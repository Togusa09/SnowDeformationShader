using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Drawable : MonoBehaviour
{
    // Start is called before the first frame update
    public RenderTexture SnowImpactTexture;
    void Start()
    {
        var size = 1024;
        //SnowImpactTexture = new Texture2D(size, size, TextureFormat.R8, false);
        SnowImpactTexture = new RenderTexture(1024, 1024, 0, RenderTextureFormat.R8);

        //for (var x = 0; x < size; x++)
        //for (var y = 0; y < size; y++)
        //{
        //    var xCol = x / (float)size;
        //    var yCol = y / (float)size;

        //        if (x > size/ 2)
        //        {
        //            var colour = new Color(0, 0, 0, 1);
        //            SnowImpactTexture.SetPixel(x, y, colour);
        //        }
        //        else
        //        {
        //            var colour = new Color(1, 0, 0, 1);
        //            SnowImpactTexture.SetPixel(x, y, colour);
        //        }

        //}
        //SnowImpactTexture.Apply();

        var renderer = GetComponent<Renderer>();
        renderer.material.SetTexture("_SnowTex", SnowImpactTexture);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
