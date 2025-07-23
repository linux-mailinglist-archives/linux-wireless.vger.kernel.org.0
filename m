Return-Path: <linux-wireless+bounces-25902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEEB0EAE9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66EF960CA6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810A272E61;
	Wed, 23 Jul 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/XGGyo9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351527144B
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253155; cv=none; b=bGxWp2AhlKMESLbO9vERzQz/dP3A4nLMFuCIF8M9lYGkMWj70ahd8JIO2vjaOfn8vgy49yI9Rage0IlJV3N9ZBaHhgcs9jrTPUPYm61lsotrN9A3A45L9vSl9W1Og9H6B6h9zZzKySG1EhgxGXSzHULGJdEBWMkTCw90yGwpZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253155; c=relaxed/simple;
	bh=M0rVh/h5KCjLjj/i2ATiChun3KjSACTurrIutV6xElw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bmez7ryPAiF6QT2kPl3xTPW2FDtAf2cHr1FQ6wp2DUaL89wcJXGK0xYYRv61BW0nxk4wPwnx48bF8eUZyS+vtVTNieWP43GB0GSH6nxwcexkUp4K23dWje9Quu1hC2c7heFtOMi8PKkm+i7nw87FDo3ujOnjj7GscJT9rcAta4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/XGGyo9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253152; x=1784789152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0rVh/h5KCjLjj/i2ATiChun3KjSACTurrIutV6xElw=;
  b=c/XGGyo9q8iu4qvpPBvBsc2VwgImweB9qSYcMFKasbtp/qpu36zlUWKT
   TlRUYsS+L4ApFfkqSrTwlrpg3K28hZ2aR0s5Lo+LsEuDK7rBfSHdsEoqo
   vP9cHwfbmlM+P/vuW4xcYQtf6a/7ABFMS/DHSVQmZKvN8J12qXr4u6yv/
   v1IBSYdazALhGMHm8R0w0XFhlsVH3Eo/AIYlPcCgHHDZftRyIH4gDBXQ5
   k0EUcacYYaLV6vz7Imer4NJCqPu7SFuZhqAT3m2bh5nxqRkoC5E/dph9D
   kfLZPLqEZ8+Mg0+y9C2eV5QLeb6kBhXpNGEO0yCq0QOVyVxoknUCuacp/
   w==;
X-CSE-ConnectionGUID: 7vCsltXITzu9j1/Uc7IDhA==
X-CSE-MsgGUID: puatqub2RLGM8UvQBrQHQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340773"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340773"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:49 -0700
X-CSE-ConnectionGUID: FGxeQXj5RFq4dPVZKPRMjw==
X-CSE-MsgGUID: pC1YJilBT7utwZVumzbz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918101"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/14] wifi: iwlwifi: Remove support for rx OMI bandwidth reduction
Date: Wed, 23 Jul 2025 09:45:10 +0300
Message-Id: <20250723094230.a9ccfe210516.Ic87bc7709a6761f593e88f1488a41442c68c1686@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This feature turns out to have an issue: it can take up to 8 seconds to
detect high throughput scenarios and to leave RX OMI bandwidth
reduction. This leads to throughput degradation.
Until the issues are fixed, remove the RX OMI implementation.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  17 -
 .../wireless/intel/iwlwifi/mld/constants.h    |   9 -
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 369 +-----------------
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  30 --
 .../wireless/intel/iwlwifi/mld/low_latency.c  |   3 -
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  57 ---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   1 -
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  12 -
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   2 -
 9 files changed, 4 insertions(+), 496 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 083136a0c456..b1c6ee8ae2df 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -90,12 +90,6 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	SEC_KEY_CMD = 0x18,
 
-	/**
-	 * @OMI_SEND_STATUS_NOTIF: notification after OMI was sent
-	 *	uses &struct iwl_omi_send_status_notif
-	 */
-	OMI_SEND_STATUS_NOTIF = 0xF2,
-
 	/**
 	 * @ESR_MODE_NOTIF: notification to recommend/force a wanted esr mode,
 	 *	uses &struct iwl_esr_mode_notif or &struct iwl_esr_mode_notif_v1
@@ -699,15 +693,4 @@ struct iwl_sec_key_cmd {
 	} __packed u; /* SEC_KEY_OPERATION_API_U_VER_1 */
 } __packed; /* SEC_KEY_CMD_API_S_VER_1 */
 
