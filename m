Return-Path: <linux-wireless+bounces-22770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F6AB10FA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF11C251CD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59521D3CD;
	Fri,  9 May 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQS4YhUN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FC21ADA3
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787512; cv=none; b=KmfSlN2v3C9iruKgusuNfnSE9/znl06ymn+2jdwCWp83H+2UGehSCUGeythl7jMkrfrpesKZl00gw1N90DxlwkmNPN4AmE0dA2DhVSPEVmlozNx/oZ+RRZYMuPLps0u4DFRiiPgxPrSieabnbGS8txUTA1NN8N3T3Qzb1kAyUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787512; c=relaxed/simple;
	bh=6WVip0+aCcEFZBxFTAGC0i6HbWeAMuE8uPplTLJ019Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a052aOAqWyein9WiAZuUJ/Wy3aKHugPvCwyw4CJ4jGVkArTYF4nasGatDvI6NhQaYsXtXK/QUlmwWaDv4v+WTmYTMquNuhS/0V8uHdQ4Xp9aDBIIexfGstzKlaTbve5Tx9zH8TKg66qLi6sjxtP7VAaMiEZUOTlJiLLHcgRRuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQS4YhUN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787510; x=1778323510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WVip0+aCcEFZBxFTAGC0i6HbWeAMuE8uPplTLJ019Y=;
  b=aQS4YhUNl6zSVgzWS5br+VAcCiKeXgpSJ+EV6cxhGEeDPgX3G7V2HBlk
   6dqg9myep4eppWD2JMwYltdDkDMB0tGyKqNZAPL8r3fuvXgIB1FhWNfC1
   3QEMczREwg1oeRurYcMSI+gbNJAF+weCRcoCRphFaWY13lcgO4vUthlJ1
   i9N9coQJQabsnzAOW45vxFhM0ehmZwCikodT4XBH0nxbO94JidudLiVUU
   a0o1H9zHVlcZ8AAiosK5aqcHypIsaEfOrSWXWieSPyZTjDmLXxMBSlOvX
   APOnqleZp1aFEX/ejrgXnmNyKBicU6dJg4gJa2jR0Zpd55y2iQD23oQD3
   Q==;
X-CSE-ConnectionGUID: KRYFjOANTjW2DISMr1YbOA==
X-CSE-MsgGUID: wjBNSN1zTLOXqI2Ojoj9Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239869"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239869"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:09 -0700
X-CSE-ConnectionGUID: HCRCWUn3QRujrPbiVZ7jEg==
X-CSE-MsgGUID: pGpvuqm0Roq6fiy/5sjQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537008"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: cfg: add ucode API min/max to MAC config
Date: Fri,  9 May 2025 13:44:40 +0300
Message-Id: <20250509104454.2582160-2-miriam.rachel.korenblit@intel.com>
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

In some older devices, the min/max firmware API supported by
the driver depends on the specific device, when sharing the
the same MAC (config). For most newer devices, it really is
dependent on the MAC instead, since the firmware was frozen
for certain MAC types. However, in the future we expect also
freezes for RF types there.

To handle this most generally, add an API min/max to the MAC
config and then use the narrowest range prescribed by both,
if set.

For the newer MACs since 9000, move the configuration, there
was only a freeze on MAC+RF lines so far.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.23a88a8b57cf.I9ba14e8caa547a9cd0301e5ee7f0d40a8e99a2ba@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  4 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 44 +++++++++++++++----
 8 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 42f2e2ede774..92ae336405fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -83,11 +83,11 @@ static const struct iwl_family_base_params iwl_22000_base = {
 			.mask = 0xffffffff,
 		},
 	},
+	.ucode_api_min = IWL_22000_UCODE_API_MIN,
+	.ucode_api_max = IWL_22000_UCODE_API_MAX,
 };
 
 #define IWL_DEVICE_22500						\
-	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
-	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index bc497abd07c1..5424133fae1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -72,6 +72,8 @@ static const struct iwl_family_base_params iwl9000_base = {
 			.mask = 0xffffffff,
 		},
 	},
+	.ucode_api_max = IWL9000_UCODE_API_MAX,
+	.ucode_api_min = IWL9000_UCODE_API_MIN,
 };
 
 static const struct iwl_tt_params iwl9000_tt_params = {
@@ -96,8 +98,6 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 };
 
 #define IWL_DEVICE_9000							\
-	.ucode_api_max = IWL9000_UCODE_API_MAX,				\
-	.ucode_api_min = IWL9000_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
 	.dccm_offset = IWL9000_DCCM_OFFSET,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 748c1f1f73a2..d0a8069196b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -87,11 +87,11 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,
 		},
 	},
+	.ucode_api_min = IWL_AX210_UCODE_API_MIN,
+	.ucode_api_max = IWL_AX210_UCODE_API_MAX,
 };
 
 #define IWL_DEVICE_AX210						\
-	.ucode_api_min = IWL_AX210_UCODE_API_MIN,			\
-	.ucode_api_max = IWL_AX210_UCODE_API_MAX,			\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 3c632b8c7650..86871b0431b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -89,11 +89,11 @@ static const struct iwl_family_base_params iwl_bz_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.ucode_api_max = IWL_BZ_UCODE_API_MAX,
+	.ucode_api_min = IWL_BZ_UCODE_API_MIN,
 };
 
 #define IWL_DEVICE_BZ							\
