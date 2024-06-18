Return-Path: <linux-wireless+bounces-9210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF890D9BA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D01F24CA4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86F148310;
	Tue, 18 Jun 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkm/BlMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7DB1442F5
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729078; cv=none; b=javVL51W5mUEm7vHi9DU9Kn+qNMPGE9nQQcFQNkLUH7b16GDsXvMF8Hi88gWGyrmcwE4ifPj+5GVCJdAGV/gmuHKORrmDE4a72/S0cCo89JjIxgCTaVNZGCeazUXAk5jdqBlURIa2RimFQMBaHfMfmM1WZ9sIG0KRF/y2gizE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729078; c=relaxed/simple;
	bh=2up0Q3kEQHzPVrv2A85hasp0oaLoqxXGHnteVvqcPkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngPtSN0SlSA0zs/poOttcHiaUq3gKe+UO0kCNzmxMpe26g/qzeeMfNvpbb6ChunX9AqJW7krZE7iw2Y+NJXQHIQ2RtXAM6miKrQ0RSxycjEKTCgUoqdIvDrnwb+D4z3P97cEno3+LkLbp46NrMMZQHkPQC3pB+8Mw9rXJ3qygmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkm/BlMq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729077; x=1750265077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2up0Q3kEQHzPVrv2A85hasp0oaLoqxXGHnteVvqcPkY=;
  b=mkm/BlMqPme1iNHUchoKuUGHQp0EDkK953KKMjUGDkXY2fjP6vsgey69
   Z2CdrZW47rAsR0FLJODgbG9MuKGtQ04qSHpwheKO4rQyhwsqYjM5UpeqF
   h1dh796AwEOoRjBLuriT6nhdl/PQZeo12pIDyVzv1CKVUBHSbbTOMXB/W
   DBGtyts2tAcHnB+GNrRoc3I8BNTZAbmdKCVhIiz2IzD69t0BWFJCWjNXI
   TGwffDuSd08fdVl/W1SSCNqGGvhdlJxJtmJ9m0GFRhxfDgDc+0oepiTO4
   Jd4XRCHpYYwPIL7euYDHz8eFUdy73Zuy4PeczgsEOcK4uMZuAHUOasyHZ
   w==;
X-CSE-ConnectionGUID: Bih+ouepRfGzrXJ8rCNbnA==
X-CSE-MsgGUID: ckkpVa+sQ06dNi5zhFn+1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257206"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257206"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:37 -0700
X-CSE-ConnectionGUID: BNWkEw3bRaaoVdOI0vhWNQ==
X-CSE-MsgGUID: c9pEMOZZQzm7OQu5Xmd9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306543"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: mvm: rename 'pldr_sync'
Date: Tue, 18 Jun 2024 19:44:11 +0300
Message-Id: <20240618194245.ccf849642af8.I01dded6b2393771b7baf8b4b17336784d987c7c2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

PLDR (product level device reset) is a Windows term, and
is something the driver triggers there, AFAICT.

Really what 'pldr_sync' here wants to capture is whether
or not the firmware will/may do a product reset during
initialization, which makes the device drop off the bus,
requiring a rescan. If this is the case, obviously the
init will fail/time out, so we don't want to report all
kinds of errors etc., hence this tracking variable.

Rename it to 'fw_product_reset' to capture the meaning
better.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  7 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 36ed08f20f80..0a8bd957bd6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -408,7 +408,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 						UREG_LMAC2_CURRENT_PC));
 		}
 
-		if (ret == -ETIMEDOUT && !mvm->pldr_sync)
+		if (ret == -ETIMEDOUT && !mvm->fw_product_reset)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
 
@@ -627,8 +627,8 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 	if (mvm->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
 		sb_cfg = iwl_read_umac_prph(mvm->trans, SB_MODIFY_CFG_FLAG);
 		/* if needed, we'll reset this on our way out later */
-		mvm->pldr_sync = sb_cfg == SB_CFG_RESIDES_IN_ROM;
-		if (mvm->pldr_sync && iwl_mei_pldr_req())
+		mvm->fw_product_reset = sb_cfg == SB_CFG_RESIDES_IN_ROM;
+		if (mvm->fw_product_reset && iwl_mei_pldr_req())
 			return -EBUSY;
 	}
 
@@ -647,7 +647,7 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
 
 		/* if we needed reset then fail here, but notify and remove */
-		if (mvm->pldr_sync) {
+		if (mvm->fw_product_reset) {
 			iwl_mei_alive_notif(false);
 			iwl_trans_pcie_remove(mvm->trans, true);
 		}
@@ -1407,14 +1407,14 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	ret = iwl_mvm_load_rt_fw(mvm);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to start RT ucode: %d\n", ret);
-		if (ret != -ERFKILL && !mvm->pldr_sync)
+		if (ret != -ERFKILL && !mvm->fw_product_reset)
 			iwl_fw_dbg_error_collect(&mvm->fwrt,
 						 FW_DBG_TRIGGER_DRIVER);
 		goto error;
 	}
 
 	/* FW loaded successfully */
-	mvm->pldr_sync = false;
+	mvm->fw_product_reset = false;
 
 	iwl_fw_disable_dbg_asserts(&mvm->fwrt);
 	iwl_get_shared_mem_conf(&mvm->fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a57f4738a8c8..4c027cf68a2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1325,7 +1325,12 @@ struct iwl_mvm {
 	bool sta_remove_requires_queue_remove;
 	bool mld_api_is_used;
 
-	bool pldr_sync;
+	/*
+	 * Indicates that firmware will do a product reset (and then
+	 * therefore fail to load) when we start it (due to OTP burn),
+	 * if so don't dump errors etc. since this is expected.
+	 */
+	bool fw_product_reset;
 
 	struct iwl_time_sync_data time_sync;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f8a4fefede8d..008fe5fece87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -875,7 +875,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
 
 	/* no longer need this regardless of failure or not */
-	mvm->pldr_sync = false;
+	mvm->fw_product_reset = false;
 
 	return ret;
 }
-- 
2.34.1


