Return-Path: <linux-wireless+bounces-22824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5327AB250E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03C7A0165F
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766A284B5E;
	Sat, 10 May 2025 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWCsGhEu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA528640C
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902938; cv=none; b=mub/rtUlXDpl0pQYA84QI/w0nuP1wngLNsV8P/sYpBolbH6DxA7kQlzFMF1BvdFqngv7DxXMaZ+57Xm41d2h9CzdCJyBCTLh3EqX7ryO166u4KFVuw7YXrxXLo5BtsAPpAoircU5Robm4xhDp4U67n3k0AwknYbbGpDM0dc1AnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902938; c=relaxed/simple;
	bh=J1NrvAMaGCuwzlv76gwDvLHN6A6klDc5pfNUQWSBH9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awTM5jgJl8in68hvf11FbnHFAyA8uVK6g1vHJ96wmpSz2BuOcA06EnSI2kK5LpvKc+33GC4VPEVeAewSXLZ5XuO3PUAV7FCFPQaEGkWIKEpm5rg1iPid41XD439Hhyo8Jae1kEyH/W9G/nASuHMxHBULemMlY4DdIkZlpNpV0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWCsGhEu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902937; x=1778438937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1NrvAMaGCuwzlv76gwDvLHN6A6klDc5pfNUQWSBH9I=;
  b=cWCsGhEuI7jfKvoGHhsLdEIbXXhNFtI5ZmjupziG1IHlRU12sywLuYk3
   00J7SyUMiz1D9kki6ew6b+pne20dj9g8CGFwyZp9HEExsBq6EXhgaK2t6
   dzplmmE+gM4iJuEoiT3Cxb2+B49jZIuQ4kaGqocljC7kzUVXrO+eou4HA
   1iL3gTI9BPkVL9m99ajKv4/2FUzGx8psbHIOHBjv201TcitCdzY46ACfF
   t0Cn6aeYcmnQ36ljpyNcI9WDekjgbZviCve4z8ES8dAczFG3wDOoekiui
   ANgPuQzerWskFqqHUC14QgylWv027d2GdHeVbuZ5l8nZsjq19rcELuGA8
   g==;
X-CSE-ConnectionGUID: EaEfct3RSeGHZ4OSAREiaA==
X-CSE-MsgGUID: j09f4+IFRZCUi74d2pnsMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880891"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880891"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:56 -0700
X-CSE-ConnectionGUID: f2mhl8PIROSSxLovQXtx+Q==
X-CSE-MsgGUID: glzjwZIkQzCGkl5+yD04Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033446"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: cfg: clean up GF device matching
Date: Sat, 10 May 2025 21:48:23 +0300
Message-Id: <20250510214621.8888f6798581.If332ebfc3b3f4a335a79ccee13e90f93b1ee4df7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Again some names don't actually exist, and we only need a
few entries to cover Ty (discrete) and AX211/AX411.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 17 ----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  4 -
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    | 17 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 80 ++-----------------
 4 files changed, 22 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 2002b14bb82d..15309e6815c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -134,24 +134,7 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.umac_prph_offset = 0x300000
 };
 
-const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
-const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
-
-const char iwl_ax210_killer_1675w_name[] =
-	"Killer(R) Wi-Fi 6E AX1675w 160MHz Wireless Network Adapter (210D2W)";
-const char iwl_ax210_killer_1675x_name[] =
-	"Killer(R) Wi-Fi 6E AX1675x 160MHz Wireless Network Adapter (210NGW)";
-const char iwl_ax211_killer_1675s_name[] =
-	"Killer(R) Wi-Fi 6E AX1675s 160MHz Wireless Network Adapter (211NGW)";
-const char iwl_ax211_killer_1675i_name[] =
-	"Killer(R) Wi-Fi 6E AX1675i 160MHz Wireless Network Adapter (211NGW)";
-const char iwl_ax411_killer_1690s_name[] =
-	"Killer(R) Wi-Fi 6E AX1690s 160MHz Wireless Network Adapter (411D2W)";
-const char iwl_ax411_killer_1690i_name[] =
-	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
-
-const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
 
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 6184d7ca55f9..424f92b34510 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -31,10 +31,6 @@
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 
-#if !IS_ENABLED(CONFIG_IWLMVM)
-const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
-#endif
-
 static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
index a90dba322094..f55c286e83be 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
@@ -23,3 +23,20 @@ const struct iwl_rf_cfg iwl_rf_gf = {
 	.nvm_type = IWL_NVM_EXT,
 	.num_rbds = IWL_NUM_RBDS_HE,
 };
+
+const char iwl_ax210_killer_1675w_name[] =
+	"Killer(R) Wi-Fi 6E AX1675w 160MHz Wireless Network Adapter (210D2W)";
+const char iwl_ax210_killer_1675x_name[] =
+	"Killer(R) Wi-Fi 6E AX1675x 160MHz Wireless Network Adapter (210NGW)";
+const char iwl_ax211_killer_1675s_name[] =
+	"Killer(R) Wi-Fi 6E AX1675s 160MHz Wireless Network Adapter (211D2W)";
+const char iwl_ax211_killer_1675i_name[] =
+	"Killer(R) Wi-Fi 6E AX1675i 160MHz Wireless Network Adapter (211NGW)";
+const char iwl_ax411_killer_1690s_name[] =
+	"Killer(R) Wi-Fi 6E AX1690s 160MHz Wireless Network Adapter (411D2W)";
+const char iwl_ax411_killer_1690i_name[] =
+	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
+
+const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6E AX210 160MHz";
+const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
+const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d9df88d10324..7e6edf6f2040 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -969,6 +969,11 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, RF_TYPE(HR2), BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_name, DEVICE(0x2723)),
 
+/* GF RF */
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, RF_TYPE(GF), CDB),
+	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name, DEVICE(0x2725)),
+
 /* Killer CRFs */
 	IWL_DEV_INFO(iwl_rf_jf, iwl9260_killer_1550_name, SUBDEV(0x1550)),
 	IWL_DEV_INFO(iwl_rf_jf, iwl9560_killer_1550s_name, SUBDEV(0x1551)),
@@ -989,74 +994,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2723), SUBDEV(0x1653)),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_killer_1650x_name,
 		     DEVICE(0x2723), SUBDEV(0x1654)),
-
-/* JF RF */
-	/* So with HR */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x2725), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x0020)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x2020)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x0024)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0xE020)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0xE024)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x4020)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x6020)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax210_name,
-		     DEVICE(0x2725), SUBDEV(0x6024)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7A70), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7A70), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name,
-		     DEVICE(0x7A70), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7A70), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7A70), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7A70), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7AF0), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7AF0), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name,
-		     DEVICE(0x7AF0), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7AF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7AF0), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
-		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
-
-
-/* Ma */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
-
-/* So-F with Gf */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SOF),
-		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SOF),
-		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
-
-/* So with GF */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SO),
-		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SO),
-		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
-
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
@@ -1073,14 +1010,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x272B), SUBDEV(0x1774)),
 
 /* Bz */
-	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ), RF_TYPE(GF)),
-
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ), RF_TYPE(FM)),
 
 	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ), RF_TYPE(WH)),
 
-	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ_W), RF_TYPE(GF)),
-
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ_W), RF_TYPE(FM)),
 
 	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ_W), RF_TYPE(WH)),
@@ -1092,21 +1025,18 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     BW_LIMITED, NO_CDB),
 
 /* Sc */
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NOT_LIMITED),
-- 
2.34.1


