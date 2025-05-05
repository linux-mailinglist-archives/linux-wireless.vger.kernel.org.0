Return-Path: <linux-wireless+bounces-22467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E23AA9C12
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F2B17D542
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A521AAE28;
	Mon,  5 May 2025 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxTQseZm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033626FA76
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471437; cv=none; b=DXphGiTVpooK6/xDhzCn3o8jUiVfiJP+gTSQPJZ+p7rzpafYm2UoSBpUn9ygpzUDOAp+TaIWDjyZzIH2ptueDkXxaXmsA89RBG051zsM8XM42SCQmtatds5QZ3iUjyC/CHnpkb0L3/N0tiEC6eIX2hWgqFcLdEjN7Kn6rMt7piI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471437; c=relaxed/simple;
	bh=HrAsVRxjNIajGFFUhHEFWctptyZKfJf0XXv8SVSQDeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cST24N9Q6xPaY+8WyI8cIQtVkP/D6uWhUEiIDDiGE0bVvzpEZxVdU6hg/ddAe2W6GsWBnRaXLuB62F0dQEWdwn698U6bE44287kWxAP51Akxc/9XRoJgrEMzxH2xI64JGfR2Ik+n96WQmuZeG+szZqyRSO/Wy5Gd03aq5tbqNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxTQseZm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471435; x=1778007435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HrAsVRxjNIajGFFUhHEFWctptyZKfJf0XXv8SVSQDeI=;
  b=VxTQseZmI09Qz+xGpKuEEkWGQKPDS/S9FhS0p2zUx1MZkmwLaKoPb5aY
   ARz26W0k9tDKgvXeOdrfZop1VOUrx5PCa90QIj+dRYfQ0e9jKpeipOd7d
   rMH//xMnNzdBSFOkYmKsXd24Lg7nPrM2fg1L4Xgc52dJukvVigVUAZwKQ
   IFOk3xRcFVekx88ZHmKvn5xphHsBC9zeXnX2XFV/7Zo7PrsKOUrjpawUp
   fBtcgP5LenylbSeZHne3YidEC7aYk6HWC6GokRbzffMLOOi7nGTMq2215
   GCESImTcrZWmRNrF4pcSvW4cZ9mI4CpfrhLghWeWJwA6Lcfst6ofLNR7P
   w==;
X-CSE-ConnectionGUID: 6iHO8lQ5SZ23MhgSoSNhcw==
X-CSE-MsgGUID: FqT3/3pMRaKGnZFUwBMDrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359439"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:14 -0700
X-CSE-ConnectionGUID: MVjDq7v7TTOHOBVyMOZ0fw==
X-CSE-MsgGUID: iHo3QtduSCKI1JaCTZf6qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697944"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: pcie: log async commands
Date: Mon,  5 May 2025 21:56:43 +0300
Message-Id: <20250505215512.cc4457285889.I633fae8828e8a37bbebc578166f388dcf893f592@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Currently, there are two log messages at INFO level for
synchronous commands:

    Attempting to send sync command ...
    Setting HCMD_ACTIVE for command ...

and unfortunately none at all for async ones. Add one
for async commands as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 632d147f7921..c876912e9aaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2549,10 +2549,10 @@ void iwl_pcie_freeze_txq_timer(struct iwl_trans *trans,
 #define HOST_COMPLETE_TIMEOUT	(2 * HZ)
 
 static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
-					 struct iwl_host_cmd *cmd)
+					 struct iwl_host_cmd *cmd,
+					 const char *cmd_str)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
 	struct iwl_txq *txq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
 	int cmd_idx;
 	int ret;
@@ -2646,6 +2646,8 @@ static int iwl_trans_pcie_send_hcmd_sync(struct iwl_trans *trans,
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 			     struct iwl_host_cmd *cmd)
 {
+	const char *cmd_str = iwl_get_cmd_string(trans, cmd->id);
+
 	/* Make sure the NIC is still alive in the bus */
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
 		return -ENODEV;
@@ -2660,6 +2662,8 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 	if (cmd->flags & CMD_ASYNC) {
 		int ret;
 
+		IWL_DEBUG_INFO(trans, "Sending async command %s\n", cmd_str);
+
 		/* An asynchronous command can not expect an SKB to be set. */
 		if (WARN_ON(cmd->flags & CMD_WANT_SKB))
 			return -EINVAL;
@@ -2678,5 +2682,5 @@ int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
 		return 0;
 	}
 
-	return iwl_trans_pcie_send_hcmd_sync(trans, cmd);
+	return iwl_trans_pcie_send_hcmd_sync(trans, cmd, cmd_str);
 }
-- 
2.34.1