-/**
- * struct iwl_omi_send_status_notif - OMI status notification
- * @success: indicates that the OMI was sent successfully
- *	(currently always set)
- * @sta_id: sta_id to which the OMI was sent
- */
-struct iwl_omi_send_status_notif {
-	__le32 success;
-	__le32 sta_id;
-} __packed; /* OMI_SEND_STATUS_NTFY_API_S_VER_2 */
-
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
index 2a59b29b75cb..49accf96f44b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -40,15 +40,6 @@
 
 #define IWL_MLD_TPT_COUNT_WINDOW (5 * HZ)
 
-/* OMI reduced BW thresholds (channel load percentage) */
-#define IWL_MLD_OMI_ENTER_CHAN_LOAD		10
-#define IWL_MLD_OMI_EXIT_CHAN_LOAD_160		20
-#define IWL_MLD_OMI_EXIT_CHAN_LOAD_320		30
-/* time (in milliseconds) to let AP "settle" the OMI */
-#define IWL_MLD_OMI_AP_SETTLE_DELAY		27
-/* time (in milliseconds) to not enter OMI reduced BW after leaving */
-#define IWL_MLD_OMI_EXIT_PROTECTION		5000
-
 #define IWL_MLD_DIS_RANDOM_FW_ID                false
 #define IWL_MLD_D3_DEBUG                        false
 #define IWL_MLD_NON_TRANSMITTING_AP	        false
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 9797510cab3f..ca5e73cfe36e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -242,27 +242,9 @@ static bool iwl_mld_fill_mu_edca(struct iwl_mld *mld,
 	return true;
 }
 
