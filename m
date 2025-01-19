Return-Path: <linux-wireless+bounces-17716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F9A163AD
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 20:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6975E3A580B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467518C00B;
	Sun, 19 Jan 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gt1xHoKH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F39182D9
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737313414; cv=none; b=kFRUHF8osovfR0NJgpTEPLKHlhREEvGaqBho7YZzXgFwu6qZOWemOUEYzcC5TIvAJN66E5iuKORXPU5br5dG3E3uUobrFbFJl0tjm6+IE2fkDVvOdxqYMDHMrGC1kkOhhUq1HL6KHN6F9tSa4QxahW+vxkb95j5Vh0+MK9R97/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737313414; c=relaxed/simple;
	bh=NBftW3ngaPbzlP43G4dY3tTDwroKA8dLyxFnKbt3ySM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+tKERZdpYpxxnSb7sbxnv2M8Jv96GypexfwRB5EzfIFATHl31swUpgQ7ers8ID+j9w6/gs3A4pOaLnM0UQWdByU2kubtJzYsAuKCzzxSf5cQVY+Jw/cObshwfeQ0+2bfCnevUR4XBHEclHxjR5pI8Ua1F9vwtVCkpBp8CoCRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gt1xHoKH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737313412; x=1768849412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NBftW3ngaPbzlP43G4dY3tTDwroKA8dLyxFnKbt3ySM=;
  b=gt1xHoKHrHPMS4eDFymb0pl6mDDGFa4Mcm3tdXy8ApoGjUVl1qQvw2Qs
   hc2GYBf70mPa+rTZh+L3MUX8GSmWWx7t6Bpw1nqTq0BwfrIomIKxOH94L
   9PPhzBSuHGL+sxCoyBBLLf2+eqWWmN5XA12Ba/SPP0AuzIJoOVY/Rc1RZ
   3o9XsCEdpkv8EjUv/RT2POrXjo8KAOcMXMf4+sZ3fUxvDFHRDHb2bsvh5
   HN/saZrKZpES2SrS7s7+N77V7a1GJSx9pH9Ux4jVJV0SUYtAdSCVSJezv
   h60sG6r/6UG67n0csvHphiT9++0LAFmUiZhRvfN4sYX/x9Edn5xux6Vjd
   w==;
X-CSE-ConnectionGUID: bnEWj3AnTbSYMg1pURDXJA==
X-CSE-MsgGUID: r1nuKvS9QDmBkso+SXojqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37556134"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37556134"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:31 -0800
X-CSE-ConnectionGUID: tzYDFyjOSTyJRobNtl4yTQ==
X-CSE-MsgGUID: ujbfJTDTRZWFOcTx7T89dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106127742"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: remove the mvm prefix from iwl_mvm_ctdp_cmd
Date: Sun, 19 Jan 2025 21:03:13 +0200
Message-Id: <20250119210104.04f3afcf9c77.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
X-Mailer: git-send-email 2.34.1
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
v2: rephrased the commit messgae

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


