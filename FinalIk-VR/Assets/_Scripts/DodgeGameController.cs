using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class DodgeGameController : MonoBehaviour
{
    public int score = 0;
    public Text pointsText;
    public TextMeshPro pointsTextWorld;
    public SphereCollider playerCollider;
    public BoxCollider hazardCollider;
    public bool gameIsStarted = false;
    public GameObject hazard;
    private GameObject[] hazardInstances;
    private Vector3[] targets ;
    private Random random = new Random();
    public Transform spawnPointLeft, spawnPointRight, spawnPointBack, spawnPointFront;
    public float playAreaSizeX, playAreaSizeY;

    public int hazardCount = 0;
    public int maxHazardCount = 5;
    private int hazardsMoving = 0;

    public float hazardInterval = 3f;
    public float hazardSpeed = 2f;

    private int hazardsFinishedMoving = 0;

    void Start()
    {
        pointsText.text = "Punkte: " + score;
        pointsTextWorld.text = "Punkte: " + score;
        hazardInstances = new GameObject[maxHazardCount];
        targets = new Vector3[maxHazardCount];
        createHazards();
    }

    void Update()
    {
        if(gameIsStarted)
        {
            pointsText.text = "Punkte: " + score;
            pointsTextWorld.text = "Punkte: " + score;
            moveHazards();
        }
    }

    private void createHazards()
    {
        for (int i = 0; i < maxHazardCount; i++)
        {
            rollSpawningDirection(Random.Range(1, 100));
        }
    }

    private void rollSpawningDirection(int direction)
    {
        string directionString = "";

        if(0 < direction && direction <= 33)
        {
            directionString = "left";
        }
        else if (34 < direction && direction <= 66)
        {
            directionString = "right";
        }
        else if (66 < direction && direction <= 100)
        {
            directionString = "back";
        }

        Vector3 position = new Vector3(0, 0, 0);
        Vector3 scale = new Vector3(0, 0, 0);
        Vector3 target = new Vector3(0, 0, 0);

        int deviationSideways = Random.Range(-2, 2);
        switch (directionString)
        {
            case "left":
                position = spawnPointLeft.position;
                scale = new Vector3(1, 1, Random.Range(1, 3));
                target = spawnPointRight.position;
                position.z += deviationSideways;
                target.z += deviationSideways;
                break;
            case "right":
                position = spawnPointBack.position;
                scale = new Vector3(1, 1, Random.Range(1, 3));
                target = spawnPointFront.position;
                position.z += deviationSideways;
                target.z += deviationSideways;

                break;
            case "back":
                position = spawnPointRight.position;
                scale = new Vector3(1, 1, Random.Range(1, 3));
                target = spawnPointLeft.position;
                position.x += deviationSideways;
                target.x += deviationSideways;
                break;
        }

        //floating overhead
        int floatingOver = Random.Range(1, 10);
        if (floatingOver <= 2)
        {
            position.y += 2;
            target.y += 2;
            scale = new Vector3(Random.Range(1, 4), 1, Random.Range(1, 4));
        }

        hazardInstances[hazardCount] = Instantiate(hazard, position, Quaternion.identity);
        hazardInstances[hazardCount].transform.localScale = scale;
        targets[hazardCount] = target;
        hazardCount++;
    }

    private void moveHazards()
    {
        float step = hazardSpeed * Time.deltaTime;

        for (int i= hazardsFinishedMoving; i < hazardsMoving; i++)
        {
            if(i < hazardInstances.Length && hazardInstances[i] != null)
            {
                hazardInstances[i].transform.position = Vector3.MoveTowards(hazardInstances[i].transform.position, targets[i], step);
                if(hazardInstances[i].transform.position == targets[i])
                {
                    if (hazardInstances[i].active)
                    {
                        hazardInstances[i].SetActive(false);
                        addPointsToScore(1);
                    }
                    hazardsFinishedMoving++;
                }
            }
        }
    }

    private void moveHazard()
    {
        hazardsMoving++;
        Debug.Log(hazardsMoving);
        if(hazardsMoving > maxHazardCount)
        {
            CancelInvoke();
        }
    }

    public void startGame()
    {
        CancelInvoke();
        InvokeRepeating("moveHazard", 1, hazardInterval);
        gameIsStarted = true;
    }

    public void addPointsToScore(int points){
        this.score += points;
    }

    public void subtractPointsFromScore(int points){
        this.score -= points;
    }


}
