Return-Path: <linux-wireless+bounces-4542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E92877AF1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA896281CDC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835914275;
	Mon, 11 Mar 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpibnTai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9913AE8
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138530; cv=none; b=qCYuTkasii7KXxqfivjbZQS1VtOeiaglUP378xRJPJ9KazRlQT1wlLFL/FQAE26BwnhcwPxhfTdxqWTDjt3xOX+V2mFG1toJjK+0NWtQfZRtiOKU1XNNbymztk7iy741Q5NqGrRo1PcWLsp97eP/OuXnzftMLXoMNplq+nVA0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138530; c=relaxed/simple;
	bh=gHTM7X4Pt17euL85qkcgIg2qVbWTn3/1sN2tLi8erbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwzLp9ch1Pyt7DZdlEqvA6f7lDZ+DD9W6/SFpMZyhPdSD3jXUZzDEJVxXldCX+X3KglvcP/YiFM8aggiAGO8glU7nL9x1R2ZKcE+oobZ8ub1ct2po/LPKR0IMG0K9qlIlrHGspH6hffkcNcVgtlKSKM6T/NnxXw4wWuuDzNv5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpibnTai; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138528; x=1741674528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gHTM7X4Pt17euL85qkcgIg2qVbWTn3/1sN2tLi8erbQ=;
  b=CpibnTailv9/p6rMnVU0zhwYGXadXbGw61qIG3T5UztbB2vjIk6y+pFJ
   XlH4lEZUGsTiZtZqUjM9pIHf8Y9BbO33PZU7FszVOb8SRsUPdx6x9LaZZ
   MzZJu3NahF+YfayD7Liyb/K9dXBoW3E+bDEzkiCfmN1cBbUMA9QHINaX/
   jw1F/pPYv0qAMiJxdcz1iU4thuLmLZ/GBvjbMe5I3Qf/gFV9imLUbmkc3
   o9ZSdNMXsvoR5TORMJB2Ebf/3dv8wKu5FVDhb7H5UL+55+UkOB+BjNiwr
   9Rd8+SBIbboyzPaQ15zw73s5YAX0p68MxroGZIep9NtmklgmG/eVYoBf5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226788"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226788"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657714"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: fix flushing during quiet CSA
Date: Mon, 11 Mar 2024 08:28:10 +0200
Message-Id: <20240311081938.d5d629f32ea8.I86d9b849d92273542bfc2d9c671b66179e7ebb72@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If, for any reason, we're going to attempt to flush the queues
while quiet CSA is happening, this cannot succeed. This could
be the case if for example mac80211 were to flush after TXing
e.g. a deauth frame due to disconnecting during the CSA.

In this case, drop the frames instead, the firmware won't let
us do any transmissions and may also become unhappy if we're
not going to disconnect quickly enough.

Currently this doesn't happen as mac80211 stops queues, but
we'll want to let mac80211 know not to stop queues for proper
multi-link support during CSA, so we need to handle this case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b8488984cc0e..5f8a53a77290 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1437,6 +1437,7 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 		u8 ap_sta_id = mvmvif->link[link_id]->ap_sta_id;
 
 		mvmvif->csa_bcn_pending = false;
+		mvmvif->csa_blocks_tx = false;
 		mvmsta = iwl_mvm_sta_from_staid_protected(mvm, ap_sta_id);
 
 		if (WARN_ON(!mvmsta)) {
@@ -5433,6 +5434,7 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 	mutex_lock(&mvm->mutex);
 
 	mvmvif->csa_failed = false;
+	mvmvif->csa_blocks_tx = false;
 
 	IWL_DEBUG_MAC80211(mvm, "pre CSA to freq %d\n",
 			   chsw->chandef.center_freq1);
@@ -5471,6 +5473,8 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 		break;
 	case NL80211_IFTYPE_STATION:
+		mvmvif->csa_blocks_tx = chsw->block_tx;
+
 		/*
 		 * In the new flow FW is in charge of timing the switch so there
 		 * is no need for all of this
@@ -5635,8 +5639,8 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       u32 queues, bool drop)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_vif *mvmvif;
 	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_sta *sta;
 	bool ap_sta_done = false;
@@ -5648,11 +5652,22 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return;
 	}
 
+	if (!drop && hweight16(vif->active_links) <= 1) {
+		int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = wiphy_dereference(hw->wiphy,
+					      vif->link_conf[link_id]);
+		if (WARN_ON(!link_conf))
+			return;
+		if (link_conf->csa_active && mvmvif->csa_blocks_tx)
+			drop = true;
+	}
+
 	/* Make sure we're done with the deferred traffic before flushing */
 	flush_work(&mvm->add_stream_wk);
 
 	mutex_lock(&mvm->mutex);
-	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	/* flush the AP-station and all TDLS peers */
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e9da4d2bc13a..ffc8f20700d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -370,6 +370,7 @@ struct iwl_mvm_vif_link_info {
  * @csa_countdown: indicates that CSA countdown may be started
  * @csa_failed: CSA failed to schedule time event, report an error later
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
+ * @csa_blocks_tx: CSA is blocking TX
  * @features: hw features active for this vif
  * @ap_beacon_time: AP beacon time for synchronisation (on older FW)
  * @bf_enabled: indicates if beacon filtering is enabled
@@ -445,6 +446,7 @@ struct iwl_mvm_vif {
 	bool csa_countdown;
 	bool csa_failed;
 	bool csa_bcn_pending;
+	bool csa_blocks_tx;
 	u16 csa_target_freq;
 	u16 csa_count;
 	u16 csa_misbehave;
-- 
2.34.1


