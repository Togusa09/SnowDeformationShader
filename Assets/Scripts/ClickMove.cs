using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickMove : MonoBehaviour
{
    public GameObject SnowCamera;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (SnowCamera)
        {
            SnowCamera.transform.position = new Vector3(transform.position.x, SnowCamera.transform.position.y, transform.position.z);
        }
    }

    void OnMouseOver()
    {
        if (Input.GetMouseButtonDown(0))
        {
            // Whatever you want it to do.
            var direction = Camera.main.transform.rotation;

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit, 100))
            {
                GetComponent<Rigidbody>().AddForceAtPosition(-hit.normal * 50, hit.point);
            }
        }
    }
}
