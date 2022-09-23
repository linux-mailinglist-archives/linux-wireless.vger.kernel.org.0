Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA85E8048
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIWRDB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWRDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 13:03:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545231280DA
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 10:02:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NGBTAZ029695;
        Fri, 23 Sep 2022 17:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=s/JEjG7pAiSMB9sBc/hxgQqBlK3p9bTRyU2+Lj+BgGI=;
 b=fi04GkShYElKiBAYJ5lb4Jwb2JE3S1/igSl6nIY4LqEVqJ6tW3cq09C3l7p+0gv+Nsv2
 m5Q/IVk7iCiexrmtNQmyDpp7FIBnf2Z4P0ufSroA6zYd9kLvaMRyqFvhUamC16ZFnh7G
 4HgOX1nyY2JYt//t4xzJMszne0VQI58LpPWby6/YJwyZSVn3mKJM3oyx4MFZXlJJQXev
 +igMdjimlhvTsTO7/DgN0XYTR+ZxRDe2V1RzgKLO2Qrvney+g0Ewq4oRKA6wOtbihi2m
 ZwPUvaky9okSNrOIAsBwyl1mMxEyN4tzw4hTLSTdcESv6CGKPwszQ/IRCsKubuI157Kc fA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3js9vusgvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 17:02:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28NH2qmg010911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 17:02:52 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 23 Sep 2022 10:02:50 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath11k: stop tx queues immediately upon firmware exit
Date:   Fri, 23 Sep 2022 22:32:35 +0530
Message-ID: <20220923170235.18873-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E7V415q33AT__ERYzlPofA_BxPYNB2RU
X-Proofpoint-GUID: E7V415q33AT__ERYzlPofA_BxPYNB2RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=887
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, recovery flag is set immediately upon firmware
exit but tx queues are stopped once firmware arrives back
and is ready which is during ath11k_core_restart. Once
ieee80211 hw restart is completed, tx queues are resumed.
If during the time delta between firmware exit and firmware
ready, mac80211 send packets, currently ath11k will drop it
since recovery flag will be set. But warning prints will
come -
  "ath11k c000000.wifi: failed to transmit frame -108"

If more tx packets are there, this could lead to flooding
of above print.

However, actually tx queues should be stopped immediately
when firmware leaves. This will prevent packets to get
dropped when firmware is recovering.

Add fix to stop tx queues immediately after firmware exit.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 5 +----
 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 3 +++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9894f908cc35..a50b748473cb 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1634,7 +1634,7 @@ static void ath11k_update_11d(struct work_struct *work)
 	}
 }
 
-static void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
+void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
 {
 	struct ath11k *ar;
 	struct ath11k_pdev *pdev;
@@ -1723,9 +1723,6 @@ static void ath11k_core_restart(struct work_struct *work)
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, restart_work);
 	int ret;
 
-	if (!ab->is_reset)
-		ath11k_core_pre_reconfigure_recovery(ab);
-
 	ret = ath11k_core_reconfigure_on_crash(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to reconfigure driver on crash recovery\n");
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b6246a2f2496..6c950608bb44 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1146,6 +1146,7 @@ int ath11k_core_check_smbios(struct ath11k_base *ab);
 void ath11k_core_halt(struct ath11k *ar);
 int ath11k_core_resume(struct ath11k_base *ab);
 int ath11k_core_suspend(struct ath11k_base *ab);
+void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 51de2208b789..775dfb5eb1a7 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3158,6 +3158,9 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 		case ATH11K_QMI_EVENT_SERVER_EXIT:
 			set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 			set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+
+			if (!ab->is_reset)
+				ath11k_core_pre_reconfigure_recovery(ab);
 			break;
 		case ATH11K_QMI_EVENT_REQUEST_MEM:
 			ret = ath11k_qmi_event_mem_request(qmi);

base-commit: 67552c0328709b82bbfc4b52f1e83354c2d21561
-- 
2.17.1

