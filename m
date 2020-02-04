Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC49151CF9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBDPLl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 10:11:41 -0500
Received: from nbd.name ([46.4.11.11]:41016 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbgBDPLk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 10:11:40 -0500
Received: from [149.224.158.146] (helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iyzrV-00078y-TK; Tue, 04 Feb 2020 16:11:37 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 4/4] ath11k: add more HE fields into radiotap header
Date:   Tue,  4 Feb 2020 16:11:35 +0100
Message-Id: <20200204151135.25302-4-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204151135.25302-1-john@phrozen.org>
References: <20200204151135.25302-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds code to parse HE fields inside ppdu TLVs. Then it adds the
populates the additional info into the ratiotap header. Also fix missing QoS
tag in native wifi mode. Finally rssi and tsf are also added.

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Tested-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 106 ++++-
 drivers/net/wireless/ath/ath11k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 435 +++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 226 ++++++++++-
 4 files changed, 703 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9cf331bdcf16..84428b25cb58 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -190,7 +190,7 @@ static u8 *ath11k_dp_rxdesc_get_80211hdr(struct hal_rx_desc *rx_desc)
 {
 	u8 *rx_pkt_hdr;
 
-	rx_pkt_hdr = &rx_desc->msdu_payload[0];
+	rx_pkt_hdr = &rx_desc->hdr_status[0];
 
 	return rx_pkt_hdr;
 }
@@ -2070,7 +2070,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	char tid[32];
 
 	status = IEEE80211_SKB_RXCB(msdu);
-	if (status->encoding == RX_ENC_HE) {
+	if (status->encoding == RX_ENC_HE && !(status->flag & RX_FLAG_RADIOTAP_HE)) {
 		he = skb_push(msdu, sizeof(known));
 		memcpy(he, &known, sizeof(known));
 		status->flag |= RX_FLAG_RADIOTAP_HE;
@@ -3843,11 +3843,14 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 			    struct ieee80211_rx_status *rxs)
 {
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf;
-	u32 decap_format, wifi_hdr_len;
+	u32 decap_format;
 	struct hal_rx_desc *rx_desc;
 	char *hdr_desc;
 	u8 *dest;
 	struct ieee80211_hdr_3addr *wh;
+	static u32 pkt_type;
+
+	pkt_type++;
 
 	mpdu_buf = NULL;
 
@@ -3880,38 +3883,27 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 
 		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
 	} else if (decap_format == DP_RX_DECAP_TYPE_NATIVE_WIFI) {
-		__le16 qos_field;
 		u8 qos_pkt = 0;
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
 		hdr_desc = ath11k_dp_rxdesc_get_80211hdr(rx_desc);
 
 		/* Base size */
-		wifi_hdr_len = sizeof(struct ieee80211_hdr_3addr);
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
 
 		if (ieee80211_is_data_qos(wh->frame_control)) {
-			struct ieee80211_qos_hdr *qwh =
-					(struct ieee80211_qos_hdr *)hdr_desc;
-
-			qos_field = qwh->qos_ctrl;
 			qos_pkt = 1;
 		}
 		msdu = head_msdu;
 
 		while (msdu) {
-			rx_desc = (struct hal_rx_desc *)msdu->data;
-			hdr_desc = ath11k_dp_rxdesc_get_80211hdr(rx_desc);
-
+			ath11k_dp_rx_msdus_set_payload(msdu);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
 					goto err_merge_fail;
-				memcpy(dest, hdr_desc, wifi_hdr_len);
-				memcpy(dest + wifi_hdr_len,
-				       (u8 *)&qos_field, sizeof(__le16));
+				memcpy(dest, hdr_desc, sizeof(struct ieee80211_qos_hdr));
 			}
-			ath11k_dp_rx_msdus_set_payload(msdu);
 			prev_buf = msdu;
 			msdu = msdu->next;
 		}
@@ -3941,8 +3933,83 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 	return NULL;
 }
 
+static void
+ath11k_dp_rx_update_radiotap_he(struct hal_rx_mon_ppdu_info *rx_status,
+				u8 *rtap_buf)
+{
+	u32 rtap_len = 0;
+
+	put_unaligned_le16(rx_status->he_data1, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_data2, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_data3, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_data4, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_data5, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_data6, &rtap_buf[rtap_len]);
+}
+
+static void
+ath11k_dp_rx_update_radiotap_he_mu(struct hal_rx_mon_ppdu_info *rx_status,
+				   u8 *rtap_buf)
+{
+	u32 rtap_len = 0;
+
+	put_unaligned_le16(rx_status->he_flags1, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	put_unaligned_le16(rx_status->he_flags2, &rtap_buf[rtap_len]);
+	rtap_len += 2;
+
+	rtap_buf[rtap_len] = rx_status->he_RU[0];
+	rtap_len += 1;
+
+	rtap_buf[rtap_len] = rx_status->he_RU[1];
+	rtap_len += 1;
+
+	rtap_buf[rtap_len] = rx_status->he_RU[2];
+	rtap_len += 1;
+
+	rtap_buf[rtap_len] = rx_status->he_RU[3];
+}
+
+static void ath11k_update_radiotap(struct hal_rx_mon_ppdu_info *ppduinfo,
+				   struct sk_buff *mon_skb,
+				   struct ieee80211_rx_status *rxs)
+{
+	u8 *ptr = NULL;
+
+	if (ppduinfo->he_mu_flags) {
+		rxs->flag |= RX_FLAG_RADIOTAP_HE_MU;
+		rxs->encoding = RX_ENC_HE;
+		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he_mu));
+		ath11k_dp_rx_update_radiotap_he_mu(ppduinfo, ptr);
+	}
+	if (ppduinfo->he_flags) {
+		rxs->flag |= RX_FLAG_RADIOTAP_HE;
+		rxs->encoding = RX_ENC_HE;
+		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he));
+		ath11k_dp_rx_update_radiotap_he(ppduinfo, ptr);
+	}
+
+	rxs->flag |= RX_FLAG_MACTIME_START;
+	rxs->signal = ppduinfo->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
+	rxs->nss = ppduinfo->nss;
+
+	rxs->mactime = ppduinfo->tsft;
+}
+
 static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 				    struct sk_buff *head_msdu,
