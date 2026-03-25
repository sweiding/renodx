// Found in Ready or Not

#include "../lutbuilderoutput.hlsli"

Texture2D<float4> Textures_1 : register(t0);

cbuffer _RootShaderParameters : register(b0) {
  float4 LUTWeights[2] : packoffset(c005.x);
  float4 ACESMinMaxData : packoffset(c008.x);
  float4 ACESMidData : packoffset(c009.x);
  float4 ACESCoefsLow_0 : packoffset(c010.x);
  float4 ACESCoefsHigh_0 : packoffset(c011.x);
  float ACESCoefsLow_4 : packoffset(c012.x);
  float ACESCoefsHigh_4 : packoffset(c012.y);
  float ACESSceneColorMultiplier : packoffset(c012.z);
  float4 OverlayColor : packoffset(c013.x);
  float3 ColorScale : packoffset(c014.x);
  float4 ColorSaturation : packoffset(c015.x);
  float4 ColorContrast : packoffset(c016.x);
  float4 ColorGamma : packoffset(c017.x);
  float4 ColorGain : packoffset(c018.x);
  float4 ColorOffset : packoffset(c019.x);
  float4 ColorSaturationShadows : packoffset(c020.x);
  float4 ColorContrastShadows : packoffset(c021.x);
  float4 ColorGammaShadows : packoffset(c022.x);
  float4 ColorGainShadows : packoffset(c023.x);
  float4 ColorOffsetShadows : packoffset(c024.x);
  float4 ColorSaturationMidtones : packoffset(c025.x);
  float4 ColorContrastMidtones : packoffset(c026.x);
  float4 ColorGammaMidtones : packoffset(c027.x);
  float4 ColorGainMidtones : packoffset(c028.x);
  float4 ColorOffsetMidtones : packoffset(c029.x);
  float4 ColorSaturationHighlights : packoffset(c030.x);
  float4 ColorContrastHighlights : packoffset(c031.x);
  float4 ColorGammaHighlights : packoffset(c032.x);
  float4 ColorGainHighlights : packoffset(c033.x);
  float4 ColorOffsetHighlights : packoffset(c034.x);
  float LUTSize : packoffset(c035.x);
  float WhiteTemp : packoffset(c035.y);
  float WhiteTint : packoffset(c035.z);
  float ColorCorrectionShadowsMax : packoffset(c035.w);
  float ColorCorrectionHighlightsMin : packoffset(c036.x);
  float ColorCorrectionHighlightsMax : packoffset(c036.y);
  float BlueCorrection : packoffset(c036.z);
  float ExpandGamut : packoffset(c036.w);
  float ToneCurveAmount : packoffset(c037.x);
  float FilmSlope : packoffset(c037.y);
  float FilmToe : packoffset(c037.z);
  float FilmShoulder : packoffset(c037.w);
  float FilmBlackClip : packoffset(c038.x);
  float FilmWhiteClip : packoffset(c038.y);
  uint bUseMobileTonemapper : packoffset(c038.z);
  uint bIsTemperatureWhiteBalance : packoffset(c038.w);
  float3 MappingPolynomial : packoffset(c039.x);
  float3 InverseGamma : packoffset(c040.x);
  uint OutputDevice : packoffset(c040.w);
  uint OutputGamut : packoffset(c041.x);
  float OutputMaxLuminance : packoffset(c041.y);
};

cbuffer UniformBufferConstants_WorkingColorSpace : register(b1) {
  float4 WorkingColorSpace_ToXYZ[4] : packoffset(c000.x);
  float4 WorkingColorSpace_FromXYZ[4] : packoffset(c004.x);
  float4 WorkingColorSpace_ToAP1[4] : packoffset(c008.x);
  float4 WorkingColorSpace_FromAP1[4] : packoffset(c012.x);
  float4 WorkingColorSpace_ToAP0[4] : packoffset(c016.x);
  uint WorkingColorSpace_bIsSRGB : packoffset(c020.x);
};

SamplerState Samplers_1 : register(s0);

