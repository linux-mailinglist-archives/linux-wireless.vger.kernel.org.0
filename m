Return-Path: <linux-wireless+bounces-22346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F09AA72B1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A365A3398
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F62550B8;
	Fri,  2 May 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY7F4iQW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49F2522AB
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190614; cv=none; b=D6AoaFv8VV5qsEb0ZtaBckg7hoYlDwY3/XHi5tPcHuHoOASBgY96SZL+uJVpCtTjDKuppp2JqKoGhKIqZ5EJkTVcoZrlwhZOD7jYl9OP+TvGnuh3wzu0lq0KTOwhVGh3jy3AOBgQ3KqF/A4JmzwhU9aUrwdttfW5ITtc5pOv59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190614; c=relaxed/simple;
	bh=oYC58V4NwxfrziKrG0Un5HQw/7LX14s1NfglnZOkhF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iL8nMDlJjY72lzd1LhEQRLE+Fx4bro2Ia226+sZZp2pH83ydN06eBno1L5T4nU0gqII/ZNNCHi7jSy3nThE8LZcPKczbiNW0s3oXBbMwulYgNvB0/hinis5grbByUP6/ckw7SRM3v2Ky49jCGhylp1GzYh0NVikC+FGwOi19mqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cY7F4iQW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190612; x=1777726612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oYC58V4NwxfrziKrG0Un5HQw/7LX14s1NfglnZOkhF8=;
  b=cY7F4iQW1ANYyOLD8Rqhu2U8SKGF3x8cqc3+vyolDnWfZY9XTXeFUEb+
   NUglZ6Vsrx5E85QixmiHS/BLru9GCqu1eJkxZA8aJ2WQCKoXa1GYv8BF3
   Yk3mg1+rK/ozvcXlQYyrf7TCaxoFy9zePjNYSg48SaLZRN8Ngf61mTnab
   VFjl6mtncpTYC9KuoIkqJ6wCDSRsKR3wWEpk60QLFr/e2W9VqVmy7vKKm
   qkfmkfOKXmWsPAr3JC59hKiQT+hHUHHkwsDXEl/khDo3PWma1njY3RtTf
   5hnatbL+lgbLw7IDChV6h8J6sAwTsR/HD+0JmiFQveRrjIMSoBBueVecc
   Q==;
X-CSE-ConnectionGUID: lfoHSpYlRD2IDAQQFzKkrQ==
X-CSE-MsgGUID: 9lDBslz1SHOlPZwNQ50Q3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255540"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:52 -0700
X-CSE-ConnectionGUID: 4phw4NZdSoqParqNsXqqJQ==
X-CSE-MsgGUID: 7hq6BqjmT1+P7vPTGFZkwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554707"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: cfg: clean up BW limit and subdev matching
Date: Fri,  2 May 2025 15:56:20 +0300
Message-Id: <20250502155404.a185eac2736c.I87ee87300c92518a1d3296d3eda9fd4163e9085e@changeid>
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

The BW limit, cores and RF ID are matched in the subdevice ID,
so it doesn't really make sense to have both SUBDEV() match and
a match on any of those three. In particular, for Killer devices
the subdevice ID doesn't even follow the layout, so no matching
should be on those three values at all, only with SUBDEV().

Change the logic around the BW limit to have it more like all
the other things: only a bw_limit match in the dev_info, and
put the actual bandwidth into struct iwl_cfg. This duplicates a
number of those values, but that way the logic is clearer.

Add a test that checks that the three matches mentioned above
are not used in conjunction with SUBDEV(), and check that if
the bw_limit is matched, a BW limit is provided in the config.
Also check that the "Killer" devices have a SUBDEV() match.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  19 +
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  14 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  14 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   8 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   5 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  16 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 450 +++++++++---------
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  35 +-
 10 files changed, 327 insertions(+), 243 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 172ca18d888b..59d0fa2193f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -175,12 +175,25 @@ const struct iwl_cfg iwl9560_qu_jf_cfg = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
+const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz = {
+	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+	.bw_limit = 80,
+};
+
 const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
 	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
