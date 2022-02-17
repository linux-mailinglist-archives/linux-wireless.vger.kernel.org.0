Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4614B957F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiBQB0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 20:26:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiBQB0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 20:26:41 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 17:26:27 PST
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 660072E088
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 17:26:27 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645061187; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MqRTXDpO5iZms6C0Mq0JiB9hb2sNIMM/28rGwLJCcJ0=; b=o7/aCBDD3zFO7ewPTh6mWnTF+29p/pcwyWFUYPceMnlZImY3WAp+xBfQS6VG2/VowtrUxMUF
 mSVkihgEwDkf9eftFEVl87WZPIer7E3DQrf/qbZj/UZXgGSjNZz9JCptH6JF3zhb+tXQpOmz
 QcmAISt62CPWuTBByUn3PvWHQ/I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 620da3143047cf1c0a5f1e1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Feb 2022 01:21:24
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D146C43616; Thu, 17 Feb 2022 01:21:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CB7DC4338F;
        Thu, 17 Feb 2022 01:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 2CB7DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>
Subject: [PATCH v10 2/3] ath11k: decode HE status tlv
Date:   Wed, 16 Feb 2022 17:21:11 -0800
Message-Id: <20220217012112.31211-3-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217012112.31211-1-pradeepc@codeaurora.org>
References: <20220217012112.31211-1-pradeepc@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/dp_rx.c    |  96 ++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_desc.h |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 135 ++++++++++++++++++++-
 3 files changed, 213 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 20c9e7904261..e990da019068 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4807,7 +4807,6 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct sk_buff *msdu, *prev_buf;
-	u32 wifi_hdr_len;
 	struct hal_rx_desc *rx_desc;
 	char *hdr_desc;
 	u8 *dest, decap_format;
@@ -4849,38 +4848,27 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 
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
@@ -4904,8 +4892,83 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
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
@@ -4940,7 +5003,7 @@ static int ath11k_dp_rx_mon_deliver(struct ath11k *ar, u32 mac_id,
 		} else {
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
-		rxs->flag |= RX_FLAG_ONLY_MONITOR;
+		ath11k_update_radiotap(ppduinfo, mon_skb, rxs);
 
 		ath11k_dp_rx_deliver_msdu(ar, napi, mon_skb, rxs);
 		mon_skb = skb_next;
@@ -5045,6 +5108,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 		}
 		if (head_msdu && tail_msdu) {
 			ath11k_dp_rx_mon_deliver(ar, dp->mac_id, head_msdu,
+						 &pmon->mon_ppdu_info,
 						 tail_msdu, napi);
 			rx_mon_stats->dest_mpdu_done++;
 		}
@@ -5114,6 +5178,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		if (log_type != ATH11K_PKTLOG_TYPE_INVALID)
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
+		memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
 		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
 
 		if (test_bit(ATH11K_FLAG_MONITOR_STARTED, &ar->monitor_flags) &&
@@ -5374,6 +5439,7 @@ static int ath11k_dp_rx_full_mon_deliver_ppdu(struct ath11k *ar,
 		tail_msdu = mon_mpdu->tail;
 		if (head_msdu && tail_msdu) {
 			ret = ath11k_dp_rx_mon_deliver(ar, mac_id, head_msdu,
+						       &pmon->mon_ppdu_info,
 						       tail_msdu, napi);
 			rx_mon_stats->dest_mpdu_done++;
 			ath11k_dbg(ar->ab, ATH11K_DBG_DATA, "full mon: deliver ppdu\n");
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 406767672844..24e72e75a8c7 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -474,6 +474,7 @@ enum hal_tlv_tag {
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
 #define HAL_TLV_HDR_LEN		GENMASK(25, 10)
+#define HAL_TLV_USR_ID		GENMASK(31, 26)
 
 #define HAL_TLV_ALIGN	4
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 7bba4f0411e1..f6bae07abfd3 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -73,6 +73,36 @@ enum hal_rx_mon_status {
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
 #define HAL_TLV_STATUS_PPDU_NOT_DONE    HAL_RX_MON_STATUS_PPDU_NOT_DONE
 #define HAL_TLV_STATUS_PPDU_DONE        HAL_RX_MON_STATUS_PPDU_DONE
 #define HAL_TLV_STATUS_BUF_DONE         HAL_RX_MON_STATUS_BUF_DONE
@@ -107,6 +137,12 @@ struct hal_rx_mon_ppdu_info {
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
@@ -114,10 +150,46 @@ struct hal_rx_mon_ppdu_info {
 	u8 rssi_comb;
 	u8 rssi_chain_pri20[HAL_RX_MAX_NSS];
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
@@ -150,6 +222,9 @@ struct hal_rx_ppdu_start {
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
 #define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
 
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_6_MPDU_OK_BYTE_COUNT	GENMASK(24, 0)
+#define HAL_RX_PPDU_END_USER_STATS_RSVD2_8_MPDU_ERR_BYTE_COUNT	GENMASK(24, 0)
+
 struct hal_rx_ppdu_end_user_stats {
 	__le32 rsvd0[2];
 	__le32 info0;
@@ -164,6 +239,16 @@ struct hal_rx_ppdu_end_user_stats {
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
 
@@ -212,25 +297,62 @@ enum hal_rx_vht_sig_a_gi_setting {
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
@@ -243,6 +365,7 @@ struct hal_rx_he_sig_b1_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_ID		GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS		GENMASK(18, 15)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING	BIT(20)
 #define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS		GENMASK(31, 29)
@@ -251,6 +374,7 @@ struct hal_rx_he_sig_b2_mu_info {
 	__le32 info0;
 } __packed;
 
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_ID	GENMASK(10, 0)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS	GENMASK(13, 11)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(19)
 #define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS	GENMASK(18, 15)
@@ -279,11 +403,14 @@ struct hal_rx_phyrx_rssi_legacy_info {
 
 #define HAL_RX_MPDU_INFO_INFO0_PEERID	GENMASK(31, 16)
 #define HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855	GENMASK(15, 0)
+#define HAL_RX_MPDU_INFO_INFO1_MPDU_LEN		GENMASK(13, 0)
 
 struct hal_rx_mpdu_info {
 	__le32 rsvd0;
 	__le32 info0;
-	__le32 rsvd1[21];
+	__le32 rsvd1[11];
+	__le32 info1;
+	__le32 rsvd2[9];
 } __packed;
 
 struct hal_rx_mpdu_info_wcn6855 {
-- 
2.17.1

