Return-Path: <linux-wireless+bounces-26648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0755B36F6D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B59F4664BB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54371350D43;
	Tue, 26 Aug 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS4YOzb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4823314B71
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223753; cv=none; b=XYJ2sbpf4TmgrOtT8Ivt5CkSbBfl2ZLCntnxGuglM+pQSijxMzJbnQKa66i5O/afcXKSXJt2QkF4NMVfQNHR3bwCCOErhLu5Sovdli0tj68WCfGHNyv1uTotmiSRI0EdkI52gudvlnuLLyHCWPPxWz02SnnvVhMqG+PPybvSY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223753; c=relaxed/simple;
	bh=6dd/+q3JYsXl9hMtKtS+ymYbGexBISGMxSxo6C0cb3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hP7au+YvJZcqD7VISxgCAfGR89TtvZr9WEnwvQsyq5wafXnQg/LXp+V1L7yPTfr6b+mTgPYgykaL1hkvSjX4t0d5xk9MlmEkKmWhPVAkF520+24yoriEYM2g42vOZ7cF3BK3qIZWbOn69wb+6HX1u96mBMeOKA/aJoBzJS9ghi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS4YOzb3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223752; x=1787759752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6dd/+q3JYsXl9hMtKtS+ymYbGexBISGMxSxo6C0cb3k=;
  b=RS4YOzb38JafEFxEFLW+LDU7zEMPaSURW+sXjzY3G+OO2UiMQfSx+FSQ
   lMVf2EmK3dswT1cPVRzdWDpDAh0wiCqt5mL9io7MWbDJD/2rW8tghK/QI
   EM02rhx7/fGNC1BnEWKN5XunMcN+SGi4qJRFWjW5Ns9/T7UQWSRk73VrB
   as6iVtnTyFDWLwrGgXxjxlN+nRh4vz+7iTM1vtzI2osaoRQa+XOEeZaSl
   nV+wcCNNXEht5NwZenaiBuQHx9q/jt33r2UtV9087mNA2pPrrqjVjD1SX
   +d/xq8sHDNs3Sgikw4cZzMaspVF9PlckhYJSjchxR2PagOD846K9vD3Fd
   g==;
X-CSE-ConnectionGUID: EnR7M39lStKnwkXljakkDQ==
X-CSE-MsgGUID: etsHHH0HSguX8kziB+i4GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108432"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108432"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:45 -0700
X-CSE-ConnectionGUID: d0HLkptOTomfUsjcVgFqPQ==
X-CSE-MsgGUID: y6epZy/iSFWfl1ncIo+k3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218324"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: trans: remove STATUS_SUSPENDED
Date: Tue, 26 Aug 2025 18:55:00 +0300
Message-Id: <20250826184046.2642406f0e9f.Ic530fa7901bd6bd9df805c8f892357078377ac8b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We needed this bit to prevent sending host commands when suspended in
pseudo mode (in real suspension we can't send commands anyway).
Now as pseudo mode is removed, we no longer need it.
Remove.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 22 ++-----------------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 ---
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index c5944e9fa6c3..d68a820c3d48 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -318,9 +318,6 @@ int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd)
 		     test_bit(STATUS_RFKILL_OPMODE, &trans->status)))
 		return -ERFKILL;
 
-	if (unlikely(test_bit(STATUS_SUSPENDED, &trans->status)))
-		return -EHOSTDOWN;
-
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
 
@@ -408,8 +405,6 @@ int iwl_trans_start_hw(struct iwl_trans *trans)
 	might_sleep();
 
 	clear_bit(STATUS_TRANS_RESET_IN_PROGRESS, &trans->status);
-	/* opmode may not resume if it detects errors */
-	clear_bit(STATUS_SUSPENDED, &trans->status);
 
 	return iwl_trans_pcie_start_hw(trans);
 }
@@ -509,31 +504,18 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask,
 
 int iwl_trans_d3_suspend(struct iwl_trans *trans, bool reset)
 {
-	int err;
-
 	might_sleep();
 
-	err = iwl_trans_pcie_d3_suspend(trans, reset);
-
-	if (!err)
-		set_bit(STATUS_SUSPENDED, &trans->status);
-
-	return err;
+	return iwl_trans_pcie_d3_suspend(trans, reset);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_suspend);
 
 int iwl_trans_d3_resume(struct iwl_trans *trans, enum iwl_d3_status *status,
 			bool reset)
 {
-	int err;
-
 	might_sleep();
 
-	err = iwl_trans_pcie_d3_resume(trans, status, reset);
-
-	clear_bit(STATUS_SUSPENDED, &trans->status);
-
-	return err;
+	return iwl_trans_pcie_d3_resume(trans, status, reset);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_d3_resume);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b7e2355ece30..0fca6992ec5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -302,8 +302,6 @@ enum iwl_d3_status {
  *	the firmware state yet
  * @STATUS_TRANS_RESET_IN_PROGRESS: reset is still in progress, don't
  *	attempt another reset yet
- * @STATUS_SUSPENDED: device is suspended, don't send commands that
- *	aren't marked accordingly
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -318,7 +316,6 @@ enum iwl_trans_status {
 	STATUS_IN_SW_RESET,
 	STATUS_RESET_PENDING,
 	STATUS_TRANS_RESET_IN_PROGRESS,
-	STATUS_SUSPENDED,
 };
 
 static inline int
-- 
2.34.1