+const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg_80mhz = {
+	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+	.bw_limit = 80,
+};
+
 const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -215,6 +228,12 @@ const struct iwl_cfg iwl_qu_hr = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
+const struct iwl_cfg iwl_qu_hr_80mhz = {
+	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
+	.bw_limit = 80,
+};
+
 const struct iwl_cfg iwl_ax200_cfg_cc = {
 	.fw_name_pre = IWL_CC_A_FW_PRE,
 	IWL_DEVICE_22500,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 0130d9a9b78b..16bf25051dbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021, 2023 Intel Corporation
+ * Copyright (C) 2018-2021, 2023, 2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -183,10 +183,22 @@ const struct iwl_cfg iwl9260_2ac_cfg = {
 	IWL_DEVICE_9000,
 };
 
+const struct iwl_cfg iwl9260_2ac_cfg_80mhz = {
+	.fw_name_pre = IWL9260_FW_PRE,
+	IWL_DEVICE_9000,
+	.bw_limit = 80,
+};
+
 const struct iwl_cfg iwl9560_2ac_cfg_soc = {
 	.fw_name_pre = IWL9000_FW_PRE,
 	IWL_DEVICE_9000,
 };
 
+const struct iwl_cfg iwl9560_2ac_cfg_soc_80mhz = {
+	.fw_name_pre = IWL9000_FW_PRE,
+	IWL_DEVICE_9000,
+	.bw_limit = 80,
+};
+
 MODULE_FIRMWARE(IWL9000_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL9260_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 309d59d28c73..40244bdcad6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -203,6 +203,13 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
+const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz = {
+	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+	.bw_limit = 80,
+};
+
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
@@ -259,6 +266,13 @@ const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz = {
+	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+	.bw_limit = 80,
+};
+
 MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_SO_A_GF_A_FW_PRE, IWL_AX210_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index f3f2dc66bfb5..abd4bfd2a812 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -169,6 +169,14 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
+const struct iwl_cfg iwl_cfg_bz_160mhz = {
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
+	.bw_limit = 160,
+};
+
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 IWL_FW_AND_PNVM(IWL_BZ_A_GF_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_BZ_A_GF4_A_FW_PRE, IWL_BZ_UCODE_API_MAX);
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 405c282e019c..800b6ffec4af 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -149,6 +149,11 @@ const struct iwl_cfg iwl_cfg_sc = {
 	IWL_DEVICE_SC,
 };
 
+const struct iwl_cfg iwl_cfg_sc_160mhz = {
+	IWL_DEVICE_SC,
+	.bw_limit = 160,
+};
+
 IWL_FW_AND_PNVM(IWL_SC_A_FM_B_FW_PRE, IWL_SC_UCODE_API_MAX);
 IWL_FW_AND_PNVM(IWL_SC_A_FM_C_FW_PRE, IWL_SC_UCODE_API_MAX);
 MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_SC_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a9d70b58e134..f8044af3b0f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -324,6 +324,7 @@ struct iwl_fw_mon_regs {
  * @non_shared_ant: the antenna that is for WiFi only
  * @nvm_ver: NVM version
  * @nvm_calib_ver: NVM calibration version
+ * @bw_limit: bandwidth limit for this device, if non-zero
  * @ht_params: point to ht parameters
  * @led_mode: 0=blinking, 1=On(RF On)/Off(RF Off)
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
@@ -382,6 +383,7 @@ struct iwl_cfg {
 	u32 smem_len;
 	u16 nvm_ver;
 	u16 nvm_calib_ver;
+	u16 bw_limit;
 	u32 rx_with_siso_diversity:1,
 	    tx_with_siso_diversity:1,
 	    internal_wimax_coex:1,
@@ -447,9 +449,6 @@ struct iwl_cfg {
 #define IWL_CFG_RF_ID_HR		0x7
 #define IWL_CFG_RF_ID_HR1		0x4
 
-#define IWL_CFG_BW_NO_LIM		(U16_MAX - 1)
-#define IWL_CFG_BW_ANY			U16_MAX
-
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
 
@@ -468,7 +467,7 @@ struct iwl_dev_info {
 	u16 subdevice;
 	u16 mac_type;
 	u16 rf_type;
-	u16 bw_limit;
+	u8 bw_limit;
 	u8 mac_step;
 	u8 rf_step;
 	u8 rf_id;
@@ -619,13 +618,19 @@ extern const struct iwl_cfg iwl8265_2ac_cfg;
 extern const struct iwl_cfg iwl8275_2ac_cfg;
 extern const struct iwl_cfg iwl4165_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
+extern const struct iwl_cfg iwl9260_2ac_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg;
+extern const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
+extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9560_2ac_cfg_soc_80mhz;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
+extern const struct iwl_cfg iwl_qu_hr_80mhz;
 extern const struct iwl_cfg iwl_ax200_cfg_cc;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
+extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0_80mhz;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
@@ -635,14 +640,17 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwl_cfg_ma;
 
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
+extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0_80mhz;
 #endif /* CONFIG_IWLMVM */
 
 #if IS_ENABLED(CONFIG_IWLMLD)
 extern const struct iwl_ht_params iwl_bz_ht_params;
 
 extern const struct iwl_cfg iwl_cfg_bz;
+extern const struct iwl_cfg iwl_cfg_bz_160mhz;
 
 extern const struct iwl_cfg iwl_cfg_sc;
+extern const struct iwl_cfg iwl_cfg_sc_160mhz;
 extern const struct iwl_cfg iwl_cfg_dr;
 #endif /* CONFIG_IWLMLD */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 018752b8c4d8..b0b42e024766 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -949,7 +949,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		break;
 	case NL80211_BAND_6GHZ:
 		if (!trans->reduced_cap_sku &&
-		    trans->bw_limit >= 320) {
+		    (!trans->cfg->bw_limit || trans->cfg->bw_limit >= 320)) {
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
 				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[1] |=
@@ -1099,11 +1099,12 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_mcs_nss_supp.bw._320.rx_tx_mcs13_max_nss = 0;
 	}
 
-	if (trans->bw_limit < 160)
+	if (trans->cfg->bw_limit && trans->cfg->bw_limit < 160)
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
 			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
-	if (trans->bw_limit < 320 || trans->reduced_cap_sku) {
+	if ((trans->cfg->bw_limit && trans->cfg->bw_limit < 320) ||
+	    trans->reduced_cap_sku) {
 		memset(&iftype_data->eht_cap.eht_mcs_nss_supp.bw._320, 0,
 		       sizeof(iftype_data->eht_cap.eht_mcs_nss_supp.bw._320));
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[2] &=
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 7378a8e74314..c02c9af2e302 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -880,7 +880,6 @@ struct iwl_txq {
  *	only valid for discrete (not integrated) NICs
  * @invalid_tx_cmd: invalid TX command buffer
  * @reduced_cap_sku: reduced capability supported SKU
- * @bw_limit: the max bandwidth
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
  * @restart: restart worker data
  * @restart.wk: restart worker
@@ -919,7 +918,6 @@ struct iwl_trans {
 	char hw_id_str[52];
 	u32 sku_id[3];
 	bool reduced_cap_sku;
-	u16 bw_limit;
 	bool step_urm;
 
 	u8 dsbr_urm_fw_dependent:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 83d368ef623a..69191ec5d3e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -559,7 +559,7 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 	.mac_step = IWL_CFG_ANY,		\
 	.rf_type = IWL_CFG_ANY,			\
 	.rf_step = IWL_CFG_ANY,			\
-	.bw_limit = IWL_CFG_BW_ANY,		\
+	.bw_limit = IWL_CFG_ANY,		\
 	.jacket = IWL_CFG_ANY,			\
 	.cores = IWL_CFG_ANY,			\
 	.rf_id = IWL_CFG_ANY,			\
@@ -579,453 +579,447 @@ EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_hw_card_ids);
 #define RF_ID(n)	.rf_id = IWL_CFG_RF_ID_##n
 #define NO_CDB		.cdb = IWL_CFG_NO_CDB
 #define CDB		.cdb = IWL_CFG_CDB
-#define BW_NO_LIMIT	.bw_limit = IWL_CFG_BW_NO_LIM
-#define BW_LIMIT(n)	.bw_limit = (n)
+#define BW_NO_LIMIT	.bw_limit = 0
+#define BW_LIMITED	.bw_limit = 1
 
 VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
 /* 9000 */
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_killer_1550_name,
-		     DEVICE(0x2526), SUBDEV(0x1550), BW_NO_LIMIT),
+		     DEVICE(0x2526), SUBDEV(0x1550)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
-		     DEVICE(0x2526), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x2526), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
-		     DEVICE(0x2526), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x2526), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
-		     DEVICE(0x30DC), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x30DC), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
-		     DEVICE(0x30DC), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x30DC), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
-		     DEVICE(0x31DC), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x31DC), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
-		     DEVICE(0x31DC), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x31DC), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name,
-		     DEVICE(0xA370), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0xA370), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
-		     DEVICE(0xA370), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0xA370), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x54F0), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x51F0), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x51F0), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x51F0), SUBDEV(0x1691), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x51F0), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1692)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x51F1), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x51F1), SUBDEV(0x1692)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x54F0), SUBDEV(0x1691), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1692)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7A70), SUBDEV(0x1691), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7A70), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1692)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1691), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1692)),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_1_name,
-		     DEVICE(0x271C), SUBDEV(0x0214), BW_NO_LIMIT),
+		     DEVICE(0x271C), SUBDEV(0x0214)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690s_name,
-		     DEVICE(0x7E40), SUBDEV(0x1691), BW_NO_LIMIT),
+		     DEVICE(0x7E40), SUBDEV(0x1691)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax411_killer_1690i_name,
-		     DEVICE(0x7E40), SUBDEV(0x1692), BW_NO_LIMIT),
+		     DEVICE(0x7E40), SUBDEV(0x1692)),
 
 /* AX200 */
 	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_name,
