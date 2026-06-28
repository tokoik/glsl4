#version 120

// texture.vert

// ラスタライザに送る視点座標系の頂点の位置
varying vec4 position;

// ラスタライザに送る視点座標系の法線ベクトル
varying vec3 normal;

void main()
{
  // 頂点のクリッピング座標値
  gl_Position = ftransform();

  // テクスチャ座標
  gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;

  // 視点座標系の頂点の位置
  position = gl_ModelViewMatrix * gl_Vertex;

  // 視点座標系の法線ベクトル
  normal = normalize(gl_NormalMatrix * gl_Normal);
}
