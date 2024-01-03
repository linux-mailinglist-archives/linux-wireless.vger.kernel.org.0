Return-Path: <linux-wireless+bounces-1426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D004822874
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A23C1C22F9B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903518028;
	Wed,  3 Jan 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCd6zgfS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD718032
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4034D9wT009728;
	Wed, 3 Jan 2024 06:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fBY17Cu5z5qDLwN7Qqr4uvanMV13dDgee8uFsAHCBFs=; b=fC
	d6zgfSMAfmsWSmrDgH9NW1a5Jq7ELrT3JASaChoi7r0jdMOvavtqc+9gImnpHSIv
	3fjFr7WkYKWCeEEAzMkPgfYtRX2/x+SpdPA+swi1sXxHWeXgA5JovCzHJz4BaqTt
	+Wvrk6A2KbdxlU7NTxVDqGzKCtdg6usH7fGtMu0+daE2BELOt9SFnxaqH0hsjEGQ
	2sDkT9g3DBARBG+D6YbmwOA7PdQm8PBwMXzZ89VJbLPGZ7M67cw/keMYPdRPcyKa
	UJgoFYvn73hknT7WkgrOBErB1nHIdOQS8QKf3J1L2kDzGUfqGLp139vTbyFa1ADw
	vY8SJjUUT87k8VJ6/GPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcum10w6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:37:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036bqnn017933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:37:52 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:37:50 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 02/10] wifi: ath12k: Refactor mac callback of bss info changed
Date: Wed, 3 Jan 2024 12:07:23 +0530
Message-ID: <20240103063731.3356060-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
References: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ORkNTyEAlJGa1hG-APoLVBn8ZR6-kJdw
X-Proofpoint-GUID: ORkNTyEAlJGa1hG-APoLVBn8ZR6-kJdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=815 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030053

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback bss_info_change(). This way, the
callback can be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 43 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7b02a107ab38..bbd57b73fa63 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2279,12 +2279,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 					 ath12k_smps_map[smps]);
 }
 
-static void ath12k_bss_assoc(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif,
+static void ath12k_bss_assoc(struct ath12k *ar,
+			     struct ath12k_vif *arvif,
 			     struct ieee80211_bss_conf *bss_conf)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_vif *vif = arvif->vif;
 	struct ath12k_wmi_peer_assoc_arg peer_arg;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_peer *peer;
@@ -2374,11 +2373,9 @@ static void ath12k_bss_assoc(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 }
 
-static void ath12k_bss_disassoc(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif)
+static void ath12k_bss_disassoc(struct ath12k *ar,
+				struct ath12k_vif *arvif)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2504,13 +2501,12 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	return ret;
 }
 
-static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
-					   struct ieee80211_vif *vif,
-					   struct ieee80211_bss_conf *info,
-					   u64 changed)
+static void ath12k_mac_bss_info_changed(struct ath12k *ar,
+					struct ath12k_vif *arvif,
+					struct ieee80211_bss_conf *info,
+					u64 changed)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_vif *vif = arvif->vif;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -2523,7 +2519,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	u8 rateidx;
 	u32 rate;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
 		arvif->beacon_interval = info->beacon_int;
@@ -2679,9 +2675,9 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc)
-			ath12k_bss_assoc(hw, vif, info);
+			ath12k_bss_assoc(ar, arvif, info);
 		else
-			ath12k_bss_disassoc(hw, vif);
+			ath12k_bss_disassoc(ar, arvif);
 	}
 
 	if (changed & BSS_CHANGED_TXPOWER) {
@@ -2783,6 +2779,19 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_EHT_PUNCTURING)
 		arvif->punct_bitmap = info->eht_puncturing;
+}
+
+static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_bss_conf *info,
+					   u64 changed)
+{
+	struct ath12k *ar = hw->priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+
+	mutex_lock(&ar->conf_mutex);
+
+	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.34.1


