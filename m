Return-Path: <linux-wireless+bounces-20270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF90A5E742
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E2E189D954
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E21F099D;
	Wed, 12 Mar 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIKt18ZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92E1EF370
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818181; cv=none; b=nDS1HQl4AFCT8S8X8Y1Dq/Tk86AVnYNGGrhrORtplqIuU80AwQk/C1y9Dzlvy2A9ooJBWjxttyh+lhLPZkbpa3vwvUzcJBxxCic7k2izEfnGo2Mid74WdXQYOTZsCekxqj/xoDTOXJXTFGCMPm2f4YV45t0CeFw4DWH82CfzrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818181; c=relaxed/simple;
	bh=UeBeSqjG+De/rPOxZIpNTUoHKcLUJfbGaLKBZKOXQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nG+PcIcPQok0msfGnPZ1M6vEbXsILUg3tSdVXOoK8rbhVKB9LbqAWXgDN9tTJ2IqJ+ZvR5LywiFYS2LK6hAWChpYy7T6qGSVlrfaVWYQp3yew+guuMuZSWhZLEb/ux+7VEb9NW6UUyRvqvylJrCzlfcliISkMLqdxey/nG1v0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIKt18ZM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818180; x=1773354180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeBeSqjG+De/rPOxZIpNTUoHKcLUJfbGaLKBZKOXQVw=;
  b=mIKt18ZMdGTUWx5siw7rp4KhdbOED+lNh3s0lmLUWGA6HdIl776g2fbw
   TlCoIbsi2Q9d/ceUkhgc3JBnO0GkOwRQfB+E6Sstd40zO3DtOKLG6ua2p
   eaySFjRRhjID58sShJcbAfaO9r9Po1Y+3llUtA48chwF8s0nLdWHkd47K
   AxsIsXRHy95GYwD0ysKP8qp0p3yveBvOH5L5N9BeMyQrq1JTJ9cO/REsH
   h/Q+4EOdAQUNZZXOCq983YB2yxqGeFWX2XXLqnoIiJ+y9y2JP5ZNGOOEu
   RqK7sz+46HWCFBD9e8cJRe0qUOWZHWY0+mdKA7Q8VaVERY8XBG4qYEwj9
   A==;
X-CSE-ConnectionGUID: 0HzNwVfzTqOY3RZDLZGO9A==
X-CSE-MsgGUID: T7jhdBHxTTmobaev6VnVyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826744"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:59 -0700
X-CSE-ConnectionGUID: OwqbE6Q+QPKHAhgGcN7IIg==
X-CSE-MsgGUID: pI9zvXmNSTiJx+SHwwon6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267366"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: iwlwifi: mld: remove IWL_MLD_EMLSR_BLOCKED_FW
Date: Thu, 13 Mar 2025 00:22:28 +0200
Message-Id: <20250313002008.6729a8d67815.Iab39bf0982d8cdbb0db701d31854101c2fcf3b64@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The channel load logic moves from the FW to the driver.
- Implement the logic: allow EMLSR only if the candidate primary link is
  active and if its average channel load exceeds the threshold.
- Remove IWL_MLD_EMLSR_BLOCKED_FW. Instead, treat ESR_RECOMMEND_LEAVE in
  the EMLSR_RECOMMENDATION notif as an EXIT reason.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../wireless/intel/iwlwifi/mld/constants.h    |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  12 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 130 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   5 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  10 +-
 6 files changed, 124 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
index 9a24996014b8..2a59b29b75cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -68,7 +68,7 @@
 #define IWL_MLD_LOW_RSSI_THRESH_160MHZ		-72
 
 #define IWL_MLD_ENTER_EMLSR_TPT_THRESH		400
