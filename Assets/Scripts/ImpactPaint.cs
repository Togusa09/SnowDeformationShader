using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImpactPaint : MonoBehaviour
{
    public RenderTexture RenderTexture;

    // Start is called before the first frame update
    void Start()
    {
        var size = 1024;

        //var texture = new Texture2D(size, size, TextureFormat.ARGB32, false);

        //for (var x = 0; x < size; x++)
        //for (var y = 0; y < size; y++)
        //{
        //    var xCol = x / (float) size;
        //    var yCol = y / (float) size;

        //    var colour = new Color(xCol, 0, yCol, 1);
        //    texture.SetPixel(x, y, colour);
        //}

        //// Apply all SetPixel calls
        //texture.Apply();

        // connect texture to material of GameObject this script is attached to
        GetComponent<Renderer>().material.mainTexture = RenderTexture;
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("Collision");
        
    }
}
