Return-Path: <linux-wireless+bounces-25212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E8B00B65
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0DC1C8115E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17172FCE14;
	Thu, 10 Jul 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtZk8zsZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA82FCFDE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172145; cv=none; b=dSMVWxsDxK3aw8u5O6A043641/mJ77pfp9D0S+Faa87+wNpN4qb92deJVuKysW44pUrydmoTXN3JOgQB3hefw24bRJIEfJIUM2eSrvqFbxyhiTZ5ww/L2HD7UllW5Jt/YNUC0i8M0Ou7MHdQqKNVwdfdxiCkQO+Usks+Yg9459w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172145; c=relaxed/simple;
	bh=pPYjZvh/LnEhOgPmFmL0Ce6BSwmo87NLlPjtrPgphrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhwLRYTHffsEL1hD6Dxs5vEJD3OK4Ao9xB9C2mnqVck06PkeUrOO7oqOwSiLDeNwKXyOcsiVGx0+rcT9Suct0QzMe5m2FHC5+2U82l77ELrkmxgeka9E9hG8McwbwvIZ/C6U53N6QLpPv18b75HHRH+BhboSUeyapDSKvgMjPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtZk8zsZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172144; x=1783708144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPYjZvh/LnEhOgPmFmL0Ce6BSwmo87NLlPjtrPgphrg=;
  b=LtZk8zsZL5Y2XBswmtlp3HjxsHcq3aRA1Gz6JpJ3VS2RM1wNCDk1j4eU
   WJiCikZm4cJPxDp8vT9h6/RzApEM+73u0ZK/v7WQCLxG10ILfKT0BWImX
   TDcuRDkomCFd8m4/b1BdoliziqGy28aoHQ8dPzm4c0vJvivUxu0t3os6j
   d/vfy5ed5TkJZCI/WgJeyTEGi5g/8hTFkbI1JdFtlS3bS29Kd0fg0PUHq
   LBnNr83ArVEDlH6dXxEJ/1UXWGdYCdxIW2xaRDTgOWNkZKQ1xOr/LZHZC
   pCpuYp8F3OvIk3qVrOu0Z5o83NXExFP/iHMuu35b9JzRdr2YcpMwCIhL9
   A==;
X-CSE-ConnectionGUID: cdeM26iNQ56WP9T3Jmfvvg==
X-CSE-MsgGUID: UFjDi/boQZypDNoUlNprLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077799"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077799"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:03 -0700
X-CSE-ConnectionGUID: bngYDDzhQ/Sd6DinuORS0g==
X-CSE-MsgGUID: 5M8OafKoSA2pAAWI7p+d1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718730"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: add iwl_trans_is_dead() API
Date: Thu, 10 Jul 2025 21:28:25 +0300
Message-Id: <20250710212632.cd89d8013261.I214b7ffbabc393593fb57831d61d1a9ffa318a1e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add iwl_trans_is_dead() function to be called by the op modes instead
of directly checking the trans status bits. This hides the trans
internal implementation details from callers.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ed72199c0b21..2879be4b8fcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3186,7 +3186,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	}
 
 	/* there's no point in fw dump if the bus is dead */
-	if (test_bit(STATUS_TRANS_DEAD, &fwrt->trans->status)) {
+	if (iwl_trans_is_dead(fwrt->trans)) {
 		IWL_ERR(fwrt, "Skip fw error dump since bus is dead\n");
 		goto out;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 2dff87c07512..6d983fe2ee44 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1545,7 +1545,7 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 		if (!IS_ERR(op_mode))
 			return op_mode;
 
-		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
+		if (iwl_trans_is_dead(drv->trans))
 			break;
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 200a8d5d5bb6..d0e658801c2e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1240,6 +1240,11 @@ static inline bool iwl_trans_device_enabled(struct iwl_trans *trans)
 	return test_bit(STATUS_DEVICE_ENABLED, &trans->status);
 }
 
+static inline bool iwl_trans_is_dead(struct iwl_trans *trans)
+{
+	return test_bit(STATUS_TRANS_DEAD, &trans->status);
+}
+
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 7ade5b714457..12682396bdc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -630,7 +630,7 @@ iwl_mld_nic_error(struct iwl_op_mode *op_mode,
 		  enum iwl_fw_error_type type)
 {
 	struct iwl_mld *mld = IWL_OP_MODE_GET_MLD(op_mode);
-	bool trans_dead = test_bit(STATUS_TRANS_DEAD, &mld->trans->status);
+	bool trans_dead = iwl_trans_is_dead(mld->trans);
 
 	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
 		IWL_ERR(mld, "Command queue full!\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7dfae8b1a43e..eb1b2f182be5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2053,7 +2053,7 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode,
 
 	if (type == IWL_ERR_TYPE_CMD_QUEUE_FULL)
 		IWL_ERR(mvm, "Command queue full!\n");
-	else if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
+	else if (!iwl_trans_is_dead(mvm->trans) &&
 		 !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 				     &mvm->status))
 		iwl_mvm_dump_nic_error_log(mvm);
-- 
2.34.1


