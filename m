Return-Path: <linux-wireless+bounces-18520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62660A28AF8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E3B188207F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A1B640;
	Wed,  5 Feb 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuunZf6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDABA38
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760171; cv=none; b=aiu2fav/aJ/h5uD0G1btGdMtMVHFQwnbcnl/eu6dLCiQOAdnzEnlXNVjbG14XhCYnHUo3abTxq3ZjgEd5aQlBw1TFy5KwLfYiOux4C8/t1LD69BGXxT3bRbdlPWpBHp870BoH+bqLAz/vi9tAIl2bNc8OHkfgVnT5ib9fXgQqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760171; c=relaxed/simple;
	bh=PQMtECzBX+STUE1gBJ4xwkfAuiLYNUuAnoxPDRAWLVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTc7Q5fRlwl34oaDcFcJOeeKJaqrzyHdjuY+GTqy/ez/fj66SFKp/5VFdjw0dTGHe9gFx9Lo37y81ptLOYNgSvpAk+ydvQzHS4HaOUeLWeVuvzWiUGcsD3JirArj6Ov3pSfml9eJyOQw6Zfd9G87+oq1rYSF4VS0CuuH/nDKY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuunZf6g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760166; x=1770296166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQMtECzBX+STUE1gBJ4xwkfAuiLYNUuAnoxPDRAWLVg=;
  b=XuunZf6gs3DGgGHVmw+Vfkx61D8nJdFzTa9v46h9CGZSR6kZDx9OIkeB
   T5vYxbqHRAPrmLjnO32KiEbFTB7iYPnE9vMgVXgI8VHcBvhYFEYLpSxjn
   0z7RIjoQocJaBXyksISvVFn+k6OzO0mMFHITbKqyWkrdqXo3lX7xb7+7W
   jp6C8Bx4QvutMwuegAnlX5Tw8k6zhr4c1TO1c2pBweHak9DQUYGKHfZcD
   L+Yeg7+/O9ub0cCvVxObbciO4rru1nx+jt5wm9SOWbTi6r+x0eaEjB06K
   SGC6Ov7kg0wP37tb9WxG+kHrS18pVWqPZl0DdFfo73fZn3S7BibWoa3yE
   A==;
X-CSE-ConnectionGUID: DI3/TkdwRgWqmX0BLc8+zg==
X-CSE-MsgGUID: jX5QoyJuQt+XoR1nTEjDTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159158"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159158"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:05 -0800
X-CSE-ConnectionGUID: RvM0Uh2GSQmbfcg99fqdHA==
X-CSE-MsgGUID: CyLOYeo2T2infnTPuU6eYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745413"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/19] wifi: iwlwifi: remove the mvm prefix from iwl_mvm_ctdp_cmd
Date: Wed,  5 Feb 2025 14:55:30 +0200
Message-Id: <20250205145347.cf71225a764c.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This command is not specific to iwlmvm.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c     |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index c73d4d597857..1dce28f3afa0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -19,7 +19,7 @@ enum iwl_phy_ops_subcmd_ids {
 	CMD_DTS_MEASUREMENT_TRIGGER_WIDE = 0x0,
 
 	/**
-	 * @CTDP_CONFIG_CMD: &struct iwl_mvm_ctdp_cmd
+	 * @CTDP_CONFIG_CMD: &struct iwl_ctdp_cmd
 	 */
 	CTDP_CONFIG_CMD = 0x03,
 
@@ -195,25 +195,25 @@ struct ct_kill_notif {
 } __packed; /* CT_KILL_NOTIFICATION_API_S_VER_1, CT_KILL_NOTIFICATION_API_S_VER_2 */
 
 /**
-* enum iwl_mvm_ctdp_cmd_operation - CTDP command operations
+* enum iwl_ctdp_cmd_operation - CTDP command operations
 * @CTDP_CMD_OPERATION_START: update the current budget
 * @CTDP_CMD_OPERATION_STOP: stop ctdp
 * @CTDP_CMD_OPERATION_REPORT: get the average budget
 */
-enum iwl_mvm_ctdp_cmd_operation {
+enum iwl_ctdp_cmd_operation {
 	CTDP_CMD_OPERATION_START	= 0x1,
 	CTDP_CMD_OPERATION_STOP		= 0x2,
 	CTDP_CMD_OPERATION_REPORT	= 0x4,
 };/* CTDP_CMD_OPERATION_TYPE_E */
 
 /**
- * struct iwl_mvm_ctdp_cmd - track and manage the FW power consumption budget
+ * struct iwl_ctdp_cmd - track and manage the FW power consumption budget
  *
- * @operation: see &enum iwl_mvm_ctdp_cmd_operation
+ * @operation: see &enum iwl_ctdp_cmd_operation
  * @budget: the budget in milliwatt
  * @window_size: defined in API but not used
  */
-struct iwl_mvm_ctdp_cmd {
+struct iwl_ctdp_cmd {
 	__le32 operation;
 	__le32 budget;
 	__le32 window_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index d92470960b38..256f8f558b15 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -506,7 +506,7 @@ static const u32 iwl_mvm_cdev_budgets[] = {
 
 int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 state)
 {
-	struct iwl_mvm_ctdp_cmd cmd = {
+	struct iwl_ctdp_cmd cmd = {
 		.operation = cpu_to_le32(op),
 		.budget = cpu_to_le32(iwl_mvm_cdev_budgets[state]),
 		.window_size = 0,
-- 
2.34.1