float4 main(
  noperspective float2 TEXCOORD : TEXCOORD,
  noperspective float4 SV_Position : SV_Position,
  nointerpolation uint SV_RenderTargetArrayIndex : SV_RenderTargetArrayIndex
) : SV_Target {
  float4 SV_Target;
  float _12 = 0.5f / LUTSize;
  float _17 = LUTSize + -1.0f;
  float _41;
  float _42;
  float _43;
  float _44;
  float _45;
  float _46;
  float _47;
  float _48;
  float _49;
  float _566;
  float _599;
  float _613;
  float _677;
  float _868;
  float _879;
  float _890;
  float _1047;
  float _1048;
  float _1049;
  float _1060;
  float _1071;
  float _1082;
  if (!(OutputGamut == 1)) {
    if (!(OutputGamut == 2)) {
      if (!(OutputGamut == 3)) {
        bool _30 = (OutputGamut == 4);
        _41 = select(_30, 1.0f, 1.705051064491272f);
        _42 = select(_30, 0.0f, -0.6217921376228333f);
        _43 = select(_30, 0.0f, -0.0832589864730835f);
        _44 = select(_30, 0.0f, -0.13025647401809692f);
        _45 = select(_30, 1.0f, 1.140804648399353f);
        _46 = select(_30, 0.0f, -0.010548308491706848f);
        _47 = select(_30, 0.0f, -0.024003351107239723f);
        _48 = select(_30, 0.0f, -0.1289689838886261f);
        _49 = select(_30, 1.0f, 1.1529725790023804f);
      } else {
        _41 = 0.6954522132873535f;
        _42 = 0.14067870378494263f;
        _43 = 0.16386906802654266f;
        _44 = 0.044794563204050064f;
        _45 = 0.8596711158752441f;
        _46 = 0.0955343171954155f;
        _47 = -0.005525882821530104f;
        _48 = 0.004025210160762072f;
        _49 = 1.0015007257461548f;
      }
    } else {
      _41 = 1.0258246660232544f;
      _42 = -0.020053181797266006f;
      _43 = -0.005771636962890625f;
      _44 = -0.002234415616840124f;
      _45 = 1.0045864582061768f;
      _46 = -0.002352118492126465f;
      _47 = -0.005013350863009691f;
      _48 = -0.025290070101618767f;
      _49 = 1.0303035974502563f;
    }
  } else {
    _41 = 1.3792141675949097f;
    _42 = -0.30886411666870117f;
    _43 = -0.0703500509262085f;
    _44 = -0.06933490186929703f;
    _45 = 1.08229660987854f;
    _46 = -0.012961871922016144f;
    _47 = -0.0021590073592960835f;
    _48 = -0.0454593189060688f;
    _49 = 1.0476183891296387f;
  }
  float _62 = (exp2((((LUTSize * (TEXCOORD.x - _12)) / _17) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _63 = (exp2((((LUTSize * (TEXCOORD.y - _12)) / _17) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _64 = (exp2(((float((uint)(int)(SV_RenderTargetArrayIndex)) / _17) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _79 = mad((WorkingColorSpace_ToAP1[0].z), _64, mad((WorkingColorSpace_ToAP1[0].y), _63, ((WorkingColorSpace_ToAP1[0].x) * _62)));
  float _82 = mad((WorkingColorSpace_ToAP1[1].z), _64, mad((WorkingColorSpace_ToAP1[1].y), _63, ((WorkingColorSpace_ToAP1[1].x) * _62)));
  float _85 = mad((WorkingColorSpace_ToAP1[2].z), _64, mad((WorkingColorSpace_ToAP1[2].y), _63, ((WorkingColorSpace_ToAP1[2].x) * _62)));
  float _86 = dot(float3(_79, _82, _85), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _90 = (_79 / _86) + -1.0f;
  float _91 = (_82 / _86) + -1.0f;
  float _92 = (_85 / _86) + -1.0f;
  float _104 = (1.0f - exp2(((_86 * _86) * -4.0f) * 0.f)) * (1.0f - exp2(dot(float3(_90, _91, _92), float3(_90, _91, _92)) * -4.0f));
  float _120 = ((mad(-0.06368321925401688f, _85, mad(-0.3292922377586365f, _82, (_79 * 1.3704125881195068f))) - _79) * _104) + _79;
  float _121 = ((mad(-0.010861365124583244f, _85, mad(1.0970927476882935f, _82, (_79 * -0.08343357592821121f))) - _82) * _104) + _82;
  float _122 = ((mad(1.2036951780319214f, _85, mad(-0.09862580895423889f, _82, (_79 * -0.02579331398010254f))) - _85) * _104) + _85;
  float _123 = dot(float3(_120, _121, _122), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _137 = ColorOffset.w + ColorOffsetShadows.w;
  float _151 = ColorGain.w * ColorGainShadows.w;
  float _165 = ColorGamma.w * ColorGammaShadows.w;
  float _179 = ColorContrast.w * ColorContrastShadows.w;
  float _193 = ColorSaturation.w * ColorSaturationShadows.w;
  float _197 = _120 - _123;
  float _198 = _121 - _123;
  float _199 = _122 - _123;
  float _256 = saturate(_123 / ColorCorrectionShadowsMax);
  float _260 = (_256 * _256) * (3.0f - (_256 * 2.0f));
  float _261 = 1.0f - _260;
  float _270 = ColorOffset.w + ColorOffsetHighlights.w;
  float _279 = ColorGain.w * ColorGainHighlights.w;
  float _288 = ColorGamma.w * ColorGammaHighlights.w;
  float _297 = ColorContrast.w * ColorContrastHighlights.w;
  float _306 = ColorSaturation.w * ColorSaturationHighlights.w;
  float _369 = saturate((_123 - ColorCorrectionHighlightsMin) / (ColorCorrectionHighlightsMax - ColorCorrectionHighlightsMin));
  float _373 = (_369 * _369) * (3.0f - (_369 * 2.0f));
  float _382 = ColorOffset.w + ColorOffsetMidtones.w;
  float _391 = ColorGain.w * ColorGainMidtones.w;
  float _400 = ColorGamma.w * ColorGammaMidtones.w;
  float _409 = ColorContrast.w * ColorContrastMidtones.w;
  float _418 = ColorSaturation.w * ColorSaturationMidtones.w;
  float _476 = _260 - _373;
  float _487 = ((_373 * (((ColorOffset.x + ColorOffsetHighlights.x) + _270) + (((ColorGain.x * ColorGainHighlights.x) * _279) * exp2(log2(exp2(((ColorContrast.x * ColorContrastHighlights.x) * _297) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationHighlights.x) * _306) * _197) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaHighlights.x) * _288)))))) + (_261 * (((ColorOffset.x + ColorOffsetShadows.x) + _137) + (((ColorGain.x * ColorGainShadows.x) * _151) * exp2(log2(exp2(((ColorContrast.x * ColorContrastShadows.x) * _179) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationShadows.x) * _193) * _197) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaShadows.x) * _165))))))) + ((((ColorOffset.x + ColorOffsetMidtones.x) + _382) + (((ColorGain.x * ColorGainMidtones.x) * _391) * exp2(log2(exp2(((ColorContrast.x * ColorContrastMidtones.x) * _409) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationMidtones.x) * _418) * _197) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaMidtones.x) * _400))))) * _476);
  float _489 = ((_373 * (((ColorOffset.y + ColorOffsetHighlights.y) + _270) + (((ColorGain.y * ColorGainHighlights.y) * _279) * exp2(log2(exp2(((ColorContrast.y * ColorContrastHighlights.y) * _297) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationHighlights.y) * _306) * _198) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaHighlights.y) * _288)))))) + (_261 * (((ColorOffset.y + ColorOffsetShadows.y) + _137) + (((ColorGain.y * ColorGainShadows.y) * _151) * exp2(log2(exp2(((ColorContrast.y * ColorContrastShadows.y) * _179) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationShadows.y) * _193) * _198) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaShadows.y) * _165))))))) + ((((ColorOffset.y + ColorOffsetMidtones.y) + _382) + (((ColorGain.y * ColorGainMidtones.y) * _391) * exp2(log2(exp2(((ColorContrast.y * ColorContrastMidtones.y) * _409) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationMidtones.y) * _418) * _198) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaMidtones.y) * _400))))) * _476);
  float _491 = ((_373 * (((ColorOffset.z + ColorOffsetHighlights.z) + _270) + (((ColorGain.z * ColorGainHighlights.z) * _279) * exp2(log2(exp2(((ColorContrast.z * ColorContrastHighlights.z) * _297) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationHighlights.z) * _306) * _199) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaHighlights.z) * _288)))))) + (_261 * (((ColorOffset.z + ColorOffsetShadows.z) + _137) + (((ColorGain.z * ColorGainShadows.z) * _151) * exp2(log2(exp2(((ColorContrast.z * ColorContrastShadows.z) * _179) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationShadows.z) * _193) * _199) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaShadows.z) * _165))))))) + ((((ColorOffset.z + ColorOffsetMidtones.z) + _382) + (((ColorGain.z * ColorGainMidtones.z) * _391) * exp2(log2(exp2(((ColorContrast.z * ColorContrastMidtones.z) * _409) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationMidtones.z) * _418) * _199) + _123)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaMidtones.z) * _400))))) * _476);
  UECbufferConfig cb_config = CreateCbufferConfig();
  cb_config.ue_filmblackclip = FilmBlackClip;
  cb_config.ue_filmtoe = FilmToe;
  cb_config.ue_filmshoulder = FilmShoulder;
  cb_config.ue_filmslope = FilmSlope;
  cb_config.ue_filmwhiteclip = FilmWhiteClip;
  cb_config.ue_tonecurveammount = ToneCurveAmount;
  cb_config.ue_mappingpolynomial = MappingPolynomial;
  cb_config.ue_overlaycolor = OverlayColor;
  cb_config.ue_bluecorrection = BlueCorrection;
  cb_config.ue_colorscale = ColorScale;

  SV_Target = ProcessLutbuilder(float3(_487, _489, _491), Samplers_1, Textures_1, cb_config, SV_Target, OutputDevice);
  return SV_Target;
}
