Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7FA62B0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfICHhf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40244 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbfICHhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:34 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53NX-0004Cd-UB; Tue, 03 Sep 2019 10:37:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:36:59 +0300
Message-Id: <20190903073714.32278-7-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 06/21] iwlwifi: add a pointer to the trans_cfg directly in trans
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add a pointer to the iwl_trans structure and point it to the trans
part of the cfg.  This is the first step in disassociating the trans
configuration from the rest of the configuration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  30 ++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  10 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   6 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  10 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  15 +--
 .../wireless/intel/iwlwifi/pcie/internal.h    |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  54 ++++-----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   8 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 108 +++++++++---------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  68 +++++------
 29 files changed, 199 insertions(+), 206 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ef5c75bbd0dd..310b85b508b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -243,7 +243,7 @@ static void iwl_fw_dump_rxf(struct iwl_fw_runtime *fwrt,
 		/* Pull RXF2 */
 		iwl_fwrt_dump_rxf(fwrt, dump_data, cfg->rxfifo2_size,
 				  RXF_DIFF_FROM_PREV +
-				  fwrt->trans->cfg->trans.umac_prph_offset, 1);
+				  fwrt->trans->trans_cfg->umac_prph_offset, 1);
 		/* Pull LMAC2 RXF1 */
 		if (fwrt->smem_cfg.num_lmacs > 1)
 			iwl_fwrt_dump_rxf(fwrt, dump_data,
@@ -684,10 +684,10 @@ static void iwl_fw_prph_handler(struct iwl_fw_runtime *fwrt, void *ptr,
 {
 	u32 range_len;
 
-	if (fwrt->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_ax210);
 		handler(fwrt, iwl_prph_dump_addr_ax210, range_len, ptr);
-	} else if (fwrt->trans->cfg->trans.device_family >=
+	} else if (fwrt->trans->trans_cfg->device_family >=
 		   IWL_DEVICE_FAMILY_22000) {
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_22000);
 		handler(fwrt, iwl_prph_dump_addr_22000, range_len, ptr);
@@ -695,7 +695,7 @@ static void iwl_fw_prph_handler(struct iwl_fw_runtime *fwrt, void *ptr,
 		range_len = ARRAY_SIZE(iwl_prph_dump_addr_comm);
 		handler(fwrt, iwl_prph_dump_addr_comm, range_len, ptr);
 
-		if (fwrt->trans->cfg->trans.mq_rx_supported) {
+		if (fwrt->trans->trans_cfg->mq_rx_supported) {
 			range_len = ARRAY_SIZE(iwl_prph_dump_addr_9000);
 			handler(fwrt, iwl_prph_dump_addr_9000, range_len, ptr);
 		}
@@ -857,7 +857,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			iwl_fw_prph_handler(fwrt, &prph_len,
 					    iwl_fw_get_prph_len);
 
-		if (fwrt->trans->cfg->trans.device_family ==
+		if (fwrt->trans->trans_cfg->device_family ==
 		    IWL_DEVICE_FAMILY_7000 &&
 		    iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_RADIO_REG))
 			radio_len = sizeof(*dump_data) + RADIO_REG_MAX_READ;
@@ -1138,7 +1138,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
 
-	if (!fwrt->trans->cfg->trans.gen2)
+	if (!fwrt->trans->trans_cfg->gen2)
 		return _iwl_dump_ini_paging_iter(fwrt, reg, range_ptr, idx);
 
 	range = range_ptr;
@@ -1444,7 +1444,7 @@ static void
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 	u32 write_ptr_addr, write_ptr_msk, cycle_cnt_addr, cycle_cnt_msk;
 
-	switch (fwrt->trans->cfg->trans.device_family) {
+	switch (fwrt->trans->trans_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_9000:
 	case IWL_DEVICE_FAMILY_22000:
 		write_ptr_addr = MON_BUFF_WRPTR_VER2;
@@ -1454,7 +1454,7 @@ static void
 		break;
 	default:
 		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->cfg->trans.device_family);
+			fwrt->trans->trans_cfg->device_family);
 		return NULL;
 	}
 
@@ -1471,10 +1471,10 @@ static void
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 	const struct iwl_cfg *cfg = fwrt->trans->cfg;
 
-	if (fwrt->trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_9000 &&
-	    fwrt->trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_22000) {
+	if (fwrt->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
+	    fwrt->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22000) {
 		IWL_ERR(fwrt, "Unsupported device family %d\n",
-			fwrt->trans->cfg->trans.device_family);
+			fwrt->trans->trans_cfg->device_family);
 		return NULL;
 	}
 
@@ -1495,7 +1495,7 @@ static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_region_cfg *reg)
 {
-	if (fwrt->trans->cfg->trans.gen2)
+	if (fwrt->trans->trans_cfg->gen2)
 		return fwrt->trans->init_dram.paging_cnt;
 
 	return fwrt->num_of_paging_blk;
@@ -1543,7 +1543,7 @@ static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump);
 
-	if (fwrt->trans->cfg->trans.gen2) {
+	if (fwrt->trans->trans_cfg->gen2) {
 		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg); i++)
 			size += range_header_len +
 				fwrt->trans->init_dram.paging[i].size;
@@ -2472,7 +2472,7 @@ static int iwl_fw_dbg_suspend_resume_hcmd(struct iwl_trans *trans, bool suspend)
 static void iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 				      struct iwl_fw_dbg_params *params)
 {
-	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		return;
 	}
@@ -2496,7 +2496,7 @@ static int iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 	if (!params)
 		return -EIO;
 
-	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
 		iwl_clear_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
 		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x1);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 0c8da5e07854..b2445bef908c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -302,7 +302,7 @@ static inline bool iwl_fw_dbg_is_d3_debug_enabled(struct iwl_fw_runtime *fwrt)
 static inline bool iwl_fw_dbg_is_paging_enabled(struct iwl_fw_runtime *fwrt)
 {
 	return iwl_fw_dbg_type_on(fwrt, IWL_FW_ERROR_DUMP_PAGING) &&
-		!fwrt->trans->cfg->trans.gen2 &&
+		!fwrt->trans->trans_cfg->gen2 &&
 		fwrt->cur_fw_img < IWL_UCODE_TYPE_MAX &&
 		fwrt->fw->img[fwrt->cur_fw_img].paging_mem_size &&
 		fwrt->fw_paging_db[0].fw_paging_block;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 705eeff1a645..2bd76bd9dfa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -322,7 +322,7 @@ int iwl_init_paging(struct iwl_fw_runtime *fwrt, enum iwl_ucode_type type)
 	const struct fw_img *fw = &fwrt->fw->img[type];
 	int ret;
 
-	if (fwrt->trans->cfg->trans.gen2)
+	if (fwrt->trans->trans_cfg->gen2)
 		return 0;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index a88117d48ade..409b2dd854ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -151,7 +151,7 @@ void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt)
 	}
 
 	pkt = cmd.resp_pkt;
