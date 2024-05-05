Return-Path: <linux-wireless+bounces-7189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E968BBF77
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988CB1C20BCB
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F6567F;
	Sun,  5 May 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ir95c8Kh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A70566A
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890035; cv=none; b=dqEy3Pl4uvdXXjzC+mQ1L6Elz5sE4Th/FHZQX/xtRNV5u0aTYchJPR6kIeTedBQtmLQ2R8uQwC3e/C3uySJprrT34CoEPFKmYFprUIVQ5c3Fi+LWdUP0d9bfH3UhtsLxqCTK2iQ4I4DnmHoefPPUqOtjhWx3wKwk6IjR+FzDy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890035; c=relaxed/simple;
	bh=nvH/sUpQtO8+H/saoyTqSZ/kiFPbJPWkQ2+7sFiVb4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER0PpKBULeQ9TWpcUwtCPoTj+GEtpe7HA3K+LrQfZW7L+XuUGkjONiJ2ZoyLa3tKgaaXixVlvFcUMcihsFawHkIlySi3jNzb6rGKms1N3fAirQp/vr2UrBcNNftkU8EYrwV/uNnSHzV3aOqfd7wDq6PJLtHdEfW7VwxAlE3i4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ir95c8Kh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890033; x=1746426033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nvH/sUpQtO8+H/saoyTqSZ/kiFPbJPWkQ2+7sFiVb4w=;
  b=Ir95c8KhqFOhCU7hZBsfTwKbqBD2kYh2tWszPoufW/j3U/hmHjGGC1Gh
   2RAw8Alcb3gNXtcl7DWUQI/32fB4jOqPBMnMAFRuDAU6LDotVe7FGjwuT
   376Nly6v4vXiduX2KVPsxTGdNAfydsr6nRTUL0aPDGt/qKirBOqSWuiG1
   /uWLB0yt5uAUzzfSoJyJ+zOqkF7i8Xa2Npmw0MKITdTuPQRjpKewDNwCJ
   8g/5xqsxc/mcECtLvajIETUqB7ytGc57Q0iQ5THSmtO8wp0d+ARY5MJaR
   r8OhW4H3IocHSfEMGc4WGNXjytx4JpkwoC52Nf8IEupnx1WQhkJhpc00i
   w==;
X-CSE-ConnectionGUID: fX8yPaS3QH2Rmj9N8w210A==
X-CSE-MsgGUID: DaJZEw5TRQe9FXcWUJ513w==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461828"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:33 -0700
X-CSE-ConnectionGUID: WFV1wS3BRgeAV9zfTvHEsQ==
X-CSE-MsgGUID: K2WSq2uDS3az/r9qdwiaow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903623"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: exit EMLSR when CSA happens
Date: Sun,  5 May 2024 09:19:55 +0300
Message-Id: <20240505091420.3ffff9577f08.I2620971fa5aef789e0d4a588def4c2621e8bed5b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If CSA is happening, then exit EMLSR to keep the better link,
which is the primary link unless that's doing the CSA with
quiet. This is done because we can't transmit the OMN frame
on a quiet link, but want to exit EMLSR during CSA for better
beacon reception, so we can follow the switch accurately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  9 ++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 48 ++++++++++---------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 41 +++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 39 ++++++++++++++-
 5 files changed, 115 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index b2a52e7b4a1c..db2d3f63f4e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -597,9 +597,15 @@ iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct wiphy *wiphy = mvm->hw->wiphy;
+	struct ieee80211_bss_conf *conf;
 	enum iwl_mvm_esr_state ret = 0;
 	s8 thresh;
 
