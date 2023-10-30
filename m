Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1061B7DC272
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJ3W2E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjJ3W2D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:28:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C570119
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:27:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UM6eWr016625;
        Mon, 30 Oct 2023 22:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uHPm0ZeLHWZRbGPbNoSCPeraz1GDKqfQzn2rN3E75Z8=;
 b=hHV2YJ4Hrt8ElHCcOYslP7XgJs/VRUSt9wPAqvI5MWC7tyqiLKIGQ0944uT5Uy1CAAM2
 4CBwnqEl9SV9u8l2MC4GviaBvZSPMIsceMO5gfTalnpRj03ACGZJYhurxG+sxNKAa6jB
 H5oWAP5nXTeEb/3Xlph2iofaO2FfAzMclV/NPaoW+TjmYY8DWIZUAUxGdO3n4iDLuZzI
 OSqJApQOddSSW7R1J/hUyT6N/CZxMPx+HKgsvJMLM4S71s0jME20U2+28CrpqVpipTI9
 8K6TcEqaPylTfmBmWQbsGKdggkfAkUkRDTybNG8rYCrO6PEyc2D+y/plBrwJoJjacLBb nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fuvgrb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMRqok009079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:27:52 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 15:27:51 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 09/13] wifi: ath12k: remove hal_desc_sz from hw params
Date:   Tue, 31 Oct 2023 03:56:56 +0530
Message-ID: <20231030222700.18914-10-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: STo8G00_c2350JiahycCcGQMIq6BK6kw
X-Proofpoint-GUID: STo8G00_c2350JiahycCcGQMIq6BK6kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
 drivers/net/wireless/ath/ath12k/dp.c     |  6 +++++
 drivers/net/wireless/ath/ath12k/dp.h     |  1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 30 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal.c    | 12 ++++++++++
 drivers/net/wireless/ath/ath12k/hal.h    |  3 +++
 drivers/net/wireless/ath/ath12k/hw.c     |  3 ---
 drivers/net/wireless/ath/ath12k/hw.h     |  1 -
 9 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index fa90c94a9..13b26693d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -627,6 +627,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_mac_destroy;
 	}
 
+	ath12k_dp_hal_rx_desc_init(ab);
+
 	ret = ath12k_wmi_cmd_init(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to send wmi init cmd: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 6893466f6..80d7ce44d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -999,6 +999,12 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
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
index 61f765432..3abcb311d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1815,4 +1815,5 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 						  u32 cookie);
 struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 						  u32 desc_id);
+void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 90dffd7df..6be4c459c 100644
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
index 581316ffa..8185688bc 100644
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
 
@@ -1783,7 +1783,7 @@ static int ath12k_dp_rx_msdu_coalesce(struct ath12k *ar,
 	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
 	int space_extra, rem_len, buf_len;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	/* As the msdu is spread across multiple rx buffers,
 	 * find the offset to the start of msdu for computing
@@ -2494,7 +2494,7 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 	u8 l3_pad_bytes;
 	u16 msdu_len;
 	int ret;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	last_buf = ath12k_dp_rx_get_msdu_last_buf(msdu_list, msdu);
 	if (!last_buf) {
@@ -2827,7 +2827,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
-	u32 hdr_len, hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hdr_len, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 	u8 *key, *data;
 	u8 key_idx;
 
@@ -2877,7 +2877,7 @@ static void ath12k_dp_rx_h_undecap_frag(struct ath12k *ar, struct sk_buff *msdu,
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	size_t crypto_len;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	if (!flags)
 		return;
@@ -2915,7 +2915,7 @@ static int ath12k_dp_rx_h_defrag(struct ath12k *ar,
 	bool is_decrypted = false;
 	int msdu_len = 0;
 	int extra_space;
-	u32 flags, hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 flags, hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	first_frag = skb_peek(&rx_tid->rx_frags);
 	last_frag = skb_peek_tail(&rx_tid->rx_frags);
@@ -2991,7 +2991,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	struct ath12k_rx_desc_info *desc_info;
 	u8 dst_ind;
 
-	hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	link_desc_banks = dp->link_desc_banks;
 	reo_dest_ring = rx_tid->dst_ring_desc;
 
@@ -3145,7 +3145,7 @@ static u64 ath12k_dp_rx_h_get_pn(struct ath12k *ar, struct sk_buff *skb)
 	struct ieee80211_hdr *hdr;
 	u64 pn = 0;
 	u8 *ehdr;
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	hdr = (struct ieee80211_hdr *)(skb->data + hal_rx_desc_sz);
 	ehdr = skb->data + hal_rx_desc_sz + ieee80211_hdrlen(hdr->frame_control);
@@ -3328,7 +3328,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	struct ath12k_skb_rxcb *rxcb;
 	struct hal_rx_desc *rx_desc;
 	u16 msdu_len;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	struct ath12k_rx_desc_info *desc_info;
 	u64 desc_va;
 
@@ -3510,7 +3510,7 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 	int n_buffs;
 
 	n_buffs = DIV_ROUND_UP(msdu_len,
-			       (DP_RX_BUFFER_SIZE - ar->ab->hw_params->hal_desc_sz));
+			       (DP_RX_BUFFER_SIZE - ar->ab->hal.hal_desc_sz));
 
 	skb_queue_walk_safe(msdu_list, skb, tmp) {
 		rxcb = ATH12K_SKB_RXCB(skb);
@@ -3534,7 +3534,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
 
@@ -3631,7 +3631,7 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
 	u8 l3pad_bytes;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
 
 	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, desc);
 	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, desc);
@@ -3947,7 +3947,7 @@ int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
 	int ret;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 
 	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
 
@@ -3982,7 +3982,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
 	int ret;
-	u32 hal_rx_desc_sz = ab->hw_params->hal_desc_sz;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
 	int i;
 
 	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 4dbe5f8bb..0169f8840 100644
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
index a989ea121..266f285d3 100644
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
index 2245fb510..9f3681bd5 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -897,7 +897,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = false,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274),
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
@@ -959,7 +958,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = true,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
 		.num_tcl_banks = 7,
 		.max_tx_ring = 3,
 
@@ -1022,7 +1020,6 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.reoq_lut_support = false,
 		.supports_shadow_regs = false,
 
-		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274),
 		.num_tcl_banks = 48,
 		.max_tx_ring = 4,
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 7b868ae80..c3754a9a5 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -187,7 +187,6 @@ struct ath12k_hw_params {
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
 
-	u32 hal_desc_sz;
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
 
-- 
2.17.1

