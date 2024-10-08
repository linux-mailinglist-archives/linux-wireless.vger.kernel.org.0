Return-Path: <linux-wireless+bounces-13666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB3993DF2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72004B24744
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F413A3F7;
	Tue,  8 Oct 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6yxBv+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8313541B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361547; cv=none; b=APW1UMfYElNl+lHDPWD3fagDvLR9CfuhZfkTEedCRNoA+u8Xfi6glDXG1+QRvaPrdMVgu6LeDvxD5z43d7C7h9XyfFskHBgjO1t8txPcc25MLv844lHkUpJNT0Sz4i9F4SgMWbuscce+rpN5rIqK/Qv3bT2+W/7iZs4szmN+HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361547; c=relaxed/simple;
	bh=P8GMX2V0vmbTVbtNntq8ucvFzEzXHzXagkSnx8qpC9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPb0LAM5yuoDI+r1V2wJHK4y20yWGL7+qZc4QppoYYd5ECcyucst6Lhxj8+ABLqqu1D1vcbZV26pDgwnbpVaFqkG8GJbQVtNLq2TkNxqt2ibRlUpVSbwxQwomLSkydx4cqZj0oIrF5Za8avNJhGd/sziDGmRJROikl5OGHo/v9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6yxBv+n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361546; x=1759897546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8GMX2V0vmbTVbtNntq8ucvFzEzXHzXagkSnx8qpC9o=;
  b=I6yxBv+nzdTP6p5D0anTsXoO4HYqyjJ5LzoVOd4Mk6LMI5djJvY7BMsV
   Nx+NdWBJ0IUQa6SV1saDizbgVlw6FJGCWng7aU9isWipaBtb8A0dyVI4o
   vJZtfJFzhTzHBWEz8NZHkZTuC4aH+21xy2dgQ/0CCTdzqWwHAH04kHdi/
   RPj8FvaX7T0mhcT1JYFAdfaACgF4PfESyzg3Pg5fB8qW9wpHsUWDzF5k4
   cDx0pWPCZ5+OQZuWHnaEhDKnlKYV/6aSQH8/C2IahS/IrrxiAqurWu2RO
   oZJ3vmOYR+rr2+GEJZlnKDg6199ouReg9Mpmg0Q82jbZo0ifNeN++dad2
   A==;
X-CSE-ConnectionGUID: sh6+N8TVQ4y/ssdG1wVWoA==
X-CSE-MsgGUID: R/INnEHaTwa5llLbMy82cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024258"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024258"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:46 -0700
X-CSE-ConnectionGUID: 2JbWz16nTBOTmSX6IZckPQ==
X-CSE-MsgGUID: PHuvEvmbQ1KtRawurdwwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486309"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: prepare the tx_power handling to be per-link
Date: Tue,  8 Oct 2024 07:25:17 +0300
Message-Id: <20241008072037.317f44628eb9.I3f6a735181c6c20e805b61e4f9d2056b7f90d7ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We still need the firmware to align

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c    | 12 ++++++------
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 99e017f365e0..3fefb0696248 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1466,15 +1466,16 @@ struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
 	return NULL;
 }
 
-int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
+			 struct ieee80211_bss_conf *link_conf,
 			 s16 tx_power)
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
+	u32 mac_id = iwl_mvm_vif_from_mac80211(link_conf->vif)->id;
 	int len;
 	struct iwl_dev_tx_power_cmd_v3_v8 cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
-		.common.mac_context_id =
-			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
+		.common.mac_context_id = cpu_to_le32(mac_id),
 	};
 	struct iwl_dev_tx_power_cmd cmd_v9_v10;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 3);
@@ -1487,8 +1488,7 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (cmd_ver > 8) {
 		/* Those fields sit on the same place for v9 and v10 */
 		cmd_v9_v10.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC);
-		cmd_v9_v10.common.mac_context_id =
-			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id);
+		cmd_v9_v10.common.mac_context_id = cpu_to_le32(mac_id);
 		cmd_v9_v10.common.pwr_restriction = cpu_to_le16(u_tx_power);
 		cmd_data = &cmd_v9_v10;
 	}
@@ -3323,7 +3323,7 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 	if (changes & BSS_CHANGED_TXPOWER) {
 		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d dBm\n",
 				bss_conf->txpower);
-		iwl_mvm_set_tx_power(mvm, vif, bss_conf->txpower);
+		iwl_mvm_set_tx_power(mvm, bss_conf, bss_conf->txpower);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 3947f6a0e0cf..9aa08d289680 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1038,7 +1038,7 @@ static void iwl_mvm_mld_link_info_changed(struct ieee80211_hw *hw,
 	if (changes & BSS_CHANGED_TXPOWER) {
 		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d dBm\n",
 				link_conf->txpower);
-		iwl_mvm_set_tx_power(mvm, vif, link_conf->txpower);
+		iwl_mvm_set_tx_power(mvm, link_conf, link_conf->txpower);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3f7b6465130a..ff5d720b7314 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2989,7 +2989,8 @@ void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 bool iwl_mvm_have_links_same_channel(struct iwl_mvm_vif *vif1,
 				     struct iwl_mvm_vif *vif2);
 bool iwl_mvm_vif_is_active(struct iwl_mvm_vif *mvmvif);
-int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
+			 struct ieee80211_bss_conf *bss_conf,
 			 s16 tx_power);
 int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
-- 
2.34.1


