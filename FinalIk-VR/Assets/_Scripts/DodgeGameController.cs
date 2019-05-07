using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;


public class DodgeGameController : MonoBehaviour
{
    public int score = 0;
    public int plusPoints = 0;
    public int minusPoints = 0;
    public TextMeshPro pointsTextWorld;
    public TextMeshPro plusPointsWorld;
    public TextMeshPro minusPointsWorld;
    public TextMeshPro endText;

    public bool gameIsStarted = false;
    public bool gameEnded = false;

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

    public GameObject collectible;
    private GameObject[] collectiblesInstances;
    public int collectiblesCount = 0;
    public int maxCollectiblesCount = 5;
    private int collectiblesMoving = 0;
    public float collectiblesInterval = 3f;
    public float collectiblesSpeed = 2f;
    private int collectiblesFinishedMoving = 0;
    private Vector3[] collectibleTargets;


    void Start()
    {
        pointsTextWorld.text = "Punkte: " + score;
        plusPointsWorld.gameObject.SetActive(false);
        minusPointsWorld.gameObject.SetActive(false);
        endText.gameObject.SetActive(false);


        hazardInstances = new GameObject[maxHazardCount];
        collectiblesInstances = new GameObject[maxCollectiblesCount];
        targets = new Vector3[maxHazardCount];
        collectibleTargets = new Vector3[maxCollectiblesCount];
        createHazards();
        createCollectibles();
    }

    void Update()
    {
        if(gameIsStarted)
        {
            pointsTextWorld.text = "Punkte: " + score;
            plusPointsWorld.text = "Pluspunkte: " + plusPoints;
            minusPointsWorld.text = "Minuspunkte: " + minusPoints;
            moveHazards();
            moveCollectibles();
        }
        if(maxHazardCount == hazardsFinishedMoving)
        {
            gameEnded = true;
        }
        if (gameEnded)
        {
            plusPointsWorld.gameObject.SetActive(true);
            minusPointsWorld.gameObject.SetActive(true);
            endText.gameObject.SetActive(true);
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

        if(0 < direction && direction <= 0)
        {
            directionString = "left";
        }
        else if (34 < direction && direction <= 0)
        {
            directionString = "right";
        }
        else if (66 < direction && direction <= 0)
        {
            directionString = "back";
        }
        else if (0 < direction && direction <= 100)
        {
            directionString = "front";
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
            case "front":
                position = spawnPointFront.position;
                scale = new Vector3(Random.Range(1, 3), 1, 1);
                target = spawnPointBack.position;
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
            scale = new Vector3(Random.Range(2, 5), 1, Random.Range(1, 4));
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
                        //addPointsToScore(1);
                    }
                    hazardsFinishedMoving++;
                }
            }
        }
    }

    private void moveHazardInvoke()
    {
        hazardsMoving++;
        if(hazardsMoving > maxHazardCount)
        {
            CancelInvoke();
        }
    }

    private void createCollectibles()
    {
        for (int i = 0; i < maxCollectiblesCount; i++)
        {
            Vector3 position = new Vector3(0, 0, 0);
            Vector3 scale = new Vector3(0, 0, 0);
            Vector3 target = new Vector3(0, 0, 0);

            int deviationSideways = Random.Range(-2, 2);
            int deviationUpwards = Random.Range(1, 3);

            position = spawnPointFront.position;
            scale = new Vector3(0.5f, 0.5f, 0.5f);
            target = spawnPointBack.position;
            position.x += deviationSideways;
            target.x += deviationSideways;
            position.y += deviationUpwards;
            target.y += deviationUpwards;

            collectiblesInstances[collectiblesCount] = Instantiate(collectible, position, Quaternion.identity);
            collectiblesInstances[collectiblesCount].transform.localScale = scale;
            collectibleTargets[collectiblesCount] = target;
            collectiblesCount++;
        }
    }

    private void moveCollectibles()
    {
        float step = collectiblesSpeed * Time.deltaTime;

        for (int i = collectiblesFinishedMoving; i < collectiblesMoving; i++)
        {
            if (i < collectiblesInstances.Length && collectiblesInstances[i] != null)
            {
                collectiblesInstances[i].transform.position = Vector3.MoveTowards(collectiblesInstances[i].transform.position, collectibleTargets[i], step);
                if (collectiblesInstances[i].transform.position == collectibleTargets[i])
                {
                    if (collectiblesInstances[i].active)
                    {
                        collectiblesInstances[i].SetActive(false);
                    }
                    collectiblesFinishedMoving++;
                }
            }
        }
    }

    private void moveCollectiblesInvoke()
    {
        collectiblesMoving++;
        if (collectiblesMoving > maxCollectiblesCount)
        {
            CancelInvoke();
        }
    }

    public void startGame()
    {
        CancelInvoke();
        InvokeRepeating("moveHazardInvoke", 2, hazardInterval);
        InvokeRepeating("moveCollectiblesInvoke", 2, collectiblesInterval);
        gameIsStarted = true;
    }

    public void addPointsToScore(int points){
        this.score += points;
        this.plusPoints += points;
    }

    public void subtractPointsFromScore(int points){
        this.score -= points;
        this.minusPoints -= points;
    }


}