-		     DEVICE(0x2723), BW_NO_LIMIT),
+		     DEVICE(0x2723)),
 	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name,
-		     DEVICE(0x2723), SUBDEV(0x1653), BW_NO_LIMIT),
+		     DEVICE(0x2723), SUBDEV(0x1653)),
 	IWL_DEV_INFO(iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name,
-		     DEVICE(0x2723), SUBDEV(0x1654), BW_NO_LIMIT),
+		     DEVICE(0x2723), SUBDEV(0x1654)),
 
 	/* Qu with Hr */
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x43F0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x43F0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x43F0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x43F0), SUBDEV(0x4070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x0A10), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x0A10)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0xA0F0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0xA0F0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x4070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0xA0F0), SUBDEV(0x6074), BW_NO_LIMIT),
+		     DEVICE(0xA0F0), SUBDEV(0x6074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x6074), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x6074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x02F0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x02F0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x02F0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x02F0), SUBDEV(0x4070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x06F0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x06F0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x06F0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x06F0), SUBDEV(0x4070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x34F0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x34F0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x34F0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x34F0), SUBDEV(0x4070)),
 
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x3DF0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x3DF0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x3DF0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x3DF0), SUBDEV(0x4070)),
 
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0070), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x0070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0074), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x0074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0078), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x0078)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x007C), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x007C)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650s_name,
-		     DEVICE(0x4DF0), SUBDEV(0x1651), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x1651)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_killer_1650i_name,
-		     DEVICE(0x4DF0), SUBDEV(0x1652), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x1652)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x2074), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x2074)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x4070), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x4070)),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name,
-		     DEVICE(0x4DF0), SUBDEV(0x6074), BW_NO_LIMIT),
+		     DEVICE(0x4DF0), SUBDEV(0x6074)),
 
 	/* So with HR */
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0090), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0090)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0020), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0020)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x2020), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x2020)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0024), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0024)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0510), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0510)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x0A10), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x0A10)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0xE020), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0xE020)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0xE024), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0xE024)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x4020), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x4020)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x6020), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x6020)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, NULL,
-		     DEVICE(0x2725), SUBDEV(0x6024), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x6024)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675w_name,
-		     DEVICE(0x2725), SUBDEV(0x1673), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x1673)),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_ty_gf_a0, iwl_ax210_killer_1675x_name,
-		     DEVICE(0x2725), SUBDEV(0x1674), BW_NO_LIMIT),
+		     DEVICE(0x2725), SUBDEV(0x1674)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x0090), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x0090)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x0098), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x0098)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x00B0), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x00B0)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x0510), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x0510)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0_long, NULL,
-		     DEVICE(0x7A70), SUBDEV(0x0A10), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x0A10)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x0090), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x0090)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x0098), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x0098)),
 	IWL_DEV_INFO(iwlax411_2ax_cfg_so_gf4_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x00B0), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x00B0)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x0310), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x0310)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x0510), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x0510)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, NULL,
