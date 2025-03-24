Return-Path: <linux-wireless+bounces-20731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C437EA6D441
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0743516A13F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC718DB34;
	Mon, 24 Mar 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rmdg40zD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E419CCEC
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797560; cv=none; b=XNmDOT5m8drH7cQsYjvYo/vHE+1KDT7DP5D+dXmBw818sVLgbZHQ3HtQ26/HDV0a19oNSer061dbxjAPu02blrReefmyfyJgOWBCd8tgMOtpGcD2+wZIJYdh2xTSR/pF7u9osYNLW7ufZLO1UH6M6BIFEF0eszV6Hs0CIAOSk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797560; c=relaxed/simple;
	bh=4M3mWu8cnmuIpFxGF95kuE1XkNSTNJjDYOeNPteQUkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COVAMDZ3odjI1cBqq+ya2cxmT8aDULLV3XbkbQ+Xcl9dlONDhM5Lxfl9RGKnCp91pZcD9NvNGrHQZ9CjnYdTTR7ctrq2C9Ay+BW3dN/8rYhQTAARho7YPcami7ATLr6/FipnUFmBWaDowI9QyXXYP0a6sR+jEaTwXmH7pzkuTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rmdg40zD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6FYZn009518;
	Mon, 24 Mar 2025 06:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xg241lM8YaTT7CAIQTBbjDM88x6w+YHRefcezHp0EP4=; b=Rmdg40zDEH7kB4QF
	hZnYHxFivg1frr+vWaVCTfleUlu03NlnpQ7Q5txZlU3QCK2Yh+qoXxZ+2ARM8JJi
	vSR9BS+FPW4S/zqc1arh2uV6PNqQUEXCtM6P+azU/TfGa6UT/j/8SFO/GLfRtH/g
	t+dyjiDX0OvskzPEwR4vDlSF5gXhdAiiZ8KNzT9ofcVB/9WCLI6L8PAigizoweqv
	bcHIRSWWEb9BWEu5/20VcqvVGavjVDNiehOkir33daY7nA//TJbASNGSQyO/1TL8
	iDdQzfioj7oYa1mUsUZ6vjXqAiQRIetIATnEK3jvXWmKB55PCbw9k/tdT31k3CJ3
	bMuJyA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmt039ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O6Prqv029641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:53 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 23:25:52 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v11 09/10] wifi: ath12k: Move to NO_VIRTUAL monitor
Date: Mon, 24 Mar 2025 11:55:17 +0530
Message-ID: <20250324062518.2752822-10-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
References: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 8w8B0tLg0Nbe9y3s7VKaAR2SoYv_5D_6
X-Proofpoint-ORIG-GUID: 8w8B0tLg0Nbe9y3s7VKaAR2SoYv_5D_6
X-Authority-Analysis: v=2.4 cv=aqGyCTZV c=1 sm=1 tr=0 ts=67e0faf2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=GBZU6RWZVqhb0NBJr5AA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240046

Currently, VIRTUAL monitor handling is present. In multi radio model,
VIRTUAL monitor is not suitable since each radio needs a separate VIF and
channel context. Therefore, switch to NO_VIRTUAL_MONITOR feature. Remove
the monitor_conf_enabled flag and mac_op_config() handler as they are not
need for the NO_VIRTUAL_MONITOR feature. In NO_VIRTUAL_MONITOR handling,
each interface creation/deletion triggers the mac_op_add_interface() /
mac_op_remove_interface() callback. Consequently, remove the monitor vdev
create/delete/start/stop from the other vdev type handlers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 -
 drivers/net/wireless/ath/ath12k/mac.c  | 126 ++-----------------------
 2 files changed, 7 insertions(+), 120 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3f92565ea4e2..994d3d0ce9ce 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -738,7 +738,6 @@ struct ath12k {
 #endif
 
 	bool dfs_block_radar_events;
-	bool monitor_conf_enabled;
 	bool monitor_vdev_created;
 	bool monitor_started;
 	int monitor_vdev_id;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c659f1d83b22..d1bcf7fd6113 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1245,61 +1245,6 @@ static int ath12k_mac_monitor_vdev_stop(struct ath12k *ar)
 	return ret;
 }
 
