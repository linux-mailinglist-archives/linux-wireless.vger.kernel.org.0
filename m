Return-Path: <linux-wireless+bounces-22382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9BAA8266
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09496189D912
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2927E7DB;
	Sat,  3 May 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/s0XnbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7A27F73F
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301523; cv=none; b=LWdVc/lKutPmaNa5cTxV2kSu2e8kR4CyCZ1OtX15o7Bh92HVlYdd9UeolndKmR4sQ2IsN3IIWxajZxdHD73Vj3AW+y7AXttcfwSTrRh9jBkBcFqVBCBbQ8K0AkgG7QNzwQRjWZoMsR8QRV+TBfGBgjpE89E3zYP6bEvzVoAjHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301523; c=relaxed/simple;
	bh=PRw8PrEXgMmbDUl07mI+VhjwotWqEU+WuTukMzcwaIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNxZrPWCvcpOK1Jk/AJnGCem6bkH8lyWafOAetY4mE3oA/DJOPx+zR0Siv6OseOFL8NZ7O1zhzWy6+31tlL1CfRekVvRlrUcmb3V40YTkcfSWOBlkwusJDy7HVOXViE/IMVgmeTAD0ioOm6gM1of8uNdk+aTXlviMFVjVBhufyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/s0XnbM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301520; x=1777837520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PRw8PrEXgMmbDUl07mI+VhjwotWqEU+WuTukMzcwaIM=;
  b=F/s0XnbM8RU5AM0bsEq1jNINrTpFczasmJiHwq9lkzccKgn6xJe2ZFzd
   dyhea37Xs4UJQtuiAqx3xJC6RinjB9ph9+SLC3wF4ZVyKDwmWIjZ7t/Op
   RMn2K9xh/N16q/579C3Gv5ptZcg0vLlRkGppqO13fN4n1PtgQ1M5PJ4O4
   499zceCTNNG+JYSxXyA+SdTtut0/9yLwP/U90Ns/vgNR6PMOUlaq47hYh
   bonMmHp/xSMnL9aFAtj5lFgo7D0jsu+P55UcVDLrhyzBKdkiforUASODR
   WDiwbapAO53PBNX56voVhy9zC1mFMyilKSSuXOYIMCoVN8ijpQegsydkX
   g==;
X-CSE-ConnectionGUID: XJ5fMo/mQviafd6DgiwF0A==
X-CSE-MsgGUID: 57R5y5VDRbi45sYn30iXKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613278"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613278"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:19 -0700
X-CSE-ConnectionGUID: icbxhwCOTkmXELXxZ+7B4w==
X-CSE-MsgGUID: xPpvaTLPQ6SAsnZ0FS1oZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644404"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: trans: collect device information
Date: Sat,  3 May 2025 22:44:34 +0300
Message-Id: <20250503224232.cd80cb55403c.Ic18524b66d655fad734bf97192a54d9cfa9fdf1f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a new device information 'info' substruct to the transport
that's const and can only be set by a special helper, and move
some information there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  21 ++--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  12 +--
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  20 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  12 +--
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  69 +++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 .../wireless/intel/iwlwifi/mld/low_latency.c  |  12 +--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  16 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  16 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   4 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 102 ++++++++++--------
 .../wireless/intel/iwlwifi/pcie/internal.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  26 ++---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   8 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  53 ++++-----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   2 +-
 41 files changed, 264 insertions(+), 228 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
index 35805cc02bf8..884f811e7a27 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c
@@ -746,7 +746,7 @@ static int iwl_nvm_is_otp(struct iwl_trans *trans)
 	u32 otpgp;
 
 	/* OTP only valid for CP/PP and after */
-	switch (trans->hw_rev & CSR_HW_REV_TYPE_MSK) {
+	switch (trans->info.hw_rev & CSR_HW_REV_TYPE_MSK) {
 	case CSR_HW_REV_TYPE_NONE:
 		IWL_ERR(trans, "Unknown hardware type\n");
 		return -EIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index bd8f67b5bab5..517edc9bf276 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -96,7 +96,7 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
-	if (priv->trans->max_skb_frags)
+	if (priv->trans->info.max_skb_frags)
 		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
 
 	hw->offchannel_tx_hw_queue = IWL_AUX_QUEUE;
@@ -188,7 +188,7 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 		priv->hw->wiphy->bands[NL80211_BAND_5GHZ] =
 			&priv->nvm_data->bands[NL80211_BAND_5GHZ];
 
-	hw->wiphy->hw_version = priv->trans->hw_id;
+	hw->wiphy->hw_version = priv->trans->info.hw_id;
 
 	iwl_leds_init(priv);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index e4e2fc158e52..f26f8202a7a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1248,7 +1248,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 ************************/
 	hw = iwl_alloc_all();
 	if (!hw) {
-		pr_err("%s: Cannot allocate network device\n", trans->name);
+		pr_err("%s: Cannot allocate network device\n",
+		       trans->info.name);
 		err = -ENOMEM;
 		goto out;
 	}
@@ -1378,7 +1379,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 * 2. Read REV register
 	 ***********************/
 	IWL_INFO(priv, "Detected %s, REV=0x%X\n",
-		priv->trans->name, priv->trans->hw_rev);
+		priv->trans->info.name, priv->trans->info.hw_rev);
 
 	err = iwl_trans_start_hw(priv->trans);
 	if (err)
@@ -1992,7 +1993,7 @@ static void iwl_nic_config(struct iwl_op_mode *op_mode)
 	/* SKU Control */
 	iwl_trans_set_bits_mask(priv->trans, CSR_HW_IF_CONFIG_REG,
 				CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH,
-				CSR_HW_REV_STEP_DASH(priv->trans->hw_rev));
+				CSR_HW_REV_STEP_DASH(priv->trans->info.hw_rev));
 
 	/* write radio config values to register */
 	if (priv->nvm_data->radio_cfg_type <= EEPROM_RF_CONFIG_TYPE_MAX) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e70eebf079be..bc60ffe43279 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -904,13 +904,14 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 		dump_data->len = cpu_to_le32(sizeof(*dump_info));
 		dump_info = (void *)dump_data->data;
 		dump_info->hw_type =
-			cpu_to_le32(CSR_HW_REV_TYPE(fwrt->trans->hw_rev));
+			cpu_to_le32(CSR_HW_REV_TYPE(fwrt->trans->info.hw_rev));
 		dump_info->hw_step =
-			cpu_to_le32(fwrt->trans->hw_rev_step);
+			cpu_to_le32(fwrt->trans->info.hw_rev_step);
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
-		strscpy_pad(dump_info->dev_human_readable, fwrt->trans->name,
-			sizeof(dump_info->dev_human_readable));
+		strscpy_pad(dump_info->dev_human_readable,
+			    fwrt->trans->info.name,
+			    sizeof(dump_info->dev_human_readable));
 		strscpy_pad(dump_info->bus_human_readable, fwrt->dev->bus->name,
 			sizeof(dump_info->bus_human_readable));
 		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
@@ -2403,13 +2404,13 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
 	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
 
-	dump->hw_step = cpu_to_le32(fwrt->trans->hw_rev_step);
+	dump->hw_step = cpu_to_le32(fwrt->trans->info.hw_rev_step);
 
 	/*
 	 * Several HWs all have type == 0x42, so we'll override this value
 	 * according to the detected HW
 	 */
-	hw_type = CSR_HW_REV_TYPE(fwrt->trans->hw_rev);
+	hw_type = CSR_HW_REV_TYPE(fwrt->trans->info.hw_rev);
 	if (hw_type == IWL_AX210_HW_TYPE) {
 		u32 prph_val = iwl_read_umac_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR);
 		u32 is_jacket = !!(prph_val & WFPM_OTP_CFG1_IS_JACKET_BIT);
@@ -2426,10 +2427,10 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->hw_type = cpu_to_le32(hw_type);
 
 	dump->rf_id_flavor =
-		cpu_to_le32(CSR_HW_RFID_FLAVOR(fwrt->trans->hw_rf_id));
-	dump->rf_id_dash = cpu_to_le32(CSR_HW_RFID_DASH(fwrt->trans->hw_rf_id));
-	dump->rf_id_step = cpu_to_le32(CSR_HW_RFID_STEP(fwrt->trans->hw_rf_id));
-	dump->rf_id_type = cpu_to_le32(CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id));
+		cpu_to_le32(CSR_HW_RFID_FLAVOR(fwrt->trans->info.hw_rf_id));
+	dump->rf_id_dash = cpu_to_le32(CSR_HW_RFID_DASH(fwrt->trans->info.hw_rf_id));
+	dump->rf_id_step = cpu_to_le32(CSR_HW_RFID_STEP(fwrt->trans->info.hw_rf_id));
+	dump->rf_id_type = cpu_to_le32(CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id));
 
 	dump->lmac_major = cpu_to_le32(fwrt->dump.fw_ver.lmac_major);
 	dump->lmac_minor = cpu_to_le32(fwrt->dump.fw_ver.lmac_minor);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index f0c813d675f4..c70f2a20f7d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -311,7 +311,7 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct iwl_fw_runtime *fwrt,
 	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
 			 fwrt->fw->human_readable);
 	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
