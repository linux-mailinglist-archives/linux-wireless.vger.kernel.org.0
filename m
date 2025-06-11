Return-Path: <linux-wireless+bounces-24006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7154AD5F0A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D747A3294
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1412BDC17;
	Wed, 11 Jun 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfNHpFuf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D42BDC24
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670020; cv=none; b=k+2KNgOa2aqqz7AHhYyKFReyV0H2MtQlv+ZgIxk/Sn3D9t5enNM7Hq3o1+QAxJnFRZ9ZxvyjLhQHjMEMfoY9+06fStpD93BHpNy5qmxJslmrXR55MNv3+Nw7ex581vIqNNwDFKBqu2+mKN5WvBvGenjOg8wP3onhvyA5SSdigNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670020; c=relaxed/simple;
	bh=OO2xFlo3x0olf6gA/wxqaXCWzMI0kLGZWt6CmXfdEwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSoo29/V3peWtAzThO4HT15zlARmfu9E3kFRDMB5gJ5Iu5jISjmC5LcUlBiqnSVUjMDKjAlz77wrBCWocPkjLF5Kg0U0E92WBdgKHcMxm+eFZHJiycnUhJQpYSGoY7K29xnPAvdSwzfoJ6hWgYxzQabQiYT5e2Ycv8zrz0OPnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfNHpFuf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670019; x=1781206019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OO2xFlo3x0olf6gA/wxqaXCWzMI0kLGZWt6CmXfdEwU=;
  b=DfNHpFufwdQ7QZkAg4MUeBv3/xDTQtjtclazW4ESANnpD8W34zYPPHwE
   XKjHESqC1t9RNZ64gHimL7pMOfCUJ6rI+gNxD/1kYfQqPwRJfiUG8tlPN
   wD4YDC3bCO1vkyHNz+/io+Tojlj4fy/vczLm+akQyOOnibtiuf9svKPx3
   plfN4t/IjaE0gLSRipmUhbQVuLVrampYBzVhj6odkxxdbxpHOQqQOeREc
   qlkzw59g4rXLhA8XAFuROKVItEEmG9GXdJ8jiQtyw/FBnEOrqu4A/5l+v
   L5m04pjg3i9Qhrou/V++a3ZF3VELAE8QzTz57hUErWZvuYFR871gIuXgE
   Q==;
X-CSE-ConnectionGUID: LcZGaUMJSpqWP0iHRpZfIQ==
X-CSE-MsgGUID: 2Jh0bQgcQ46Fk/lrp/2WtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360882"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:59 -0700
X-CSE-ConnectionGUID: kzrS7bAmThCPOy23y3164g==
X-CSE-MsgGUID: XDd5dxujTTex4z5Vv9aDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165846"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 06/15] wifi: iwlwifi: mld: add timer host wakeup debugfs
Date: Wed, 11 Jun 2025 22:26:25 +0300
Message-Id: <20250611222325.9f2a39cae1e1.Ie0003f21286fea50b507d0debe06332b030cd4cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
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


