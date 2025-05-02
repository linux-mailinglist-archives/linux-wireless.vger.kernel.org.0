Return-Path: <linux-wireless+bounces-22334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A18AA719E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92223BDA7C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB6253938;
	Fri,  2 May 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka+Rvlv0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DC2550A0
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188458; cv=none; b=H+6het3ZXuR3xuE5E3QvNXBV16jESxldDQi1RVDzNxNPqESug/jL5VJkYl7h8eg8e3A4fgW3a2Pv71F7s9YLfH5pgBnEhtpeBlpXR+Z+o6MPVsAbzSC4JGXL08or9pf6ZPHZsLPK/Gp06VQPUSm4wXOCqA/Azm+1+X/CIcjHKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188458; c=relaxed/simple;
	bh=b5uUfqdDXd7rrhHISL4WPOB7btGtAUG06d2e8WX7olU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0XNeHhFSjg6vw3sdeeU7O/KSXu9iGTuI8OfHQdbBsWFizO8G+YY2mtIGLr2QnIAa2Yxqr3/7zhbxLF4yHxKe2wCrBifrlk+D2+R7a13AwNUXyJaZOcV2skSzM3nOJBb5lT93cnzurM+ZB3fL42cYsvWU11Ug8e2gNHAwarlrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka+Rvlv0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188456; x=1777724456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5uUfqdDXd7rrhHISL4WPOB7btGtAUG06d2e8WX7olU=;
  b=ka+Rvlv0PciWoKsafqCrBKBAtmfOqC3xURs56lv+I5sRx70FI9tz9Vnm
   tLOAmVy+Ttv3twcMR0NstbOAxGSJBVugwabm9agqsQFMor0B2dN+RSgDs
   V2pHpv3Rroyv80gONKGPQyr1g6NmjBHa/msPPU+FRUYRIBGUaT4Ddof09
   BziAoeJvPevaSqmQ77+yjprgwatDSeS73dBHzTqe1YvVpORlt/4GNQgVQ
   N0XTYuOXkmIbvM3NpYVqaQW0VFkmr/DiAFNqz1KYDMPNP4/hcWJ/rjMoW
   vxDV0lwxH9q+W1G1uPtcnMnENaxP3KiFMdJAwlE96I5BDkVr+qPsLUPkr
   A==;
