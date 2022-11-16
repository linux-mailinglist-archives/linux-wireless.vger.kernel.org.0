Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97F062C50D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiKPQoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiKPQnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683C6567
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B396F61EEC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE02C433C1;
        Wed, 16 Nov 2022 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616774;
        bh=+70Y5sJc8kp4qcrR7GwFhWpeZR5mZ5XSWXvkap53iZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUtCp2fiZuQ8EfeT9hluhyneen1KedQ4NXdsD4TLRRTwSlmNh2HWLaUrNhhNCFcBU
         jL1yoHo4sNqjQrTcuY6qSdvjf+Tp6jCOdqOTUKcNBHqKpWKA3kIiQ6CYBitspe7cZr
         Ytntycz+UWGXSXDinV7LFSyge0tit8HDCfdo859KDuZXKl1Q5Wg1w4AKdm/3E89pOZ
         H4c9qzbNGi2c9j+DydGi2W0w0ZaPeIOwBgvzdBMa4IfC0yN7kexfp1bYCX6VBN8j/W
         N5piLjc+/Nu6XKYpZlTre7jTbMfxFpn0Pw6ytNqkbYpts1So/u4caCUztVo7BnUK6j
         c7ASnAYGVOrGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 25/50] wifi: ath12k: add hal_tx.h
