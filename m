Return-Path: <linux-wireless+bounces-22771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB9AB10FB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C2A0695F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0221ADA3;
	Fri,  9 May 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyMGKcDK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949428F51B
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787513; cv=none; b=RvKk9tCu6WeDJqRP6us+bIBQ0VcAUn38RzZf0QtpmGaW3UPCd0tkfrc4ShDVBf5ki5fOuaZhQO4yegnxw+dJCrjjIC3ilVhBJNU//GSjRDij1rfFoTHsrRYDMYzonukK1UvhUWqziaNmf2Od5tWHoYWbOE4ddY0PMyV85yHaezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787513; c=relaxed/simple;
	bh=bl1nkgXljoYzT629OL0iSsj6mGgkSPvaIJFYOz5fuBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsfApaf9DVyfoKPLbbj0/pFdX159ieBP3at8YE1L6mDsywRana3cqEeKZh6Oa3ea1jWRAmCvvM6sSvVvod0LDxhj6uvVMNkK64yw1ZzZS9FhvyuxVKxX0ARvXuax4Jqx4n3giLxHnqip654P/gPwTUdW3aqU8cwgXLH5xr53Ve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyMGKcDK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787511; x=1778323511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bl1nkgXljoYzT629OL0iSsj6mGgkSPvaIJFYOz5fuBo=;
  b=AyMGKcDK1WfRGcFQfdTOhtF3+th9gHYtBMI226DxvTyU5WLaeJcAnAAj
   g4Ln/CXZnMAZQmGgRuvrtKTaByTLNeygOQDMZuNAlomuRNM+YSvhp+RwP
   leBXyBd5w1WYSNkImV1AQAE1166rVg8wnTym1aPoi9p6PUiORUpupDBjE
   lPB9BkneuFpUovd0I+zJLxE9LIorV9mzUVJU1cxtkJlT2qXcXwlivX0X5
   FIr11LT2OJe+PX1cOBV/bS+NgoE0AHTdNUsGYIB0/eETbi2KpiAURr9Nz
   XZCa/pNmIaji6Ks9EjkBMhKEiEfw0L9zMGCZoGO1S4dzH6630E/ny9PQM
   Q==;
X-CSE-ConnectionGUID: y4SDwg4IRK60nSIbzgoPhw==
X-CSE-MsgGUID: HQb+C3hZRMKXdU9QCWGcmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239878"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:11 -0700
X-CSE-ConnectionGUID: 1pdrNFvlRkG4364A9GUowA==
X-CSE-MsgGUID: Nw75LIa+R1GKw0KqQKAX9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537011"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: cfg: unify num_rbds config
Date: Fri,  9 May 2025 13:44:41 +0300
Message-Id: <20250509104454.2582160-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This should depend on both the RF (VHT/HE/EHT support) and
the MAC (<=22000 can put multiple frames into one buffer),
so unify the config in the struct iwl_cfg to just have it
sized according to the RF, and then double it for all the
MACs starting from AX210 (So/Ty).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.d7326eb49e10.I5e86b672f6e4dfe96c602a60166a5a75e1c2e2b8@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c   | 16 +++-------------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c   | 16 +++-------------
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c      | 10 ++--------
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c      |  8 +-------
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c      |  8 +-------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h  | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h   | 13 +++++++++++++
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c     |  2 +-
 12 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 92ae336405fd..0ae910828704 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -131,16 +131,6 @@ const struct iwl_mac_cfg iwl_qu_long_latency_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-/*
- * If the device doesn't support HE, no need to have that many buffers.
- * 22000 devices can split multiple frames into a single RB, so fewer are
- * needed; AX210 cannot (but use smaller RBs by default) - these sizes
- * were picked according to 8 MSDUs inside 256 A-MSDUs in an A-MPDU, with
- * additional overhead to account for processing time.
- */
-#define IWL_NUM_RBDS_NON_HE		512
-#define IWL_NUM_RBDS_22000_HE		2048
-
 /*
  * All JF radio modules are part of the 9000 series, but the MAC part
  * looks more like 22000.  That's why this device is here, but called
@@ -182,17 +172,17 @@ const char iwl_ax201_killer_1650i_name[] =
 const struct iwl_cfg iwl_qu_hr1 = {
 	IWL_DEVICE_22500,
 	.tx_with_siso_diversity = true,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 };
 
 const struct iwl_cfg iwl_qu_hr = {
 	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 };
 
 const struct iwl_cfg iwl_qu_hr_80mhz = {
 	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 	.bw_limit = 80,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 5424133fae1d..e4f99cef6d7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -105,7 +105,7 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.dccm2_offset = IWL9000_DCCM2_OFFSET,				\
 	.dccm2_len = IWL9000_DCCM2_LEN,					\
 	.thermal_params = &iwl9000_tt_params,				\
-	.num_rbds = 512,						\
+	.num_rbds = IWL_NUM_RBDS_NON_HE,				\
 	.vht_mu_mimo_supported = true,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.ht_params = {							\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index d0a8069196b2..6d3c1e032265 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -141,16 +141,6 @@ const struct iwl_mac_cfg iwl_so_long_latency_imr_mac_cfg = {
 	.imr_enabled = true,
 };
 
-/*
- * If the device doesn't support HE, no need to have that many buffers.
- * AX210 devices can split multiple frames into a single RB, so fewer are
- * needed; AX210 cannot (but use smaller RBs by default) - these sizes
- * were picked according to 8 MSDUs inside 256 A-MSDUs in an A-MPDU, with
- * additional overhead to account for processing time.
- */
-#define IWL_NUM_RBDS_NON_HE		512
-#define IWL_NUM_RBDS_AX210_HE		4096
-
 const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_AX210,
 	.base = &iwl_ax210_base,
