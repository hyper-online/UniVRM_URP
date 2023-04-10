Shader "Custom/OutlineTransparent" {
    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Main Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineWidth ("Outline Width", Range(0, 0.1)) = 0.02
    }
 
    SubShader {
        Tags {"Queue"="Transparent" "RenderType"="Transparent"}
        LOD 100

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        float4 _Color;
        float _OutlineWidth;
        float4 _OutlineColor;

        struct Input {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _Color.rgb * tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Alpha = tex2D(_MainTex, IN.uv_MainTex).a;
            float fresnel = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            float outline = step(fresnel, _OutlineWidth);
            o.Emission = _OutlineColor.rgb * outline;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
