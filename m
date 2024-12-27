Return-Path: <linux-wireless+bounces-16827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32969FD1B6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5427118831F0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417B153820;
	Fri, 27 Dec 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yf8Q7mFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875755D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286494; cv=none; b=RSGZwYLK4i0PRJEcqrbrzR3pW/+BmNmFhlTf7t0F/T2YEH9oyqWHFKIWUdT3AgdIESTdUljcgsz0FX8NyvuJ3hF5A5LtOE5qTtmTwgDgqwGK1xNqG+1i3LyflUHBAqKMkX3/qHIvAyazmrvD8OIkYopD7y03zuq1d2a2p6aljls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286494; c=relaxed/simple;
	bh=FDHyEfWbJ0uu8n+b6CacxQZLXu6oyyyLM2DSWEwpRwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Du951pUiSyRgIr2/HyUfVyrRprgU2jcmXi0f2e+PYlzxR3e4Yt6txSL/FiKynr2g3n1qEjOUUtDec9aRoZd9H4ST3JNzkkxA+mHKcUjotbeEs7QPaBjtZ7eDNTT3zrvrtspDlt3W5NBOweMg3CyU/v+IOitoRNz1KjWrrVs+cL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yf8Q7mFA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286492; x=1766822492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FDHyEfWbJ0uu8n+b6CacxQZLXu6oyyyLM2DSWEwpRwA=;
  b=Yf8Q7mFAP5WjCZDL6eAEcyxE7wrVzsZn/5qnlD9e2GnchyhqcWrL23jr
   9+EGq14vJk8CrutUYMirYQFvhhFX1SGKdVglicqzevevw4PxoK5I1/Ptl
   fyGL5e01fmnPEdvBzJvBtqRaANJo7sSeV80LI3N9koNYlGRytRNcN0H53
   W5EtXtHC+yjY3Fa6uA8zddppq7c+Gsc7p7n5OOW8LZq/SgDCj+lvjbL62
   av1gXwE3zL+thOx3c8wvGUhAg/9Ei/IwDxd44GigRtG78FMg0CihmCItX
   D1LgtFJF8Vva5vkulT/Fo/VnNPvH0ITHDfgFK4EDfDcq+Oa78c8WnwY5k
   w==;
X-CSE-ConnectionGUID: +NCh4c9iTBqFWeLPlXxMkA==
X-CSE-MsgGUID: g7KzNbF5SEqvrFpMrh16Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690929"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690929"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:32 -0800
X-CSE-ConnectionGUID: tPYFZY2HQ1qKGPQaftAfGA==
X-CSE-MsgGUID: vALuTFYES+u4pbADJLNwHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858243"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: s/iwl_mvm_ctdp_cmd/iwl_ctdp_cmd/
Date: Fri, 27 Dec 2024 10:01:00 +0200
Message-Id: <20241227095718.2d2cc9910535.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This command is not related to iwlmvm.

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


