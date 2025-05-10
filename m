Return-Path: <linux-wireless+bounces-22821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2F1AB250B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7181F7A9DEA
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20E280318;
	Sat, 10 May 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gesiohIO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945B28153C
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902934; cv=none; b=BPHJplQVvzB/MFVB/BlQRsXzZQVByM/O81/CuikQJBrPCGs/dYT6j+4MRuwjeqmb1MgLLmAsczZ/HVXeTpOFDxS0rtgKkVXj5TXJy2piveu5b6+zhf1jJcMARfKwd5Gbdf7wcgc/kM1M6DXz3yNJRO5FTdr7pIyoGlf5vmv0w/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902934; c=relaxed/simple;
	bh=BlLvrRzXBQ7p98QGmA6C36DTqYtYkeo11QDvCKsLOaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xf04A5ZpePM7fUCsLdXTkKAPimThAn/CIPPDlSnmQn3ZWgy+g33TlTlTeZktj06c9liWyoyv2odKZTyjH5FkhrXOBURowvMzjddUNuy1zmMB4Bm8Ljr5qJauDzriD4G2WqyyErjaXnqj23FLiJv5uL7mTPucwv8gFfa72uXZOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gesiohIO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902933; x=1778438933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BlLvrRzXBQ7p98QGmA6C36DTqYtYkeo11QDvCKsLOaY=;
  b=gesiohIOuhN+4kphTPVUi6xAFCXw4jtXz06JtHV6Xfrk9U6hFqc2lRn/
   KXD4p4ad7NkRGc4gbChKU3CLWzmFZCLqH+Z3yD8m25XanWuGmcIDo1ViI
   8C3c8KF/QKVA0UwsMSTejJ5uh3d2CwzI/CE+skBhUKLk4TzAKe95V28Yd
   tSdx/YjJ6yJTR09raNlFugWEpgwH5SJlDRIgIPGc+nc62CybyVQ4+EnXq
   jfKgQjryzvxXMKFNihlsUnnsztMnScuxHVtpegpeGCC7nZo5+sglcW59y
   1ON3ROEEyKDiLJDIa6eIWfpPvUyoGzUCz7avt6T7p+nxA1EHK+pPymiia
   g==;
X-CSE-ConnectionGUID: EZeccbT1RKmXvR9tHWKTQQ==
X-CSE-MsgGUID: 1sWJdF/TTx+iflDPiIn0dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880885"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880885"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:53 -0700
X-CSE-ConnectionGUID: 3pb88RxZT5S2wlgbv5TBfg==
X-CSE-MsgGUID: ncVo/95qTBKlrDUgxGKdow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033433"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: cfg: clean up HR device matching
Date: Sat, 10 May 2025 21:48:20 +0300
Message-Id: <20250510214621.fa0cde465de0.I6a3f9ed9a7341e2c58c69af50a9f126992a745f2@changeid>
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

We only need a few entries on top of the Killer ones.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   5 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   1 -
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |   5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 154 +-----------------
 4 files changed, 8 insertions(+), 157 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 5855cf430798..52e0beebf9ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -123,11 +123,6 @@ const struct iwl_mac_cfg iwl_ax200_mac_cfg = {
 	.bisr_workaround = 1,
 };
 
-const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
-const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
-const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
-const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
-
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
 const char iwl_ax200_killer_1650x_name[] =
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 8b07289f4921..6184d7ca55f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -33,7 +33,6 @@
 
 #if !IS_ENABLED(CONFIG_IWLMVM)
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
-const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 #endif
 
 static const struct iwl_family_base_params iwl_bz_base = {
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
index 7d444ee0a187..db02664e3917 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
@@ -35,3 +35,8 @@ const struct iwl_rf_cfg iwl_rf_hr_80mhz = {
 	IWL_DEVICE_HR,
 	.bw_limit = 80,
 };
+
+const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
+const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
+const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
+const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b41b8aa75739..415523acfa40 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -945,7 +945,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
 
 /* HR RF */
-	/* FIXME - should have some RF match */
+	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, RF_TYPE(HR2)),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, RF_TYPE(HR1)),
+	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, RF_TYPE(HR2), BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax200_name, DEVICE(0x2723)),
 
 /* Killer CRFs */
@@ -973,114 +975,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
 		     DEVICE(0x271C), SUBDEV(0x0214)),
 
-/* AX200 */
-
-	/* Qu with Hr */
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x6074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x6074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x4070)),
-
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x4070)),
-
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0078)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x007C)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x2074)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x4070)),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x6074)),
-
 	/* So with HR */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x2725), SUBDEV(0x0090)),
@@ -1241,48 +1135,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Qu with Hr */
 	/* Qu B step */
-	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QU),
-		     MAC_STEP(B), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-
-	/* Qu C step */
-	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QU),
-		     MAC_STEP(C), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
-
-	/* QuZ */
-	IWL_DEV_INFO(iwl_rf_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
-		     RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(QUZ),
-		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(QUZ),
-		     MAC_STEP(B), RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* Ma */
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(MA), RF_TYPE(HR2),
-		     NO_CDB),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
 
-/* So with Hr */
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SO),
-		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, MAC_TYPE(SO),
-		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(SO),
-		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
-
-/* So-F with Hr */
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax203_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
-
 /* So-F with Gf */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
@@ -1343,16 +1199,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x272B), SUBDEV(0x1774)),
 
 /* Bz */
-	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ), RF_TYPE(HR2)),
-
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ), RF_TYPE(GF)),
 
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ), RF_TYPE(FM)),
 
 	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ), RF_TYPE(WH)),
 
-	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ_W), RF_TYPE(HR2)),
-
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ_W), RF_TYPE(GF)),
 
 	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ_W), RF_TYPE(FM)),
-- 
2.34.1