-#define IWL_MLD_CHAN_LOAD_THRESH		2 /* in percentage */
+#define IWL_MLD_EXIT_EMLSR_CHAN_LOAD		2 /* in percentage */
 
 #define IWL_MLD_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
 #define IWL_MLD_FTM_INITIATOR_DYNACK		true
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 57910660ed18..550ae3c9d766 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -24,7 +24,6 @@ enum iwl_mld_cca_40mhz_wa_status {
  *
  * @IWL_MLD_EMLSR_BLOCKED_PREVENTION: Prevent repeated EMLSR enter/exit
  * @IWL_MLD_EMLSR_BLOCKED_WOWLAN: WOWLAN is preventing EMLSR
- * @IWL_MLD_EMLSR_BLOCKED_FW: FW did not recommend MLO
  * @IWL_MLD_EMLSR_BLOCKED_ROC: remain-on-channel is preventing EMLSR
  * @IWL_MLD_EMLSR_BLOCKED_NON_BSS: An active non-BSS interface's link is
  *      preventing EMLSR
@@ -36,11 +35,10 @@ enum iwl_mld_cca_40mhz_wa_status {
 enum iwl_mld_emlsr_blocked {
 	IWL_MLD_EMLSR_BLOCKED_PREVENTION	= 0x1,
 	IWL_MLD_EMLSR_BLOCKED_WOWLAN		= 0x2,
-	IWL_MLD_EMLSR_BLOCKED_FW		= 0x4,
-	IWL_MLD_EMLSR_BLOCKED_ROC		= 0x8,
-	IWL_MLD_EMLSR_BLOCKED_NON_BSS		= 0x10,
-	IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS	= 0x20,
-	IWL_MLD_EMLSR_BLOCKED_TPT		= 0x40,
+	IWL_MLD_EMLSR_BLOCKED_ROC		= 0x4,
+	IWL_MLD_EMLSR_BLOCKED_NON_BSS		= 0x8,
+	IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS	= 0x10,
+	IWL_MLD_EMLSR_BLOCKED_TPT		= 0x20,
 };
 
 /**
@@ -62,6 +60,7 @@ enum iwl_mld_emlsr_blocked {
  * @IWL_MLD_EMLSR_EXIT_CHAN_LOAD: Exit EMLSR because the primary channel is not
  *	loaded enough to justify EMLSR.
  * @IWL_MLD_EMLSR_EXIT_RFI: Exit EMLSR due to RFI
+ * @IWL_MLD_EMLSR_EXIT_FW_REQUEST: Exit EMLSR because the FW requested it
  */
 enum iwl_mld_emlsr_exit {
 	IWL_MLD_EMLSR_EXIT_BLOCK		= 0x1,
@@ -75,6 +74,7 @@ enum iwl_mld_emlsr_exit {
 	IWL_MLD_EMLSR_EXIT_BT_COEX		= 0x100,
 	IWL_MLD_EMLSR_EXIT_CHAN_LOAD		= 0x200,
 	IWL_MLD_EMLSR_EXIT_RFI			= 0x400,
+	IWL_MLD_EMLSR_EXIT_FW_REQUEST		= 0x800,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 91e201fde72a..f6623988fff6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1189,8 +1189,13 @@ iwl_mld_mac80211_link_info_changed_sta(struct iwl_mld *mld,
 		iwl_mld_omi_ap_changed_bw(mld, link_conf, bw);
 	}
 
-	if (changes & BSS_CHANGED_BANDWIDTH)
-		iwl_mld_emlsr_check_equal_bw(mld, vif, link_conf);
+	if (changes & BSS_CHANGED_BANDWIDTH) {
+		if (iwl_mld_emlsr_active(vif))
+			iwl_mld_emlsr_check_equal_bw(mld, vif, link_conf);
+		else
+			/* Channel load threshold may have changed */
+			iwl_mld_retry_emlsr(mld, vif);
+	}
 }
 
 static int iwl_mld_update_mu_groups(struct iwl_mld *mld,
@@ -1712,10 +1717,6 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 						    IWL_MLD_EMLSR_BLOCKED_TPT,
 						    0);
 
-			/* Wait for the FW to send a recommendation */
-			iwl_mld_block_emlsr(mld, vif,
-					    IWL_MLD_EMLSR_BLOCKED_FW, 0);
-
 			/* clear COEX_HIGH_PRIORITY_ENABLE */
 			ret = iwl_mld_mac_fw_action(mld, vif,
 						    FW_CTXT_ACTION_MODIFY);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index a5b1d373922a..9556ff3a75a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -9,7 +9,6 @@
 #define HANDLE_EMLSR_BLOCKED_REASONS(HOW)	\
 	HOW(PREVENTION)			\
 	HOW(WOWLAN)			\
-	HOW(FW)				\
 	HOW(ROC)			\
 	HOW(NON_BSS)			\
 	HOW(TMP_NON_BSS)		\
@@ -53,7 +52,8 @@ static void iwl_mld_print_emlsr_blocked(struct iwl_mld *mld, u32 mask)
 	HOW(LINK_USAGE)			\
 	HOW(BT_COEX)			\
 	HOW(CHAN_LOAD)			\
-	HOW(RFI)
+	HOW(RFI)			\
+	HOW(FW_REQUEST)
 
 static const char *
 iwl_mld_get_emlsr_exit_string(enum iwl_mld_emlsr_exit exit)
@@ -332,18 +332,14 @@ iwl_mld_vif_iter_emlsr_mode_notif(void *data, u8 *mac,
 		return;
 
 	switch (le32_to_cpu(notif->action)) {
-	case ESR_RECOMMEND_ENTER:
-		iwl_mld_unblock_emlsr(mld_vif->mld, vif,
-				      IWL_MLD_EMLSR_BLOCKED_FW);
-		break;
 	case ESR_RECOMMEND_LEAVE:
-		iwl_mld_block_emlsr(mld_vif->mld, vif,
-				    IWL_MLD_EMLSR_BLOCKED_FW,
-				    iwl_mld_get_primary_link(vif));
+		iwl_mld_exit_emlsr(mld_vif->mld, vif,
+				   IWL_MLD_EMLSR_EXIT_FW_REQUEST,
+				   iwl_mld_get_primary_link(vif));
 		break;
+	case ESR_RECOMMEND_ENTER:
 	case ESR_FORCE_LEAVE:
 	default:
-		/* ESR_FORCE_LEAVE should not happen at this point */
 		IWL_WARN(mld_vif->mld, "Unexpected EMLSR notification: %d\n",
 			 le32_to_cpu(notif->action));
 	}
@@ -724,6 +720,53 @@ iwl_mld_set_link_sel_data(struct iwl_mld *mld,
 	return n_data;
 }
 
+static u32
+iwl_mld_get_min_chan_load_thresh(struct ieee80211_chanctx_conf *chanctx)
+{
+	const struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(chanctx);
+
+	switch (phy->chandef.width) {
+	case NL80211_CHAN_WIDTH_320:
+	case NL80211_CHAN_WIDTH_160:
+		return 5;
+	case NL80211_CHAN_WIDTH_80:
+		return 7;
+	default:
+		break;
+	}
+	return 10;
+}
+
+static bool
+iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif,
+				  const struct iwl_mld_link_sel_data *a,
+				  const struct iwl_mld_link_sel_data *b)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *link_a =
+		iwl_mld_link_dereference_check(mld_vif, a->link_id);
+	struct ieee80211_chanctx_conf *chanctx_a = NULL;
+	u32 primary_load_perc;
+
+	if (!link_a || !link_a->active) {
+		IWL_DEBUG_EHT(mld, "Primary link is not active. Can't enter EMLSR\n");
+		return false;
+	}
+
+	chanctx_a = wiphy_dereference(mld->wiphy, link_a->chan_ctx);
+
+	if (WARN_ON(!chanctx_a))
+		return false;
+
+	primary_load_perc =
+		iwl_mld_phy_from_mac80211(chanctx_a)->avg_channel_load_not_by_us;
+
+	IWL_DEBUG_EHT(mld, "Average channel load not by us: %u\n", primary_load_perc);
+
+	return primary_load_perc > iwl_mld_get_min_chan_load_thresh(chanctx_a);
+}
+
 static bool
 iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 			 struct iwl_mld_link_sel_data *a,
@@ -746,6 +789,8 @@ iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
 		 */
 		reason_mask |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
 	}
+	if (!iwl_mld_channel_load_allows_emlsr(mld, vif, a, b))
+		reason_mask |= IWL_MLD_EMLSR_EXIT_CHAN_LOAD;
 
 	if (reason_mask) {
 		IWL_DEBUG_INFO(mld,
@@ -904,7 +949,6 @@ void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
 		link_conf_dereference_check(vif, other_link_id);
 
 	if (!ieee80211_vif_link_active(vif, link->link_id) ||
-	    !iwl_mld_emlsr_active(vif) ||
 	    WARN_ON(link->link_id == other_link_id || !other_link))
 		return;
 
@@ -952,39 +996,67 @@ void iwl_mld_emlsr_check_bt(struct iwl_mld *mld)
 						NULL);
 }
 
-static void iwl_mld_emlsr_check_chan_load_iter(void *_data, u8 *mac,
-					       struct ieee80211_vif *vif)
+struct iwl_mld_chan_load_data {
+	struct iwl_mld_phy *phy;
+	u32 prev_chan_load_not_by_us;
+};
+
+static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
+					  struct ieee80211_vif *vif)
 {
-	struct iwl_mld *mld = (struct iwl_mld *)_data;
+	struct iwl_mld_chan_load_data *data = _data;
+	const struct iwl_mld_phy *phy = data->phy;
+	struct ieee80211_chanctx_conf *chanctx =
+		container_of((const void *)phy, struct ieee80211_chanctx_conf,
+			     drv_priv);
+	struct iwl_mld *mld = iwl_mld_vif_from_mac80211(vif)->mld;
 	struct ieee80211_bss_conf *prim_link;
 	unsigned int prim_link_id;
-	int chan_load;
-
-	if (!iwl_mld_emlsr_active(vif))
-		return;
 
 	prim_link_id = iwl_mld_get_primary_link(vif);
 	prim_link = link_conf_dereference_protected(vif, prim_link_id);
+
 	if (WARN_ON(!prim_link))
 		return;
 
-	chan_load = iwl_mld_get_chan_load_by_others(mld, prim_link, true);
-
-	if (chan_load < 0)
+	if (chanctx != rcu_access_pointer(prim_link->chanctx_conf))
 		return;
 
-	/* chan_load is in range [0,255] */
-	if (chan_load < NORMALIZE_PERCENT_TO_255(IWL_MLD_CHAN_LOAD_THRESH))
-		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
-				   prim_link_id);
+	if (iwl_mld_emlsr_active(vif)) {
+		int chan_load = iwl_mld_get_chan_load_by_others(mld, prim_link,
+								true);
+
+		if (chan_load < 0)
+			return;
+
+		/* chan_load is in range [0,255] */
+		if (chan_load < NORMALIZE_PERCENT_TO_255(IWL_MLD_EXIT_EMLSR_CHAN_LOAD))
+			iwl_mld_exit_emlsr(mld, vif,
+					   IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
+					   prim_link_id);
+	} else {
+		u32 old_chan_load = data->prev_chan_load_not_by_us;
+		u32 new_chan_load = phy->avg_channel_load_not_by_us;
+		u32 thresh = iwl_mld_get_min_chan_load_thresh(chanctx);
+
+		if (old_chan_load <= thresh && new_chan_load > thresh)
+			iwl_mld_retry_emlsr(mld, vif);
+	}
 }
 
