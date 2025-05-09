Return-Path: <linux-wireless+bounces-22776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78DAB1104
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EA71C25840
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355728FFC9;
	Fri,  9 May 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEBybj4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DF28F51F
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787520; cv=none; b=NULDMeM1H1rs9NPODtVf1VwrfkKzc924yxD7zIGXl+4YeD3QjJYAi8ZadCQmoIyeAiZIjT4DJ/sBAsBZLVZm0POFWCFW8c8Nepc5VNqlTZohLWb1I5NE7AUV1ONVe0JmSnxsVj25OzmtrhkP4BqqK2fs+z/428B5nuyhkM4d62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787520; c=relaxed/simple;
	bh=epj5RczLqBQnX/Kb4NkB434hQSP/Fj+N7Ixamhfb6mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+BcqlBjzDSx22cYyhZJwNplAqGHznq8ZxEWt8RnwHb7fvOOaN/sNRJ0gh61LkQZ03aNJYsuYOFUmif+347ftbg9orYiwvsFk3kYTPc0SccupIYaVFa0l1bqQKd4scw7MUiEUMVBu/G1f1B2QGUfybka8opaYQghUJoA027mORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEBybj4W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787519; x=1778323519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epj5RczLqBQnX/Kb4NkB434hQSP/Fj+N7Ixamhfb6mo=;
  b=jEBybj4WlgmRhRBrUWcRj1mcbaTKinTp6y4D/t0PK7yI9dCsiCWl2rqF
   nd3vnJSlngHJ4UsAVM8N1Md+gz1I9TG+yZcHF3JUPc4KR9kX9j7/1DZKZ
   k2S/e5DvIgQnDw8iztBzDdpJkQWY9BxnHr4Py8ekBZ/tPpYffZE+XS3KA
   5kNVwg+soGqP+HDtJqa2/ahsF33rC2juyFib5m3vy6p6z6vDdP06WEMiE
   KUToWIQZEE86ZwyXd4cAafvC1HcFJge9ocx0Y90ZitaevsLfTcPA1q48/
   A/HfC7xlwxTY9b5PcQnaJuDvhXfNliqaSDLI38ajBJytL6sZY2huWLmYr
   w==;
X-CSE-ConnectionGUID: uQwHl5R3Q8+UF4niB6FghA==
X-CSE-MsgGUID: cBF5ju5rQ3CQ1t7mFcDd+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239893"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:16 -0700
X-CSE-ConnectionGUID: xm7V7gu/S7qsES7LJOevvQ==
X-CSE-MsgGUID: 2tZhpctSQzacHJlcNPDHlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537030"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: cfg: add FM RF config
Date: Fri,  9 May 2025 13:44:45 +0300
Message-Id: <20250509104454.2582160-7-miriam.rachel.korenblit@intel.com>
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

The Bz configs really should be FM for the RF, so
move that around.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.7ab8b86a1f5f.I6608adf28ba601dee75194c405384754ce229e81@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |  1 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 29 ----------------
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    | 33 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 20 +++++------
 5 files changed, 46 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 2d4815053821..0d7daa6d3ebd 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -23,6 +23,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
 iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o cfg/rf-gf.o
+iwlwifi-$(CONFIG_IWLMLD) += cfg/rf-fm.o
 
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index dc1b4930c24a..8b07289f4921 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -15,9 +15,6 @@
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	93
 
-/* NVM versions */
-#define IWL_BZ_NVM_VERSION		0x0a1d
-
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
 #define IWL_BZ_SMEM_LEN			0xD0000
@@ -93,19 +90,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.ucode_api_min = IWL_BZ_UCODE_API_MIN,
 };
 
-#define IWL_DEVICE_BZ							\
-	.ht_params = {							\
-		.stbc = true,						\
-		.ldpc = true,						\
-		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
-			      BIT(NL80211_BAND_5GHZ),			\
-	},								\
-	.led_mode = IWL_LED_RF_STATE,					\
-	.non_shared_ant = ANT_B,					\
-	.vht_mu_mimo_supported = true,					\
-	.nvm_ver = IWL_BZ_NVM_VERSION,					\
-	.nvm_type = IWL_NVM_EXT
-
 const struct iwl_mac_cfg iwl_bz_mac_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_BZ,
 	.base = &iwl_bz_base,
