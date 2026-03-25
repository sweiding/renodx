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
  float _112;
  float _819;
  float _852;
  float _866;
  float _930;
  float _1121;
  float _1132;
  float _1143;
  float _1300;
  float _1301;
  float _1302;
  float _1313;
  float _1324;
  float _1335;
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
  bool _91 = (bIsTemperatureWhiteBalance != 0);
  float _95 = 0.9994439482688904f / WhiteTemp;
  if (!(!((WhiteTemp * 1.0005563497543335f) <= 7000.0f))) {
    _112 = (((((2967800.0f - (_95 * 4607000064.0f)) * _95) + 99.11000061035156f) * _95) + 0.24406300485134125f);
  } else {
    _112 = (((((1901800.0f - (_95 * 2006400000.0f)) * _95) + 247.47999572753906f) * _95) + 0.23703999817371368f);
  }
  float _126 = ((((WhiteTemp * 1.2864121856637212e-07f) + 0.00015411825734190643f) * WhiteTemp) + 0.8601177334785461f) / ((((WhiteTemp * 7.081451371959702e-07f) + 0.0008424202096648514f) * WhiteTemp) + 1.0f);
  float _133 = WhiteTemp * WhiteTemp;
  float _136 = ((((WhiteTemp * 4.204816761443908e-08f) + 4.228062607580796e-05f) * WhiteTemp) + 0.31739872694015503f) / ((1.0f - (WhiteTemp * 2.8974181986995973e-05f)) + (_133 * 1.6145605741257896e-07f));
  float _141 = ((_126 * 2.0f) + 4.0f) - (_136 * 8.0f);
  float _142 = (_126 * 3.0f) / _141;
  float _144 = (_136 * 2.0f) / _141;
  bool _145 = (WhiteTemp < 4000.0f);
  float _154 = ((WhiteTemp + 1189.6199951171875f) * WhiteTemp) + 1412139.875f;
  float _156 = ((-1137581184.0f - (WhiteTemp * 1916156.25f)) - (_133 * 1.5317699909210205f)) / (_154 * _154);
  float _163 = (6193636.0f - (WhiteTemp * 179.45599365234375f)) + _133;
  float _165 = ((1974715392.0f - (WhiteTemp * 705674.0f)) - (_133 * 308.60699462890625f)) / (_163 * _163);
  float _167 = rsqrt(dot(float2(_156, _165), float2(_156, _165)));
  float _168 = WhiteTint * 0.05000000074505806f;
  float _171 = ((_168 * _165) * _167) + _126;
  float _174 = _136 - ((_168 * _156) * _167);
  float _179 = (4.0f - (_174 * 8.0f)) + (_171 * 2.0f);
  float _185 = (((_171 * 3.0f) / _179) - _142) + select(_145, _142, _112);
  float _186 = (((_174 * 2.0f) / _179) - _144) + select(_145, _144, (((_112 * 2.869999885559082f) + -0.2750000059604645f) - ((_112 * _112) * 3.0f)));
  float _187 = select(_91, _185, 0.3127000033855438f);
  float _188 = select(_91, _186, 0.32899999618530273f);
  float _189 = select(_91, 0.3127000033855438f, _185);
  float _190 = select(_91, 0.32899999618530273f, _186);
  float _191 = max(_188, 1.000000013351432e-10f);
  float _192 = _187 / _191;
  float _195 = ((1.0f - _187) - _188) / _191;
  float _196 = max(_190, 1.000000013351432e-10f);
  float _197 = _189 / _196;
  float _200 = ((1.0f - _189) - _190) / _196;
  float _219 = mad(-0.16140000522136688f, _200, ((_197 * 0.8950999975204468f) + 0.266400009393692f)) / mad(-0.16140000522136688f, _195, ((_192 * 0.8950999975204468f) + 0.266400009393692f));
  float _220 = mad(0.03669999912381172f, _200, (1.7135000228881836f - (_197 * 0.7501999735832214f))) / mad(0.03669999912381172f, _195, (1.7135000228881836f - (_192 * 0.7501999735832214f)));
  float _221 = mad(1.0296000242233276f, _200, ((_197 * 0.03889999911189079f) + -0.06849999725818634f)) / mad(1.0296000242233276f, _195, ((_192 * 0.03889999911189079f) + -0.06849999725818634f));
  float _222 = mad(_220, -0.7501999735832214f, 0.0f);
  float _223 = mad(_220, 1.7135000228881836f, 0.0f);
  float _224 = mad(_220, 0.03669999912381172f, -0.0f);
  float _225 = mad(_221, 0.03889999911189079f, 0.0f);
  float _226 = mad(_221, -0.06849999725818634f, 0.0f);
  float _227 = mad(_221, 1.0296000242233276f, 0.0f);
  float _230 = mad(0.1599626988172531f, _225, mad(-0.1470542997121811f, _222, (_219 * 0.883457362651825f)));
  float _233 = mad(0.1599626988172531f, _226, mad(-0.1470542997121811f, _223, (_219 * 0.26293492317199707f)));
  float _236 = mad(0.1599626988172531f, _227, mad(-0.1470542997121811f, _224, (_219 * -0.15930065512657166f)));
  float _239 = mad(0.04929120093584061f, _225, mad(0.5183603167533875f, _222, (_219 * 0.38695648312568665f)));
  float _242 = mad(0.04929120093584061f, _226, mad(0.5183603167533875f, _223, (_219 * 0.11516613513231277f)));
  float _245 = mad(0.04929120093584061f, _227, mad(0.5183603167533875f, _224, (_219 * -0.0697740763425827f)));
  float _248 = mad(0.9684867262840271f, _225, mad(0.04004279896616936f, _222, (_219 * -0.007634039502590895f)));
  float _251 = mad(0.9684867262840271f, _226, mad(0.04004279896616936f, _223, (_219 * -0.0022720457054674625f)));
  float _254 = mad(0.9684867262840271f, _227, mad(0.04004279896616936f, _224, (_219 * 0.0013765322510153055f)));
  float _257 = mad(_236, (WorkingColorSpace_ToXYZ[2].x), mad(_233, (WorkingColorSpace_ToXYZ[1].x), (_230 * (WorkingColorSpace_ToXYZ[0].x))));
  float _260 = mad(_236, (WorkingColorSpace_ToXYZ[2].y), mad(_233, (WorkingColorSpace_ToXYZ[1].y), (_230 * (WorkingColorSpace_ToXYZ[0].y))));
  float _263 = mad(_236, (WorkingColorSpace_ToXYZ[2].z), mad(_233, (WorkingColorSpace_ToXYZ[1].z), (_230 * (WorkingColorSpace_ToXYZ[0].z))));
  float _266 = mad(_245, (WorkingColorSpace_ToXYZ[2].x), mad(_242, (WorkingColorSpace_ToXYZ[1].x), (_239 * (WorkingColorSpace_ToXYZ[0].x))));
  float _269 = mad(_245, (WorkingColorSpace_ToXYZ[2].y), mad(_242, (WorkingColorSpace_ToXYZ[1].y), (_239 * (WorkingColorSpace_ToXYZ[0].y))));
  float _272 = mad(_245, (WorkingColorSpace_ToXYZ[2].z), mad(_242, (WorkingColorSpace_ToXYZ[1].z), (_239 * (WorkingColorSpace_ToXYZ[0].z))));
  float _275 = mad(_254, (WorkingColorSpace_ToXYZ[2].x), mad(_251, (WorkingColorSpace_ToXYZ[1].x), (_248 * (WorkingColorSpace_ToXYZ[0].x))));
  float _278 = mad(_254, (WorkingColorSpace_ToXYZ[2].y), mad(_251, (WorkingColorSpace_ToXYZ[1].y), (_248 * (WorkingColorSpace_ToXYZ[0].y))));
  float _281 = mad(_254, (WorkingColorSpace_ToXYZ[2].z), mad(_251, (WorkingColorSpace_ToXYZ[1].z), (_248 * (WorkingColorSpace_ToXYZ[0].z))));
  float _311 = mad(mad((WorkingColorSpace_FromXYZ[0].z), _281, mad((WorkingColorSpace_FromXYZ[0].y), _272, (_263 * (WorkingColorSpace_FromXYZ[0].x)))), _64, mad(mad((WorkingColorSpace_FromXYZ[0].z), _278, mad((WorkingColorSpace_FromXYZ[0].y), _269, (_260 * (WorkingColorSpace_FromXYZ[0].x)))), _63, (mad((WorkingColorSpace_FromXYZ[0].z), _275, mad((WorkingColorSpace_FromXYZ[0].y), _266, (_257 * (WorkingColorSpace_FromXYZ[0].x)))) * _62)));
  float _314 = mad(mad((WorkingColorSpace_FromXYZ[1].z), _281, mad((WorkingColorSpace_FromXYZ[1].y), _272, (_263 * (WorkingColorSpace_FromXYZ[1].x)))), _64, mad(mad((WorkingColorSpace_FromXYZ[1].z), _278, mad((WorkingColorSpace_FromXYZ[1].y), _269, (_260 * (WorkingColorSpace_FromXYZ[1].x)))), _63, (mad((WorkingColorSpace_FromXYZ[1].z), _275, mad((WorkingColorSpace_FromXYZ[1].y), _266, (_257 * (WorkingColorSpace_FromXYZ[1].x)))) * _62)));
  float _317 = mad(mad((WorkingColorSpace_FromXYZ[2].z), _281, mad((WorkingColorSpace_FromXYZ[2].y), _272, (_263 * (WorkingColorSpace_FromXYZ[2].x)))), _64, mad(mad((WorkingColorSpace_FromXYZ[2].z), _278, mad((WorkingColorSpace_FromXYZ[2].y), _269, (_260 * (WorkingColorSpace_FromXYZ[2].x)))), _63, (mad((WorkingColorSpace_FromXYZ[2].z), _275, mad((WorkingColorSpace_FromXYZ[2].y), _266, (_257 * (WorkingColorSpace_FromXYZ[2].x)))) * _62)));
  float _332 = mad((WorkingColorSpace_ToAP1[0].z), _317, mad((WorkingColorSpace_ToAP1[0].y), _314, ((WorkingColorSpace_ToAP1[0].x) * _311)));
  float _335 = mad((WorkingColorSpace_ToAP1[1].z), _317, mad((WorkingColorSpace_ToAP1[1].y), _314, ((WorkingColorSpace_ToAP1[1].x) * _311)));
  float _338 = mad((WorkingColorSpace_ToAP1[2].z), _317, mad((WorkingColorSpace_ToAP1[2].y), _314, ((WorkingColorSpace_ToAP1[2].x) * _311)));
  float _339 = dot(float3(_332, _335, _338), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _343 = (_332 / _339) + -1.0f;
  float _344 = (_335 / _339) + -1.0f;
  float _345 = (_338 / _339) + -1.0f;
  float _357 = (1.0f - exp2(((_339 * _339) * -4.0f) * 0.f)) * (1.0f - exp2(dot(float3(_343, _344, _345), float3(_343, _344, _345)) * -4.0f));
  float _373 = ((mad(-0.06368321925401688f, _338, mad(-0.3292922377586365f, _335, (_332 * 1.3704125881195068f))) - _332) * _357) + _332;
  float _374 = ((mad(-0.010861365124583244f, _338, mad(1.0970927476882935f, _335, (_332 * -0.08343357592821121f))) - _335) * _357) + _335;
  float _375 = ((mad(1.2036951780319214f, _338, mad(-0.09862580895423889f, _335, (_332 * -0.02579331398010254f))) - _338) * _357) + _338;
  float _376 = dot(float3(_373, _374, _375), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _390 = ColorOffset.w + ColorOffsetShadows.w;
  float _404 = ColorGain.w * ColorGainShadows.w;
  float _418 = ColorGamma.w * ColorGammaShadows.w;
  float _432 = ColorContrast.w * ColorContrastShadows.w;
  float _446 = ColorSaturation.w * ColorSaturationShadows.w;
  float _450 = _373 - _376;
  float _451 = _374 - _376;
  float _452 = _375 - _376;
  float _509 = saturate(_376 / ColorCorrectionShadowsMax);
  float _513 = (_509 * _509) * (3.0f - (_509 * 2.0f));
  float _514 = 1.0f - _513;
  float _523 = ColorOffset.w + ColorOffsetHighlights.w;
  float _532 = ColorGain.w * ColorGainHighlights.w;
  float _541 = ColorGamma.w * ColorGammaHighlights.w;
  float _550 = ColorContrast.w * ColorContrastHighlights.w;
  float _559 = ColorSaturation.w * ColorSaturationHighlights.w;
  float _622 = saturate((_376 - ColorCorrectionHighlightsMin) / (ColorCorrectionHighlightsMax - ColorCorrectionHighlightsMin));
  float _626 = (_622 * _622) * (3.0f - (_622 * 2.0f));
  float _635 = ColorOffset.w + ColorOffsetMidtones.w;
  float _644 = ColorGain.w * ColorGainMidtones.w;
  float _653 = ColorGamma.w * ColorGammaMidtones.w;
  float _662 = ColorContrast.w * ColorContrastMidtones.w;
  float _671 = ColorSaturation.w * ColorSaturationMidtones.w;
  float _729 = _513 - _626;
  float _740 = ((_626 * (((ColorOffset.x + ColorOffsetHighlights.x) + _523) + (((ColorGain.x * ColorGainHighlights.x) * _532) * exp2(log2(exp2(((ColorContrast.x * ColorContrastHighlights.x) * _550) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationHighlights.x) * _559) * _450) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaHighlights.x) * _541)))))) + (_514 * (((ColorOffset.x + ColorOffsetShadows.x) + _390) + (((ColorGain.x * ColorGainShadows.x) * _404) * exp2(log2(exp2(((ColorContrast.x * ColorContrastShadows.x) * _432) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationShadows.x) * _446) * _450) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaShadows.x) * _418))))))) + ((((ColorOffset.x + ColorOffsetMidtones.x) + _635) + (((ColorGain.x * ColorGainMidtones.x) * _644) * exp2(log2(exp2(((ColorContrast.x * ColorContrastMidtones.x) * _662) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationMidtones.x) * _671) * _450) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaMidtones.x) * _653))))) * _729);
  float _742 = ((_626 * (((ColorOffset.y + ColorOffsetHighlights.y) + _523) + (((ColorGain.y * ColorGainHighlights.y) * _532) * exp2(log2(exp2(((ColorContrast.y * ColorContrastHighlights.y) * _550) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationHighlights.y) * _559) * _451) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaHighlights.y) * _541)))))) + (_514 * (((ColorOffset.y + ColorOffsetShadows.y) + _390) + (((ColorGain.y * ColorGainShadows.y) * _404) * exp2(log2(exp2(((ColorContrast.y * ColorContrastShadows.y) * _432) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationShadows.y) * _446) * _451) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaShadows.y) * _418))))))) + ((((ColorOffset.y + ColorOffsetMidtones.y) + _635) + (((ColorGain.y * ColorGainMidtones.y) * _644) * exp2(log2(exp2(((ColorContrast.y * ColorContrastMidtones.y) * _662) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationMidtones.y) * _671) * _451) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaMidtones.y) * _653))))) * _729);
  float _744 = ((_626 * (((ColorOffset.z + ColorOffsetHighlights.z) + _523) + (((ColorGain.z * ColorGainHighlights.z) * _532) * exp2(log2(exp2(((ColorContrast.z * ColorContrastHighlights.z) * _550) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationHighlights.z) * _559) * _452) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaHighlights.z) * _541)))))) + (_514 * (((ColorOffset.z + ColorOffsetShadows.z) + _390) + (((ColorGain.z * ColorGainShadows.z) * _404) * exp2(log2(exp2(((ColorContrast.z * ColorContrastShadows.z) * _432) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationShadows.z) * _446) * _452) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaShadows.z) * _418))))))) + ((((ColorOffset.z + ColorOffsetMidtones.z) + _635) + (((ColorGain.z * ColorGainMidtones.z) * _644) * exp2(log2(exp2(((ColorContrast.z * ColorContrastMidtones.z) * _662) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationMidtones.z) * _671) * _452) + _376)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaMidtones.z) * _653))))) * _729);
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

  SV_Target = ProcessLutbuilder(float3(_740, _742, _744), Samplers_1, Textures_1, cb_config, SV_Target, OutputDevice);
  return SV_Target;
}
