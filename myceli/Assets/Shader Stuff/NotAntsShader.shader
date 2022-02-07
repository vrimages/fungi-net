// Original reference: https://www.shadertoy.com/view/7sjGDm
// Converted from GLSL to HLSL by Lucas Wozniak

Shader "NotAntsShader"
{
	
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		//-------------------------------------------------------------------------------------------


		CGINCLUDE
		#pragma vertex SetVertexShader
		#pragma fragment SetPixelShader

		//#pragma multi_compile_fog

		#include "UnityCG.cginc"

		//sampler2D _BufferA;	
		//sampler2D _BufferB;
		//Buffer<float4> _BufferA2;
		//Buffer<float4> _BufferB2;

		Texture2D _BufferA2;
		Texture2D _BufferB2;

		int iFrame;
		//float4 iMouse;
		//float4 iResolution;
		
		void SetVertexShader (inout float4 vertex:POSITION, inout float2 uv:TEXCOORD0)
		{
			vertex = UnityObjectToClipPos(vertex);
		}
		
		
		ENDCG

		//-------------------------------------------------------------------------------------------
		
		Pass
		{ 
			CGPROGRAM
			// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
			#pragma exclude_renderers d3d11



			float4 getv2(float2 p, float2 uv:TEXCOORD0)
			{
				
				//float2 r2 = float2(i.uv);
				float2 r2 = uv;
				if (p.x < 0) {
					p.x += r2.x;
				}
				if (p.y < 0) {
					p.y += r2.y;
				}
				if (p.x >= r2.x) {
					p.x -= r2.x;
				}
				if (p.y >= r2.y) {
					p.y -= r2.y;
				}
				//return texelFetch( _BufferA, p, 0 );
				return _BufferA2.Load(int3(p,0), 0);
			}

			float4 getvb(float2 p, float2 uv:TEXCOORD0)
			{
				//float2 r2 = float2(i.uv);
				float2 r2 = uv;
				if (p.x < 0) {
					p.x += r2.x;
				}
				if (p.y < 0) {
					p.y += r2.y;
				}
				if (p.x >= r2.x) {
					p.x -= r2.x;
				}
				if (p.y >= r2.y) {
					p.y -= r2.y;
				}
				//return texelFetch( _BufferB, p, 0 );
				return _BufferB2.Load(int3(p,0), 0);
			}

			float2 addScent(float2 old, float2 d, float2 front, float k) {
				old += d * (1.0+0.00*dot(d, front)) * k;
				return old;
			}

			void SetPixelShader (float4 vertex:POSITION, float2 uv:TEXCOORD0, out float4 fragColor:SV_TARGET)
			{

				//#pragma vertex vert
				//#pragma fragment frag
				// make fog work
				//#pragma multi_compile_fog

				//#include "UnityCG.cginc"


				/*

				struct appdata
				{
					//float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					//UNITY_FOG_COORDS(1)
					//float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;

				v2f vert (appdata v)
				{
					v2f o;
					//o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					//UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				*/

				//fixed4 frag (v2f i) : SV_Target
				//{
					//string hi = "";


					// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
					//#pragma exclude_renderers d3d11

					// Trails

					/*
					float randv(float2 (float co)){
						return frac(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
					}
					*/


					/*
					float4 getv2(float2 yo)
					{
						
						//float2 r2 = float2(i.uv);
						//float2 r2 = float2(uv);
						float2 ay = uv + yo;
						if (ay.x < 0) {
							ay.x += uv.x;
						}
						if (ay.y < 0) {
							ay.y += uv.y;
						}
						if (ay.x >= r2.x) {
							ay.x -= uv.x;
						}
						if (ay.y >= r2.y) {
							ay.y -= uv.y;
						}
						//return texelFetch( _BufferA, p, 0 );
						return _BufferA.Load(int3(ay,0));
					}

					float4 getvb(float2 hi)
					{
						//float2 r2 = float2(i.uv);
						float2 r2 = float2(uv);
						if (p.x < 0) {
							p.x += r2.x;
						}
						if (p.y < 0) {
							p.y += r2.y;
						}
						if (p.x >= r2.x) {
							p.x -= r2.x;
						}
						if (p.y >= r2.y) {
							p.y -= r2.y;
						}
						//return texelFetch( _BufferB, p, 0 );
						return _BufferB.Load(int3(p,0));
					}
					*/

					/*
					float4 getv2(float2 p)
					{
						
						//float2 r2 = float2(i.uv);
						float2 r2 = float2(uv);
						if (p.x < 0) {
							p.x += r2.x;
						}
						if (p.y < 0) {
							p.y += r2.y;
						}
						if (p.x >= r2.x) {
							p.x -= r2.x;
						}
						if (p.y >= r2.y) {
							p.y -= r2.y;
						}
						//return texelFetch( _BufferA, p, 0 );
						return _BufferA.Load(int3(p,0));
					}

					float4 getvb(float2 p)
					{
						//float2 r2 = float2(i.uv);
						float2 r2 = float2(uv);
						if (p.x < 0) {
							p.x += r2.x;
						}
						if (p.y < 0) {
							p.y += r2.y;
						}
						if (p.x >= r2.x) {
							p.x -= r2.x;
						}
						if (p.y >= r2.y) {
							p.y -= r2.y;
						}
						//return texelFetch( _BufferB, p, 0 );
						return _BufferB.Load(int3(p,0));
					}
					*/

					static const float kold = 1.0;
					static const float kscent = 0.885;
					static const float ksc2 = 0.120;
					static const float pi=3.1415;
					static const float pi2=2.0 * pi;
					static const float scentDecay = 0.995;
					static const float scexpand = 0.022;
					static const float scadd = 0.2;

					



					float2 p = float2(uv);
					float2 d[4] = {
						{0.0, 1.0},
						{0.0, -1.0},
						{1.0, 0.0},
						{-1.0, 0.0}
					}; 
					float4 av[5] = {
						getvb(p + float2(0, 1), uv),
						getvb(p + float2(0, -1), uv),
						getvb(p + float2(1, 0), uv),
						getvb(p + float2(-1, 0), uv),
						getvb(p + float2(0, 0), uv)
					}; 
					float4 scv[5] = {
						getv2(p + float2(0, 1), uv),
						getv2(p + float2(0, -1), uv),
						getv2(p + float2(1, 0), uv),
						getv2(p + float2(-1, 0), uv),
						getv2(p + float2(0, 0), uv)
					};
					

					
					
					if (iFrame == 0) {
						fragColor = float4(0,0,0,0);
						} else {
						float sc = scv[4].x;
						float sc2 = 0.0;
						sc2 += scv[0].x+scv[1].x+scv[2].x+scv[3].x;
						sc = (1.0 - scexpand) * sc + scexpand * 0.25 * sc2;
						
						sc = sc * scentDecay + scadd * min(av[4].x, 9999999.0);
						
						/*if (length(uv - float2(10.0)) < 5.0) {
							sc = max(sc, 40.0);
						}*/
						
						//drr = dr;
						fragColor = (sc, 0.0, 0.0, 0.0);
					}
					
				//}

			}

			ENDCG
		}

		//-------------------------------------------------------------------------------------------

		Pass
		{ 
			CGPROGRAM
			// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
			#pragma exclude_renderers d3d11


			float randv(float2 co){
				return frac(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
			}


			float4 getv2(float2 p, float2 uv:TEXCOORD0)
			{
				
				//float2 r2 = float2(i.uv);
				float2 r2 = uv;
				if (p.x < 0) {
					p.x += r2.x;
				}
				if (p.y < 0) {
					p.y += r2.y;
				}
				if (p.x >= r2.x) {
					p.x -= r2.x;
				}
				if (p.y >= r2.y) {
					p.y -= r2.y;
				}
				//return texelFetch( _BufferA, p, 0 );
				return _BufferA2.Load(int3(p,0), 0);
			}

			float4 getvb(float2 p, float2 uv:TEXCOORD0)
			{
				//float2 r2 = float2(i.uv);
				float2 r2 = uv;
				if (p.x < 0) {
					p.x += r2.x;
				}
				if (p.y < 0) {
					p.y += r2.y;
				}
				if (p.x >= r2.x) {
					p.x -= r2.x;
				}
				if (p.y >= r2.y) {
					p.y -= r2.y;
				}
				//return texelFetch( _BufferB, p, 0 );
				return _BufferB2.Load(int3(p,0), 0);
			}




			float4 pack(float4 v) {
				return float4(v.xy, v.zw);
			}

			float4 unpack(float4 v) {
				return float4(v.xy, v.zw);
			}


			float2 addScent(float2 old, float2 d, float2 front, float k) {
				old += d * (1.0+0.00*dot(d, front)) * k;
				return old;
			}
			

			void SetPixelShader (float4 vertex:POSITION, float2 uv:TEXCOORD0, out float4 fragColor:SV_TARGET)
			{

				//#pragma vertex vert
				//#pragma fragment frag
				// make fog work
				//#pragma multi_compile_fog

				//#include "UnityCG.cginc"

				/*
				struct appdata
				{
					//float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					//UNITY_FOG_COORDS(1)
					//float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;

				v2f vert (appdata v)
				{
					v2f o;
					//o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					//UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}
				*/

				//fixed4 frag (v2f i) : SV_Target
				//{

					// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
					//#pragma exclude_renderers d3d11

					// x - particle presence/amount
					// y - angle
					// z, w - movement error for Bresenham's like movement at arbitrary angle
					

					/*
					float4 getv2(float2 p)
					{
						//float2 r2 = float2(i.uv);
						float2 r2 = float2(uv);
						if (p.x < 0) {
							p.x += r2.x;
						}
						if (p.y < 0) {
							p.y += r2.y;
						}
						if (p.x >= r2.x) {
							p.x -= r2.x;
						}
						if (p.y >= r2.y) {
							p.y -= r2.y;
						}
						//return texelFetch( _BufferA, p, 0 );
						return _BufferA.Load(int3(p,0));
					}

					float4 getvb(float2 p)
					{
						//float2 r2 = float2(i.uv);
						float2 r2 = float2(uv);
						if (p.x < 0) {
							p.x += r2.x;
						}
						if (p.y < 0) {
							p.y += r2.y;
						}
						if (p.x >= r2.x) {
							p.x -= r2.x;
						}
						if (p.y >= r2.y) {
							p.y -= r2.y;
						}
						//return texelFetch( _BufferB, p, 0 );
						return _BufferB.Load(int3(p,0));

					}
					



					float4 pack(float4 v) {
						return float4(v.xy, v.zw);
					}

					float4 unpack(float4 v) {
						return float4(v.xy, v.zw);
					}
					*/

					static const float kold = 1.0;
					static const float kscent = 0.185;
					static const float ksc2 = 0.060;
					static const float krn = 0.000000005252;
					static const float pi=3.1415;
					static const float pi2=2.0 * pi;
					static const float optsc = 2280.0;
					static const float prefs = 2.0;
					static const float initialFill = 0.90;

					
					#define mod(x, y) (x-y*floor(x/y))


					float2 p = uv;
					float2 d[4] = {
						float2(0.0, 1.0),
						float2(0.0, -1.0),
						float2(1.0, 0.0),
						float2(-1.0, 0.0)
					}; 
					int spd = 1;
					float4 av[5] = {
						getvb(p + float2(0, 1), uv),
						getvb(p + float2(0, -1), uv),
						getvb(p + float2(1, 0), uv),
						getvb(p + float2(-1, 0), uv),
						getvb(p + float2(0, 0), uv)
					}; 

					float2 sumDir = (0,0);
					float totalw = 0.0;
					float2 olds = (0,0);
					for (int i=0; i<4; i++) {
						float2 gof = float2(cos(av[i].y), sin(av[i].y));
						float2 vs = 1.0*av[i].zw + gof;
						
						float proj = dot(vs, -d[i]);
						if (av[i].x < prefs) {
							if  (proj > 0.0 && proj > length(vs + d[i] * proj)) {
								sumDir += gof * av[i].x;
								totalw += av[i].x;
								olds += av[i].x * (vs + d[i]);
							}
							} else {
							float other = length(vs + d[i] * proj);
							if (proj > 0.0 ) {
								float ph = (proj) / (other + proj);
								sumDir += ph * gof * av[i].x;
								totalw += ph * av[i].x;
								olds += ph * av[i].x * (vs + d[i]);
							}
							/*float ph = max(0.0, dot(gof, -d[i]));// * 0.61;
							float other = vs + d[i] * proj)
							sumDir += ph * gof * av[i].x;
							totalw += ph * av[i].x;
							olds += ph * av[i].x * (vs + d[i]);*/
						}
					}
					olds /= max(0.01, totalw);
					if (length(olds) > 2.0 || dot(olds, sumDir) < 0.0) {
						olds = (0,0);
					}
					
					sumDir = normalize(sumDir);
					
					const float md = 3.4;
					/*float2 d2[4] = float2[4](
					float2(0.0, 1.0),
					float2(0.0, -1.0),
					float2(1.0, 0.0),
					float2(-1.0, 0.0)    ); 
					*/
					/*float2 d2[4] = float2[4](
					float2(1.0, 1.0),
					float2(1.0, -1.0),
					float2(-1.0, 1.0),
					float2(-1.0, -1.0)
					);*/
					float2 d2[4] = {
						sumDir, -sumDir, float2(sumDir.y, -sumDir.x), -float2(sumDir.y, -sumDir.x)
					}; 
					float4 sc[5] = {
						getv2(p + float2(d2[0]*md), uv),
						getv2(p + float2(d2[1]*md), uv),
						getv2(p + float2(d2[2]*md), uv),
						getv2(p + float2(d2[3]*md), uv),
						getv2(p + float2(0, 0), uv)
					}; 
					
					
					float2 scd = (0, 0);
					float tsc = 0.0;
					for (int i=0; i<4; i++) {
						float ef = (1.0 + dot(d2[i], sumDir));
						scd += d2[i] * sc[i].x * ef; //(optsc-abs(-optsc+sc[i].x)) * ef;
						tsc += sc[i].x * ef;
					}
					
					float drsc = atan2(scd.y, scd.x);
					

					float dra = atan2(sumDir.y, sumDir.x);
					dra += (randv(uv*0.2 + float2(_Time.y*10.0, 0.)) -0.5) * krn;
					
					
					float df = mod((drsc-dra), pi2);
					if (df > pi) { 
						df -= pi2;
					}
					if (df < -pi) { 
						df += pi2;
					}
					dra += ksc2 * min((pow(2.0, tsc)-1.0), 4.0) * clamp(df, -kscent, kscent);
					/*dra += (randv(uv + float2(_Time.y, 0.)) -0.5) * krn;
					dra -= 0.000;*/
					
					
					
					
					if (iFrame == 0) {
						float a = randv(uv) * pi2;
						float amount = (randv(uv + float2(10, 0)) > initialFill) ? 1.0 : 0.0;
						fragColor = pack(float4(amount, a, 0, 0));
						} else {
						
						
						
						float2 drr = (cos(dra), sin(dra));
						//drr = dr;
						fragColor = pack(float4(totalw, dra, olds.xy));
					}
					
				//}

			}

			ENDCG
		}

		//-------------------------------------------------------------------------------------------

		Pass
		{
			CGPROGRAM



			void SetPixelShader (float4 vertex:POSITION, float2 uv:TEXCOORD0, out float4 fragColor:SV_TARGET)
			{

				//#pragma vertex vert
				//#pragma fragment frag
				// make fog work
				//#pragma multi_compile_fog

				//#include "UnityCG.cginc"

				/*
				struct appdata
				{
					//float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					//UNITY_FOG_COORDS(1)
					//float4 vertex : SV_POSITION;
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;

				

				v2f vert (appdata v)
				{
					v2f o;
					//o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					//UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				*/
				

				//fixed4 frag (v2f i) : SV_Target
				//{
					/*
					float randv(float2 co){
						return frac(sin(dot(co.xy ,float2(12.9898,78.233))) * 43758.5453);
					}
					*/

					static const float scale = 1.0;

					//float4 c0 = texelFetch(_BufferA, float2(uv * scale), 0);
					float4 c0 = _BufferA2.Load(int3(float2(uv * scale), 0));
					//float4 c1 = texelFetch(_BufferB, float2(uv * scale), 0);
					float4 c1 = _BufferB2.Load(int3(float2(uv * scale), 0));
					//    c0.z = randv(uv);

					// Output to screen
					//return float4(c0.x * 1.0, 1.0*log(c1.x)*0.5, 0.0, 1.0);
					//return float4(c0.x * 1.0, c1.x*0.1, 0.0, 1.0);
					fragColor = float4(c0.x * 0.35, c1.x*0.1, 1.0*log(c1.x-2.0)*0.5, 1.0);
					//return float4(c0.x > 0.5, 0, c0.x < 0.5, 1.0);
				//}

			}

			ENDCG
		}


		//-------------------------------------------------------------------------------------------


	}
}
