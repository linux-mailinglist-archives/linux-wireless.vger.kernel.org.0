Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF61859138E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiHLQK7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiHLQKq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8B1A4B06
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D611E61593
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF90C433D6;
        Fri, 12 Aug 2022 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320638;
        bh=vgfSKMtKaBN3ogJfHWfP9Jjm90ATfwOXTe+0jCgywmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nH6Xsf0Tsoc/qr5A9PFs/4XKuzWHj+WNz6SIcAiplfl4mbcvBbkcdnNXmYcyn7DOx
         30APnlsgpiq34v5xN41Vgb197teW0keJKSVUfgYLTjLkjfj1F4Bwq2FeV5h/gmEC0g
         Mz7QgsMa19TQv5/zK106NL8MBar4xvuV7Tvr2bW+AFqL2F4z4dt4hD39rhmlP+BGG1
         qY/QAxhsmZZXZgAE4DVWgb1w1nwzHNsmtyv2vv/ugnM9sx1Lqc0c3lZmHxk4At2tzk
         /+/zz54vrTjNXSQNEiJcA7o+82snovfhYywrwungDbjURrRJuy4kv7PmfoB4kC4UC2
         w/ZhwXbLFFwuw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 30/50] wifi: ath12k: add hw.h
Date:   Fri, 12 Aug 2022 19:09:43 +0300
Message-Id: <20220812161003.27279-31-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/net/wireless/ath/ath12k/hw.h | 284 +++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
new file mode 100644
index 000000000000..f6b9b9f55d34
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_HW_H
+#define ATH12K_HW_H
+
+#include <linux/mhi.h>
+
+#include "wmi.h"
+#include "hal.h"
+
+/* Target configuration defines */
+
+/* Num VDEVS per radio */
+#define TARGET_NUM_VDEVS	(16 + 1)
+
+#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+
+/* Num of peers for Single Radio mode */
+#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
+
+/* Num of peers for DBS */
+#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV)
+
+/* Num of peers for DBS_SBS */
+#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
+
+/* Max num of stations (per radio) */
+#define TARGET_NUM_STATIONS	512
+
+#define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
+#define TARGET_NUM_PEER_KEYS	2
+#define TARGET_NUM_TIDS(x)	(2 * TARGET_NUM_PEERS(x) + \
+				 4 * TARGET_NUM_VDEVS + 8)
+
+#define TARGET_AST_SKID_LIMIT	16
+#define TARGET_NUM_OFFLD_PEERS	4
+#define TARGET_NUM_OFFLD_REORDER_BUFFS 4
+
+#define TARGET_TX_CHAIN_MASK	(BIT(0) | BIT(1) | BIT(2) | BIT(4))
+#define TARGET_RX_CHAIN_MASK	(BIT(0) | BIT(1) | BIT(2) | BIT(4))
+#define TARGET_RX_TIMEOUT_LO_PRI	100
+#define TARGET_RX_TIMEOUT_HI_PRI	40
+
+#define TARGET_DECAP_MODE_RAW		0
+#define TARGET_DECAP_MODE_NATIVE_WIFI	1
+#define TARGET_DECAP_MODE_ETH		2
+
+#define TARGET_SCAN_MAX_PENDING_REQS	4
+#define TARGET_BMISS_OFFLOAD_MAX_VDEV	3
+#define TARGET_ROAM_OFFLOAD_MAX_VDEV	3
+#define TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES	8
+#define TARGET_GTK_OFFLOAD_MAX_VDEV	3
+#define TARGET_NUM_MCAST_GROUPS		12
+#define TARGET_NUM_MCAST_TABLE_ELEMS	64
+#define TARGET_MCAST2UCAST_MODE		2
+#define TARGET_TX_DBG_LOG_SIZE		1024
+#define TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
+#define TARGET_VOW_CONFIG		0
+#define TARGET_NUM_MSDU_DESC		(2500)
+#define TARGET_MAX_FRAG_ENTRIES		6
+#define TARGET_MAX_BCN_OFFLD		16
+#define TARGET_NUM_WDS_ENTRIES		32
+#define TARGET_DMA_BURST_SIZE		1
+#define TARGET_RX_BATCHMODE		1
+
+#define ATH12K_HW_MAX_QUEUES		4
+#define ATH12K_QUEUE_LEN		4096
+
+#define ATH12K_HW_RATECODE_CCK_SHORT_PREAM_MASK  0x4
+
+#define ATH12K_FW_DIR			"ath12k"
+
+#define ATH12K_BOARD_MAGIC		"QCA-ATH12K-BOARD"
+#define ATH12K_BOARD_API2_FILE		"board-2.bin"
+#define ATH12K_DEFAULT_BOARD_FILE	"board.bin"
+#define ATH12K_DEFAULT_CAL_FILE		"caldata.bin"
+#define ATH12K_AMSS_FILE		"amss.bin"
+#define ATH12K_M3_FILE			"m3.bin"
+#define ATH12K_REGDB_FILE_NAME		"regdb.bin"
+
+enum ath12k_hw_rate_cck {
+	ATH12K_HW_RATE_CCK_LP_11M = 0,
+	ATH12K_HW_RATE_CCK_LP_5_5M,
+	ATH12K_HW_RATE_CCK_LP_2M,
+	ATH12K_HW_RATE_CCK_LP_1M,
+	ATH12K_HW_RATE_CCK_SP_11M,
+	ATH12K_HW_RATE_CCK_SP_5_5M,
+	ATH12K_HW_RATE_CCK_SP_2M,
+};
+
+enum ath12k_hw_rate_ofdm {
+	ATH12K_HW_RATE_OFDM_48M = 0,
+	ATH12K_HW_RATE_OFDM_24M,
+	ATH12K_HW_RATE_OFDM_12M,
+	ATH12K_HW_RATE_OFDM_6M,
+	ATH12K_HW_RATE_OFDM_54M,
+	ATH12K_HW_RATE_OFDM_36M,
+	ATH12K_HW_RATE_OFDM_18M,
+	ATH12K_HW_RATE_OFDM_9M,
+};
+
+enum ath12k_bus {
+	ATH12K_BUS_PCI,
+};
+
+#define ATH12K_EXT_IRQ_GRP_NUM_MAX 11
+
+struct hal_rx_desc;
+struct hal_tcl_data_cmd;
+struct htt_rx_ring_tlv_filter;
+enum hal_encrypt_type;
+
+struct ath12k_hw_ring_mask {
+	u8 tx[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 rx_mon_dest[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 rx[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 rx_err[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 rx_wbm_rel[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 reo_status[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 host2rxdma[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+	u8 tx_mon_dest[ATH12K_EXT_IRQ_GRP_NUM_MAX];
+};
+
+struct ath12k_hw_hal_params {
+	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
+	u32	  wbm2sw_cc_enable;
+};
+
+struct ath12k_hw_params {
+	const char *name;
+	u16 hw_rev;
+
+	struct {
+		const char *dir;
+		size_t board_size;
+		size_t cal_offset;
+	} fw;
+
+	u8 max_radios;
+	bool single_pdev_only:1;
+	u32 qmi_service_ins_id;
+	bool internal_sleep_clock:1;
+
+	const struct ath12k_hw_ops *hw_ops;
+	const struct ath12k_hw_ring_mask *ring_mask;
+	const struct ath12k_hw_regs *regs;
+
+	const struct ce_attr *host_ce_config;
+	u32 ce_count;
+	const struct ce_pipe_config *target_ce_config;
+	u32 target_ce_count;
+	const struct service_to_pipe *svc_to_ce_map;
+	u32 svc_to_ce_map_len;
+
+	const struct ath12k_hw_hal_params *hal_params;
+
+	bool rxdma1_enable:1;
+	int num_rxmda_per_pdev;
+	int num_rxdma_dst_ring;
+	bool rx_mac_buf_ring:1;
+	bool vdev_start_delay:1;
+
+	u16 interface_modes;
+	bool supports_monitor:1;
+
+	bool idle_ps:1;
+	bool download_calib:1;
+	bool supports_suspend:1;
+	bool tcl_ring_retry:1;
+	bool reoq_lut_support:1;
+	bool supports_shadow_regs:1;
+
+	u32 hal_desc_sz;
+	u32 num_tcl_banks;
+	u32 max_tx_ring;
+	bool static_window_map:1;
+
+	struct mhi_controller_config *mhi_config;
+
+	void (*wmi_init)(struct ath12k_base *ab,
+			 struct ath12k_wmi_resource_config_arg *config);
+
+	const struct hal_ops *hal_ops;
+
+	const char *qdss_config;
+	unsigned int qdss_config_len;
+};
+
+struct ath12k_hw_ops {
+	u8 (*get_hw_mac_from_pdev_id)(int pdev_id);
+	int (*mac_id_to_pdev_id)(const struct ath12k_hw_params *hw, int mac_id);
+	int (*mac_id_to_srng_id)(const struct ath12k_hw_params *hw, int mac_id);
+	int (*rxdma_ring_sel_config)(struct ath12k_base *ab);
+	u8 (*get_ring_selector)(struct sk_buff *skb);
+	bool (*dp_srng_is_tx_comp_ring)(int ring_num);
+};
+
+static inline
+int ath12k_hw_get_mac_from_pdev_id(const struct ath12k_hw_params *hw,
+				   int pdev_idx)
+{
+	if (hw->hw_ops->get_hw_mac_from_pdev_id)
+		return hw->hw_ops->get_hw_mac_from_pdev_id(pdev_idx);
+
+	return 0;
+}
+
+static inline int ath12k_hw_mac_id_to_pdev_id(const struct ath12k_hw_params *hw,
+					      int mac_id)
+{
+	if (hw->hw_ops->mac_id_to_pdev_id)
+		return hw->hw_ops->mac_id_to_pdev_id(hw, mac_id);
+
+	return 0;
+}
+
+static inline int ath12k_hw_mac_id_to_srng_id(const struct ath12k_hw_params *hw,
+					      int mac_id)
+{
+	if (hw->hw_ops->mac_id_to_srng_id)
+		return hw->hw_ops->mac_id_to_srng_id(hw, mac_id);
+
+	return 0;
+}
+
+struct ath12k_fw_ie {
+	__le32 id;
+	__le32 len;
+	u8 data[];
+};
+
+enum ath12k_bd_ie_board_type {
+	ATH12K_BD_IE_BOARD_NAME = 0,
+	ATH12K_BD_IE_BOARD_DATA = 1,
+};
+
+enum ath12k_bd_ie_type {
+	/* contains sub IEs of enum ath12k_bd_ie_board_type */
+	ATH12K_BD_IE_BOARD = 0,
+	ATH12K_BD_IE_BOARD_EXT = 1,
+};
+
+struct ath12k_hw_regs {
+	u32 hal_tcl1_ring_id;
+	u32 hal_tcl1_ring_misc;
+	u32 hal_tcl1_ring_tp_addr_lsb;
+	u32 hal_tcl1_ring_tp_addr_msb;
+	u32 hal_tcl1_ring_consumer_int_setup_ix0;
+	u32 hal_tcl1_ring_consumer_int_setup_ix1;
+	u32 hal_tcl1_ring_msi1_base_lsb;
+	u32 hal_tcl1_ring_msi1_base_msb;
+	u32 hal_tcl1_ring_msi1_data;
+	u32 hal_tcl_ring_base_lsb;
+
+	u32 hal_tcl_status_ring_base_lsb;
+
+	u32 hal_wbm_idle_ring_base_lsb;
+	u32 hal_wbm_idle_ring_misc_addr;
+	u32 hal_wbm_r0_idle_list_cntl_addr;
+	u32 hal_wbm_r0_idle_list_size_addr;
+	u32 hal_wbm_scattered_ring_base_lsb;
+	u32 hal_wbm_scattered_ring_base_msb;
+	u32 hal_wbm_scattered_desc_head_info_ix0;
+	u32 hal_wbm_scattered_desc_head_info_ix1;
+	u32 hal_wbm_scattered_desc_tail_info_ix0;
+	u32 hal_wbm_scattered_desc_tail_info_ix1;
+	u32 hal_wbm_scattered_desc_ptr_hp_addr;
+
+	u32 hal_wbm_sw_release_ring_base_lsb;
+	u32 hal_wbm_sw1_release_ring_base_lsb;
+	u32 hal_wbm0_release_ring_base_lsb;
+	u32 hal_wbm1_release_ring_base_lsb;
+
+	u32 pcie_qserdes_sysclk_en_sel;
+	u32 pcie_pcs_osc_dtct_config_base;
+};
+
+int ath12k_hw_init(struct ath12k_base *ab);
+
+#endif