-		     DEVICE(0x7AF0), SUBDEV(0x0A10), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x0A10)),
 
 	/* So with JF */
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x7A70), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x7A70), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1552)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_160_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1551), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1551)),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_160_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1552), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1552)),
 
 	/* SO with GF2 */
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x2726), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x2726), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x2726), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x2726), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x51F0), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x51F0), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x51F0), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x51F1), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x51F1), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x51F1), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x51F1), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x54F0), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x54F0), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x54F0), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7A70), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7A70), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x7A70), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7AF0), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x7AF0), SUBDEV(0x1672)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7F70), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x7F70), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7F70), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x7F70), SUBDEV(0x1672)),
 
 	/* MA with GF2 */
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675s_name,
-		     DEVICE(0x7E40), SUBDEV(0x1671), BW_NO_LIMIT),
+		     DEVICE(0x7E40), SUBDEV(0x1671)),
 	IWL_DEV_INFO(iwl_cfg_ma, iwl_ax211_killer_1675i_name,
-		     DEVICE(0x7E40), SUBDEV(0x1672), BW_NO_LIMIT),
+		     DEVICE(0x7E40), SUBDEV(0x1672)),
 
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9461_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9461_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9461_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9462_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9462_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9462_name, MAC_TYPE(PU),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_160_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_2ac_cfg_soc, iwl9560_name, MAC_TYPE(PU),
+	IWL_DEV_INFO(iwl9560_2ac_cfg_soc_80mhz, iwl9560_name, MAC_TYPE(PU),
 		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NO_LIMIT, CORES(BT_GNSS), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9270_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_LIMIT(80), CORES(BT_GNSS), NO_CDB),
