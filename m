Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACAA32F64C
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 00:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCEXEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 18:04:12 -0500
Received: from z11.mailgun.us ([104.130.96.11]:39593 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhCEXD6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 18:03:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614985437; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=52aLQBi4pTxsSaRgMTF2reTfBgzIt+ifJ5UPtdC+HEc=; b=c03YQr6QFTRKl9Y1AUOfWoX8Uj9YvXhTAQeqczEfo2Q2Fkxel0jJKjRKNLGj8UM5NJniV3g0
 rS1MekbMaRzQlnxjCQ6QukvdvlIFDTYudPZyMTd525fmt33HrRUNV66opb+jnZXpsNzR7R4Z
 JnaCu1EHWCV+Dc7fjfCIntmN1e4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6042b8d481003345dc32cd27 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Mar 2021 23:03:48
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3D17C43462; Fri,  5 Mar 2021 23:03:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08691C433CA;
        Fri,  5 Mar 2021 23:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08691C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>
Subject: [PATCH v7 2/3] ath11k: decode HE status tlv
Date:   Fri,  5 Mar 2021 15:03:36 -0800
Message-Id: <20210305230337.23047-3-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305230337.23047-1-pradeepc@codeaurora.org>
References: <20210305230337.23047-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new bitmasks and macro definitions required for parsing HE
status tlvs. Decode HE status tlvs, which will used in dumping
ppdu stats as well as updating radiotap headers.

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c    |  99 ++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 135 ++++++++++++++++++++-
 3 files changed, 214 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1d9aa1bb6b6e..659e0e68444e 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2369,7 +2369,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	char tid[32];
 
 	status = IEEE80211_SKB_RXCB(msdu);
-	if (status->encoding == RX_ENC_HE) {
+	if (status->encoding == RX_ENC_HE && !(status->flag & RX_FLAG_RADIOTAP_HE)) {
 		he = skb_push(msdu, sizeof(known));
 		memcpy(he, &known, sizeof(known));
 		status->flag |= RX_FLAG_RADIOTAP_HE;
@@ -4712,7 +4712,6 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf;
-	u32 wifi_hdr_len;
 	struct hal_rx_desc *rx_desc;
 	char *hdr_desc;
 	u8 *dest, decap_format;
@@ -4751,38 +4750,27 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 
 		skb_trim(prev_buf, prev_buf->len - HAL_RX_FCS_LEN);
 	} else if (decap_format == DP_RX_DECAP_TYPE_NATIVE_WIFI) {
-		__le16 qos_field;
 		u8 qos_pkt = 0;
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
 		hdr_desc = ath11k_dp_rxdesc_get_80211hdr(ab, rx_desc);
 
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
-			hdr_desc = ath11k_dp_rxdesc_get_80211hdr(ab, rx_desc);
-
+			ath11k_dp_rx_msdus_set_payload(ar, msdu);
 			if (qos_pkt) {
 				dest = skb_push(msdu, sizeof(__le16));
 				if (!dest)
 					goto err_merge_fail;
-				memcpy(dest, hdr_desc, wifi_hdr_len);
-				memcpy(dest + wifi_hdr_len,
-				       (u8 *)&qos_field, sizeof(__le16));
+				memcpy(dest, hdr_desc, sizeof(struct ieee80211_qos_hdr));
 			}
-			ath11k_dp_rx_msdus_set_payload(ar, msdu);
 			prev_buf = msdu;
 			msdu = msdu->next;
 		}
@@ -4812,8 +4800,83 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
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
@@ -4843,8 +4906,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 		} else {
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
-		rxs->flag |= RX_FLAG_ONLY_MONITOR;
-
+		ath11k_update_radiotap(ppduinfo, mon_skb, rxs);
 		status = IEEE80211_SKB_RXCB(mon_skb);
 		*status = *rxs;
 
@@ -4920,6 +4982,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 		}
 		if (head_msdu && tail_msdu) {
 			ath11k_dp_rx_mon_deliver(ar, dp->mac_id, head_msdu,
+						 &pmon->mon_ppdu_info,
 						 tail_msdu, napi);
 			rx_mon_stats->dest_mpdu_done++;
 		}
@@ -4966,6 +5029,8 @@ static void ath11k_dp_rx_mon_status_process_tlv(struct ath11k *ar,
 	while (!skb_queue_empty(&pmon->rx_status_q)) {
 		status_skb = skb_dequeue(&pmon->rx_status_q);
 
+		memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
+
 		tlv_status = ath11k_hal_rx_parse_mon_status(ar->ab, ppdu_info,
 							    status_skb);
 		if (tlv_status == HAL_TLV_STATUS_PPDU_DONE) {
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index d54ec6aa6281..e661448136eb 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -474,6 +474,7 @@ enum hal_tlv_tag {
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
 #define HAL_TLV_HDR_LEN		GENMASK(25, 10)
+#define HAL_TLV_USR_ID		GENMASK(31, 26)
 
 #define HAL_TLV_ALIGN	4
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index d464a270c049..61afcbdbb55c 100644
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
@@ -93,16 +123,58 @@ struct hal_rx_mon_ppdu_info {
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
@@ -135,6 +207,9 @@ struct hal_rx_ppdu_start {
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
 
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT	GENMASK(24, 0)
+
 struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd0[2];
 	__le32 info0;
@@ -149,6 +224,16 @@ struct hal_rx_ppdu_end_user_stats {
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
 
@@ -197,25 +282,62 @@ enum hal_rx_vht_sig_a_gi_setting {
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
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_UL_FLAG		BIT(1)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_MCS_OF_SIGB		GENMASK(3, 1)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_DCM_OF_SIGB		BIT(4)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_BSS_COLOR		GENMASK(10, 5)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_SPATIAL_REUSE	GENMASK(14, 11)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_TRANSMIT_BW		GENMASK(17, 15)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_NUM_SIGB_SYMB	GENMASK(21, 18)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_COMP_MODE_SIGB	BIT(22)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_CP_LTF_SIZE		GENMASK(24, 23)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_DOPPLER_INDICATION	BIT(25)
+
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_TXOP_DURATION	GENMASK(6, 0)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_CODING		BIT(7)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_NUM_LTF_SYMB	GENMASK(10, 8)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_LDPC_EXTRA		BIT(11)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_STBC		BIT(12)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_TXBF		BIT(10)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_PKT_EXT_FACTOR	GENMASK(14, 13)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_PKT_EXT_PE_DISAM	BIT(15)
 
 struct hal_rx_he_sig_a_mu_dl_info {
 	__le32 info0;
@@ -228,6 +350,7 @@ struct hal_rx_he_sig_b1_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_ID		GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS		GENMASK(18, 15)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING	BIT(20)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS		GENMASK(31, 29)
@@ -236,6 +359,7 @@ struct hal_rx_he_sig_b2_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_ID	GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS	GENMASK(13, 11)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(19)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS	GENMASK(18, 15)
@@ -254,10 +378,13 @@ struct hal_rx_phyrx_rssi_legacy_info {
 } __packed;
 
 #define HAL_RX_MPDU_INFO_INFO0_PEERID	GENMASK(31, 16)
+#define HAL_RX_MPDU_INFO_INFO1_MPDU_LEN        GENMASK(13, 0)
 struct hal_rx_mpdu_info {
 	__le32 rsvd0;
 	__le32 info0;
-	__le32 rsvd1[21];
+	__le32 rsvd1[11];
+	__le32 info1;
+	__le32 rsvd2[9];
 } __packed;
 
 #define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
-- 
2.17.1

