Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A596BABAD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCOJIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCOJIY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 05:08:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47077B9B6
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 02:07:48 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F6CVbi031070;
        Wed, 15 Mar 2023 09:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+HAYdprAXADx6oWeuYZM1bSTfuwFc7QgFqEhugCHaOg=;
 b=BKzCCqx5Vj9kq6cgqjKwChmVVuTY147OSWhzZgO1t1JqboN5TKlzt6z7H8oeLdE7qGbA
 7d/EjluWOsAVPm2EsDCX71A77P1w6wIFV0Y0/1sniWa8tWicXA3LQvG0ieUKIuDfDgr8
 M1G9xpPctY0g8ykjMtf9RmUo+6ESnGUEUIRd2mG+p1JnmCrTua4Kk6yWh0YmAL0Y0paj
 Y41suB6X4QW0vq500K9VkmjJsFKcToZp0vKxyHTlsYvcjTZomQwiqVtu9dh2a4gRl1gz
 UMZGlrOAI6ma3nHFcfkvDuSWlxpS3bhcVKuBaQQ1W/3/z2dhQr/gtrd90eWHKoqAX2wC qw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2crh2q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 09:07:40 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F97dgA027477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 09:07:40 GMT
Received: from rajson-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 02:07:38 -0700
From:   Rajat Soni <quic_rajson@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix memory leak in ath12k_qmi_driver_event_work()
Date:   Wed, 15 Mar 2023 14:36:32 +0530
Message-ID: <20230315090632.15065-1-quic_rajson@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MHZ1LfykRlekh_ygDfCrTfIzsy4Hj_-7
X-Proofpoint-ORIG-GUID: MHZ1LfykRlekh_ygDfCrTfIzsy4Hj_-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=942 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the buffer pointed by event is not freed in case
ATH12K_FLAG_UNREGISTERING bit is set, this causes memory leak.

Add a goto skip instead of return, to ensure event and all the
list entries are freed properly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 979a63f2e2ab..4beb9ef23d08 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2991,7 +2991,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 		spin_unlock(&qmi->event_lock);
 
 		if (test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))
-			return;
+			goto skip;
 
 		switch (event->type) {
 		case ATH12K_QMI_EVENT_SERVER_ARRIVE:
@@ -3032,6 +3032,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 			ath12k_warn(ab, "invalid event type: %d", event->type);
 			break;
 		}
+skip:
 		kfree(event);
 		spin_lock(&qmi->event_lock);
 	}

base-commit: 3fa9da4001890def44801dd56d5fbc134689be28
-- 
2.17.1