+		     BW_LIMITED, CORES(BT_GNSS), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_name, DEVICE(0x271B),
+	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9162_name, DEVICE(0x271B),
 		     MAC_TYPE(TH), RF_TYPE(JF1),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_name, DEVICE(0x2526),
+	IWL_DEV_INFO(iwl9260_2ac_cfg_80mhz, iwl9260_name, DEVICE(0x2526),
 		     MAC_TYPE(TH), RF_TYPE(JF2),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 /* Qu with Jf */
 	/* Qu B step */
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name,
 		     MAC_TYPE(QU), MAC_STEP(B),
 		     RF_TYPE(JF2), RF_ID(JF),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2),
-		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2),
-		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550s_name,
+		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
+		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(B), RF_TYPE(JF2)),
 
 	/* Qu C step */
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name,
 		     MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_name, MAC_TYPE(QU),
-		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMIT(80), CORES(BT),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name, MAC_TYPE(QU),
+		     MAC_STEP(C), RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT),
 		     NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2),
-		     RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2),
-		     RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
+		     SUBDEV(0x1551), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
+		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
 
 	/* QuZ */
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9461_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9461_name, MAC_TYPE(QUZ),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9462_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9462_name, MAC_TYPE(QUZ),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_name, MAC_TYPE(QUZ),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9560_name, MAC_TYPE(QUZ),
+		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name,
-		     SUBDEV(0x1551), MAC_TYPE(QUZ), RF_TYPE(JF2), RF_ID(JF),
-		     BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name,
-		     SUBDEV(0x1552), MAC_TYPE(QUZ), RF_TYPE(JF2), RF_ID(JF),
-		     BW_LIMIT(80), CORES(BT), NO_CDB),
+		     SUBDEV(0x1551), MAC_TYPE(QUZ), RF_TYPE(JF2)),
+	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9560_killer_1550i_name,
+		     SUBDEV(0x1552), MAC_TYPE(QUZ), RF_TYPE(JF2)),
 
 /* Qu with Hr */
 	/* Qu B step */
 	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(B), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
