Return-Path: <linux-wireless+bounces-3775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6E85A1B9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B121C213C6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2132AD39;
	Mon, 19 Feb 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZG/aeVeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE129424
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341278; cv=none; b=HJtC7L1Le8VrCMcuSArfhUZ+rGn9Nb1x8s9I5P8OxBg4gDb6ZKQMcFo/DeYv1LTGnEI55dUD9oCqYhGR4f1oKmmCmgKxRq8Lg1jzR7zCcRsmbhlADBv+keTcrPyt9Jd/hPdxSIAI+tGrOMMiNJkDNEz/N0mFjkOiHgkGfLG5xAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341278; c=relaxed/simple;
	bh=TImiDi0k8rq0ubIoehI14s2PxV9kt7lCVXk0uh4tNkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mZmSWSIdcOMQWx9QWp9/WjMgYTKcqCzaDITwgODRFGyzGWvaNICxZDabLYvb3KYhsLhcSAPqcMTRaR4TxxajqV/eYUDHuXup08avtF5ocuXoSZB38RHDsdN7SagpHNASSrKmlL/zhYyKjYOm/xWD4RenqENOMbeaVUyoFh4a/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZG/aeVeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J9rijF009221;
	Mon, 19 Feb 2024 11:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=iwsKdLI
	vwUspJYp+631LHoK3VAZn1d3zg//BuNqcXZM=; b=ZG/aeVeHjn1CKACVU/I83tx
	uFFAQUw3aFKChHOD+rWYGAHjh4lZ3h5rbgP04EGc8M+84f7WSryecpPpVNepJQk4
	lmrrYTc1QrUP8SFjwbkhPQtoadmwmBRZt1GuP3qja9Zri8GkFzXrL9aQtUHcjLQw
	JT4I3o0kSeSkfaDL9oIkjFnm+9lPtXGMaYI63/WWcQVrIQ74FTSC4rlmzryFfmBa
	LE3MoyxwFOLOG6If3pdZg1ZVCTAtKWqYqsRUVDxNIs39K++e2lDrLWixylwvdFtb
	g/wbMw6nwuXQaIA8eF5IJK7zo1vMgJPD7b4SIUBCBFb/4WdWehA7oroPuU/saCQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc4qx05ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 11:14:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41JBET5d015546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 11:14:29 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 03:14:27 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath12k: report signal for iw dev xxx station dump
Date: Mon, 19 Feb 2024 19:14:17 +0800
Message-ID: <20240219111417.1185-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.37.3.windows.1
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
X-Proofpoint-GUID: OyogeICbCOkp_z-byzEq_b_YziCascYH
X-Proofpoint-ORIG-GUID: OyogeICbCOkp_z-byzEq_b_YziCascYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190084

The signal of "iw dev xxx station dump" always show 0 dBm. This is because
currently signal is only set in ath12k_mgmt_rx_event function, and not set
for rx data packet. So, change to get signal from firmware and report to
mac80211.

After that, "iw dev xxx station dump" show the correct signal such as:
signal: -50 dBm
signal: -49 dBm

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/hw.c   |   6 ++
 drivers/net/wireless/ath/ath12k/hw.h   |   2 +
 drivers/net/wireless/ath/ath12k/mac.c  |  45 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c  | 129 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  |  48 +++++++++
 6 files changed, 229 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2c8e23ab894f..ce45faa31cd2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -426,6 +426,7 @@ struct ath12k_sta {
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
 	u32 bw_prev;
 	u32 peer_nss;
+	s8 rssi_beacon;
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0b17dfd47856..521ad3ac2739 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -920,6 +920,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 
 		.supports_sta_ps = false,
+
+		.supports_rssi_stats = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -993,6 +995,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = 0,
 
 		.supports_sta_ps = true,
+
+		.supports_rssi_stats = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1061,6 +1065,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
 
 		.supports_sta_ps = false,
+
+		.supports_rssi_stats = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 87965980b938..b7059195ff59 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -211,6 +211,8 @@ struct ath12k_hw_params {
 	u32 otp_board_id_register;
 
 	bool supports_sta_ps;
+
+	bool supports_rssi_stats;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 39fe845a6137..8aaf6e0036cf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7443,12 +7443,42 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return ret;
 }
 
+static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
+				   u32 vdev_id, u32 stats_id)
+{
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH12K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id, pdev_id);
+
+	if (ret)
+		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+err_unlock:
+
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
+	struct ath12k *ar = arsta->arvif->ar;
+	s8 signal;
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -7473,8 +7503,19 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
 	/* TODO: Use real NF instead of default one. */
-	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	signal = arsta->rssi_comb;
+
+	if (!signal &&
+	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ar->ab->hw_params->supports_rssi_stats &&
+	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_VDEV_STAT)))
+		signal = arsta->rssi_beacon;
+
+	if (signal) {
+		sinfo->signal = signal;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	}
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 838161dd9098..12adb553a0c8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -25,6 +25,10 @@ struct ath12k_wmi_svc_ready_parse {
 	bool wmi_svc_bitmap_done;
 };
 
+struct wmi_tlv_fw_stats_parse {
+	const struct wmi_stats_event *ev;
+};
+
 struct ath12k_wmi_dma_ring_caps_parse {
 	struct ath12k_wmi_dma_ring_caps_params *dma_ring_caps;
 	u32 n_dma_ring_caps;
@@ -6459,8 +6463,100 @@ static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff
 	rcu_read_unlock();
 }
 
