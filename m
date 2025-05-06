Return-Path: <linux-wireless+bounces-22684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC4AACE37
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27807B8CE6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618F207E1D;
	Tue,  6 May 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mfg9zMuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AEA217703
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560491; cv=none; b=T+co+k+5OtoJ/J7xAo/GImbGxRJRB/ZKyqv5cb386IwYDG0cQo55Mke2EilOLPf1PMA+PJNVlf0484OmYiCUaJSyy6/AovobVvXpGT/kTYSy0qigVOGNRuAftOmsZm3gDODJo5REz2isj95y/9hZlN4Xy2M9Gslhaeh2RJlwVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560491; c=relaxed/simple;
	bh=3iduYFwju9Ji9wj2agEAcggscUpZ4B44idNCq16wmM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqJ52KvZ7MbhpaVlUmTdgofPTAcAiEX+QjS+ba1tidwAgwKNaWIve/NHWwVXpth9/1D+uOBJzxONzQUjMskStqFLar69ImXtsP/mcH/NGoJAe2OIELa1XNsEzmMS9qCSmPSXuUJBDxO8J+8nba593BPmRaBjpJxbdIsBV+9FxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mfg9zMuQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560490; x=1778096490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3iduYFwju9Ji9wj2agEAcggscUpZ4B44idNCq16wmM0=;
  b=Mfg9zMuQYlw6bKgizEcECMCbub2tyeg1H6P4ejkVAzI4kXoX9vm5VnIf
   cXUFf1nTu5SUZ1NtuHWpV9VYcZk1XJayp0D2PG2hR5QS7MERLEThYMGOv
   tN1UUm07JwVxMtBdpQVPfFtqklLj7nkHXEBtdopf6pxgjJP1X5qIo/aMq
   vt+sW+GPBOOwlaD6SJ7VXHuRu9b+H9dOg3zkZZsbGw4ghmJZCGwG0gMAn
   eW9ns/L0byJbaoR67jPyXy7iIPSSYE0vPJpGhVQsKEcWuG84iszieHzHs
   oVrBxClQSDw3EHUz57vmibQ3H+tyigdGOH04g1tMG35KNJB1BgWBrLEMw
   w==;
X-CSE-ConnectionGUID: 2JtpOWv0TdqktQ8bZKy3og==
X-CSE-MsgGUID: xkB9ESE+SfWJaEKPV1s/YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961657"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961657"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:30 -0700
X-CSE-ConnectionGUID: ni/pGPpbRZGhFOeFGhCcpg==
X-CSE-MsgGUID: veGirpJjRnCnkWiFh5+1Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465480"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: use a radio/system specific power budget
Date: Tue,  6 May 2025 22:40:56 +0300
Message-Id: <20250506194102.3407967-10-miriam.rachel.korenblit@intel.com>
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
Message-Id: <20250506223834.f29cfaab0a18.I060dbadb243f6e613085a9451c42c5ab65d77267@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  4 +
 .../net/wireless/intel/iwlwifi/mld/thermal.c  | 81 ++++++++++++-------
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 0d88463dd678..671f3a709322 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -154,6 +154,8 @@
  * @radio_kill: bitmap of radio kill status
  * @radio_kill.hw: radio is killed by hw switch
  * @radio_kill.ct: radio is killed because the device it too hot
+ * @power_budget_mw: maximum cTDP power budget as defined for this system and
+ *	device
  * @addresses: device MAC addresses.
  * @scan: instance of the scan object
  * @wowlan: WoWLAN support data.
@@ -244,6 +246,8 @@ struct iwl_mld {
 		    ct:1;
 	} radio_kill;
 
+	u32 power_budget_mw;
+
 	struct mac_address addresses[IWL_MLD_MAX_ADDRESSES];
 	struct iwl_mld_scan scan;
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
index f655fc04d949..3232b31f4b0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/thermal.c
@@ -13,6 +13,9 @@
 #include "mld.h"
 #include "hcmd.h"
 
+#define IWL_MLD_NUM_CTDP_STEPS		20
+#define IWL_MLD_MIN_CTDP_BUDGET_MW	150
+
 #define IWL_MLD_CT_KILL_DURATION (5 * HZ)
 
 void iwl_mld_handle_ct_kill_notif(struct iwl_mld *mld,
@@ -272,43 +275,27 @@ static void iwl_mld_thermal_zone_register(struct iwl_mld *mld)
 	}
 }
 