-		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
+	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(B),
+		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 
 	/* Qu C step */
 	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QU),
 		     MAC_STEP(C), RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
-		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
+	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QU), MAC_STEP(C),
+		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QU), MAC_STEP(C),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
 	/* QuZ */
 	IWL_DEV_INFO(iwl_qu_hr1, iwl_ax101_name, MAC_TYPE(QUZ),
 		     RF_TYPE(HR1), NO_CDB),
-	IWL_DEV_INFO(iwl_qu_hr, iwl_ax203_name, MAC_TYPE(QUZ),
-		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
+	IWL_DEV_INFO(iwl_qu_hr_80mhz, iwl_ax203_name, MAC_TYPE(QUZ),
+		     MAC_STEP(B), RF_TYPE(HR2), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_qu_hr, iwl_ax201_name, MAC_TYPE(QUZ),
 		     MAC_STEP(B), RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
@@ -1037,10 +1031,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     NO_CDB),
 
 /* So with Hr */
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax203_name, MAC_TYPE(SO),
-		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax101_name, MAC_TYPE(SO),
-		     RF_TYPE(HR1), BW_LIMIT(80), NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax203_name, MAC_TYPE(SO),
+		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SO),
+		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_killer_1650i_name,
@@ -1048,10 +1042,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     MAC_TYPE(SO), RF_TYPE(HR2)),
 
 /* So-F with Hr */
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax203_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR2), BW_LIMIT(80), NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax101_name, MAC_TYPE(SOF),
-		     RF_TYPE(HR1), BW_LIMIT(80), NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax203_name, MAC_TYPE(SOF),
+		     RF_TYPE(HR2), BW_LIMITED, NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0_80mhz, iwl_ax101_name, MAC_TYPE(SOF),
+		     RF_TYPE(HR1), BW_LIMITED, NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SOF),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
 
@@ -1064,18 +1058,18 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* SoF with JF2 */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SOF),
+		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* SoF with JF */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SOF),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_name, MAC_TYPE(SOF),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SOF),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SOF),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with GF */
 	IWL_DEV_INFO(iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name, MAC_TYPE(SO),
@@ -1086,18 +1080,18 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* So with JF2 */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9560_name, MAC_TYPE(SO),
-		     RF_TYPE(JF2), RF_ID(JF), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9560_name, MAC_TYPE(SO),
+		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
 /* So with JF */
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NO_LIMIT, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name, MAC_TYPE(SO),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NO_LIMIT, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9461_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMIT(80), CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0, iwl9462_name, MAC_TYPE(SO),
-		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMIT(80), CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9461_name, MAC_TYPE(SO),
+		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
+	IWL_DEV_INFO(iwlax210_2ax_cfg_so_jf_b0_80mhz, iwl9462_name, MAC_TYPE(SO),
+		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
 #endif /* CONFIG_IWLMVM */
 #if IS_ENABLED(CONFIG_IWLMLD)
@@ -1121,30 +1115,30 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 /* Ga (Gl) */
 	IWL_DEV_INFO(iwl_cfg_bz, iwl_gl_name, MAC_TYPE(GL), RF_TYPE(FM),
 		     BW_NO_LIMIT, NO_CDB),
-	IWL_DEV_INFO(iwl_cfg_bz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
-		     BW_LIMIT(160), NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_bz_160mhz, iwl_mtp_name, MAC_TYPE(GL), RF_TYPE(FM),
+		     BW_LIMITED, NO_CDB),
 
 /* Sc */
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
-		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC), RF_TYPE(WH),
+		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
-		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2), RF_TYPE(WH),
+		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2), RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_ax211_name, MAC_TYPE(SC2F), RF_TYPE(GF)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_fm_name, MAC_TYPE(SC2F), RF_TYPE(FM)),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_wh_name, MAC_TYPE(SC2F), RF_TYPE(WH),
 		     BW_NO_LIMIT),