+				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct sk_buff *tail_msdu,
 				    struct napi_struct *napi)
 {
@@ -3972,11 +4039,9 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 		} else {
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
-		rxs->flag |= RX_FLAG_ONLY_MONITOR;
-
+		ath11k_update_radiotap(ppduinfo, mon_skb, rxs);
 		status = IEEE80211_SKB_RXCB(mon_skb);
 		*status = *rxs;
-
 		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb);
 		mon_skb = skb_next;
 	} while (mon_skb);
@@ -4043,6 +4108,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, u32 quota,
 		}
 		if (head_msdu && tail_msdu) {
 			ath11k_dp_rx_mon_deliver(ar, dp->mac_id, head_msdu,
+						 &pmon->mon_ppdu_info,
 						 tail_msdu, napi);
 			rx_mon_stats->dest_mpdu_done++;
 		}
@@ -4083,6 +4149,8 @@ static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
 	while (!skb_queue_empty(&pmon->rx_status_q)) {
 		status_skb = skb_dequeue(&pmon->rx_status_q);
 
+		memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
+
 		tlv_status = ath11k_hal_rx_parse_mon_status(ar->ab, ppdu_info,
 							    status_skb);
 		if (tlv_status == HAL_TLV_STATUS_PPDU_DONE) {
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 5e200380cca4..c33f628a0958 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -472,6 +472,7 @@ enum hal_tlv_tag {
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
 #define HAL_TLV_HDR_LEN		GENMASK(25, 10)
+#define HAL_TLV_USR_ID		GENMASK(31, 26)
 
 #define HAL_TLV_ALIGN	4
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 58c57f91b672..551fe9bd3a2a 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -811,12 +811,75 @@ void ath11k_hal_reo_hw_setup(struct ath11k_base *ab)
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 }
 
+#define HAL_MAX_UL_MU_USERS	37
+static inline void
+ath11k_hal_rx_handle_ofdma_info(void *rx_tlv,
+				struct hal_rx_user_status *rx_user_status)
+{
+	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
+		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
+
+	rx_user_status->ul_ofdma_user_v0_word0 = ppdu_end_user->info6;
+
+	rx_user_status->ul_ofdma_user_v0_word1 = ppdu_end_user->rsvd2[10];
+}
+
+static inline void
+ath11k_hal_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
+				  struct hal_rx_user_status *rx_user_status)
+{
+	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
+		(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
+
+	rx_user_status->mpdu_ok_byte_count =
+		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT,
+			  ppdu_end_user->rsvd2[6]);
+	rx_user_status->mpdu_err_byte_count =
+		FIELD_GET(HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT,
+			  ppdu_end_user->rsvd2[8]);
+}
+
+static inline void
+ath11k_hal_rx_populate_mu_user_info(void *rx_tlv, struct hal_rx_mon_ppdu_info *ppdu_info,
+				    struct hal_rx_user_status *rx_user_status)
+{
+	rx_user_status->ast_index = ppdu_info->ast_index;
+	rx_user_status->tid = ppdu_info->tid;
+	rx_user_status->tcp_msdu_count =
+		ppdu_info->tcp_msdu_count;
+	rx_user_status->udp_msdu_count =
+		ppdu_info->udp_msdu_count;
+	rx_user_status->other_msdu_count =
+		ppdu_info->other_msdu_count;
+	rx_user_status->frame_control = ppdu_info->frame_control;
+	rx_user_status->frame_control_info_valid =
+		ppdu_info->frame_control_info_valid;
+	rx_user_status->data_sequence_control_info_valid =
+		ppdu_info->data_sequence_control_info_valid;
+	rx_user_status->first_data_seq_ctrl =
+		ppdu_info->first_data_seq_ctrl;
+	rx_user_status->preamble_type = ppdu_info->preamble_type;
+	rx_user_status->ht_flags = ppdu_info->ht_flags;
+	rx_user_status->vht_flags = ppdu_info->vht_flags;
+	rx_user_status->he_flags = ppdu_info->he_flags;
+	rx_user_status->rs_flags = ppdu_info->rs_flags;
+
+	rx_user_status->mpdu_cnt_fcs_ok =
+		ppdu_info->num_mpdu_fcs_ok;
+	rx_user_status->mpdu_cnt_fcs_err =
+		ppdu_info->num_mpdu_fcs_err;
+
+	ath11k_hal_rx_populate_byte_count(rx_tlv, ppdu_info, rx_user_status);
+}
+
 static enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
-				   u32 tlv_tag, u8 *tlv_data)
+				   u32 tlv_tag, u8 *tlv_data, u32 userid)
 {
-	u32 info0, info1;
+	u32 info0, info1, value;
+	u8 he_dcm = 0, he_stbc = 0;
+	u16 he_gi = 0, he_ltf = 0;
 
 	switch (tlv_tag) {
 	case HAL_RX_PPDU_START: {
@@ -837,6 +900,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		info0 = __le32_to_cpu(eu_stats->info0);
 		info1 = __le32_to_cpu(eu_stats->info1);
 
+		ppdu_info->ast_index =
+			FIELD_GET(HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX,
+				  __le32_to_cpu(eu_stats->info2));
 		ppdu_info->tid =
 			ffs(FIELD_GET(HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP,
 				      __le32_to_cpu(eu_stats->info6))) - 1;
@@ -860,6 +926,42 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->num_mpdu_fcs_err =
 			FIELD_GET(HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR,
 				  info0);
+		switch (ppdu_info->preamble_type) {
+		case HAL_RX_PREAMBLE_11N:
+			ppdu_info->ht_flags = 1;
+			break;
+		case HAL_RX_PREAMBLE_11AC:
+			ppdu_info->vht_flags = 1;
+			break;
+		case HAL_RX_PREAMBLE_11AX:
+			ppdu_info->he_flags = 1;
+			break;
+		default:
+			break;
+		}
+
+		if (userid < HAL_MAX_UL_MU_USERS) {
+			struct hal_rx_user_status *rxuser_stats =
+							&ppdu_info->userstats;
+
+			ath11k_hal_rx_handle_ofdma_info(tlv_data, rxuser_stats);
+			ath11k_hal_rx_populate_mu_user_info(tlv_data, ppdu_info,
+							    rxuser_stats);
+		}
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[0] = eu_stats->rsvd1[0];
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[1] = eu_stats->rsvd1[1];
+
+		break;
+	}
+	case HAL_RX_PPDU_END_USER_STATS_EXT: {
+		struct hal_rx_ppdu_end_user_stats_ext *eu_stats =
+			(struct hal_rx_ppdu_end_user_stats_ext *)tlv_data;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[2] = eu_stats->info1;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[3] = eu_stats->info2;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[4] = eu_stats->info3;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[5] = eu_stats->info4;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[6] = eu_stats->info5;
+		ppdu_info->userstats.mpdu_fcs_ok_bitmap[7] = eu_stats->info6;
 		break;
 	}
 	case HAL_PHYRX_HT_SIG: {
@@ -958,16 +1060,147 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		else
 			ppdu_info->reception_type =
 				HAL_RX_RECEPTION_TYPE_MU_MIMO;
+		ppdu_info->vht_flag_values5 = group_id;
+		ppdu_info->vht_flag_values3[0] = (((ppdu_info->mcs) << 4) |
+						   ppdu_info->nss);
+		ppdu_info->vht_flag_values2 = ppdu_info->bw;
+		ppdu_info->vht_flag_values4 =
+			FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING, info1);
 		break;
 	}
 	case HAL_PHYRX_HE_SIG_A_SU: {
 		struct hal_rx_he_sig_a_su_info *he_sig_a =
 			(struct hal_rx_he_sig_a_su_info *)tlv_data;
-		u32 nsts, cp_ltf, dcm;
+		u32 nsts, cp_ltf, dcm, value;
 
+		ppdu_info->he_flags = 1;
 		info0 = __le32_to_cpu(he_sig_a->info0);
 		info1 = __le32_to_cpu(he_sig_a->info1);
 
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_FORMAT_IND, info0);
+
+		if (value == 0)
+			ppdu_info->he_data1 = HE_TRIG_FORMAT_TYPE;
+		else
+			ppdu_info->he_data1 = HE_SU_FORMAT_TYPE;
+
+		ppdu_info->he_data1 |=
+			HE_BSS_COLOR_KNOWN |
+			HE_BEAM_CHANGE_KNOWN |
+			HE_DL_UL_KNOWN |
+			HE_MCS_KNOWN |
+			HE_DCM_KNOWN |
+			HE_CODING_KNOWN |
+			HE_LDPC_EXTRA_SYMBOL_KNOWN |
+			HE_STBC_KNOWN |
+			HE_DATA_BW_RU_KNOWN |
+			HE_DOPPLER_KNOWN;
+
+		ppdu_info->he_data2 |=
+			HE_GI_KNOWN |
+			HE_TXBF_KNOWN |
+			HE_PE_DISAMBIGUITY_KNOWN |
+			HE_TXOP_KNOWN |
+			HE_LTF_SYMBOLS_KNOWN |
+			HE_PRE_FEC_PADDING_KNOWN |
+			HE_MIDABLE_PERIODICITY_KNOWN;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_BSS_COLOR, info0);
+		ppdu_info->he_data3 = value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_BEAM_CHANGE, info0);
+		value = value << HE_BEAM_CHANGE_SHIFT;
+		ppdu_info->he_data3 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_DL_UL_FLAG, info0);
+		value = value << HE_DL_UL_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_MCS, info0);
+		ppdu_info->mcs = value;
+		value = value << HE_TRANSMIT_MCS_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM, info0);
+		he_dcm = value;
+		value = value << HE_DCM_SHIFT;
+		ppdu_info->he_data3 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_CODING, info1);
+		ppdu_info->ldpc = (value == HAL_RX_SU_MU_CODING_LDPC) ? 1 : 0;
+		value = value << HE_CODING_SHIFT;
+		ppdu_info->he_data3 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_LDPC_EXTRA, info1);
+		value = value << HE_LDPC_EXTRA_SYMBOL_SHIFT;
+		ppdu_info->he_data3 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_STBC, info1);
+		he_stbc = value;
+		value = value << HE_STBC_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		/* data4 */
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_SPATIAL_REUSE, info0);
+		ppdu_info->he_data4 = value;
+
+		/* data5 */
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_BW, info0);
+		ppdu_info->he_data5 = value;
+		ppdu_info->bw = value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_CP_LTF_SIZE, info0);
+		switch (value) {
+		case 0:
+				he_gi = HE_GI_0_8;
+				he_ltf = HE_LTF_1_X;
+				break;
+		case 1:
+				he_gi = HE_GI_0_8;
+				he_ltf = HE_LTF_2_X;
+				break;
+		case 2:
+				he_gi = HE_GI_1_6;
+				he_ltf = HE_LTF_2_X;
+				break;
+		case 3:
+				if (he_dcm && he_stbc) {
+					he_gi = HE_GI_0_8;
+					he_ltf = HE_LTF_4_X;
+				} else {
+					he_gi = HE_GI_3_2;
+					he_ltf = HE_LTF_4_X;
+				}
+				break;
+		}
+		ppdu_info->gi = he_gi;
+		value = he_gi << HE_GI_SHIFT;
+		ppdu_info->he_data5 |= value;
+		value = he_ltf << HE_LTF_SIZE_SHIFT;
+		ppdu_info->ltf_size = he_ltf;
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS, info0);
+		value = (value << HE_LTF_SYM_SHIFT);
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_PKT_EXT_FACTOR, info1);
+		value = value << HE_PRE_FEC_PAD_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXBF, info1);
+		value = value << HE_TXBF_SHIFT;
+		ppdu_info->he_data5 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_PKT_EXT_PE_DISAM, info1);
+		value = value << HE_PE_DISAMBIGUITY_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		/* data6 */
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS, info0);
+		value++;
+		ppdu_info->nss = value;
+		ppdu_info->he_data6 = value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_DOPPLER_IND, info1);
+		value = value << HE_DOPPLER_SHIFT;
+		ppdu_info->he_data6 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXOP_DURATION, info1);
+		value = value << HE_TXOP_SHIFT;
+		ppdu_info->he_data6 |= value;
+
 		ppdu_info->mcs =
 			FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_MCS,
 				  info0);