Date:   Wed, 16 Nov 2022 18:38:37 +0200
Message-Id: <20221116163902.24996-26-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_tx.h | 194 +++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/hal_tx.h
new file mode 100644
index 000000000000..7c837094a6f7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_HAL_TX_H
+#define ATH12K_HAL_TX_H
+
+#include "hal_desc.h"
+#include "core.h"
+
+#define HAL_TX_ADDRX_EN			1
+#define HAL_TX_ADDRY_EN			2
+
+#define HAL_TX_ADDR_SEARCH_DEFAULT	0
+#define HAL_TX_ADDR_SEARCH_INDEX	1
+
+/* TODO: check all these data can be managed with struct ath12k_tx_desc_info for perf */
+struct hal_tx_info {
+	u16 meta_data_flags; /* %HAL_TCL_DATA_CMD_INFO0_META_ */
+	u8 ring_id;
+	u8 rbm_id;
+	u32 desc_id;
+	enum hal_tcl_desc_type type;
+	enum hal_tcl_encap_type encap_type;
+	dma_addr_t paddr;
+	u32 data_len;
+	u32 pkt_offset;
+	enum hal_encrypt_type encrypt_type;
+	u32 flags0; /* %HAL_TCL_DATA_CMD_INFO1_ */
+	u32 flags1; /* %HAL_TCL_DATA_CMD_INFO2_ */
+	u16 addr_search_flags; /* %HAL_TCL_DATA_CMD_INFO0_ADDR(X/Y)_ */
+	u16 bss_ast_hash;
+	u16 bss_ast_idx;
+	u8 tid;
+	u8 search_type; /* %HAL_TX_ADDR_SEARCH_ */
+	u8 lmac_id;
+	u8 vdev_id;
+	u8 dscp_tid_tbl_idx;
+	bool enable_mesh;
+	int bank_id;
+};
+
+/* TODO: Check if the actual desc macros can be used instead */
+#define HAL_TX_STATUS_FLAGS_FIRST_MSDU		BIT(0)
+#define HAL_TX_STATUS_FLAGS_LAST_MSDU		BIT(1)
+#define HAL_TX_STATUS_FLAGS_MSDU_IN_AMSDU	BIT(2)
+#define HAL_TX_STATUS_FLAGS_RATE_STATS_VALID	BIT(3)
+#define HAL_TX_STATUS_FLAGS_RATE_LDPC		BIT(4)
+#define HAL_TX_STATUS_FLAGS_RATE_STBC		BIT(5)
+#define HAL_TX_STATUS_FLAGS_OFDMA		BIT(6)
+
+#define HAL_TX_STATUS_DESC_LEN		sizeof(struct hal_wbm_release_ring)
+
+/* Tx status parsed from srng desc */
+struct hal_tx_status {
+	enum hal_wbm_rel_src_module buf_rel_source;
+	enum hal_wbm_tqm_rel_reason status;
+	u8 ack_rssi;
+	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
+	u32 ppdu_id;
+	u8 try_cnt;
+	u8 tid;
+	u16 peer_id;
+	u32 rate_stats;
+};
+
+#define HAL_TX_PHY_DESC_INFO0_BF_TYPE		GENMASK(17, 16)
+#define HAL_TX_PHY_DESC_INFO0_PREAMBLE_11B	BIT(20)
+#define HAL_TX_PHY_DESC_INFO0_PKT_TYPE		GENMASK(24, 21)
+#define HAL_TX_PHY_DESC_INFO0_BANDWIDTH		GENMASK(30, 28)
+#define HAL_TX_PHY_DESC_INFO1_MCS		GENMASK(3, 0)
+#define HAL_TX_PHY_DESC_INFO1_STBC		BIT(6)
+#define HAL_TX_PHY_DESC_INFO2_NSS		GENMASK(23, 21)
+#define HAL_TX_PHY_DESC_INFO3_AP_PKT_BW		GENMASK(6, 4)
+#define HAL_TX_PHY_DESC_INFO3_LTF_SIZE		GENMASK(20, 19)
+#define HAL_TX_PHY_DESC_INFO3_ACTIVE_CHANNEL	GENMASK(17, 15)
+
+struct hal_tx_phy_desc {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+} __packed;
+
+#define HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_15_0	GENMASK(15, 0)
+#define HAL_TX_FES_STAT_PROT_INFO0_STRT_FRM_TS_31_16	GENMASK(31, 16)
+#define HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_15_0	GENMASK(15, 0)
+#define HAL_TX_FES_STAT_PROT_INFO1_END_FRM_TS_31_16	GENMASK(31, 16)
+
+struct hal_tx_fes_status_prot {
+	__le64 reserved;
+	__le32 info0;
+	__le32 info1;
+	__le32 reserved1[11];
+} __packed;
+
+#define HAL_TX_FES_STAT_USR_PPDU_INFO0_DURATION		GENMASK(15, 0)
+
+struct hal_tx_fes_status_user_ppdu {
+	__le64 reserved;
+	__le32 info0;
+	__le32 reserved1[3];
+} __packed;
+
+#define HAL_TX_FES_STAT_STRT_INFO0_PROT_TS_LOWER_32	GENMASK(31, 0)
+#define HAL_TX_FES_STAT_STRT_INFO1_PROT_TS_UPPER_32	GENMASK(31, 0)
+
+struct hal_tx_fes_status_start_prot {
+	__le32 info0;
+	__le32 info1;
+	__le64 reserved;
+} __packed;
+
+#define HAL_TX_FES_STATUS_START_INFO0_MEDIUM_PROT_TYPE	GENMASK(29, 27)
+
+struct hal_tx_fes_status_start {
+	__le32 reserved;
+	__le32 info0;
+	__le64 reserved1;
+} __packed;
+
+#define HAL_TX_Q_EXT_INFO0_FRAME_CTRL		GENMASK(15, 0)
+#define HAL_TX_Q_EXT_INFO0_QOS_CTRL		GENMASK(31, 16)
+#define HAL_TX_Q_EXT_INFO1_AMPDU_FLAG		BIT(0)
+
+struct hal_tx_queue_exten {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+#define HAL_TX_FES_SETUP_INFO0_NUM_OF_USERS	GENMASK(28, 23)
+
+struct hal_tx_fes_setup {
+	__le32 schedule_id;
+	__le32 info0;
+	__le64 reserved;
+} __packed;
+
+#define HAL_TX_PPDU_SETUP_INFO0_MEDIUM_PROT_TYPE	GENMASK(2, 0)
+#define HAL_TX_PPDU_SETUP_INFO1_PROT_FRAME_ADDR1_31_0	GENMASK(31, 0)
+#define HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR1_47_32	GENMASK(15, 0)
+#define HAL_TX_PPDU_SETUP_INFO2_PROT_FRAME_ADDR2_15_0	GENMASK(31, 16)
+#define HAL_TX_PPDU_SETUP_INFO3_PROT_FRAME_ADDR2_47_16	GENMASK(31, 0)
+#define HAL_TX_PPDU_SETUP_INFO4_PROT_FRAME_ADDR3_31_0	GENMASK(31, 0)
+#define HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR3_47_32	GENMASK(15, 0)
+#define HAL_TX_PPDU_SETUP_INFO5_PROT_FRAME_ADDR4_15_0	GENMASK(31, 16)
+#define HAL_TX_PPDU_SETUP_INFO6_PROT_FRAME_ADDR4_47_16	GENMASK(31, 0)
+
+struct hal_tx_pcu_ppdu_setup_init {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	__le32 info3;
+	__le32 reserved;
+	__le32 info4;
+	__le32 info5;
+	__le32 info6;
+} __packed;
+
+#define HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_15_0	GENMASK(15, 0)
+#define HAL_TX_FES_STATUS_END_INFO0_START_TIMESTAMP_31_16	GENMASK(31, 16)
+
+struct hal_tx_fes_status_end {
+	__le32 reserved[2];
+	__le32 info0;
+	__le32 reserved1[19];
+} __packed;
+
+#define HAL_TX_BANK_CONFIG_EPD			BIT(0)
+#define HAL_TX_BANK_CONFIG_ENCAP_TYPE		GENMASK(2, 1)
+#define HAL_TX_BANK_CONFIG_ENCRYPT_TYPE		GENMASK(6, 3)
+#define HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP	BIT(7)
+#define HAL_TX_BANK_CONFIG_LINK_META_SWAP	BIT(8)
+#define HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN	BIT(9)
+#define HAL_TX_BANK_CONFIG_ADDRX_EN		BIT(10)
+#define HAL_TX_BANK_CONFIG_ADDRY_EN		BIT(11)
+#define HAL_TX_BANK_CONFIG_MESH_EN		GENMASK(13, 12)
+#define HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN	BIT(14)
+#define HAL_TX_BANK_CONFIG_PMAC_ID		GENMASK(16, 15)
+/* STA mode will have MCAST_PKT_CTRL instead of DSCP_TID_MAP bitfield */
+#define HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID	GENMASK(22, 17)
+
+void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
+				  struct hal_tcl_data_cmd *tcl_cmd,
+				  struct hal_tx_info *ti);
+void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id);
+int ath12k_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
+			    enum hal_reo_cmd_type type,
+			    struct ath12k_hal_reo_cmd *cmd);
+void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab, u32 bank_config,
+					   u8 bank_id);
+#endif