-	IWL_DEV_INFO(iwl_cfg_sc, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
-		     BW_LIMIT(160)),
+	IWL_DEV_INFO(iwl_cfg_sc_160mhz, iwl_sp_name, MAC_TYPE(SC2F), RF_TYPE(WH),
+		     BW_LIMITED),
 	IWL_DEV_INFO(iwl_cfg_sc, iwl_pe_name, MAC_TYPE(SC2F), RF_TYPE(PE)),
 
 /* Dr */
@@ -1345,15 +1339,8 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->rf_id != rf_id)
 			continue;
 
-		/*
-		 * Check that bw_limit have the same "boolean" value since
-		 * IWL_SUBDEVICE_BW_LIM can only return a boolean value and
-		 * dev_info->bw_limit encodes a non-boolean value.
-		 * dev_info->bw_limit == IWL_CFG_BW_NO_LIM must be equal to
-		 * !bw_limit to have a match.
-		 */
-		if (dev_info->bw_limit != IWL_CFG_BW_ANY &&
-		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !!bw_limit)
+		if (dev_info->bw_limit != (u8)IWL_CFG_ANY &&
+		    dev_info->bw_limit != bw_limit)
 			continue;
 
 		if (dev_info->cores != (u8)IWL_CFG_ANY &&
@@ -1497,7 +1484,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		iwl_trans->name = dev_info->name;
-		iwl_trans->bw_limit = dev_info->bw_limit;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index de6e3eaca8cd..0da5e255b063 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -31,7 +31,7 @@ static void devinfo_table_order(struct kunit *test)
 					    di->mac_type, di->mac_step,
 					    di->rf_type, di->cdb,
 					    di->jacket, di->rf_id,
-					    di->bw_limit != IWL_CFG_BW_NO_LIM,
+					    di->bw_limit,
 					    di->cores, di->rf_step);
 		if (!ret) {
 			iwl_pci_print_dev_info("No entry found for: ", di);
@@ -104,6 +104,37 @@ static void devinfo_no_cfg_dups(struct kunit *test)
 	}
 }
 
+static void devinfo_check_subdev_match(struct kunit *test)
+{
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[i];
+
+		/* if BW limit bit is matched then must have a limit */
+		if (di->bw_limit == 1)
+			KUNIT_EXPECT_NE(test, di->cfg->bw_limit, 0);
+
+		if (di->subdevice == (u16)IWL_CFG_ANY)
+			continue;
+
+		KUNIT_EXPECT_EQ(test, di->rf_id, (u8)IWL_CFG_ANY);
+		KUNIT_EXPECT_EQ(test, di->bw_limit, (u8)IWL_CFG_ANY);
+		KUNIT_EXPECT_EQ(test, di->cores, (u8)IWL_CFG_ANY);
+	}
+}
+
+static void devinfo_check_killer_subdev(struct kunit *test)
+{
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[i];
+		const char *name = di->name ?: di->cfg->name;
+
+		if (!strstr(name, "Killer"))
+			continue;
+
+		KUNIT_EXPECT_NE(test, di->subdevice, (u16)IWL_CFG_ANY);
+	}
+}
+
 static void devinfo_pci_ids(struct kunit *test)
 {
 	struct pci_dev *dev;
@@ -177,6 +208,8 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_no_cfg_dups),
+	KUNIT_CASE(devinfo_check_subdev_match),
+	KUNIT_CASE(devinfo_check_killer_subdev),
 	KUNIT_CASE(devinfo_pci_ids),
 	KUNIT_CASE(devinfo_no_trans_cfg_dups),
 	{}
-- 
2.34.1


