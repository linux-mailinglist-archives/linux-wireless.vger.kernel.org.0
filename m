Return-Path: <linux-wireless+bounces-18568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E15A29F7F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 04:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC433A6F83
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA1376;
	Thu,  6 Feb 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bhQR/2D2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83B2B9BF
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738814080; cv=none; b=ecgV+b+oYRT1ovuFxBVJjdl0+9plc1TY/kdVBSQSOT4dnUcofaRmlLoLumbjKiqYSLUuR8huzEd7TILULbzidDqX3619dQV6n/KzCHyRaT4zNmmI3Tcvkxz1VSkk3LHS8xhLbwCLx0vL7+Kpj86lMUWfqUctjCbqerlP8nyJP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738814080; c=relaxed/simple;
	bh=xE/dzycjqdWanw8wAXMDyHFPESpd8NqFUX5JxhMVTRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdWe29x3OMBvhqDAYqCZbvlHA8ggZdeyf+eBh7t4rwuW0wAkr/rw09RMswvVn4friI8U+hyqLqHX/5fdyIfhve87nOqKthA0Zy6cwJXUt32HDWzWgE9USHd+OxAjYRFasefBWQBcqR4lpz+5VMOcoWAXsCso9ry+x6rNUwI1ag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bhQR/2D2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5163kosq015347;
	Thu, 6 Feb 2025 03:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tOnpS52nEEq94e5pT4/FNrCXaHL91Ze8myXQk/oA0AI=; b=bhQR/2D2U2wsyUpm
	XBkW2UCQa0mKSFOw9GxFLtL+QpONXrAkvd08BWmnQKPB3tJRBbjp8zoZHQtZOUlD
	q6X9CrXVnS5B3CoqQ6rUHfQo8mC6Qc/HZbnNzTZ/qGCbDBWr+IXeMsv/V9ok29i2
	tTGLnIICfOHuWmFb5B6QibDEk743hru7mg5JNFbgIOavGNzGyFfoayCiZXyNqAL5
	VL/m9qlFF9a8ZiEA1Ypi0ejLMqMFcR8JfQ3iMuKpKBebverKqs2oHYNLPYht/VZW
	xfUzkmHEwGfcAOLuYyD2T8gDcQFud4MMQRSOSigfHv7LNnKK6ACWMUtoiBelKDny
	61fSTQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mnfkg0ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 03:54:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5163sZvL016274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 03:54:35 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 19:54:32 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v5 5/7] wifi: ath12k: change the status update in the monitor Rx
Date: Thu, 6 Feb 2025 09:23:55 +0530
Message-ID: <20250206035357.310868-6-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206035357.310868-1-quic_periyasa@quicinc.com>
References: <20250206035357.310868-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: JyfrudcY6XnsnV0wKMKOofBctq1Y6-C2
X-Proofpoint-ORIG-GUID: JyfrudcY6XnsnV0wKMKOofBctq1Y6-C2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=858 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060029

From: P Praneesh <quic_ppranees@quicinc.com>

Currently, in the monitor Rx path, status is filled from the RX TLV header
present in the MSDU data. This logic is inherited from ath11k. However, in
the ath12k 802.11be hardware, the Rx TLV header is not present in the MSDU
data. This information is reported under various TLV tags. Therefore, avoid
the existing status filling by accumulating the needed information in the
PPDU information structure and fill the status.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h   |  16 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 138 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h |   5 +-
 3 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c0ac1a531ca9..8faca7277fb8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -528,9 +528,19 @@ struct ath12k_sta {
 	enum ieee80211_sta_state state;
 };
 
-#define ATH12K_MIN_5GHZ_FREQ 4150
-#define ATH12K_MIN_6GHZ_FREQ 5925
-#define ATH12K_MAX_6GHZ_FREQ 7115
+#define ATH12K_HALF_20MHZ_BW	10
+#define ATH12K_2GHZ_MIN_CENTER	2412
+#define ATH12K_2GHZ_MAX_CENTER	2484
+#define ATH12K_5GHZ_MIN_CENTER	4900
+#define ATH12K_5GHZ_MAX_CENTER	5920
+#define ATH12K_6GHZ_MIN_CENTER	5935
+#define ATH12K_6GHZ_MAX_CENTER	7115
+#define ATH12K_MIN_2GHZ_FREQ	(ATH12K_2GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW - 1)
+#define ATH12K_MAX_2GHZ_FREQ	(ATH12K_2GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW + 1)
+#define ATH12K_MIN_5GHZ_FREQ	(ATH12K_5GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MAX_5GHZ_FREQ	(ATH12K_5GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MIN_6GHZ_FREQ	(ATH12K_6GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MAX_6GHZ_FREQ	(ATH12K_6GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
 #define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5GHZ_CHAN 173
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 597957d7d3ee..ae925a281fdd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1700,18 +1700,128 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 	skb_pull(head_msdu, rx_pkt_offset + l2_hdr_offset);
 }
 