-/* budget in mWatt */
-static const u32 iwl_mld_cdev_budgets[] = {
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
 int iwl_mld_config_ctdp(struct iwl_mld *mld, u32 state,
 			enum iwl_ctdp_cmd_operation op)
 {
 	struct iwl_ctdp_cmd cmd = {
 		.operation = cpu_to_le32(op),
-		.budget = cpu_to_le32(iwl_mld_cdev_budgets[state]),
 		.window_size = 0,
 	};
+	u32 budget;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	/* Do a linear scale from IWL_MLD_MIN_CTDP_BUDGET_MW to the configured
+	 * maximum in the predefined number of steps.
+	 */
+	budget = ((mld->power_budget_mw - IWL_MLD_MIN_CTDP_BUDGET_MW) *
+		  (IWL_MLD_NUM_CTDP_STEPS - 1 - state)) /
+		 (IWL_MLD_NUM_CTDP_STEPS - 1) +
+		 IWL_MLD_MIN_CTDP_BUDGET_MW;
+	cmd.budget = cpu_to_le32(budget);
+
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP, CTDP_CONFIG_CMD),
 				   &cmd);
 
@@ -326,7 +313,7 @@ int iwl_mld_config_ctdp(struct iwl_mld *mld, u32 state,
 static int iwl_mld_tcool_get_max_state(struct thermal_cooling_device *cdev,
 				       unsigned long *state)
 {
-	*state = ARRAY_SIZE(iwl_mld_cdev_budgets) - 1;
+	*state = IWL_MLD_NUM_CTDP_STEPS - 1;
 
 	return 0;
 }
@@ -354,7 +341,7 @@ static int iwl_mld_tcool_set_cur_state(struct thermal_cooling_device *cdev,
 		goto unlock;
 	}
 
-	if (new_state >= ARRAY_SIZE(iwl_mld_cdev_budgets)) {
+	if (new_state >= IWL_MLD_NUM_CTDP_STEPS) {
 		ret = -EINVAL;
 		goto unlock;
 	}
@@ -417,10 +404,48 @@ static void iwl_mld_cooling_device_unregister(struct iwl_mld *mld)
 }
 #endif /* CONFIG_THERMAL */
 
+static u32 iwl_mld_ctdp_get_max_budget(struct iwl_mld *mld)
+{
+	u64 bios_power_budget = 0;
+	u32 default_power_budget;
+
+	switch (CSR_HW_RFID_TYPE(mld->trans->info.hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_GF:
+		/* dual-radio devices have a higher budget */
+		if (CSR_HW_RFID_IS_CDB(mld->trans->info.hw_rf_id))
+			default_power_budget = 5200;
+		else
+			default_power_budget = 2880;
+		break;
+	case IWL_CFG_RF_TYPE_FM:
+		default_power_budget = 3450;
+		break;
+	case IWL_CFG_RF_TYPE_WH:
+	case IWL_CFG_RF_TYPE_PE:
+	default:
+		default_power_budget = 5550;
+		break;
+	}
+
+	iwl_bios_get_pwr_limit(&mld->fwrt, &bios_power_budget);
+
+	/* 32bit in UEFI, 16bit in ACPI; use BIOS value if it is in range */
+	if (bios_power_budget &&
+	    bios_power_budget != 0xffff && bios_power_budget != 0xffffffff &&
+	    bios_power_budget >= IWL_MLD_MIN_CTDP_BUDGET_MW &&
+	    bios_power_budget <= default_power_budget)
+		return (u32)bios_power_budget;
+
+	return default_power_budget;
+}
+
 void iwl_mld_thermal_initialize(struct iwl_mld *mld)
 {
 	wiphy_delayed_work_init(&mld->ct_kill_exit_wk, iwl_mld_exit_ctkill);
 
+	mld->power_budget_mw = iwl_mld_ctdp_get_max_budget(mld);
+	IWL_DEBUG_TEMP(mld, "cTDP power budget: %d mW\n", mld->power_budget_mw);
+
 #ifdef CONFIG_THERMAL
 	iwl_mld_cooling_device_register(mld);
 	iwl_mld_thermal_zone_register(mld);
-- 
2.34.1


