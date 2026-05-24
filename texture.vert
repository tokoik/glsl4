#version 120

// texture.vert

// ラスタライザに送る頂点の法線ベクトル
varying vec3 normal;

// ラスタライザに送る光線ベクトル
varying vec3 light;

// ラスタライザに送る中間ベクトル
varying vec3 halfway;

void main()
{
  // 頂点のクリッピング座標値
  gl_Position = ftransform();

  // 頂点のワールド座標値
  vec4 position = gl_ModelViewMatrix * gl_Vertex;

  // 法線ベクトル
  normal = normalize(gl_NormalMatrix * gl_Normal);

  // 光線ベクトル
  light = normalize((gl_LightSource[0].position * position.w
    - gl_LightSource[0].position.w * position).xyz);

  // 視線ベクトル
  vec3 view = -normalize(position.xyz);

  // 中間ベクトル
  halfway = normalize(light + view);

  // テクスチャ座標
  gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
