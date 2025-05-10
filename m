Return-Path: <linux-wireless+bounces-22823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1473AB250D
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5D7AAE70
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02767283122;
	Sat, 10 May 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQ9BkgJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10C284B5E
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902936; cv=none; b=eGoI29RhbW6NjVxeYNvh10glttGO9GzxorF/wCOMg8k+Joz4Qf0iUQkLh/lkMxVSHhQ/3aqRq5HX/BMRdlrJuzBpA4W7LAz306J4bKJSQFPaYCInaf7D8NU/6J55QratqJzRM0cpFGoa22UcndNJtv38vJpuvD79HcyE6OqFwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902936; c=relaxed/simple;
	bh=DFlgVA0nyYoM59vUvMqsxBu7zT+7oxcmbDCmVvQaaGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0VbrdDG65kt4uX85L28kJZIQqJx3VV0jovJ4WnItI28OeWYjN0Yn6zHkEENwHkYReSq/y5yMxfIxMcsyBrN5bUhc69GEpb8QwMNZWwUCfmdS31w1A7r9mw4MZ3aRsL3c1hLltRh+h3lnE1C/fHstbbMBASwN0ecB5fM6A0Mk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQ9BkgJi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902935; x=1778438935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFlgVA0nyYoM59vUvMqsxBu7zT+7oxcmbDCmVvQaaGg=;
  b=hQ9BkgJiHBg+KLCq2GW/y30Bqsmz4vO0/kt0O50mrPQz8EK2Xv4POrdi
   QBdm1IGFubcbpb/uIcqEzt9Fr3fVCcenFfPn9bMfiqbHP12AU8HRAg8n0
   rKLe47ufGtB+lVkLXDRyQyJRqcyD/QaXV6qqRjOI+7K3DRN19G39vKD+U
   qB4BqS/ZLMz9NeOOokPJIIUjORK6kNTDZYQNoB5MxseK9EaQcVz8SdaLV
   U1OJ11/VJd2mr/TOWO5aIh9kKQ0h0JZbgFtaR1pTTZhY7wGctNvJUwmwG
   3qjvCoBwK3fg/BTe1zfCOSg+8mJ1I9uSx6UHoegZx2FQqbe0OVfb+5qe+
   g==;
X-CSE-ConnectionGUID: gJAvm/9ATESCYHr4cXgohA==
X-CSE-MsgGUID: KBCSchfMTKW7wV0wOIgxyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880890"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880890"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:55 -0700
X-CSE-ConnectionGUID: /ozSqGQzQNC10ZO6kQJJhA==
X-CSE-MsgGUID: Yuzri8vgSjaXNtCgkum5Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033443"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: cfg: clean up JF device matching
Date: Sat, 10 May 2025 21:48:22 +0300
Message-Id: <20250510214621.bca83604aa92.I35301d2d8b57c072284fff7bf6682b4a9424e56c@changeid>
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

This really only needs to be distinguished based on the
RF type, bandwidth limit and possibly diversity (JF1).
Some of the names that are defined don't even exist.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  21 ---
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  16 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 164 ++----------------
 3 files changed, 35 insertions(+), 166 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 816cf72e32e7..ac1fa291cf2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -100,26 +100,5 @@ const struct iwl_mac_cfg iwl9560_shared_clk_mac_cfg = {
 	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
 };
 
