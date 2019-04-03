using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class hazardCollider : MonoBehaviour
{
    public DodgeGameController gameController;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    private void OnTriggerEnter(Collider otherCollider){
        if(otherCollider.gameObject.CompareTag("Hazard")){
            Debug.Log("Hazard Trigger");
            gameController.subtractPointsFromScore(10);
        }
    }
}
