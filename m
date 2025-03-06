Return-Path: <linux-wireless+bounces-19952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F389A55956
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F8A16A6FC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436F27C178;
	Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAex0EPB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA527C86D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298725; cv=none; b=RNgJ6VIyMPu+y5qO20ayNbJQjsZu122PKfOmMBiJegcqZ5mVzku24Br2W4TsoBIcpfdCx6VKgnUowHy426ab3kItXQq9+oqqMQxHK7JGSY6M6bVpT31MV6SWTbXefzrXjNDd5R13vMY4x6Hu8+DthiOeW5NZ4Nt8djr2RLP8Yu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298725; c=relaxed/simple;
	bh=Pj0p2paligLz2ZvpOs3SXHK7UYAOvX5cSNksAWAn4lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McPLe6L8+snXcvH9KYHrCMq8gwvQoyTEF5R1F4T+eVID1TD+B1pp2GsIgUiL1xUXbqzW0IgsKGHge8CDwYQ8hk8ZndaHoB81LpQfKPHcHgUN9+ZB9N6h9mKzwNoB5AspMMw6UDnwxjmxWyzfpN5oOe76JR/yTvFsd6xdFZdw56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAex0EPB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298723; x=1772834723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pj0p2paligLz2ZvpOs3SXHK7UYAOvX5cSNksAWAn4lM=;
  b=SAex0EPBYVVP/OKjn5t48DEHLZvcVST36M9droa9oFwEAFX6wBz6E3/Z
   sxvZmJSUHXsAFloML/+k1WGG0lt9GhSKBHaqx4yonHoK/hFvlIHB20VAU
   CHBpnxMgbtS9pnfKQ52hTvIzOW3UyzdVeE13wdOTWg1Qq7ssx+W6dI7CJ
   5G6zMd13/W/J0HnsVobXGShuT+cpDVQ0LybG75s/2DO+ubW50q1uYVK1j
   QxPx/OrI/1UB/ymaGIEcW67esjCoDfZhltTJiGnITgbldl0+mod7opw62
   mlZPqn4EsWnqpdumljnYLjmsKFkhZBAJSM6HPFLBbKr0b4ivbm8WJDvON
   A==;
X-CSE-ConnectionGUID: 8VzFgrYvRXy8J4ZzzpqR/g==
X-CSE-MsgGUID: TWf1o+UTRJGUQXBzniemyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474269"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474269"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:20 -0800
X-CSE-ConnectionGUID: hYGgJS2RSimSsiB63e0htw==
X-CSE-MsgGUID: cCSH9aSdQ32kno9Sqthqxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061905"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: iwlwifi: w/a FW SMPS mode selection
Date: Fri,  7 Mar 2025 00:04:48 +0200
Message-Id: <20250307000213.bf1bbf64f072.I2c793ff1fc2a6779a95faaee1ded348100fd97f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

The FW is now responsible of determining the SMPS mode.
If the user disabled power save in a certain vif, we send the vif-level
power command to clear out the POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK bit
for that vif.
But erroneously, the FW checks DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK in
the device-level command to determine the SMPS mode.

To W/A this, send also the device-level command when the power save of a
vif changes, and disable power save if there is any vif that has power
save disabled.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 +++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 20aaef913e3f..1e916a0ce082 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4100,6 +4100,20 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 	return 0;
 }
 
+void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     bool update)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (!iwl_mvm_has_rlc_offload(mvm))
+		return;
+
+	mvmvif->ps_disabled = !vif->cfg.ps;
+
+	if (update)
+		iwl_mvm_power_update_mac(mvm);
+}
+
 /* Common part for MLD and non-MLD modes */
 int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -4192,6 +4206,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ret = iwl_mvm_sta_state_assoc_to_authorized(mvm, vif, sta,
 							    callbacks);
+		iwl_mvm_smps_workaround(mvm, vif, true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		ret = iwl_mvm_sta_state_authorized_to_assoc(mvm, vif, sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 341a2a7a49ec..78d7153a0cfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2024 Intel Corporation
+ * Copyright (C) 2022-2025 Intel Corporation
  */
 #include "mvm.h"
 
@@ -887,6 +887,7 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 	}
 
 	if (changes & BSS_CHANGED_PS) {
+		iwl_mvm_smps_workaround(mvm, vif, false);
 		ret = iwl_mvm_power_update_mac(mvm);
 		if (ret)
 			IWL_ERR(mvm, "failed to update power mode\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b6e0b63cbd3c..f6391c7a3e29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -3031,4 +3031,7 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
 					struct ieee80211_bss_conf *bss_conf,
 					bool is_ap);
+
+void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     bool update);
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


