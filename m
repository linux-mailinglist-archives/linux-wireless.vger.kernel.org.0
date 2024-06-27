Return-Path: <linux-wireless+bounces-9656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E57E91A50D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 13:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE46BB227A5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB61494A1;
	Thu, 27 Jun 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BmFhZB9h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956F1487FF
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487534; cv=none; b=rmLb7KTMqSRuticUd2vjdfSvxar89N52dinyUcQhMFVR91kT9irFrpz7F5wPqQTM4YtAsRptNEihrwrcGEnnAO+/ffT9RYU0fZD3unMIMnGX9H1Iom2ueGxVM33YfymD2jjx6mDbLoE7SxmO+uLu2qjQvlAXUOSEuUdcK95eiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487534; c=relaxed/simple;
	bh=OQVkXGAKZC4V+FMjSzQ4pinUn06xkdZWqGY1k2Dr+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPz7zMjwjJRUrOBCrR4WdQTtdqvvERrUNW5IrnOsLt+On4kJ/tDUbMwvpXbtjx8xgGS5gsabqo7DTafx0EXZmsqXvFFS2vrRLrRdeMX89/v+oMFEWYTnJIXezLvz6bzeJ67FjoxbwNPYLYRFNuiMpHm9JDgd1yYCSpUAAytxolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BmFhZB9h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=xM+JqIIuQbfJG0h2/gQPmznlxs1chJOoweI/IY1k4aY=; t=1719487532; x=1720697132; 
	b=BmFhZB9hC1RcwaB6Bs9UzJ/wEsCbSMUrxKdvTqpCfut7+DFnciWrn2WzKU0V+EO+iCHFwGekd66
	l7yvxTLvS+YSpTqziJdA04GW3u5gL7HeNk+0XkcyqMxs4G9ChrxJdGm6NHAcL1YTQg5nzYEqC3vvW
	ZSdDWjFbw5ft3Ugp8MIHaWIlC9P0XjZmgbInSk7rWWr+RnnMnm3N5b/1R6SStRFHMm9bh0zKkBUje
	X/pyYQmy2vL1cYDBpnTnAyIjMniuSz8CRKc5QpsFu18TQfKlCgUUTsNANyoNDkKP4OwvUFuw9Kztt
	pGdimFU82VT99XwSpmESRLv0x4YppLAzzM+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMnFp-00000006yCf-25yD;
	Thu, 27 Jun 2024 13:25:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH v2] wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP
Date: Thu, 27 Jun 2024 13:25:27 +0200
Message-ID: <20240627132527.94924bcc9c9e.I328a219e45f2e2724cd52e75bb9feee3bf21a463@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This flag is annoying because it puts a lot of logic into mac80211
that could just as well be in the driver (only iwlmvm uses it) and
the implementation is also broken for MLO.

Remove the flag in favour of calling drv_mgd_prepare_tx() without
any conditions even for the deauth-while-assoc case. The drivers
that implement it can take the appropriate actions, which for the
only user of DEAUTH_NEED_MGD_TX_PREP (iwlmvm) is a bit more tricky
than the implementation in mac80211 is anyway, and all others have
no need and can just exit if info->was_assoc is set.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: simplify link_id assignment in ieee80211_set_disassoc() [Jonas Gorski]
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++-----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +++
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  2 ++
 include/net/mac80211.h                        | 22 +++++-----------
 net/mac80211/debugfs.c                        |  1 -
 net/mac80211/main.c                           |  3 ---
 net/mac80211/mlme.c                           | 26 +++----------------
 8 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d29531d95353..f6ff67fced29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -383,12 +383,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (!mvm->mld_api_is_used)
 		ieee80211_hw_set(hw, TIMING_BEACON_ONLY);
 