-const char iwl9162_name[] = "Intel(R) Wireless-AC 9162";
-const char iwl9260_name[] = "Intel(R) Wireless-AC 9260";
-const char iwl9260_1_name[] = "Intel(R) Wireless-AC 9260-1";
-const char iwl9270_name[] = "Intel(R) Wireless-AC 9270";
-const char iwl9461_name[] = "Intel(R) Wireless-AC 9461";
-const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
-const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
-const char iwl9162_160_name[] = "Intel(R) Wireless-AC 9162 160MHz";
-const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
-const char iwl9270_160_name[] = "Intel(R) Wireless-AC 9270 160MHz";
-const char iwl9461_160_name[] = "Intel(R) Wireless-AC 9461 160MHz";
-const char iwl9462_160_name[] = "Intel(R) Wireless-AC 9462 160MHz";
-const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
-
-const char iwl9260_killer_1550_name[] =
-	"Killer(R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
-const char iwl9560_killer_1550i_name[] =
-	"Killer(R) Wireless-AC 1550i Wireless Network Adapter (9560NGW) 160MHz";
-const char iwl9560_killer_1550s_name[] =
-	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
-
 MODULE_FIRMWARE(IWL9000_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL9260_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
index 60f5fcfb1f46..467eaeae6deb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
@@ -66,3 +66,19 @@ const struct iwl_rf_cfg iwl_rf_jf_80mhz = {
 	IWL_DEVICE_JF,
 	.bw_limit = 80,
 };
+
+const char iwl9260_name[] = "Intel(R) Wireless-AC 9260";
+const char iwl9461_name[] = "Intel(R) Wireless-AC 9461";
+const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
+const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
+const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
+const char iwl9461_160_name[] = "Intel(R) Wireless-AC 9461 160MHz";
+const char iwl9462_160_name[] = "Intel(R) Wireless-AC 9462 160MHz";
+const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
+
+const char iwl9260_killer_1550_name[] =
+	"Killer(R) Wireless-AC 1550 Wireless Network Adapter (9260NGW) 160MHz";
+const char iwl9560_killer_1550i_name[] =
+	"Killer(R) Wireless-AC 1550i Wireless Network Adapter (9560NGW) 160MHz";
+const char iwl9560_killer_1550s_name[] =
+	"Killer(R) Wireless-AC 1550s Wireless Network Adapter (9560D2W) 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 415523acfa40..d9df88d10324 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -944,6 +944,25 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
 
+/* JF1 RF */
+	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
+		     RF_TYPE(JF1)),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name,
+		     RF_TYPE(JF1), BW_LIMITED),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name,
+		     RF_TYPE(JF1), RF_ID(JF1_DIV)),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name,
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED),
+/* JF2 RF */
+	IWL_DEV_INFO(iwl_rf_jf, iwl9260_160_name,
+		     RF_TYPE(JF2)),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9260_name,
+		     RF_TYPE(JF2), BW_LIMITED),
+	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name,
+		     RF_TYPE(JF2), RF_ID(JF)),
+	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name,
+		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED),
+
 /* HR RF */
 	IWL_DEV_INFO(iwl_rf_hr, iwl_ax201_name, RF_TYPE(HR2)),
 	IWL_DEV_INFO(iwl_rf_hr_80mhz, iwl_ax101_name, RF_TYPE(HR1)),
@@ -972,9 +991,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2723), SUBDEV(0x1654)),
 
 /* JF RF */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9260_1_name,
-		     DEVICE(0x271C), SUBDEV(0x0214)),
-
 	/* So with HR */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x2725), SUBDEV(0x0090)),
@@ -1025,116 +1041,6 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
-	/* MA with GF2 */
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(PU),
-		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(PU),
-		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(PU),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(PU),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(PU),
-		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(PU),
-		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9270_160_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_NOT_LIMITED, CORES(BT_GNSS), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9270_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_LIMITED, CORES(BT_GNSS), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9162_160_name, DEVICE(0x271B),
-		     MAC_TYPE(TH), RF_TYPE(JF1),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9162_name, DEVICE(0x271B),
-		     MAC_TYPE(TH), RF_TYPE(JF1),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9260_160_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9260_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-/* Qu with Jf */
-	/* Qu B step */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
-		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name,
-		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name,
-		     MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name,
-		     MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name,
-		     MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name,
-		     MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	/* Qu C step */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
-		     MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name,
-		     MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name,
-		     MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name,
-		     MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(QU),
-		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(QU),
-		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT),
-		     NO_CDB),
-
-	/* QuZ */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
-
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
-
-/* Qu with Hr */
-	/* Qu B step */
 
 /* Ma */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(MA), RF_TYPE(GF)),
@@ -1145,44 +1051,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
-/* SoF with JF2 */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
-
-/* SoF with JF */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
-
 /* So with GF */
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax211_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_rf_gf, iwl_ax411_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
-/* So with JF2 */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9560_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9560_name, MAC_TYPE(SO),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
-
-/* So with JF */
-	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf, iwl9462_160_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9461_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl_rf_jf_80mhz, iwl9462_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
-
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
 	IWL_DEV_INFO(iwl_rf_fm, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
-- 
2.34.1


