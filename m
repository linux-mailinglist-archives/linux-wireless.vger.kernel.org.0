Return-Path: <linux-wireless+bounces-1534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028E825B4B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF9B285AFF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8C36083;
	Fri,  5 Jan 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bfOgtd4J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A336096
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405FOfcH008954;
	Fri, 5 Jan 2024 19:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2So6YusTlvKYvBjqpWRG92GPbqhpP1uY1gFBpLu4l5I=; b=bf
	Ogtd4JFHsvkJIV64oHa8sg2qbfXCuetQybeFwlfW3Db4IZtD14L22YuEGw+NrcQy
	T4rsGvONcJU9IBbeUhL09d2H62qZkVtO6S48ChcP01gTNazlAguPD6qnCVMI3Z5o
	C2Pge+S+A54GBTBRnvQ6KCvmMqmdio3/BqUzf2ufjLL059DzdoP3XsMP6moM6jIo
	IYTOhxGlsXgNulDEOoGMfFYc1T0oPJIR1WPQANwtjfaau6ywLX3P/j91JssozLiF
	o/aLUfM4YXoaZ3RyNGV9C04ntx4VuzVyRmtYlCxtn3HUkHvZoea6zVNtb4dQR/jp
	hsgL9QPppsN15jOR4YJQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve99at66v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405JvEwb032340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:14 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:13 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 08/12] wifi: ath12k: remove hal_desc_sz from hw params
Date: Sat, 6 Jan 2024 01:26:35 +0530
Message-ID: <20240105195639.3217739-9-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: pP3z51-zsHSFSIvdaSLdDnonzBgWtS6a
X-Proofpoint-GUID: pP3z51-zsHSFSIvdaSLdDnonzBgWtS6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401050161

With word mask subscription support, the rx_desc structure will
change. The fields in this structure rx_desc will be reduced to only
the required fields. To make word mask subscription changes compatible
with the older firmware version (firmware that does not support word
mask subscription), two different structures of rx_desc will be
required for the same hardware.

The hardware param hal_desc_sz value cannot be constant for the same
hardware. It depends on the size of rx_desc structure which may
change based on firmware capability to support word mask subscription.
Hence, remove hal_desc_sz from hardware param and add hal_rx_ops
to get the size of rx_desc in run time.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c   |  2 ++
 drivers/net/wireless/ath/ath12k/dp.c     |  8 ++++++-
 drivers/net/wireless/ath/ath12k/dp.h     |  3 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 30 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.c    | 12 ++++++++++
 drivers/net/wireless/ath/ath12k/hal.h    |  3 +++
 drivers/net/wireless/ath/ath12k/hw.c     |  5 +---
 drivers/net/wireless/ath/ath12k/hw.h     |  1 -
 9 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 02b9d493d191..d547e6136c5d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -750,6 +750,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_mac_destroy;
 	}
 
+	ath12k_dp_hal_rx_desc_init(ab);
+
 	ret = ath12k_wmi_cmd_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to send wmi init cmd: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index a6f81f2f97ef..af800d60f3a2 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <crypto/hash.h>
@@ -997,6 +997,12 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
 	}
 }
 
+void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
+{
+	ab->hal.hal_desc_sz =
+		ab->hal_rx_ops->rx_desc_get_desc_size();
+}
+
 static void ath12k_dp_service_mon_ring(struct timer_list *t)
 {
 	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 1df3cdd46140..c8e993576695 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_DP_H
@@ -1820,4 +1820,5 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 desc_id);
+void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 626aea73853a..7a55a26dc744 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -864,7 +864,7 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar, struct sk_buff
 {
 	u32 rx_pkt_offset, l2_hdr_offset;
 
-	rx_pkt_offset = ar->ab->hw_params->hal_desc_sz;
+	rx_pkt_offset = ar->ab->hal.hal_desc_sz;
 	l2_hdr_offset = ath12k_dp_rx_h_l3pad(ar->ab,
 					     (struct hal_rx_desc *)msdu->data);
 	skb_pull(msdu, rx_pkt_offset + l2_hdr_offset);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 0b819e45a624..9e089c865b31 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -58,7 +58,7 @@ static bool ath12k_dp_rx_h_more_frags(struct ath12k_base *ab,
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params->hal_desc_sz);
+	hdr = (struct ieee80211_hdr *)(skb->data + ab->hal.hal_desc_sz);
 	return ieee80211_has_morefrags(hdr->frame_control);
 }
 
@@ -67,7 +67,7 @@ static u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 {
 	struct ieee80211_hdr *hdr;
 
-	hdr = (struct ieee80211_hdr *)(skb->data + ab->hw_params->hal_desc_sz);
+	hdr = (struct ieee80211_hdr *)(skb->data + ab->hal.hal_desc_sz);
 	return le16_to_cpu(hdr->seq_ctrl) & IEEE80211_SCTL_FRAG;
 }
 
