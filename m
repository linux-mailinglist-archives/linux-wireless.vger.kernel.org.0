Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E57DC270
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjJ3W16 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjJ3W15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:27:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB759FF
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:52 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMQgW2021759;
        Mon, 30 Oct 2023 22:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iEXxi5mX/9Y1qssv08/LH5WYun4CG7g4HwEvGehzNH8=;
 b=SyHK8x5klD/wvo3HzjThE/ok0ktZ0x5zvw1CVftfIxf7SJYIovOt+xiVgZ2GSNQCHfzC
 /0IbaEQIHs+NfMdjZsIItctqPdqNbJwpamUc3W8BZgsWGUrD6fxW0Rof68hMBrENXWbY
 +Z4v5tWhIHp+y6Qlg0jIm4vnBE6iq2BQyfuJYdlQhYaf6IzOmF4kuSP/7Y/Li3E2nPOf
 9fzT0ooOBdsHRkoiUdOZ9VOROoiacsipuPzPNutZz3he7M5u8NC/agGJbV1tSipAteKt
 SUuZl482uZmcZHyL9Bzu6UbMSv1TlBBYbhAXgBwj3zK5bJSn8qNQDY6BPxwkfCEJWpE7 qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0sw7w3v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRmIo032143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:48 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:46 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 07/13] wifi: ath12k: fix firmware assert during insmod in memory segment mode
Date:   Tue, 31 Oct 2023 03:56:54 +0530
Message-ID: <20231030222700.18914-8-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E9kV9UZpfPqnnh6aBGhQXTZCjiEz13KR
X-Proofpoint-GUID: E9kV9UZpfPqnnh6aBGhQXTZCjiEz13KR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

In segment memory mode, firmware allocates memory segments of size
2 MB. This 2 MB memory is used by firmware for the number of peers.
This number of peer is sent from host to firmware during WMI init
command. For single-phy the number of peers sent is
TARGET_NUM_PEERS_SINGLE = 529 (512 + 17). While for split-phy number
of peers sent to firmware is TARGET_NUM_PEERS_DBS = 2 *(512 + 17) =
1058. With this 1058 number of peers firmware is unable to allocate
memory in 2 MB segment and firmware crash is observed.

Hence, fix this firmware crash by reducing the number of stations
TARGET_NUM_STATIONS for split-phy.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 27 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  3 +++
 drivers/net/wireless/ath/ath12k/hw.h   | 23 ++++++++++++++++------
 drivers/net/wireless/ath/ath12k/mac.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/wmi.c  | 15 +++-----------
 5 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b936760b5..fa90c94a9 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -387,6 +387,33 @@ int ath12k_core_fetch_bdf(struct ath12k_base *ab, struct ath12k_board_data *bd)
 	return 0;
 }
 
+u32 ath12k_core_get_max_station_per_radio(struct ath12k_base *ab)
+{
+	if (ab->num_radios == 2)
+		return TARGET_NUM_STATIONS_DBS;
+	else if (ab->num_radios == 3)
+		return TARGET_NUM_PEERS_PDEV_DBS_SBS;
+	return TARGET_NUM_STATIONS_SINGLE;
+}
+
+u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab)
+{
+	if (ab->num_radios == 2)
+		return TARGET_NUM_PEERS_PDEV_DBS;
+	else if (ab->num_radios == 3)
+		return TARGET_NUM_PEERS_PDEV_DBS_SBS;
+	return TARGET_NUM_PEERS_PDEV_SINGLE;
+}
+
+u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
+{
+	if (ab->num_radios == 2)
+		return TARGET_NUM_TIDS(DBS);
+	else if (ab->num_radios == 3)
+		return TARGET_NUM_TIDS(DBS_SBS);
+	return TARGET_NUM_TIDS(SINGLE);
+}
+
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 68c42ca44..8f5ead445 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -817,6 +817,9 @@ int ath12k_core_suspend(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
+u32 ath12k_core_get_max_station_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 2fb50941c..7b868ae80 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -17,19 +17,30 @@
 /* Num VDEVS per radio */
 #define TARGET_NUM_VDEVS	(16 + 1)
 
-#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV_SINGLE	(TARGET_NUM_STATIONS_SINGLE + \
+					 TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV_DBS	(TARGET_NUM_STATIONS_DBS + \
+					 TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV_DBS_SBS	(TARGET_NUM_STATIONS_DBS_SBS + \
+					 TARGET_NUM_VDEVS)
 
 /* Num of peers for Single Radio mode */
-#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV_SINGLE)
 
 /* Num of peers for DBS */
-#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV_DBS)
 
 /* Num of peers for DBS_SBS */
-#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV_DBS_SBS)
 
-/* Max num of stations (per radio) */
-#define TARGET_NUM_STATIONS	512
+/* Max num of stations for Single Radio mode */
+#define TARGET_NUM_STATIONS_SINGLE	512
+
+/* Max num of stations for DBS */
+#define TARGET_NUM_STATIONS_DBS		128
+
+/* Max num of stations for DBS_SBS */
+#define TARGET_NUM_STATIONS_DBS_SBS	128
 
 #define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
 #define TARGET_NUM_PEER_KEYS	2
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 594aa18e7..1170801f2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7471,8 +7471,8 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+	ar->max_num_stations = ath12k_core_get_max_station_per_radio(ab);
+	ar->max_num_peers = ath12k_core_get_max_peers_per_radio(ab);
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 460f38a22..7d294d1b2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -179,18 +179,9 @@ void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config)
 {
 	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
-
-	if (ab->num_radios == 2) {
-		config->num_peers = TARGET_NUM_PEERS(DBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS);
-	} else if (ab->num_radios == 3) {
-		config->num_peers = TARGET_NUM_PEERS(DBS_SBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS_SBS);
-	} else {
-		/* Control should not reach here */
-		config->num_peers = TARGET_NUM_PEERS(SINGLE);
-		config->num_tids = TARGET_NUM_TIDS(SINGLE);
-	}
+	config->num_peers = ab->num_radios *
+		ath12k_core_get_max_peers_per_radio(ab);
+	config->num_tids = ath12k_core_get_max_num_tids(ab);
 	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
 	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
 	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
-- 
2.17.1