+static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
+					      struct wmi_tlv_fw_stats_parse *parse,
+					      const void *ptr,
+					      u16 len)
+{
+	const struct wmi_stats_event *ev = parse->ev;
+	struct ath12k *ar;
+	struct ath12k_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *arsta;
+	int i, ret = 0;
+	const void *data = ptr;
+
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch update stats ev");
+		return -EPROTO;
+	}
+
+	rcu_read_lock();
+
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
+	if (!ar) {
+		ath12k_warn(ab, "invalid pdev id %d in update stats event\n",
+			    le32_to_cpu(ev->pdev_id));
+		ret = -EPROTO;
+		goto exit;
+	}
+
+	for (i = 0; i < le32_to_cpu(ev->num_vdev_stats); i++) {
+		const struct ath12k_wmi_vdev_stats *src;
+
+		src = data;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		arvif = ath12k_mac_get_arvif(ar, le32_to_cpu(src->vdev_id));
+		if (arvif) {
+			sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
+							   arvif->bssid,
+							   NULL);
+			if (sta) {
+				arsta = ath12k_sta_to_arsta(sta);
+				arsta->rssi_beacon = le32_to_cpu(src->beacon_snr);
+				ath12k_dbg(ab, ATH12K_DBG_WMI,
+					   "wmi stats vdev id %d snr %d\n",
+					   src->vdev_id, src->beacon_snr);
+			} else {
+				ath12k_dbg(ab, ATH12K_DBG_WMI,
+					   "not found station bssid %pM for vdev stat\n",
+					   arvif->bssid);
+			}
+		}
+
+		data += sizeof(*src);
+		len -= sizeof(*src);
+	}
+
+exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
+					 u16 tag, u16 len,
+					 const void *ptr, void *data)
+{
+	struct wmi_tlv_fw_stats_parse *parse = data;
+	int ret = 0;
+
+	switch (tag) {
+	case WMI_TAG_STATS_EVENT:
+		parse->ev = ptr;
+		break;
+	case WMI_TAG_ARRAY_BYTE:
+		ret = ath12k_wmi_tlv_fw_stats_data_parse(ab, parse, ptr, len);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
 static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
+	int ret;
+	struct wmi_tlv_fw_stats_parse parse = {};
+
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_tlv_fw_stats_parse,
+				  &parse);
+	if (ret)
+		ath12k_warn(ab, "failed to parse fw stats %d\n", ret);
 }
 
 /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned
@@ -7180,3 +7276,36 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
 
 	ath12k_wmi_free_dbring_caps(ab);
 }
+
+int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
+				      u32 vdev_id, u32 pdev_id)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_request_stats_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_request_stats_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_REQUEST_STATS_CMD,
+						 sizeof(*cmd));
+
+	cmd->stats_id = cpu_to_le32(stats_id);
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->pdev_id = cpu_to_le32(pdev_id);
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_REQUEST_STATS_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_REQUEST_STATS cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "WMI request stats 0x%x vdev id %d pdev id %d\n",
+		   stats_id, vdev_id, pdev_id);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 103462feb935..65a8801a0d81 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4845,6 +4845,52 @@ struct wmi_twt_disable_event {
 	__le32 status;
 } __packed;
 
+struct wmi_stats_event {
+	__le32 stats_id;
+	__le32 num_pdev_stats;
+	__le32 num_vdev_stats;
+	__le32 num_peer_stats;
+	__le32 num_bcnflt_stats;
+	__le32 num_chan_stats;
+	__le32 num_mib_stats;
+	__le32 pdev_id;
+	__le32 num_bcn_stats;
+	__le32 num_peer_extd_stats;
+	__le32 num_peer_extd2_stats;
+} __packed;
+
+enum wmi_stats_id {
+	WMI_REQUEST_VDEV_STAT	= BIT(3),
+};
+
+struct wmi_request_stats_cmd {
+	__le32 tlv_header;
+	__le32 stats_id;
+	__le32 vdev_id;
+	struct ath12k_wmi_mac_addr_params peer_macaddr;
+	__le32 pdev_id;
+} __packed;
+
+#define WLAN_MAX_AC 4
+#define MAX_TX_RATE_VALUES 10
+
+struct ath12k_wmi_vdev_stats {
+	__le32 vdev_id;
+	__le32 beacon_snr;
+	__le32 data_snr;
+	__le32 num_tx_frames[WLAN_MAX_AC];
+	__le32 num_rx_frames;
+	__le32 num_tx_frames_retries[WLAN_MAX_AC];
+	__le32 num_tx_frames_failures[WLAN_MAX_AC];
+	__le32 num_rts_fail;
+	__le32 num_rts_success;
+	__le32 num_rx_err;
+	__le32 num_rx_discard;
+	__le32 num_tx_not_acked;
+	__le32 tx_rate_history[MAX_TX_RATE_VALUES];
+	__le32 beacon_rssi_history[MAX_TX_RATE_VALUES];
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -4966,6 +5012,8 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
+int ath12k_wmi_send_stats_request_cmd(struct ath12k *ar, u32 stats_id,
+				      u32 vdev_id, u32 pdev_id);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)

base-commit: 707e306f3573fa321ae197d77366578e4566cff5
prerequisite-patch-id: be59cc41a58272051c64f75d2e96d6cfbdc17180
-- 
2.34.1