-	if (fwrt->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000)
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 		iwl_parse_shared_mem_22000(fwrt, pkt);
 	else
 		iwl_parse_shared_mem(fwrt, pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a204ecbdacaf..ff0519ea00a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -215,7 +215,7 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	const struct iwl_cfg *cfg = drv->trans->cfg;
 	char tag[8];
 
-	if (drv->trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_9000 &&
+	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_B_STEP &&
 	     CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_C_STEP)) {
 		IWL_ERR(drv,
@@ -1120,7 +1120,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->cfg->trans.device_family <
+			if (drv->trans->trans_cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.umac_error_event_table =
@@ -1136,7 +1136,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*dbg_ptrs))
 				goto invalid_tlv_len;
-			if (drv->trans->cfg->trans.device_family <
+			if (drv->trans->trans_cfg->device_family <
 			    IWL_DEVICE_FAMILY_22000)
 				break;
 			drv->trans->dbg.lmac_error_event_table[0] =
@@ -1522,14 +1522,14 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 		fw->init_evtlog_size = (pieces->init_evtlog_size - 16)/12;
 	else
 		fw->init_evtlog_size =
-			drv->trans->cfg->trans.base_params->max_event_log_size;
+			drv->trans->trans_cfg->base_params->max_event_log_size;
 	fw->init_errlog_ptr = pieces->init_errlog_ptr;
 	fw->inst_evtlog_ptr = pieces->inst_evtlog_ptr;
 	if (pieces->inst_evtlog_size)
 		fw->inst_evtlog_size = (pieces->inst_evtlog_size - 16)/12;
 	else
 		fw->inst_evtlog_size =
-			drv->trans->cfg->trans.base_params->max_event_log_size;
+			drv->trans->trans_cfg->base_params->max_event_log_size;
 	fw->inst_errlog_ptr = pieces->inst_errlog_ptr;
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index 88f38e4cf7ef..80bc2e44c7b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -207,7 +207,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 	 * CSR auto clock gate disable bit -
 	 * this is only applicable for HW with OTP shadow RAM
 	 */
-	if (trans->cfg->trans.base_params->shadow_ram_support)
+	if (trans->trans_cfg->base_params->shadow_ram_support)
 		iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 			    CSR_RESET_LINK_PWR_MGMT_DISABLED);
 
@@ -328,7 +328,7 @@ static int iwl_find_otp_image(struct iwl_trans *trans,
 		}
 		/* more in the link list, continue */
 		usedblocks++;
-	} while (usedblocks <= trans->cfg->trans.base_params->max_ll_items);
+	} while (usedblocks <= trans->trans_cfg->base_params->max_ll_items);
 
 	/* OTP has no valid blocks */
 	IWL_DEBUG_EEPROM(trans->dev, "OTP has no valid blocks\n");
@@ -361,7 +361,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 	if (nvm_is_otp < 0)
 		return nvm_is_otp;
 
-	sz = trans->cfg->trans.base_params->eeprom_size;
+	sz = trans->trans_cfg->base_params->eeprom_size;
 	IWL_DEBUG_EEPROM(trans->dev, "NVM size = %d\n", sz);
 
 	e = kmalloc(sz, GFP_KERNEL);
@@ -396,7 +396,7 @@ int iwl_read_eeprom(struct iwl_trans *trans, u8 **eeprom, size_t *eeprom_size)
 			    CSR_OTP_GP_REG_ECC_CORR_STATUS_MSK |
 			    CSR_OTP_GP_REG_ECC_UNCORR_STATUS_MSK);
 		/* traversing the linked list if no shadow ram supported */
-		if (!trans->cfg->trans.base_params->shadow_ram_support) {
+		if (!trans->trans_cfg->base_params->shadow_ram_support) {
 			ret = iwl_find_otp_image(trans, &validblockaddr);
 			if (ret)
 				goto err_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index dfaad564ef09..0c12df558240 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -127,7 +127,7 @@
 static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 					     unsigned int chnl)
 {
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		WARN_ON_ONCE(chnl >= 64);
 		return TFH_TFDQ_CBB_TABLE + 8 * chnl;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 7561a3891788..1b7414bf7bef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -304,10 +304,10 @@ IWL_EXPORT_SYMBOL(iwl_clear_bits_prph);
 
 void iwl_force_nmi(struct iwl_trans *trans)
 {
-	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_9000)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_write_prph(trans, DEVICE_SET_NMI_REG,
 			       DEVICE_SET_NMI_VAL_DRV);
-	else if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_AX210)
+	else if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
 				UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER_MSK);
 	else
@@ -458,7 +458,7 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 		FH_TSSR_TX_ERROR_REG
 	};
 
-	if (trans->cfg->trans.mq_rx_supported)
+	if (trans->trans_cfg->mq_rx_supported)
 		return iwl_dump_rfh(trans, buf);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 10aef19680d0..e43e452403f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -793,10 +793,10 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 {
 	__le32 mac_addr0 =
 		cpu_to_le32(iwl_read32(trans,
-				       trans->cfg->trans.csr->mac_addr0_strap));
+				       trans->trans_cfg->csr->mac_addr0_strap));
 	__le32 mac_addr1 =
 		cpu_to_le32(iwl_read32(trans,
-				       trans->cfg->trans.csr->mac_addr1_strap));
+				       trans->trans_cfg->csr->mac_addr1_strap));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 	/*
@@ -807,9 +807,9 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 		return;
 
 	mac_addr0 = cpu_to_le32(iwl_read32(trans,
-					trans->cfg->trans.csr->mac_addr0_otp));
+					trans->trans_cfg->csr->mac_addr0_otp));
 	mac_addr1 = cpu_to_le32(iwl_read32(trans,
-					trans->cfg->trans.csr->mac_addr1_otp));
+					trans->trans_cfg->csr->mac_addr1_otp));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 }
@@ -1301,7 +1301,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 			 le32_to_cpu(dword_buff[3]));
 
 		/* nvm file validation, dword_buff[2] holds the file version */
