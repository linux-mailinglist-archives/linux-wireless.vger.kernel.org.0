Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46C94A2E1F
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiA2LQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37886 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237273AbiA2LQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:35 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDlia-0002ji-JR;
        Sat, 29 Jan 2022 13:16:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:19 +0200
Message-Id: <iwlwifi.20220129105618.715f04ecc635.Ib89a6caa06c1324c1c0dd3f9f4cf7407f2857155@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: yoyo: add IMR DRAM dump support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Support debug collection of the platform IMR memory region,
where data is copied by FW during d3 state

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 97 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  8 ++
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 19 ++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 34 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 30 ++++--
 .../wireless/intel/iwlwifi/pcie/internal.h    | 24 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 28 +++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 42 +++++++-
 8 files changed, 269 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 101d9085e835..d3e1c89d9be7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -12,7 +12,7 @@
 #include "iwl-io.h"
 #include "iwl-prph.h"
 #include "iwl-csr.h"
-
+#include "iwl-fh.h"
 /**
  * struct iwl_fw_dump_ptrs - set of pointers needed for the fw-error-dump
  *
@@ -1598,6 +1598,33 @@ static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int iwl_dump_ini_imr_iter(struct iwl_fw_runtime *fwrt,
+				 struct iwl_dump_ini_region_data *reg_data,
+				 void *range_ptr, u32 range_len, int idx)
+{
+	/* read the IMR memory and DMA it to SRAM */
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	u64 imr_curr_addr = fwrt->trans->dbg.imr_data.imr_curr_addr;
+	u32 imr_rem_bytes = fwrt->trans->dbg.imr_data.imr2sram_remainbyte;
+	u32 sram_addr = fwrt->trans->dbg.imr_data.sram_addr;
+	u32 sram_size = fwrt->trans->dbg.imr_data.sram_size;
+	u32 size_to_dump = (imr_rem_bytes > sram_size) ? sram_size : imr_rem_bytes;
+
+	range->range_data_size = cpu_to_le32(size_to_dump);
+	if (iwl_trans_write_imr_mem(fwrt->trans, sram_addr,
+				    imr_curr_addr, size_to_dump)) {
+		IWL_ERR(fwrt, "WRT_DEBUG: IMR Memory transfer failed\n");
+		return -1;
+	}
+
+	fwrt->trans->dbg.imr_data.imr_curr_addr = imr_curr_addr + size_to_dump;
+	fwrt->trans->dbg.imr_data.imr2sram_remainbyte -= size_to_dump;
+
+	iwl_trans_read_mem_bytes(fwrt->trans, sram_addr, range->data,
+				 size_to_dump);
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static void *
 iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data,
@@ -1736,6 +1763,18 @@ iwl_dump_ini_special_mem_fill_header(struct iwl_fw_runtime *fwrt,
 	return dump->data;
 }
 
+static void *
+iwl_dump_ini_imr_fill_header(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data,
+			     void *data, u32 data_len)
+{
+	struct iwl_fw_ini_error_dump *dump = data;
+
+	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
+
+	return dump->data;
+}
+
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1795,6 +1834,26 @@ static u32 iwl_dump_ini_single_range(struct iwl_fw_runtime *fwrt,
 	return 1;
 }
 
