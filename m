Return-Path: <linux-wireless+bounces-23963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E7AD496C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8980A7A9FA5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AA218AC3;
	Wed, 11 Jun 2025 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9uXH4Iz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95249219E8C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612881; cv=none; b=kmQFB8lTAEXyoj2TfYt/jzaDU8NjudS5rd0bnUeZ7YAZlLrmGjCvOXWkY3TcEt4Pw7+/19VfJJgMtD5hIMoYIY5aoLIHn7JygCCZ2GxbAkMwqMozRTC30qoTBz+uTpu2mVc2dGQpvIakHY96uzyJmfHt3Z9++sfBGDVJ/ZrFI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612881; c=relaxed/simple;
	bh=OO2xFlo3x0olf6gA/wxqaXCWzMI0kLGZWt6CmXfdEwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIyrTPOIVujv8pWIzR+Y82nha6NsnsD5mY6KdFA3tJsE4aj9W6/zUhVFMTD3kOztdLnSU232Ho4OoYMpRG0qGlij9Hmcxfijcrergya4sGykMopnqq3bxDUyqX5AvBFUm5a9wZA8c9HOp4x75njYR0/4Wf+Tn/iZNpGCbt1PKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9uXH4Iz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612879; x=1781148879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OO2xFlo3x0olf6gA/wxqaXCWzMI0kLGZWt6CmXfdEwU=;
  b=Y9uXH4IzbifBQ/2DxgUSZqXN5j05EJZ0KtFVPLI43ltRZKnDeyL+PBdz
   83yO1atoIpoWp8QtwyYSTCfVINz0sb0dQegzH72lfwJm+CIP/lNTwsfDP
   bNcq7jgMeSGD5HyhSfcfDxkwsBZl5zSCIyK9XkbGPuCjt0vm7Vrb1DaxR
   OJCL/WQTwB10UFMs59RgSEXVp08uQFvV2xczfhogO5mZyzxcHNjiN5BgE
   DUxi7tTnceySH6Laxrm/+McSUNF9/QqaZev+QtQbGO59l50dySnRww1my
   4T7ym0H7IqaeeACMOAhKbT8LUBcPLfvkQh0QHJyzj6Ne/P6vZRcxxPCNy
   Q==;
X-CSE-ConnectionGUID: bqyRy19lRMmJTI7T25tyNg==
X-CSE-MsgGUID: UNXlJ1l/S0SkA9rKoIGQOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094889"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094889"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:39 -0700
X-CSE-ConnectionGUID: 9G69NCw7Sb+hmQ3yst4VZA==
X-CSE-MsgGUID: dVb+s4o1T5utXG+9bwHZEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880934"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: add timer host wakeup debugfs
Date: Wed, 11 Jun 2025 06:34:06 +0300
Message-Id: <20250611063124.9f2a39cae1e1.Ie0003f21286fea50b507d0debe06332b030cd4cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a debugfs file to be able to control how long, at most,
the device will sleep before waking up the host. This will
be useful to test certain "assert during suspend" scenarios
for the previous change.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h   | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/mld/d3.c      | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h     | 2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 9c271ea67155..9ce819503aed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -19,9 +19,11 @@ enum iwl_d0i3_flags {
 /**
  * enum iwl_d3_wakeup_flags - D3 manager wakeup flags
  * @IWL_WAKEUP_D3_CONFIG_FW_ERROR: wake up on firmware sysassert
+ * @IWL_WAKEUP_D3_HOST_TIMER: wake up on host timer expiry
  */
 enum iwl_d3_wakeup_flags {
-	IWL_WAKEUP_D3_CONFIG_FW_ERROR = BIT(0),
+	IWL_WAKEUP_D3_CONFIG_FW_ERROR	= BIT(0),
+	IWL_WAKEUP_D3_HOST_TIMER	= BIT(1),
 }; /* D3_MANAGER_WAKEUP_CONFIG_API_E_VER_3 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 339b148d6793..d450d24689f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1317,6 +1317,13 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	struct iwl_d3_manager_config d3_cfg_cmd_data = {};
 	int ret;
 
+	if (mld->debug_max_sleep) {
+		d3_cfg_cmd_data.wakeup_host_timer =
+			cpu_to_le32(mld->debug_max_sleep);
+		d3_cfg_cmd_data.wakeup_flags =
+			cpu_to_le32(IWL_WAKEUP_D3_HOST_TIMER);
+	}
+
 	lockdep_assert_wiphy(mld->wiphy);
 
 	IWL_DEBUG_WOWLAN(mld, "Starting the no wowlan suspend flow\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 352da8aa7898..75cc1d8bb90c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -546,6 +546,11 @@ iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
 #endif
 	MLD_DEBUGFS_ADD_FILE(inject_packet, debugfs_dir, 0200);
 
+#ifdef CONFIG_PM_SLEEP
+	debugfs_create_u32("max_sleep", 0600, debugfs_dir,
+			   &mld->debug_max_sleep);
+#endif
+
 	debugfs_create_bool("rx_ts_ptp", 0600, debugfs_dir,
 			    &mld->monitor.ptp_time);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 1a2c44f44eff..241ab3a00e56 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -159,6 +159,7 @@
  * @addresses: device MAC addresses.
  * @scan: instance of the scan object
  * @wowlan: WoWLAN support data.
+ * @debug_max_sleep: maximum sleep time in D3 (for debug purposes)
  * @led: the led device
  * @mcc_src: the source id of the MCC, comes from the firmware
  * @bios_enable_puncturing: is puncturing enabled by bios
@@ -252,6 +253,7 @@ struct iwl_mld {
 	struct iwl_mld_scan scan;
 #ifdef CONFIG_PM_SLEEP
 	struct wiphy_wowlan_support wowlan;
+	u32 debug_max_sleep;
 #endif /* CONFIG_PM_SLEEP */
 #ifdef CONFIG_IWLWIFI_LEDS
 	struct led_classdev led;
-- 
2.34.1