-	/* We should probably have this, but mac80211
-	 * currently doesn't support it for MLO.
-	 */
-	if (!(hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
-		ieee80211_hw_set(hw, DEAUTH_NEED_MGD_TX_PREP);
-
 	/*
 	 * On older devices, enabling TX A-MSDU occasionally leads to
 	 * something getting messed up, the command read from the FIFO
@@ -2853,6 +2847,8 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 
 	if (changes & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
+			mvmvif->session_prot_connection_loss = false;
+
 			/* clear statistics to get clean beacon counter */
 			iwl_mvm_request_statistics(mvm, true);
 			for_each_mvm_vif_valid_link(mvmvif, i)
@@ -4268,8 +4264,12 @@ void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_prep_tx_info *info)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
+	if (info->was_assoc && !mvmvif->session_prot_connection_loss)
+		return;
+
 	guard(mvm)(mvm);
 	iwl_mvm_protect_assoc(mvm, vif, info->duration, info->link_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ebf313e161f4..3c99396ad369 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -873,6 +873,8 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 	if (changes & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
+			mvmvif->session_prot_connection_loss = false;
+
 			/* clear statistics to get clean beacon counter */
 			iwl_mvm_request_statistics(mvm, true);
 			iwl_mvm_sf_update(mvm, vif, false);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 362973fdeac0..393ce424c196 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -450,6 +450,9 @@ struct iwl_mvm_esr_exit {
  * @unblock_esr_tpt_wk: work for unblocking EMLSR when tpt is high enough.
  * @roc_activity: currently running ROC activity for this vif (or
  *	ROC_NUM_ACTIVITIES if no activity is running).
+ * @session_prot_connection_loss: the connection was lost due to session
+ *	protection ending without receiving a beacon, so we need to now
+ *	protect the deauth separately
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -463,6 +466,7 @@ struct iwl_mvm_vif {
 	bool pm_enabled;
 	bool monitor_active;
 	bool esr_active;
+	bool session_prot_connection_loss;
 
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 98490866a7f5..b96a337e066e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -222,6 +222,8 @@ static bool iwl_mvm_te_check_disconnect(struct iwl_mvm *mvm,
 		iwl_dbg_tlv_time_point(&mvm->fwrt,
 				       IWL_FW_INI_TIME_POINT_ASSOC_FAILED,
 				       NULL);
+
+		mvmvif->session_prot_connection_loss = true;
 	}
 
 	iwl_mvm_connection_loss(mvm, vif, errmsg);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9c96e8ae9ef7..bd0f8aefa797 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2767,14 +2767,6 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_TDLS_BUFFER_STA: Hardware supports buffer STA on
  *	TDLS links.
  *
- * @IEEE80211_HW_DEAUTH_NEED_MGD_TX_PREP: The driver requires the
- *	mgd_prepare_tx() callback to be called before transmission of a
- *	deauthentication frame in case the association was completed but no
- *	beacon was heard. This is required in multi-channel scenarios, where the
- *	virtual interface might not be given air time for the transmission of
- *	the frame, as it is not synced with the AP/P2P GO yet, and thus the
- *	deauthentication frame might not be transmitted.
- *
  * @IEEE80211_HW_DOESNT_SUPPORT_QOS_NDP: The driver (or firmware) doesn't
  *	support QoS NDP for AP probing - that's most likely a driver bug.
  *
@@ -2874,7 +2866,6 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_REPORTS_LOW_ACK,
 	IEEE80211_HW_SUPPORTS_TX_FRAG,
 	IEEE80211_HW_SUPPORTS_TDLS_BUFFER_STA,
-	IEEE80211_HW_DEAUTH_NEED_MGD_TX_PREP,
 	IEEE80211_HW_DOESNT_SUPPORT_QOS_NDP,
 	IEEE80211_HW_BUFF_MMPDU_TXQ,
 	IEEE80211_HW_SUPPORTS_VHT_EXT_NSS_BW,
@@ -3787,13 +3778,15 @@ enum ieee80211_reconfig_type {
  * @success: whether the frame exchange was successful, only
  *	used with the mgd_complete_tx() method, and then only
  *	valid for auth and (re)assoc.
+ * @was_assoc: set if this call is due to deauth/disassoc
+ *	while just having been associated
  * @link_id: the link id on which the frame will be TX'ed.
  *	Only used with the mgd_prepare_tx() method.
  */
 struct ieee80211_prep_tx_info {
 	u16 duration;
 	u16 subtype;
-	u8 success:1;
+	u8 success:1, was_assoc:1;
 	int link_id;
 };
 
@@ -4242,12 +4235,9 @@ struct ieee80211_prep_tx_info {
  *	yet it need not necessarily be given airtime, in particular since any
  *	transmission to a P2P GO needs to be synchronized against the GO's
  *	powersave state. mac80211 will call this function before transmitting a
- *	management frame prior to having successfully associated to allow the
- *	driver to give it channel time for the transmission, to get a response
- *	and to be able to synchronize with the GO.
- *	For drivers that set %IEEE80211_HW_DEAUTH_NEED_MGD_TX_PREP, mac80211
- *	would also call this function before transmitting a deauthentication
- *	frame in case that no beacon was heard from the AP/P2P GO.
+ *	management frame prior to transmitting that frame to allow the driver
+ *	to give it channel time for the transmission, to get a response and be
+ *	able to synchronize with the GO.
  *	The callback will be called before each transmission and upon return
  *	mac80211 will transmit the frame right away.
  *	Additional information is passed in the &struct ieee80211_prep_tx_info
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 98310188f330..02b5476a4376 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -483,7 +483,6 @@ static const char *hw_flag_names[] = {
 	FLAG(REPORTS_LOW_ACK),
 	FLAG(SUPPORTS_TX_FRAG),
 	FLAG(SUPPORTS_TDLS_BUFFER_STA),
-	FLAG(DEAUTH_NEED_MGD_TX_PREP),
 	FLAG(DOESNT_SUPPORT_QOS_NDP),
 	FLAG(BUFF_MMPDU_TXQ),
 	FLAG(SUPPORTS_VHT_EXT_NSS_BW),
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index c8cb091b5ea3..3290e8478d0d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1160,9 +1160,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 		if (WARN_ON(!ieee80211_hw_check(hw, AP_LINK_PS)))
 			return -EINVAL;
-
-		if (WARN_ON(ieee80211_hw_check(hw, DEAUTH_NEED_MGD_TX_PREP)))
-			return -EINVAL;
 	}
 
 #ifdef CONFIG_PM
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3d207d79d11f..f78c05dcb221 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3521,6 +3521,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	u64 changed = 0;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = stype,
+		.was_assoc = true,
+		.link_id = ffs(sdata->vif.active_links) - 1,
 	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3569,29 +3571,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* deauthenticate/disassociate now */
 	if (tx || frame_buf) {
-		/*
-		 * In multi channel scenarios guarantee that the virtual
-		 * interface is granted immediate airtime to transmit the
-		 * deauthentication frame by calling mgd_prepare_tx, if the
-		 * driver requested so.
-		 */
-		if (ieee80211_hw_check(&local->hw, DEAUTH_NEED_MGD_TX_PREP)) {
-			for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
-			     link_id++) {
-				struct ieee80211_link_data *link;
-
-				link = sdata_dereference(sdata->link[link_id],
-							 sdata);
-				if (!link)
-					continue;
-				if (link->u.mgd.have_beacon)
-					break;
-			}
-			if (link_id == IEEE80211_MLD_MAX_NUM_LINKS) {
-				info.link_id = ffs(sdata->vif.active_links) - 1;
-				drv_mgd_prepare_tx(sdata->local, sdata, &info);
-			}
-		}
+		drv_mgd_prepare_tx(sdata->local, sdata, &info);
 
 		ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
 					       sdata->vif.cfg.ap_addr, stype,
-- 
2.45.2