+static u32 iwl_dump_ini_imr_ranges(struct iwl_fw_runtime *fwrt,
+				   struct iwl_dump_ini_region_data *reg_data)
+{
+	/* range is total number of pages need to copied from
+	 *IMR memory to SRAM and later from SRAM to DRAM
+	 */
+	u32 imr_enable = fwrt->trans->dbg.imr_data.imr_enable;
+	u32 imr_size = fwrt->trans->dbg.imr_data.imr_size;
+	u32 sram_size = fwrt->trans->dbg.imr_data.sram_size;
+
+	if (imr_enable == 0 || imr_size == 0 || sram_size == 0) {
+		IWL_DEBUG_INFO(fwrt,
+			       "WRT: Invalid imr data enable: %d, imr_size: %d, sram_size: %d\n",
+			       imr_enable, imr_size, sram_size);
+		return 0;
+	}
+
+	return((imr_size % sram_size) ? (imr_size / sram_size + 1) : (imr_size / sram_size));
+}
+
 static u32 iwl_dump_ini_mem_get_size(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1973,6 +2032,33 @@ iwl_dump_ini_fw_pkt_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32
+iwl_dump_ini_imr_get_size(struct iwl_fw_runtime *fwrt,
+			  struct iwl_dump_ini_region_data *reg_data)
+{
+	u32 size = 0;
+	u32 ranges = 0;
+	u32 imr_enable = fwrt->trans->dbg.imr_data.imr_enable;
+	u32 imr_size = fwrt->trans->dbg.imr_data.imr_size;
+	u32 sram_size = fwrt->trans->dbg.imr_data.sram_size;
+
+	if (imr_enable == 0 || imr_size == 0 || sram_size == 0) {
+		IWL_DEBUG_INFO(fwrt,
+			       "WRT: Invalid imr data enable: %d, imr_size: %d, sram_size: %d\n",
+			       imr_enable, imr_size, sram_size);
+		return size;
+	}
+	size = imr_size;
+	ranges = iwl_dump_ini_imr_ranges(fwrt, reg_data);
+	if (!size && !ranges) {
+		IWL_ERR(fwrt, "WRT: imr_size :=%d, ranges :=%d\n", size, ranges);
+		return 0;
+	}
+	size += sizeof(struct iwl_fw_ini_error_dump) +
+		ranges * sizeof(struct iwl_fw_ini_error_dump_range);
+	return size;
+}
+
 /**
  * struct iwl_dump_ini_mem_ops - ini memory dump operations
  * @get_num_of_ranges: returns the number of memory ranges in the region.
@@ -2040,7 +2126,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	size = ops->get_size(fwrt, reg_data);
 
 	if (size < sizeof(*header)) {
-		IWL_DEBUG_FW(fwrt, "WRT: size didn't include space for haeder\n");
+		IWL_DEBUG_FW(fwrt, "WRT: size didn't include space for header\n");
 		return 0;
 	}
 
@@ -2295,7 +2381,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_csr_iter,
 	},
-	[IWL_FW_INI_REGION_DRAM_IMR] = {},
+	[IWL_FW_INI_REGION_DRAM_IMR] = {
+		.get_num_of_ranges = iwl_dump_ini_imr_ranges,
+		.get_size = iwl_dump_ini_imr_get_size,
+		.fill_mem_hdr = iwl_dump_ini_imr_fill_header,
+		.fill_range = iwl_dump_ini_imr_iter,
+	},
 	[IWL_FW_INI_REGION_PCI_IOSF_CONFIG] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 9a58eca7e2c8..9346cf92322e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -211,6 +211,14 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 		return -EOPNOTSUPP;
 	}
 
+	if (type == IWL_FW_INI_REGION_INTERNAL_BUFFER) {
+		trans->dbg.imr_data.sram_addr =
+			le32_to_cpu(reg->internal_buffer.base_addr);
+		trans->dbg.imr_data.sram_size =
+			le32_to_cpu(reg->internal_buffer.size);
+	}
+
+
 	active_reg = &trans->dbg.active_regions[id];
 	if (*active_reg) {
 		IWL_WARN(trans, "WRT: Overriding region id %u\n", id);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 5558f9925e11..bedd78a47f67 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -596,6 +596,25 @@ struct iwl_rb_status {
 #define IWL_NUM_OF_TBS		20
 #define IWL_TFH_NUM_TBS		25
 
+/* IMR DMA registers */
+#define IMR_TFH_SRV_DMA_CHNL0_CTRL           0x00a0a51c
+#define IMR_TFH_SRV_DMA_CHNL0_SRAM_ADDR      0x00a0a520
+#define IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_LSB  0x00a0a524
+#define IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_MSB  0x00a0a528
+#define IMR_TFH_SRV_DMA_CHNL0_BC             0x00a0a52c
+#define TFH_SRV_DMA_CHNL0_LEFT_BC	     0x00a0a530
+
+/* RFH S2D DMA registers */
+#define IMR_RFH_GEN_CFG_SERVICE_DMA_RS_MSK	0x0000000c
+#define IMR_RFH_GEN_CFG_SERVICE_DMA_SNOOP_MSK	0x00000002
+
+/* TFH D2S DMA registers */
+#define IMR_UREG_CHICK_HALT_UMAC_PERMANENTLY_MSK	0x80000000
+#define IMR_UREG_CHICK					0x00d05c00
+#define IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_IRQ_TARGET_POS	0x00800000
+#define IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_RS_MSK		0x00000030
+#define IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_DMA_EN_POS	0x80000000
+
 static inline u8 iwl_get_dma_hi_addr(dma_addr_t addr)
 {
 	return (sizeof(addr) > sizeof(u32) ? upper_32_bits(addr) : 0) & 0xF;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1bcaa3598785..6a4d3eafdc19 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -615,6 +615,10 @@ struct iwl_trans_ops {
 	int (*set_reduce_power)(struct iwl_trans *trans,
 				const void *data, u32 len);
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
+	int (*imr_dma_data)(struct iwl_trans *trans,
+			    u32 dst_addr, u64 src_addr,
+			    u32 byte_cnt);
+
 };
 
 /**
@@ -721,6 +725,26 @@ struct iwl_self_init_dram {
 	int paging_cnt;
 };
 
+/**
+ * struct iwl_imr_data - imr dram data used during debug process
+ * @imr_enable: imr enable status received from fw
+ * @imr_size: imr dram size received from fw
+ * @sram_addr: sram address from debug tlv
+ * @sram_size: sram size from debug tlv
+ * @imr2sram_remainbyte`: size remained after each dma transfer
+ * @imr_curr_addr: current dst address used during dma transfer
+ * @imr_base_addr: imr address received from fw
+ */
+struct iwl_imr_data {
+	u32 imr_enable;
+	u32 imr_size;
+	u32 sram_addr;
+	u32 sram_size;
+	u32 imr2sram_remainbyte;
+	u64 imr_curr_addr;
+	__le64 imr_base_addr;
+};
+
 /**
  * struct iwl_trans_debug - transport debug related data
  *
@@ -785,6 +809,7 @@ struct iwl_trans_debug {
 	u32 ucode_preset;
 	bool restart_required;
 	u32 last_tp_resetfw;
+	struct iwl_imr_data imr_data;
 };
 
 struct iwl_dma_ptr {
@@ -1368,6 +1393,15 @@ static inline int iwl_trans_read_mem(struct iwl_trans *trans, u32 addr,
 		iwl_trans_read_mem(trans, addr, buf, (bufsize) / sizeof(u32));\
 	} while (0)
 
+static inline int iwl_trans_write_imr_mem(struct iwl_trans *trans,
+					  u32 dst_addr, u64 src_addr,
+					  u32 byte_cnt)
+{
+	if (trans->ops->imr_dma_data)
+		return trans->ops->imr_dma_data(trans, dst_addr, src_addr, byte_cnt);
+	return 0;
+}
+
 static inline u32 iwl_trans_read_mem32(struct iwl_trans *trans, u32 addr)
 {
 	u32 value;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fcbe7c3656ad..14e067c834e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -127,12 +127,30 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u32 version = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
 					      UCODE_ALIVE_NTFY, 0);
 
-	/*
-	 * For v5 and above, we can check the version, for older
-	 * versions we need to check the size.
-	 */
-	if (version == 5 || version == 6) {
-		/* v5 and v6 are compatible (only IMR addition) */
+	if (version == 6) {
+		struct iwl_alive_ntf_v6 *palive;
+
+		if (pkt_len < sizeof(*palive))
+			return false;
+
+		palive = (void *)pkt->data;
+		mvm->trans->dbg.imr_data.imr_enable =
+			le32_to_cpu(palive->imr.enabled);
+		mvm->trans->dbg.imr_data.imr_size =
+			le32_to_cpu(palive->imr.size);
+		mvm->trans->dbg.imr_data.imr2sram_remainbyte =
+			mvm->trans->dbg.imr_data.imr_size;
+		mvm->trans->dbg.imr_data.imr_base_addr =
+			palive->imr.base_addr;
+		mvm->trans->dbg.imr_data.imr_curr_addr =
+			le64_to_cpu(mvm->trans->dbg.imr_data.imr_base_addr);
+		IWL_DEBUG_FW(mvm, "IMR Enabled: 0x0%x  size 0x0%x Address 0x%016llx\n",
+			     mvm->trans->dbg.imr_data.imr_enable,
+			     mvm->trans->dbg.imr_data.imr_size,
+			     le64_to_cpu(mvm->trans->dbg.imr_data.imr_base_addr));
+	}
+
+	if (version >= 5) {
 		struct iwl_alive_ntf_v5 *palive;
 
 		if (pkt_len < sizeof(*palive))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 6dce36d32693..3cddc3e6db53 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -261,6 +261,20 @@ enum iwl_pcie_fw_reset_state {
 	FW_RESET_ERROR,
 };
 
+/**
+ * enum wl_pcie_imr_status - imr dma transfer state
+ * @IMR_D2S_IDLE: default value of the dma transfer
+ * @IMR_D2S_REQUESTED: dma transfer requested
+ * @IMR_D2S_COMPLETED: dma transfer completed
+ * @IMR_D2S_ERROR: dma transfer error
+ */
+enum iwl_pcie_imr_status {
+	IMR_D2S_IDLE,
+	IMR_D2S_REQUESTED,
+	IMR_D2S_COMPLETED,
+	IMR_D2S_ERROR,
+};
+
 /**
  * struct iwl_trans_pcie - PCIe transport specific data
  * @rxq: all the RX queue data
@@ -319,6 +333,8 @@ enum iwl_pcie_fw_reset_state {
  * @alloc_page_lock: spinlock for the page allocator
  * @alloc_page: allocated page to still use parts of
  * @alloc_page_used: how much of the allocated page was already used (bytes)
+ * @imr_status: imr dma state machine
+ * @wait_queue_head_t: imr wait queue for dma completion
  * @rf_name: name/version of the CRF, if any
  */
 struct iwl_trans_pcie {
@@ -414,7 +430,8 @@ struct iwl_trans_pcie {
 	bool fw_reset_handshake;
 	enum iwl_pcie_fw_reset_state fw_reset_state;
 	wait_queue_head_t fw_reset_waitq;
-
+	enum iwl_pcie_imr_status imr_status;
+	wait_queue_head_t imr_waitq;
 	char rf_name[32];
 };
 
@@ -809,4 +826,9 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			       struct iwl_host_cmd *cmd);
 int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 			  struct iwl_host_cmd *cmd);
+void iwl_trans_pcie_copy_imr_fh(struct iwl_trans *trans,
+				u32 dst_addr, u64 src_addr, u32 byte_cnt);
+int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
+			    u32 dst_addr, u64 src_addr, u32 byte_cnt);
+
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 21cddfc279d4..bda98c2eb0ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1996,6 +1996,11 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 		/* Wake up uCode load routine, now that load is complete */
 		trans_pcie->ucode_write_complete = true;
 		wake_up(&trans_pcie->ucode_write_waitq);
+		/* Wake up IMR write routine, now that write to SRAM is complete */
+		if (trans_pcie->imr_status == IMR_D2S_REQUESTED) {
+			trans_pcie->imr_status = IMR_D2S_COMPLETED;
+			wake_up(&trans_pcie->ucode_write_waitq);
+		}
 	}
 
 	if (inta & ~handled) {
@@ -2209,7 +2214,17 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	}
 
 	/* This "Tx" DMA channel is used only for loading uCode */
-	if (inta_fh & MSIX_FH_INT_CAUSES_D2S_CH0_NUM) {
+	if (inta_fh & MSIX_FH_INT_CAUSES_D2S_CH0_NUM &&
+	    trans_pcie->imr_status == IMR_D2S_REQUESTED) {
+		IWL_DEBUG_ISR(trans, "IMR Complete interrupt\n");
+		isr_stats->tx++;
+
+		/* Wake up IMR routine once write to SRAM is complete */
+		if (trans_pcie->imr_status == IMR_D2S_REQUESTED) {
+			trans_pcie->imr_status = IMR_D2S_COMPLETED;
+			wake_up(&trans_pcie->ucode_write_waitq);
+		}
+	} else if (inta_fh & MSIX_FH_INT_CAUSES_D2S_CH0_NUM) {
 		IWL_DEBUG_ISR(trans, "uCode load interrupt\n");
 		isr_stats->tx++;
 		/*
@@ -2218,6 +2233,12 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		 */
 		trans_pcie->ucode_write_complete = true;
 		wake_up(&trans_pcie->ucode_write_waitq);
+
+		/* Wake up IMR routine once write to SRAM is complete */
+		if (trans_pcie->imr_status == IMR_D2S_REQUESTED) {
+			trans_pcie->imr_status = IMR_D2S_COMPLETED;
+			wake_up(&trans_pcie->ucode_write_waitq);
+		}
 	}
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
@@ -2232,7 +2253,10 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 			inta_fh);
 		isr_stats->sw++;
 		/* during FW reset flow report errors from there */
-		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+		if (trans_pcie->imr_status == IMR_D2S_REQUESTED) {
+			trans_pcie->imr_status = IMR_D2S_ERROR;
+			wake_up(&trans_pcie->imr_waitq);
+		} else if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
 			trans_pcie->fw_reset_state = FW_RESET_ERROR;
 			wake_up(&trans_pcie->fw_reset_waitq);
 		} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 94efaddfdcc4..cafc4d0e66b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3469,7 +3469,8 @@ static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 	.d3_suspend = iwl_trans_pcie_d3_suspend,			\
 	.d3_resume = iwl_trans_pcie_d3_resume,				\
 	.interrupts = iwl_trans_pci_interrupts,				\
