Return-Path: <linux-wireless+bounces-22683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A0AACE40
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63398984A1A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66752153E4;
	Tue,  6 May 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQkVGo3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83921579F
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560489; cv=none; b=hwU9cl9wmX5WGR4iEVrlODmArEQLo2AZQgnyze+kux3g15IYg5oVGyP80D6jn66vaMVf1q4qQvphZnAi0HRM+mxIV0Uy+/G9brYTetULfeTtC19sH+KCdFtoXjEBsL1q5CTIA6/ifUMy83XVtC4n2PwASYp+PPype3UX/GDYXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560489; c=relaxed/simple;
	bh=VEvOK1CdkhwEVDxmAEjfBLl66MpOe4ARXMlZ5Rs4BK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlSYvaPq2Cor2teoAsUgTmCbA9RHgBAGmdecs5iurBPlzknAt7+vstX8789qHAY9aR6ilM/H7Ihd5rgdUTN4OfeiJl+MiWoCBd1KCiEHeqY3tSlO1IY8xUXMNFh0PfVm9VvSO+yZ7PV+DYFODSfEjwwyWwreWGxEeC7RZYEdCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQkVGo3X; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560488; x=1778096488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEvOK1CdkhwEVDxmAEjfBLl66MpOe4ARXMlZ5Rs4BK4=;
  b=WQkVGo3XFwKGdpj0CHpeP2AVCCJqyqEX6kMVUtxlO0JdJWIlbeKOY1Qp
   ZUl+mbQykTLQjVujjrgIl+bdFR9Z+0GlDPwyqD6tfI/lXBGgdpVot21Y4
   04JXxHENQIuvX7axFsQR9zjvhq6k/g4eT9pKjQBWuYdpGk2rGRa0ys4F4
   Q4V06tKYOfutviFCwFc0jHmlKefJMBsYYj/4CEMWM0kxw7v1mC9HrMzLd
   sT9X1l/efNNJefekkGA1NLNQF4+libOBNAGKr35NeLSc3V9WIQe8J1PUS
   RW6GYZcPqljaytPj9En4gyBWg91GJOSTbg9ICzgnqgoj0QDvqVG9Ygsek
   Q==;
X-CSE-ConnectionGUID: AHbd33KtQ9q9l7z15TIcMg==
X-CSE-MsgGUID: gWhFVB+RQ7G0cYEihVH8Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961653"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:28 -0700
X-CSE-ConnectionGUID: zVzJffcCSZupxF2j3H1Dog==
X-CSE-MsgGUID: P6cSu614QbOJAw86ZURFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465472"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: use a radio/system specific power budget
Date: Tue,  6 May 2025 22:40:55 +0300
Message-Id: <20250506194102.3407967-9-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Different hardware has a different maximum power consumption and the
BIOS can also define a power limit for the device. Add code to select
an appropriate maximum power budget for the device and configure that
instead of using a hardcoded table.

This removes the old table. It does not work with the variable upper
limit and the there should be no consumer that requires these exact step
values.