-			 fwrt->trans->name);
+			 fwrt->trans->info.name);
 	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
 			 fwrt->dev->bus->name);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index de87e0e3e072..e1270fdc2544 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2024 Intel Corporation
+ * Copyright (C) 2019-2021, 2024-2025 Intel Corporation
  */
 #include "iwl-drv.h"
 #include "runtime.h"
@@ -116,14 +116,14 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 	 * The default queue is configured via context info, so if we
 	 * have a single queue, there's nothing to do here.
 	 */
-	if (fwrt->trans->num_rx_queues == 1)
+	if (fwrt->trans->info.num_rxqs == 1)
 		return 0;
 
 	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22000)
 		return 0;
 
 	/* skip the default queue */
-	num_queues = fwrt->trans->num_rx_queues - 1;
+	num_queues = fwrt->trans->info.num_rxqs - 1;
 
 	size = struct_size(cmd, data, num_queues);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 1195e708caa9..7766b2a45cdf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2020-2024 Intel Corporation
+ * Copyright(c) 2020-2025 Intel Corporation
  */
 
 #include "iwl-drv.h"
@@ -96,8 +96,8 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 				     "Got IWL_UCODE_TLV_HW_TYPE mac_type 0x%0x rf_id 0x%0x\n",
 				     mac_type, rf_id);
 
-			if (mac_type == CSR_HW_REV_TYPE(trans->hw_rev) &&
-			    rf_id == CSR_HW_RFID_TYPE(trans->hw_rf_id))
+			if (mac_type == CSR_HW_REV_TYPE(trans->info.hw_rev) &&
+			    rf_id == CSR_HW_RFID_TYPE(trans->info.hw_rf_id))
 				hw_match = true;
 			break;
 		case IWL_UCODE_TLV_SEC_RT: {
@@ -152,8 +152,8 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 	if (!hw_match) {
 		IWL_DEBUG_FW(trans,
 			     "HW mismatch, skipping PNVM section (need mac_type 0x%x rf_id 0x%x)\n",
-			     CSR_HW_REV_TYPE(trans->hw_rev),
-			     CSR_HW_RFID_TYPE(trans->hw_rf_id));
+			     CSR_HW_REV_TYPE(trans->info.hw_rev),
+			     CSR_HW_RFID_TYPE(trans->info.hw_rf_id));
 		return -ENOENT;
 	}
 
@@ -205,7 +205,7 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 			len -= ALIGN(tlv_len, 4);
 
 			trans->reduced_cap_sku = false;
-			rf_type = CSR_HW_RFID_TYPE(trans->hw_rf_id);
+			rf_type = CSR_HW_RFID_TYPE(trans->info.hw_rf_id);
 			if ((trans->sku_id[0] & IWL_PNVM_REDUCED_CAP_BIT) &&
 			    rf_type == IWL_CFG_RF_TYPE_FM)
 				trans->reduced_cap_sku = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 4038de2df75e..74b90bd92c48 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -181,9 +181,9 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 	 */
 	return IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) >= 38 ||
 		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 &&
-		 fwrt->trans->hw_rev != CSR_HW_REV_TYPE_3160) ||
+		 fwrt->trans->info.hw_rev != CSR_HW_REV_TYPE_3160) ||
 		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
-		 ((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
+		 ((fwrt->trans->info.hw_rev & CSR_HW_REV_TYPE_MSK) ==
 		  CSR_HW_REV_TYPE_7265D));
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
@@ -314,7 +314,7 @@ int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
 	bool send_ppag_always;
 
 	/* many firmware images for JF lie about this */
-	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) ==
+	if (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id) ==
 	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
 		return -EOPNOTSUPP;
 
@@ -491,7 +491,7 @@ __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	u32 val;
 	__le32 config_bitmap = 0;
 
-	switch (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(fwrt->trans->info.hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_HR1:
 	case IWL_CFG_RF_TYPE_HR2:
 	case IWL_CFG_RF_TYPE_JF1:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 7ff97fb71905..652fa0708de8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -176,7 +176,7 @@ static inline char iwl_drv_get_step(int step)
 
 static bool iwl_drv_is_wifi7_supported(struct iwl_trans *trans)
 {
-	return CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM;
+	return CSR_HW_RFID_TYPE(trans->info.hw_rf_id) >= IWL_CFG_RF_TYPE_FM;
 }
 
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
@@ -187,9 +187,9 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	if (trans->cfg->fw_name_pre)
 		return trans->cfg->fw_name_pre;
 
-	mac_step = iwl_drv_get_step(trans->hw_rev_step);
+	mac_step = iwl_drv_get_step(trans->info.hw_rev_step);
 
-	switch (CSR_HW_REV_TYPE(trans->hw_rev)) {
+	switch (CSR_HW_REV_TYPE(trans->info.hw_rev)) {
 	case IWL_CFG_MAC_TYPE_PU:
 		mac = "pu";
 		break;
@@ -237,9 +237,9 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		return "unknown-mac";
 	}
 
-	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->hw_rf_id));
+	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->info.hw_rf_id));
 
-	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_HR1:
 	case IWL_CFG_RF_TYPE_HR2:
 		rf = "hr";
@@ -253,7 +253,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		break;
 	case IWL_CFG_RF_TYPE_WH:
 		if (SILICON_Z_STEP ==
-		    CSR_HW_RFID_STEP(trans->hw_rf_id)) {
+		    CSR_HW_RFID_STEP(trans->info.hw_rf_id)) {
 			rf = "whtc";
 			rf_step = 'a';
 		} else {
@@ -264,7 +264,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		return "unknown-rf";
 	}
 
-	cdb = CSR_HW_RFID_IS_CDB(trans->hw_rf_id) ? "4" : "";
+	cdb = CSR_HW_RFID_IS_CDB(trans->info.hw_rf_id) ? "4" : "";
 
 	scnprintf(buf, FW_NAME_PRE_BUFSIZE,
 		  "iwlwifi-%s-%c0-%s%s-%c0",
@@ -284,11 +284,11 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	const char *fw_name_pre;
 
 	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
-	    (drv->trans->hw_rev_step != SILICON_B_STEP &&
-	     drv->trans->hw_rev_step != SILICON_C_STEP)) {
+	    (drv->trans->info.hw_rev_step != SILICON_B_STEP &&
+	     drv->trans->info.hw_rev_step != SILICON_C_STEP)) {
 		IWL_ERR(drv,
 			"Only HW steps B and C are currently supported (0x%0x)\n",
-			drv->trans->hw_rev);
+			drv->trans->info.hw_rev);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 0653ca8b974a..29221657c9ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2022, 2024 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2022, 2024-2025 Intel Corporation
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
 #include <linux/delay.h>