-		if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_8000 &&
+		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
 		    CSR_HW_REV_STEP(trans->hw_rev) == SILICON_C_STEP &&
 		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
 			ret = -EFAULT;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1b9bf9f94367..4152ae972aa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -743,6 +743,7 @@ struct iwl_trans_debug {
  *
  * @ops - pointer to iwl_trans_ops
  * @op_mode - pointer to the op_mode
+ * @trans_cfg: the trans-specific configuration part
  * @cfg - pointer to the configuration
  * @drv - pointer to iwl_drv
  * @status: a bit-mask of transport status flags
@@ -774,6 +775,7 @@ struct iwl_trans_debug {
 struct iwl_trans {
 	const struct iwl_trans_ops *ops;
 	struct iwl_op_mode *op_mode;
+	const struct iwl_cfg_trans_params *trans_cfg;
 	const struct iwl_cfg *cfg;
 	struct iwl_drv *drv;
 	enum iwl_trans_state state;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cd067653814c..cd7172d7f72e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1050,7 +1050,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	 * recording before entering D3. In later devices the FW stops the
 	 * recording automatically.
 	 */
-	if (mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
 	/* must be last -- this switches firmware state */
@@ -1658,7 +1658,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 		mvm_ap_sta->tid_data[i].seq_number = seq;
 	}
 
-	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		i = mvm->offload_tid;
 		iwl_trans_set_q_ptrs(mvm->trans,
 				     mvm_ap_sta->tid_data[i].txq_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2dbb02666851..ad18c2f1a806 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1173,7 +1173,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 	struct iwl_rx_mpdu_desc *desc;
 	int bin_len = count / 2;
 	int ret = -EINVAL;
-	size_t mpdu_cmd_hdr_size = (mvm->trans->cfg->trans.device_family >=
+	size_t mpdu_cmd_hdr_size = (mvm->trans->trans_cfg->device_family >=
 				    IWL_DEVICE_FAMILY_22560) ?
 		sizeof(struct iwl_rx_mpdu_desc) :
 		IWL_RX_DESC_SIZE_V1;
@@ -1182,7 +1182,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 		return -EIO;
 
 	/* supporting only 9000 descriptor */
-	if (!mvm->trans->cfg->trans.mq_rx_supported)
+	if (!mvm->trans->trans_cfg->mq_rx_supported)
 		return -ENOTSUPP;
 
 	rxb._page = alloc_pages(GFP_ATOMIC, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 474e61f436a7..fcb51cb3010e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -357,13 +357,13 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
 
-		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000)
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
 				iwl_read_umac_prph(trans,
 						   UMAG_SB_CPU_2_STATUS));
-		else if (trans->cfg->trans.device_family >=
+		else if (trans->trans_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_8000)
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
@@ -1334,7 +1334,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;
 
 	/* Init RSS configuration */
-	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000) {
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
 		ret = iwl_configure_rxq(mvm);
 		if (ret) {
 			IWL_ERR(mvm, "Failed to configure RX queues: %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 126e63c7f4c1..02a93adc3dfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3320,7 +3320,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
-		if (!mvm->trans->cfg->trans.gen2) {
+		if (!mvm->trans->trans_cfg->gen2) {
 			key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
 			key->flags |= IEEE80211_KEY_FLAG_PUT_IV_SPACE;
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7d3484144891..9e76d494c45c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1356,13 +1356,13 @@ static inline bool iwl_mvm_has_new_rx_api(struct iwl_mvm *mvm)
 static inline bool iwl_mvm_has_new_tx_api(struct iwl_mvm *mvm)
 {
 	/* TODO - replace with TLV once defined */
-	return mvm->trans->cfg->trans.use_tfh;
+	return mvm->trans->trans_cfg->use_tfh;
 }
 
 static inline bool iwl_mvm_has_unified_ucode(struct iwl_mvm *mvm)
 {
 	/* TODO - better define this */
-	return mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_cdb_supported(struct iwl_mvm *mvm)
@@ -1387,7 +1387,7 @@ static inline bool iwl_mvm_cdb_scan_api(struct iwl_mvm *mvm)
 	 * but then there's a little bit of code in scan that won't make
 	 * any sense...
 	 */
-	return mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000;
+	return mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000;
 }
 
 static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index c30ce004af14..35b393f8cd85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -173,7 +173,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	 * unrelated errors. Need to further investigate this, but for now
 	 * we'll separate cases.
 	 */
-	if (mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		reg_val |= CSR_HW_IF_CONFIG_REG_BIT_RADIO_SI;
 
 	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt))
@@ -664,7 +664,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		op_mode->ops = &iwl_mvm_ops_mq;
 		trans->rx_mpdu_cmd_hdr_size =
-			(trans->cfg->trans.device_family >=
+			(trans->trans_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_22560) ?
 			sizeof(struct iwl_rx_mpdu_desc) :
 			IWL_RX_DESC_SIZE_V1;
@@ -728,7 +728,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.no_reclaim_cmds = no_reclaim_cmds;
 	trans_cfg.n_no_reclaim_cmds = ARRAY_SIZE(no_reclaim_cmds);
 
-	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		rb_size_default = IWL_AMSDU_2K;
 	else
 		rb_size_default = IWL_AMSDU_4K;
@@ -757,7 +757,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	trans->wide_cmd_header = true;
 	trans_cfg.bc_table_dword =
-		mvm->trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560;
+		mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560;
 
 	trans_cfg.command_groups = iwl_mvm_groups;
 	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_mvm_groups);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 7300eea03b4c..42d525e46e80 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3338,7 +3338,7 @@ static void rs_build_rates_table_from_fixed(struct iwl_mvm *mvm,
 	if (num_of_ant(ant) == 1)
 		lq_cmd->single_stream_ant_msk = ant;
 
-	if (!mvm->trans->cfg->trans.gen2)
+	if (!mvm->trans->trans_cfg->gen2)
 		lq_cmd->agg_frame_cnt_limit = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		lq_cmd->agg_frame_cnt_limit =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 65a8f0ad5f29..25d038092eec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -349,7 +349,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 		    !(status & IWL_RX_MPDU_RES_STATUS_TTAK_OK))
 			return 0;
 
-		if (mvm->trans->cfg->trans.gen2 &&
+		if (mvm->trans->trans_cfg->gen2 &&
 		    !(status & RX_MPDU_RES_STATUS_MIC_OK))
 			stats->flag |= RX_FLAG_MMIC_ERROR;
 
@@ -366,7 +366,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 
 		if (pkt_flags & FH_RSCSR_RADA_EN) {
 			stats->flag |= RX_FLAG_ICV_STRIPPED;
-			if (mvm->trans->cfg->trans.gen2)
+			if (mvm->trans->trans_cfg->gen2)
 				stats->flag |= RX_FLAG_MMIC_STRIPPED;
 		}
 
@@ -1504,7 +1504,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
-	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
 		rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 		channel = desc->v3.channel;
 		gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
@@ -1605,7 +1605,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (likely(!(phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
 		u64 tsf_on_air_rise;
 
-		if (mvm->trans->cfg->trans.device_family >=
+		if (mvm->trans->trans_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_22560)
 			tsf_on_air_rise = le64_to_cpu(desc->v3.tsf_on_air_rise);
 		else
@@ -1732,7 +1732,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 			*qc &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 
-			if (mvm->trans->cfg->trans.device_family ==
+			if (mvm->trans->trans_cfg->device_family ==
 			    IWL_DEVICE_FAMILY_9000) {
 				iwl_mvm_flip_address(hdr->addr3);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ca7e51313381..eaa8b1c9938a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1604,7 +1604,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 	mvm_sta->mac_id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id,
 						      mvmvif->color);
 	mvm_sta->vif = vif;
-	if (!mvm->trans->cfg->trans.gen2)
+	if (!mvm->trans->trans_cfg->gen2)
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	else
 		mvm_sta->max_agg_bufsize = LINK_QUAL_AGG_FRAME_LIMIT_GEN2_DEF;
@@ -2813,7 +2813,7 @@ int iwl_mvm_sta_tx_agg_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->cfg->trans.gen2)
+	if (mvm->trans->trans_cfg->gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn == tid_data->next_reclaimed) {
@@ -3853,7 +3853,7 @@ u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data)
 	 * In 22000 HW, the next_reclaimed index is only 8 bit, so we'll need
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
-	if (mvm->trans->cfg->trans.gen2)
+	if (mvm->trans->trans_cfg->gen2)
 		sn &= 0xff;
 
 	return ieee80211_sn_sub(sn, tid_data->next_reclaimed);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 48d305c9b737..8a059da7a1fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -546,7 +546,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 							    hdr->frame_control);
 		}
 
-		if (mvm->trans->cfg->trans.device_family >=
+		if (mvm->trans->trans_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_22560) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
 
@@ -1272,7 +1272,7 @@ static void iwl_mvm_check_ratid_empty(struct iwl_mvm *mvm,
 	 * to align the wrap around of ssn so we compare relevant values.
 	 */
 	normalized_ssn = tid_data->ssn;
-	if (mvm->trans->cfg->trans.gen2)
+	if (mvm->trans->trans_cfg->gen2)
 		normalized_ssn &= 0xff;
 
 	if (normalized_ssn != tid_data->next_reclaimed)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index f8d6e5672867..ba1524727a1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1431,7 +1431,7 @@ u32 iwl_mvm_get_systime(struct iwl_mvm *mvm)
 {
 	u32 reg_addr = DEVICE_SYSTEM_TIME_REG;
 
-	if (mvm->trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22000 &&
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000 &&
 	    mvm->trans->cfg->gp2_reg_addr)
 		reg_addr = mvm->trans->cfg->gp2_reg_addr;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 1b5de527f141..75fa8a6aafee 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -180,7 +180,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
 	else
 		iwl_set_bit(trans, CSR_GP_CNTRL, CSR_AUTO_FUNC_INIT);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 11e1c2b363bb..beee8e9e3892 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1004,6 +1004,9 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
+	/* the trans_cfg should never change, so set it now */
+	iwl_trans->trans_cfg = &cfg->trans;
+
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
@@ -1024,18 +1027,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
-	/*
-	 * We can already set the cfg to iwl_trans here, because the
-	 * only part we use at this point is the cfg_trans
-	 * information.  Once we decide the real cfg, we set it again
-	 * (happens later in this function).  TODO: this is only
-	 * temporary, while we're sorting out this whole thing, but in
-	 * the future it won't be necessary, because we will separate
-	 * the trans configuration entirely from the rest of the
-	 * config struct.
-	 */
-	iwl_trans->cfg = cfg;
-
 	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			cfg = &iwlax210_2ax_cfg_ty_gf_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index eba9660a2bc8..f07559b3633a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -254,7 +254,7 @@ struct iwl_dma_ptr {
 static inline int iwl_queue_inc_wrap(struct iwl_trans *trans, int index)
 {
 	return ++index &
-		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 }
 
 /**
@@ -264,7 +264,7 @@ static inline int iwl_queue_inc_wrap(struct iwl_trans *trans, int index)
 static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					    struct iwl_rxq *rxq)
 {
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
 		__le16 *rb_stts = rxq->rb_stts;
 
 		return READ_ONCE(*rb_stts);
@@ -282,7 +282,7 @@ static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 static inline int iwl_queue_dec_wrap(struct iwl_trans *trans, int index)
 {
 	return --index &
-		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 }
 
 struct iwl_cmd_meta {
@@ -707,7 +707,7 @@ void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 static inline u16 iwl_pcie_tfd_tb_get_len(struct iwl_trans *trans, void *_tfd,
 					  u8 idx)
 {
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
 
@@ -913,7 +913,7 @@ static inline void *iwl_pcie_get_tfd(struct iwl_trans *trans,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (trans->cfg->trans.use_tfh)
+	if (trans->trans_cfg->use_tfh)
 		idx = iwl_pcie_get_cmd_index(txq, idx);
 
 	return txq->tfds + trans_pcie->tfd_size * idx;
@@ -957,7 +957,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 					   MSIX_HW_INT_CAUSES_REG_RF_KILL);
 	}
 
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_9000) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000) {
 		/*
 		 * On 9000-series devices this bit isn't enabled by default, so
 		 * when we power down the device we need set the bit to allow it
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 79b012e881f0..fce8c500ec02 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -200,12 +200,12 @@ static inline __le32 iwl_pcie_dma_addr2rbd_ptr(dma_addr_t dma_addr)
  */
 int iwl_pcie_rx_stop(struct iwl_trans *trans)
 {
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
 		/* TODO: remove this for 22560 once fw does it */
 		iwl_write_umac_prph(trans, RFH_RXF_DMA_CFG_GEN3, 0);
 		return iwl_poll_umac_prph_bit(trans, RFH_GEN_STATUS_GEN3,
 					      RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
-	} else if (trans->cfg->trans.mq_rx_supported) {
+	} else if (trans->trans_cfg->mq_rx_supported) {
 		iwl_write_prph(trans, RFH_RXF_DMA_CFG, 0);
 		return iwl_poll_prph_bit(trans, RFH_GEN_STATUS,
 					   RXF_DMA_IDLE, RXF_DMA_IDLE, 1000);
@@ -232,7 +232,7 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 1. shadow registers aren't enabled
 	 * 2. there is a chance that the NIC is asleep
 	 */
-	if (!trans->cfg->trans.base_params->shadow_reg_enable &&
+	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		reg = iwl_read32(trans, CSR_UCODE_DRV_GP1);
 
@@ -240,18 +240,18 @@ static void iwl_pcie_rxq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Rx queue requesting wakeup, GP1 = 0x%x\n",
 				       reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->cfg->trans.csr->flag_mac_access_req));
+				    BIT(trans->trans_cfg->csr->flag_mac_access_req));
 			rxq->need_update = true;
 			return;
 		}
 	}
 
 	rxq->write_actual = round_down(rxq->write, 8);
-	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22560)
 		iwl_write32(trans, HBUS_TARG_WRPTR,
 			    (rxq->write_actual |
 			     ((FIRST_RX_QUEUE + rxq->id) << 16)));
-	else if (trans->cfg->trans.mq_rx_supported)
+	else if (trans->trans_cfg->mq_rx_supported)
 		iwl_write32(trans, RFH_Q_FRBDCB_WIDX_TRG(rxq->id),
 			    rxq->write_actual);
 	else
@@ -279,7 +279,7 @@ static void iwl_pcie_restock_bd(struct iwl_trans *trans,
 				struct iwl_rxq *rxq,
 				struct iwl_rx_mem_buffer *rxb)
 {
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
 		struct iwl_rx_transfer_desc *bd = rxq->bd;
 
 		BUILD_BUG_ON(sizeof(*bd) != 2 * sizeof(u64));
@@ -405,7 +405,7 @@ static void iwl_pcie_rxsq_restock(struct iwl_trans *trans,
 static
 void iwl_pcie_rxq_restock(struct iwl_trans *trans, struct iwl_rxq *rxq)
 {
-	if (trans->cfg->trans.mq_rx_supported)
+	if (trans->trans_cfg->mq_rx_supported)
 		iwl_pcie_rxmq_restock(trans, rxq);
 	else
 		iwl_pcie_rxsq_restock(trans, rxq);
@@ -682,7 +682,7 @@ static int iwl_pcie_free_bd_size(struct iwl_trans *trans, bool use_rx_td)
 	if (use_rx_td)
 		return sizeof(*rx_td);
 	else
-		return trans->cfg->trans.mq_rx_supported ? sizeof(__le64) :
+		return trans->trans_cfg->mq_rx_supported ? sizeof(__le64) :
 			sizeof(__le32);
 }
 
@@ -690,7 +690,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
 	struct device *dev = trans->dev;
-	bool use_rx_td = (trans->cfg->trans.device_family >=
+	bool use_rx_td = (trans->trans_cfg->device_family >=
 			  IWL_DEVICE_FAMILY_22560);
 	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
 
@@ -712,7 +712,7 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
 
-	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560)
 		return;
 
 	if (rxq->tr_tail)
@@ -735,13 +735,13 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	struct device *dev = trans->dev;
 	int i;
 	int free_size;
-	bool use_rx_td = (trans->cfg->trans.device_family >=
+	bool use_rx_td = (trans->trans_cfg->device_family >=
 			  IWL_DEVICE_FAMILY_22560);
 	size_t rb_stts_size = use_rx_td ? sizeof(__le16) :
 			      sizeof(struct iwl_rb_status);
 
 	spin_lock_init(&rxq->lock);
-	if (trans->cfg->trans.mq_rx_supported)
+	if (trans->trans_cfg->mq_rx_supported)
 		rxq->queue_size = MQ_RX_TABLE_SIZE;
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
@@ -757,7 +757,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	if (!rxq->bd)
 		goto err;
 
-	if (trans->cfg->trans.mq_rx_supported) {
+	if (trans->trans_cfg->mq_rx_supported) {
 		rxq->used_bd = dma_alloc_coherent(dev,
 						  (use_rx_td ? sizeof(*rxq->cd) : sizeof(__le32)) * rxq->queue_size,
 						  &rxq->used_bd_dma,
@@ -807,7 +807,7 @@ int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i, ret;
-	size_t rb_stts_size = trans->cfg->trans.device_family >=
+	size_t rb_stts_size = trans->trans_cfg->device_family >=
 			      IWL_DEVICE_FAMILY_22560 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
@@ -1074,7 +1074,7 @@ int _iwl_pcie_rx_init(struct iwl_trans *trans)
 		rxq->read = 0;
 		rxq->write = 0;
 		rxq->write_actual = 0;
-		memset(rxq->rb_stts, 0, (trans->cfg->trans.device_family >=
+		memset(rxq->rb_stts, 0, (trans->trans_cfg->device_family >=
 					 IWL_DEVICE_FAMILY_22560) ?
 		       sizeof(__le16) : sizeof(struct iwl_rb_status));
 
@@ -1088,7 +1088,7 @@ int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	}
 
 	/* move the pool to the default queue and allocator ownerships */
-	queue_size = trans->cfg->trans.mq_rx_supported ?
+	queue_size = trans->trans_cfg->mq_rx_supported ?
 		     MQ_RX_NUM_RBDS : RX_QUEUE_SIZE;
 	allocator_pool_size = trans->num_rx_queues *
 		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
@@ -1120,7 +1120,7 @@ int iwl_pcie_rx_init(struct iwl_trans *trans)
 	if (ret)
 		return ret;
 
-	if (trans->cfg->trans.mq_rx_supported)
+	if (trans->trans_cfg->mq_rx_supported)
 		iwl_pcie_rx_mq_hw_init(trans);
 	else
 		iwl_pcie_rx_hw_init(trans, trans_pcie->rxq);
@@ -1151,7 +1151,7 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rb_allocator *rba = &trans_pcie->rba;
 	int i;
-	size_t rb_stts_size = trans->cfg->trans.device_family >=
+	size_t rb_stts_size = trans->trans_cfg->device_family >=
 			      IWL_DEVICE_FAMILY_22560 ?
 			      sizeof(__le16) : sizeof(struct iwl_rb_status);
 
@@ -1347,7 +1347,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		}
 
 		page_stolen |= rxcb._page_stolen;
-		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 			break;
 		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
 	}
@@ -1392,14 +1392,14 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc) != 32);
 
-	if (!trans->cfg->trans.mq_rx_supported) {
+	if (!trans->trans_cfg->mq_rx_supported) {
 		rxb = rxq->queue[i];
 		rxq->queue[i] = NULL;
 		return rxb;
 	}
 
 	/* used_bd is a 32/16 bit but only 12 are used to retrieve the vid */
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		vid = le16_to_cpu(rxq->cd[i].rbid) & 0x0FFF;
 	else
 		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF;
@@ -1515,7 +1515,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 	/* Backtrack one entry */
 	rxq->read = i;
 	/* update cr tail with the rxq read pointer */
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		*rxq->cr_tail = cpu_to_le16(r);
 	spin_unlock(&rxq->lock);
 
@@ -1597,7 +1597,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 		return;
 	}
 
-	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
 		if (!trans_pcie->txq[i])
 			continue;
 		del_timer(&trans_pcie->txq[i]->stuck_timer);
@@ -1838,7 +1838,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 	if (inta & CSR_INT_BIT_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->cfg->trans.gen2) {
+		if (trans->trans_cfg->gen2) {
 			/*
 			 * We can restock, since firmware configured
 			 * the RFH
@@ -2179,13 +2179,13 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_ALIVE) {
 		IWL_DEBUG_ISR(trans, "Alive interrupt\n");
 		isr_stats->alive++;
-		if (trans->cfg->trans.gen2) {
+		if (trans->trans_cfg->gen2) {
 			/* We can restock, since firmware configured the RFH */
 			iwl_pcie_rxmq_restock(trans, trans_pcie->rxq);
 		}
 	}
 
-	if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_22560 &&
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22560 &&
 	    inta_hw & MSIX_HW_INT_CAUSES_REG_IPC) {
 		/* Reflect IML transfer status */
 		int res = iwl_read32(trans, CSR_IML_RESP_ADDR);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 919b69ab836d..b6db3c42c467 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -133,7 +133,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_init_done));
+		      BIT(trans->trans_cfg->csr->flag_init_done));
 }
 
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
@@ -168,14 +168,14 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	}
 
 	iwl_pcie_ctxt_info_free_paging(trans);
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		iwl_pcie_ctxt_info_gen3_free(trans);
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
+		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
@@ -340,7 +340,7 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		goto out;
 	}
 
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		ret = iwl_pcie_ctxt_info_gen3_init(trans, fw);
 	else
 		ret = iwl_pcie_ctxt_info_init(trans, fw);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e196e3b87574..d2fe8ff45bbb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -184,8 +184,8 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	iwl_set_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
-		    BIT(trans->cfg->trans.csr->flag_sw_reset));
+	iwl_set_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
+		    BIT(trans->trans_cfg->csr->flag_sw_reset));
 	usleep_range(5000, 6000);
 }
 
@@ -341,7 +341,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	 */
 
 	/* Disable L0S exit timer (platform NMI Work/Around) */
-	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_set_bit(trans, CSR_GIO_CHICKEN_BITS,
 			    CSR_GIO_CHICKEN_BITS_REG_BIT_DIS_L0S_EXIT_TIMER);
 
@@ -365,7 +365,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	iwl_pcie_apm_config(trans);
 
 	/* Configure analog phase-lock-loop before activating to D0A */
-	if (trans->cfg->trans.base_params->pll_cfg)
+	if (trans->trans_cfg->base_params->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
 	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
@@ -490,7 +490,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_init_done));
+		      BIT(trans->trans_cfg->csr->flag_init_done));
 
 	/* Activates XTAL resources monitor */
 	__iwl_trans_pcie_set_bit(trans, CSR_MONITOR_CFG_REG,
@@ -512,12 +512,12 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 	int ret;
 
 	/* stop device's busmaster DMA activity */
-	iwl_set_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
-		    BIT(trans->cfg->trans.csr->flag_stop_master));
+	iwl_set_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
+		    BIT(trans->trans_cfg->csr->flag_stop_master));
 
-	ret = iwl_poll_bit(trans, trans->cfg->trans.csr->addr_sw_reset,
-			   BIT(trans->cfg->trans.csr->flag_master_dis),
-			   BIT(trans->cfg->trans.csr->flag_master_dis), 100);
+	ret = iwl_poll_bit(trans, trans->trans_cfg->csr->addr_sw_reset,
+			   BIT(trans->trans_cfg->csr->flag_master_dis),
+			   BIT(trans->trans_cfg->csr->flag_master_dis), 100);
 	if (ret < 0)
 		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
 
@@ -533,10 +533,10 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 			iwl_pcie_apm_init(trans);
 
 		/* inform ME that we are leaving */
-		if (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000)
+		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000)
 			iwl_set_bits_prph(trans, APMG_PCIDEV_STT_REG,
 					  APMG_PCIDEV_STT_VAL_WAKE_ME);
-		else if (trans->cfg->trans.device_family >=
+		else if (trans->trans_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_8000) {
 			iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 				    CSR_RESET_LINK_PWR_MGMT_DISABLED);
@@ -567,7 +567,7 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_init_done));
+		      BIT(trans->trans_cfg->csr->flag_init_done));
 }
 
 static int iwl_pcie_nic_init(struct iwl_trans *trans)
