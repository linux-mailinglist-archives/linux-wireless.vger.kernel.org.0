Return-Path: <linux-wireless+bounces-2640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C283FEBD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5273D1F23791
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA54F600;
	Mon, 29 Jan 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WZoRXXYx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C34F1FC
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511485; cv=none; b=txcHbHcvQNP5M2ZX4A52UzD5rt0I0CQAZwpKvBAIm0IxJjJVG5AVl13Ke2kKjZs36qwOjPifJJwF1b6MiWRaCku2pT7hOpR0y84laWcMbHiPOg0+WECZGbMgL9mjYTCk/SXul9XCKXZuWK0kNnT0Ag0+Jz7hps6EKN60nVFVwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511485; c=relaxed/simple;
	bh=9TV2x6KZRGgvbhglm4JXKXPH1iJBvPuhQjU7Z0qlxXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQw4qoj9IHWhhaVX2qLpCbsS+wafQbi6RmEAgSGdN+R5Ppqc16pRqliysWGT9qsrMSNNXSBMfC11Qf7Zy+h6LKUe5M8v1MegtWfgffLHGMKzTR67oWI6uQNOdDeRdrQHCB35tFg5Cam1fyP8sWBnhElAD4vc4zVEYjyujcOJ55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WZoRXXYx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5LeeS026153;
	Mon, 29 Jan 2024 06:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cdlYapi8z5SYoiZhJgbTP+GCBNQPdiFv6uuqra67sCI=; b=WZ
	oRXXYxwk8ubxuzi0ocLl+xLDaIJ2ndDakHBHE884KjSbVgv9xKA9wFtIyKBli9kF
	8jiS1T1dCAzQ/TH3ZBAoRl6F8tkJTu+NBdHhMEj90s7NyzRctZzypw0jX+yocknb
	CxVHpd+kTuyZwiHxKa5YSLQhWQTdljkdRhqeV9qucoRCTt8AqtzV7QrrAkW6Ouhe
	RMRuyqDHuBjQtUSEen2jIwB1oL7RYvg6hukfpY1HdYeX/sUO/CSfZHa6/CiiJbS5
	DBJU3ejwUvaea3s8eyg9GdhWmzqnl0xcy+4NFgEJF6FJ5sp5VLqPQ7i7EPQ62dj5
	uXzfMEjk6wy9DcOVc+qA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrubb0qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vx2m008881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:59 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:57 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 06/13] wifi: ath12k: fix firmware assert during insmod in memory segment mode
Date: Mon, 29 Jan 2024 12:27:17 +0530
Message-ID: <20240129065724.2310207-7-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2leM3jYUp933UhiLSxb0c99d4oX93Z1u
X-Proofpoint-GUID: 2leM3jYUp933UhiLSxb0c99d4oX93Z1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

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
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

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
index 634a9ddc2fe5..7f0b395f1296 100644
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
index fc906d7acd42..68b4031ac484 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -869,6 +869,9 @@ int ath12k_core_suspend(struct ath12k_base *ab);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
+u32 ath12k_core_get_max_station_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
+u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 44ba3a50e075..efa3411dc63d 100644
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
index 672c9d347097..046bb466a391 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7624,8 +7624,8 @@ static int ath12k_mac_setup_register(struct ath12k *ar,
 	ath12k_mac_setup_ht_vht_cap(ar, cap, ht_cap);
 	ath12k_mac_setup_sband_iftype_data(ar, cap);
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+	ar->max_num_stations = ath12k_core_get_max_station_per_radio(ar->ab);
+	ar->max_num_peers = ath12k_core_get_max_peers_per_radio(ar->ab);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 276351d68efb..7fc269eb4a0c 100644
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


