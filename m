Return-Path: <linux-wireless+bounces-13675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BA993DFB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F31F24B0A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08812C484;
	Tue,  8 Oct 2024 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz8kPpp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B4139CEC
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361560; cv=none; b=KcvoB1jppkCGjjTxwMx7Az/HIhee+dlXkGwU1Hb63DaH8alc+NTNkC2G21IsQ2hkzPTGlWwlwuNz9ocCGx/cjb7m5X8aiguWLQxJf0XD0uxKYMwY6asoi0uiogbWndjgcqRKgjtPcNT4uaopME9hkjx1nWq2ogV45AbEjf+KSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361560; c=relaxed/simple;
	bh=OXQtPiWBDH/Ghw6KSS6XK2YShw0JtZrHzTerp6x8N4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhB5kPgLuz1ey8OztwNiywAiCwgp+A9zd+dk3SoifQ1AfcGnagIwXG8WZOAs9lrUEckROzKW4iChVTRcQTP8ZI88MZWA+8dSomuWOGy10NuTQqKPNgP5mFSHkDTlggYXRf1LQjZjS7symit/ZpVzmSvi2MWxjiOv6UZM1lcNOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz8kPpp8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361559; x=1759897559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXQtPiWBDH/Ghw6KSS6XK2YShw0JtZrHzTerp6x8N4w=;
  b=Tz8kPpp88bFMGQFMT3amFl6pxblYk2oYxfVu2TRnpX615q7u6uxgg10T
   CO7ECHRVUGgeeYvipZmj46bPQUfLPSrvIz3zthLRyCFADjfyIvtJKEITR
   q0Gzp13J3DxLUQb2aTbBaXbLDjnv8DdJC1GmTPaIcVZgbgG8anmu+1klt
   IwjYGprgIyAU4YYj7JGnrTeDHVyFwVSSXLAWXshJL0NhQ9hjaPVJlufcb
   NGLi8uQLlQmuw4CD9bX13bD2RYaGQgGoBfb7k/osh3B2WoSOB6eRlaR7S
   2dLlbb+L6lTeqJUt5N/HPD/ONv/4GPq+L3n8gLCP/j8mkOgab/ctiyuNo
   g==;
X-CSE-ConnectionGUID: GJcNQn5VRBKLYKx0IJ/yog==
X-CSE-MsgGUID: IBvhA+KWRRWa8paLIyYunw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024302"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:59 -0700
X-CSE-ConnectionGUID: Sz5scg9wQ16MhF2u8MjZjw==
X-CSE-MsgGUID: IBGL8H7LRNuHtP6CmnB7Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486394"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: fw: add an error table status getter
Date: Tue,  8 Oct 2024 07:25:26 +0300
Message-Id: <20241008072037.610a38614ce6.Iab5f795bc30ce5d08550cff1772fe051527bcb95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Add a function for getting the error status and error
code for given error table.
Remove a static function of same purpose from mvm/d3.c

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 22 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  | 34 ++++++--------------
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 98d56e778d99..9d8f89adc322 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019, 2021-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -327,6 +327,7 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
 void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 				    u32 timepoint,
 				    u32 timepoint_data);
+bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id);
 void iwl_fw_disable_dbg_asserts(struct iwl_fw_runtime *fwrt);
 void iwl_fw_dbg_clear_monitor_buf(struct iwl_fw_runtime *fwrt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 8f107ceec407..3cabdeb53e99 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -530,3 +530,23 @@ void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
 	}
 }
 IWL_EXPORT_SYMBOL(iwl_fwrt_dump_error_logs);
+
+bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id)
+{
+	struct error_table_start {
+		/* cf. struct iwl_error_event_table */
+		u32 valid;
+		__le32 err_id;
+	} err_info;
+
+	if (!base)
+		return false;
+
+	iwl_trans_read_mem_bytes(trans, base,
+				 &err_info, sizeof(err_info));
+	if (err_info.valid && err_id)
+		*err_id = le32_to_cpu(err_info.err_id);
+
+	return !!err_info.valid;
+}
+IWL_EXPORT_SYMBOL(iwl_fwrt_read_err_table);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 99a541d442bb..cdda404c0654 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3024,24 +3024,6 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 		ieee80211_resume_disconnect(vif);
 }
 
-static bool iwl_mvm_rt_status(struct iwl_trans *trans, u32 base, u32 *err_id)
-{
-	struct error_table_start {
-		/* cf. struct iwl_error_event_table */
-		u32 valid;
-		__le32 err_id;
-	} err_info;
-
-	if (!base)
-		return false;
-
-	iwl_trans_read_mem_bytes(trans, base,
-				 &err_info, sizeof(err_info));
-	if (err_info.valid && err_id)
-		*err_id = le32_to_cpu(err_info.err_id);
-
-	return !!err_info.valid;
-}
 
 static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
@@ -3049,9 +3031,9 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	u32 err_id;
 
 	/* check for lmac1 error */
-	if (iwl_mvm_rt_status(mvm->trans,
-			      mvm->trans->dbg.lmac_error_event_table[0],
-			      &err_id)) {
+	if (iwl_fwrt_read_err_table(mvm->trans,
+				    mvm->trans->dbg.lmac_error_event_table[0],
+				    &err_id)) {
 		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
 			struct cfg80211_wowlan_wakeup wakeup = {
 				.rfkill_release = true,
@@ -3063,13 +3045,15 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	}
 
 	/* check if we have lmac2 set and check for error */
-	if (iwl_mvm_rt_status(mvm->trans,
-			      mvm->trans->dbg.lmac_error_event_table[1], NULL))
+	if (iwl_fwrt_read_err_table(mvm->trans,
+				    mvm->trans->dbg.lmac_error_event_table[1],
+				    NULL))
 		return true;
 
 	/* check for umac error */
-	if (iwl_mvm_rt_status(mvm->trans,
-			      mvm->trans->dbg.umac_error_event_table, NULL))
+	if (iwl_fwrt_read_err_table(mvm->trans,
+				    mvm->trans->dbg.umac_error_event_table,
+				    NULL))
 		return true;
 
 	return false;
-- 
2.34.1


