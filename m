Return-Path: <linux-wireless+bounces-11925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80595E69E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 04:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D22B20C05
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 02:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428B4C6C;
	Mon, 26 Aug 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iN7FPDo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48533C8
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638395; cv=none; b=QWAyNBChJdKvvJyJQLaG6a5q9ACTYqEbqz2UdRvcMJ/e4AmpACr7tqJZs/7hynhCz6jFTH5Nh5wCT+A67DkEGJO0TlqxtUE/sPBe07oaFyeSkLFED+6RoiuSiHCK5NfMDsaAzJhJ21XZETkHrbynoiH+ZCjJHaZ8xGORGTR//Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638395; c=relaxed/simple;
	bh=VmnfavPBVF6PHBxVBlmP/UJ6gUA99K4QGcpD/ezU3TI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZoTxQ6o/lUSFYVFD9FwwmbIcM8m4pWGUbBE7z8gINQDvkekqzqJthg3SsXAF0wbzFaoXvVEnGcCcdhXyJTe/VeEsPJ8H9nsiR5i5AAy5NnuXWRnhqC7nQ0cnANyb4ejOTh6wYGyex5cu3N3cwx8OOyHKuTaNOof2V7sgXeKZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iN7FPDo+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PNkugu004858;
	Mon, 26 Aug 2024 01:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ejUiGfGXLBo3+0XPv6rD4bCCGasyHGZc97m2ozGVeV4=; b=iN7FPDo+sB5ilMmR
	EKbyAGJvPjnp/PtewDIQ73w2zwtipdqS7svg06AWYDvLPw4NJFeWYUQi4dO8eqxl
	8XEnPJ5+8oJXDINaafScyFpxnkmjpE8XP81eFTifGNimgjw+yBmadMRNNrpfrBTt
	U9ejXZxl9E3xrAtha6s2gSeZzwr5+PatqOflHejYeFVCtU2aBS4Hx4qfpogCY1WI
	X1GFaOE6f375hooAGywOcFZ3WgKXEUw5yHVLNFjgXUrCqdrv2hufQNkq46UQWGfi
	/qeoV+wuUZpDdUsh4ixzi2DQ//1TnDhHtMPQRUzt00UPT/I60gfAueN4TYv8j05+
	X1rN4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179ant5yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q1o7aI022347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:07 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 Aug
 2024 18:50:05 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 3/3] wifi: ath11k: fix leaking station RX/TX stats in reset scenario
Date: Mon, 26 Aug 2024 09:49:42 +0800
Message-ID: <20240826014942.87783-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826014942.87783-1-quic_bqiang@quicinc.com>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2xM3e83qnwQoIzvfZC77YJ-w2TJ1nXiE
X-Proofpoint-ORIG-GUID: 2xM3e83qnwQoIzvfZC77YJ-w2TJ1nXiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_20,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260012

Currently ath12k_sta::rx_stats/tx_stats would only get freed when the station
transit from NONE to NOTEXIST state within ath11k_mac_op_sta_state(). However
in reset scenario, there is no chance for it to go through such transition.
Further, after reset, when a new connection to AP starts, ath12k_sta is zerod
in NOTEXIST to NONE transition, making rx_stats/tx_stats leaked:

Kmemleak reports:
unreferenced object 0xffff9a3cd0a23400 (size 1024):
  backtrace (crc 21ee4c52):
    kmalloc_trace_noprof+0x2ba/0x360
    ath11k_mac_op_sta_state+0x1b6/0xca0 [ath11k]
    drv_sta_state+0x11e/0x9c0 [mac80211]
    sta_info_insert_rcu+0x469/0x880 [mac80211]
    sta_info_insert+0x10/0x80 [mac80211]
    ieee80211_prep_connection+0x295/0x950 [mac80211]
    ieee80211_mgd_auth+0x230/0x5a0 [mac80211]
    cfg80211_mlme_auth+0xeb/0x2a0 [cfg80211]

Add a new function which frees them, and call it during reset to fix this issue.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 27 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/mac.h  |  3 ++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 03187df26000..586217de9581 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1972,6 +1972,7 @@ void ath11k_core_halt(struct ath11k *ar)
 	ar->allocated_vdev_map = 0;
 
 	ath11k_mac_scan_finish(ar);
+	ath11k_mac_station_cleanup_all(ar);
 	ath11k_mac_peer_cleanup_all(ar);
 	cancel_delayed_work_sync(&ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f21d37cefb65..a02fd07f8f1c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9512,6 +9512,15 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	return ret;
 }
 
+static void ath11k_mac_station_free_stats(struct ath11k_sta *arsta)
+{
+	kfree(arsta->tx_stats);
+	arsta->tx_stats = NULL;
+
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
+}
+
 static int ath11k_mac_station_remove(struct ath11k *ar,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta)
@@ -9545,15 +9554,23 @@ static int ath11k_mac_station_remove(struct ath11k *ar,
 
 	ath11k_mac_dec_num_stations(arvif, sta);
 
-	kfree(arsta->tx_stats);
-	arsta->tx_stats = NULL;
-
-	kfree(arsta->rx_stats);
-	arsta->rx_stats = NULL;
+	ath11k_mac_station_free_stats(arsta);
 
 	return ret;
 }
 
+static void ath11k_mac_station_cleanup(void *data, struct ieee80211_sta *sta)
+{
+	ath11k_mac_station_free_stats(ath11k_sta_to_arsta(sta));
+}
+
+void ath11k_mac_station_cleanup_all(struct ath11k *ar)
+{
+	ieee80211_iterate_stations_atomic(ar->hw,
+					  ath11k_mac_station_cleanup,
+					  NULL);
+}
+
 static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index f5800fbecff8..17d0bbfc52bf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_MAC_H
@@ -179,4 +179,5 @@ int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_chanctx_conf *ctx);
+void ath11k_mac_station_cleanup_all(struct ath11k *ar);
 #endif
-- 
2.25.1