@@ -984,22 +1217,6 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 				   info0);
 		nsts = FIELD_GET(HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS, info0);
 
-		switch (cp_ltf) {
-		case 0:
-		case 1:
-			ppdu_info->gi = HAL_RX_GI_0_8_US;
-			break;
-		case 2:
-			ppdu_info->gi = HAL_RX_GI_1_6_US;
-			break;
-		case 3:
-			if (dcm && ppdu_info->is_stbc)
-				ppdu_info->gi = HAL_RX_GI_0_8_US;
-			else
-				ppdu_info->gi = HAL_RX_GI_3_2_US;
-			break;
-		}
-
 		ppdu_info->nss = nsts + 1;
 		ppdu_info->dcm = dcm;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
@@ -1009,32 +1226,132 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		struct hal_rx_he_sig_a_mu_dl_info *he_sig_a_mu_dl =
 			(struct hal_rx_he_sig_a_mu_dl_info *)tlv_data;
 
-		u32 cp_ltf;
-
 		info0 = __le32_to_cpu(he_sig_a_mu_dl->info0);
 		info1 = __le32_to_cpu(he_sig_a_mu_dl->info1);
 
-		ppdu_info->bw =
-			FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_TRANSMIT_BW,
-				  info0);
-		cp_ltf = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_CP_LTF_SIZE,
-				   info0);
-
-		switch (cp_ltf) {
+		ppdu_info->he_mu_flags = 1;
+
+		ppdu_info->he_data1 = HE_MU_FORMAT_TYPE;
+		ppdu_info->he_data1 |=
+			HE_BSS_COLOR_KNOWN |
+			HE_DL_UL_KNOWN |
+			HE_LDPC_EXTRA_SYMBOL_KNOWN |
+			HE_STBC_KNOWN |
+			HE_DATA_BW_RU_KNOWN |
+			HE_DOPPLER_KNOWN;
+
+		ppdu_info->he_data2 =
+			HE_GI_KNOWN |
+			HE_LTF_SYMBOLS_KNOWN |
+			HE_PRE_FEC_PADDING_KNOWN |
+			HE_PE_DISAMBIGUITY_KNOWN |
+			HE_TXOP_KNOWN |
+			HE_MIDABLE_PERIODICITY_KNOWN;
+
+		/*data3*/
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_BSS_COLOR, info0);
+		ppdu_info->he_data3 = value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_UL_FLAG, info0);
+		value = value << HE_DL_UL_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_LDPC_EXTRA, info1);
+		value = value << HE_LDPC_EXTRA_SYMBOL_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC, info1);
+		he_stbc = value;
+		value = value << HE_STBC_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		/*data4*/
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_SPATIAL_REUSE, info0);
+		ppdu_info->he_data4 = value;
+
+		/*data5*/
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_TRANSMIT_BW, info0);
+		ppdu_info->he_data5 = value;
+		ppdu_info->bw = value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_CP_LTF_SIZE, info0);
+		switch (value) {
 		case 0:
+			he_gi = HE_GI_0_8;
+			he_ltf = HE_LTF_4_X;
+			break;
 		case 1:
-			ppdu_info->gi = HAL_RX_GI_0_8_US;
+			he_gi = HE_GI_0_8;
+			he_ltf = HE_LTF_2_X;
 			break;
 		case 2:
-			ppdu_info->gi = HAL_RX_GI_1_6_US;
+			he_gi = HE_GI_1_6;
+			he_ltf = HE_LTF_2_X;
 			break;
 		case 3:
-			ppdu_info->gi = HAL_RX_GI_3_2_US;
+			he_gi = HE_GI_3_2;
+			he_ltf = HE_LTF_4_X;
 			break;
 		}
