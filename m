Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD478D325
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 08:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbjH3GJx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjH3GJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 02:09:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1086CCB
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 23:09:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U3fAJf016006;
        Wed, 30 Aug 2023 06:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=HD44fc1v3l30lOp6aCuhaI039spsjV+2V8bDLG5RVTI=;
 b=U+cwawfEs6LkYe+riJZKa1diiMA7Qd56RzUZ5Bjx+aeuO1JZRfpl0uxMgFbeKiZxYtsP
 m/ut/4RwxuDpw8Pg6vhQ9ydfzgoYrH/HOW5W8IAOVJ2YA3smMDtGn2gL14DCNUsDw2fo
 e18rnPZfS0cnnObDKtbaCwGYd2rh55hMSeJ2+6c9hqnOsKsQ0q9eQtseurECfGXPCUrh
 XDEXJQ56ErgssX/Zmwl3AFmrLkdyk1GjLMZSgI5bQhFrJRk3M/HpFZR7DTR7jcSio5px
 9ZICd6PSKvhOrmTayAuzRFEl31LnmbJHj6vhjY8Q9izP5hyFBAvDJFbJiC4WN0S79sHR Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss7meucpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:09:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U694nC003340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:09:04 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 23:09:03 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: change to initialize recovery variables earlier in ath12k_core_reset()
Date:   Wed, 30 Aug 2023 02:08:50 -0400
Message-ID: <20230830060850.18881-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2NfYV00ovDmCzHY9S1kKmgJa4S-kbFX1
X-Proofpoint-GUID: 2NfYV00ovDmCzHY9S1kKmgJa4S-kbFX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes device recovery fail with this operation.
Run test command for many times:
echo assert > /sys/kernel/debug/ath12k/wcn7850\ hw2.0_0000\:03\:00.0/simulate_fw_crash

While recovery start, ath12k_core_post_reconfigure_recovery() will
call ieee80211_restart_hw(), and the restart_work which queued by
ieee80211_restart_hw() is running in another thread, it will call
into ath12k_mac_op_start() and ath12k_mac_wait_reconfigure(), and
the variables ab->recovery_start_count and ab->recovery_start is used
in ath12k_mac_wait_reconfigure(), so ath12k need to initialize the
variables before queue the restart_work, otherwise ath12k_mac_wait_reconfigure()
maybe use the un-initialized variables. Change to initialize the 2
variables earlier and then recovery process become correct.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..39f938fafa81 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -823,6 +823,8 @@ static void ath12k_core_reset(struct work_struct *work)
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");
 
 	ab->is_reset = true;
+	atomic_set(&ab->recovery_start_count, 0);
+	reinit_completion(&ab->recovery_start);
 	atomic_set(&ab->recovery_count, 0);
 
 	ath12k_core_pre_reconfigure_recovery(ab);
@@ -830,9 +832,6 @@ static void ath12k_core_reset(struct work_struct *work)
 	reinit_completion(&ab->reconfigure_complete);
 	ath12k_core_post_reconfigure_recovery(ab);
 
-	reinit_completion(&ab->recovery_start);
-	atomic_set(&ab->recovery_start_count, 0);
-
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "waiting recovery start...\n");
 
 	time_left = wait_for_completion_timeout(&ab->recovery_start,

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

