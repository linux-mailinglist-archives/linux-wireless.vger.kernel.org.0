Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650F696546
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHTPt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:49:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbfHTPt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:49:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FDFC61AFB; Tue, 20 Aug 2019 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316197;
        bh=CVNPaV0BPGTuBslM85B0hs3CKkDIFJC5oGpUaBi2UKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRPU/MOT+Zz6pkgSGgCNHPyn7KqzfUouLxegl2+Oz0GJ9gf+OZdX+1OFgSNM/riBF
         vheJq5otAXBCvzsa5BcuUTwEMUhVZTni37W7hAWnHjOleBBsTc7jVfA1V+4x3t+/Bp
         CoDJzL+rnder5DqmKkR1ttMRw8DFVEixsL8QzWRI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A38D61AD8;
        Tue, 20 Aug 2019 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316171;
        bh=CVNPaV0BPGTuBslM85B0hs3CKkDIFJC5oGpUaBi2UKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9w1KgwAS/npxj97+l+OpCnx26nwBJl2G2pzIGwHSgdXD7aI6+vdHJbJJ7brvJmWN
         ypBT+PfhrdHECjMUtXhVNBoF6Mi2BKbu50t87djfpLPWnzjF/nngC+jzLDzGr4cxQV
         JTXJC1m8SlzYwRbbrRrYaCeKIIbb5Ni42DBrJMI4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A38D61AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 25/49] ath11k: add hal_rx.h
Date:   Tue, 20 Aug 2019 18:47:51 +0300
Message-Id: <1566316095-27507-26-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/hal_rx.h | 352 +++++++++++++++++++++++++++++++
 1 file changed, 352 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