+		ppdu_info->gi = he_gi;
+		value = he_gi << HE_GI_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		value = he_ltf << HE_LTF_SIZE_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_NUM_LTF_SYMB, info1);
+		value = (value << HE_LTF_SYM_SHIFT);
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_FACTOR, info1);
+		value = value << HE_PRE_FEC_PAD_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_PE_DISAM, info1);
+		value = value << HE_PE_DISAMBIGUITY_SHIFT;
+		ppdu_info->he_data5 |= value;
+
+		/*data6*/
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_DOPPLER_INDICATION, info0);
+		value = value << HE_DOPPLER_SHIFT;
+		ppdu_info->he_data6 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO1_TXOP_DURATION, info1);
+		value = value << HE_TXOP_SHIFT;
+		ppdu_info->he_data6 |= value;
+
+		/* HE-MU Flags */
+		/* HE-MU-flags1 */
+		ppdu_info->he_flags1 =
+			HE_SIG_B_MCS_KNOWN |
+			HE_SIG_B_DCM_KNOWN |
+			HE_SIG_B_COMPRESSION_FLAG_1_KNOWN |
+			HE_SIG_B_SYM_NUM_KNOWN |
+			HE_RU_0_KNOWN;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_MCS_OF_SIGB, info0);
+		ppdu_info->he_flags1 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_DCM_OF_SIGB, info0);
+		value = value << HE_DCM_FLAG_1_SHIFT;
+		ppdu_info->he_flags1 |= value;
+
+		/* HE-MU-flags2 */
+		ppdu_info->he_flags2 =
+			HE_BW_KNOWN;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_TRANSMIT_BW, info0);
+		ppdu_info->he_flags2 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_COMP_MODE_SIGB, info0);
+		value = value << HE_SIG_B_COMPRESSION_FLAG_2_SHIFT;
+		ppdu_info->he_flags2 |= value;
+		value = FIELD_GET(HAL_RX_HE_SIG_A_MU_DL_INFO0_NUM_SIGB_SYMB, info0);
+		value = value - 1;
+		value = value << HE_NUM_SIG_B_SYMBOLS_SHIFT;
+		ppdu_info->he_flags2 |= value;
 
 		ppdu_info->is_stbc = info1 &