@@ -1762,7 +1762,7 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
 	int space_extra, rem_len, buf_len;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	/* As the msdu is spread across multiple rx buffers,
 	 * find the offset to the start of msdu for computing
@@ -2474,7 +2474,7 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	u8 l3_pad_bytes;
 	u16 msdu_len;
 	int ret;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
 	if (!last_buf) {
@@ -2805,7 +2805,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
-	u32 hdr_len, hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hdr_len, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
@@ -2855,7 +2855,7 @@ static void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	size_t crypto_len;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	if (!flags)
 		return;
@@ -2893,7 +2893,7 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 	bool is_decrypted = false;
 	int msdu_len = 0;
 	int extra_space;
-	u32 flags, hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 flags, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	first_frag = skb_peek(&rx_tid->rx_frags);
 	last_frag = skb_peek_tail(&rx_tid->rx_frags);
@@ -2969,7 +2969,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	struct ath12k_rx_desc_info *desc_info;
 	u8 dst_ind;
 
-	hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	link_desc_banks = dp->link_desc_banks;
 	reo_dest_ring = rx_tid->dst_ring_desc;
 
@@ -3123,7 +3123,7 @@ static u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
 	u8 *ehdr;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
 	ehdr = skb->data + hal_rx_desc_sz + ieee80211_hdrlen(hdr->frame_control);
@@ -3306,7 +3306,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	struct ath12k_skb_rxcb *rxcb;
 	struct hal_rx_desc *rx_desc;
 	u16 msdu_len;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	struct ath12k_rx_desc_info *desc_info;
 	u64 desc_va;
 
@@ -3487,7 +3487,7 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 	int n_buffs;
 
 	n_buffs = DIV_ROUND_UP(msdu_len,
-			       (DP_RX_BUFFER_SIZE - ar->ab->hw_params->hal_desc_sz));
+			       (DP_RX_BUFFER_SIZE - ar->ab->hal.hal_desc_sz));
 
 	skb_queue_walk_safe(msdu_list, skb, tmp) {
 		rxcb = ATH12K_SKB_RXCB(skb);
@@ -3511,7 +3511,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
 
@@ -3608,7 +3608,7 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, desc);
 	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, desc);
@@ -3923,7 +3923,7 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
 	int ret;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 
 	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
 
@@ -3958,7 +3958,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
 	int ret;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	int i;
 
 	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index b6b8298a2bdc..fa1bfb5256d0 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -680,6 +680,11 @@ static u32 ath12k_hw_qcn9274_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
+static u32 ath12k_hw_qcn9274_get_rx_desc_size(void)
+{
+	return sizeof(struct hal_rx_desc_qcn9274);
+}
+
 const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_qcn9274_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_qcn9274_rx_desc_get_last_msdu,
@@ -717,6 +722,7 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
 	.dp_rx_h_is_decrypted = ath12k_hw_qcn9274_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_qcn9274_dp_rx_h_mpdu_err,
+	.rx_desc_get_desc_size = ath12k_hw_qcn9274_get_rx_desc_size,
 };
 
 const struct hal_ops hal_qcn9274_ops = {
@@ -1137,6 +1143,11 @@ static u32 ath12k_hw_wcn7850_dp_rx_h_mpdu_err(struct hal_rx_desc *desc)
 	return errmap;
 }
 
+static u32 ath12k_hw_wcn7850_get_rx_desc_size(void)
+{
+	return sizeof(struct hal_rx_desc_wcn7850);
+}
+
 const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_get_first_msdu = ath12k_hw_wcn7850_rx_desc_get_first_msdu,
 	.rx_desc_get_last_msdu = ath12k_hw_wcn7850_rx_desc_get_last_msdu,
@@ -1175,6 +1186,7 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
 	.dp_rx_h_is_decrypted = ath12k_hw_wcn7850_dp_rx_h_is_decrypted,
 	.dp_rx_h_mpdu_err = ath12k_hw_wcn7850_dp_rx_h_mpdu_err,
+	.rx_desc_get_desc_size = ath12k_hw_wcn7850_get_rx_desc_size,
 };
 
 const struct hal_ops hal_wcn7850_ops = {
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 33dedfbb3964..82517991510b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1023,6 +1023,8 @@ struct ath12k_hal {
 	/* shadow register configuration */
 	u32 shadow_reg_addr[HAL_SHADOW_NUM_REGS];
 	int num_shadow_reg_configured;
+
+	u32 hal_desc_sz;
 };
 
 /* Maps WBM ring number and Return Buffer Manager Id per TCL ring */
@@ -1075,6 +1077,7 @@ struct hal_rx_ops {
 	bool (*dp_rx_h_ip_cksum_fail)(struct hal_rx_desc *desc);
 	bool (*dp_rx_h_is_decrypted)(struct hal_rx_desc *desc);
 	u32 (*dp_rx_h_mpdu_err)(struct hal_rx_desc *desc);
+	u32 (*rx_desc_get_desc_size)(void);
 };
 
 struct hal_ops {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index de60d988d860..c4a79167b9f4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -897,7 +897,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = false,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274),
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
@@ -960,7 +959,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = true,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
 		.num_tcl_banks = 7,
 		.max_tx_ring = 3,
 
@@ -1023,7 +1021,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = false,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274),
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 2ecd66e62e49..c82d3a27b4b4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -187,7 +187,6 @@ struct ath12k_hw_params {
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
 
-	u32 hal_desc_sz;
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
 
-- 
2.34.1


