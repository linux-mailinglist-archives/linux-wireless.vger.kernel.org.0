Return-Path: <linux-wireless+bounces-7363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB78C05B4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C432B1C20D61
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FFE1311A2;
	Wed,  8 May 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UzfHJcOE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CB130E36
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200182; cv=none; b=tnq+1IZrkg+t1teeb3cxmmHwZfQXBylSLNDoHeGgeXf/F2GK1y43WDsrnWZ7ssZkP8ZRl1RkkdxPON68dx/evbUOKSnsjBYWMzBon630qfmDRaDetKdctc89obvyMESM5QJT+5Bp9LiVxznCcB8QVXaScDZqCe63Gzfbqnox7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200182; c=relaxed/simple;
	bh=SEgXsBDAfl9OGlycxOhgsAuyuByFP3C7yY6mElz1N7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1lE4wqsSgqgLNyDQM+1OcCExlDaOJJE5Lk3Hij5S6cbJBk2lR1czxaKL+LwYRxLKBtxaRQaHxhbh9eD0nH1WDmg346PWdF0l1ZP5FHAeAOWxEYL+9A981+isB1wrPitq94SOKrCbuwI9V705irax1eNrg95AT8ANKp3+W3KtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UzfHJcOE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CUH29029258;
	Wed, 8 May 2024 20:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Zr5cFOeE4mvkBfhOCBQ8aGd+B82rCQ5bKwUjXh+d1Vg=; b=Uz
	fHJcOEJ2evC4e+GerzuyCRsxqS4a2KF668a/Ag/6rXQ+7wlJuKPjATpz/m9wgf6o
	npqm6SodSuteeJoo9mR/6mUvYjlhX8iDrgoxC9aBVSRDb+m4EYH3LiegTqMqGN1p
	UWpwdB7FrlSfhb6M1pxTxF+2wIBzfhlNgWvBs6eIDL2nRRNkbkzIz2oWvsdf/Lpj
	kKRhTaAgA2G/GDHuFWszvky0KgOMo+wVmowByAZgog/B03oiyUSTWYYojAU8u9IK
	RMjgzd5SsMENKjvVbrYMOisw6yFE14HBsisJsU/HSg9HQqqHidZZV1uBi2ShXoAv
	8NGbBNxzN5yHdxrSIsdg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09f5s1xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTNNC005479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:23 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 2/9] wifi: ath12k: configure MBSSID params in vdev create/start
Date: Wed, 8 May 2024 13:29:05 -0700
Message-ID: <20240508202912.11902-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240508202912.11902-1-quic_alokad@quicinc.com>
References: <20240508202912.11902-1-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: Xdbx1wUs_apIgwUI2OLkrRZ1eeypsfop
X-Proofpoint-ORIG-GUID: Xdbx1wUs_apIgwUI2OLkrRZ1eeypsfop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080151

Configure multiple BSSID flags and vdev_id of the transmited profile
in vdev create/start commands depending on the service bit
WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 66 ++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/wmi.c |  3 ++
 drivers/net/wireless/ath/ath12k/wmi.h |  7 +++
 3 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e840ef89ffb3..32d370c8e756 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5910,17 +5910,59 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 	return vdev_stats_id;
 }
 
-static void ath12k_mac_setup_vdev_create_arg(struct ath12k_vif *arvif,
-					     struct ath12k_wmi_vdev_create_arg *arg)
+static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_vif *arvif,
+					       u32 *flags, u32 *tx_vdev_id)
+{
+	struct ieee80211_vif *tx_vif = arvif->vif->mbssid_tx_vif;
+	struct ath12k *ar = arvif->ar;
+	struct ath12k_vif *tx_arvif;
+
+	if (!tx_vif)
+		return 0;
+
+	tx_arvif = ath12k_vif_to_arvif(tx_vif);
+
+	if (arvif->vif->bss_conf.nontransmitted) {
+		if (ar->ah->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
+			return -EINVAL;
+
+		*flags = WMI_VDEV_MBSSID_FLAGS_NON_TRANSMIT_AP;
+		*tx_vdev_id = tx_arvif->vdev_id;
+	} else if (tx_arvif == arvif) {
+		*flags = WMI_VDEV_MBSSID_FLAGS_TRANSMIT_AP;
+	} else {
+		return -EINVAL;
+	}
+
+	if (arvif->vif->bss_conf.ema_ap)
+		*flags |= WMI_VDEV_MBSSID_FLAGS_EMA_MODE;
+
+	return 0;
+}
+
+static int ath12k_mac_setup_vdev_create_arg(struct ath12k_vif *arvif,
+					    struct ath12k_wmi_vdev_create_arg *arg)
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_pdev *pdev = ar->pdev;
+	int ret;
 
 	arg->if_id = arvif->vdev_id;
 	arg->type = arvif->vdev_type;
 	arg->subtype = arvif->vdev_subtype;
 	arg->pdev_id = pdev->pdev_id;
 
+	arg->mbssid_flags = WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP;
+	arg->mbssid_tx_vdev_id = 0;
+	if (!test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		      ar->ab->wmi_ab.svc_map)) {
+		ret = ath12k_mac_setup_vdev_params_mbssid(arvif,
+							  &arg->mbssid_flags,
+							  &arg->mbssid_tx_vdev_id);
+		if (ret)
+			return ret;
+	}
+
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		arg->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
 		arg->chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
