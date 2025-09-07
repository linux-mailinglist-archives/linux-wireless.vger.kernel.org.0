Return-Path: <linux-wireless+bounces-27048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3470B4799C
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BD417B401
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFA21B9FD;
	Sun,  7 Sep 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PauEy5Mn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943E1C84A6
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233855; cv=none; b=IPE3UUZ6gvWQ+RVPTA5mDowHFYEAvt5jxjYK1z1SPR8ndgd0MB1hIrxkLr7DPlfRpYvZpErVCK2Ul0to5iw+xXmMVbro4O2sp7/I039w3EBQDllPttaNDOLSglh4mMtc4YOHBQE51rN+VkZiIjeVXnLQZNGAp8XvrDOTZkaunVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233855; c=relaxed/simple;
	bh=7Evz+ny2QIoXFXpRrBgQdSRP15ZA0Rq8ekvCtpojYJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyZAjb2mrywz5bHOvFwqK5/3X4pu0lpA7/kMpWhTRYB/fDx+3TR8DMTOkmjixo1mfyANR/QpD2kFGx3egQ7LoJsGMNJZTBTJZUT/oSZrsljL8CYfegHgkpRY5e2w49V3yG1wSA+Qm2p1gMfeHtb7wEvj/WObHTNGWUoEnVkbFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PauEy5Mn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233853; x=1788769853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Evz+ny2QIoXFXpRrBgQdSRP15ZA0Rq8ekvCtpojYJU=;
  b=PauEy5MnzaT7AHOGU3LyEclUPCabwVpM2CmSn+wrWSyEd9eu5h18j1Ip
   wyfCWX+TXJosyRzr6xV9wzXbqlstYJtJ73BpZdCtPIu36ptEa3GhM60at
   9um+hUNnvy90/mayev78t2xZhHlcBvqtVML5vdz0vDJ+uY9Yy3LXjRXKi
   PxjhPfjugoz8fT7MJwO6F6mMUUeBienAqvlxUunNGUuuxUmIzrqvBMKhA
   Q0QE9Kzsb3Atg6v24Au4aiNb58M5QNEBiSkCJPa3j1tKwzqpU7e80d45L
   MhLYDp4wf6UHNrAJFP2MrA/jFWQDI6TbzUd96U/4OWTXkgBh6WvsWmT1r
   g==;
X-CSE-ConnectionGUID: wq/jqJ2gR6SNbIsSJPP0WA==
X-CSE-MsgGUID: l6y0MX7ZQ+mW44sofydf8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973597"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:53 -0700
X-CSE-ConnectionGUID: GKMYOfIIRLOqjcxqi7j63A==
X-CSE-MsgGUID: tNY9arFXTty2TrGRHXEiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790009"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: add STATUS_FW_ERROR API
Date: Sun,  7 Sep 2025 11:30:00 +0300
Message-Id: <20250907112757.23f5160b3265.Iba325ffa4c6c6f7fc3a702fb6c1827b0857d0db3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add iwl_trans_notify_fw_error() and iwl_trans_is_fw_error() for use by
op modes. These helpers provide a clean interface for marking and
checking firmware error state. This hides the trans internal
implementation details from callers.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 14 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  5 ++---
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  2 +-
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 10d016308d77..2ce55859641c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -830,7 +830,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 	}
 
 	/* reading RXF/TXF sizes */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status)) {
+	if (iwl_trans_is_fw_error(fwrt->trans)) {
 		fifo_len = iwl_fw_rxf_len(fwrt, mem_cfg);
 		fifo_len += iwl_fw_txf_len(fwrt, mem_cfg);
 
@@ -3116,7 +3116,7 @@ static void iwl_send_dbg_dump_complete_cmd(struct iwl_fw_runtime *fwrt,
 		.len[0] = sizeof(hcmd_data),
 	};
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (iwl_trans_is_fw_error(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9f09629e2ac5..b9e41b8e2f15 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1209,6 +1209,20 @@ static inline bool iwl_trans_is_dead(struct iwl_trans *trans)
 	return test_bit(STATUS_TRANS_DEAD, &trans->status);
 }
 
+static inline bool iwl_trans_is_fw_error(struct iwl_trans *trans)
+{
+	return test_bit(STATUS_FW_ERROR, &trans->status);
+}
+
+/*
+ * This function notifies the transport layer of firmware error, the recovery
+ * will be handled by the op mode
+ */
+static inline void iwl_trans_notify_fw_error(struct iwl_trans *trans)
+{
+	trans->state = IWL_TRANS_NO_FW;
+	set_bit(STATUS_FW_ERROR, &trans->status);
+}
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 8cd9d61a92e8..f10732d31242 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1213,8 +1213,7 @@ static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
 	ret = iwl_trans_d3_resume(mld->trans, false);
 	if (ret) {
 		/* Avoid sending commands if the FW is dead */
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
+		iwl_trans_notify_fw_error(mld->trans);
 		iwl_remove_notification(&mld->notif_wait, &wait_d3_notif);
 		return ret;
 	}
@@ -1267,8 +1266,7 @@ int iwl_mld_no_wowlan_suspend(struct iwl_mld *mld)
 	if (ret) {
 		IWL_ERR(mld, "d3 suspend: trans_d3_suspend failed %d\n", ret);
 		/* We are going to stop the FW. Avoid sending commands in that flow */
-		mld->trans->state = IWL_TRANS_NO_FW;
-		set_bit(STATUS_FW_ERROR, &mld->trans->status);
+		iwl_trans_notify_fw_error(mld->trans);
 	} else {
 		/* Async notification might send hcmds, which is not allowed in suspend */
 		iwl_mld_cancel_async_notifications(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 38832f5e4068..431504195e33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3102,7 +3102,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm)
 
 	rt_status = iwl_mvm_check_rt_status(mvm, vif);
 	if (rt_status != FW_ALIVE) {
-		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
+		iwl_trans_notify_fw_error(mvm->trans);
 		if (rt_status == FW_ERROR) {
 			IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
 			iwl_mvm_dump_nic_error_log(mvm);
@@ -3272,7 +3272,7 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 
 	rt_status = iwl_mvm_check_rt_status(mvm, NULL);
 	if (rt_status != FW_ALIVE) {
-		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
+		iwl_trans_notify_fw_error(mvm->trans);
 		if (rt_status == FW_ERROR) {
 			IWL_ERR(mvm,
 				"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
@@ -3284,7 +3284,6 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 						&iwl_dump_desc_assert,
 						false, 0);
 		}
-		mvm->trans->state = IWL_TRANS_NO_FW;
 		ret = -ENODEV;
 
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index cda7c51b307c..f281d91475b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -3539,7 +3539,7 @@ iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
 	struct iwl_trans_dump_data *dump_data;
 	u32 len, num_rbs = 0, monitor_len = 0;
 	int i, ptr;
-	bool dump_rbs = test_bit(STATUS_FW_ERROR, &trans->status) &&
+	bool dump_rbs = iwl_trans_is_fw_error(trans) &&
 			!trans->mac_cfg->mq_rx_supported &&
 			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
 
-- 
2.34.1