+	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
+	if (WARN_ON_ONCE(!conf))
+		return false;
+
 	/* BT Coex effects eSR mode only if one of the links is on LB */
 	if (link->chandef->chan->band == NL80211_BAND_2GHZ &&
 	    (!iwl_mvm_bt_coex_calculate_esr_mode(mvm, vif, link->signal,
@@ -612,6 +618,9 @@ iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
 	if (link->signal < thresh)
 		ret |= IWL_MVM_ESR_EXIT_LOW_RSSI;
 
+	if (conf->csa_active)
+		ret |= IWL_MVM_ESR_EXIT_CSA;
+
 	if (ret)
 		IWL_DEBUG_INFO(mvm,
 			       "Link %d is not allowed for esr. Reason: 0x%x\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 61b3c45e3f0c..f28ffefd434e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5570,17 +5570,16 @@ static void iwl_mvm_csa_block_txqs(void *data, struct ieee80211_sta *sta)
 }
 
 #define IWL_MAX_CSA_BLOCK_TX 1500
-int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
+int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_channel_switch *chsw)
 {
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_vif *csa_vif;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_txq *mvmtxq;
 	int ret;
 
-	mutex_lock(&mvm->mutex);
+	lockdep_assert_held(&mvm->mutex);
 
 	mvmvif->csa_failed = false;
 	mvmvif->csa_blocks_tx = false;
@@ -5598,25 +5597,19 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 			rcu_dereference_protected(mvm->csa_vif,
 						  lockdep_is_held(&mvm->mutex));
 		if (WARN_ONCE(csa_vif && csa_vif->bss_conf.csa_active,
-			      "Another CSA is already in progress")) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+			      "Another CSA is already in progress"))
+			return -EBUSY;
 
 		/* we still didn't unblock tx. prevent new CS meanwhile */
 		if (rcu_dereference_protected(mvm->csa_tx_blocked_vif,
-					      lockdep_is_held(&mvm->mutex))) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+					      lockdep_is_held(&mvm->mutex)))
+			return -EBUSY;
 
 		rcu_assign_pointer(mvm->csa_vif, vif);
 
 		if (WARN_ONCE(mvmvif->csa_countdown,
-			      "Previous CSA countdown didn't complete")) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+			      "Previous CSA countdown didn't complete"))
+			return -EBUSY;
 
 		mvmvif->csa_target_freq = chsw->chandef.chan->center_freq;
 
@@ -5650,10 +5643,8 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 		 * we don't know the dtim period. In this case, the firmware can't
 		 * track the beacons.
 		 */
-		if (!vif->cfg.assoc || !vif->bss_conf.dtim_period) {
-			ret = -EBUSY;
-			goto out_unlock;
-		}
+		if (!vif->cfg.assoc || !vif->bss_conf.dtim_period)
+			return -EBUSY;
 
 		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX &&
 		    hweight16(vif->valid_links) <= 1)
@@ -5675,7 +5666,7 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
 			ret = iwl_mvm_old_pre_chan_sw_sta(mvm, vif, chsw);
 			if (ret)
-				goto out_unlock;
+				return ret;
 		} else {
 			iwl_mvm_schedule_client_csa(mvm, vif, chsw);
 		}
@@ -5691,12 +5682,23 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 
 	ret = iwl_mvm_power_update_ps(mvm);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	/* we won't be on this channel any longer */
 	iwl_mvm_teardown_tdls_peers(mvm);
 
-out_unlock:
+	return ret;
+}
+
+static int iwl_mvm_mac_pre_channel_switch(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_channel_switch *chsw)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+	ret = iwl_mvm_pre_channel_switch(mvm, vif, chsw);
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
@@ -6482,7 +6484,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.set_tim = iwl_mvm_set_tim,
 
 	.channel_switch = iwl_mvm_channel_switch,
-	.pre_channel_switch = iwl_mvm_pre_channel_switch,
+	.pre_channel_switch = iwl_mvm_mac_pre_channel_switch,
 	.post_channel_switch = iwl_mvm_post_channel_switch,
 	.abort_channel_switch = iwl_mvm_abort_channel_switch,
 	.channel_switch_rx_beacon = iwl_mvm_channel_switch_rx_beacon,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index de04b44bcf48..748c72cbb2dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1290,6 +1290,45 @@ iwl_mvm_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return NEG_TTLM_RES_ACCEPT;
 }
 
+static int
+iwl_mvm_mld_mac_pre_channel_switch(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_channel_switch *chsw)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+	if (mvmvif->esr_active) {
+		u8 primary = iwl_mvm_get_primary_link(vif);
+		int selected;
+
+		/* prefer primary unless quiet CSA on it */
+		if (chsw->link_id == primary && chsw->block_tx)
+			selected = iwl_mvm_get_other_link(vif, primary);
+		else
+			selected = primary;
+
+		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_CSA, selected);
+		mutex_unlock(&mvm->mutex);
+
+		/*
+		 * If we've not kept the link active that's doing the CSA
+		 * then we don't need to do anything else, just return.
+		 */
+		if (selected != chsw->link_id)
+			return 0;
+
+		mutex_lock(&mvm->mutex);
+	}
+
+	ret = iwl_mvm_pre_channel_switch(mvm, vif, chsw);
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1343,7 +1382,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx_last_beacon = iwl_mvm_tx_last_beacon,
 
 	.channel_switch = iwl_mvm_channel_switch,