-	.ucode_api_max = IWL_BZ_UCODE_API_MAX,				\
-	.ucode_api_min = IWL_BZ_UCODE_API_MIN,				\
 	.ht_params = {							\
 		.stbc = true,						\
 		.ldpc = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index d7f0797c3231..6696c30ed7b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -82,11 +82,11 @@ static const struct iwl_family_base_params iwl_dr_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.ucode_api_max = IWL_DR_UCODE_API_MAX,
+	.ucode_api_min = IWL_DR_UCODE_API_MIN,
 };
 
 #define IWL_DEVICE_DR							\
-	.ucode_api_max = IWL_DR_UCODE_API_MAX,				\
-	.ucode_api_min = IWL_DR_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index e9a94d4c7d4d..6669dc316019 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -89,11 +89,11 @@ static const struct iwl_family_base_params iwl_sc_base = {
 		},
 	},
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.ucode_api_max = IWL_SC_UCODE_API_MAX,
+	.ucode_api_min = IWL_SC_UCODE_API_MIN,
 };
 
 #define IWL_DEVICE_SC							\
-	.ucode_api_max = IWL_SC_UCODE_API_MAX,				\
-	.ucode_api_min = IWL_SC_UCODE_API_MIN,				\
 	.led_mode = IWL_LED_RF_STATE,					\
 	.non_shared_ant = ANT_B,					\
 	.vht_mu_mimo_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b5cfaad6a037..9e6c9650fbae 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -170,6 +170,8 @@ struct iwl_fw_mon_regs {
  * @mon_dbgi_regs: monitor DBGI registers
  * @mon_dram_regs: monitor DRAM registers
  * @mon_smem_regs: monitor SMEM registers
+ * @ucode_api_max: Highest version of uCode API supported by driver.
+ * @ucode_api_min: Lowest version of uCode API supported by driver.
  */
 struct iwl_family_base_params {
 	unsigned int wd_timeout;
@@ -190,6 +192,8 @@ struct iwl_family_base_params {
 
 	u8 max_ll_items;
 	u8 led_compensation;
+	u8 ucode_api_max;
+	u8 ucode_api_min;
 	u32 mac_addr_from_csr:10;
 	u8 nvm_hw_section_num;
 	netdev_features_t features;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d300b7a12ed7..8734c7913b2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -291,12 +291,37 @@ IWL_EXPORT_SYMBOL(iwl_drv_get_fwname_pre);
 static void iwl_req_fw_callback(const struct firmware *ucode_raw,
 				void *context);
 
+static void iwl_get_ucode_api_versions(struct iwl_trans *trans,
+				       unsigned int *api_min,
+				       unsigned int *api_max)
+{
+	const struct iwl_family_base_params *base = trans->mac_cfg->base;
+	const struct iwl_cfg *cfg = trans->cfg;
+
+	if (!base->ucode_api_max) {
+		*api_min = cfg->ucode_api_min;
+		*api_max = cfg->ucode_api_max;
+		return;
+	}
+
+	if (!cfg->ucode_api_max) {
+		*api_min = base->ucode_api_min;
+		*api_max = base->ucode_api_max;
+		return;
+	}
+
+	*api_min = max(cfg->ucode_api_min, base->ucode_api_min);
+	*api_max = min(cfg->ucode_api_max, base->ucode_api_max);
+}
+
 static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 {
-	const struct iwl_cfg *cfg = drv->trans->cfg;
 	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
+	unsigned int ucode_api_max, ucode_api_min;
 	const char *fw_name_pre;
 
+	iwl_get_ucode_api_versions(drv->trans, &ucode_api_min, &ucode_api_max);
+
 	if (drv->trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (drv->trans->info.hw_rev_step != SILICON_B_STEP &&
 	     drv->trans->info.hw_rev_step != SILICON_C_STEP)) {
@@ -309,21 +334,21 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	fw_name_pre = iwl_drv_get_fwname_pre(drv->trans, _fw_name_pre);
 
 	if (first)
-		drv->fw_index = cfg->ucode_api_max;
+		drv->fw_index = ucode_api_max;
 	else
 		drv->fw_index--;
 
-	if (drv->fw_index < cfg->ucode_api_min) {
+	if (drv->fw_index < ucode_api_min) {
 		IWL_ERR(drv, "no suitable firmware found!\n");
 
-		if (cfg->ucode_api_min == cfg->ucode_api_max) {
+		if (ucode_api_min == ucode_api_max) {
 			IWL_ERR(drv, "%s-%d is required\n", fw_name_pre,
-				cfg->ucode_api_max);
+				ucode_api_max);
 		} else {
 			IWL_ERR(drv, "minimum version required: %s-%d\n",
-				fw_name_pre, cfg->ucode_api_min);
+				fw_name_pre, ucode_api_min);
 			IWL_ERR(drv, "maximum version supported: %s-%d\n",
-				fw_name_pre, cfg->ucode_api_max);
+				fw_name_pre, ucode_api_max);
 		}
 
 		IWL_ERR(drv,
@@ -1554,14 +1579,15 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	struct iwlwifi_opmode_table *op;
 	int err;
 	struct iwl_firmware_pieces *pieces;
-	const unsigned int api_max = drv->trans->cfg->ucode_api_max;
-	const unsigned int api_min = drv->trans->cfg->ucode_api_min;
+	unsigned int api_min, api_max;
 	size_t trigger_tlv_sz[FW_DBG_TRIGGER_MAX];
 	u32 api_ver;
 	int i;
 	bool usniffer_images = false;
 	bool failure = true;
 
+	iwl_get_ucode_api_versions(drv->trans, &api_min, &api_max);
+
 	fw->ucode_capa.max_probe_length = IWL_DEFAULT_MAX_PROBE_LENGTH;
 	fw->ucode_capa.standard_phy_calibration_size =
 			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
-- 
2.34.1


