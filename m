Return-Path: <linux-wireless+bounces-22739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5869AAF973
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C591C002A1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F6C2253E0;
	Thu,  8 May 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRCbLaXy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB82253AB
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706406; cv=none; b=OkXNmtOvCDSqUQuplPvh6OlJI/rfI56E5/F0FRqZ5Lndei5KGi9nRiZ8WSAvy/BNy9Kxc8iBAnHauMKD/FLTl9ak077jO8BGvv6WewBgdsMFT0P7PguTzxUMivyNKCoi+zvj6KnyYAav8tkFrfxYf7IJlO0lVxTbnvwtY6XcLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706406; c=relaxed/simple;
	bh=MyIDiW90EHWHeRiXhSziNqMSluMhvcZKC2g9k9EjXqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD9tnNd8znFPEBc/Lvr4HXIW64c2CP6ErVkrKmwfV3Kvf0lAO5NKHSWqa6CFy6HbMw2tJgwZ5xF/OzHDFo1xvvRJRfMR+qwI6BXsNEWGUN3DJZz/OOcQTrnfDn9Q8FwV3PkSSDHLApAUxv3mpwTPMqVE3UFXHy10jM7aNJMDUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRCbLaXy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706405; x=1778242405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MyIDiW90EHWHeRiXhSziNqMSluMhvcZKC2g9k9EjXqU=;
  b=dRCbLaXyuCgBTRUP9PXZQFPFaZA156itK1Plr259oToiSK1vZ8sIihkl
   CMmQ94MmfI8nd+CaqcU0Dpgb7Ji8Xz+FwXbi4F0iuJZ1RElAUlQ6L+OrT
   8oTBXxLFkbHfRHfp34BJR3sLfpDXnBAW1VTuYyX7QbSjLlJrNw+KYsUxY
   Uvp+XUbvp9lVG9INnwvtrR9Xfcd+7cy/kdOinaQ2/wOoBpa3PytiQuqa4
   XsT1Ac1JYBtvyvni+JrvYj1xSShKBZPwBMlPwob35jtWEHJnFcGJGMeMO
   rB2B0Ku14bG43Mrrh76V08nVeZheC8WNoK5Dj3UZMzRFPIJ2AVrQ+Sjba
   g==;
X-CSE-ConnectionGUID: CJEV3GE5Ra2QVjb5OUmOIA==
X-CSE-MsgGUID: owfkbqjWRp+VRd0hoIWKKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688033"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688033"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:25 -0700
X-CSE-ConnectionGUID: ul3jo1H/RESUolbmDtow4Q==
X-CSE-MsgGUID: EKsyH1PhTjeM9d+86oGeEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347783"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: cfg: remove QuZ/JF special cases
Date: Thu,  8 May 2025 15:12:53 +0300
Message-Id: <20250508121306.1277801-3-miriam.rachel.korenblit@intel.com>
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

Since JF RF always uses b0 step and QuZ MAC always uses
a0 step for firmware, there's no need for these configs
that just force the steps to those values. Remove them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.5e7f3de13ff3.I3175e6d02788cd246edacc4d8ce1af008261d465@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 13 -------------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 16 ++++++++--------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 633fb2bffa2f..5b0704241b15 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -174,19 +174,6 @@ const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz = {
 	.bw_limit = 80,
 };
 
-const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg_80mhz = {
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-	.bw_limit = 80,
-};
-
 const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 914f549e95ba..93bba87a234a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -669,8 +669,6 @@ extern const struct iwl_cfg iwl9000_2ac_cfg;
 extern const struct iwl_cfg iwl9000_2ac_cfg_80mhz;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg;
 extern const struct iwl_cfg iwl9560_qu_jf_cfg_80mhz;
-extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
-extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg_80mhz;
 extern const struct iwl_cfg iwl_qu_hr1;
 extern const struct iwl_cfg iwl_qu_hr;
 extern const struct iwl_cfg iwl_qu_hr_80mhz;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fe2a8f40f6d4..934671d3d454 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1336,23 +1336,23 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     SUBDEV(0x1552), MAC_TYPE(QU), MAC_STEP(C), RF_TYPE(JF2)),
 
 	/* QuZ */
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9461_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9461_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9461_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1), BW_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9462_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9462_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9462_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF1), RF_ID(JF1_DIV), BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_160_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_NOT_LIMITED, CORES(BT), NO_CDB),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9560_name, MAC_TYPE(QUZ),
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_name, MAC_TYPE(QUZ),
 		     RF_TYPE(JF2), RF_ID(JF), BW_LIMITED, CORES(BT), NO_CDB),
 
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg, iwl9560_killer_1550s_name,
 		     SUBDEV(0x1551), MAC_TYPE(QUZ), RF_TYPE(JF2)),
-	IWL_DEV_INFO(iwl9560_quz_a0_jf_b0_cfg_80mhz, iwl9560_killer_1550i_name,
+	IWL_DEV_INFO(iwl9560_qu_jf_cfg_80mhz, iwl9560_killer_1550i_name,
 		     SUBDEV(0x1552), MAC_TYPE(QUZ), RF_TYPE(JF2)),
 
 /* Qu with Hr */
-- 
2.34.1