new file mode 100644
index 000000000000..d854b47270c0
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -0,0 +1,352 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_HAL_RX_H
+#define ATH11K_HAL_RX_H
+
+struct hal_rx_mpdu_meta {
+	u32 peer_meta;
+	u16 msdu_cnt;
+	u16 seq_num;
+	bool frag;
+	bool retry;
+	bool ampdu;
+	bool raw;
+};
+
+struct hal_rx_msdu_meta {
+	u32 cookie;
+	u32 msdu_len;
+	bool first;
+	bool last;
+	bool continuation;
+};
+
+struct hal_rx_meta_info {
+	enum hal_reo_dest_ring_push_reason push_reason;
+	struct hal_rx_mpdu_meta mpdu_meta;
+	struct hal_rx_msdu_meta msdu_meta;
+};
+
+struct hal_rx_wbm_rel_info {
+	u32 cookie;
+	enum hal_wbm_rel_src_module err_rel_src;
+	enum hal_reo_dest_ring_push_reason push_reason;
+	u32 err_code;
+	bool first_msdu;
+	bool last_msdu;
+};
+
+#define HAL_INVALID_PEERID 0xffff
+#define VHT_SIG_SU_NSS_MASK 0x7
+
+#define HAL_RX_MAX_MCS 12
+#define HAL_RX_MAX_NSS 8
+
+struct hal_rx_mon_status_tlv_hdr {
+	u32 hdr;
+	u8 value[0];
+};
+
+enum hal_rx_su_mu_coding {
+	HAL_RX_SU_MU_CODING_BCC,
+	HAL_RX_SU_MU_CODING_LDPC,
+	HAL_RX_SU_MU_CODING_MAX,
+};
+
+enum hal_rx_gi {
+	HAL_RX_GI_0_8_US,
+	HAL_RX_GI_0_4_US,
+	HAL_RX_GI_1_6_US,
+	HAL_RX_GI_3_2_US,
+	HAL_RX_GI_MAX,
+};
+
+enum hal_rx_bw {
+	HAL_RX_BW_20MHZ,
+	HAL_RX_BW_40MHZ,
+	HAL_RX_BW_80MHZ,
+	HAL_RX_BW_160MHZ,
+	HAL_RX_BW_MAX,
+};
+
+enum hal_rx_preamble {
+	HAL_RX_PREAMBLE_11A,
+	HAL_RX_PREAMBLE_11B,
+	HAL_RX_PREAMBLE_11N,
+	HAL_RX_PREAMBLE_11AC,
+	HAL_RX_PREAMBLE_11AX,
+	HAL_RX_PREAMBLE_MAX,
+};
+
+enum hal_rx_reception_type {
+	HAL_RX_RECEPTION_TYPE_SU,
+	HAL_RX_RECEPTION_TYPE_MU_MIMO,
+	HAL_RX_RECEPTION_TYPE_MU_OFDMA,
+	HAL_RX_RECEPTION_TYPE_MU_OFDMA_MIMO,
+	HAL_RX_RECEPTION_TYPE_MAX,
+};
+
+#define HAL_TLV_STATUS_PPDU_NOT_DONE            0
+#define HAL_TLV_STATUS_PPDU_DONE                1
+#define HAL_TLV_STATUS_BUF_DONE                 2
+#define HAL_TLV_STATUS_PPDU_NON_STD_DONE        3
+#define HAL_RX_FCS_LEN                          4
+
+enum hal_rx_mon_status {
+	HAL_RX_MON_STATUS_PPDU_NOT_DONE,
+	HAL_RX_MON_STATUS_PPDU_DONE,
+	HAL_RX_MON_STATUS_BUF_DONE,
+};
+
+struct hal_rx_mon_ppdu_info {
+	u32 ppdu_id;
+	u32 ppdu_ts;
+	u32 num_mpdu_fcs_ok;
+	u32 num_mpdu_fcs_err;
+	u32 preamble_type;
+	u16 chan_num;
+	u16 tcp_msdu_count;
+	u16 tcp_ack_msdu_count;
+	u16 udp_msdu_count;
+	u16 other_msdu_count;
+	u16 peer_id;
+	u8 rate;
+	u8 mcs;
+	u8 nss;
+	u8 bw;
+	u8 is_stbc;
+	u8 gi;
+	u8 ldpc;
+	u8 beamformed;
+	u8 rssi_comb;
+	u8 tid;
+	u8 reception_type;
+	u64 rx_duration;
+};
+
+#define HAL_RX_PPDU_START_INFO0_PPDU_ID		GENMASK(15, 0)
+
+struct hal_rx_ppdu_start {
+	__le32 info0;
+	__le32 chan_num;
+	__le32 ppdu_start_ts;
+} __packed;
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR	GENMASK(25, 16)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_MPDU_CNT_FCS_OK	GENMASK(8, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID		BIT(9)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_QOS_CTRL_VALID		BIT(10)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_HT_CTRL_VALID		BIT(11)
+#define HAL_RX_PPDU_END_USER_STATS_INFO1_PKT_TYPE		GENMASK(23, 20)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX		GENMASK(15, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO2_FRAME_CTRL		GENMASK(31, 16)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO3_QOS_CTRL		GENMASK(31, 16)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO4_UDP_MSDU_CNT		GENMASK(15, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO4_TCP_MSDU_CNT		GENMASK(31, 16)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO5_OTHER_MSDU_CNT		GENMASK(15, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO5_TCP_ACK_MSDU_CNT	GENMASK(31, 16)
+
+#define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP		GENMASK(15, 0)
+#define HAL_RX_PPDU_END_USER_STATS_INFO6_TID_EOSP_BITMAP	GENMASK(31, 16)
+
+struct hal_rx_ppdu_end_user_stats {
+	__le32 rsvd0[2];
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+	__le32 ht_ctrl;
+	__le32 rsvd1[2];
+	__le32 info4;
+	__le32 info5;
+	__le32 info6;
+	__le32 rsvd2[11];
+} __packed;
+
+#define HAL_RX_HT_SIG_INFO_INFO0_MCS		GENMASK(6, 0)
+#define HAL_RX_HT_SIG_INFO_INFO0_BW		BIT(7)
+
+#define HAL_RX_HT_SIG_INFO_INFO1_STBC		GENMASK(5, 4)
+#define HAL_RX_HT_SIG_INFO_INFO1_FEC_CODING	BIT(6)
+#define HAL_RX_HT_SIG_INFO_INFO1_GI		BIT(7)
+
+struct hal_rx_ht_sig_info {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+#define HAL_RX_LSIG_B_INFO_INFO0_RATE	GENMASK(3, 0)
+#define HAL_RX_LSIG_B_INFO_INFO0_LEN	GENMASK(15, 4)
+
+struct hal_rx_lsig_b_info {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_LSIG_A_INFO_INFO0_RATE		GENMASK(3, 0)
+#define HAL_RX_LSIG_A_INFO_INFO0_LEN		GENMASK(16, 5)
+#define HAL_RX_LSIG_A_INFO_INFO0_PKT_TYPE	GENMASK(27, 24)
+
+struct hal_rx_lsig_a_info {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_VHT_SIG_A_INFO_INFO0_BW		GENMASK(1, 0)
+#define HAL_RX_VHT_SIG_A_INFO_INFO0_STBC	BIT(3)
+#define HAL_RX_VHT_SIG_A_INFO_INFO0_GROUP_ID	GENMASK(9, 4)
+#define HAL_RX_VHT_SIG_A_INFO_INFO0_NSTS	GENMASK(21, 10)
+
+#define HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING		GENMASK(1, 0)
+#define HAL_RX_VHT_SIG_A_INFO_INFO1_SU_MU_CODING	BIT(2)
+#define HAL_RX_VHT_SIG_A_INFO_INFO1_MCS			GENMASK(7, 4)
+#define HAL_RX_VHT_SIG_A_INFO_INFO1_BEAMFORMED		BIT(8)
+
+struct hal_rx_vht_sig_a_info {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_MCS	GENMASK(6, 3)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM		BIT(7)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_BW	GENMASK(20, 19)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_CP_LTF_SIZE	GENMASK(22, 21)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO0_NSTS		GENMASK(25, 23)
+
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_CODING		BIT(7)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_STBC		BIT(9)
+#define HAL_RX_HE_SIG_A_SU_INFO_INFO1_TXBF		BIT(10)
+
+struct hal_rx_he_sig_a_su_info {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_TRANSMIT_BW	GENMASK(17, 15)
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO0_CP_LTF_SIZE	GENMASK(24, 23)
+
+#define HAL_RX_HE_SIG_A_MU_DL_INFO_INFO1_STBC		BIT(12)
+
+struct hal_rx_he_sig_a_mu_dl_info {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+#define HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION	GENMASK(7, 0)
+
+struct hal_rx_he_sig_b1_mu_info {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_MCS		GENMASK(18, 15)
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_CODING	BIT(20)
+#define HAL_RX_HE_SIG_B2_MU_INFO_INFO0_STA_NSTS		GENMASK(31, 29)
+
+struct hal_rx_he_sig_b2_mu_info {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_NSTS	GENMASK(13, 11)
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_TXBF	BIT(19)
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_MCS	GENMASK(18, 15)
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_DCM	BIT(19)
+#define HAL_RX_HE_SIG_B2_OFDMA_INFO_INFO0_STA_CODING	BIT(20)
+
+struct hal_rx_he_sig_b2_ofdma_info {
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
+
+struct hal_rx_phyrx_rssi_legacy_info {
+	__le32 rsvd[35];
+	__le32 info0;
+} __packed;
+
+#define HAL_RX_MPDU_INFO_INFO0_PEERID	GENMASK(31, 16)
+struct hal_rx_mpdu_info {
+	__le32 rsvd0;
+	__le32 info0;
+	__le32 rsvd1[21];
+} __packed;
+
+#define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
+struct hal_rx_ppdu_end_duration {
+	__le32 rsvd0[9];
+	__le32 info0;
+	__le32 rsvd1[4];
+} __packed;
+
+struct hal_rx_rxpcu_classification_overview {
+	u32 rsvd0;
+} __packed;
+
+struct hal_rx_msdu_desc_info {
+	u32 msdu_flags;
+	u16 msdu_len; /* 14 bits for length */
+};
+
+#define HAL_RX_NUM_MSDU_DESC 6
+struct hal_rx_msdu_list {
+	struct hal_rx_msdu_desc_info msdu_info[HAL_RX_NUM_MSDU_DESC];
+	u32 sw_cookie[HAL_RX_NUM_MSDU_DESC];
+	u8 rbm[HAL_RX_NUM_MSDU_DESC];
+};
+
+void ath11k_hal_reo_status_queue_stats(struct ath11k_base *ab, u32 *reo_desc,
+				       struct hal_reo_status *status);
+void ath11k_hal_reo_flush_queue_status(struct ath11k_base *ab, u32 *reo_desc,
+				       struct hal_reo_status *status);
+void ath11k_hal_reo_flush_cache_status(struct ath11k_base *ab, u32 *reo_desc,
+				       struct hal_reo_status *status);
+void ath11k_hal_reo_flush_cache_status(struct ath11k_base *ab, u32 *reo_desc,
+				       struct hal_reo_status *status);
+void ath11k_hal_reo_unblk_cache_status(struct ath11k_base *ab, u32 *reo_desc,
+				       struct hal_reo_status *status);
+void ath11k_hal_reo_flush_timeout_list_status(struct ath11k_base *ab,
+					      u32 *reo_desc,
+					      struct hal_reo_status *status);
+void ath11k_hal_reo_desc_thresh_reached_status(struct ath11k_base *ab,
+					       u32 *reo_desc,
+					       struct hal_reo_status *status);
+void ath11k_hal_reo_update_rx_reo_queue_status(struct ath11k_base *ab,
+					       u32 *reo_desc,
+					       struct hal_reo_status *status);
+int ath11k_hal_reo_process_status(u8 *reo_desc, u8 *status);
+void ath11k_hal_rx_msdu_link_info_get(void *link_desc, u32 *num_msdus,
+				      struct hal_rx_msdu_meta *meta,
+				      enum hal_rx_buf_return_buf_manager *rbm);
+void ath11k_hal_rx_msdu_link_desc_set(struct ath11k_base *ab, void *desc,
+				      void *link_desc,
+				      enum hal_wbm_rel_bm_act action);
+void ath11k_hal_rx_buf_addr_info_set(void *desc, dma_addr_t paddr,
+				     u32 cookie, u8 manager);
+void ath11k_hal_rx_buf_addr_info_get(void *desc, dma_addr_t *paddr,
+				     u32 *cookie, u8 *rbm);
+int ath11k_hal_desc_reo_parse_err(struct ath11k_base *ab, u32 *rx_desc,
+				  dma_addr_t *paddr, u32 *desc_bank);
+void ath11k_hal_rx_parse_dst_ring_desc(struct ath11k_base *ab, u32 *rx_desc,
+				       struct hal_rx_meta_info *meta_info);
+int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
+				  struct hal_rx_wbm_rel_info *rel_info);
+void ath11k_hal_rx_reo_ent_paddr_get(struct ath11k_base *ab, void *desc,
+				     dma_addr_t *paddr, u32 *desc_bank);
+void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc,
+					 dma_addr_t *paddr, u32 *sw_cookie,
+					 void **pp_buf_addr_info,
+					 u32 *msdu_cnt);
+enum hal_rx_mon_status
+ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
+			       struct hal_rx_mon_ppdu_info *ppdu_info,
+			       struct sk_buff *skb);
+#define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0 0xDDBEEF
+#define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1 0xADBEEF
+#define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2 0xBDBEEF
+#define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3 0xCDBEEF
+#endif