-				     HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_STBC;
+				     HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 		break;
 	}
@@ -1048,6 +1365,7 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ru_tones = FIELD_GET(HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION,
 				     info0);
 		ppdu_info->ru_alloc = ath11k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+		ppdu_info->he_RU[0] = ru_tones;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 		break;
 	}
@@ -1057,14 +1375,25 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 
 		info0 = __le32_to_cpu(he_sig_b2_mu->info0);
 
+		ppdu_info->he_data1 |= HE_MCS_KNOWN | HE_CODING_KNOWN;
+
 		ppdu_info->mcs =
-			FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS,
-				  info0);
+			FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS, info0);
+		value = ppdu_info->mcs << HE_TRANSMIT_MCS_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING, info0);
+		ppdu_info->ldpc = value;
+		value = value << HE_CODING_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_ID, info0);
+		value = value << HE_STA_ID_SHIFT;
+		ppdu_info->he_data4 |= value;
+
 		ppdu_info->nss =
 			FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS,
 				  info0) + 1;
-		ppdu_info->ldpc = FIELD_GET(HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING,
-					    info0);
 		break;
 	}
 	case HAL_PHYRX_HE_SIG_B2_OFDMA: {
@@ -1073,17 +1402,37 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 
 		info0 = __le32_to_cpu(he_sig_b2_ofdma->info0);
 
+		ppdu_info->he_data1 |= HE_MCS_KNOWN | HE_DCM_KNOWN | HE_CODING_KNOWN;
+
+		/* HE-data2 */
+		ppdu_info->he_data2 |= HE_TXBF_KNOWN;
+
 		ppdu_info->mcs =
 			FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS,
 				  info0);
