Return-Path: <linux-wireless+bounces-7358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969718C05AF
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 22:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBC1B22F62
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E086130E33;
	Wed,  8 May 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nrjBHq9j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08D130AF3
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200179; cv=none; b=Dw+XAZ29rBNgrHHRRWyhAWeBhXKk3x8tHMt9IVfNRo2XSYQ5DZKIoX4cLTc8BlgCLN6S+azVMRABDaot64KupvFJYyedsfpNFbXIrEcqRalx/0Aefi/c/NndD88olQJO02G8KXEabR/28IfqcqcRw7gerAv1D3Lk2yseECOJWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200179; c=relaxed/simple;
	bh=bnOXRzWek61ZCkdu0I/+0b61erZ1eqAFcc1POuCBTJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcUIanOZr4luBsyC3WXgNoBXkGvzJgCTOqZ/pOOV/8ZzMlQX4WPylObVm6a6UE1UxKkwqBIDINQ5puos15Jzxs2mzZozJL4jjFM7d9v/kEkoiDcuEzC22HUG4rjWDzDS6i/ePw1Cg4CGAsKE44TYlEUxqCxBlMTAlesIbf/y8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nrjBHq9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CXL6h006531;
	Wed, 8 May 2024 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mgSUBBI5iqw+0S5ZZi6pXqZm59F89jdeaI8ghFmGqEc=; b=nr
	jBHq9jS7UVeB0XyFnHxbAIzlR+AzWc0JDQNXzn5bECerjcKT95mp6Yx/hDbTH8pQ
	I0nilYAiVuTdAHfgv//Zj6a08SRBFK78azlHNLZJ1Oz3GNW3InrwkqECiBG6LLjy
	4s6cicwv9dl+aUqh/vVw5ADx9IBOsOupKvfrgs/RZ3BBx3T0OtNAHGSye9aEQw/V
	7znmUHX0lcUpWlmmPbfTJ0n3t0kkuiq7Uuv6J2QfcVZWnyB+Y9svk2Y7UgcIokC9
	iaVf9J4gfFDh7ZTM0CmespC2/Z1IIL9+Pa4yPQ4MeqCNkiMtXrZWh0Y8g0027ztw
	A+r4z60ctt/Q08UXjokA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09geh25r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 20:29:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448KTPUG023174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 20:29:26 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 13:29:25 -0700
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v2 8/9] wifi: ath12k: add EMA beacon support
Date: Wed, 8 May 2024 13:29:11 -0700
Message-ID: <20240508202912.11902-9-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: 6cGmO3H_vHZc6Tp98Tsa8wBGJ_c3om7T
X-Proofpoint-ORIG-GUID: 6cGmO3H_vHZc6Tp98Tsa8wBGJ_c3om7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080151

Add new function ath12k_mac_setup_bcn_tmpl_ema() which retrieves
a list of EMA (Enhanced Multi-BSSID Advertisements) beacon templates
from mac80211 and sends all to firmware. Add support to send EMA
configurations to firmware by adding a new parameter 'ema_params' in
struct wmi_bcn_tmpl_cmd.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 55 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c | 13 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h | 18 ++++++++-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ef591b1b0c48..71da4fe0006f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1387,6 +1387,56 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_vif *arvif, struct sk_buff *b
 	}
 }
 
+static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_vif *arvif)
+{
+	struct ieee80211_bss_conf *bss_conf = &arvif->vif->bss_conf;
+	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
+	struct ieee80211_ema_beacons *beacons;
+	struct ath12k_vif *tx_arvif;
+	bool nontx_profile_found = false;
+	int ret = 0;
+	u8 i;
+
+	tx_arvif = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
+							 tx_arvif->vif, 0);
+	if (!beacons || !beacons->cnt) {
+		ath12k_warn(arvif->ar->ab,
+			    "failed to get ema beacon templates from mac80211\n");
+		return -EPERM;
+	}
+
+	if (tx_arvif == arvif)
+		ath12k_mac_set_arvif_ies(arvif, beacons->bcn[0].skb, 0, NULL);
+
+	for (i = 0; i < beacons->cnt; i++) {
+		if (tx_arvif != arvif && !nontx_profile_found)
+			ath12k_mac_set_arvif_ies(arvif, beacons->bcn[i].skb,
+						 bss_conf->bssid_index,
+						 &nontx_profile_found);
+
+		ema_args.bcn_cnt = beacons->cnt;
+		ema_args.bcn_index = i;
+		ret = ath12k_wmi_bcn_tmpl(tx_arvif->ar, tx_arvif->vdev_id,
+					  &beacons->bcn[i].offs,
+					  beacons->bcn[i].skb, &ema_args);
+		if (ret) {
+			ath12k_warn(tx_arvif->ar->ab,
+				    "failed to set ema beacon template id %i error %d\n",
+				    i, ret);
+			break;
+		}
+	}
+
+	if (tx_arvif != arvif && !nontx_profile_found)
+		ath12k_warn(arvif->ar->ab,
+			    "nontransmitted bssid index %u not found in beacon template\n",
+			    bss_conf->bssid_index);
+
+	ieee80211_beacon_free_ema_list(beacons);
+	return ret;
+}
+
 static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 {
 	struct ath12k_vif *tx_arvif = arvif;
@@ -1405,6 +1455,9 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 		tx_arvif = ath12k_vif_to_arvif(vif->mbssid_tx_vif);
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
+
+		if (vif->bss_conf.ema_ap)
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
 	}
 
 	bcn = ieee80211_beacon_get_template(ath12k_ar_to_hw(tx_arvif->ar), tx_arvif->vif,
@@ -1448,7 +1501,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 		}
 	}
 
