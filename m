Return-Path: <linux-wireless+bounces-2402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C683974D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906EB1F2CC68
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16F81AD2;
	Tue, 23 Jan 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGWbSbSO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407081AD4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033343; cv=none; b=utJOX7us6s3U8JfrYjVa063PNaA1oxz1vhiimd78nzuJ29aH6ua4i9I3wyCGliw4b17OGW/FPPLID34pcyFXgZ5bsiiFX07Nd7cMmJofGYAF6n4OfEW0uDyJ5q3cxdOciZtaGQQW+jUKZJYi/rZdGJYsJO1lbhkVe/WDJnKfFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033343; c=relaxed/simple;
	bh=R6pUuOybH9sZksa3eFP7egraef6Fsygz7d0+lTyTL2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnLHWyXd3/SdaLCEahvefQW/K8KfpRyo0NqVZeFN6BkX0dKvoj/SaGGrsHYrT1b1/isdXhl2gJE6NtYmVQUP4XCOeDwWI/jEQzIQ/VlmUVwSIF9A35b/20aff+ZLCTvO0/AGjvvP4LV8o7c1DvQLxwAKp9sdiQhSlJyFGE9G3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGWbSbSO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033342; x=1737569342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6pUuOybH9sZksa3eFP7egraef6Fsygz7d0+lTyTL2s=;
  b=WGWbSbSO4ITBA/Ue7RESJBhfaMN4a6VQwDy2+TPVdsce36kPevEgo63S
   M08jd4DvBoHUOOQO50bbNNMyRq0eSFhUIsnP8Tb16qgCuPVM9U1Whng3U
   99Fa9H6WMbbOJVBN5yifSvT77bAMCqtVL+0lRDufXN9qg096exldl3d+B
   shaxulbEftWLqQA3r1MBvL2RhOxi8VlqHR7wAAH7uKbOTCikkWNvMPYu0
   YfVtlJWu7TuVKjhE2fGSOsjJf6XAVXthbT66tJ9yskleBtEywnp0ayV4d
   GIr3v1iqS+tcV9kD/o65JVevWNwTloAM2k1egX77g+tu/QDH/j4zDTXOx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501814"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666535"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: remove retry loops in start
Date: Tue, 23 Jan 2024 20:08:15 +0200
Message-Id: <20240123200528.f80a88a18799.I48f21eda090f4cc675f40e99eef69a986d21b500@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's either the pldr_sync case, in which case we didn't want
or do the retry loops anyway, or things will just continue to
fail. Remove the retry loop that was added in a previous attempt
to address the issue that was later (though still a bit broken)
addressed by the pldr_sync case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 28 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  3 --
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 +------
 3 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index abf8001bdac1..91e974de0ade 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1424,35 +1424,25 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 	const struct iwl_op_mode_ops *ops = op->ops;
 	struct dentry *dbgfs_dir = NULL;
 	struct iwl_op_mode *op_mode = NULL;
-	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
 
 	/* also protects start/stop from racing against each other */
 	lockdep_assert_held(&iwlwifi_opmode_table_mtx);
 
-	for (retry = 0; retry <= max_retry; retry++) {
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-		drv->dbgfs_op_mode = debugfs_create_dir(op->name,
-							drv->dbgfs_drv);
-		dbgfs_dir = drv->dbgfs_op_mode;
+	drv->dbgfs_op_mode = debugfs_create_dir(op->name,
+						drv->dbgfs_drv);
+	dbgfs_dir = drv->dbgfs_op_mode;
 #endif
 
-		op_mode = ops->start(drv->trans, drv->trans->cfg,
-				     &drv->fw, dbgfs_dir);
-
-		if (op_mode)
-			return op_mode;
-
-		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
-			break;
-
-		IWL_ERR(drv, "retry init count %d\n", retry);
+	op_mode = ops->start(drv->trans, drv->trans->cfg,
+			     &drv->fw, dbgfs_dir);
+	if (op_mode)
+		return op_mode;
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-		debugfs_remove_recursive(drv->dbgfs_op_mode);
-		drv->dbgfs_op_mode = NULL;
+	debugfs_remove_recursive(drv->dbgfs_op_mode);
+	drv->dbgfs_op_mode = NULL;
 #endif
-	}
 
 	return NULL;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 6a1d31892417..1549ff429549 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -98,9 +98,6 @@ void iwl_drv_stop(struct iwl_drv *drv);
 #define VISIBLE_IF_IWLWIFI_KUNIT static
 #endif
 
-/* max retry for init flow */
-#define IWL_MAX_INIT_RETRY 2
-
 #define FW_NAME_PRE_BUFSIZE	64
 struct iwl_trans;
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7f13dff04b26..6bbcf4092f52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1195,14 +1195,12 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
-	int retry, max_retry = 0;
 
 	mutex_lock(&mvm->mutex);
 
 	/* we are starting the mac not in error flow, and restart is enabled */
 	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
 	    iwlwifi_mod_params.fw_restart) {
-		max_retry = IWL_MAX_INIT_RETRY;
 		/*
 		 * This will prevent mac80211 recovery flows to trigger during
 		 * init failures
@@ -1210,13 +1208,7 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 	}
 
-	for (retry = 0; retry <= max_retry; retry++) {
-		ret = __iwl_mvm_mac_start(mvm);
-		if (!ret || mvm->pldr_sync)
-			break;
-
-		IWL_ERR(mvm, "mac start retry %d\n", retry);
-	}
+	ret = __iwl_mvm_mac_start(mvm);
 	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
 
 	mutex_unlock(&mvm->mutex);
-- 
2.34.1


