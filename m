Return-Path: <linux-wireless+bounces-1532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B148A825B49
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267DAB213C8
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F638360B0;
	Fri,  5 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vc/S5pPl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46136085
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405JZYc4013072;
	Fri, 5 Jan 2024 19:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=IUle156WBGhFQFE8AV80bpHHDTwF+4KQb3hAmHn0moY=; b=Vc
	/S5pPlWlKkGfMHrSTTAKnH5PlmoMVQOtHW1XdFbkoeYPq9rWzIFJQVhFNEJ7jAjQ
	mEU+NIbcIf7Fa+0pw2skZ/Uw8JK2cs0P5/WzwWjR5E08atkyu3zmA0fTadsKlhFv
	3p5pVmmikrJb91c6P9POba5KCPiAr7ecPdEiRBGGNYbTHbuaH3S2dxXhpBz7NK7f
	PT4zar3xfKKYsyQ2RQHqHcHK9u43/NC++k6FDCyEvjrRVEo/UiSzfCvrARlbQwrr
	qb8JcEeyt4iOaGx6T+1NrL7XtDohdhRmlYvWNWPo5LbJwgv7FT7PosW7uLGF81hY
	UVTGzd9NOLSu5L/0nGhA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve99at66r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvBOq007401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:11 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:09 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 06/12] wifi: ath12k: fix firmware assert during insmod in memory segment mode
Date: Sat, 6 Jan 2024 01:26:33 +0530
Message-ID: <20240105195639.3217739-7-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qoxd1ZXMx73OeZEEOSxmwE4deO4enn-B
X-Proofpoint-GUID: Qoxd1ZXMx73OeZEEOSxmwE4deO4enn-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401050161

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
index 609f5173e070..02b9d493d191 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -510,6 +510,33 @@ int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct ath12k_board_data *bd
 	return ret;
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
index 5ae8a931716b..271a9e2afc59 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -846,6 +846,9 @@ int ath12k_core_suspend(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
+u32 ath12k_core_get_max_station_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 9c67ed8f90bf..2ecd66e62e49 100644
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
index 71e4fc3cbba3..55fcd3c560b9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7488,8 +7488,8 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+	ar->max_num_stations = ath12k_core_get_max_station_per_radio(ab);
+	ar->max_num_peers = ath12k_core_get_max_peers_per_radio(ab);
 
 	wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 47c396189af1..a94db1eb7df8 100644
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
2.34.1