-static u8 iwl_mld_sta_rx_bw_to_fw(enum ieee80211_sta_rx_bandwidth bw)
-{
-	switch (bw) {
-	default: /* potential future values not supported by this hw/driver */
-	case IEEE80211_STA_RX_BW_20:
-		return IWL_LINK_MODIFY_BW_20;
-	case IEEE80211_STA_RX_BW_40:
-		return IWL_LINK_MODIFY_BW_40;
-	case IEEE80211_STA_RX_BW_80:
-		return IWL_LINK_MODIFY_BW_80;
-	case IEEE80211_STA_RX_BW_160:
-		return IWL_LINK_MODIFY_BW_160;
-	case IEEE80211_STA_RX_BW_320:
-		return IWL_LINK_MODIFY_BW_320;
-	}
-}
-
-static int _iwl_mld_change_link_in_fw(struct iwl_mld *mld,
-				      struct ieee80211_bss_conf *link,
-				      enum ieee80211_sta_rx_bandwidth bw,
-				      u32 changes)
+int
+iwl_mld_change_link_in_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
+			  u32 changes)
 {
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
 	struct ieee80211_vif *vif = link->vif;
@@ -318,9 +300,6 @@ static int _iwl_mld_change_link_in_fw(struct iwl_mld *mld,
 	cmd.bi = cpu_to_le32(link->beacon_int);
 	cmd.dtim_interval = cpu_to_le32(link->beacon_int * link->dtim_period);
 
-	if (changes & LINK_CONTEXT_MODIFY_BANDWIDTH)
-		cmd.modify_bandwidth = iwl_mld_sta_rx_bw_to_fw(bw);
-
 	/* Configure HE parameters only if HE is supported, and only after
 	 * the parameters are set in mac80211 (meaning after assoc)
 	 */
@@ -382,29 +361,11 @@ static int _iwl_mld_change_link_in_fw(struct iwl_mld *mld,
 	return iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_MODIFY);
 }
 
-int iwl_mld_change_link_in_fw(struct iwl_mld *mld,
-			      struct ieee80211_bss_conf *link,
-			      u32 changes)
-{
-	if (WARN_ON(changes & LINK_CONTEXT_MODIFY_BANDWIDTH))
-		changes &= ~LINK_CONTEXT_MODIFY_BANDWIDTH;
-
-	return _iwl_mld_change_link_in_fw(mld, link, 0, changes);
-}
-
-int iwl_mld_change_link_omi_bw(struct iwl_mld *mld,
-			       struct ieee80211_bss_conf *link,
-			       enum ieee80211_sta_rx_bandwidth bw)
-{
-	return _iwl_mld_change_link_in_fw(mld, link, bw,
-					  LINK_CONTEXT_MODIFY_BANDWIDTH);
-}
-
 int iwl_mld_activate_link(struct iwl_mld *mld,
 			  struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(mld_link->vif);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(link->vif);
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -412,7 +373,6 @@ int iwl_mld_activate_link(struct iwl_mld *mld,
 	if (WARN_ON(!mld_link || mld_link->active))
 		return -EINVAL;
 
-	mld_link->rx_omi.exit_ts = jiffies;
 	mld_link->active = true;
 
 	ret = iwl_mld_change_link_in_fw(mld, link,
@@ -477,319 +437,6 @@ iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
 	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
 }
 
-static void iwl_mld_omi_bw_update(struct iwl_mld *mld,
-				  struct ieee80211_bss_conf *link_conf,
-				  struct iwl_mld_link *mld_link,
-				  struct ieee80211_link_sta *link_sta,
-				  enum ieee80211_sta_rx_bandwidth bw,
-				  bool ap_update)
-{
-	enum ieee80211_sta_rx_bandwidth apply_bw;
-
-	mld_link->rx_omi.desired_bw = bw;
-
-	/* Can't update OMI while already in progress, desired_bw was
-	 * set so on FW notification the worker will see the change
-	 * and apply new the new desired bw.
-	 */
-	if (mld_link->rx_omi.bw_in_progress)
-		return;
-
-	if (bw == IEEE80211_STA_RX_BW_MAX)
-		apply_bw = ieee80211_chan_width_to_rx_bw(link_conf->chanreq.oper.width);
-	else
-		apply_bw = bw;
-
-	if (!ap_update) {
-		/* The update isn't due to AP tracking after leaving OMI,
-		 * where the AP could increase BW and then we must tell
-		 * it that we can do the increased BW as well, if we did
-		 * update the chandef.
-		 * In this case, if we want MAX, then we will need to send
-		 * a new OMI to the AP if it increases its own bandwidth as
-		 * we can (due to internal and FW limitations, and being
-		 * worried the AP might break) only send to what we're doing
-		 * at the moment. In this case, set last_max_bw; otherwise
-		 * if we really want to decrease our bandwidth set it to 0
-		 * to indicate no updates are needed if the AP changes.
-		 */
-		if (bw != IEEE80211_STA_RX_BW_MAX)
-			mld_link->rx_omi.last_max_bw = apply_bw;
-		else
-			mld_link->rx_omi.last_max_bw = 0;
-	} else {
-		/* Otherwise, if we're already trying to do maximum and
-		 * the AP is changing, set last_max_bw to the new max the
-		 * AP is using, we'll only get to this code path if the
-		 * new bandwidth of the AP is bigger than what we sent it
-		 * previously. This avoids repeatedly sending updates if
-		 * it changes bandwidth, only doing it once on an increase.
-		 */
-		mld_link->rx_omi.last_max_bw = apply_bw;
-	}
-
-	if (ieee80211_prepare_rx_omi_bw(link_sta, bw)) {
-		mld_link->rx_omi.bw_in_progress = apply_bw;
-		iwl_mld_change_link_omi_bw(mld, link_conf, apply_bw);
-	}
-}
-
-static void iwl_mld_omi_bw_finished_work(struct wiphy *wiphy,
-					 struct wiphy_work *work)
-{
-	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
-	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	struct iwl_mld_link *mld_link =
-		container_of(work, typeof(*mld_link), rx_omi.finished_work.work);
-	enum ieee80211_sta_rx_bandwidth desired_bw, switched_to_bw;
-	struct ieee80211_vif *vif = mld_link->vif;
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct ieee80211_bss_conf *link_conf;
-	struct ieee80211_link_sta *link_sta;
-
-	if (!mld_vif->ap_sta)
-		return;
-
-	link_sta = wiphy_dereference(mld->wiphy,
-				     mld_vif->ap_sta->link[mld_link->link_id]);
-	if (WARN_ON_ONCE(!link_sta))
-		return;
-
-	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
-	if (WARN_ON_ONCE(!link_conf))
-		return;
-
-	if (WARN_ON(!mld_link->rx_omi.bw_in_progress))
-		return;
-
-	desired_bw = mld_link->rx_omi.desired_bw;
-	switched_to_bw = mld_link->rx_omi.bw_in_progress;
-
-	ieee80211_finalize_rx_omi_bw(link_sta);
-	mld_link->rx_omi.bw_in_progress = 0;
-
-	if (desired_bw != switched_to_bw)
-		iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta,
-				      desired_bw, false);
-}
-
-static struct ieee80211_vif *
-iwl_mld_get_omi_bw_reduction_pointers(struct iwl_mld *mld,
-				      struct ieee80211_link_sta **link_sta,
-				      struct iwl_mld_link **mld_link)
-{
-	struct iwl_mld_vif *mld_vif;
-	struct ieee80211_vif *vif;
-	int n_link_stas = 0;
-
-	*link_sta = NULL;
-
-	if (mld->trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
-		return NULL;
-
-	vif = iwl_mld_get_bss_vif(mld);
-	if (!vif)
-		return NULL;
-
-	for (int i = 0; i < ARRAY_SIZE(mld->fw_id_to_link_sta); i++) {
-		struct ieee80211_link_sta *tmp;
-
-		tmp = wiphy_dereference(mld->wiphy, mld->fw_id_to_link_sta[i]);
-		if (IS_ERR_OR_NULL(tmp))
-			continue;
-
-		n_link_stas++;
-		*link_sta = tmp;
-	}
-
-	/* can't do anything if we have TDLS peers or EMLSR */
-	if (n_link_stas != 1)
-		return NULL;
-
-	mld_vif = iwl_mld_vif_from_mac80211(vif);
-	*mld_link = iwl_mld_link_dereference_check(mld_vif,
-						   (*link_sta)->link_id);
-	if (WARN_ON(!*mld_link))
-		return NULL;
-
-	return vif;
-}
-
-void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
-			       struct ieee80211_bss_conf *link_conf,
-			       enum ieee80211_sta_rx_bandwidth bw)
-{
-	struct ieee80211_link_sta *link_sta;
-	struct iwl_mld_link *mld_link;
-	struct ieee80211_vif *vif;
-
-	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
-	if (!vif)
-		return;
-
-	if (WARN_ON(link_conf->vif != vif))
-		return;
-
-	/* This is 0 if we requested an OMI BW reduction and don't want to
-	 * be sending an OMI when the AP's bandwidth changes.
-	 */
-	if (!mld_link->rx_omi.last_max_bw)
-		return;
-
-	/* We only need to tell the AP if it increases BW over what we last
-	 * told it we were using, if it reduces then our last OMI to it will
-	 * not get used anyway (e.g. we said we want 160 but it's doing 80.)
-	 */
-	if (bw < mld_link->rx_omi.last_max_bw)
-		return;
-
-	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta, bw, true);
-}
-
-void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
-				     struct iwl_rx_packet *pkt)
-{
-	const struct iwl_omi_send_status_notif *notif = (const void *)pkt->data;
-	struct ieee80211_link_sta *link_sta;
-	struct iwl_mld_link *mld_link;
-	struct iwl_mld_vif *mld_vif;
-	struct ieee80211_vif *vif;
-	u32 sta_id;
-
-	sta_id = le32_to_cpu(notif->sta_id);
-
-	if (IWL_FW_CHECK(mld, sta_id >= mld->fw->ucode_capa.num_stations,
-			 "Invalid station %d\n", sta_id))
-		return;
-
-	link_sta = wiphy_dereference(mld->wiphy, mld->fw_id_to_link_sta[sta_id]);
-	if (IWL_FW_CHECK(mld, !link_sta, "Station does not exist\n"))
-		return;
-
-	vif = iwl_mld_sta_from_mac80211(link_sta->sta)->vif;
-	mld_vif = iwl_mld_vif_from_mac80211(vif);
-
-	mld_link = iwl_mld_link_dereference_check(mld_vif, link_sta->link_id);
-	if (WARN(!mld_link, "Link %d does not exist\n", link_sta->link_id))
-		return;
-
-	if (IWL_FW_CHECK(mld, !mld_link->rx_omi.bw_in_progress,
-			 "OMI notification when not requested\n"))
-		return;
-
-	wiphy_delayed_work_queue(mld->hw->wiphy,
-				 &mld_link->rx_omi.finished_work,
-				 msecs_to_jiffies(IWL_MLD_OMI_AP_SETTLE_DELAY));
-}
-
-void iwl_mld_leave_omi_bw_reduction(struct iwl_mld *mld)
-{
-	struct ieee80211_bss_conf *link_conf;
-	struct ieee80211_link_sta *link_sta;
-	struct iwl_mld_link *mld_link;
-	struct ieee80211_vif *vif;
-
-	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
-	if (!vif)
-		return;
-
-	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
-	if (WARN_ON_ONCE(!link_conf))
-		return;
-
-	if (!link_conf->he_support)
-		return;
-
-	mld_link->rx_omi.exit_ts = jiffies;
-
-	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta,
-			      IEEE80211_STA_RX_BW_MAX, false);
-}
-
-void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld)
-{
-	enum ieee80211_sta_rx_bandwidth bw = IEEE80211_STA_RX_BW_MAX;
-	struct ieee80211_chanctx_conf *chanctx;
-	struct ieee80211_bss_conf *link_conf;
-	struct ieee80211_link_sta *link_sta;
-	struct cfg80211_chan_def chandef;
-	struct iwl_mld_link *mld_link;
-	struct iwl_mld_vif *mld_vif;
-	struct ieee80211_vif *vif;
-	struct iwl_mld_phy *phy;
-	u16 punctured;
-	int exit_thr;
-
-	/* not allowed in CAM mode */
-	if (iwlmld_mod_params.power_scheme == IWL_POWER_SCHEME_CAM)
-		return;
-
-	/* must have one BSS connection (no P2P), no TDLS, nor EMLSR */
-	vif = iwl_mld_get_omi_bw_reduction_pointers(mld, &link_sta, &mld_link);
-	if (!vif)
-		return;
-
-	link_conf = link_conf_dereference_protected(vif, link_sta->link_id);
-	if (WARN_ON_ONCE(!link_conf))
-		return;
-
-	if (!link_conf->he_support)
-		return;
-
-	chanctx = wiphy_dereference(mld->wiphy, mld_link->chan_ctx);
-	if (WARN_ON(!chanctx))
-		return;
-
-	mld_vif = iwl_mld_vif_from_mac80211(vif);
-	if (!mld_vif->authorized)
-		goto apply;
-
-	/* must not be in low-latency mode */
-	if (iwl_mld_vif_low_latency(mld_vif))
-		goto apply;
-
-	chandef = link_conf->chanreq.oper;
-
-	switch (chandef.width) {
-	case NL80211_CHAN_WIDTH_320:
-		exit_thr = IWL_MLD_OMI_EXIT_CHAN_LOAD_320;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		exit_thr = IWL_MLD_OMI_EXIT_CHAN_LOAD_160;
-		break;
-	default:
-		/* since we reduce to 80 MHz, must have more to start with */
-		goto apply;
-	}
-
-	/* not to be done if primary 80 MHz is punctured */
-	if (cfg80211_chandef_primary(&chandef, NL80211_CHAN_WIDTH_80,
-				     &punctured) < 0 ||
-	    punctured != 0)
-		goto apply;
-
-	phy = iwl_mld_phy_from_mac80211(chanctx);
-
-	if (phy->channel_load_by_us > exit_thr) {
-		/* send OMI for max bandwidth */
-		goto apply;
-	}
-
-	if (phy->channel_load_by_us > IWL_MLD_OMI_ENTER_CHAN_LOAD) {
-		/* no changes between enter/exit thresholds */
-		return;
-	}
-
-	if (time_is_after_jiffies(mld_link->rx_omi.exit_ts +
-				  msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
-		return;
-
-	/* reduce bandwidth to 80 MHz to save power */
-	bw = IEEE80211_STA_RX_BW_80;
-apply:
-	iwl_mld_omi_bw_update(mld, link_conf, mld_link, link_sta, bw, false);
-}
-
 IWL_MLD_ALLOC_FN(link, bss_conf)
 
 /* Constructor function for struct iwl_mld_link */
@@ -797,18 +444,12 @@ static int
 iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 		  struct iwl_mld_link *mld_link)
 {
-	mld_link->vif = link->vif;
-	mld_link->link_id = link->link_id;
 	mld_link->average_beacon_energy = 0;
 
 	iwl_mld_init_internal_sta(&mld_link->bcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->mcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->mon_sta);
 
-	if (!mld->fw_status.in_hw_restart)
-		wiphy_delayed_work_init(&mld_link->rx_omi.finished_work,
-					iwl_mld_omi_bw_finished_work);
-
 	return iwl_mld_allocate_link_fw_id(mld, &mld_link->fw_id, link);
 }
 
@@ -872,8 +513,6 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 
 	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 
-	wiphy_delayed_work_cancel(mld->wiphy, &link->rx_omi.finished_work);
-
 	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 881823be07ba..cad2c9426349 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -36,11 +36,9 @@ struct iwl_probe_resp_data {
  * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked.
  * @igtk: fw can only have one IGTK at a time, whereas mac80211 can have two.
  *	This tracks the one IGTK that currently exists in FW.
- * @vif: the vif this link belongs to
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
  * @mon_sta: station used for TX injection in monitor interface.
- * @link_id: over the air link ID
  * @average_beacon_energy: average beacon energy for beacons received during
  *	client connections
  * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
@@ -49,14 +47,6 @@ struct iwl_probe_resp_data {
  * @silent_deactivation: next deactivation needs to be silent.
  * @probe_resp_data: data from FW notification to store NOA related data to be
  *	inserted into probe response.
- * @rx_omi: data for BW reduction with OMI
- * @rx_omi.bw_in_progress: update is in progress (indicates target BW)
- * @rx_omi.exit_ts: timestamp of last exit
- * @rx_omi.finished_work: work for the delayed reaction to the firmware saying
- *	the change was applied, and for then applying a new mode if it was
- *	updated while waiting for firmware/AP settle delay.
- * @rx_omi.desired_bw: desired bandwidth
- * @rx_omi.last_max_bw: last maximum BW used by firmware, for AP BW changes
  */
 struct iwl_mld_link {
 	struct rcu_head rcu_head;
@@ -71,19 +61,9 @@ struct iwl_mld_link {
 		struct ieee80211_key_conf *igtk;
 	);
 	/* And here fields that survive a fw restart */
-	struct ieee80211_vif *vif;
 	struct iwl_mld_int_sta bcast_sta;
 	struct iwl_mld_int_sta mcast_sta;
 	struct iwl_mld_int_sta mon_sta;
-	u8 link_id;
-
-	struct {
-		struct wiphy_delayed_work finished_work;
-		unsigned long exit_ts;
-		enum ieee80211_sta_rx_bandwidth bw_in_progress,
-						desired_bw,
-						last_max_bw;
-	} rx_omi;
 
 	/* we can only have 2 GTK + 2 IGTK + 2 BIGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[6];
@@ -123,9 +103,6 @@ int iwl_mld_activate_link(struct iwl_mld *mld,
 			  struct ieee80211_bss_conf *link);
 void iwl_mld_deactivate_link(struct iwl_mld *mld,
 			     struct ieee80211_bss_conf *link);
-int iwl_mld_change_link_omi_bw(struct iwl_mld *mld,
-			       struct ieee80211_bss_conf *link,
-			       enum ieee80211_sta_rx_bandwidth bw);
 int iwl_mld_change_link_in_fw(struct iwl_mld *mld,
 			      struct ieee80211_bss_conf *link, u32 changes);
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
@@ -145,13 +122,6 @@ unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
 int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf,
 				    bool expect_active_link);
-void iwl_mld_handle_omi_status_notif(struct iwl_mld *mld,
-				     struct iwl_rx_packet *pkt);
-void iwl_mld_leave_omi_bw_reduction(struct iwl_mld *mld);
-void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld);
-void iwl_mld_omi_ap_changed_bw(struct iwl_mld *mld,
-			       struct ieee80211_bss_conf *link_conf,
-			       enum ieee80211_sta_rx_bandwidth bw);
 
 void iwl_mld_handle_beacon_filter_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
index f7faa87b8ba6..23362867b400 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
@@ -224,9 +224,6 @@ void iwl_mld_vif_update_low_latency(struct iwl_mld *mld,
 		return;
 	}
 
-	if (low_latency)
-		iwl_mld_leave_omi_bw_reduction(mld);
-
 	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_P2P_CLIENT)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 3ea6d4c1b779..b0bd01914a91 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1015,8 +1015,6 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (n_active > 1) {
 		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
-		iwl_mld_leave_omi_bw_reduction(mld);
-
 		/* Indicate to mac80211 that EML is enabled */
 		vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
 		mld_vif->emlsr.last_entry_ts = jiffies;
@@ -1212,20 +1210,6 @@ iwl_mld_mac80211_link_info_changed_sta(struct iwl_mld *mld,
 	if (changes & (BSS_CHANGED_CQM | BSS_CHANGED_BEACON_INFO))
 		iwl_mld_enable_beacon_filter(mld, link_conf, false);
 
-	/* If we have used OMI before to reduce bandwidth to 80 MHz and then
-	 * increased to 160 MHz again, and then the AP changes to 320 MHz, it
-	 * will think that we're limited to 160 MHz right now. Update it by
-	 * requesting a new OMI bandwidth.
-	 */
-	if (changes & BSS_CHANGED_BANDWIDTH) {
-		enum ieee80211_sta_rx_bandwidth bw;
-
-		bw = ieee80211_chan_width_to_rx_bw(link_conf->chanreq.oper.width);
-
-		iwl_mld_omi_ap_changed_bw(mld, link_conf, bw);
-
-	}
-
 	if (changes & BSS_CHANGED_BANDWIDTH)
 		iwl_mld_retry_emlsr(mld, vif);
 }
@@ -1428,30 +1412,6 @@ iwl_mld_mac80211_sched_scan_stop(struct ieee80211_hw *hw,
 	return iwl_mld_scan_stop(mld, IWL_MLD_SCAN_SCHED, false);
 }
 
-static void
-iwl_mld_restart_complete_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct ieee80211_bss_conf *link_conf;
-	struct iwl_mld *mld = data;
-	int link_id;
-
-	for_each_vif_active_link(vif, link_conf, link_id) {
-		enum ieee80211_sta_rx_bandwidth bw;
-		struct iwl_mld_link *mld_link;
-
-		mld_link = wiphy_dereference(mld->wiphy,
-					     mld_vif->link[link_id]);
-
-		if (WARN_ON_ONCE(!mld_link))
-			continue;
-
-		bw = mld_link->rx_omi.bw_in_progress;
-		if (bw)
-			iwl_mld_change_link_omi_bw(mld, link_conf, bw);
-	}
-}
-
 static void
 iwl_mld_mac80211_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type)
@@ -1462,11 +1422,6 @@ iwl_mld_mac80211_reconfig_complete(struct ieee80211_hw *hw,
 	case IEEE80211_RECONFIG_TYPE_RESTART:
 		mld->fw_status.in_hw_restart = false;
 		iwl_mld_send_recovery_cmd(mld, ERROR_RECOVERY_END_OF_RECOVERY);
-
-		ieee80211_iterate_interfaces(mld->hw,
-					     IEEE80211_IFACE_ITER_NORMAL,
-					     iwl_mld_restart_complete_vif, mld);
-
 		iwl_trans_finish_sw_reset(mld->trans);
 		/* no need to lock, adding in parallel would schedule too */
 		if (!list_empty(&mld->txqs_to_add))
@@ -1690,18 +1645,6 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 				return -EBUSY;
 		}
 
-		/*
-		 * If this is the first STA (i.e. the AP) it won't do
-		 * anything, otherwise must leave for any new STA on
-		 * any other interface, or for TDLS, etc.
-		 * Need to call this _before_ adding the STA so it can
-		 * look up the one STA to use to ask mac80211 to leave
-		 * OMI; in the unlikely event that adding the new STA
-		 * then fails we'll just re-enter OMI later (via the
-		 * statistics notification handling.)
-		 */
-		iwl_mld_leave_omi_bw_reduction(mld);
-
 		ret = iwl_mld_add_sta(mld, sta, vif, STATION_TYPE_PEER);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index e78e7a4f39d1..7b46ccc306ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -251,7 +251,6 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(RX_BAID_ALLOCATION_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
-	HCMD_NAME(OMI_SEND_STATUS_NOTIF),
 	HCMD_NAME(ESR_MODE_NOTIF),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index e8f10e8145f9..f17aeca4fae6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -78,13 +78,6 @@ static bool iwl_mld_cancel_##name##_notif(struct iwl_mld *mld,			\
 				  u8: (notif)->id_member);			\
 }
 
-static bool iwl_mld_always_cancel(struct iwl_mld *mld,
-				  struct iwl_rx_packet *pkt,
-				  u32 obj_id)
-{
-	return true;
-}
-
 /* Currently only defined for the RX_HANDLER_SIZES options. Use this for
  * notifications that belong to a specific object, and that should be
  * canceled when the object is removed
@@ -350,8 +343,6 @@ CMD_VERSIONS(time_msmt_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_notify))
 CMD_VERSIONS(time_sync_confirm_notif,
 	     CMD_VER_ENTRY(1, iwl_time_msmt_cfm_notify))
-CMD_VERSIONS(omi_status_notif,
-	     CMD_VER_ENTRY(2, iwl_omi_send_status_notif))
 CMD_VERSIONS(ftm_resp_notif, CMD_VER_ENTRY(10, iwl_tof_range_rsp_ntfy))
 CMD_VERSIONS(beacon_filter_notif, CMD_VER_ENTRY(2, iwl_beacon_filter_notif))
 
@@ -369,7 +360,6 @@ DEFINE_SIMPLE_CANCELLATION(probe_resp_data, iwl_probe_resp_data_notif,
 			   mac_id)
 DEFINE_SIMPLE_CANCELLATION(uapsd_misbehaving_ap, iwl_uapsd_misbehaving_ap_notif,
 			   mac_id)
-#define iwl_mld_cancel_omi_status_notif iwl_mld_always_cancel
 DEFINE_SIMPLE_CANCELLATION(ftm_resp, iwl_tof_range_rsp_ntfy, request_id)
 DEFINE_SIMPLE_CANCELLATION(beacon_filter, iwl_beacon_filter_notif, link_id)
 
@@ -466,8 +456,6 @@ const struct iwl_rx_handler iwl_mld_rx_handlers[] = {
 	RX_HANDLER_NO_OBJECT(LEGACY_GROUP,
 			     WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION,
 			     time_sync_confirm_notif, RX_HANDLER_ASYNC)
-	RX_HANDLER_OF_LINK(DATA_PATH_GROUP, OMI_SEND_STATUS_NOTIF,
-			   omi_status_notif)
 	RX_HANDLER_OF_LINK(DATA_PATH_GROUP, BEACON_FILTER_IN_NOTIF,
 			   beacon_filter_notif)
 	RX_HANDLER_OF_FTM_REQ(LOCATION_GROUP, TOF_RANGE_RESPONSE_NOTIF,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index f633cb1cf510..cbc64db5eab6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -508,8 +508,6 @@ void iwl_mld_handle_stats_oper_notif(struct iwl_mld *mld,
 	iwl_mld_process_per_link_stats(mld, stats->per_link, curr_ts_usec);
 	iwl_mld_process_per_sta_stats(mld, stats->per_sta);
 	iwl_mld_process_per_phy_stats(mld, stats->per_phy);
-
-	iwl_mld_check_omi_bw_reduction(mld);
 }
 
 void iwl_mld_handle_stats_oper_part1_notif(struct iwl_mld *mld,
-- 
2.34.1


