function forward_dev_gke
    set PROJECT_ID mk-savi-mlserving-dev
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)
    set ZONE (gcloud compute instances list --project $PROJECT_ID --filter="name=($INSTANCE)" --format="csv[no-heading](zone)")

    gcloud beta compute ssh $INSTANCE --project $PROJECT_ID --tunnel-through-iap --zone $ZONE -- -o ExitOnForwardFailure=yes -M -S /tmp/sslsock -L8888:127.0.0.1:8888 -fN
end

function close_dev_gke
    set PROJECT_ID mk-savi-mlserving-dev
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)

    ssh -S /tmp/sslsock -O exit $INSTANCE
end

function forward_uat_gke
    set PROJECT_ID mk-savi-mlserving-uat
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)
    set ZONE (gcloud compute instances list --project $PROJECT_ID --filter="name=($INSTANCE)" --format="csv[no-heading](zone)")

    gcloud beta compute ssh $INSTANCE --project $PROJECT_ID --tunnel-through-iap --zone $ZONE -- -o ExitOnForwardFailure=yes -M -S /tmp/sslsock -L8888:127.0.0.1:8888 -fN
end

function close_uat_gke
    set PROJECT_ID mk-savi-mlserving-uat
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)

    ssh -S /tmp/sslsock -O exit $INSTANCE
end

function forward_prod_gke
    set PROJECT_ID mk-savi-mlserving-prod
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)
    set ZONE (gcloud compute instances list --project $PROJECT_ID --filter="name=($INSTANCE)" --format="csv[no-heading](zone)")

    gcloud beta compute ssh $INSTANCE --project $PROJECT_ID --tunnel-through-iap --zone $ZONE -- -o ExitOnForwardFailure=yes -M -S /tmp/sslsock -L8888:127.0.0.1:8888 -fN
end

function close_prod_gke
    set PROJECT_ID mk-savi-mlserving-prod
    set REGION australia-southeast1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)

    ssh -S /tmp/sslsock -O exit $INSTANCE
end

function forward_dev_mlpipelines
    set PROJECT_ID mk-savi-mldev
    set REGION us-central1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)
    set ZONE (gcloud compute instances list --project $PROJECT_ID --filter="name=($INSTANCE)" --format="csv[no-heading](zone)")

    gcloud beta compute ssh $INSTANCE --project $PROJECT_ID --tunnel-through-iap --zone $ZONE -- -o ExitOnForwardFailure=yes -M -S /tmp/sslsock -L8888:127.0.0.1:8888 -fN
end

function close_dev_mlpipelines
    set PROJECT_ID mk-savi-mldev
    set REGION us-central1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)

    ssh -S /tmp/sslsock -O exit $INSTANCE
end

function forward_prod_mlpipelines
    set PROJECT_ID mk-savi-mlprod
    set REGION us-central1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)
    set ZONE (gcloud compute instances list --project $PROJECT_ID --filter="name=($INSTANCE)" --format="csv[no-heading](zone)")

    gcloud beta compute ssh $INSTANCE --project $PROJECT_ID --tunnel-through-iap --zone $ZONE -- -o ExitOnForwardFailure=yes -M -S /tmp/sslsock -L8888:127.0.0.1:8888 -fN
end

function close_prod_mlpipelines
    set PROJECT_ID mk-savi-mlprod
    set REGION us-central1

    set INSTANCE (gcloud compute instance-groups list-instances bastion-mig --project $PROJECT_ID --filter="status=RUNNING" --format="value(instance)" --limit 1 --region $REGION)

    ssh -S /tmp/sslsock -O exit $INSTANCE
end