-void iwl_mld_emlsr_check_chan_load(struct iwl_mld *mld)
+void iwl_mld_emlsr_check_chan_load(struct ieee80211_hw *hw,
+				   struct iwl_mld_phy *phy,
+				   u32 prev_chan_load_not_by_us)
 {
-	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+	struct iwl_mld_chan_load_data data = {
+		.phy = phy,
+		.prev_chan_load_not_by_us = prev_chan_load_not_by_us,
+	};
+
+	ieee80211_iterate_active_interfaces_mtx(hw,
 						IEEE80211_IFACE_ITER_NORMAL,
-						iwl_mld_emlsr_check_chan_load_iter,
-						(void *)(uintptr_t)mld);
+						iwl_mld_chan_load_update_iter,
+						&data);
 }
 
 void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index 0f1b18f61c75..a5fbe1919c6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -11,6 +11,7 @@
 #include "iwl-config.h"
 #include "iwl-trans.h"
 #include "iface.h"
+#include "phy.h"
 
 struct iwl_mld;
 
@@ -139,7 +140,9 @@ void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
 
 void iwl_mld_emlsr_check_bt(struct iwl_mld *mld);
 
-void iwl_mld_emlsr_check_chan_load(struct iwl_mld *mld);
+void iwl_mld_emlsr_check_chan_load(struct ieee80211_hw *hw,
+				   struct iwl_mld_phy *phy,
+				   u32 prev_chan_load_not_by_us);
 
 /**
  * iwl_mld_retry_emlsr - Retry entering EMLSR
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 75cb204c2419..0715bbc31031 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -457,7 +457,7 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 {
 	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
 	const struct iwl_stats_ntfy_per_phy *per_phy = data;
-	u32 new_load;
+	u32 new_load, old_load;
 
 	if (WARN_ON(phy->fw_id >= IWL_STATS_MAX_PHY_OPERATIONAL))
 		return;
@@ -465,14 +465,16 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 	phy->channel_load_by_us =
 		le32_to_cpu(per_phy[phy->fw_id].channel_load_by_us);
 
+	old_load = phy->avg_channel_load_not_by_us;
 	new_load = le32_to_cpu(per_phy[phy->fw_id].channel_load_not_by_us);
 	if (IWL_FW_CHECK(phy->mld, new_load > 100, "Invalid channel load %u\n",
 			 new_load))
 		return;
 
 	/* give a weight of 0.5 for the old value */
-	phy->avg_channel_load_not_by_us =
-		(new_load >> 1) + (phy->avg_channel_load_not_by_us >> 1);
+	phy->avg_channel_load_not_by_us = (new_load >> 1) + (old_load >> 1);
+
+	iwl_mld_emlsr_check_chan_load(hw, phy, old_load);
 }
 
 static void
@@ -483,8 +485,6 @@ iwl_mld_process_per_phy_stats(struct iwl_mld *mld,
 					 iwl_mld_fill_chanctx_stats,
 					 (void *)(uintptr_t)per_phy);
 
-	/* channel_load_by_us may have been updated, so recheck */
-	iwl_mld_emlsr_check_chan_load(mld);
 }
 
 void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
-- 
2.34.1