This considerably increases the power budget for some devices and can
prevent throttling in high traffic situations.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Message-Id: <20250506223834.bbabf051c21b.Ie1b84408a4f147cf1bc2a1256a84aff18fcee366@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 89 +++++++++++++-------
 2 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cb2f6e2ae9bf..75e7e0a69624 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -664,6 +664,8 @@ enum iwl_mvm_sched_scan_pass_all_states {
  * @min_backoff: The minimal tx backoff due to power restrictions
  * @params: Parameters to configure the thermal throttling algorithm.
  * @throttle: Is thermal throttling is active?
+ * @power_budget_mw: maximum cTDP power budget as defined for this system and
+ *	device
  */
 struct iwl_mvm_tt_mgmt {
 	struct delayed_work ct_kill_exit;
@@ -672,6 +674,8 @@ struct iwl_mvm_tt_mgmt {
 	u32 min_backoff;
 	struct iwl_tt_params params;
 	bool throttle;
+
+	u32 power_budget_mw;
 };
 
 #ifdef CONFIG_THERMAL
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index ed2f79abb82b..53bab21ebae2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2019-2022, 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2022, 2024-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -8,6 +8,9 @@
 
 #include "mvm.h"
 
+#define IWL_MVM_NUM_CTDP_STEPS		20
+#define IWL_MVM_MIN_CTDP_BUDGET_MW	150
+
 #define IWL_MVM_TEMP_NOTIF_WAIT_TIMEOUT	HZ
 
 void iwl_mvm_enter_ctkill(struct iwl_mvm *mvm)
@@ -479,43 +482,28 @@ static const struct iwl_tt_params iwl_mvm_default_tt_params = {
 	.support_tx_backoff = true,
 };
 
-/* budget in mWatt */
-static const u32 iwl_mvm_cdev_budgets[] = {
-	2400,	/* cooling state 0 */
-	2000,	/* cooling state 1 */
-	1800,	/* cooling state 2 */
-	1600,	/* cooling state 3 */
-	1400,	/* cooling state 4 */
-	1200,	/* cooling state 5 */
-	1000,	/* cooling state 6 */
-	900,	/* cooling state 7 */
-	800,	/* cooling state 8 */
-	700,	/* cooling state 9 */
-	650,	/* cooling state 10 */
-	600,	/* cooling state 11 */
-	550,	/* cooling state 12 */
-	500,	/* cooling state 13 */
-	450,	/* cooling state 14 */
-	400,	/* cooling state 15 */
-	350,	/* cooling state 16 */
-	300,	/* cooling state 17 */
-	250,	/* cooling state 18 */
-	200,	/* cooling state 19 */
-	150,	/* cooling state 20 */
-};
-
 int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 state)
 {
 	struct iwl_ctdp_cmd cmd = {
 		.operation = cpu_to_le32(op),
-		.budget = cpu_to_le32(iwl_mvm_cdev_budgets[state]),
 		.window_size = 0,
 	};
+	u32 budget;
 	int ret;
 	u32 status;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	/* Do a linear scale from IWL_MVM_MIN_CTDP_BUDGET_MW to the configured
+	 * maximum in the predefined number of steps.
+	 */
+	budget = ((mvm->thermal_throttle.power_budget_mw -
+		   IWL_MVM_MIN_CTDP_BUDGET_MW) *
+		  (IWL_MVM_NUM_CTDP_STEPS - 1 - state)) /
+		 (IWL_MVM_NUM_CTDP_STEPS - 1) +
+		 IWL_MVM_MIN_CTDP_BUDGET_MW;
+	cmd.budget = cpu_to_le32(budget);
+
 	status = 0;
 	ret = iwl_mvm_send_cmd_pdu_status(mvm, WIDE_ID(PHY_OPS_GROUP,
 						       CTDP_CONFIG_CMD),
@@ -707,7 +695,7 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 static int iwl_mvm_tcool_get_max_state(struct thermal_cooling_device *cdev,
 				       unsigned long *state)
 {
-	*state = ARRAY_SIZE(iwl_mvm_cdev_budgets) - 1;
+	*state = IWL_MVM_NUM_CTDP_STEPS - 1;
 
 	return 0;
 }
@@ -733,7 +721,7 @@ static int iwl_mvm_tcool_set_cur_state(struct thermal_cooling_device *cdev,
 	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR)
 		return -EIO;
 
-	if (new_state >= ARRAY_SIZE(iwl_mvm_cdev_budgets))
+	if (new_state >= IWL_MVM_NUM_CTDP_STEPS)
 		return -EINVAL;
 
 	return iwl_mvm_ctdp_command(mvm, CTDP_CMD_OPERATION_START,
@@ -794,6 +782,47 @@ static void iwl_mvm_cooling_device_unregister(struct iwl_mvm *mvm)
 }
 #endif /* CONFIG_THERMAL */
 
+static u32 iwl_mvm_ctdp_get_max_budget(struct iwl_mvm *mvm)
+{
+	u64 bios_power_budget = 0;
+	u32 default_power_budget;
+
+	switch (CSR_HW_RFID_TYPE(mvm->trans->info.hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_JF2:
+	case IWL_CFG_RF_TYPE_JF1:
+		default_power_budget = 2000;
+		break;
+	case IWL_CFG_RF_TYPE_HR2:
+	case IWL_CFG_RF_TYPE_HR1:
+		default_power_budget = 2400;
+		break;
+	case IWL_CFG_RF_TYPE_GF:
+		/* dual-radio devices have a higher budget */
+		if (CSR_HW_RFID_IS_CDB(mvm->trans->info.hw_rf_id))
+			default_power_budget = 5200;
+		else
+			default_power_budget = 2880;
+		break;
+	case IWL_CFG_RF_TYPE_FM:
+		default_power_budget = 3450;
+		break;
+	default:
+		default_power_budget = 5550;
+		break;
+	}
+
+	iwl_bios_get_pwr_limit(&mvm->fwrt, &bios_power_budget);
+
+	/* 32bit in UEFI, 16bit in ACPI; use BIOS value if it is in range */
+	if (bios_power_budget &&
+	    bios_power_budget != 0xffff && bios_power_budget != 0xffffffff &&
+	    bios_power_budget >= IWL_MVM_MIN_CTDP_BUDGET_MW &&
+	    bios_power_budget <= default_power_budget)
+		return (u32)bios_power_budget;
+
+	return default_power_budget;
+}
+
 void iwl_mvm_thermal_initialize(struct iwl_mvm *mvm, u32 min_backoff)
 {
 	struct iwl_mvm_tt_mgmt *tt = &mvm->thermal_throttle;
@@ -805,6 +834,8 @@ void iwl_mvm_thermal_initialize(struct iwl_mvm *mvm, u32 min_backoff)
 	else
 		tt->params = iwl_mvm_default_tt_params;
 
+	tt->power_budget_mw = iwl_mvm_ctdp_get_max_budget(mvm);
+	IWL_DEBUG_TEMP(mvm, "cTDP power budget: %d mW\n", tt->power_budget_mw);
 	tt->throttle = false;
 	tt->dynamic_smps = false;
 	tt->min_backoff = min_backoff;
-- 
2.34.1


