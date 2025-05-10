Return-Path: <linux-wireless+bounces-22825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD7AB250F
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10107189D5E7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764272836A6;
	Sat, 10 May 2025 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCaerVCq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EF286411
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902939; cv=none; b=YeC9oknGwVpHN0lgau71ys44kjt9Wu8kXLatyLEbZBIGgmrPouAwTNjbT+uII5CtWenl+E5c5ft+f8vAkYCZgTbA7dgj/9oWtPxbJbsA6rWA8Vp0Spc/RubwnRvNBTzMflMva9b6wSCwVGPxZoPxK38+n6UgEYeFzblsLIQ+EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902939; c=relaxed/simple;
	bh=A6RDfj8xO/TkS60e00IH6cweoy9ejm/Oym1Osmidu/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg20AMpuFr1b/K23S/dGGS0nMfSrJCSNZLj8BckFzjdaQT5K4cehEgz/J7svAkB3TN+0Of9eWVBCx4bZTqoE+btELAkKx0IAabksdPmJXl1r0Hq9TsFjvtcSurICTXxLAo8gMMeKlsJI7raJqUKrtnN2CTfGRJGzVR1WBdhb5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCaerVCq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902938; x=1778438938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6RDfj8xO/TkS60e00IH6cweoy9ejm/Oym1Osmidu/c=;
  b=NCaerVCqA4+nhQlmS3yQvhjZ7Mjd0lLzwppgMmg6z3coe3iGYvcL5g1q
   psXGJ/18dF098wpZTH8hxO6eF66g4YthxnsAOwsZiHAv1X61342zyQhKm
   Gzmv+cLtPkSdgMIxSLQpo20B/JsCkreErmlPQOZPExIW6AcZMKN4yH4tB
   0qI3pFAkEmlyFWmPVwKsBDvSNq4R7A0XXdVEexUak44gcf1crxaeAGiSu
   oU2HxrYY2LtaIHxd2aWyVr4lCyT5Utdp/JWPTDZ21gRT7pUgQjGzWW+a6
   pnaGOmhH+qw5/Is40nO2/gOU52PFOnOgkRSE65TLP0F3n3mog0gLMzeJt
   A==;
X-CSE-ConnectionGUID: lKE4jlSRQNS+zslImgvP0g==
X-CSE-MsgGUID: UBc5/mHFTSCvabiBBDT79Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880892"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880892"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:58 -0700
X-CSE-ConnectionGUID: NM3ypUkeTQmms4oHFOHAtA==
X-CSE-MsgGUID: 85WHBnTeRcy7kdEgC8OQ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033449"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: cfg: fix and clean up FM/WH device matching
Date: Sat, 10 May 2025 21:48:24 +0300
Message-Id: <20250510214621.ba2964bee671.If7aaaf10b236115e39b17d37296341de6c821069@changeid>
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

We only need a few entries, and there don't seem to be any
such devices actually limited to 160 MHz.

Also add PCI IDs for the new Killer device on LNL platforms.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  2 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  5 --
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  9 ++++
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    | 15 ++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  1 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 23 +++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 49 +++++++------------
 8 files changed, 56 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 0d7daa6d3ebd..89e7df5bf6ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -23,7 +23,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
 iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o cfg/rf-gf.o
-iwlwifi-$(CONFIG_IWLMLD) += cfg/rf-fm.o
+iwlwifi-$(CONFIG_IWLMLD) += cfg/rf-fm.o cfg/rf-wh.o
 
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 15309e6815c7..18d0de13f564 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -134,8 +134,6 @@ const struct iwl_mac_cfg iwl_ma_mac_cfg = {
 	.umac_prph_offset = 0x300000
 };
 
-const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
-
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 424f92b34510..05e45fff8b36 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -107,11 +107,6 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
 	.low_latency_xtal = true,
 };
 
-const char iwl_fm_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
-const char iwl_wh_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
-const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
-const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
-
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
index 2d0cad9c5f2c..456a666c8dfd 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -40,3 +40,12 @@ const char iwl_killer_be1750w_name[] =
 	"Killer(TM) Wi-Fi 7 BE1750w 320MHz Wireless Network Adapter (BE200D2W)";
 const char iwl_killer_be1750x_name[] =
 	"Killer(TM) Wi-Fi 7 BE1750x 320MHz Wireless Network Adapter (BE200NGW)";
