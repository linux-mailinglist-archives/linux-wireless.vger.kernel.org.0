Return-Path: <linux-wireless+bounces-25197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3EDB00959
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA167ABF45
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094762F0E54;
	Thu, 10 Jul 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tkk1WlIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227082F0E3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166523; cv=none; b=czv7nBcAkYVYI6DhWs8g0+d2T8BCcCojxpfHIuwT1R+6U7knikO5E0IQzvFttcwBCJ74rsiWrDPSfFCGjEw0uJjwZi0ahtb3tc6Fau+qd7/FTSgS3MNLtk0Jr/mC5mKJO4PCncgU8iZmjHpdIbrzTeUNvioaAD69ay5laGAlCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166523; c=relaxed/simple;
	bh=pPYjZvh/LnEhOgPmFmL0Ce6BSwmo87NLlPjtrPgphrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTXwxNmqn6ax3AIhXY6ZQb0bZkvBRnK/abYMfRsr4+x+YmycY/GOxK2/P/r1GTNjBQZd89auPU2c0JYdFK3v7VzcRlQXgX6fgL1YXclgeVdzkVDI2N9RsKm+UbPjIEbOK4+HlKdvtomhH/X0jHwuKyy/ZVwPZV0hj++MlMuZqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tkk1WlIt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166522; x=1783702522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPYjZvh/LnEhOgPmFmL0Ce6BSwmo87NLlPjtrPgphrg=;
  b=Tkk1WlItwrquRbZBaHgoVi0tZ3t5sDbr+zQ3HqzZYOPJho4n0h/TOtB4
   WyXGt1F+gp8vvJZ4IU+rAoepGX2HjAFzRe497pPTaMK9O9YkK9BriwRdM
   nXeBOOk+ck4wXk22E+YhViDFO07xoYmhD4PVsk9zavGPX5lnMvpF+bhcU
   Ljl4lWoyMt7UwK/EcqQ9CUNE1uQsb2A7vZTL0po43X1beq3vR1AqCpbei
   bE5Cb8OBj9o5KQ6RWK9+aReazQIT1iCJrKp0+XL0lUW5D+5lbJmBKXI37
   MzoW26vgNSh4cvBEV2b26OBN+I4uwGxh6pGO4cH1tCAK/gZVqzHzxGkCZ
   A==;
X-CSE-ConnectionGUID: T2FwtHd4QFyCFdcIpSMDNg==
X-CSE-MsgGUID: 9YpI//81RiC8lwCU1vz1Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610009"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610009"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:19 -0700
X-CSE-ConnectionGUID: i8b7TXO1Q22/NIPqjzvezw==
X-CSE-MsgGUID: 2By+idWES7SyFObJXTltQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277053"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: iwlwifi: add iwl_trans_is_dead() API
Date: Thu, 10 Jul 2025 19:54:41 +0300
Message-Id: <20250710195219.cd89d8013261.I214b7ffbabc393593fb57831d61d1a9ffa318a1e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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