-	ret = ath12k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
+	ret = ath12k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, NULL);
 
 	if (ret)
 		ath12k_warn(ab, "failed to submit beacon template command: %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b328005f995f..b5f0d57e6639 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1788,13 +1788,15 @@ int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
 
 int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn,
+			struct ath12k_wmi_bcn_tmpl_ema_arg *ema_args)
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
 	struct ath12k_wmi_bcn_prb_info_params *bcn_prb_info;
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
+	u32 ema_params = 0;
 	void *ptr;
 	int ret, len;
 	size_t aligned_len = roundup(bcn->len, 4);
@@ -1814,6 +1816,15 @@ int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 	cmd->ext_csa_switch_count_offset = cpu_to_le32(offs->cntdwn_counter_offs[1]);
 	cmd->buf_len = cpu_to_le32(bcn->len);
 	cmd->mbssid_ie_offset = cpu_to_le32(offs->mbssid_off);
+	if (ema_args) {
+		u32p_replace_bits(&ema_params, ema_args->bcn_cnt, WMI_EMA_BEACON_CNT);
+		u32p_replace_bits(&ema_params, ema_args->bcn_index, WMI_EMA_BEACON_IDX);
+		if (ema_args->bcn_index == 0)
+			u32p_replace_bits(&ema_params, 1, WMI_EMA_BEACON_FIRST);
+		if (ema_args->bcn_index + 1 == ema_args->bcn_cnt)
+			u32p_replace_bits(&ema_params, 1, WMI_EMA_BEACON_LAST);
+		cmd->ema_params = cpu_to_le32(ema_params);
+	}
 
 	ptr = skb->data + sizeof(*cmd);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 9b0166a5a575..7f83c4583919 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3533,6 +3533,16 @@ struct ath12k_wmi_p2p_noa_info {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_EMA_BEACON_CNT      GENMASK(7, 0)
+#define WMI_EMA_BEACON_IDX      GENMASK(15, 8)
+#define WMI_EMA_BEACON_FIRST    GENMASK(23, 16)
+#define WMI_EMA_BEACON_LAST     GENMASK(31, 24)
+
+struct ath12k_wmi_bcn_tmpl_ema_arg {
+	u8 bcn_cnt;
+	u8 bcn_index;
+};
+
 struct wmi_bcn_tmpl_cmd {
 	__le32 tlv_header;
 	__le32 vdev_id;
@@ -3543,6 +3553,11 @@ struct wmi_bcn_tmpl_cmd {
 	__le32 csa_event_bitmap;
 	__le32 mbssid_ie_offset;
 	__le32 esp_ie_offset;
+	__le32 csc_switch_count_offset;
+	__le32 csc_event_bitmap;
+	__le32 mu_edca_ie_offset;
+	__le32 feature_enable_bitmap;
+	__le32 ema_params;
 } __packed;
 
 struct wmi_p2p_go_set_beacon_ie_cmd {
@@ -4900,7 +4915,8 @@ int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
 			     const u8 *p2p_ie);
 int ath12k_wmi_bcn_tmpl(struct ath12k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn,
+			struct ath12k_wmi_bcn_tmpl_ema_arg *ema_args);
 int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id);
 int ath12k_wmi_vdev_up(struct ath12k *ar, struct ath12k_wmi_vdev_up_params *params);
 int ath12k_wmi_vdev_stop(struct ath12k *ar, u8 vdev_id);
-- 
2.39.0