+		value = ppdu_info->mcs << HE_TRANSMIT_MCS_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_DCM, info0);
+		he_dcm = value;
+		value = value << HE_DCM_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		value = FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_CODING, info0);
+		ppdu_info->ldpc = value;
+		value = value << HE_CODING_SHIFT;
+		ppdu_info->he_data3 |= value;
+
+		/* HE-data4 */
+		value = FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_ID, info0);
+		value = value << HE_STA_ID_SHIFT;
+		ppdu_info->he_data4 |= value;
+
 		ppdu_info->nss =
 			FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS,
 				  info0) + 1;
 		ppdu_info->beamformed =
-			info0 &
-			HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF;
-		ppdu_info->ldpc = FIELD_GET(HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_CODING,
-					    info0);
+			info0 & HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF;
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
 		break;
 	}
@@ -1117,6 +1466,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->rx_duration =
 			FIELD_GET(HAL_RX_PPDU_END_DURATION,
 				  __le32_to_cpu(ppdu_rx_duration->info0));
+		ppdu_info->tsft = ppdu_rx_duration->rsvd0[1];
+		ppdu_info->tsft = (ppdu_info->tsft << 32) | ppdu_rx_duration->rsvd0[0];
 		break;
 	}
 	case HAL_DUMMY:
@@ -1140,12 +1491,14 @@ ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 	enum hal_rx_mon_status hal_status = HAL_RX_MON_STATUS_BUF_DONE;
 	u16 tlv_tag;
 	u16 tlv_len;
+	u32 tlv_userid = 0;
 	u8 *ptr = skb->data;
 
 	do {
 		tlv = (struct hal_tlv_hdr *)ptr;
 		tlv_tag = FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl);
 		tlv_len = FIELD_GET(HAL_TLV_HDR_LEN, tlv->tl);
+		tlv_userid = FIELD_GET(HAL_TLV_USR_ID, tlv->tl);
 		ptr += sizeof(*tlv);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
@@ -1157,7 +1510,7 @@ ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
 
 		hal_status = ath11k_hal_rx_parse_mon_status_tlv(ab, ppdu_info,
-								tlv_tag, ptr);
+								tlv_tag, ptr, tlv_userid);
 		ptr += tlv_len;
 		ptr = PTR_ALIGN(ptr, HAL_TLV_ALIGN);
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index e863e4abfcc1..7c4bcc4157de 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -77,6 +77,36 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_BUF_DONE,
 };
 
