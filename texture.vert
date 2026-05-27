#version 120

// texture.vert

// ラスタライザに送る頂点の位置
varying vec4 position;

// ラスタライザに送る頂点の法線ベクトル
varying vec3 normal;

void main()
{
  // 頂点のクリッピング座標値
  gl_Position = ftransform();

  // 頂点のワールド座標値
  position = gl_ModelViewMatrix * gl_Vertex;

  // 法線ベクトル
  normal = normalize(gl_NormalMatrix * gl_Normal);

  // テクスチャ座標
  gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
}