-static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
-{
-	struct ath12k_pdev *pdev = ar->pdev;
-	struct ath12k_wmi_vdev_create_arg arg = {};
-	int bit, ret;
-	u8 tmp_addr[6];
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	if (ar->monitor_vdev_created)
-		return 0;
-
-	if (ar->ab->free_vdev_map == 0) {
-		ath12k_warn(ar->ab, "failed to find free vdev id for monitor vdev\n");
-		return -ENOMEM;
-	}
-
-	bit = __ffs64(ar->ab->free_vdev_map);
-
-	ar->monitor_vdev_id = bit;
-
-	arg.if_id = ar->monitor_vdev_id;
-	arg.type = WMI_VDEV_TYPE_MONITOR;
-	arg.subtype = WMI_VDEV_SUBTYPE_NONE;
-	arg.pdev_id = pdev->pdev_id;
-	arg.if_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
-		arg.chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
-		arg.chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
-	}
-
-	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
-		arg.chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
-		arg.chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
-	}
-
-	ret = ath12k_wmi_vdev_create(ar, tmp_addr, &arg);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to request monitor vdev %i creation: %d\n",
-			    ar->monitor_vdev_id, ret);
-		ar->monitor_vdev_id = -1;
-		return ret;
-	}
-
-	ar->allocated_vdev_map |= 1LL << ar->monitor_vdev_id;
-	ar->ab->free_vdev_map &= ~(1LL << ar->monitor_vdev_id);
-	ar->num_created_vdevs++;
-	ar->monitor_vdev_created = true;
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor vdev %d created\n",
-		   ar->monitor_vdev_id);
-
-	return 0;
-}
-
 static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
 {
 	int ret;
@@ -1358,7 +1303,6 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 					    &arg.chanctx_conf->def);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start monitor vdev: %d\n", ret);
-		ath12k_mac_monitor_vdev_delete(ar);
 		return ret;
 	}
 
@@ -1433,58 +1377,9 @@ int ath12k_mac_vdev_stop(struct ath12k_link_vif *arvif)
 	return ret;
 }
 
-static int ath12k_mac_config(struct ath12k *ar, u32 changed)
-{
-	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
-	struct ieee80211_conf *conf = &hw->conf;
-	int ret = 0;
-
-	lockdep_assert_wiphy(hw->wiphy);
-
-	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		ar->monitor_conf_enabled = conf->flags & IEEE80211_CONF_MONITOR;
-		if (ar->monitor_conf_enabled) {
-			if (ar->monitor_vdev_created)
-				return ret;
-			ret = ath12k_mac_monitor_vdev_create(ar);
-			if (ret)
-				return ret;
-			ret = ath12k_mac_monitor_start(ar);
-			if (ret)
-				goto err_mon_del;
-		} else {
-			if (!ar->monitor_vdev_created)
-				return ret;
-			ret = ath12k_mac_monitor_stop(ar);
-			if (ret)
-				return ret;
-			ath12k_mac_monitor_vdev_delete(ar);
-		}
-	}
-
-	return ret;
-
-err_mon_del:
-	ath12k_mac_monitor_vdev_delete(ar);
-	return ret;
-}
-
 static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar;
-	int ret;
-
-	lockdep_assert_wiphy(hw->wiphy);
-
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	ret = ath12k_mac_config(ar, changed);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to update config pdev idx %d: %d\n",
-			    ar->pdev_idx, ret);
-
-	return ret;
+	return 0;
 }
 
 static int ath12k_mac_setup_bcn_p2p_ie(struct ath12k_link_vif *arvif,
@@ -8396,8 +8291,6 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	}
 
 	ath12k_dp_vdev_tx_attach(ar, arvif);
-	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
-		ath12k_mac_monitor_vdev_create(ar);
 
 	return ret;
 
@@ -8699,8 +8592,6 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ar->monitor_vdev_id = -1;
 		ar->monitor_vdev_created = false;
-	} else if (ar->monitor_vdev_created && !ar->monitor_started) {
-		ret = ath12k_mac_monitor_vdev_delete(ar);
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
@@ -9392,8 +9283,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		arvif = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
 					  ahvif->link[link_id]);
 
-		if (vif->type == NL80211_IFTYPE_MONITOR)
+		if (vif->type == NL80211_IFTYPE_MONITOR) {
 			monitor_vif = true;
+			continue;
+		}
 
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
@@ -9627,8 +9520,10 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_start(ar);
-		if (ret)
+		if (ret) {
+			ath12k_mac_monitor_vdev_delete(ar);
 			goto out;
+		}
 
 		arvif->is_started = true;
 		goto out;
@@ -9642,9 +9537,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
-		ath12k_mac_monitor_start(ar);
-
 	arvif->is_started = true;
 
 	/* TODO: Setup ps and cts/rts protection */
@@ -9706,10 +9598,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 	arvif->is_started = false;
-
-	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
-	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
-		ath12k_mac_monitor_stop(ar);
 }
 
 static int
-- 
2.34.1


