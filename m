Return-Path: <linux-wireless+bounces-3743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4F859850
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926F21C20F1F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1F6F06D;
	Sun, 18 Feb 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJuEhCt8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E2376EE
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278728; cv=none; b=e35yw0UXH5sUuaCNnQm+3rBSaFH8tzpLj3dMOfvVz2C4ny0qvDskOiYg0lh1m7dl5Nk1sgUPc03yC34Nx3JSk6OYFzXNOjE93emKiHGnYLViHBMEhGcnBHg9xZEE5HAFU8fKQi/eRWNRhnYtVSbm73TDYtOP4C2ezzykGsf46nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278728; c=relaxed/simple;
	bh=l1QNI+GfiWgKMyKVEKmBhJtMWhQKoUOmC1CmzP9NMm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAyVfZYNvjHToeM8v1+BoWvRwUjxspp/mVwkafYQwMjInmcchsMiwZjYOAXRhf9F4gUk/cBfXo1Cmq7hMCp6cKnNT9JQQcCy0CEBP9cUJohbrELgBqe6GhzHQI06rQZoe51ms7qlqJKs6s3G/jHg8UzgTq5HODKv7y+aRP8eir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJuEhCt8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278726; x=1739814726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1QNI+GfiWgKMyKVEKmBhJtMWhQKoUOmC1CmzP9NMm0=;
  b=lJuEhCt8OdmSmYJ28Divs4X2u/Lj5VxUJ9M9MyVLUpYV23nbo1K8GZJ8
   dYY3DR5lANTsAqYvSMRueNMdU7Z9Db0VZy1JcmNYwCKrLwt8gsUK/iJAX
   vlcEQfxIN7rIxKVYg+0uCv+MHaVhpRFFTf1U4V2m8kq2IqnzItE++4y+s
   NX7VRwRkqswzLA8fMshAlGy6ADK1Z1k6Y9St6+khOe2tHujzem6TgV0Ay
   Q3vBL2GBTtxbabSvctp2uoFYedBIYQrZT0HBM48+LVGhmZw/yxOy1ed1R
   1H6R8NgpLSNbXYPXJc113Wu1eBGagczpC82YRPzdjdIcAV+DBLC0yBh2g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464970"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464970"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459413"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: mvm: support wider-bandwidth OFDMA
Date: Sun, 18 Feb 2024 19:51:42 +0200
Message-Id: <20240218194912.ca666ede5dd6.I357972823d20e9045e2c97dbb7ac24fe9f5a6e41@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

To support wider-bandwidth OFDMA we need to configure the
PHY context in the firmware, which will in turn configure
the DSP accordingly. Pass the relevant information down.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  5 +++--
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  5 +++--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 19 +++++++++++++++----
 6 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b6a9896bce25..9830a3c3600b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -720,7 +720,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_chanctx_conf *ctx;
 	u8 chains_static, chains_dynamic;
-	struct cfg80211_chan_def chandef;
+	struct cfg80211_chan_def chandef, ap_def;
 	int ret, i;
 	struct iwl_binding_cmd_v1 binding_cmd = {};
 	struct iwl_time_quota_cmd quota_cmd = {};
@@ -742,12 +742,13 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EINVAL;
 	}
 	chandef = ctx->def;
+	ap_def = ctx->ap;
 	chains_static = ctx->rx_chains_static;
 	chains_dynamic = ctx->rx_chains_dynamic;
 	rcu_read_unlock();
 
 	ret = iwl_mvm_phy_ctxt_add(mvm, mvmvif->deflink.phy_ctxt, &chandef,
-				   chains_static, chains_dynamic);
+				   &ap_def, chains_static, chains_dynamic);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index aa3c9c2cbd7f..51b01f7528be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -592,7 +592,7 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 
 	for_each_vif_active_link(vif, link_conf, link_id) {
 		struct ieee80211_chanctx_conf *chanctx_conf;
-		struct cfg80211_chan_def min_def;
+		struct cfg80211_chan_def min_def, ap_def;
 		struct iwl_mvm_phy_ctxt *phy_ctxt;
 		u8 chains_static, chains_dynamic;
 
@@ -606,6 +606,7 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 		 * everything here and use it after unlocking
 		 */
 		min_def = chanctx_conf->min_def;
+		ap_def = chanctx_conf->ap;
 		chains_static = chanctx_conf->rx_chains_static;
 		chains_dynamic = chanctx_conf->rx_chains_dynamic;
 		rcu_read_unlock();
@@ -614,7 +615,7 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 		if (!phy_ctxt)
 			continue;
 
-		ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &min_def,
+		ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &min_def, &ap_def,
 					       chains_static, chains_dynamic);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index dca36b0662c7..8e760300a1ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -438,7 +438,7 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	rcu_read_unlock();
 
 	phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
