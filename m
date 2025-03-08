Return-Path: <linux-wireless+bounces-20066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EFAA57F34
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87DA3ABB18
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9441EDA00;
	Sat,  8 Mar 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZSsk5Py"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5D1B0411
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471308; cv=none; b=ZwfGY0fmZmCpcnBFAw7vitk5jknTFI924Y1JKv21yugkfSq5pDpf9oxlkzwARK5jCDL837sFf85IwO+p7X304dXody68sb7JtkBYC8rdEpdFpcDuqRCgEkny6VHxnojhQJUei75YxLLAx8/PE3QHqlJmMW6xX7IzAWKqehDBCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471308; c=relaxed/simple;
	bh=EdRmZujHb9fs1v2CBTyju/7u68tzpZTsjGWYGTGjEB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UT8FWNQt+y8TLkkke4XGZP29ntPU5QUBF3otIaaSj1H6cpf7PdBpCcpG8KX1ZmuT4OkO3/v/BcrG/bvybHIZ3jvCqI5QxuioAg2w2JCypX4uGgfXfuWvl5bKhnxlKhzyPKqA2utaSFx7kGoIF4HuuQ5bHki0c8RU2CEkkc7HfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZSsk5Py; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471306; x=1773007306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EdRmZujHb9fs1v2CBTyju/7u68tzpZTsjGWYGTGjEB0=;
  b=LZSsk5Py7+SWYf5HQn4X7nEkd2Q30zkwmPUQ2vGXmz+yvKk9+gGoJoW+
   T7YUrQuwme+vDsHPJ3g7pubCuHK/h5/9GxF3ealhLl5kmTKnTEfM/FR7a
   deNk7h6cl4RLXVbjWHncEke1DTZ/oT/H9MEjhQhZHj9U4Gf7fSAoGLn4k
   02RRWRNW/yUEQvbsyWT0VsWtg6eYCf1v5aBKvPE8idqVBABpwazJUBhBE
   5GoiGutfnCG1GQN5h6NoZXd2axudE1hgOHlav9YJQMyPKVC6QVcJcxOxX
   +ObKlIGs18jGzSNEWW1G3UoIfH5vmFIn6sPyMNRtXjZ8PoPGf2FNvchiE
   Q==;
X-CSE-ConnectionGUID: TO8TwDxITnm6rM/sH0RBHA==
X-CSE-MsgGUID: c8HnnTGtR+CT56qDTCCnnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540625"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540625"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:46 -0800
X-CSE-ConnectionGUID: QN1T3C4pRa2KO0EFrz5WqQ==
X-CSE-MsgGUID: BdKdvIEIRruRywArIqL3bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352113"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: iwlwifi: mld: initialize regulatory early
Date: Sun,  9 Mar 2025 00:01:16 +0200
Message-Id: <20250308235203.10ab8fed94e9.I7c8dee3d14c7427a56882739f82546c6492f3b10@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since iwlmld claims wiphys to be self-managed, it needs to
have a regdomain registered before the wiphy is registered
to avoid issues when trying to get the regdomain, e.g. via
"iw phy phy0 reg get".

Move the initialization early, on every FW start not just
when starting to really operate it. This also requires the
self-managed flag to be set early.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c     |  8 ++++----
 .../net/wireless/intel/iwlwifi/mld/mac80211.c   |  9 ---------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c    | 17 +++++++++++++++--
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index ec93af362cfc..9c1dce0d5979 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -339,6 +339,10 @@ int iwl_mld_load_fw(struct iwl_mld *mld)
 	if (ret)
 		return ret;
 
+	ret = iwl_mld_init_mcc(mld);
+	if (ret)
+		return ret;
+
 	mld->fw_status.running = true;
 
 	return 0;
@@ -481,10 +485,6 @@ static int iwl_mld_config_fw(struct iwl_mld *mld)
 	if (ret)
 		return ret;
 
-	ret = iwl_mld_init_mcc(mld);
-	if (ret)
-		return ret;
-
 	if (mld->fw_status.in_hw_restart) {
 		iwl_mld_send_recovery_cmd(mld, ERROR_RECOVERY_UPDATE_DB);
 		iwl_mld_time_sync_fw_config(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index b01a41f9b013..27ef41d69479 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -164,14 +164,6 @@ static void iwl_mld_hw_set_security(struct iwl_mld *mld)
 			      NL80211_EXT_FEATURE_BEACON_PROTECTION);
 }
 
-static void iwl_mld_hw_set_regulatory(struct iwl_mld *mld)
-{
-	struct wiphy *wiphy = mld->wiphy;
-
-	wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
-	wiphy->regulatory_flags |= REGULATORY_ENABLE_RELAX_NO_IR;
-}
-
 static void iwl_mld_hw_set_antennas(struct iwl_mld *mld)
 {
 	struct wiphy *wiphy = mld->wiphy;
@@ -415,7 +407,6 @@ int iwl_mld_register_hw(struct iwl_mld *mld)
 	iwl_mld_hw_set_addresses(mld);
 	iwl_mld_hw_set_channels(mld);
 	iwl_mld_hw_set_security(mld);
-	iwl_mld_hw_set_regulatory(mld);
 	iwl_mld_hw_set_pm(mld);
 	iwl_mld_hw_set_antennas(mld);
 	iwl_mac_hw_set_radiotap(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index adc3d23aa019..d4a99ae64074 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2024-2025 Intel Corporation
  */
-
+#include <linux/rtnetlink.h>
 #include <net/mac80211.h>
 
 #include "fw/api/rx.h"
@@ -50,6 +50,14 @@ static void __exit iwl_mld_exit(void)
 }
 module_exit(iwl_mld_exit);
 
+static void iwl_mld_hw_set_regulatory(struct iwl_mld *mld)
+{
+	struct wiphy *wiphy = mld->wiphy;
+
+	wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
+	wiphy->regulatory_flags |= REGULATORY_ENABLE_RELAX_NO_IR;
+}
+
 VISIBLE_IF_IWLWIFI_KUNIT
 void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
 		       const struct iwl_cfg *cfg, const struct iwl_fw *fw,
@@ -67,7 +75,6 @@ void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
 
 	/* Setup async RX handling */
 	spin_lock_init(&mld->async_handlers_lock);
-	INIT_LIST_HEAD(&mld->async_handlers_list);
 	wiphy_work_init(&mld->async_handlers_wk,
 			iwl_mld_async_handlers_wk);
 
@@ -387,9 +394,13 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_bios_setup_step(trans, &mld->fwrt);
 	mld->bios_enable_puncturing = iwl_uefi_get_puncturing(&mld->fwrt);
 
+	iwl_mld_hw_set_regulatory(mld);
+
 	/* Configure transport layer with the opmode specific params */
 	iwl_mld_configure_trans(op_mode);
 
+	/* needed for regulatory init */
+	rtnl_lock();
 	/* Needed for sending commands */
 	wiphy_lock(mld->wiphy);
 
@@ -401,6 +412,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	if (ret) {
 		wiphy_unlock(mld->wiphy);
+		rtnl_unlock();
 		iwl_fw_flush_dumps(&mld->fwrt);
 		goto free_hw;
 	}
@@ -408,6 +420,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_mld_stop_fw(mld);
 
 	wiphy_unlock(mld->wiphy);
+	rtnl_unlock();
 
 	ret = iwl_mld_leds_init(mld);
 	if (ret)
-- 
2.34.1


