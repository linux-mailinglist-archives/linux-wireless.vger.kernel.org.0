Return-Path: <linux-wireless+bounces-22350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8BAA72B5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961A27A8881
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AA25486C;
	Fri,  2 May 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6YAOw29"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4B25485D
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190621; cv=none; b=ZD//rZa6ti/x3Urk4es+W06lqQIsTcuFA1kxwppf0mb+VSRLww5HAHQnvMOPAA/Np7ZJIcp355+MQbe36JSMykfx49DQDVWH5VczOPWX2Q/KCMrurvepcZo4YWqPjmgsxYmjvG42+HLHemgFLc3PyMpd/XifQ/T2FWxSjw7yVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190621; c=relaxed/simple;
	bh=rfpxCHc8EqIVhIjW1jLtIFyScK3WroJcGrpM2HwAHZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZCeAr7WfCQr6PzIPOLIijFeITrG7Bo5Go2tNvi5Ar18PnLCwt4XgMkXkT5J9O4bHR3Cq/l4FGOBwiCCZknEjeS2zRv4au2x6MIRj6lQmhS7Z7Q2FoHIvkR9vk9V4iEoSgAJkOfV1cb9/P/GxAmnmbdtzPRbVa9JnnctVQPTyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6YAOw29; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190621; x=1777726621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rfpxCHc8EqIVhIjW1jLtIFyScK3WroJcGrpM2HwAHZg=;
  b=T6YAOw29zgF1NV2c8yINcQpUoIdiwU0VqdgfuAXCiNdlHq8W2XGe/Ph/
   muBlOs+lRJAFdpBLSq2rT+eNEz4WxR0nIgYNv8Dzz+zSS1EqArVUyqt9s
   wdTSZLhma5QNH5B1pCjL/EWM/eAQPpXAsct6YX9BtGIgrNkE1FGv0kYp5
   fJKu5REkV2h9+tBitWuw7KIgE8c86cV21dTAJsVLoFMwKM9QcxxU/bku6
   SOOAK3Uj8fVvUfV6tfsUkhx7QGZAlJJEN8HqAQIm1ynepFVz0pf5u40fW
   Vt6i8Chje6XFRDr+83XQlFHKGYoVzmp7MpToWPdJMmfvTvvfN1hY7OyO8
   g==;
X-CSE-ConnectionGUID: PyrxF++kRGqMuJXhGZlzOQ==
X-CSE-MsgGUID: uUDQ1IWVRjW/0E/OIxNjMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255552"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:00 -0700
X-CSE-ConnectionGUID: AU0eiFccQKSwjyWNwDHJVg==
X-CSE-MsgGUID: 9lSzhxddTUqL9s6VyI/ZVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554736"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: cfg: move all names out of configs
Date: Fri,  2 May 2025 15:56:25 +0300
Message-Id: <20250502155404.1538369bffde.Id430ff71f57cbb37c19ecc5b41c831e5ba9b0695@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Move all the names into dev info structs and remove
the pointer from the configs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  1 -
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  6 +--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 52 +++++++++----------
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 10 +---
 5 files changed, 29 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 7f6f6a9ea615..9a1623091af7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -123,7 +123,6 @@ const struct iwl_cfg iwl8260_cfg = {
 };
 
 const struct iwl_cfg iwl8265_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 8265",
 	.fw_name_pre = IWL8265_FW_PRE,
 	IWL_DEVICE_8265,
 	.ht_params = &iwl8000_ht_params,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 610dbbaee26f..6f081aaa5c57 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -191,7 +191,6 @@ const char iwl_ax411_killer_1690i_name[] =
 	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
@@ -205,15 +204,15 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz = {
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
-	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
+
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
 	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -221,7 +220,6 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
-	.name = iwl_ax411_name,
 	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e8fc51fae61d..cded707223fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -307,7 +307,6 @@ struct iwl_fw_mon_regs {
 
 /**
  * struct iwl_cfg
- * @name: Official name of the device
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
  *	filename is constructed as <fw_name_pre>-<api>.ucode.
@@ -358,7 +357,6 @@ struct iwl_fw_mon_regs {
  */
 struct iwl_cfg {
 	/* params specific to an individual device within a device family */
-	const char *name;
 	const char *fw_name_pre;
 	/* params likely to change within a device family */
 	const struct iwl_ht_params *ht_params;
@@ -613,6 +611,7 @@ extern const char iwl_ax211_killer_1675s_name[];
 extern const char iwl_ax211_killer_1675i_name[];
 extern const char iwl_ax411_killer_1690s_name[];
 extern const char iwl_ax411_killer_1690i_name[];
+extern const char iwl_ax210_name[];
 extern const char iwl_ax211_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 55f07c68339c..0165c06fd7aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1588,57 +1588,57 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x6074)),
 
 	/* So with HR */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x2725), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x2020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0024)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE024)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x4020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6024)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675w_name,
 		     DEVICE(0x2725), SUBDEV(0x1673)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675x_name,
 		     DEVICE(0x2725), SUBDEV(0x1674)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, NULL,
+	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name,
 		     DEVICE(0x7A70), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, NULL,
+	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name,
 		     DEVICE(0x7AF0), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
+	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
@@ -2301,10 +2301,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_free_trans;
 	}
 
-	/* if we don't have a name yet, copy name from the old cfg */
-	if (!iwl_trans->name)
-		iwl_trans->name = iwl_trans->cfg->name;
-
 	IWL_INFO(iwl_trans, "Detected %s\n", iwl_trans->name);
 
 	if (iwl_trans->trans_cfg->mq_rx_supported) {
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 15bf1aba83c0..1e339284d2c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -54,7 +54,7 @@ static void devinfo_names(struct kunit *test)
 	for (idx = 0; idx < iwl_dev_info_table_size; idx++) {
 		const struct iwl_dev_info *di = &iwl_dev_info_table[idx];
 
-		KUNIT_ASSERT_TRUE(test, di->name || di->cfg->name);
+		KUNIT_ASSERT_TRUE(test, di->name);
 	}
 }
 
@@ -88,14 +88,9 @@ static void devinfo_no_cfg_dups(struct kunit *test)
 	for (int i = 0; i < p; i++) {
 		struct iwl_cfg cfg_i = *cfgs[i];
 
-		/* null out the names since we can handle them differently */
-		cfg_i.name = NULL;
-
 		for (int j = 0; j < i; j++) {
 			struct iwl_cfg cfg_j = *cfgs[j];
 
-			cfg_j.name = NULL;
-
 			KUNIT_EXPECT_NE_MSG(test, memcmp(&cfg_i, &cfg_j,
 							 sizeof(cfg_i)), 0,
 					    "identical configs: %ps and %ps\n",
@@ -126,9 +121,8 @@ static void devinfo_check_killer_subdev(struct kunit *test)
 {
 	for (int i = 0; i < iwl_dev_info_table_size; i++) {
 		const struct iwl_dev_info *di = &iwl_dev_info_table[i];
-		const char *name = di->name ?: di->cfg->name;
 
-		if (!strstr(name, "Killer"))
+		if (!strstr(di->name, "Killer"))
 			continue;
 
 		KUNIT_EXPECT_NE(test, di->subdevice, (u16)IWL_CFG_ANY);
-- 
2.34.1


