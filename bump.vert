#version 120

// bump.vert

attribute vec3 tangent;

varying vec3 light;
varying vec3 view;

void main()
{
  // 頂点位置，光線ベクトル
  vec4 position = gl_ModelViewMatrix * gl_Vertex;
  vec3 l = normalize((gl_LightSource[0].position * position.w - gl_LightSource[0].position.w * position).xyz);

  // 法線ベクトルと接線ベクトルから接空間への変換行列
  vec3 n = normalize(gl_NormalMatrix * gl_Normal);
  vec3 t = normalize(gl_NormalMatrix * tangent);
  vec3 b = cross(n, t);

  vec3 temp;

  // 接空間における光線ベクトル
  temp.x = dot(l, t);
  temp.y = dot(l, b);
  temp.z = dot(l, n);
  light = normalize(temp);

  // 接空間における視線ベクトル
  temp.x = dot(position.xyz, t);
  temp.y = dot(position.xyz, b);
  temp.z = dot(position.xyz, n);
  view = -normalize(temp);

  // テクスチャ座標，頂点位置
  gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
  gl_Position = ftransform();
}