+static void
+ath12k_dp_mon_fill_rx_stats_info(struct ath12k *ar,
+				 struct hal_rx_mon_ppdu_info *ppdu_info,
+				 struct ieee80211_rx_status *rx_status)
+{
+	u32 center_freq = ppdu_info->freq;
+
+	rx_status->freq = center_freq;
+	rx_status->bw = ath12k_mac_bw_to_mac80211_bw(ppdu_info->bw);
+	rx_status->nss = ppdu_info->nss;
+	rx_status->rate_idx = 0;
+	rx_status->encoding = RX_ENC_LEGACY;
+	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+
+	if (center_freq >= ATH12K_MIN_6GHZ_FREQ &&
+	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_6GHZ;
+	} else if (center_freq >= ATH12K_MIN_2GHZ_FREQ &&
+		   center_freq <= ATH12K_MAX_2GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_2GHZ;
+	} else if (center_freq >= ATH12K_MIN_5GHZ_FREQ &&
+		   center_freq <= ATH12K_MAX_5GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_5GHZ;
+	} else {
+		rx_status->band = NUM_NL80211_BANDS;
+	}
+}
+
+static void
+ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
+			   struct hal_rx_mon_ppdu_info *ppdu_info,
+			   struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_supported_band *sband;
+	enum rx_msdu_start_pkt_type pkt_type;
+	u8 rate_mcs, nss, sgi;
+	bool is_cck;
+
+	pkt_type = ppdu_info->preamble_type;
+	rate_mcs = ppdu_info->rate;
+	nss = ppdu_info->nss;
+	sgi = ppdu_info->gi;
+
+	switch (pkt_type) {
+	case RX_MSDU_START_PKT_TYPE_11A:
+	case RX_MSDU_START_PKT_TYPE_11B:
+		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
+		if (rx_status->band < NUM_NL80211_BANDS) {
+			sband = &ar->mac.sbands[rx_status->band];
+			rx_status->rate_idx = ath12k_mac_hw_rate_to_idx(sband, rate_mcs,
+									is_cck);
+		}
+		break;
+	case RX_MSDU_START_PKT_TYPE_11N:
+		rx_status->encoding = RX_ENC_HT;
+		if (rate_mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in HT mode %d\n",
+				     rate_mcs);
+			break;
+		}
+		rx_status->rate_idx = rate_mcs + (8 * (nss - 1));
+		if (sgi)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		break;
+	case RX_MSDU_START_PKT_TYPE_11AC:
+		rx_status->encoding = RX_ENC_VHT;
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in VHT mode %d\n",
+				     rate_mcs);
+			break;
+		}
+		if (sgi)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		break;
+	case RX_MSDU_START_PKT_TYPE_11AX:
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_HE_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in HE mode %d\n",
+				    rate_mcs);
+			break;
+		}
+		rx_status->encoding = RX_ENC_HE;
+		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		break;
+	case RX_MSDU_START_PKT_TYPE_11BE:
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in EHT mode %d\n",
+				    rate_mcs);
+			break;
+		}
+		rx_status->encoding = RX_ENC_EHT;
+		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		break;
+	default:
+		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+			   "monitor receives invalid preamble type %d",
+			    pkt_type);
+		break;
+	}
+}
+
 static struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 			    struct dp_mon_mpdu *mon_mpdu,
+			    struct hal_rx_mon_ppdu_info *ppdu_info,
 			    struct ieee80211_rx_status *rxs)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
 	struct sk_buff *head_msdu, *tail_msdu;
-	struct hal_rx_desc *rx_desc, *tail_rx_desc;
+	struct hal_rx_desc *rx_desc;
 	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
+	struct ieee80211_channel *channel;
 	u32 frag_list_sum_len = 0;
+	u8 channel_num = ppdu_info->chan_num;
 
 	mpdu_buf = NULL;
 	head_msdu = mon_mpdu->head;
@@ -1720,9 +1830,29 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 	if (!head_msdu)
 		goto err_merge_fail;
 
-	tail_rx_desc = (struct hal_rx_desc *)tail_msdu->data;
+	ath12k_dp_mon_fill_rx_stats_info(ar, ppdu_info, rxs);
+
+	if (unlikely(rxs->band == NUM_NL80211_BANDS ||
+		     !ath12k_ar_to_hw(ar)->wiphy->bands[rxs->band])) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+			   "sband is NULL for status band %d channel_num %d center_freq %d pdev_id %d\n",
+			   rxs->band, channel_num, ppdu_info->freq, ar->pdev_idx);
+
+		spin_lock_bh(&ar->data_lock);
+		channel = ar->rx_channel;
+		if (channel) {
+			rxs->band = channel->band;
+			channel_num =
+				ieee80211_frequency_to_channel(channel->center_freq);
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+
+	if (rxs->band < NUM_NL80211_BANDS)
+		rxs->freq = ieee80211_channel_to_frequency(channel_num,
+							   rxs->band);
 
-	ath12k_dp_rx_h_ppdu(ar, tail_rx_desc, rxs);
+	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
 		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
@@ -2040,7 +2170,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
 	u8 decap = DP_RX_DECAP_TYPE_RAW;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, rxs);
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, ppduinfo, rxs);
 	if (!mon_skb)
 		goto mon_deliver_fail;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 6f10e4222ba6..c753eb2a03ad 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -509,7 +509,10 @@ struct hal_rx_mpdu_start {
 
 struct hal_rx_msdu_end {
 	__le32 info0;
-	__le32 rsvd0[18];
+	__le32 rsvd0[9];
+	__le16 info00;
+	__le16 info01;
+	__le32 rsvd00[8];
 	__le32 info1;
 	__le32 rsvd1[10];
 	__le32 info2;
-- 
2.34.1