@@ -594,7 +594,7 @@ static int iwl_pcie_nic_init(struct iwl_trans *trans)
 	if (iwl_pcie_tx_init(trans))
 		return -ENOMEM;
 
-	if (trans->cfg->trans.base_params->shadow_reg_enable) {
+	if (trans->trans_cfg->base_params->shadow_reg_enable) {
 		/* enable shadow regs in HW */
 		iwl_set_bit(trans, CSR_MAC_SHADOW_REG_CTRL, 0x800FFFFF);
 		IWL_DEBUG_INFO(trans, "Enabling shadow registers in device\n");
@@ -832,7 +832,7 @@ static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
 
 	iwl_enable_interrupts(trans);
 
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		if (cpu == 1)
 			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
 				       0xFFFF);
@@ -964,7 +964,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
 			       trans->dbg.fw_mon[0].physical >>
 			       dest->base_shift);
-		if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
 				       (trans->dbg.fw_mon[0].physical +
 					trans->dbg.fw_mon[0].size - 256) >>
@@ -1006,7 +1006,7 @@ static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
 
 	/* supported for 7000 only for the moment */
 	if (iwlwifi_mod_params.fw_monitor &&
-	    trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
+	    trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		iwl_pcie_alloc_fw_monitor(trans, 0);
 
 		if (trans->dbg.fw_mon[0].size) {
@@ -1135,7 +1135,7 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	int val = trans_pcie->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
 	int i, arr_size =
-		(trans->cfg->trans.device_family != IWL_DEVICE_FAMILY_22560) ?
+		(trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22560) ?
 		ARRAY_SIZE(causes_list) : ARRAY_SIZE(causes_list_v2);
 
 	/*
@@ -1145,7 +1145,7 @@ static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 	 */
 	for (i = 0; i < arr_size; i++) {
 		struct iwl_causes_list *causes =
-			(trans->cfg->trans.device_family !=
+			(trans->trans_cfg->device_family !=
 			 IWL_DEVICE_FAMILY_22560) ?
 			causes_list : causes_list_v2;
 
@@ -1190,7 +1190,7 @@ void iwl_pcie_conf_msix_hw(struct iwl_trans_pcie *trans_pcie)
 	struct iwl_trans *trans = trans_pcie->trans;
 
 	if (!trans_pcie->msix_enabled) {
-		if (trans->cfg->trans.mq_rx_supported &&
+		if (trans->trans_cfg->mq_rx_supported &&
 		    test_bit(STATUS_DEVICE_ENABLED, &trans->status))
 			iwl_write_umac_prph(trans, UREG_CHICK,
 					    UREG_CHICK_MSI_ENABLE);
@@ -1271,7 +1271,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 
 	/* Make sure (redundant) we've released our request to stay awake */
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
+		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_apm_stop(trans, false);
@@ -1398,7 +1398,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
 
 	/* Load the given image to the HW */
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		ret = iwl_pcie_load_given_ucode_8000(trans, fw);
 	else
 		ret = iwl_pcie_load_given_ucode(trans, fw);
@@ -1471,7 +1471,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 	IWL_WARN(trans, "reporting RF_KILL (radio %s)\n",
 		 state ? "disabled" : "enabled");
 	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state)) {
-		if (trans->cfg->trans.gen2)
+		if (trans->trans_cfg->gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
 			_iwl_trans_pcie_stop_device(trans);
@@ -1501,9 +1501,9 @@ static void iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 	iwl_pcie_synchronize_irqs(trans);
 
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_mac_access_req));
+		      BIT(trans->trans_cfg->csr->flag_mac_access_req));
 	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      BIT(trans->cfg->trans.csr->flag_init_done));
+		      BIT(trans->trans_cfg->csr->flag_init_done));
 
 	if (reset) {
 		/*
@@ -1532,7 +1532,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	}
 
 	iwl_set_bit(trans, CSR_GP_CNTRL,
-		    BIT(trans->cfg->trans.csr->flag_mac_access_req));
+		    BIT(trans->trans_cfg->csr->flag_mac_access_req));
 
 	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
 	if (ret)
@@ -1554,7 +1554,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 
 	if (!reset) {
 		iwl_clear_bit(trans, CSR_GP_CNTRL,
-			      BIT(trans->cfg->trans.csr->flag_mac_access_req));
+			      BIT(trans->trans_cfg->csr->flag_mac_access_req));
 	} else {
 		iwl_trans_pcie_tx_reset(trans);
 
@@ -1708,7 +1708,7 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 {
 	u32 hpm, wprot;
 
-	switch (trans->cfg->trans.device_family) {
+	switch (trans->trans_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_9000:
 		wprot = PREG_PRPH_WPROT_9000;
 		break;
@@ -1823,7 +1823,7 @@ static u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
 
 static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
 {
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		return 0x00FFFFFF;
 	else
 		return 0x000FFFFF;
@@ -1894,7 +1894,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_synchronize_irqs(trans);
 
-	if (trans->cfg->trans.gen2)
+	if (trans->trans_cfg->gen2)
 		iwl_pcie_gen2_tx_free(trans);
 	else
 		iwl_pcie_tx_free(trans);
@@ -1976,8 +1976,8 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 
 	/* this bit wakes up the NIC */
 	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-				 BIT(trans->cfg->trans.csr->flag_mac_access_req));
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000)
+				 BIT(trans->trans_cfg->csr->flag_mac_access_req));
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
 	/*
@@ -2001,8 +2001,8 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans,
 	 * and do not save/restore SRAM when power cycling.
 	 */
 	ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   BIT(trans->cfg->trans.csr->flag_val_mac_access_en),