@@ -5936,6 +5978,7 @@ static void ath12k_mac_setup_vdev_create_arg(struct ath12k_vif *arvif,
 	}
 
 	arg->if_stats_id = ath12k_mac_get_vdev_stats_id(arvif);
+	return 0;
 }
 
 static u32
@@ -6117,7 +6160,12 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
 		vif->hw_queue[i] = i % (ATH12K_HW_MAX_QUEUES - 1);
 
-	ath12k_mac_setup_vdev_create_arg(arvif, &vdev_arg);
+	ret = ath12k_mac_setup_vdev_create_arg(arvif, &vdev_arg);
+	if (ret) {
+		ath12k_warn(ab, "failed to create vdev parameters %d: %d\n",
+			    arvif->vdev_id, ret);
+		goto err;
+	}
 
 	ret = ath12k_wmi_vdev_create(ar, vif->addr, &vdev_arg);
 	if (ret) {
@@ -6859,10 +6907,16 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
 
-	/* Fill the MBSSID flags to indicate AP is non MBSSID by default
-	 * Corresponding flags would be updated with MBSSID support.
-	 */
 	arg.mbssid_flags = WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP;
+	arg.mbssid_tx_vdev_id = 0;
+	if (test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		ret = ath12k_mac_setup_vdev_params_mbssid(arvif,
+							  &arg.mbssid_flags,
+							  &arg.mbssid_tx_vdev_id);
+		if (ret)
+			return ret;
+	}
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		arg.ssid = arvif->u.ap.ssid;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4bc19b47aa75..58c67ede777e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -844,6 +844,8 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	cmd->vdev_subtype = cpu_to_le32(args->subtype);
 	cmd->num_cfg_txrx_streams = cpu_to_le32(WMI_NUM_SUPPORTED_BAND_MAX);
 	cmd->pdev_id = cpu_to_le32(args->pdev_id);
+	cmd->mbssid_flags = cpu_to_le32(args->mbssid_flags);
+	cmd->mbssid_tx_vdev_id = cpu_to_le32(args->mbssid_tx_vdev_id);
 	cmd->vdev_stats_id = cpu_to_le32(args->if_stats_id);
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
@@ -1049,6 +1051,7 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 	cmd->he_ops = cpu_to_le32(arg->he_ops);
 	cmd->punct_bitmap = cpu_to_le32(arg->punct_bitmap);
 	cmd->mbssid_flags = cpu_to_le32(arg->mbssid_flags);
+	cmd->mbssid_tx_vdev_id = cpu_to_le32(arg->mbssid_tx_vdev_id);
 
 	if (!restart) {
 		if (arg->ssid) {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index e71e6c73f249..86a0ef09aa39 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2154,6 +2154,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
+	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	WMI_MAX_EXT_SERVICE = 256,
 
@@ -2729,6 +2730,8 @@ struct ath12k_wmi_vdev_create_arg {
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
 	u8 if_stats_id;
+	u32 mbssid_flags;
+	u32 mbssid_tx_vdev_id;
 };
 
 #define ATH12K_MAX_VDEV_STATS_ID	0x30
@@ -2795,6 +2798,10 @@ struct ath12k_wmi_ssid_params {
 
 enum wmi_vdev_mbssid_flags {
 	WMI_VDEV_MBSSID_FLAGS_NON_MBSSID_AP	= BIT(0),
+	WMI_VDEV_MBSSID_FLAGS_TRANSMIT_AP	= BIT(1),
+	WMI_VDEV_MBSSID_FLAGS_NON_TRANSMIT_AP	= BIT(2),
+	WMI_VDEV_MBSSID_FLAGS_EMA_MODE		= BIT(3),
+	WMI_VDEV_MBSSID_FLAGS_SCAN_MODE_VAP	= BIT(4),
 };
 
 struct wmi_vdev_start_request_cmd {
-- 
2.39.0


