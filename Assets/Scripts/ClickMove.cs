using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickMove : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
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
                //Debug.Log(hit.transform.gameObject.name);
                GetComponent<Rigidbody>().AddForceAtPosition(-hit.normal * 50, hit.point);
            }

            //GetComponent<Rigidbody>().AddForce( direction * new Vector3(0, 0, 40));
        }
    }
}