+struct hal_rx_user_status {
+	u32 mcs:4,
+	nss:3,
+	ofdma_info_valid:1,
+	dl_ofdma_ru_start_index:7,
+	dl_ofdma_ru_width:7,
+	dl_ofdma_ru_size:8;
+	u32 ul_ofdma_user_v0_word0;
+	u32 ul_ofdma_user_v0_word1;
+	u32 ast_index;
+	u32 tid;
+	u16 tcp_msdu_count;
+	u16 udp_msdu_count;
+	u16 other_msdu_count;
+	u16 frame_control;
+	u8 frame_control_info_valid;
+	u8 data_sequence_control_info_valid;
+	u16 first_data_seq_ctrl;
+	u32 preamble_type;
+	u16 ht_flags;
+	u16 vht_flags;
+	u16 he_flags;
+	u8 rs_flags;
+	u32 mpdu_cnt_fcs_ok;
+	u32 mpdu_cnt_fcs_err;
+	u32 mpdu_fcs_ok_bitmap[8];
+	u32 mpdu_ok_byte_count;
+	u32 mpdu_err_byte_count;
+};
+
 struct hal_rx_mon_ppdu_info {
 	u32 ppdu_id;
 	u32 ppdu_ts;
@@ -93,16 +123,59 @@ struct hal_rx_mon_ppdu_info {
 	u8 mcs;
 	u8 nss;
 	u8 bw;
+	u8 vht_flag_values1;
+	u8 vht_flag_values2;
+	u8 vht_flag_values3[4];
+	u8 vht_flag_values4;
+	u8 vht_flag_values5;
+	u16 vht_flag_values6;
 	u8 is_stbc;
 	u8 gi;
+	u8 sgi;
 	u8 ldpc;
 	u8 beamformed;
 	u8 rssi_comb;
 	u8 tid;
+	u16 ht_flags;
+	u16 vht_flags;
+	u16 he_flags;
+	u16 he_mu_flags;
 	u8 dcm;
 	u8 ru_alloc;
 	u8 reception_type;
+	u64 tsft;
 	u64 rx_duration;
+	u16 frame_control;
+	u32 ast_index;
+	u8 rs_fcs_err;
+	u8 rs_flags;
+	u8 cck_flag;
+	u8 ofdm_flag;
+	u8 ulofdma_flag;
+	u8 frame_control_info_valid;
+	u16 he_per_user_1;
+	u16 he_per_user_2;
+	u8 he_per_user_position;
+	u8 he_per_user_known;
+	u16 he_flags1;
+	u16 he_flags2;
+	u8 he_RU[4];
+	u16 he_data1;
+	u16 he_data2;
+	u16 he_data3;
+	u16 he_data4;
+	u16 he_data5;
+	u16 he_data6;
+	u32 ppdu_len;
+	u32 prev_ppdu_id;
+	u32 device_id;
+	u16 first_data_seq_ctrl;
+	u8 monitor_direct_used;
+	u8 data_sequence_control_info_valid;
+	u8 ltf_size;
+	u8 rxpcu_filter_pass;
+	char rssi_chain[8][8];
+	struct hal_rx_user_status userstats;
 };
 
 #define HAL_RX_PPDU_START_INFO0_PPDU_ID		GENMASK(15, 0)
@@ -135,6 +208,9 @@ struct hal_rx_ppdu_start {
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
 
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT	GENMASK(24, 0)
+
 struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd0[2];
 	__le32 info0;
@@ -145,10 +221,20 @@ struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd1[2];
 	__le32 info4;
 	__le32 info5;
-	__le32 info6;
+	__le32 info6; //byte 11
 	__le32 rsvd2[11];
 } __packed;
 
+struct hal_rx_ppdu_end_user_stats_ext {
+	u32 info0;
+	u32 info1;
+	u32 info2;
+	u32 info3;
+	u32 info4;
+	u32 info5;
+	u32 info6;
+} __packed;
+
 #define HAL_RX_HT_SIG_INFO_INFO0_MCS		GENMASK(6, 0)
 #define HAL_RX_HT_SIG_INFO_INFO0_BW		BIT(7)
 
@@ -197,25 +283,62 @@ enum hal_rx_vht_sig_a_gi_setting {
 	HAL_RX_VHT_SIG_A_SHORT_GI_AMBIGUITY = 3,
 };
 
+#define HAL_RX_SU_MU_CODING_LDPC 0x01
+
+#define HE_GI_0_8 0
+#define HE_GI_0_4 1
+#define HE_GI_1_6 2
+#define HE_GI_3_2 3
+
+#define HE_LTF_1_X 0
+#define HE_LTF_2_X 1
+#define HE_LTF_4_X 2
+#define HE_LTF_UNKNOWN 3
+
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_MCS	GENMASK(6, 3)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM		BIT(7)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_BW	GENMASK(20, 19)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_CP_LTF_SIZE	GENMASK(22, 21)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS		GENMASK(25, 23)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_BSS_COLOR		GENMASK(13, 8)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_SPATIAL_REUSE	GENMASK(18, 15)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_FORMAT_IND	BIT(0)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_BEAM_CHANGE	BIT(1)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_DL_UL_FLAG	BIT(2)
 
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXOP_DURATION	GENMASK(6, 0)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO1_CODING		BIT(7)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_LDPC_EXTRA	BIT(8)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO1_STBC		BIT(9)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXBF		BIT(10)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_PKT_EXT_FACTOR	GENMASK(12, 11)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_PKT_EXT_PE_DISAM	BIT(13)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_DOPPLER_IND	BIT(15)
 
 struct hal_rx_he_sig_a_su_info {
 	__le32 info0;
 	__le32 info1;
 } __packed;
 
-#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_TRANSMIT_BW	GENMASK(17, 15)
-#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_CP_LTF_SIZE	GENMASK(24, 23)
-
-#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_STBC		BIT(12)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_UL_FLAG		BIT(1)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_MCS_OF_SIGB		GENMASK(3, 1)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_DCM_OF_SIGB		BIT(4)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_BSS_COLOR		GENMASK(10, 5)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_SPATIAL_REUSE	GENMASK(14, 11)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_TRANSMIT_BW		GENMASK(17, 15)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_NUM_SIGB_SYMB	GENMASK(21, 18)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_COMP_MODE_SIGB	BIT(22)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_CP_LTF_SIZE		GENMASK(24, 23)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO0_DOPPLER_INDICATION	BIT(25)
+
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_TXOP_DURATION	GENMASK(6, 0)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_CODING		BIT(7)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_NUM_LTF_SYMB	GENMASK(10, 8)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_LDPC_EXTRA		BIT(11)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC		BIT(12)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_TXBF		BIT(10)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_FACTOR	GENMASK(14, 13)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_PE_DISAM	BIT(15)
 
 struct hal_rx_he_sig_a_mu_dl_info {
 	__le32 info0;
@@ -228,6 +351,7 @@ struct hal_rx_he_sig_b1_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_ID		GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS		GENMASK(18, 15)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING	BIT(20)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS		GENMASK(31, 29)
@@ -236,6 +360,7 @@ struct hal_rx_he_sig_b2_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_ID	GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS	GENMASK(13, 11)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(19)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS	GENMASK(18, 15)
@@ -359,4 +484,95 @@ static inline u32 ath11k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1 0xADBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2 0xBDBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3 0xCDBEEF
+
+/* HE Radiotap data1 Mask */
+#define HE_SU_FORMAT_TYPE 0x0000
+#define HE_EXT_SU_FORMAT_TYPE 0x0001
+#define HE_MU_FORMAT_TYPE  0x0002
+#define HE_TRIG_FORMAT_TYPE  0x0003
+#define HE_BEAM_CHANGE_KNOWN 0x0008
+#define HE_DL_UL_KNOWN 0x0010
+#define HE_MCS_KNOWN 0x0020
+#define HE_DCM_KNOWN 0x0040
+#define HE_CODING_KNOWN 0x0080
+#define HE_LDPC_EXTRA_SYMBOL_KNOWN 0x0100
+#define HE_STBC_KNOWN 0x0200
+#define HE_DATA_BW_RU_KNOWN 0x4000
+#define HE_DOPPLER_KNOWN 0x8000
+#define HE_BSS_COLOR_KNOWN 0x0004
+
+/* HE Radiotap data2 Mask */
+#define HE_GI_KNOWN 0x0002
+#define HE_TXBF_KNOWN 0x0010
+#define HE_PE_DISAMBIGUITY_KNOWN 0x0020
+#define HE_TXOP_KNOWN 0x0040
+#define HE_LTF_SYMBOLS_KNOWN 0x0004
+#define HE_PRE_FEC_PADDING_KNOWN 0x0008
+#define HE_MIDABLE_PERIODICITY_KNOWN 0x0080
+
+/* HE radiotap data3 shift values */
+#define HE_BEAM_CHANGE_SHIFT 6
+#define HE_DL_UL_SHIFT 7
+#define HE_TRANSMIT_MCS_SHIFT 8
+#define HE_DCM_SHIFT 12
+#define HE_CODING_SHIFT 13
+#define HE_LDPC_EXTRA_SYMBOL_SHIFT 14
+#define HE_STBC_SHIFT 15
+
+/* HE radiotap data4 shift values */
+#define HE_STA_ID_SHIFT 4
+
+/* HE radiotap data5 */
+#define HE_GI_SHIFT 4
+#define HE_LTF_SIZE_SHIFT 6
+#define HE_LTF_SYM_SHIFT 8
+#define HE_TXBF_SHIFT 14
+#define HE_PE_DISAMBIGUITY_SHIFT 15
+#define HE_PRE_FEC_PAD_SHIFT 12
+
+/* HE radiotap data6 */
+#define HE_DOPPLER_SHIFT 4
+#define HE_TXOP_SHIFT 8
+
+/* HE radiotap HE-MU flags1 */
+#define HE_SIG_B_MCS_KNOWN 0x0010
+#define HE_SIG_B_DCM_KNOWN 0x0040
+#define HE_SIG_B_SYM_NUM_KNOWN 0x8000
+#define HE_RU_0_KNOWN 0x0100
+#define HE_RU_1_KNOWN 0x0200
+#define HE_RU_2_KNOWN 0x0400
+#define HE_RU_3_KNOWN 0x0800
+#define HE_DCM_FLAG_1_SHIFT 5
+#define HE_SPATIAL_REUSE_MU_KNOWN 0x0100
+#define HE_SIG_B_COMPRESSION_FLAG_1_KNOWN 0x4000
+
+/* HE radiotap HE-MU flags2 */
+#define HE_SIG_B_COMPRESSION_FLAG_2_SHIFT 3
+#define HE_BW_KNOWN 0x0004
+#define HE_NUM_SIG_B_SYMBOLS_SHIFT 4
+#define HE_SIG_B_COMPRESSION_FLAG_2_KNOWN 0x0100
+#define HE_NUM_SIG_B_FLAG_2_SHIFT 9
+#define HE_LTF_FLAG_2_SYMBOLS_SHIFT 12
+#define HE_LTF_KNOWN 0x8000
+
+/* HE radiotap per_user_1 */
+#define HE_STA_SPATIAL_SHIFT 11
+#define HE_TXBF_SHIFT 14
+#define HE_RESERVED_SET_TO_1_SHIFT 19
+#define HE_STA_CODING_SHIFT 20
+
+/* HE radiotap per_user_2 */
+#define HE_STA_MCS_SHIFT 4
+#define HE_STA_DCM_SHIFT 5
+
+/* HE radiotap per user known */
+#define HE_USER_FIELD_POSITION_KNOWN 0x01
+#define HE_STA_ID_PER_USER_KNOWN 0x02
+#define HE_STA_NSTS_KNOWN 0x04
+#define HE_STA_TX_BF_KNOWN 0x08
+#define HE_STA_SPATIAL_CONFIG_KNOWN 0x10
+#define HE_STA_MCS_KNOWN 0x20
+#define HE_STA_DCM_KNOWN 0x40
+#define HE_STA_CODING_KNOWN 0x80
+
 #endif
-- 
2.20.1

