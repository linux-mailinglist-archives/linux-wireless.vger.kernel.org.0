Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057DC7571F6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jul 2023 04:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGRCs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGRCsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 22:48:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D952E6C
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 19:48:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I2VrZP010945;
        Tue, 18 Jul 2023 02:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Y4LVSotgpj1rOBsiuRlk9VRWl4eBVM6YTEqbq3VQpK8=;
 b=ShpHvMSFHx7WqRkLdOp4UAdWPBMwmZqVly2+2FeFzHTAcYVNOE4H2CfAZ08o86AZ8sNW
 Su9ULJwHBOpQL5Z9UdhTO1OCVnOCU7O/Gx6bfsnkoshWevwwlUcxPq504t5IXQEshbFV
 eaEjcxq3hSFksrijPntxlRmTfbQIuiomBKK/C3izBaewnG4+PhW79LxodoTStZawe4Z1
 0ZJK81D1s2WlPbzrTrvoe453BgnIeUAbIHfJLPdCh+9T4U5ZNyM4UZZHNb7ZudpQY4S9
 cwtZeKWBKb7LRyPFn7g2vXG4UQD/cdJ7LManDKqPY7HIH+9XDWksBFLozFCdBtpMz7jC Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1jcxw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 02:47:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I2lc1x019488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 02:47:38 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:47:37 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: avoid deadlock by change ieee80211_queue_work for regd_update_work
Date:   Mon, 17 Jul 2023 22:47:24 -0400
Message-ID: <20230718024724.29120-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dfmhe5738vx9ZAhRJyImvME62JUrLzQd
X-Proofpoint-ORIG-GUID: dfmhe5738vx9ZAhRJyImvME62JUrLzQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=770
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Deadlock is easily happened while shutdown wlan interface such as run
"ifconfig wlan0 down".

The reason is because when ar->regd_update_work is ran, it will
call wiphy_lock(ar->hw->wiphy) in function ath12k_regd_update() which
is running in workqueue of ieee80211_local queued by ieee80211_queue_work().
Another thread from "ifconfig wlan0 down" will also accuqire the lock
by wiphy_lock(sdata->local->hw.wiphy) in function ieee80211_stop(), and
then it call ieee80211_stop_device() to flush_workqueue(local->workqueue),
this will wait the workqueue of ieee80211_local finished. Then deadlock
will happen easily if the two thread run meanwhile.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7ae0bb78b2b5..ea6de84bf5cd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5213,7 +5213,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		ar = ab->pdevs[pdev_idx].ar;
 		kfree(ab->new_regd[pdev_idx]);
 		ab->new_regd[pdev_idx] = regd;
-		ieee80211_queue_work(ar->hw, &ar->regd_update_work);
+		queue_work(ab->workqueue, &ar->regd_update_work);
 	} else {
 		/* Multiple events for the same *ar is not expected. But we
 		 * can still clear any previously stored default_regd if we

base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084
-- 
2.40.1