@@ -133,19 +117,6 @@ const char iwl_wh_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
 const char iwl_gl_name[] = "Intel(R) Wi-Fi 7 BE200 320MHz";
 const char iwl_mtp_name[] = "Intel(R) Wi-Fi 7 BE202 160MHz";
 
-const struct iwl_cfg iwl_cfg_bz = {
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.num_rbds = IWL_NUM_RBDS_EHT,
-};
-
-const struct iwl_cfg iwl_cfg_bz_160mhz = {
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.num_rbds = IWL_NUM_RBDS_EHT,
-	.bw_limit = 160,
-};
-
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
new file mode 100644
index 000000000000..670360af3d6e
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2025 Intel Corporation
+ */
+#include "iwl-config.h"
+
+/* NVM versions */
+#define IWL_FM_NVM_VERSION		0x0a1d
+
+#define IWL_DEVICE_FM							\
+	.ht_params = {							\
+		.stbc = true,						\
+		.ldpc = true,						\
+		.ht40_bands = BIT(NL80211_BAND_2GHZ) |			\
+			      BIT(NL80211_BAND_5GHZ),			\
+	},								\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.non_shared_ant = ANT_B,					\
+	.vht_mu_mimo_supported = true,					\
+	.uhb_supported = true,						\
+	.num_rbds = IWL_NUM_RBDS_EHT,					\
+	.nvm_ver = IWL_FM_NVM_VERSION,					\
+	.nvm_type = IWL_NVM_EXT
+
+const struct iwl_cfg iwl_rf_fm = {
+	IWL_DEVICE_FM,
+};
+
+const struct iwl_cfg iwl_rf_fm_160mhz = {
+	IWL_DEVICE_FM,
+	.bw_limit = 160,
+};
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index fa12e5259bf9..541cd5427d6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -694,8 +694,8 @@ extern const struct iwl_cfg iwl_rf_gf;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
-extern const struct iwl_cfg iwl_cfg_bz;
-extern const struct iwl_cfg iwl_cfg_bz_160mhz;
+extern const struct iwl_cfg iwl_rf_fm;
+extern const struct iwl_cfg iwl_rf_fm_160mhz;
 
 extern const struct iwl_cfg iwl_cfg_sc;
 extern const struct iwl_cfg iwl_cfg_sc_160mhz;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index bf2d8db8cfc4..1aa3508ed2ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1451,26 +1451,26 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
 /* Bz */
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_ax201_name, MAC_TYPE(BZ), RF_TYPE(HR2)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ), RF_TYPE(HR2)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_ax211_name, MAC_TYPE(BZ), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ), RF_TYPE(GF)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_fm_name, MAC_TYPE(BZ), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ), RF_TYPE(FM)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_wh_name, MAC_TYPE(BZ), RF_TYPE(WH)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ), RF_TYPE(WH)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_ax201_name, MAC_TYPE(BZ_W), RF_TYPE(HR2)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_ax201_name, MAC_TYPE(BZ_W), RF_TYPE(HR2)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_ax211_name, MAC_TYPE(BZ_W), RF_TYPE(GF)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_ax211_name, MAC_TYPE(BZ_W), RF_TYPE(GF)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_fm_name, MAC_TYPE(BZ_W), RF_TYPE(FM)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_fm_name, MAC_TYPE(BZ_W), RF_TYPE(FM)),
 
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_wh_name, MAC_TYPE(BZ_W), RF_TYPE(WH)),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_wh_name, MAC_TYPE(BZ_W), RF_TYPE(WH)),
 
 /* Ga (Gl) */
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
+	IWL_DEV_INFO(iwl_rf_fm, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_bz_160mhz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
+	IWL_DEV_INFO(iwl_rf_fm_160mhz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_LIMITED, NO_CDB),
 
 /* Sc */
-- 
2.34.1


