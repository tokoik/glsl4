#version 120

// bump.vert

attribute vec3 tangent;

varying vec3 light;
varying vec3 view;

void main()
{
  // 位置ベクトルと光線ベクトルを求める
  vec4 p = gl_ModelViewMatrix * gl_Vertex;
  vec3 l = normalize(gl_LightSource[0].position.xyz * p.w - gl_LightSource[0].position.w * p.xyz);

  // 法線ベクトルと接線ベクトルから接空間への変換行列を求める
  vec3 n = normalize(gl_NormalMatrix * gl_Normal);
  vec3 t = normalize(gl_NormalMatrix * tangent);
  vec3 b = cross(n, t);
  
  vec3 temp;
  
  // 接空間における視線ベクトルを求める
  temp.x = dot(p.xyz, t);
  temp.y = dot(p.xyz, b);
  temp.z = dot(p.xyz, n);
  view = -normalize(temp);

  // 接空間における光線ベクトルを求める
  temp.x = dot(l, t);
  temp.y = dot(l, b);
  temp.z = dot(l, n);
  light = normalize(temp);

  // テクスチャ座標と頂点座標を出力する
  gl_TexCoord[0] = gl_MultiTexCoord0;
  gl_Position = ftransform();
}
