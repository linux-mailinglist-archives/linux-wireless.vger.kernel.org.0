Return-Path: <linux-wireless+bounces-22300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42AEAA5CDD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837417B1120
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332925D914;
	Thu,  1 May 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpZrCzBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FD22D4D0
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093606; cv=none; b=I6zTbuZDhAA61aNRNzcfHmtRm1Rz1cvvxlt4b0rYZfOe/Ug9bBY91nRQKL76czevOoMLBQzIwm/euO05ZcZbPSgHo/O58KGpHhaML64yAGuftaVfnK4qM7KIGPTFlxzFGmQXB8kEiVdFEmz9J4efHlJmyhxar7tfglVrA/Xq5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093606; c=relaxed/simple;
	bh=b5uUfqdDXd7rrhHISL4WPOB7btGtAUG06d2e8WX7olU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIOqLPF4mKnROwdNCbl7YLFcXxDpUf560TLh/myh2GzdIiZtsxUs0lJSRYF+l2YNMP+BI+DIrQeitdcZcqkE8yQ6fHiUrbiHJbxfXPJ65iiSw2Cv7FJ1aBvNjI8ISQnlSE9p9Ur+U1/VIWFtTCBvxrid4Pcdb+pp6+R6/4dRyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpZrCzBU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093604; x=1777629604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5uUfqdDXd7rrhHISL4WPOB7btGtAUG06d2e8WX7olU=;
  b=SpZrCzBUFh2Dh4rtkKFIAmSFUkM80w57s7ow2y+/pYZr7DzWvUgjnuO5
   XcD1rJRJKMLVZgTy5rs49LI1nqRVbL2WFZVLa+hWLGgXrOxlI+2795NqD
   od64up/IGE26LYNdG29jfUNM+KQArY/4zsgInXvw2yZ2fpqksgX2ZoMh8
   hAV10b9yVwXXfENMJ6DbPjLGuJivwNWghByFJiR7v7lTtPZ+c9WyMrwFA
   8QRGvQAN0gr8necYca07zQRLZ0E9HoKdvDoTSXDNpsnZ8cAyGTIPMKuCH
   kv9+nrPvIXExr8YtkzcV5RqV7P6D4mv76lSqWozUrEn8WNvgFuQjpuIud
   w==;
X-CSE-ConnectionGUID: J7CmYaFLSDiXhe6xLfLoSQ==
X-CSE-MsgGUID: cf51D7OTSkubAzXGZ6iaRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962833"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962833"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:04 -0700
X-CSE-ConnectionGUID: 2LuNKZiFQfqEmb+ON90edQ==
X-CSE-MsgGUID: U+1F9p3QR9S1+WNjER/UMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317985"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: cfg: remove fw_name_mac
Date: Thu,  1 May 2025 12:59:30 +0300
Message-Id: <20250501125731.6049360b177d.I41fa594d6a0be163444b90c1ed4b441a949d3899@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
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


