#version 120

// bump.frag

uniform sampler2D texture;

varying vec3 view;
varying vec3 light;

void main ()
{
  // 法線マップから法線ベクトル得る
  vec4 color = texture2DProj(texture, gl_TexCoord[0]);
  vec3 fnormal = color.rgb * 2.0 - 1.0;

  // 接空間における光線ベクトル，視線ベクトル，中間ベクトル
  vec3 flight = normalize(light);
  vec3 fview = normalize(view);
  vec3 halfway = normalize(flight + fview);

  // 拡散反射率と鏡面反射率
  float diffuse = max(dot(fnormal, flight), 0.0);
  float specular = pow(max(dot(fnormal, halfway), 0.0), gl_FrontMaterial.shininess);

  // フラグメントの色
  gl_FragColor = gl_FrontLightProduct[0].ambient
               + gl_FrontLightProduct[0].diffuse * diffuse
               + gl_FrontLightProduct[0].specular * specular;
}
