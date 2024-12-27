Return-Path: <linux-wireless+bounces-16839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BBC9FD1C2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D311D1623D3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC7D15574E;
	Fri, 27 Dec 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4fr0ddX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC31155725
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286511; cv=none; b=XLnYecLvEbgZ6YDA0FvrvJQSRvOR11VBarCMQqW+ExBA91g6XIMXxXtripy8XAkDGk3Wm5hgeYUXw6VRx4u5O7VGcS20WN/nWkpxrgAohJbpi1sEvwkVc2ymUmzHj0oApJ9uwJ1XXLk/Xvf8zcJOLMpGeT9Hvgc4BTlkVprnyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286511; c=relaxed/simple;
	bh=Bm6wGP3hYpm9WChvuBYK0N6CJ4H7XQFeemKHbnOnop4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1XyISs/DsV3Du1SLYPwDzWd5msve4hupcf6VwWIZWEYjD46wjkTZkEDJbdkP1L7ILYqsG4cT1KdANji3Wzsp7oLaYxA67fpq2K1CZVOAG3jvNNc/dC/mKcGsNKoHx0OeuZK15in+74EPzTd76Rq/3YY/j7tU21WfEITEaH/m9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4fr0ddX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286510; x=1766822510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bm6wGP3hYpm9WChvuBYK0N6CJ4H7XQFeemKHbnOnop4=;
  b=Z4fr0ddXmVwBPKQAM+eGVyxtRPIXUtQ6t4USxWb4CqVC7Tu44AXyIbr6
   whgdoSGJy8PQ9yXv8mwHel50qdxsW+qxfcLMPUUIwfc4Rq1GRI0YznNbL
   AHqar6A2D/x0ruNIj6LyVwcCnsNgA9m0v1gx2yYGHqxIwAd9cFGdBloJu
   EwGnCX7qlRJfJHJr2DiTTnRZFlCX0CaMy5r01xiBkgz5Len2/mSLs6Oxa
   KGgnhzSlhughOJgxC/Ty9gWflN1lljzJF5wEwQVn54gfu1iHsPU5bRvwl
   9vKRcWgQNhog3Ly5g/fblqlikSSWoVMFTaFfvzT97mWOw1RRbxM8Vmwbm
   A==;
X-CSE-ConnectionGUID: SyxOxvyJQPqrHQygDYcbHA==
X-CSE-MsgGUID: uws2EHpNQeelV4r2DcxWgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46691010"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46691010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:49 -0800
X-CSE-ConnectionGUID: b5rudYTdRMOEEOAU3qKXsg==
X-CSE-MsgGUID: ullKYErsQlCjF5OiQSaBkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858500"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/17] wifi: iwlwifi: iwl_fw_error_collect() is always called sync
Date: Fri, 27 Dec 2024 10:01:12 +0200
Message-Id: <20241227095718.08f515513e88.I780a557743ca7f029f46a1cc75d0799542e39d83@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since iwl_fw_error_collect() is now always called with the sync
argument set to true, to collect data synchronously, remove the
argument from it entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h  | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index f4803b55adb9..87998374f459 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -287,7 +287,7 @@ static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 		trans->dbg.umac_error_event_table = umac_error_event_table;
 }
 
-static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt, bool sync)
+static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 {
 	enum iwl_fw_ini_time_point tp_id;
 
@@ -303,7 +303,7 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt, bool sync)
 		tp_id = IWL_FW_INI_TIME_POINT_FW_ASSERT;
 	}
 
-	_iwl_dbg_tlv_time_point(fwrt, tp_id, NULL, sync);
+	iwl_dbg_tlv_time_point_sync(fwrt, tp_id, NULL);
 }
 
 static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 08c59df593b2..7250c85fb6e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2043,11 +2043,11 @@ static void iwl_mvm_dump_error(struct iwl_op_mode *op_mode,
 	/* if we come in from opmode we have the mutex held */
 	if (mode->context == IWL_ERR_CONTEXT_FROM_OPMODE) {
 		lockdep_assert_held(&mvm->mutex);
-		iwl_fw_error_collect(&mvm->fwrt, true);
+		iwl_fw_error_collect(&mvm->fwrt);
 	} else {
 		mutex_lock(&mvm->mutex);
 		if (mode->context != IWL_ERR_CONTEXT_ABORT)
-			iwl_fw_error_collect(&mvm->fwrt, true);
+			iwl_fw_error_collect(&mvm->fwrt);
 		mutex_unlock(&mvm->mutex);
 	}
 }
-- 
2.34.1