+const char iwl_killer_be1790s_name[] =
+	"Killer(R) Wi-Fi 7 BE1790s 320MHz Wireless Network Adapter (BE401D2W)";
+const char iwl_killer_be1790i_name[] =
+	"Killer(R) Wi-Fi 7 BE1790i 320MHz Wireless Network Adapter (BE401NGW)";
+
+const char iwl_be201_name[] = "Intel(R) Wi-Fi 7 BE201 320MHz";
+const char iwl_be200_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
+const char iwl_be202_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
+const char iwl_be401_name[] = "Intel(R) Wi-Fi 7 BE401 320MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
new file mode 100644
index 000000000000..97735175cb0e
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* currently iwl_rf_wh/iwl_rf_wh_160mhz are just defines for the FM ones */
+
+const char iwl_killer_be1775s_name[] =
+	"Killer(R) Wi-Fi 7 BE1775s 320MHz Wireless Network Adapter (BE211D2W)";
+const char iwl_killer_be1775i_name[] =
+	"Killer(R) Wi-Fi 7 BE1775i 320MHz Wireless Network Adapter (BE211NGW)";
+
+const char iwl_be211_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
+const char iwl_be213_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 5ccb8fff01f4..3078e7d0c1fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -105,7 +105,6 @@ const struct iwl_mac_cfg iwl_sc_mac_cfg = {
 	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
-const char iwl_sp_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
 const char iwl_pe_name[] = "Intel(R) Wi-Fi 8 BN201";
 
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 69cbe138bad2..7bf18658763e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -632,20 +632,24 @@ extern const char iwl_ax411_killer_1690s_name[];
 extern const char iwl_ax411_killer_1690i_name[];
 extern const char iwl_ax210_name[];
 extern const char iwl_ax211_name[];
-extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
-extern const char iwl_fm_name[];
-extern const char iwl_wh_name[];
-extern const char iwl_sp_name[];
-extern const char iwl_pe_name[];
-extern const char iwl_gl_name[];
-extern const char iwl_mtp_name[];
-extern const char iwl_dr_name[];
-extern const char iwl_br_name[];
 extern const char iwl_killer_be1750s_name[];
 extern const char iwl_killer_be1750i_name[];
 extern const char iwl_killer_be1750w_name[];
 extern const char iwl_killer_be1750x_name[];
+extern const char iwl_killer_be1790s_name[];
+extern const char iwl_killer_be1790i_name[];
+extern const char iwl_be201_name[];
+extern const char iwl_be200_name[];
+extern const char iwl_be202_name[];
+extern const char iwl_be401_name[];
+extern const char iwl_be213_name[];
+extern const char iwl_killer_be1775s_name[];
+extern const char iwl_killer_be1775i_name[];
+extern const char iwl_be211_name[];
+extern const char iwl_pe_name[];
+extern const char iwl_dr_name[];
+extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_rf_cfg iwl5300_agn_cfg;
 extern const struct iwl_rf_cfg iwl5350_agn_cfg;
@@ -702,7 +706,6 @@ extern const struct iwl_rf_cfg iwl_rf_fm_160mhz;
 #define iwl_rf_wh iwl_rf_fm
 #define iwl_rf_wh_160mhz iwl_rf_fm_160mhz
 #define iwl_rf_pe iwl_rf_fm
-#define iwl_rf_pe_160mhz iwl_rf_fm_160mhz
 #endif /* CONFIG_IWLMLD */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7e6edf6f2040..f52c3c19beb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -531,6 +531,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA840, 0x40E0, iwl_bz_mac_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x4110, iwl_bz_mac_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1775, iwl_bz_mac_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1776, iwl_bz_mac_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_mac_cfg)},
 	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_mac_cfg)},
 
@@ -996,12 +998,20 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x2723), SUBDEV(0x1654)),
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
-	IWL_DEV_INFO(iwl_rf_fm, iwl_ax231_name, MAC_TYPE(MA), RF_TYPE(FM),
-		     NO_CDB),
+/* FM RF */
+	IWL_DEV_INFO(iwl_rf_fm, iwl_be201_name, RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_be401_name, RF_TYPE(FM), CDB),
+	/* the discrete NICs got the RF B0, it's only for the name anyway */
+	IWL_DEV_INFO(iwl_rf_fm, iwl_be200_name, RF_TYPE(FM),
+		     DEVICE(0x272B), RF_STEP(B)),
+	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_be202_name,
+		     RF_TYPE(FM), BW_LIMITED),
 
 /* Killer CRFs */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750s_name, SUBDEV(0x1771)),
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750i_name, SUBDEV(0x1772)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790s_name, SUBDEV(0x1791)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1790i_name, SUBDEV(0x1792)),
 
 /* Killer discrete */
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750w_name,
@@ -1009,44 +1019,21 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(iwl_rf_fm, iwl_killer_be1750x_name,
 		     DEVICE(0x272B), SUBDEV(0x1774)),
 
-/* Bz */
-	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ), RF_TYPE(FM)),
+/* WH RF */
+	IWL_DEV_INFO(iwl_rf_wh, iwl_be211_name, RF_TYPE(WH)),
+	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_be213_name, RF_TYPE(WH), BW_LIMITED),
 
-	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ), RF_TYPE(WH)),
-
-	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ_W), RF_TYPE(FM)),
-
-	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ_W), RF_TYPE(WH)),
-
-/* Ga (Gl) */
-	IWL_DEV_INFO(iwl_rf_fm, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
-		     BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
-		     BW_LIMITED, NO_CDB),
+/* Killer */
+	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775s_name, SUBDEV(0x1776)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775i_name, SUBDEV(0x1775)),
 
 /* Sc */
-	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
-		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
-		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
-		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
-		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
-		     BW_NOT_LIMITED),
-	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
-		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
 	IWL_DEV_INFO(iwl_rf_pe, iwl_dr_name, MAC_TYPE(DR), RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_wh, iwl_dr_name, MAC_TYPE(DR), RF_TYPE(WH)),
 
 /* Br */
 	IWL_DEV_INFO(iwl_rf_pe, iwl_br_name, MAC_TYPE(BR), RF_TYPE(PE)),
-- 
2.34.1


