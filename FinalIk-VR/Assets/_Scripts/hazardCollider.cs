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
            gameController.subtractPointsFromScore(1);
            otherCollider.gameObject.SetActive(false);
        }
        if (otherCollider.gameObject.CompareTag("Collectible"))
        {
            gameController.addPointsToScore(2);
            otherCollider.gameObject.SetActive(false);
        }
    }
}
