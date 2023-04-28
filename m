Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891A06F13E0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjD1JLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjD1JLL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 05:11:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50692D67
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 02:11:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S6dV69011175;
        Fri, 28 Apr 2023 09:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=QWoMIqAH//VDtEReeDvbESXYd8i6Ugq9xvvfsLU7KHQ=;
 b=IhjHkKP7LCU7E7sPe33EF4B0S2bo03DdQLGKk3grgcLcP2usUE1FlkmsR3cUDmJV7F+n
 YFUhIsWTx1KMKFkjjDPQ6SZmixPIzKKH46QQZZoahSaxLFrmqbKdqOc1uF0ZiLRCuL3a
 jku03yOea16AK+OpxGG0ZqM5srMYj8yCbEDEP/P3yxOsMcwtC7Dpx3HCANpcY9xscmua
 ajVrHb9gNxnwQLK5j+5Q9DNl8jQwyPiTfh0r6zMKI8yKEd5fYuu/5J6EQQlEBMId34LE
 pwkoHexs55I05QK9O1uLUXbePs8h0xTfobnX+SwJR9BWLiygM70F9fpkAxA3mhDL8B74 LQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7wm59ryg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 09:11:05 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33S9B1b5019548;
        Fri, 28 Apr 2023 09:11:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q48nkxm2g-1;
        Fri, 28 Apr 2023 09:11:01 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33S9B07l019540;
        Fri, 28 Apr 2023 09:11:00 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 33S9B0OS019536;
        Fri, 28 Apr 2023 09:11:00 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id BB9A71100068; Fri, 28 Apr 2023 14:40:59 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Aishwarya R <quic_aisr@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: increase vdev setup timeout
Date:   Fri, 28 Apr 2023 14:40:41 +0530
Message-Id: <20230428091041.20033-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OkRi9sb1NgFYd87WoiviBHeeJQbxC2zZ
X-Proofpoint-ORIG-GUID: OkRi9sb1NgFYd87WoiviBHeeJQbxC2zZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_03,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=960 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280074
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aishwarya R <quic_aisr@quicinc.com>

When vdev start/stop happens, response from firmware is received with delay
and hence there is a timeout before VDEV can be up/down.
Also, with maximum peers connected and when vdev stop occurs, firmware
will take time to clean up all the peers and vap queues.
In such cases as well, vdev start/stop response is sent by firmware with delay.

Increase the vdev setup timeout as recommended by firmware team.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8c401145a221..d720d95eba96 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -771,6 +771,8 @@ static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
 
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "ath12k vdev setup timeout %d\n",
+		   ATH12K_VDEV_SETUP_TIMEOUT_HZ);
 	if (!wait_for_completion_timeout(&ar->vdev_setup_done,
 					 ATH12K_VDEV_SETUP_TIMEOUT_HZ))
 		return -ETIMEDOUT;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ddc3b72755c4..a8b972493fbb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2682,7 +2682,7 @@ struct ath12k_wmi_ssid_params {
 	u8 ssid[ATH12K_WMI_SSID_LEN];
 } __packed;
 
-#define ATH12K_VDEV_SETUP_TIMEOUT_HZ (1 * HZ)
+#define ATH12K_VDEV_SETUP_TIMEOUT_HZ (5 * HZ)
 
 struct wmi_vdev_start_request_cmd {
 	__le32 tlv_header;
-- 
2.17.1