X-CSE-ConnectionGUID: w5Qem1q7Q6O9lKegj0ENtw==
X-CSE-MsgGUID: I+r3ibC5TwCmiUWjzXwDMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010362"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010362"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:56 -0700
X-CSE-ConnectionGUID: eXyZd11USNyVWlS7o7VAXg==
X-CSE-MsgGUID: PKZXFy4yTNGRsmIrQrNSEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586126"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 08/15] wifi: iwlwifi: cfg: remove fw_name_mac
Date: Fri,  2 May 2025 15:20:23 +0300
Message-Id: <20250502151751.8dba9a2d3546.I41fa594d6a0be163444b90c1ed4b441a949d3899@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of having fw_name_mac in the config, derive it
from the MAC type instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 11 ----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  2 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  3 --
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 54 ++++++++++++++++---
 7 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1237d1b62b65..b2d24a49234c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -171,7 +171,6 @@ const struct iwl_cfg_trans_params iwl_qu_long_latency_trans_cfg = {
  * 9560 nevertheless.
  */
 const struct iwl_cfg iwl9560_qu_jf_cfg = {
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
@@ -212,7 +211,6 @@ const char iwl_ax201_killer_1650i_name[] =
 	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
 const struct iwl_cfg iwl_qu_hr1 = {
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -225,7 +223,6 @@ const struct iwl_cfg iwl_qu_hr1 = {
 };
 
 const struct iwl_cfg iwl_qu_hr = {
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -238,7 +235,6 @@ const struct iwl_cfg iwl_qu_hr = {
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -250,7 +246,6 @@ const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 };
 
 const struct iwl_cfg iwl_quz_hr1 = {
-	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -264,7 +259,6 @@ const struct iwl_cfg iwl_quz_hr1 = {
 
 const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -277,7 +271,6 @@ const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
 
 const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -290,7 +283,6 @@ const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
 
 const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
          * This device doesn't support receiving BlockAck with a large bitmap
@@ -315,7 +307,6 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -328,7 +319,6 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_hr = {
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_hr = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_mac = "Qu",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -340,7 +330,6 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_hr = {
 };
 
 const struct iwl_cfg iwl_cfg_quz_hr = {
-	.fw_name_mac = "QuZ",
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index e87b57b9e2c0..309d59d28c73 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -248,7 +248,6 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 };
 
 const struct iwl_cfg iwl_cfg_ma = {
-	.fw_name_mac = "ma",
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index f055255a7c93..1d491c72bae8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -163,7 +163,6 @@ const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 
 const struct iwl_cfg iwl_cfg_bz = {
-	.fw_name_mac = "bz",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
@@ -171,7 +170,6 @@ const struct iwl_cfg iwl_cfg_bz = {
 };
 
 const struct iwl_cfg iwl_cfg_gl = {
-	.fw_name_mac = "gl",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 282b9b846c3a..4bca1b13858f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -138,7 +138,6 @@ const struct iwl_cfg_trans_params iwl_dr_trans_cfg = {
 const char iwl_dr_name[] = "Intel(R) TBD Dr device";
 
 const struct iwl_cfg iwl_cfg_dr = {
-	.fw_name_mac = "dr",
 	IWL_DEVICE_DR,
 };
 
@@ -156,7 +155,6 @@ const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
 const char iwl_br_name[] = "Intel(R) TBD Br device";
 
 const struct iwl_cfg iwl_cfg_br = {
-	.fw_name_mac = "br",
 	IWL_DEVICE_DR,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 5c740f302c93..4b39f11c9582 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -146,17 +146,14 @@ const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
 const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
 
 const struct iwl_cfg iwl_cfg_sc = {
-	.fw_name_mac = "sc",
 	IWL_DEVICE_SC,
 };
 
 const struct iwl_cfg iwl_cfg_sc2 = {
-	.fw_name_mac = "sc2",
 	IWL_DEVICE_SC,
 };
 
 const struct iwl_cfg iwl_cfg_sc2f = {
-	.fw_name_mac = "sc2f",
 	IWL_DEVICE_SC,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index db8dbdde55bd..82ca7faf3fe0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -312,7 +312,6 @@ struct iwl_fw_mon_regs {
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
  *	filename is constructed as <fw_name_pre>-<api>.ucode.
- * @fw_name_mac: MAC name for this config, the remaining pieces of the
  *	name will be generated dynamically
  * @ucode_api_max: Highest version of uCode API supported by driver.
  * @ucode_api_min: Lowest version of uCode API supported by driver.
@@ -363,7 +362,6 @@ struct iwl_cfg {
 	/* params specific to an individual device within a device family */
 	const char *name;
 	const char *fw_name_pre;
-	const char *fw_name_mac;
 	/* params likely to change within a device family */
 	const struct iwl_ht_params *ht_params;
 	const struct iwl_eeprom_params *eeprom_params;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d36837501e08..0b208d973585 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -182,16 +182,59 @@ static bool iwl_drv_is_wifi7_supported(struct iwl_trans *trans)
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 {
 	char mac_step, rf_step;
-	const char *rf, *cdb;
+	const char *mac, *rf, *cdb;
 
 	if (trans->cfg->fw_name_pre)
 		return trans->cfg->fw_name_pre;
 
-	if (WARN_ON(!trans->cfg->fw_name_mac))
-		return "unconfigured";
-
 	mac_step = iwl_drv_get_step(trans->hw_rev_step);
 
+	switch (CSR_HW_REV_TYPE(trans->hw_rev)) {
+	case IWL_CFG_MAC_TYPE_PU:
+		mac = "pu";
+		break;
+	case IWL_CFG_MAC_TYPE_TH:
+		mac = "th";
+		break;
+	case IWL_CFG_MAC_TYPE_QU:
+		mac = "Qu";
+		break;
+	case IWL_CFG_MAC_TYPE_QUZ:
+		mac = "QuZ";
+		break;
+	case IWL_CFG_MAC_TYPE_SO:
+	case IWL_CFG_MAC_TYPE_SOF:
+		mac = "so";
+		break;
+	case IWL_CFG_MAC_TYPE_MA:
+		mac = "ma";
+		break;
+	case IWL_CFG_MAC_TYPE_BZ:
+	case IWL_CFG_MAC_TYPE_BZ_W:
+		mac = "bz";
+		break;
+	case IWL_CFG_MAC_TYPE_GL:
+		mac = "gl";
+		break;
+	case IWL_CFG_MAC_TYPE_SC:
+		mac = "sc";
+		break;
+	case IWL_CFG_MAC_TYPE_SC2:
+		mac = "sc2";
+		break;
+	case IWL_CFG_MAC_TYPE_SC2F:
+		mac = "sc2f";
+		break;
+	case IWL_CFG_MAC_TYPE_BR:
+		mac = "br";
+		break;
+	case IWL_CFG_MAC_TYPE_DR:
+		mac = "dr";
+		break;
+	default:
+		return "unknown-mac";
+	}
+
 	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->hw_rf_id));
 
 	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
@@ -223,8 +266,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 
 	scnprintf(buf, FW_NAME_PRE_BUFSIZE,
 		  "iwlwifi-%s-%c0-%s%s-%c0",
-		  trans->cfg->fw_name_mac, mac_step,
-		  rf, cdb, rf_step);
+		  mac, mac_step, rf, cdb, rf_step);
 
 	return buf;
 }
-- 
2.34.1