@@ -260,7 +260,7 @@ struct reg {
 static int iwl_dump_rfh(struct iwl_trans *trans, char **buf)
 {
 	int i, q;
-	int num_q = trans->num_rx_queues;
+	int num_q = trans->info.num_rxqs;
 	static const u32 rfh_tbl[] = {
 		RFH_RXF_DMA_CFG,
 		RFH_GEN_CFG,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index b0b42e024766..9972929234a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -921,7 +921,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	bool is_ap = iftype_data->types_mask & (BIT(NL80211_IFTYPE_AP) |
 						BIT(NL80211_IFTYPE_P2P_GO));
 	bool slow_pcie = (!trans->trans_cfg->integrated &&
-			  trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB);
+			  trans->info.pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB);
 
 	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
 		iftype_data->eht_cap.has_eht = false;
@@ -1040,7 +1040,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
 			IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 
-	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_GF:
 	case IWL_CFG_RF_TYPE_FM:
 	case IWL_CFG_RF_TYPE_WH:
@@ -1052,7 +1052,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		break;
 	}
 
-	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	if (CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_GL &&
 	    iftype_data->eht_cap.has_eht) {
 		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] &=
 			~(IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
@@ -2003,7 +2003,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 
 		/* nvm file validation, dword_buff[2] holds the file version */
 		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
-		    trans->hw_rev_step == SILICON_C_STEP &&
+		    trans->info.hw_rev_step == SILICON_C_STEP &&
 		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
 			ret = -EFAULT;
 			goto out;
@@ -2070,7 +2070,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 			break;
 		}
 
-		iwl_nvm_fixups(trans->hw_id, section_id, temp, section_size);
+		iwl_nvm_fixups(trans->info.hw_id, section_id, temp, section_size);
 
 		kfree(nvm_sections[section_id].data);
 		nvm_sections[section_id].data = temp;
@@ -2173,7 +2173,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
+	if (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9d7f38991a12..7f05444c32ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -287,7 +287,6 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 #endif
 
 	trans->dev = dev;
-	trans->num_rx_queues = 1;
 
 	INIT_DELAYED_WORK(&trans->restart.wk, iwl_trans_restart_wk);
 
@@ -298,6 +297,10 @@ int iwl_trans_init(struct iwl_trans *trans)
 {
 	int txcmd_size, txcmd_align;
 
+	/* check if name/num_rx_queues were set as a proxy for info being set */
+	if (WARN_ON(!trans->info.name || !trans->info.num_rxqs))
+		return -EINVAL;
+
 	if (!trans->trans_cfg->gen2) {
 		txcmd_size = sizeof(struct iwl_tx_cmd);
 		txcmd_align = sizeof(void *);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3a025cc46348..43894aa72673 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -801,6 +801,36 @@ struct iwl_txq {
 	bool overflow_tx;
 };
 
+/**
+ * struct iwl_trans_info - transport info for outside use
+ * @name: the device name
+ * @max_skb_frags: maximum number of fragments an SKB can have when transmitted.
+ *	0 indicates that frag SKBs (NETIF_F_SG) aren't supported.
+ * @hw_rev: the revision data of the HW
+ * @hw_rev_step: The mac step of the HW
+ * @hw_rf_id: the device RF ID
+ * @hw_cnv_id: the device CNV ID
+ * @hw_crf_id: the device CRF ID
+ * @hw_wfpm_id: the device wfpm ID
+ * @hw_id: the ID of the device / sub-device
+ * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
+ *	only valid for discrete (not integrated) NICs
+ * @num_rxqs: number of RX queues allocated by the transport
+ */
+struct iwl_trans_info {
+	const char *name;
+	u32 max_skb_frags;
+	u32 hw_rev;
+	u32 hw_rev_step;
+	u32 hw_rf_id;
+	u32 hw_crf_id;
+	u32 hw_cnv_id;
+	u32 hw_wfpm_id;
+	u32 hw_id;
+	u8 pcie_link_speed;
+	u8 num_rxqs;
+};
+
 /**
  * struct iwl_trans - transport common data
  *
@@ -812,17 +842,9 @@ struct iwl_txq {
  * @state: current device state
  * @status: a bit-mask of transport status flags
  * @dev: pointer to struct device * that represents the device
- * @max_skb_frags: maximum number of fragments an SKB can have when transmitted.
- *	0 indicates that frag SKBs (NETIF_F_SG) aren't supported.
- * @hw_rf_id: a u32 with the device RF ID
- * @hw_cnv_id: a u32 with the device CNV ID
- * @hw_crf_id: a u32 with the device CRF ID
- * @hw_id: a u32 with the ID of the device / sub-device.
- *	Set during transport allocation.
+ * @info: device information for use by other layers
  * @sku_id: the SKU identifier (for PNVM matching)
  * @pnvm_loaded: indicates PNVM was loaded
- * @hw_rev: the revision data of the HW
- * @hw_rev_step: The mac step of the HW
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
@@ -831,8 +853,6 @@ struct iwl_txq {
  * @command_groups: pointer to command group name list array
  * @command_groups_size: array size of @command_groups
  * @wide_cmd_header: true when ucode supports wide command header format
- * @num_rx_queues: number of RX queues allocated by the transport;
- *	the transport must set this before calling iwl_drv_start()
  * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
  * @dev_cmd_pool_name: name for the TX command allocation pool
@@ -844,11 +864,8 @@ struct iwl_txq {
  *	start of the 802.11 header in the @rx_mpdu_cmd
  * @dbg: additional debug data, see &struct iwl_trans_debug
  * @init_dram: FW initialization DMA data
- * @name: the device name
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
- * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
- *	only valid for discrete (not integrated) NICs
  * @reduced_cap_sku: reduced capability supported SKU
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
@@ -874,13 +891,8 @@ struct iwl_trans {
 	unsigned long status;
 
 	struct device *dev;
-	u32 max_skb_frags;
-	u32 hw_rev;
-	u32 hw_rev_step;
-	u32 hw_rf_id;
-	u32 hw_crf_id;
-	u32 hw_cnv_id;
-	u32 hw_id;
+
+	const struct iwl_trans_info info;
 	u32 sku_id[3];
 	bool reduced_cap_sku;
 	bool step_urm;
@@ -903,8 +915,6 @@ struct iwl_trans {
 	int command_groups_size;
 	bool wide_cmd_header;
 
-	u8 num_rx_queues;
-
 	/* The following fields are internal only */
 	struct kmem_cache *dev_cmd_pool;
 	char dev_cmd_pool_name[50];
@@ -918,12 +928,9 @@ struct iwl_trans {
 	struct iwl_trans_debug dbg;
 	struct iwl_self_init_dram init_dram;
 
-	const char *name;
 	u32 mbx_addr_0_step;
 	u32 mbx_addr_1_step;
 
-	u8 pcie_link_speed;
-
 	struct {
 		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
@@ -1243,4 +1250,14 @@ void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans);
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 			     struct iwl_host_cmd *cmd);
 
+/* Internal helper */
+static inline void iwl_trans_set_info(struct iwl_trans *trans,
+				      struct iwl_trans_info *info)
+{
+	struct iwl_trans_info *write;
+
+	write = (void *)(uintptr_t)&trans->info;
+	*write = *info;
+}
+
 #endif /* __iwl_trans_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 687a9450ac98..f606a39a53ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -444,7 +444,7 @@ static void iwl_mld_init_reorder_buffer(struct iwl_mld *mld,
 					struct iwl_mld_baid_data *data,
 					u16 ssn)
 {
-	for (int i = 0; i < mld->trans->num_rx_queues; i++) {
+	for (int i = 0; i < mld->trans->info.num_rxqs; i++) {
 		struct iwl_mld_reorder_buffer *reorder_buf =
 			&data->reorder_buf[i];
 		struct iwl_mld_reorder_buf_entry *entries =
@@ -468,7 +468,7 @@ static void iwl_mld_free_reorder_buffer(struct iwl_mld *mld,
 	iwl_mld_sync_rx_queues(mld, IWL_MLD_RXQ_NOTIF_DEL_BA,
 			       &delba_data, sizeof(delba_data));
 
-	for (int i = 0; i < mld->trans->num_rx_queues; i++) {
+	for (int i = 0; i < mld->trans->info.num_rxqs; i++) {
 		struct iwl_mld_reorder_buffer *reorder_buf =
 			&data->reorder_buf[i];
 		struct iwl_mld_reorder_buf_entry *entries =
@@ -530,7 +530,7 @@ int iwl_mld_ampdu_rx_start(struct iwl_mld *mld, struct ieee80211_sta *sta,
 	 * before starting the BA session in the firmware
 	 */
 	baid_data = kzalloc(sizeof(*baid_data) +
-			    mld->trans->num_rx_queues * reorder_buf_size,
+			    mld->trans->info.num_rxqs * reorder_buf_size,
 			    GFP_KERNEL);
 	if (!baid_data)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index f90043728689..e84d0bdef5fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -774,7 +774,7 @@ iwl_mld_update_ptk_rx_seq(struct iwl_mld *mld,
 		return;
 
 	for (int tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
-		for (int i = 1; i < mld->trans->num_rx_queues; i++)
+		for (int i = 1; i < mld->trans->info.num_rxqs; i++)
 			memcpy(mld_ptk_pn->q[i].pn[tid],
 			       wowlan_status->ptk.aes_seq[tid].ccmp.pn,
 			       IEEE80211_CCMP_PN_LEN);
@@ -1434,7 +1434,7 @@ iwl_mld_suspend_set_ucast_pn(struct iwl_mld *mld, struct ieee80211_sta *sta,
 		ieee80211_get_key_rx_seq(key, tid, &seq);
 
 		/* and use the internal data for all queues */
-		for (int que = 1; que < mld->trans->num_rx_queues; que++) {
+		for (int que = 1; que < mld->trans->info.num_rxqs; que++) {
 			u8 *cur_pn = mld_ptk_pn->q[que].pn[tid];
 
 			if (memcmp(max_pn, cur_pn, IEEE80211_CCMP_PN_LEN) < 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index bd19de665a37..8831b95b91ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -49,7 +49,7 @@ static int iwl_mld_send_rss_cfg_cmd(struct iwl_mld *mld)
 	/* Do not direct RSS traffic to Q 0 which is our fallback queue */
 	for (int i = 0; i < ARRAY_SIZE(cmd.indirection_table); i++)
 		cmd.indirection_table[i] =
-			1 + (i % (mld->trans->num_rx_queues - 1));
+			1 + (i % (mld->trans->info.num_rxqs - 1));
 	netdev_rss_key_fill(cmd.secret_key, sizeof(cmd.secret_key));
 
 	return iwl_mld_send_cmd_pdu(mld, RSS_CONFIG_CMD, &cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index a4a612afb3b3..f7faa87b8ba6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -21,7 +21,7 @@ static bool iwl_mld_calc_low_latency(struct iwl_mld *mld,
 {
 	struct iwl_mld_low_latency *ll = &mld->low_latency;
 	bool global_low_latency = false;
-	u8 num_rx_q = mld->trans->num_rx_queues;
+	u8 num_rx_q = mld->trans->info.num_rxqs;
 
 	for (int mac_id = 0; mac_id < NUM_MAC_INDEX_DRIVER; mac_id++) {
 		u32 total_vo_vi_pkts = 0;
@@ -131,12 +131,12 @@ int iwl_mld_low_latency_init(struct iwl_mld *mld)
 	struct iwl_mld_low_latency *ll = &mld->low_latency;
 	unsigned long ts = jiffies;
 
-	ll->pkts_counters = kcalloc(mld->trans->num_rx_queues,
+	ll->pkts_counters = kcalloc(mld->trans->info.num_rxqs,
 				    sizeof(*ll->pkts_counters), GFP_KERNEL);
 	if (!ll->pkts_counters)
 		return -ENOMEM;
 
-	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++)
 		spin_lock_init(&ll->pkts_counters[q].lock);
 
 	wiphy_delayed_work_init(&ll->work, iwl_mld_low_latency_wk);
@@ -167,7 +167,7 @@ void iwl_mld_low_latency_restart_cleanup(struct iwl_mld *mld)
 	memset(ll->window_start, 0, sizeof(ll->window_start));
 	memset(ll->result, 0, sizeof(ll->result));
 
-	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++)
 		memset(ll->pkts_counters[q].vo_vi, 0,
 		       sizeof(ll->pkts_counters[q].vo_vi));
 }
@@ -276,7 +276,7 @@ void iwl_mld_low_latency_update_counters(struct iwl_mld *mld,
 		return;
 
 	if (WARN_ON_ONCE(fw_id >= ARRAY_SIZE(counters->vo_vi) ||
-			 queue >= mld->trans->num_rx_queues))
+			 queue >= mld->trans->info.num_rxqs))
 		return;
 
 	if (mld->low_latency.stopped)
@@ -324,7 +324,7 @@ void iwl_mld_low_latency_restart(struct iwl_mld *mld)
 		ll->window_start[mac] = 0;
 		low_latency |= ll->result[mac];
 
-		for (int q = 0; q < mld->trans->num_rx_queues; q++) {
+		for (int q = 0; q < mld->trans->info.num_rxqs; q++) {
 			spin_lock_bh(&ll->pkts_counters[q].lock);
 			ll->pkts_counters[q].vo_vi[mac] = 0;
 			spin_unlock_bh(&ll->pkts_counters[q].lock);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index e06cf72b2de5..ce5c84e6bdb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -305,7 +305,7 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 
 	wiphy->max_remain_on_channel_duration = 10000;
 
-	wiphy->hw_version = mld->trans->hw_id;
+	wiphy->hw_version = mld->trans->info.hw_id;
 
 	wiphy->hw_timestamp_max_peers = 1;
 
@@ -353,7 +353,7 @@ static void iwl_mac_hw_set_misc(struct iwl_mld *mld)
 	hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
 	hw->netdev_features |= mld->cfg->features;
 
-	hw->max_tx_fragments = mld->trans->max_skb_frags;
+	hw->max_tx_fragments = mld->trans->info.max_skb_frags;
 	hw->max_listen_interval = IWL_MLD_CONN_LISTEN_INTERVAL;
 
 	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
@@ -2006,7 +2006,7 @@ static int iwl_mld_alloc_ptk_pn(struct iwl_mld *mld,
 				struct ieee80211_key_conf *key,
 				struct iwl_mld_ptk_pn **ptk_pn)
 {
-	u8 num_rx_queues = mld->trans->num_rx_queues;
+	u8 num_rx_queues = mld->trans->info.num_rxqs;
 	int keyidx = key->keyidx;
 	struct ieee80211_key_seq seq;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 189946d5b2cb..f65ff513ae63 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -545,7 +545,7 @@ void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	}
 
 	/* Sum up RX and TX MPDUs from the different queues/links */
-	for (int q = 0; q < mld->trans->num_rx_queues; q++) {
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++) {
 		struct iwl_mld_per_q_mpdu_counter *queue_counter =
 			&mld_sta->mpdu_counters[q];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 2122a7c3e945..459959f83c6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -37,7 +37,7 @@ static inline bool iwl_mld_vif_has_emlsr_cap(struct ieee80211_vif *vif)
 	return ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION &&
 	       ieee80211_vif_is_mld(vif) &&
 	       vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP &&
-	       !CSR_HW_RFID_IS_CDB(mld_vif->mld->trans->hw_rf_id);
+	       !CSR_HW_RFID_IS_CDB(mld_vif->mld->trans->info.hw_rf_id);
 }
 
 static inline int
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 61e00b13f2ce..df279bf4de44 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -603,7 +603,7 @@ void iwl_mld_rx_rss(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
 	u16 cmd_id = WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd);
 
-	if (unlikely(queue >= mld->trans->num_rx_queues))
+	if (unlikely(queue >= mld->trans->info.num_rxqs))
 		return;
 
 	if (likely(cmd_id == WIDE_ID(LEGACY_GROUP, REPLY_RX_MPDU_CMD)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 3e69f2a4fa81..307e2bd622e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1850,7 +1850,7 @@ void iwl_mld_sync_rx_queues(struct iwl_mld *mld,
 			    enum iwl_mld_internal_rxq_notif_type type,
 			    const void *notif_payload, u32 notif_payload_size)
 {
-	u8 num_rx_queues = mld->trans->num_rx_queues;
+	u8 num_rx_queues = mld->trans->info.num_rxqs;
 	struct {
 		struct iwl_rxq_sync_cmd sync_cmd;
 		struct iwl_mld_internal_rxq_notif notif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index dfaa885dd1d0..b91f53341cdf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -660,7 +660,7 @@ iwl_mld_alloc_dup_data(struct iwl_mld *mld, struct iwl_mld_sta *mld_sta)
 	if (mld->fw_status.in_hw_restart)
 		return 0;
 
-	dup_data = kcalloc(mld->trans->num_rx_queues, sizeof(*dup_data),
+	dup_data = kcalloc(mld->trans->info.num_rxqs, sizeof(*dup_data),
 			   GFP_KERNEL);
 	if (!dup_data)
 		return -ENOMEM;
@@ -673,7 +673,7 @@ iwl_mld_alloc_dup_data(struct iwl_mld *mld, struct iwl_mld_sta *mld_sta)
 	 * This thus allows receiving a packet with seqno 0 and the
 	 * retry bit set as the very first packet on a new TID.
 	 */
-	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++)
 		memset(dup_data[q].last_seq, 0xff,
 		       sizeof(dup_data[q].last_seq));
 	mld_sta->dup_data = dup_data;
@@ -695,13 +695,13 @@ static void iwl_mld_alloc_mpdu_counters(struct iwl_mld *mld,
 	    sta->tdls || !ieee80211_vif_is_mld(vif))
 		return;
 
-	mld_sta->mpdu_counters = kcalloc(mld->trans->num_rx_queues,
+	mld_sta->mpdu_counters = kcalloc(mld->trans->info.num_rxqs,
 					 sizeof(*mld_sta->mpdu_counters),
 					 GFP_KERNEL);
 	if (!mld_sta->mpdu_counters)
 		return;
 
-	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+	for (int q = 0; q < mld->trans->info.num_rxqs; q++)
 		spin_lock_init(&mld_sta->mpdu_counters[q].lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index f818545fae97..208c17d67270 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -833,7 +833,7 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
 	 *	1 more for the potential data in the header
 	 */
 	if ((num_subframes * 2 + skb_shinfo(skb)->nr_frags + 1) >
-	    mld->trans->max_skb_frags)
+	    mld->trans->info.max_skb_frags)
 		num_subframes = 1;
 
 	if (num_subframes > 1)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 456ad4fadd8f..d56cc09797f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -300,7 +300,7 @@ static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
 
 			for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 				pn = iwl_mvm_find_max_pn(key, ptk_pn, &seq, i,
-						mvm->trans->num_rx_queues);
+						mvm->trans->info.num_rxqs);
 				aes_sc[i].pn = cpu_to_le64((u64)pn[5] |
 							   ((u64)pn[4] << 8) |
 							   ((u64)pn[3] << 16) |
@@ -421,7 +421,7 @@ static void iwl_mvm_wowlan_get_rsc_v5_data(struct ieee80211_hw *hw,
 
 			for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 				pn = iwl_mvm_find_max_pn(key, ptk_pn, &seq, i,
-						mvm->trans->num_rx_queues);
+						mvm->trans->info.num_rxqs);
 				rsc[i] = cpu_to_le64((u64)pn[5] |
 						     ((u64)pn[4] << 8) |
 						     ((u64)pn[3] << 16) |
@@ -1684,7 +1684,7 @@ static void iwl_mvm_set_aes_ptk_rx_seq(struct iwl_mvm *mvm,
 	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
 		int i;
 
-		for (i = 1; i < mvm->trans->num_rx_queues; i++)
+		for (i = 1; i < mvm->trans->info.num_rxqs; i++)
 			memcpy(ptk_pn->q[i].pn[tid],
 			       status->ptk.aes.seq[tid].ccmp.pn,
 			       IEEE80211_CCMP_PN_LEN);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 3de4c5f8bdff..bb480b2c3626 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -56,13 +56,13 @@ static int iwl_send_rss_cfg_cmd(struct iwl_mvm *mvm)
 			     BIT(IWL_RSS_HASH_TYPE_IPV6_PAYLOAD),
 	};
 
-	if (mvm->trans->num_rx_queues == 1)
+	if (mvm->trans->info.num_rxqs == 1)
 		return 0;
 
 	/* Do not direct RSS traffic to Q 0 which is our fallback queue */
 	for (i = 0; i < ARRAY_SIZE(cmd.indirection_table); i++)
 		cmd.indirection_table[i] =
-			1 + (i % (mvm->trans->num_rx_queues - 1));
+			1 + (i % (mvm->trans->info.num_rxqs - 1));
 	netdev_rss_key_fill(cmd.secret_key, sizeof(cmd.secret_key));
 
 	return iwl_mvm_send_cmd_pdu(mvm, RSS_CONFIG_CMD, 0, sizeof(cmd), &cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d62c797775f2..fbd16d61d599 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -417,10 +417,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		return -EINVAL;
 	}
 
-	if (mvm->trans->num_rx_queues > 1)
+	if (mvm->trans->info.num_rxqs > 1)
 		ieee80211_hw_set(hw, USES_RSS);
 
-	if (mvm->trans->max_skb_frags)
+	if (mvm->trans->info.max_skb_frags)
 		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
 
 	hw->queues = IEEE80211_NUM_ACS;
@@ -441,7 +441,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->uapsd_queues = IWL_MVM_UAPSD_QUEUES;
 	hw->uapsd_max_sp_len = IWL_UAPSD_MAX_SP;
-	hw->max_tx_fragments = mvm->trans->max_skb_frags;
+	hw->max_tx_fragments = mvm->trans->info.max_skb_frags;
 
 	BUILD_BUG_ON(ARRAY_SIZE(mvm->ciphers) < ARRAY_SIZE(mvm_ciphers) + 6);
 	memcpy(mvm->ciphers, mvm_ciphers, sizeof(mvm_ciphers));
@@ -610,7 +610,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->bands[NL80211_BAND_6GHZ] =
 			&mvm->nvm_data->bands[NL80211_BAND_6GHZ];
 
-	hw->wiphy->hw_version = mvm->trans->hw_id;
+	hw->wiphy->hw_version = mvm->trans->info.hw_id;
 
 	if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
 		hw->wiphy->flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -4506,7 +4506,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 			WARN_ON(rcu_access_pointer(mvmsta->ptk_pn[keyidx]));
 			ptk_pn = kzalloc(struct_size(ptk_pn, q,
-						     mvm->trans->num_rx_queues),
+						     mvm->trans->info.num_rxqs),
 					 GFP_KERNEL);
 			if (!ptk_pn) {
 				ret = -ENOMEM;
@@ -4515,7 +4515,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 
 			for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
 				ieee80211_get_key_rx_seq(key, tid, &seq);
-				for (q = 0; q < mvm->trans->num_rx_queues; q++)
+				for (q = 0; q < mvm->trans->info.num_rxqs; q++)
 					memcpy(ptk_pn->q[q].pn[tid],
 					       seq.ccmp.pn,
 					       IEEE80211_CCMP_PN_LEN);
@@ -6370,7 +6370,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 	};
 	int ret;
 
-	cmd->rxq_mask = cpu_to_le32(BIT(mvm->trans->num_rx_queues) - 1);
+	cmd->rxq_mask = cpu_to_le32(BIT(mvm->trans->info.num_rxqs) - 1);
 	cmd->count = cpu_to_le32(sizeof(struct iwl_mvm_internal_rxq_notif) +
 				 size);
 	notif->type = type;
@@ -6385,7 +6385,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 
 	if (sync) {
 		notif->cookie = mvm->queue_sync_cookie;
-		mvm->queue_sync_state = (1 << mvm->trans->num_rx_queues) - 1;
+		mvm->queue_sync_state = (1 << mvm->trans->info.num_rxqs) - 1;
 	}
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a5275f2cd418..37a432081995 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1723,13 +1723,13 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 
 static inline bool iwl_mvm_is_esr_supported(struct iwl_trans *trans)
 {
-	if (CSR_HW_RFID_IS_CDB(trans->hw_rf_id))
+	if (CSR_HW_RFID_IS_CDB(trans->info.hw_rf_id))
 		return false;
 
-	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
 	case IWL_CFG_RF_TYPE_FM:
 		/* Step A doesn't support eSR */
-		return CSR_HW_RFID_STEP(trans->hw_rf_id);
+		return CSR_HW_RFID_STEP(trans->info.hw_rf_id);
 	case IWL_CFG_RF_TYPE_WH:
 	case IWL_CFG_RF_TYPE_PE:
 		return true;
@@ -1748,8 +1748,8 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 
 	/* Check if HW supports eSR or STR */
 	if (iwl_mvm_is_esr_supported(trans) ||
-	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
-	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
+	    (CSR_HW_RFID_TYPE(trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
+	     CSR_HW_RFID_IS_CDB(trans->info.hw_rf_id)))
 		return IWL_FW_MAX_ACTIVE_LINKS_NUM;
 
 	return 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 80ec59c58ae4..db49f0caff12 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -120,7 +120,7 @@ static int iwl_nvm_read_chunk(struct iwl_mvm *mvm, u16 section,
 		} else {
 			IWL_DEBUG_EEPROM(mvm->trans->dev,
 					 "NVM access command failed with status %d (device: %s)\n",
-					 ret, mvm->trans->name);
+					 ret, mvm->trans->info.name);
 			ret = -ENODATA;
 		}
 		goto exit;
@@ -206,7 +206,7 @@ static int iwl_nvm_read_section(struct iwl_mvm *mvm, u16 section,
 		offset += ret;
 	}
 
-	iwl_nvm_fixups(mvm->trans->hw_id, section, data, offset);
+	iwl_nvm_fixups(mvm->trans->info.hw_id, section, data, offset);
 
 	IWL_DEBUG_EEPROM(mvm->trans->dev,
 			 "NVM section %d read completed\n", section);
@@ -338,7 +338,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 			break;
 		}
 
-		iwl_nvm_fixups(mvm->trans->hw_id, section, temp, ret);
+		iwl_nvm_fixups(mvm->trans->info.hw_id, section, temp, ret);
 
 		mvm->nvm_sections[section].data = temp;
 		mvm->nvm_sections[section].length = ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 135d5b89ac25..74732602acb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -96,7 +96,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 		return;
 
 	/* SKU control */
-	reg_val = CSR_HW_REV_STEP_DASH(mvm->trans->hw_rev);
+	reg_val = CSR_HW_REV_STEP_DASH(mvm->trans->info.hw_rev);
 
 	/* radio configuration */
 	reg_val |= radio_cfg_type << CSR_HW_IF_CONFIG_REG_POS_PHY_TYPE;
@@ -1350,7 +1350,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		trans->rx_mpdu_cmd_hdr_size =
 			sizeof(struct iwl_rx_mpdu_res_start);
 
-		if (WARN_ON(trans->num_rx_queues > 1)) {
+		if (WARN_ON(trans->info.num_rxqs > 1)) {
 			err = -EINVAL;
 			goto out_free;
 		}
@@ -2160,7 +2160,7 @@ static void iwl_mvm_rx_mq_rss(struct iwl_op_mode *op_mode,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	u16 cmd = WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd);
 
-	if (unlikely(queue >= mvm->trans->num_rx_queues))
+	if (unlikely(queue >= mvm->trans->info.num_rxqs))
 		return;
 
 	if (unlikely(cmd == WIDE_ID(LEGACY_GROUP, FRAME_RELEASE)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 2dbef7b46355..a5cd0fd7a11a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1001,7 +1001,7 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 	sec_link = mvmvif->link[sec_link]->fw_link_id;
 
 	/* Sum up RX and TX MPDUs from the different queues/links */
-	for (int q = 0; q < mvm->trans->num_rx_queues; q++) {
+	for (int q = 0; q < mvm->trans->info.num_rxqs; q++) {
 		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
 
 		/* The link IDs that doesn't exist will contain 0 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 78fd7faaed97..4f672732c4e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2015, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1798,7 +1798,7 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		int q;
 
-		dup_data = kcalloc(mvm->trans->num_rx_queues,
+		dup_data = kcalloc(mvm->trans->info.num_rxqs,
 				   sizeof(*dup_data), GFP_KERNEL);
 		if (!dup_data)
 			return -ENOMEM;
@@ -1811,7 +1811,7 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		 * This thus allows receiving a packet with seqno 0 and the
 		 * retry bit set as the very first packet on a new TID.
 		 */
-		for (q = 0; q < mvm->trans->num_rx_queues; q++)
+		for (q = 0; q < mvm->trans->info.num_rxqs; q++)
 			memset(dup_data[q].last_seq, 0xff,
 			       sizeof(dup_data[q].last_seq));
 		mvm_sta->dup_data = dup_data;
@@ -1839,11 +1839,11 @@ int iwl_mvm_sta_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    !sta->tdls && ieee80211_vif_is_mld(vif)) {
 		mvm_sta->mpdu_counters =
-			kcalloc(mvm->trans->num_rx_queues,
+			kcalloc(mvm->trans->info.num_rxqs,
 				sizeof(*mvm_sta->mpdu_counters),
 				GFP_KERNEL);
 		if (mvm_sta->mpdu_counters)
-			for (int q = 0; q < mvm->trans->num_rx_queues; q++)
+			for (int q = 0; q < mvm->trans->info.num_rxqs; q++)
 				spin_lock_init(&mvm_sta->mpdu_counters[q].lock);
 	}
 
@@ -2717,7 +2717,7 @@ static void iwl_mvm_free_reorder(struct iwl_mvm *mvm,
 
 	iwl_mvm_sync_rxq_del_ba(mvm, data->baid);
 
-	for (i = 0; i < mvm->trans->num_rx_queues; i++) {
+	for (i = 0; i < mvm->trans->info.num_rxqs; i++) {
 		int j;
 		struct iwl_mvm_reorder_buffer *reorder_buf =
 			&data->reorder_buf[i];
@@ -2750,7 +2750,7 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 {
 	int i;
 
-	for (i = 0; i < mvm->trans->num_rx_queues; i++) {
+	for (i = 0; i < mvm->trans->info.num_rxqs; i++) {
 		struct iwl_mvm_reorder_buffer *reorder_buf =
 			&data->reorder_buf[i];
 		struct iwl_mvm_reorder_buf_entry *entries =
@@ -2925,7 +2925,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		 * before starting the BA session in the firmware
 		 */
 		baid_data = kzalloc(sizeof(*baid_data) +
-				    mvm->trans->num_rx_queues *
+				    mvm->trans->info.num_rxqs *
 				    reorder_buf_size,
 				    GFP_KERNEL);
 		if (!baid_data)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 91f6945f3f98..14f9daad4757 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1023,7 +1023,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 *	1 more for the potential data in the header
 	 */
 	if ((num_subframes * 2 + skb_shinfo(skb)->nr_frags + 1) >
-	    mvm->trans->max_skb_frags)
+	    mvm->trans->info.max_skb_frags)
 		num_subframes = 1;
 
 	if (num_subframes > 1)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index c11ea1d4f7fc..b3a04af7faad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -152,7 +152,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 
 	prph_sc_ctrl->version.version = 0;
 	prph_sc_ctrl->version.mac_id =
-		cpu_to_le16((u16)trans->hw_rev);
+		cpu_to_le16((u16)trans->info.hw_rev);
 	prph_sc_ctrl->version.size = cpu_to_le16(sizeof(*prph_scratch) / 4);
 
 	control_flags |= IWL_PRPH_SCRATCH_MTR_MODE;
@@ -161,7 +161,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	if (trans->trans_cfg->imr_enabled)
 		control_flags |= IWL_PRPH_SCRATCH_IMR_DEBUG_EN;
 
-	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	if (CSR_HW_REV_TYPE(trans->info.hw_rev) == IWL_CFG_MAC_TYPE_GL &&
 	    iwl_is_force_scu_active_approved()) {
 		control_flags |= IWL_PRPH_SCRATCH_SCU_FORCE_ACTIVE;
 		IWL_DEBUG_FW(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 81a8cac3bb0a..4fd3855e6a34 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -180,7 +180,7 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	ctxt_info->version.version = 0;
 	ctxt_info->version.mac_id =
-		cpu_to_le16((u16)trans->hw_rev);
+		cpu_to_le16((u16)trans->info.hw_rev);
 	/* size is in DWs */
 	ctxt_info->version.size = cpu_to_le16(sizeof(*ctxt_info) / 4);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e2c5ec091533..36ae27a5cd42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1517,7 +1517,8 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table_size);
 /*
  * Read rf id and cdb info from prph register and store it
  */
-static void get_crf_id(struct iwl_trans *iwl_trans)
+static void get_crf_id(struct iwl_trans *iwl_trans,
+		       struct iwl_trans_info *info)
 {
 	u32 sd_reg_ver_addr;
 	u32 hw_wfpm_id;
@@ -1535,51 +1536,50 @@ static void get_crf_id(struct iwl_trans *iwl_trans)
 	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
 
 	/* Read crf info */
-	iwl_trans->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
+	info->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
 
 	/* Read cnv info */
-	iwl_trans->hw_cnv_id =
-		iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
+	info->hw_cnv_id = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
 
 	/* For BZ-W, take B step also when A step is indicated */
-	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
 		step = SILICON_B_STEP;
 
 	/* In BZ, the MAC step must be read from the CNVI aux register */
-	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
-		step = CNVI_AUX_MISC_CHIP_MAC_STEP(iwl_trans->hw_cnv_id);
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
+		step = CNVI_AUX_MISC_CHIP_MAC_STEP(info->hw_cnv_id);
 
 		/* For BZ-U, take B step also when A step is indicated */
-		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(iwl_trans->hw_cnv_id) ==
+		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(info->hw_cnv_id) ==
 		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
 		    step == SILICON_A_STEP)
 			step = SILICON_B_STEP;
 	}
 
-	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
-	    CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
-		iwl_trans->hw_rev_step = step;
-		iwl_trans->hw_rev |= step;
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
+	    CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
+		info->hw_rev_step = step;
+		info->hw_rev |= step;
 	}
 
 	/* Read cdb info (also contains the jacket info if needed in the future */
 	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
 	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
-		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
-		 hw_wfpm_id);
+		 info->hw_crf_id, info->hw_cnv_id, hw_wfpm_id);
 }
 
 /*
  * In case that there is no OTP on the NIC, map the rf id and cdb info
  * from the prph registers.
  */
-static int map_crf_id(struct iwl_trans *iwl_trans)
+static int map_crf_id(struct iwl_trans *iwl_trans,
+		      struct iwl_trans_info *info)
 {
 	int ret = 0;
-	u32 val = iwl_trans->hw_crf_id;
+	u32 val = info->hw_crf_id;
 	u32 step_id = REG_CRF_ID_STEP(val);
 	u32 slave_id = REG_CRF_ID_SLAVE(val);
-	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(iwl_trans->hw_cnv_id);
+	u32 jacket_id_cnv = REG_CRF_ID_SLAVE(info->hw_cnv_id);
 	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
 						    WFPM_OTP_CFG1_ADDR);
 	u32 jacket_id_wfpm = WFPM_OTP_CFG1_IS_JACKET(hw_wfpm_id);
@@ -1588,31 +1588,31 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	/* Map between crf id to rf id */
 	switch (REG_CRF_ID_TYPE(val)) {
 	case REG_CRF_ID_TYPE_JF_1:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
 		break;
 	case REG_CRF_ID_TYPE_JF_2:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
 		break;
 	case REG_CRF_ID_TYPE_HR_NONE_CDB_1X1:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
 		break;
 	case REG_CRF_ID_TYPE_HR_NONE_CDB:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
 		break;
 	case REG_CRF_ID_TYPE_HR_CDB:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
 		break;
 	case REG_CRF_ID_TYPE_GF:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
 		break;
 	case REG_CRF_ID_TYPE_FM:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
 		break;
 	case REG_CRF_ID_TYPE_WHP:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
 		break;
 	case REG_CRF_ID_TYPE_PE:
-		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
 		break;
 	default:
 		ret = -EIO;
@@ -1624,28 +1624,28 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	}
 
 	/* Set Step-id */
-	iwl_trans->hw_rf_id |= (step_id << 8);
+	info->hw_rf_id |= (step_id << 8);
 
 	/* Set CDB capabilities */
 	if (cdb_id_wfpm || slave_id) {
-		iwl_trans->hw_rf_id += BIT(28);
+		info->hw_rf_id += BIT(28);
 		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
 	}
 
 	/* Set Jacket capabilities */
 	if (jacket_id_wfpm || jacket_id_cnv) {
-		iwl_trans->hw_rf_id += BIT(29);
+		info->hw_rf_id += BIT(29);
 		IWL_INFO(iwl_trans, "Adding jacket to rf id\n");
 	}
 
 	IWL_INFO(iwl_trans,
 		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
-		 REG_CRF_ID_TYPE(val), step_id, slave_id, iwl_trans->hw_rf_id);
+		 REG_CRF_ID_TYPE(val), step_id, slave_id, info->hw_rf_id);
 	IWL_INFO(iwl_trans,
 		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
 		 cdb_id_wfpm, jacket_id_wfpm, hw_wfpm_id);
 	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
-		 jacket_id_cnv, iwl_trans->hw_cnv_id);
+		 jacket_id_cnv, info->hw_cnv_id);
 
 out:
 	return ret;
@@ -1766,13 +1766,16 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct iwl_cfg_trans_params *trans;
 	const struct iwl_dev_info *dev_info;
+	struct iwl_trans_info info = {
+		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
+	};
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
 	int ret;
 
 	trans = (void *)ent->driver_data;
 
-	iwl_trans = iwl_trans_pcie_alloc(pdev, trans);
+	iwl_trans = iwl_trans_pcie_alloc(pdev, trans, &info);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
@@ -1781,6 +1784,9 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	iwl_trans_pcie_check_product_reset_status(pdev);
 	iwl_trans_pcie_check_product_reset_mode(pdev);
 
+	/* set the things we know so far for the grab NIC access */
+	iwl_trans_set_info(iwl_trans, &info);
+
 	/*
 	 * Let's try to grab NIC access early here. Sometimes, NICs may
 	 * fail to initialize, and if that happens it's better if we see
@@ -1794,7 +1800,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ret)
 			goto out_free_trans;
 		if (iwl_trans_grab_nic_access(iwl_trans)) {
-			get_crf_id(iwl_trans);
+			get_crf_id(iwl_trans, &info);
 			/* all good */
 			iwl_trans_release_nic_access(iwl_trans);
 		} else {
@@ -1803,7 +1809,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+	info.hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
 	/*
 	 * The RF_ID is set to zero in blank OTP so read version to
@@ -1812,28 +1818,28 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (iwl_trans->trans_cfg->rf_id &&
 	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
-	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && map_crf_id(iwl_trans)) {
+	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
 		ret = -EINVAL;
 		goto out_free_trans;
 	}
 
 	IWL_INFO(iwl_trans, "PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
 		 pdev->device, pdev->subsystem_device,
-		 iwl_trans->hw_rev, iwl_trans->hw_rf_id);
+		 info.hw_rev, info.hw_rf_id);
 
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
-					 CSR_HW_REV_TYPE(iwl_trans->hw_rev),
-					 iwl_trans->hw_rev_step,
-					 CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id),
-					 CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id),
-					 CSR_HW_RFID_IS_JACKET(iwl_trans->hw_rf_id),
+					 CSR_HW_REV_TYPE(info.hw_rev),
+					 info.hw_rev_step,
+					 CSR_HW_RFID_TYPE(info.hw_rf_id),
+					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
+					 CSR_HW_RFID_IS_JACKET(info.hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
 					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
 					 IWL_SUBDEVICE_CORES(pdev->subsystem_device),
-					 CSR_HW_RFID_STEP(iwl_trans->hw_rf_id));
+					 CSR_HW_RFID_STEP(info.hw_rf_id));
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
-		iwl_trans->name = dev_info->name;
+		info.name = dev_info->name;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -1845,18 +1851,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * changed, be identical to the ones in the 7265D configuration.
 	 */
 	if (iwl_trans->cfg == &iwl7265_cfg &&
-	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
+	    (info.hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
 		iwl_trans->cfg = &iwl7265d_cfg;
 #endif
 	if (!iwl_trans->cfg) {
 		pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
 		       pdev->device, pdev->subsystem_device,
-		       iwl_trans->hw_rev, iwl_trans->hw_rf_id);
+		       info.hw_rev, info.hw_rf_id);
 		ret = -EINVAL;
 		goto out_free_trans;
 	}
 
-	IWL_INFO(iwl_trans, "Detected %s\n", iwl_trans->name);
+	IWL_INFO(iwl_trans, "Detected %s\n", info.name);
 
 	if (iwl_trans->trans_cfg->mq_rx_supported) {
 		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
@@ -1873,10 +1879,12 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
 
-		iwl_trans->pcie_link_speed =
+		info.pcie_link_speed =
 			u16_get_bits(link_status, PCI_EXP_LNKSTA_CLS);
 	}
 
+	iwl_trans_set_info(iwl_trans, &info);
+
 	ret = iwl_trans_init(iwl_trans);
 	if (ret)
 		goto out_free_trans;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 07b4b28b052f..f532a5d6576e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -563,7 +563,8 @@ iwl_trans_pcie_get_trans(struct iwl_trans_pcie *trans_pcie)
  */
 struct iwl_trans
 *iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		      const struct iwl_cfg_trans_params *cfg_trans);
+		      const struct iwl_cfg_trans_params *cfg_trans,
+		      struct iwl_trans_info *info);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
 					   struct device *dev);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index d3c72cf0a5f4..cb8c8973cb18 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -206,7 +206,7 @@ static void iwl_pcie_rxq_check_wrptr(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		if (!rxq->need_update)
@@ -754,7 +754,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	return 0;
 
 err:
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		iwl_pcie_free_rxq_dma(trans, rxq);
@@ -773,7 +773,7 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	if (WARN_ON(trans_pcie->rxq))
 		return -EINVAL;
 
-	trans_pcie->rxq = kcalloc(trans->num_rx_queues, sizeof(struct iwl_rxq),
+	trans_pcie->rxq = kcalloc(trans->info.num_rxqs, sizeof(struct iwl_rxq),
 				  GFP_KERNEL);
 	trans_pcie->rx_pool = kcalloc(RX_POOL_SIZE(trans_pcie->num_rx_bufs),
 				      sizeof(trans_pcie->rx_pool[0]),
@@ -796,7 +796,7 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 	 */
 	trans_pcie->base_rb_stts =
 			dma_alloc_coherent(trans->dev,
-					   rb_stts_size * trans->num_rx_queues,
+					   rb_stts_size * trans->info.num_rxqs,
 					   &trans_pcie->base_rb_stts_dma,
 					   GFP_KERNEL);
 	if (!trans_pcie->base_rb_stts) {
@@ -804,7 +804,7 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 		goto err;
 	}
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		rxq->id = i;
@@ -817,7 +817,7 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 err:
 	if (trans_pcie->base_rb_stts) {
 		dma_free_coherent(trans->dev,
-				  rb_stts_size * trans->num_rx_queues,
+				  rb_stts_size * trans->info.num_rxqs,
 				  trans_pcie->base_rb_stts,
 				  trans_pcie->base_rb_stts_dma);
 		trans_pcie->base_rb_stts = NULL;
@@ -933,7 +933,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 	/* disable free amd used rx queue operation */
 	iwl_write_prph_no_grab(trans, RFH_RXF_RXQ_ACTIVE, 0);
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		/* Tell device where to find RBD free table in DRAM */
 		iwl_write_prph64_no_grab(trans,
 					 RFH_Q_FRBDCB_BA_LSB(i),
@@ -1073,7 +1073,7 @@ void iwl_pcie_rx_napi_sync(struct iwl_trans *trans)
 	if (unlikely(!trans_pcie->rxq))
 		return;
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		if (rxq && rxq->napi.poll)
@@ -1110,7 +1110,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	for (i = 0; i < RX_QUEUE_SIZE; i++)
 		def_rxq->queue[i] = NULL;
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		spin_lock_bh(&rxq->lock);
@@ -1147,7 +1147,7 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 	/* move the pool to the default queue and allocator ownerships */
 	queue_size = trans->trans_cfg->mq_rx_supported ?
 			trans_pcie->num_rx_bufs - 1 : RX_QUEUE_SIZE;
-	allocator_pool_size = trans->num_rx_queues *
+	allocator_pool_size = trans->info.num_rxqs *
 		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
 	num_alloc = queue_size + allocator_pool_size;
 
@@ -1224,14 +1224,14 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 
 	if (trans_pcie->base_rb_stts) {
 		dma_free_coherent(trans->dev,
-				  rb_stts_size * trans->num_rx_queues,
+				  rb_stts_size * trans->info.num_rxqs,
 				  trans_pcie->base_rb_stts,
 				  trans_pcie->base_rb_stts_dma);
 		trans_pcie->base_rb_stts = NULL;
 		trans_pcie->base_rb_stts_dma = 0;
 	}
 
-	for (i = 0; i < trans->num_rx_queues; i++) {
+	for (i = 0; i < trans->info.num_rxqs; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		iwl_pcie_free_rxq_dma(trans, rxq);
@@ -1649,7 +1649,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 
 	trace_iwlwifi_dev_irq_msix(trans->dev, entry, false, 0, 0);
 
-	if (WARN_ON(entry->entry >= trans->num_rx_queues))
+	if (WARN_ON(entry->entry >= trans->info.num_rxqs))
 		return IRQ_NONE;
 
 	if (!trans_pcie->rxq) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 9283547e9616..f9a9fece9b6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -291,7 +291,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	if (buf[0])
 		return;
 
-	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF):
 		pos = scnprintf(buf, buflen, "JF");
 		break;
@@ -315,7 +315,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 		break;
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_WP):
 		if (SILICON_Z_STEP ==
-		    CSR_HW_RFID_STEP(trans->hw_rf_id))
+		    CSR_HW_RFID_STEP(trans->info.hw_rf_id))
 			pos = scnprintf(buf, buflen, "WHTC");
 		else
 			pos = scnprintf(buf, buflen, "WH");
@@ -324,7 +324,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 		return;
 	}
 
-	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	switch (CSR_HW_RFID_TYPE(trans->info.hw_rf_id)) {
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR):
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR1):
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HRCDB):
@@ -347,7 +347,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	}
 
 	pos += scnprintf(buf + pos, buflen - pos, ", rfid=0x%x",
-			 trans->hw_rf_id);
+			 trans->info.hw_rf_id);
 
 	IWL_INFO(trans, "Detected RF %s\n", buf);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cc4614fd226b..1f99f5dd00af 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1175,7 +1175,7 @@ static void iwl_pcie_map_rx_causes(struct iwl_trans *trans)
 	 * the other (N - 2) interrupt vectors.
 	 */
 	val = BIT(MSIX_FH_INT_CAUSES_Q(0));
-	for (idx = 1; idx < trans->num_rx_queues; idx++) {
+	for (idx = 1; idx < trans->info.num_rxqs; idx++) {
 		iwl_write8(trans, CSR_MSIX_RX_IVAR(idx),
 			   MSIX_FH_INT_CAUSES_Q(idx - offset));
 		val |= BIT(MSIX_FH_INT_CAUSES_Q(idx));
@@ -1655,7 +1655,8 @@ int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 static void
 iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 			    struct iwl_trans *trans,
-			    const struct iwl_cfg_trans_params *cfg_trans)
+			    const struct iwl_cfg_trans_params *cfg_trans,
+			    struct iwl_trans_info *info)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int max_irqs, num_irqs, i, ret;
@@ -1695,27 +1696,28 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	 * More than two interrupts: we will use fewer RSS queues.
 	 */
 	if (num_irqs <= max_irqs - 2) {
-		trans_pcie->trans->num_rx_queues = num_irqs + 1;
+		info->num_rxqs = num_irqs + 1;
 		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX |
 			IWL_SHARED_IRQ_FIRST_RSS;
 	} else if (num_irqs == max_irqs - 1) {
-		trans_pcie->trans->num_rx_queues = num_irqs;
+		info->num_rxqs = num_irqs;
 		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX;
 	} else {
-		trans_pcie->trans->num_rx_queues = num_irqs - 1;
+		info->num_rxqs = num_irqs - 1;
 	}
 
 	IWL_DEBUG_INFO(trans,
 		       "MSI-X enabled with rx queues %d, vec mask 0x%x\n",
-		       trans_pcie->trans->num_rx_queues, trans_pcie->shared_vec_mask);
+		       info->num_rxqs, trans_pcie->shared_vec_mask);
 
-	WARN_ON(trans_pcie->trans->num_rx_queues > IWL_MAX_RX_HW_QUEUES);
+	WARN_ON(info->num_rxqs > IWL_MAX_RX_HW_QUEUES);
 
 	trans_pcie->alloc_vecs = num_irqs;
 	trans_pcie->msix_enabled = true;
 	return;
 
 enable_msi:
+	info->num_rxqs = 1;
 	ret = pci_enable_msi(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "pci_enable_msi failed - %d\n", ret);
@@ -1728,14 +1730,15 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	}
 }
 
-static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans)
+static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
+				      struct iwl_trans_info *info)
 {
 #if defined(CONFIG_SMP)
 	int iter_rx_q, i, ret, cpu, offset;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	i = trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 0 : 1;
-	iter_rx_q = trans_pcie->trans->num_rx_queues - 1 + i;
+	iter_rx_q = info->num_rxqs - 1 + i;
 	offset = 1 + i;
 	for (; i < iter_rx_q ; i++) {
 		/*
@@ -1755,7 +1758,8 @@ static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans)
 }
 
 static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
-				      struct iwl_trans_pcie *trans_pcie)
+				      struct iwl_trans_pcie *trans_pcie,
+				      struct iwl_trans_info *info)
 {
 	int i;
 
@@ -1784,7 +1788,7 @@ static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
 			return ret;
 		}
 	}
-	iwl_pcie_irq_set_affinity(trans_pcie->trans);
+	iwl_pcie_irq_set_affinity(trans_pcie->trans, info);
 
 	return 0;
 }
@@ -2615,7 +2619,7 @@ int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	if (queue >= trans->num_rx_queues || !trans_pcie->rxq)
+	if (queue >= trans->info.num_rxqs || !trans_pcie->rxq)
 		return -EINVAL;
 
 	data->fr_bd_cb = trans_pcie->rxq[queue].bd_dma;
@@ -2928,7 +2932,7 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 	int pos = 0, i, ret;
 	size_t bufsz;
 
-	bufsz = sizeof(char) * 121 * trans->num_rx_queues;
+	bufsz = sizeof(char) * 121 * trans->info.num_rxqs;
 
 	if (!trans_pcie->rxq)
 		return -EAGAIN;
@@ -2937,7 +2941,7 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	for (i = 0; i < trans->num_rx_queues && pos < bufsz; i++) {
+	for (i = 0; i < trans->info.num_rxqs && pos < bufsz; i++) {
 		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
 
 		spin_lock_bh(&rxq->lock);
@@ -3804,7 +3808,8 @@ void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 
 struct iwl_trans *
 iwl_trans_pcie_alloc(struct pci_dev *pdev,
-		     const struct iwl_cfg_trans_params *cfg_trans)
+		     const struct iwl_cfg_trans_params *cfg_trans,
+		     struct iwl_trans_info *info)
 {
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
@@ -3842,7 +3847,8 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		trans_pcie->txqs.tfd.max_tbs = IWL_NUM_OF_TBS;
 		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfd);
 	}
-	trans->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
+
+	info->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
 
 	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
 	if (!trans_pcie->txqs.tso_hdr_page) {
@@ -3954,8 +3960,8 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	trans_pcie->pci_dev = pdev;
 	iwl_disable_interrupts(trans);
 
-	trans->hw_rev = iwl_read32(trans, CSR_HW_REV);
-	if (trans->hw_rev == 0xffffffff) {
+	info->hw_rev = iwl_read32(trans, CSR_HW_REV);
+	if (info->hw_rev == 0xffffffff) {
 		dev_err(&pdev->dev, "HW_REV=0xFFFFFFFF, PCI issues?\n");
 		ret = -EIO;
 		goto out_no_pci;
@@ -3968,14 +3974,13 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * in the old format.
 	 */
 	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000)
-		trans->hw_rev_step = trans->hw_rev & 0xF;
+		info->hw_rev_step = info->hw_rev & 0xF;
 	else
-		trans->hw_rev_step = (trans->hw_rev & 0xC) >> 2;
+		info->hw_rev_step = (info->hw_rev & 0xC) >> 2;
 
-	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
+	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", info->hw_rev);
 
-	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans);
-	trans->hw_id = (pdev->device << 16) + pdev->subsystem_device;
+	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans, info);
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
@@ -3984,7 +3989,7 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		goto out_no_pci;
 
 	if (trans_pcie->msix_enabled) {
-		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
+		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie, info);
 		if (ret)
 			goto out_no_pci;
 	 } else {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 19f033ed3221..665c359e8479 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1039,7 +1039,7 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, u32 flags, u32 sta_mask,
 	size = rounddown_pow_of_two(size);
 
 	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_BZ &&
-	    trans->hw_rev_step == SILICON_A_STEP) {
+	    trans->info.hw_rev_step == SILICON_A_STEP) {
 		size = 4096;
 		txq = iwl_txq_dyn_alloc_dma(trans, size, timeout);
 	} else {
-- 
2.34.1