@@ -193,17 +183,17 @@ const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
 const struct iwl_cfg iwl_cfg_ma = {
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 };
 
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
 	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 };
 
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz = {
 	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.num_rbds = IWL_NUM_RBDS_HE,
 	.bw_limit = 80,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 86871b0431b1..dc1b4930c24a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -106,12 +106,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.nvm_ver = IWL_BZ_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT
 
-/*
- * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
- * A-MPDU, with additional overhead to account for processing time.
- */
-#define IWL_NUM_RBDS_BZ_EHT		(512 * 16)
-
 const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base = &iwl_bz_base,
@@ -142,13 +136,13 @@ const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 const struct iwl_cfg iwl_cfg_bz = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
+	.num_rbds = IWL_NUM_RBDS_EHT,
 };
 
 const struct iwl_cfg iwl_cfg_bz_160mhz = {
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
+	.num_rbds = IWL_NUM_RBDS_EHT,
 	.bw_limit = 160,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 6696c30ed7b6..91da09423158 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -93,7 +93,7 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.nvm_ver = IWL_DR_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.uhb_supported = true,						\
-	.num_rbds = IWL_NUM_RBDS_DR_EHT,				\
+	.num_rbds = IWL_NUM_RBDS_EHT,				\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
@@ -101,12 +101,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 			      BIT(NL80211_BAND_5GHZ),			\
 	}
 
-/*
- * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
- * A-MPDU, with additional overhead to account for processing time.
- */
-#define IWL_NUM_RBDS_DR_EHT		(512 * 16)
-
 const struct iwl_mac_cfg iwl_dr_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_DR,
 	.base = &iwl_dr_base,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 6669dc316019..6db25355df42 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -100,7 +100,7 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.nvm_ver = IWL_SC_NVM_VERSION,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.uhb_supported = true,						\
-	.num_rbds = IWL_NUM_RBDS_SC_EHT,				\
+	.num_rbds = IWL_NUM_RBDS_EHT,				\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
@@ -108,12 +108,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 			      BIT(NL80211_BAND_5GHZ),			\
 	}
 
-/*
- * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
- * A-MPDU, with additional overhead to account for processing time.
- */
-#define IWL_NUM_RBDS_SC_EHT		(512 * 16)
-
 const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_SC,
 	.base = &iwl_sc_base,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9e6c9650fbae..3593914793a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -342,6 +342,16 @@ struct iwl_mac_cfg {
 	    imr_enabled:1;
 };
 
+/*
+ * These sizes were picked according to 8 MSDUs inside 64/256/612 A-MSDUs
+ * in an A-MPDU, with additional overhead to account for processing time.
+ * They will be doubled for MACs starting from So/Ty that don't support
+ * putting multiple frames into a single buffer.
+ */
+#define IWL_NUM_RBDS_NON_HE		(64 * 8)
+#define IWL_NUM_RBDS_HE			(256 * 8)
+#define IWL_NUM_RBDS_EHT		(512 * 8)
+
 /**
  * struct iwl_cfg
  * @fw_name_pre: Firmware filename prefix. The api version and extension
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 904df78297f3..894436a65351 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1214,6 +1214,19 @@ static inline bool iwl_trans_is_hw_error_value(u32 val)
 
 void iwl_trans_free_restart_list(void);
 
+static inline u16 iwl_trans_get_num_rbds(struct iwl_trans *trans)
+{
+	u16 result = trans->cfg->num_rbds;
+
+	/*
+	 * Since AX210 family (So/Ty) the device cannot put mutliple
+	 * frames into the same buffer, so double the value for them.
+	 */
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return 2 * result;
+	return result;
+}
+
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index dcc8edeb34ff..4759e570e807 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -256,7 +256,7 @@ int iwl_pcie_ctxt_info_gen3_alloc(struct iwl_trans *trans,
 	ctxt_info_gen3->mtr_size =
 		cpu_to_le16(TFD_QUEUE_CB_SIZE(cmdq_size));
 	ctxt_info_gen3->mcr_size =
-		cpu_to_le16(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds));
+		cpu_to_le16(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)));
 
 	trans_pcie->ctxt_info_gen3 = ctxt_info_gen3;
 	trans_pcie->prph_info = prph_info;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cc3e3d91b27f..cb36baac14da 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -202,10 +202,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		rb_size = IWL_CTXT_INFO_RB_SIZE_4K;
 	}
 
-	WARN_ON(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds) > 12);
+	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
 	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
 	control_flags |=
-		u32_encode_bits(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds),
+		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
 				IWL_CTXT_INFO_RB_CB_SIZE);
 	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
 	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 45a62733b28a..7db0ca1a59aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1864,7 +1864,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ret = -EINVAL;
 			goto out_free_trans;
 		}
-		trans_pcie->num_rx_bufs = iwl_trans->cfg->num_rbds;
+		trans_pcie->num_rx_bufs = iwl_trans_get_num_rbds(iwl_trans);
 	} else {
 		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index c283ceff0417..c5fdadf7de1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -722,7 +722,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 
 	spin_lock_init(&rxq->lock);
 	if (trans->mac_cfg->mq_rx_supported)
-		rxq->queue_size = trans->cfg->num_rbds;
+		rxq->queue_size = iwl_trans_get_num_rbds(trans);
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
 
-- 
2.34.1