-	.pre_channel_switch = iwl_mvm_pre_channel_switch,
+	.pre_channel_switch = iwl_mvm_mld_mac_pre_channel_switch,
 	.post_channel_switch = iwl_mvm_post_channel_switch,
 	.abort_channel_switch = iwl_mvm_abort_channel_switch,
 	.channel_switch_rx_beacon = iwl_mvm_channel_switch_rx_beacon,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 433b29334039..96d29eae8903 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -365,6 +365,7 @@ struct iwl_mvm_vif_link_info {
  *	due to BT Coex.
  * @IWL_MVM_ESR_EXIT_BANDWIDTH: Bandwidths of primary and secondry links
  *	preventing the enablement of EMLSR
+ * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -375,6 +376,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_LOW_RSSI	= 0x20000,
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
+	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
@@ -2818,7 +2820,7 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw);
 void iwl_mvm_channel_switch(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_channel_switch *chsw);
-int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
+int iwl_mvm_pre_channel_switch(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif,
 			       struct ieee80211_channel_switch *chsw);
 void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index 66dd89103dfe..f49e3c98b1ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -10,6 +10,14 @@
 
 MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 
+static struct wiphy wiphy = {
+	.mtx = __MUTEX_INITIALIZER(wiphy.mtx),
+};
+
+static struct ieee80211_hw hw = {
+	.wiphy = &wiphy,
+};
+
 static struct ieee80211_channel chan_5ghz = {
 	.band = NL80211_BAND_5GHZ,
 };
@@ -50,7 +58,10 @@ static struct iwl_fw fw = {
 	},
 };
 
-static struct iwl_mvm mvm = {.fw = &fw};
+static struct iwl_mvm mvm = {
+	.hw = &hw,
+	.fw = &fw,
+};
 
 static const struct link_grading_case {
 	const char *desc;
@@ -237,6 +248,7 @@ static const struct valid_link_pair_case {
 	enum nl80211_chan_width cw_b;
 	s32 sig_a;
 	s32 sig_b;
+	bool csa_a;
 	bool valid;
 } valid_link_pair_cases[] = {
 	{
@@ -335,6 +347,17 @@ static const struct valid_link_pair_case {
 		.cw_b = NL80211_CHAN_WIDTH_160,
 		.valid = true,
 	},
+	{
+		.desc = "CSA active",
+		.chan_a = &chan_6ghz,
+		.cw_a = NL80211_CHAN_WIDTH_160,
+		.sig_a = -5,
+		.chan_b = &chan_5ghz,
+		.cw_b = NL80211_CHAN_WIDTH_160,
+		.valid = false,
+		/* same as previous entry with valid=true except for CSA */
+		.csa_a = true,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(valid_link_pair, valid_link_pair_cases, desc)
@@ -358,6 +381,7 @@ static void test_valid_link_pair(struct kunit *test)
 		.link_id = 5,
 		.signal = params->sig_b,
 	};
+	struct ieee80211_bss_conf *conf;
 	bool result;
 
 	KUNIT_ASSERT_NOT_NULL(test, vif);
@@ -377,7 +401,20 @@ static void test_valid_link_pair(struct kunit *test)
 	mvm.last_bt_notif.wifi_loss_low_rssi = params->bt;
 	mvmvif->mvm = &mvm;
 
+	conf = kunit_kzalloc(test, sizeof(*vif->link_conf[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conf);
+	conf->chanreq.oper = chandef_a;
+	conf->csa_active = params->csa_a;
+	vif->link_conf[link_a.link_id] = (void __rcu *)conf;
+
+	conf = kunit_kzalloc(test, sizeof(*vif->link_conf[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conf);
+	conf->chanreq.oper = chandef_b;
+	vif->link_conf[link_b.link_id] = (void __rcu *)conf;
+
+	wiphy_lock(&wiphy);
 	result = iwl_mvm_mld_valid_link_pair(vif, &link_a, &link_b);
+	wiphy_unlock(&wiphy);
 
 	KUNIT_EXPECT_EQ(test, result, params->valid);
 
-- 
2.34.1


