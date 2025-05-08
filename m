Return-Path: <linux-wireless+bounces-22742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0647AAF976
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ECB4A71BE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DDA35966;
	Thu,  8 May 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQq6CCEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AB1C5F39
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706409; cv=none; b=d5PLdrXFLuY744/42iN4SM8vIUzkGZ/c1+U90GqcLLg5gKLDIQnnNXwFZM9xl0zC0tRN4j9lFO9o5GI5GqrBKG3FquVT6WuRXRgMCyVdJfB4MtEkCZUqtS/0XRsskWKIb85kxhEjVSuPuPNkDJtsJL5UvZEIQczy1nFnM8t/qI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706409; c=relaxed/simple;
	bh=wqka3Udy5F4MIvYdZmK/5y3DWD9xrU3KgS1f2uIY/oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC5t5Z19huGZSIHBMQL1r/ljG0h7WqHpOz2yHnBgfuEHErz3pR6/GxjTz6Ekn4wI5kFten6uq6+WgMXInCFwCes3KnnZhas0bpjrXRTB3SBGwNwxkcTzCUP2hUKqXYlReEPNkX5LPISHA5XqTAKIQM63Id/okgwTPtqYuw/hnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQq6CCEH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706408; x=1778242408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqka3Udy5F4MIvYdZmK/5y3DWD9xrU3KgS1f2uIY/oo=;
  b=mQq6CCEHHzZyP7YWsmmXL8GNpcue5OWbx22jshjPu6J+rL4K1vI47697
   n10b4BE7xjSSLC5xb2emT4CEfsLTrhUxep9k42bRTOvV+lExd8sNGjSrv
   fAcAPIsy6SEjS65J9Nkx2CV8adoLw1kXnUqsRPCbM0zDiYvS+vN4hXebS
   zC2uVZDE2y/jZuBG0vGW7upRM35lNECOrD0UoA/huPwOAZkshO46WzthU
   CSCtRoklzkwoWGUr0sh+J6kZYayOt0EPpiofK0Q69LI5i+sstTxNAp/5O
   lfeKC/F36oYjOi088Rgq5Xknt4TXKqoUPYZDOTMn0WqQvJdJAvGeqS+6v
   w==;
X-CSE-ConnectionGUID: WFPNS+6kQqiveamf/F1/7Q==
X-CSE-MsgGUID: oJp3LS0oR4yZwpDv3GM26Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688036"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:27 -0700
X-CSE-ConnectionGUID: oSAFu0wQRzal04ZWYxmVFg==
X-CSE-MsgGUID: C88/NXveS3WUBv6XstezcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347802"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: cfg: build ax210 family FW names dynamically
Date: Thu,  8 May 2025 15:12:55 +0300
Message-Id: <20250508121306.1277801-5-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add support for the TY MAC (discrete device) and GF4 RF to
the list of MAC/RF types, and use that to remove fw_name_pre
for the ax210 family devices.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.462c260255e2.I349691d46944c7a6e4313df1df3cf5bc37bdc603@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  25 -----
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   6 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 102 +++++++++---------
 4 files changed, 58 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index e7bba29fe755..21b1e257f751 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -196,41 +196,18 @@ const char iwl_ax411_killer_1690i_name[] =
 	"Killer(R) Wi-Fi 6E AX1690i 160MHz Wireless Network Adapter (411NGW)";
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
-	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz = {
-	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 	.bw_limit = 80,
 };
 
-const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
-	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const char iwl_ax210_name[] = "Intel(R) Wi-Fi 6 AX210 160MHz";
 
-const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
-	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
-const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
-	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwl_cfg_ma = {
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
@@ -238,13 +215,11 @@ const struct iwl_cfg iwl_cfg_ma = {
 };
 
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
-	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz = {
-	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 	.bw_limit = 80,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f978449af106..0977a683459a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -412,6 +412,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_SO		0x37
+#define IWL_CFG_MAC_TYPE_TY		0x42
 #define IWL_CFG_MAC_TYPE_SOF		0x43
 #define IWL_CFG_MAC_TYPE_MA		0x44
 #define IWL_CFG_MAC_TYPE_BZ		0x46
@@ -673,9 +674,6 @@ extern const struct iwl_cfg iwl_qu_hr_80mhz;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz;
-extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
-extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
-extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 
 extern const struct iwl_cfg iwl_cfg_ma;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index acfc3eb89afe..eb57981e4c8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -209,6 +209,11 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 	case IWL_CFG_MAC_TYPE_SO:
 	case IWL_CFG_MAC_TYPE_SOF:
 		mac = "so";
+		mac_step = 'a';
+		break;
+	case IWL_CFG_MAC_TYPE_TY:
+		mac = "ty";
+		mac_step = 'a';
 		break;
 	case IWL_CFG_MAC_TYPE_MA:
 		mac = "ma";
@@ -254,6 +259,7 @@ const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 		break;
 	case IWL_CFG_RF_TYPE_GF:
 		rf = "gf";
+		rf_step = 'a';
 		break;
 	case IWL_CFG_RF_TYPE_FM:
 		rf = "fm";
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 934671d3d454..bffe3bb3e3f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -970,23 +970,23 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x51F0), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9560_killer_1550i_160_name,
 		     DEVICE(0x51F0), SUBDEV(0x1551)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x51F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x51F1), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x54F0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7A70), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7A70), SUBDEV(0x1692)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1691)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1692)),
 
 	IWL_DEV_INFO(iwl9000_2ac_cfg, iwl9260_1_name,
@@ -1139,57 +1139,57 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x4DF0), SUBDEV(0x6074)),
 
 	/* So with HR */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x2725), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x2020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0024)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0xE024)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x4020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6020)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_name,
 		     DEVICE(0x2725), SUBDEV(0x6024)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675w_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_killer_1675w_name,
 		     DEVICE(0x2725), SUBDEV(0x1673)),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675x_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax210_killer_1675x_name,
 		     DEVICE(0x2725), SUBDEV(0x1674)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name,
 		     DEVICE(0x7A70), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7A70), SUBDEV(0x0A10)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0090)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0098)),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name,
 		     DEVICE(0x7AF0), SUBDEV(0x00B0)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0310)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0510)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name,
 		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
@@ -1203,29 +1203,29 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x51F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x51F1), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x51F1), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x54F0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x54F0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7A70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7A70), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7AF0), SUBDEV(0x1672)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
 		     DEVICE(0x7F70), SUBDEV(0x1671)),
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
 		     DEVICE(0x7F70), SUBDEV(0x1672)),
 
 	/* MA with GF2 */
@@ -1405,9 +1405,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR2), BW_NOT_LIMITED, NO_CDB),
 
 /* So-F with Gf */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name, MAC_TYPE(SOF),
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name, MAC_TYPE(SOF),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* SoF with JF2 */
@@ -1427,9 +1427,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with GF */
-	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, NO_CDB),
-	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name, MAC_TYPE(SO),
+	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_name, MAC_TYPE(SO),
 		     RF_TYPE(GF), BW_NOT_LIMITED, CDB),
 
 /* So with JF2 */
-- 
2.34.1