-	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &ctx.def,
+	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &ctx.def, &ctx.ap,
 				       ctx.rx_chains_static,
 				       ctx.rx_chains_dynamic);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 229d87a786df..69f6a96b0cfb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1644,6 +1644,9 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
+	if (vif->p2p || iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) < 5)
+		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
+
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mvm->p2p_device_vif = vif;
 
@@ -4651,7 +4654,7 @@ static int iwl_mvm_p2p_find_phy_ctxt(struct iwl_mvm *mvm,
 	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
 
 	return iwl_mvm_phy_ctxt_add(mvm, mvmvif->deflink.phy_ctxt,
-				    &chandef, 1, 1);
+				    &chandef, NULL, 1, 1);
 }
 
 /* Execute the common part for MLD and non-MLD modes */
@@ -4772,7 +4775,7 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 		goto out;
 	}
 
-	ret = iwl_mvm_phy_ctxt_add(mvm, phy_ctxt, def,
+	ret = iwl_mvm_phy_ctxt_add(mvm, phy_ctxt, def, &ctx->ap,
 				   ctx->rx_chains_static,
 				   ctx->rx_chains_dynamic);
 	if (ret) {
@@ -4850,7 +4853,7 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 	}
 
 	iwl_mvm_bt_coex_vif_change(mvm);
-	iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, def,
+	iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, def, &ctx->ap,
 				 ctx->rx_chains_static,
 				 ctx->rx_chains_dynamic);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ce78c21883e9..fcae5199ac90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1810,9 +1810,11 @@ void iwl_mvm_rx_shared_mem_cfg_notif(struct iwl_mvm *mvm,
 struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm);
 int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			 const struct cfg80211_chan_def *chandef,
+			 const struct cfg80211_chan_def *ap,
 			 u8 chains_static, u8 chains_dynamic);
 int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			     const struct cfg80211_chan_def *chandef,
+			     const struct cfg80211_chan_def *ap,
 			     u8 chains_static, u8 chains_dynamic);
 void iwl_mvm_phy_ctxt_ref(struct iwl_mvm *mvm,
 			  struct iwl_mvm_phy_ctxt *ctxt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index bac655834f32..e208e3c34c25 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -198,12 +198,16 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt,
 				  const struct cfg80211_chan_def *chandef,
+				  const struct cfg80211_chan_def *ap,
 				  u8 chains_static, u8 chains_dynamic,
 				  u32 action)
 {
 	int ret;
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1);
 
+	if (ver < 5 || !ap || !ap->chan)
+		ap = NULL;
+
 	if (ver >= 3 && ver <= 5) {
 		struct iwl_phy_context_cmd cmd = {};
 
@@ -215,6 +219,11 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 					  chains_static,
 					  chains_dynamic);
 
+		if (ap) {
+			cmd.v5.sbb_bandwidth = iwl_mvm_get_channel_width(ap);
+			cmd.v5.sbb_ctrl_channel_loc = iwl_mvm_get_ctrl_pos(ap);
+		}
+
 		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
 					   0, sizeof(cmd), &cmd);
 	} else if (ver < 3) {
@@ -255,6 +264,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
  */
 int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			 const struct cfg80211_chan_def *chandef,
+			 const struct cfg80211_chan_def *ap,
 			 u8 chains_static, u8 chains_dynamic)
 {
 	int ret;
@@ -267,7 +277,7 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	ctxt->center_freq1 = chandef->center_freq1;
 
-	ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
+	ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, ap,
 				     chains_static, chains_dynamic,
 				     FW_CTXT_ACTION_ADD);
 
@@ -301,6 +311,7 @@ void iwl_mvm_phy_ctxt_ref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
  */
 int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			     const struct cfg80211_chan_def *chandef,
+			     const struct cfg80211_chan_def *ap,
 			     u8 chains_static, u8 chains_dynamic)
 {
 	enum iwl_ctxt_action action = FW_CTXT_ACTION_MODIFY;
@@ -324,7 +335,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 		int ret;
 
 		/* ... remove it here ...*/
-		ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
+		ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, NULL,
 					     chains_static, chains_dynamic,
 					     FW_CTXT_ACTION_REMOVE);
 		if (ret)
@@ -338,7 +349,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	ctxt->center_freq1 = chandef->center_freq1;
 
-	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
+	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef, ap,
 				      chains_static, chains_dynamic,
 				      action);
 }
@@ -358,7 +369,7 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 
 	cfg80211_chandef_create(&chandef, ctxt->channel, NL80211_CHAN_NO_HT);
 
-	iwl_mvm_phy_ctxt_apply(mvm, ctxt, &chandef, 1, 1,
+	iwl_mvm_phy_ctxt_apply(mvm, ctxt, &chandef, NULL, 1, 1,
 			       FW_CTXT_ACTION_REMOVE);
 }
 
-- 
2.34.1


