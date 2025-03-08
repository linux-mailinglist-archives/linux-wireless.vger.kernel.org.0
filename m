Return-Path: <linux-wireless+bounces-20053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E3A57E80
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F816E1D0
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6552080FB;
	Sat,  8 Mar 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWLnHgEj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41A20458B
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468791; cv=none; b=pxuRZy5uBO36t2w4qdRdUmIIJXNjtagNRg39HZV2wzxYP7yOg5QxVcke3W2+9iIbll1Sew8jQBuAMrA4Id8EpgzrXHJO3O38rkUi151+2bW/db9l1UDpUq8xN0D8FuTDPWOFyx7AuTg55F/32WsH5xynfULHDIp12TobP9EC/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468791; c=relaxed/simple;
	bh=Pj0p2paligLz2ZvpOs3SXHK7UYAOvX5cSNksAWAn4lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTmiVzRYn1d5ni0T6g2ZZmE13sNtfOYhcc9B+in8eb3pLjWikfSYLiAZJXpq3Ym8e9Y984rPwjA3dHFaZ8vM+qVE5iaKrA7ksu2rUBosZf6JX5r0dP++x3AUNF8KzPKeFE1IhUbwUXrTxbS+yKJRmyPPFmgkmbvWcktlC1pBsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWLnHgEj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468790; x=1773004790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pj0p2paligLz2ZvpOs3SXHK7UYAOvX5cSNksAWAn4lM=;
  b=DWLnHgEjeqv89V9GPvDou7dKNon8y8QU60IgnadMrbf7neBzy3pAR8oQ
   1ggXtNMT29rmrixWr8PP/v7NLFseXIwrMxZztdSgq6zBs5qg+AIf8E/8U
   ofr2uT50Uf8I5d6bB+GwQZv4n0yz+XlyRY2ewhuSCyhuAP4gOwb/ZcGKG
   pKvS7NVOW3GjHw58bFJud3BealK0WSVFNVqHAZnRh5+3mazWhFBwINLeG
   Y2XAHA+lUuj1wr/jyfPnyWeI+reZxM11zLn0t0mlh+3HOWOF81wxpCRV+
   3DwSlUsptlnj9iITBl5uIJiRehxW99fCZQcBJOKMx+vEgHAz1zjHwOd/X
   w==;
X-CSE-ConnectionGUID: MIzG0OiGQxmSJno8uS8yKQ==
X-CSE-MsgGUID: 843xX9x7Q066+7QjZP/qTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052378"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052378"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:50 -0800
X-CSE-ConnectionGUID: hmHcc0tNQp23PNyAARua/g==
X-CSE-MsgGUID: zW/K5i3vSPiZrhWK4ZGhvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859933"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v3 wireless-next 08/14] wifi: iwlwifi: w/a FW SMPS mode selection
Date: Sat,  8 Mar 2025 23:19:19 +0200
Message-Id: <20250308231427.7bf205efa027.I2c793ff1fc2a6779a95faaee1ded348100fd97f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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


