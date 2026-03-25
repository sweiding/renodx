// Found in Ready or Not

#include "../lutbuilderoutput.hlsli"

Texture2D<float4> Textures_1 : register(t0);

Texture2D<float4> Textures_2 : register(t1);

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

SamplerState Samplers_2 : register(s1);

float4 main(
  noperspective float2 TEXCOORD : TEXCOORD,
  noperspective float4 SV_Position : SV_Position,
  nointerpolation uint SV_RenderTargetArrayIndex : SV_RenderTargetArrayIndex
) : SV_Target {
  float4 SV_Target;
  float _14 = 0.5f / LUTSize;
  float _19 = LUTSize + -1.0f;
  float _43;
  float _44;
  float _45;
  float _46;
  float _47;
  float _48;
  float _49;
  float _50;
  float _51;
  float _114;
  float _821;
  float _854;
  float _868;
  float _932;
  float _1123;
  float _1134;
  float _1145;
  float _1331;
  float _1332;
  float _1333;
  float _1344;
  float _1355;
  float _1366;
  if (!(OutputGamut == 1)) {
    if (!(OutputGamut == 2)) {
      if (!(OutputGamut == 3)) {
        bool _32 = (OutputGamut == 4);
        _43 = select(_32, 1.0f, 1.705051064491272f);
        _44 = select(_32, 0.0f, -0.6217921376228333f);
        _45 = select(_32, 0.0f, -0.0832589864730835f);
        _46 = select(_32, 0.0f, -0.13025647401809692f);
        _47 = select(_32, 1.0f, 1.140804648399353f);
        _48 = select(_32, 0.0f, -0.010548308491706848f);
        _49 = select(_32, 0.0f, -0.024003351107239723f);
        _50 = select(_32, 0.0f, -0.1289689838886261f);
        _51 = select(_32, 1.0f, 1.1529725790023804f);
      } else {
        _43 = 0.6954522132873535f;
        _44 = 0.14067870378494263f;
        _45 = 0.16386906802654266f;
        _46 = 0.044794563204050064f;
        _47 = 0.8596711158752441f;
        _48 = 0.0955343171954155f;
        _49 = -0.005525882821530104f;
        _50 = 0.004025210160762072f;
        _51 = 1.0015007257461548f;
      }
    } else {
      _43 = 1.0258246660232544f;
      _44 = -0.020053181797266006f;
      _45 = -0.005771636962890625f;
      _46 = -0.002234415616840124f;
      _47 = 1.0045864582061768f;
      _48 = -0.002352118492126465f;
      _49 = -0.005013350863009691f;
      _50 = -0.025290070101618767f;
      _51 = 1.0303035974502563f;
    }
  } else {
    _43 = 1.3792141675949097f;
    _44 = -0.30886411666870117f;
    _45 = -0.0703500509262085f;
    _46 = -0.06933490186929703f;
    _47 = 1.08229660987854f;
    _48 = -0.012961871922016144f;
    _49 = -0.0021590073592960835f;
    _50 = -0.0454593189060688f;
    _51 = 1.0476183891296387f;
  }
  float _64 = (exp2((((LUTSize * (TEXCOORD.x - _14)) / _19) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _65 = (exp2((((LUTSize * (TEXCOORD.y - _14)) / _19) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _66 = (exp2(((float((uint)(int)(SV_RenderTargetArrayIndex)) / _19) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  bool _93 = (bIsTemperatureWhiteBalance != 0);
  float _97 = 0.9994439482688904f / WhiteTemp;
  if (!(!((WhiteTemp * 1.0005563497543335f) <= 7000.0f))) {
    _114 = (((((2967800.0f - (_97 * 4607000064.0f)) * _97) + 99.11000061035156f) * _97) + 0.24406300485134125f);
  } else {
    _114 = (((((1901800.0f - (_97 * 2006400000.0f)) * _97) + 247.47999572753906f) * _97) + 0.23703999817371368f);
  }
  float _128 = ((((WhiteTemp * 1.2864121856637212e-07f) + 0.00015411825734190643f) * WhiteTemp) + 0.8601177334785461f) / ((((WhiteTemp * 7.081451371959702e-07f) + 0.0008424202096648514f) * WhiteTemp) + 1.0f);
  float _135 = WhiteTemp * WhiteTemp;
  float _138 = ((((WhiteTemp * 4.204816761443908e-08f) + 4.228062607580796e-05f) * WhiteTemp) + 0.31739872694015503f) / ((1.0f - (WhiteTemp * 2.8974181986995973e-05f)) + (_135 * 1.6145605741257896e-07f));
  float _143 = ((_128 * 2.0f) + 4.0f) - (_138 * 8.0f);
  float _144 = (_128 * 3.0f) / _143;
  float _146 = (_138 * 2.0f) / _143;
  bool _147 = (WhiteTemp < 4000.0f);
  float _156 = ((WhiteTemp + 1189.6199951171875f) * WhiteTemp) + 1412139.875f;
  float _158 = ((-1137581184.0f - (WhiteTemp * 1916156.25f)) - (_135 * 1.5317699909210205f)) / (_156 * _156);
  float _165 = (6193636.0f - (WhiteTemp * 179.45599365234375f)) + _135;
  float _167 = ((1974715392.0f - (WhiteTemp * 705674.0f)) - (_135 * 308.60699462890625f)) / (_165 * _165);
  float _169 = rsqrt(dot(float2(_158, _167), float2(_158, _167)));
  float _170 = WhiteTint * 0.05000000074505806f;
  float _173 = ((_170 * _167) * _169) + _128;
  float _176 = _138 - ((_170 * _158) * _169);
  float _181 = (4.0f - (_176 * 8.0f)) + (_173 * 2.0f);
  float _187 = (((_173 * 3.0f) / _181) - _144) + select(_147, _144, _114);
  float _188 = (((_176 * 2.0f) / _181) - _146) + select(_147, _146, (((_114 * 2.869999885559082f) + -0.2750000059604645f) - ((_114 * _114) * 3.0f)));
  float _189 = select(_93, _187, 0.3127000033855438f);
  float _190 = select(_93, _188, 0.32899999618530273f);
  float _191 = select(_93, 0.3127000033855438f, _187);
  float _192 = select(_93, 0.32899999618530273f, _188);
  float _193 = max(_190, 1.000000013351432e-10f);
  float _194 = _189 / _193;
  float _197 = ((1.0f - _189) - _190) / _193;
  float _198 = max(_192, 1.000000013351432e-10f);
  float _199 = _191 / _198;
  float _202 = ((1.0f - _191) - _192) / _198;
  float _221 = mad(-0.16140000522136688f, _202, ((_199 * 0.8950999975204468f) + 0.266400009393692f)) / mad(-0.16140000522136688f, _197, ((_194 * 0.8950999975204468f) + 0.266400009393692f));
  float _222 = mad(0.03669999912381172f, _202, (1.7135000228881836f - (_199 * 0.7501999735832214f))) / mad(0.03669999912381172f, _197, (1.7135000228881836f - (_194 * 0.7501999735832214f)));
  float _223 = mad(1.0296000242233276f, _202, ((_199 * 0.03889999911189079f) + -0.06849999725818634f)) / mad(1.0296000242233276f, _197, ((_194 * 0.03889999911189079f) + -0.06849999725818634f));
  float _224 = mad(_222, -0.7501999735832214f, 0.0f);
  float _225 = mad(_222, 1.7135000228881836f, 0.0f);
  float _226 = mad(_222, 0.03669999912381172f, -0.0f);
  float _227 = mad(_223, 0.03889999911189079f, 0.0f);
  float _228 = mad(_223, -0.06849999725818634f, 0.0f);
  float _229 = mad(_223, 1.0296000242233276f, 0.0f);
  float _232 = mad(0.1599626988172531f, _227, mad(-0.1470542997121811f, _224, (_221 * 0.883457362651825f)));
  float _235 = mad(0.1599626988172531f, _228, mad(-0.1470542997121811f, _225, (_221 * 0.26293492317199707f)));
  float _238 = mad(0.1599626988172531f, _229, mad(-0.1470542997121811f, _226, (_221 * -0.15930065512657166f)));
  float _241 = mad(0.04929120093584061f, _227, mad(0.5183603167533875f, _224, (_221 * 0.38695648312568665f)));
  float _244 = mad(0.04929120093584061f, _228, mad(0.5183603167533875f, _225, (_221 * 0.11516613513231277f)));
  float _247 = mad(0.04929120093584061f, _229, mad(0.5183603167533875f, _226, (_221 * -0.0697740763425827f)));
  float _250 = mad(0.9684867262840271f, _227, mad(0.04004279896616936f, _224, (_221 * -0.007634039502590895f)));
  float _253 = mad(0.9684867262840271f, _228, mad(0.04004279896616936f, _225, (_221 * -0.0022720457054674625f)));
  float _256 = mad(0.9684867262840271f, _229, mad(0.04004279896616936f, _226, (_221 * 0.0013765322510153055f)));
  float _259 = mad(_238, (WorkingColorSpace_ToXYZ[2].x), mad(_235, (WorkingColorSpace_ToXYZ[1].x), (_232 * (WorkingColorSpace_ToXYZ[0].x))));
  float _262 = mad(_238, (WorkingColorSpace_ToXYZ[2].y), mad(_235, (WorkingColorSpace_ToXYZ[1].y), (_232 * (WorkingColorSpace_ToXYZ[0].y))));
  float _265 = mad(_238, (WorkingColorSpace_ToXYZ[2].z), mad(_235, (WorkingColorSpace_ToXYZ[1].z), (_232 * (WorkingColorSpace_ToXYZ[0].z))));
  float _268 = mad(_247, (WorkingColorSpace_ToXYZ[2].x), mad(_244, (WorkingColorSpace_ToXYZ[1].x), (_241 * (WorkingColorSpace_ToXYZ[0].x))));
  float _271 = mad(_247, (WorkingColorSpace_ToXYZ[2].y), mad(_244, (WorkingColorSpace_ToXYZ[1].y), (_241 * (WorkingColorSpace_ToXYZ[0].y))));
  float _274 = mad(_247, (WorkingColorSpace_ToXYZ[2].z), mad(_244, (WorkingColorSpace_ToXYZ[1].z), (_241 * (WorkingColorSpace_ToXYZ[0].z))));
  float _277 = mad(_256, (WorkingColorSpace_ToXYZ[2].x), mad(_253, (WorkingColorSpace_ToXYZ[1].x), (_250 * (WorkingColorSpace_ToXYZ[0].x))));
  float _280 = mad(_256, (WorkingColorSpace_ToXYZ[2].y), mad(_253, (WorkingColorSpace_ToXYZ[1].y), (_250 * (WorkingColorSpace_ToXYZ[0].y))));
  float _283 = mad(_256, (WorkingColorSpace_ToXYZ[2].z), mad(_253, (WorkingColorSpace_ToXYZ[1].z), (_250 * (WorkingColorSpace_ToXYZ[0].z))));
  float _313 = mad(mad((WorkingColorSpace_FromXYZ[0].z), _283, mad((WorkingColorSpace_FromXYZ[0].y), _274, (_265 * (WorkingColorSpace_FromXYZ[0].x)))), _66, mad(mad((WorkingColorSpace_FromXYZ[0].z), _280, mad((WorkingColorSpace_FromXYZ[0].y), _271, (_262 * (WorkingColorSpace_FromXYZ[0].x)))), _65, (mad((WorkingColorSpace_FromXYZ[0].z), _277, mad((WorkingColorSpace_FromXYZ[0].y), _268, (_259 * (WorkingColorSpace_FromXYZ[0].x)))) * _64)));
  float _316 = mad(mad((WorkingColorSpace_FromXYZ[1].z), _283, mad((WorkingColorSpace_FromXYZ[1].y), _274, (_265 * (WorkingColorSpace_FromXYZ[1].x)))), _66, mad(mad((WorkingColorSpace_FromXYZ[1].z), _280, mad((WorkingColorSpace_FromXYZ[1].y), _271, (_262 * (WorkingColorSpace_FromXYZ[1].x)))), _65, (mad((WorkingColorSpace_FromXYZ[1].z), _277, mad((WorkingColorSpace_FromXYZ[1].y), _268, (_259 * (WorkingColorSpace_FromXYZ[1].x)))) * _64)));
  float _319 = mad(mad((WorkingColorSpace_FromXYZ[2].z), _283, mad((WorkingColorSpace_FromXYZ[2].y), _274, (_265 * (WorkingColorSpace_FromXYZ[2].x)))), _66, mad(mad((WorkingColorSpace_FromXYZ[2].z), _280, mad((WorkingColorSpace_FromXYZ[2].y), _271, (_262 * (WorkingColorSpace_FromXYZ[2].x)))), _65, (mad((WorkingColorSpace_FromXYZ[2].z), _277, mad((WorkingColorSpace_FromXYZ[2].y), _268, (_259 * (WorkingColorSpace_FromXYZ[2].x)))) * _64)));
  float _334 = mad((WorkingColorSpace_ToAP1[0].z), _319, mad((WorkingColorSpace_ToAP1[0].y), _316, ((WorkingColorSpace_ToAP1[0].x) * _313)));
  float _337 = mad((WorkingColorSpace_ToAP1[1].z), _319, mad((WorkingColorSpace_ToAP1[1].y), _316, ((WorkingColorSpace_ToAP1[1].x) * _313)));
  float _340 = mad((WorkingColorSpace_ToAP1[2].z), _319, mad((WorkingColorSpace_ToAP1[2].y), _316, ((WorkingColorSpace_ToAP1[2].x) * _313)));
  float _341 = dot(float3(_334, _337, _340), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _345 = (_334 / _341) + -1.0f;
  float _346 = (_337 / _341) + -1.0f;
  float _347 = (_340 / _341) + -1.0f;
  float _359 = (1.0f - exp2(((_341 * _341) * -4.0f) * 0.f)) * (1.0f - exp2(dot(float3(_345, _346, _347), float3(_345, _346, _347)) * -4.0f));
  float _375 = ((mad(-0.06368321925401688f, _340, mad(-0.3292922377586365f, _337, (_334 * 1.3704125881195068f))) - _334) * _359) + _334;
  float _376 = ((mad(-0.010861365124583244f, _340, mad(1.0970927476882935f, _337, (_334 * -0.08343357592821121f))) - _337) * _359) + _337;
  float _377 = ((mad(1.2036951780319214f, _340, mad(-0.09862580895423889f, _337, (_334 * -0.02579331398010254f))) - _340) * _359) + _340;
  float _378 = dot(float3(_375, _376, _377), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _392 = ColorOffset.w + ColorOffsetShadows.w;
  float _406 = ColorGain.w * ColorGainShadows.w;
  float _420 = ColorGamma.w * ColorGammaShadows.w;
  float _434 = ColorContrast.w * ColorContrastShadows.w;
  float _448 = ColorSaturation.w * ColorSaturationShadows.w;
  float _452 = _375 - _378;
  float _453 = _376 - _378;
  float _454 = _377 - _378;
  float _511 = saturate(_378 / ColorCorrectionShadowsMax);
  float _515 = (_511 * _511) * (3.0f - (_511 * 2.0f));
  float _516 = 1.0f - _515;
  float _525 = ColorOffset.w + ColorOffsetHighlights.w;
  float _534 = ColorGain.w * ColorGainHighlights.w;
  float _543 = ColorGamma.w * ColorGammaHighlights.w;
  float _552 = ColorContrast.w * ColorContrastHighlights.w;
  float _561 = ColorSaturation.w * ColorSaturationHighlights.w;
  float _624 = saturate((_378 - ColorCorrectionHighlightsMin) / (ColorCorrectionHighlightsMax - ColorCorrectionHighlightsMin));
  float _628 = (_624 * _624) * (3.0f - (_624 * 2.0f));
  float _637 = ColorOffset.w + ColorOffsetMidtones.w;
  float _646 = ColorGain.w * ColorGainMidtones.w;
  float _655 = ColorGamma.w * ColorGammaMidtones.w;
  float _664 = ColorContrast.w * ColorContrastMidtones.w;
  float _673 = ColorSaturation.w * ColorSaturationMidtones.w;
  float _731 = _515 - _628;
  float _742 = ((_628 * (((ColorOffset.x + ColorOffsetHighlights.x) + _525) + (((ColorGain.x * ColorGainHighlights.x) * _534) * exp2(log2(exp2(((ColorContrast.x * ColorContrastHighlights.x) * _552) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationHighlights.x) * _561) * _452) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaHighlights.x) * _543)))))) + (_516 * (((ColorOffset.x + ColorOffsetShadows.x) + _392) + (((ColorGain.x * ColorGainShadows.x) * _406) * exp2(log2(exp2(((ColorContrast.x * ColorContrastShadows.x) * _434) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationShadows.x) * _448) * _452) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaShadows.x) * _420))))))) + ((((ColorOffset.x + ColorOffsetMidtones.x) + _637) + (((ColorGain.x * ColorGainMidtones.x) * _646) * exp2(log2(exp2(((ColorContrast.x * ColorContrastMidtones.x) * _664) * log2(max(0.0f, ((((ColorSaturation.x * ColorSaturationMidtones.x) * _673) * _452) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.x * ColorGammaMidtones.x) * _655))))) * _731);
  float _744 = ((_628 * (((ColorOffset.y + ColorOffsetHighlights.y) + _525) + (((ColorGain.y * ColorGainHighlights.y) * _534) * exp2(log2(exp2(((ColorContrast.y * ColorContrastHighlights.y) * _552) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationHighlights.y) * _561) * _453) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaHighlights.y) * _543)))))) + (_516 * (((ColorOffset.y + ColorOffsetShadows.y) + _392) + (((ColorGain.y * ColorGainShadows.y) * _406) * exp2(log2(exp2(((ColorContrast.y * ColorContrastShadows.y) * _434) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationShadows.y) * _448) * _453) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaShadows.y) * _420))))))) + ((((ColorOffset.y + ColorOffsetMidtones.y) + _637) + (((ColorGain.y * ColorGainMidtones.y) * _646) * exp2(log2(exp2(((ColorContrast.y * ColorContrastMidtones.y) * _664) * log2(max(0.0f, ((((ColorSaturation.y * ColorSaturationMidtones.y) * _673) * _453) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.y * ColorGammaMidtones.y) * _655))))) * _731);
  float _746 = ((_628 * (((ColorOffset.z + ColorOffsetHighlights.z) + _525) + (((ColorGain.z * ColorGainHighlights.z) * _534) * exp2(log2(exp2(((ColorContrast.z * ColorContrastHighlights.z) * _552) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationHighlights.z) * _561) * _454) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaHighlights.z) * _543)))))) + (_516 * (((ColorOffset.z + ColorOffsetShadows.z) + _392) + (((ColorGain.z * ColorGainShadows.z) * _406) * exp2(log2(exp2(((ColorContrast.z * ColorContrastShadows.z) * _434) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationShadows.z) * _448) * _454) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaShadows.z) * _420))))))) + ((((ColorOffset.z + ColorOffsetMidtones.z) + _637) + (((ColorGain.z * ColorGainMidtones.z) * _646) * exp2(log2(exp2(((ColorContrast.z * ColorContrastMidtones.z) * _664) * log2(max(0.0f, ((((ColorSaturation.z * ColorSaturationMidtones.z) * _673) * _454) + _378)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((ColorGamma.z * ColorGammaMidtones.z) * _655))))) * _731);
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

  SV_Target = ProcessLutbuilder(float3(_742, _744, _746), Samplers_1, Samplers_2, Textures_1, Textures_2, cb_config, SV_Target, OutputDevice);
  return SV_Target;
}