-	.sync_nmi = iwl_trans_pcie_sync_nmi				\
+	.sync_nmi = iwl_trans_pcie_sync_nmi,				\
+	.imr_dma_data = iwl_trans_pcie_copy_imr				\
 
 static const struct iwl_trans_ops trans_ops_pcie = {
 	IWL_TRANS_COMMON_OPS,
@@ -3554,6 +3555,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	mutex_init(&trans_pcie->mutex);
 	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
 	init_waitqueue_head(&trans_pcie->fw_reset_waitq);
+	init_waitqueue_head(&trans_pcie->imr_waitq);
 
 	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
 						   WQ_HIGHPRI | WQ_UNBOUND, 1);
@@ -3682,3 +3684,41 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
 }
+
+void iwl_trans_pcie_copy_imr_fh(struct iwl_trans *trans,
+				u32 dst_addr, u64 src_addr, u32 byte_cnt)
+{
+	iwl_write_prph(trans, IMR_UREG_CHICK,
+		       iwl_read_prph(trans, IMR_UREG_CHICK) |
+		       IMR_UREG_CHICK_HALT_UMAC_PERMANENTLY_MSK);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_SRAM_ADDR, dst_addr);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_LSB,
+		       (u32)(src_addr & 0xFFFFFFFF));
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_MSB,
+		       iwl_get_dma_hi_addr(src_addr));
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_BC, byte_cnt);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_CTRL,
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_IRQ_TARGET_POS |
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_DMA_EN_POS |
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_RS_MSK);
+}
+
+int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
+			    u32 dst_addr, u64 src_addr, u32 byte_cnt)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret = -1;
+
+	trans_pcie->imr_status = IMR_D2S_REQUESTED;
+	iwl_trans_pcie_copy_imr_fh(trans, dst_addr, src_addr, byte_cnt);
+	ret = wait_event_timeout(trans_pcie->imr_waitq,
+				 trans_pcie->imr_status !=
+				 IMR_D2S_REQUESTED, 5 * HZ);
+	if (!ret || trans_pcie->imr_status == IMR_D2S_ERROR) {
+		IWL_ERR(trans, "Failed to copy IMR Memory chunk!\n");
+		iwl_trans_pcie_dump_regs(trans);
+		return -ETIMEDOUT;
+	}
+	trans_pcie->imr_status = IMR_D2S_IDLE;
+	return 0;
+}
-- 
2.34.1