-			   (BIT(trans->cfg->trans.csr->flag_mac_clock_ready) |
+			   BIT(trans->trans_cfg->csr->flag_val_mac_access_en),
+			   (BIT(trans->trans_cfg->csr->flag_mac_clock_ready) |
 			    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
@@ -2084,7 +2084,7 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans,
 		goto out;
 
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->cfg->trans.csr->flag_mac_access_req));
+				   BIT(trans->trans_cfg->csr->flag_mac_access_req));
 	/*
 	 * Above we read the CSR_GP_CNTRL register, which will flush
 	 * any previous writes, but we need the write that clears the
@@ -2191,7 +2191,7 @@ static void iwl_trans_pcie_block_txq_ptrs(struct iwl_trans *trans, bool block)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txq[i];
 
 		if (i == trans_pcie->cmd_queue)
@@ -2222,7 +2222,7 @@ void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 	bool active;
 	u8 fifo;
 
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		IWL_ERR(trans, "Queue %d is stuck %d %d\n", txq_id,
 			txq->read_ptr, txq->write_ptr);
 		/* TODO: access new SCD registers and dump them */
@@ -2239,10 +2239,10 @@ void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 		jiffies_to_msecs(txq->wd_timeout),
 		txq->read_ptr, txq->write_ptr,
 		iwl_read_prph(trans, SCD_QUEUE_RDPTR(txq_id)) &
