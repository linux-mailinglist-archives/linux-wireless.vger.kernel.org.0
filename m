Return-Path: <linux-wireless+bounces-4888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CEA87F917
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772ACB21F63
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAF7CF30;
	Tue, 19 Mar 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsRUykWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4D7CF1F
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835860; cv=none; b=UWlot4Ncf0noNEaYGHBTf/iAZgcFSSStLWeg9SWB9E1hccsgz1YzN0Of+HJpf5GEW4LsRUWMWLgA++ucaizWj5BUp+O2OedIn3qXDvBP2Z6Mjoq9e7UwR3vMvPqSMSq1FLswkmjtQYzxGxZN1/gB2cvak/GT1jsQapDmGrzSBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835860; c=relaxed/simple;
	bh=u1nS0KoykOiPa7EbN/d8X4tQEOrSTJYf14YNkx2TBH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XptNpicL0yOZDwwUJJGND5F/CvGYcwndPxaBoaX9/QPXCWuT7uf0MDWFVT5zhxZgtD05v8kIRJzde3LLhrfUS+FZIp0D5ZJocVqXGxxwYRIHLQcnw8CChMKjDSSIwnRZQmhow7hFjJO3B5nO82llfxavyM+QHgTipfJYzoYR554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsRUykWv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835859; x=1742371859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u1nS0KoykOiPa7EbN/d8X4tQEOrSTJYf14YNkx2TBH4=;
  b=nsRUykWvKNWdvGfkXvXKzIynMqPY1bubdnzOJPY6mQyiHrevIVeHFZkp
   jbfs7Kr4ClCMzIbql4jBi3uSWzVraSDEFJanoBExyhVHEpdCw/NGn/WEx
   urD4l/pL1eHemO35KDfGJ8gHfBbs4FHoNoV5NJpeZad5Pu9lcwIEPANcC
   zQ1o9HWp5snQ2+nEAb5o0vURBIZxrmGCm8BJHqC4UX/nuVeb3wwOZUjvH
   qL0nzs1OaxmTKLCr0jtQJoFPVqM+dfopfBpmjXWBruDNrAkfj4LU9QEGt
   SvCcDz36ya0eszF6cYJITXPjdzZ1hPEmXloWyQVd1aVlsEippWEmqAYOi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810560"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447627"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: fw: don't always use FW dump trig
Date: Tue, 19 Mar 2024 10:10:20 +0200
Message-Id: <20240319100755.e2976bc58b29.I72fbd6135b3623227de53d8a2bb82776066cb72b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the dump_data (struct iwl_fwrt_dump_data) is a union,
it's not safe to unconditionally access and use the 'trig'
member, it might be 'desc' instead. Access it only if it's
known to be 'trig' rather than 'desc', i.e. if ini-debug
is present.

Fixes: 0eb50c674a1e ("iwlwifi: yoyo: send hcmd to fw after dump collection completes.")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index db6d7013df66..c3bdf433d8f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3081,8 +3081,6 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	struct iwl_fw_dbg_params params = {0};
 	struct iwl_fwrt_dump_data *dump_data =
 		&fwrt->dump.wks[wk_idx].dump_data;
-	u32 policy;
-	u32 time_point;
 	if (!test_bit(wk_idx, &fwrt->dump.active_wks))
 		return;
 
@@ -3113,13 +3111,16 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
-	policy = le32_to_cpu(dump_data->trig->apply_policy);
-	time_point = le32_to_cpu(dump_data->trig->time_point);
+	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
+		u32 policy = le32_to_cpu(dump_data->trig->apply_policy);
+		u32 time_point = le32_to_cpu(dump_data->trig->time_point);
 
-	if (policy & IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD) {
-		IWL_DEBUG_FW_INFO(fwrt, "WRT: sending dump complete\n");
-		iwl_send_dbg_dump_complete_cmd(fwrt, time_point, 0);
+		if (policy & IWL_FW_INI_APPLY_POLICY_DUMP_COMPLETE_CMD) {
+			IWL_DEBUG_FW_INFO(fwrt, "WRT: sending dump complete\n");
+			iwl_send_dbg_dump_complete_cmd(fwrt, time_point, 0);
+		}
 	}
+
 	if (fwrt->trans->dbg.last_tp_resetfw == IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY)
 		iwl_force_nmi(fwrt->trans);
 
-- 
2.34.1


