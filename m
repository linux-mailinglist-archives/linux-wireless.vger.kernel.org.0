Return-Path: <linux-wireless+bounces-4883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888C87F910
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB161F22930
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE653E04;
	Tue, 19 Mar 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxw2KzYi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220F7BAEC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835849; cv=none; b=TIK3+5Ew6z+z2FkpHF5MEYKFi/6jNPQ4lCOqXUYCLRxfFFNLDenqLWKqGxPWgmleXmEs4ujWBFuTFiqYSf7PRUtwiFBxUrzYtnwbgcf8/oHaJArmp1QlRl9ZH6NvPc40rgqyv5DqmNa5pADb7DOWYVBL3Ujuklq+Uoa5ewYwroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835849; c=relaxed/simple;
	bh=q3n+1doiYi6JrYz6c5Y//4gOdiF+Dlfl8zoEM3UHUDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPnFplk5kGG93xGK5Y45ljiI/3mlG0kCK7zZ3QQXqXfyhf/CN+5oy3N9Z7puabk8Fp9JZ2FQ9lavK2brPtRsxENpoUEP4BSgFz4wgTJuRoFSRhulWV0sa/ao/mzjzdZTi4VY3Q0s87DgmbPgQbKmUR2XecSCdz4OKXTNQw/a7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxw2KzYi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835847; x=1742371847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3n+1doiYi6JrYz6c5Y//4gOdiF+Dlfl8zoEM3UHUDI=;
  b=hxw2KzYi/IqfeLZukq5rgxRgEuvdK3GcvGl7ZVEtNHEhFH8B9P26hXcH
   udBEA+liqzFGYfE35JkaJ4z7B5BG1HNzP6jiQR9CLGmn9kkPTDx8D2gjf
   LPVYWxtx3vhym5f6Gq95NNo06XpvmbuLXifKolTdHljEtDxdH6xQg/Qhz
   dOqn4izmSx1prk5a5s/zbJV1SVYyz1/0wR+JbSnvcsRcsHiSPz1P59S0L
   2flAzMd1sOSjVTQ+xjAknO2JyHy3f9hqvRcNLZ6Ic0fL+x8O+xMDeYmEW
   v/iTav0xbrLX46FgrUpMe92mlaXWw/FxPff9uzl7A+bmy34765VDhSu6K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810524"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810524"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447576"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging request
Date: Tue, 19 Mar 2024 10:10:15 +0200
Message-Id: <20240319100755.8523150148ec.I7ab6c547513717e69ec385f72a8f43ea00bd9e0a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add an option to force sending unprotected ranging request even if the
station is associated to the responder or a PASN keys are configured.
This is used for testing.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c    |  2 ++
 .../wireless/intel/iwlwifi/mvm/ftm-initiator.c  | 17 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 3d272b3bed4e..5485e8bf613e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -793,6 +793,8 @@ void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	MVM_DEBUGFS_ADD_FILE_VIF(rx_phyinfo, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(quota_min, mvmvif->dbgfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE_VIF(os_device_timediff, mvmvif->dbgfs_dir, 0400);
+	debugfs_create_bool("ftm_unprotected", 0200, mvmvif->dbgfs_dir,
+			    &mvmvif->ftm_unprotected);
 	MVM_DEBUGFS_ADD_FILE_VIF(int_mlo_scan, mvmvif->dbgfs_dir, 0200);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 4863a3c74640..c9000c878005 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -551,6 +551,15 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			break;
 		}
 		rcu_read_unlock();
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+		if (mvmvif->ftm_unprotected) {
+			target->sta_id = IWL_MVM_INVALID_STA;
+			target->initiator_ap_flags &=
+				~cpu_to_le32(IWL_INITIATOR_AP_FLAGS_PMF);
+		}
+
+#endif
 	} else {
 		target->sta_id = IWL_MVM_INVALID_STA;
 	}
@@ -713,6 +722,12 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_ftm_pasn_entry *entry;
 	u32 flags = le32_to_cpu(target->initiator_ap_flags);
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (mvmvif->ftm_unprotected)
+		return;
+#endif
 
 	if (!(flags & (IWL_INITIATOR_AP_FLAGS_NON_TB |
 		       IWL_INITIATOR_AP_FLAGS_TB)))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3f6fd6fef7cf..8134a5907908 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -437,6 +437,7 @@ struct iwl_mvm_vif {
 	struct iwl_dbgfs_bf dbgfs_bf;
 	struct iwl_mac_power_cmd mac_pwr_cmd;
 	int dbgfs_quota_min;
+	bool ftm_unprotected;
 #endif
 
 	/* FW identified misbehaving AP */
-- 
2.34.1