-			(trans->cfg->trans.base_params->max_tfd_queue_size - 1),
-		iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
-			(trans->cfg->trans.base_params->max_tfd_queue_size - 1),
-		iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
+			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			iwl_read_prph(trans, SCD_QUEUE_WRPTR(txq_id)) &
+			(trans->trans_cfg->base_params->max_tfd_queue_size - 1),
+			iwl_read_direct32(trans, FH_TX_TRB_REG(fifo)));
 }
 
 static int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
@@ -2331,7 +2331,7 @@ static int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
 
 	/* waiting for all the tx frames complete might take a while */
 	for (cnt = 0;
-	     cnt < trans->cfg->trans.base_params->num_of_queues;
+	     cnt < trans->trans_cfg->base_params->num_of_queues;
 	     cnt++) {
 
 		if (cnt == trans_pcie->cmd_queue)
@@ -2477,7 +2477,7 @@ static ssize_t iwl_dbgfs_tx_queue_read(struct file *file,
 	size_t bufsz;
 
 	bufsz = sizeof(char) * 75 *
-		trans->cfg->trans.base_params->num_of_queues;
+		trans->trans_cfg->base_params->num_of_queues;
 
 	if (!trans_pcie->txq_memory)
 		return -EAGAIN;
@@ -2487,7 +2487,7 @@ static ssize_t iwl_dbgfs_tx_queue_read(struct file *file,
 		return -ENOMEM;
 
 	for (cnt = 0;
-	     cnt < trans->cfg->trans.base_params->num_of_queues;
+	     cnt < trans->trans_cfg->base_params->num_of_queues;
 	     cnt++) {
 		txq = trans_pcie->txq[cnt];
 		pos += scnprintf(buf + pos, bufsz - pos,
@@ -2958,7 +2958,7 @@ static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
 	(*data)->len = cpu_to_le32(fh_regs_len);
 	val = (void *)(*data)->data;
 
-	if (!trans->cfg->trans.gen2)
+	if (!trans->trans_cfg->gen2)
 		for (i = FH_MEM_LOWER_BOUND; i < FH_MEM_UPPER_BOUND;
 		     i += sizeof(u32))
 			*val++ = cpu_to_le32(iwl_trans_pcie_read32(trans, i));
@@ -3006,7 +3006,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 {
 	u32 base, base_high, write_ptr, write_ptr_val, wrap_cnt;
 
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		base = DBGC_CUR_DBGBUF_BASE_ADDR_LSB;
 		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
 		write_ptr = DBGC_CUR_DBGBUF_STATUS;
@@ -3026,7 +3026,7 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		cpu_to_le32(iwl_read_prph(trans, wrap_cnt));
 	fw_mon_data->fw_mon_base_ptr =
 		cpu_to_le32(iwl_read_prph(trans, base));
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		fw_mon_data->fw_mon_base_high_ptr =
 			cpu_to_le32(iwl_read_prph(trans, base_high));
 		write_ptr_val &= DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK;
@@ -3043,8 +3043,8 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 
 	if (trans->dbg.dest_tlv ||
 	    (trans->dbg.num_blocks &&
-	     (trans->cfg->trans.device_family == IWL_DEVICE_FAMILY_7000 ||
-	      trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_AX210))) {
+	     (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
+	      trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
 
 		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FW_MONITOR);
@@ -3127,7 +3127,7 @@ static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
 			      trans->dbg.dest_tlv->end_shift;
 
 			/* Make "end" point to the actual end */
-			if (trans->cfg->trans.device_family >=
+			if (trans->trans_cfg->device_family >=
 			    IWL_DEVICE_FAMILY_8000 ||
 			    trans->dbg.dest_tlv->monitor_mode == MARBH_MODE)
 				end += (1 << trans->dbg.dest_tlv->end_shift);
@@ -3153,7 +3153,7 @@ static struct iwl_trans_dump_data
 	u32 len, num_rbs = 0, monitor_len = 0;
 	int i, ptr;
 	bool dump_rbs = test_bit(STATUS_FW_ERROR, &trans->status) &&
-			!trans->cfg->trans.mq_rx_supported &&
+			!trans->trans_cfg->mq_rx_supported &&
 			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
 
 	if (!dump_mask)
@@ -3178,7 +3178,7 @@ static struct iwl_trans_dump_data
 
 	/* FH registers */
 	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FH_REGS)) {
-		if (trans->cfg->trans.gen2)
+		if (trans->trans_cfg->gen2)
 			len += sizeof(*data) +
 			       (iwl_umac_prph(trans, FH_MEM_UPPER_BOUND_GEN2) -
 				iwl_umac_prph(trans, FH_MEM_LOWER_BOUND_GEN2));
@@ -3202,7 +3202,7 @@ static struct iwl_trans_dump_data
 	}
 
 	/* Paged memory for gen2 HW */
-	if (trans->cfg->trans.gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
+	if (trans->trans_cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
 		for (i = 0; i < trans->init_dram.paging_cnt; i++)
 			len += sizeof(*data) +
 			       sizeof(struct iwl_fw_error_dump_paging) +
@@ -3257,7 +3257,7 @@ static struct iwl_trans_dump_data
 		len += iwl_trans_pcie_dump_rbs(trans, &data, num_rbs);
 
 	/* Paged memory for gen2 HW */
-	if (trans->cfg->trans.gen2 &&
+	if (trans->trans_cfg->gen2 &&
 	    dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING)) {
 		for (i = 0; i < trans->init_dram.paging_cnt; i++) {
 			struct iwl_fw_error_dump_paging *paging;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8fcda4d4bc46..7af4e3ae4928 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -117,7 +117,7 @@ void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 	num_fetch_chunks = DIV_ROUND_UP(filled_tfd_size, 64) - 1;
 
 	bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560)
 		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
 	else
 		scd_bc_tbl->tfd_offset[idx] = bc_ent;
@@ -541,7 +541,7 @@ struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 
 	memset(tfd, 0, sizeof(*tfd));
 
-	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_22560)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22560)
 		len = sizeof(struct iwl_tx_cmd_gen2);
 	else
 		len = sizeof(struct iwl_tx_cmd_gen3);
@@ -623,7 +623,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		return -1;
 	}
 
-	if (trans->cfg->trans.device_family >= IWL_DEVICE_FAMILY_22560) {
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
 		struct iwl_tx_cmd_gen3 *tx_cmd_gen3 =
 			(void *)dev_cmd->payload;
 
@@ -1123,7 +1123,7 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 	if (!txq)
 		return -ENOMEM;
 	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl,
-				     (trans->cfg->trans.device_family >=
+				     (trans->trans_cfg->device_family >=
 				      IWL_DEVICE_FAMILY_22560) ?
 				     sizeof(struct iwl_gen3_bc_tbl) :
 				     sizeof(struct iwlagn_scd_bc_tbl));
@@ -1187,7 +1187,7 @@ int iwl_trans_pcie_txq_alloc_response(struct iwl_trans *trans,
 
 	txq->id = qid;
 	trans_pcie->txq[qid] = txq;
-	wr_ptr &= (trans->cfg->trans.base_params->max_tfd_queue_size - 1);
+	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 
 	/* Place first TFD at index corresponding to start sequence number */
 	txq->read_ptr = wr_ptr;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 774c8bfe8450..5787cdefacd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -113,17 +113,17 @@ int iwl_queue_space(struct iwl_trans *trans, const struct iwl_txq *q)
 	 * If q->n_window is smaller than max_tfd_queue_size, there is no need
 	 * to reserve any queue entries for this purpose.
 	 */
-	if (q->n_window < trans->cfg->trans.base_params->max_tfd_queue_size)
+	if (q->n_window < trans->trans_cfg->base_params->max_tfd_queue_size)
 		max = q->n_window;
 	else
-		max = trans->cfg->trans.base_params->max_tfd_queue_size - 1;
+		max = trans->trans_cfg->base_params->max_tfd_queue_size - 1;
 
 	/*
 	 * max_tfd_queue_size is a power of 2, so the following is equivalent to
 	 * modulo by max_tfd_queue_size and is well defined.
 	 */
 	used = (q->write_ptr - q->read_ptr) &
-		(trans->cfg->trans.base_params->max_tfd_queue_size - 1);
+		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 
 	if (WARN_ON(used > max))
 		return 0;
@@ -292,7 +292,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 	 * 2. NIC is woken up for CMD regardless of shadow outside this function
 	 * 3. there is a chance that the NIC is asleep
 	 */
-	if (!trans->cfg->trans.base_params->shadow_reg_enable &&
+	if (!trans->trans_cfg->base_params->shadow_reg_enable &&
 	    txq_id != trans_pcie->cmd_queue &&
 	    test_bit(STATUS_TPOWER_PMI, &trans->status)) {
 		/*
@@ -306,7 +306,7 @@ static void iwl_pcie_txq_inc_wr_ptr(struct iwl_trans *trans,
 			IWL_DEBUG_INFO(trans, "Tx queue %d requesting wakeup, GP1 = 0x%x\n",
 				       txq_id, reg);
 			iwl_set_bit(trans, CSR_GP_CNTRL,
-				    BIT(trans->cfg->trans.csr->flag_mac_access_req));
+				    BIT(trans->trans_cfg->csr->flag_mac_access_req));
 			txq->need_update = true;
 			return;
 		}
@@ -327,7 +327,7 @@ void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->cfg->trans.base_params->num_of_queues; i++) {
+	for (i = 0; i < trans->trans_cfg->base_params->num_of_queues; i++) {
 		struct iwl_txq *txq = trans_pcie->txq[i];
 
 		if (!test_bit(i, trans_pcie->queue_used))
@@ -346,7 +346,7 @@ static inline dma_addr_t iwl_pcie_tfd_tb_get_addr(struct iwl_trans *trans,
 						  void *_tfd, u8 idx)
 {
 
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
 
@@ -389,7 +389,7 @@ static inline void iwl_pcie_tfd_set_tb(struct iwl_trans *trans, void *tfd,
 
 static inline u8 iwl_pcie_tfd_get_num_tbs(struct iwl_trans *trans, void *_tfd)
 {
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd = _tfd;
 
 		return le16_to_cpu(tfd->num_tbs) & 0x1f;
@@ -436,7 +436,7 @@ static void iwl_pcie_tfd_unmap(struct iwl_trans *trans,
 
 	meta->tbs = 0;
 
-	if (trans->cfg->trans.use_tfh) {
+	if (trans->trans_cfg->use_tfh) {
 		struct iwl_tfh_tfd *tfd_fh = (void *)tfd;
 
 		tfd_fh->num_tbs = 0;
@@ -524,14 +524,14 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t tfd_sz = trans_pcie->tfd_size *
-		trans->cfg->trans.base_params->max_tfd_queue_size;
+		trans->trans_cfg->base_params->max_tfd_queue_size;
 	size_t tb0_buf_sz;
 	int i;
 
 	if (WARN_ON(txq->entries || txq->tfds))
 		return -EINVAL;
 
-	if (trans->cfg->trans.use_tfh)
+	if (trans->trans_cfg->use_tfh)
 		tfd_sz = trans_pcie->tfd_size * slots_num;
 
 	timer_setup(&txq->stuck_timer, iwl_pcie_txq_stuck_timer, 0);
@@ -591,7 +591,7 @@ int iwl_pcie_txq_init(struct iwl_trans *trans, struct iwl_txq *txq,
 {
 	int ret;
 	u32 tfd_queue_max_size =
-		trans->cfg->trans.base_params->max_tfd_queue_size;
+		trans->trans_cfg->base_params->max_tfd_queue_size;
 
 	txq->need_update = false;
 
@@ -639,14 +639,14 @@ static void iwl_pcie_clear_cmd_in_flight(struct iwl_trans *trans)
 
 	lockdep_assert_held(&trans_pcie->reg_lock);
 
-	if (!trans->cfg->trans.base_params->apmg_wake_up_wa)
+	if (!trans->trans_cfg->base_params->apmg_wake_up_wa)
 		return;
 	if (WARN_ON(!trans_pcie->cmd_hold_nic_awake))
 		return;
 
 	trans_pcie->cmd_hold_nic_awake = false;
 	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   BIT(trans->cfg->trans.csr->flag_mac_access_req));
+				   BIT(trans->trans_cfg->csr->flag_mac_access_req));
 }
 
 /*
@@ -726,7 +726,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 	if (txq->tfds) {
 		dma_free_coherent(dev,
 				  trans_pcie->tfd_size *
-				  trans->cfg->trans.base_params->max_tfd_queue_size,
+				  trans->trans_cfg->base_params->max_tfd_queue_size,
 				  txq->tfds, txq->dma_addr);
 		txq->dma_addr = 0;
 		txq->tfds = NULL;
@@ -748,7 +748,7 @@ static void iwl_pcie_txq_free(struct iwl_trans *trans, int txq_id)
 void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int nq = trans->cfg->trans.base_params->num_of_queues;
+	int nq = trans->trans_cfg->base_params->num_of_queues;
 	int chan;
 	u32 reg_val;
 	int clear_dwords = (SCD_TRANS_TBL_OFFSET_QUEUE(nq) -
@@ -775,7 +775,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 	/* The chain extension of the SCD doesn't work well. This feature is
 	 * enabled by default by the HW, so we need to disable it manually.
 	 */
-	if (trans->cfg->trans.base_params->scd_chain_ext_wa)
+	if (trans->trans_cfg->base_params->scd_chain_ext_wa)
 		iwl_write_prph(trans, SCD_CHAINEXT_EN, 0);
 
 	iwl_trans_ac_txq_enable(trans, trans_pcie->cmd_queue,
@@ -797,7 +797,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 			   reg_val | FH_TX_CHICKEN_BITS_SCD_AUTO_RETRY_EN);
 
 	/* Enable L1-Active */
-	if (trans->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		iwl_clear_bits_prph(trans, APMG_PCIDEV_STT_REG,
 				    APMG_PCIDEV_STT_VAL_L1_ACT_DIS);
 }
@@ -811,13 +811,13 @@ void iwl_trans_pcie_tx_reset(struct iwl_trans *trans)
 	 * we should never get here in gen2 trans mode return early to avoid
 	 * having invalid accesses
 	 */
-	if (WARN_ON_ONCE(trans->cfg->trans.gen2))
+	if (WARN_ON_ONCE(trans->trans_cfg->gen2))
 		return;
 
-	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		struct iwl_txq *txq = trans_pcie->txq[txq_id];
-		if (trans->cfg->trans.use_tfh)
+		if (trans->trans_cfg->use_tfh)
 			iwl_write_direct64(trans,
 					   FH_MEM_CBBC_QUEUE(trans, txq_id),
 					   txq->dma_addr);
@@ -900,7 +900,7 @@ int iwl_pcie_tx_stop(struct iwl_trans *trans)
 		return 0;
 
 	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++)
 		iwl_pcie_txq_unmap(trans, txq_id);
 
@@ -922,7 +922,7 @@ void iwl_pcie_tx_free(struct iwl_trans *trans)
 	/* Tx queues */
 	if (trans_pcie->txq_memory) {
 		for (txq_id = 0;
-		     txq_id < trans->cfg->trans.base_params->num_of_queues;
+		     txq_id < trans->trans_cfg->base_params->num_of_queues;
 		     txq_id++) {
 			iwl_pcie_txq_free(trans, txq_id);
 			trans_pcie->txq[txq_id] = NULL;
@@ -946,9 +946,9 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	int ret;
 	int txq_id, slots_num;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u16 bc_tbls_size = trans->cfg->trans.base_params->num_of_queues;
+	u16 bc_tbls_size = trans->trans_cfg->base_params->num_of_queues;
 
-	bc_tbls_size *= (trans->cfg->trans.device_family >=
+	bc_tbls_size *= (trans->trans_cfg->device_family >=
 			 IWL_DEVICE_FAMILY_22560) ?
 		sizeof(struct iwl_gen3_bc_tbl) :
 		sizeof(struct iwlagn_scd_bc_tbl);
@@ -975,7 +975,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	trans_pcie->txq_memory =
-		kcalloc(trans->cfg->trans.base_params->num_of_queues,
+		kcalloc(trans->trans_cfg->base_params->num_of_queues,
 			sizeof(struct iwl_txq), GFP_KERNEL);
 	if (!trans_pcie->txq_memory) {
 		IWL_ERR(trans, "Not enough memory for txq\n");
@@ -984,7 +984,7 @@ static int iwl_pcie_tx_alloc(struct iwl_trans *trans)
 	}
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
 
@@ -1038,7 +1038,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	spin_unlock(&trans_pcie->irq_lock);
 
 	/* Alloc and init all Tx queues, including the command queue (#4/#9) */
-	for (txq_id = 0; txq_id < trans->cfg->trans.base_params->num_of_queues;
+	for (txq_id = 0; txq_id < trans->trans_cfg->base_params->num_of_queues;
 	     txq_id++) {
 		bool cmd_queue = (txq_id == trans_pcie->cmd_queue);
 
@@ -1066,7 +1066,7 @@ int iwl_pcie_tx_init(struct iwl_trans *trans)
 	}
 
 	iwl_set_bits_prph(trans, SCD_GP_CTRL, SCD_GP_CTRL_AUTO_ACTIVE_MODE);
-	if (trans->cfg->trans.base_params->num_of_queues > 20)
+	if (trans->trans_cfg->base_params->num_of_queues > 20)
 		iwl_set_bits_prph(trans, SCD_GP_CTRL,
 				  SCD_GP_CTRL_ENABLE_31_QUEUES);
 
@@ -1138,7 +1138,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		IWL_ERR(trans,
 			"%s: Read index for txq id (%d), last_to_free %d is out of range [0-%d] %d %d.\n",
 			__func__, txq_id, last_to_free,
-			trans->cfg->trans.base_params->max_tfd_queue_size,
+			trans->trans_cfg->base_params->max_tfd_queue_size,
 			txq->write_ptr, txq->read_ptr);
 		goto out;
 	}
@@ -1161,7 +1161,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 		txq->entries[read_ptr].skb = NULL;
 
-		if (!trans->cfg->trans.use_tfh)
+		if (!trans->trans_cfg->use_tfh)
 			iwl_pcie_txq_inval_byte_cnt_tbl(trans, txq);
 
 		iwl_pcie_txq_free_tfd(trans, txq);
@@ -1295,12 +1295,12 @@ void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx)
 	idx = iwl_pcie_get_cmd_index(txq, idx);
 	r = iwl_pcie_get_cmd_index(txq, txq->read_ptr);
 
-	if (idx >= trans->cfg->trans.base_params->max_tfd_queue_size ||
+	if (idx >= trans->trans_cfg->base_params->max_tfd_queue_size ||
 	    (!iwl_queue_used(txq, idx))) {
 		WARN_ONCE(test_bit(txq_id, trans_pcie->queue_used),
 			  "%s: Read index for DMA queue txq id (%d), index %d is out of range [0-%d] %d %d.\n",
 			  __func__, txq_id, idx,
-			  trans->cfg->trans.base_params->max_tfd_queue_size,
+			  trans->trans_cfg->base_params->max_tfd_queue_size,
 			  txq->write_ptr, txq->read_ptr);
 		return;
 	}
@@ -1414,7 +1414,7 @@ bool iwl_trans_pcie_txq_enable(struct iwl_trans *trans, int txq_id, u16 ssn,
 		 * this sad hardware issue.
 		 * This bug has been fixed on devices 9000 and up.
 		 */
-		scd_bug = !trans->cfg->trans.mq_rx_supported &&
+		scd_bug = !trans->trans_cfg->mq_rx_supported &&
 			!((ssn - txq->write_ptr) & 0x3f) &&
 			(ssn != txq->write_ptr);
 		if (scd_bug)
-- 
2.23.0.rc1

