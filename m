Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28849020F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHPM4D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 08:56:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36132 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbfHPM4D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 08:56:03 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hyblx-00066W-4s; Fri, 16 Aug 2019 15:56:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 16 Aug 2019 15:55:51 +0300
Message-Id: <20190816125554.8659-2-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816125554.8659-1-luca@coelho.fi>
References: <20190816125554.8659-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 1/4] iwlwifi: mvm: Allow multicast data frames only when associated
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The MAC context configuration always allowed multicast data frames
to pass to the driver for all MAC context types, and in the
case of station MAC context both when associated and when not
associated.

One of the outcomes of this configuration is having the FW forward
encrypted multicast frames to the driver with Rx status indicating
that the frame was not decrypted (as expected, since no keys were
configured yet) which in turn results with unnecessary error
messages.

Change this behavior to allow multicast data frames only when they
are actually expected, e.g., station MAC context is associated etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 33 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cb22d447fcb8..fe776e35b9d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -554,7 +554,7 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 		cpu_to_le32(vif->bss_conf.use_short_slot ?
 			    MAC_FLG_SHORT_SLOT : 0);
 
-	cmd->filter_flags = cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
+	cmd->filter_flags = 0;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		u8 txf = iwl_mvm_mac_ac_to_tx_fifo(mvm, i);
@@ -623,6 +623,8 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	/* We need the dtim_period to set the MAC as associated */
 	if (vif->bss_conf.assoc && vif->bss_conf.dtim_period &&
 	    !force_assoc_off) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		u8 ap_sta_id = mvmvif->ap_sta_id;
 		u32 dtim_offs;
 
 		/*
@@ -658,6 +660,29 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 			       dtim_offs);
 
 		ctxt_sta->is_assoc = cpu_to_le32(1);
+
+		/*
+		 * allow multicast data frames only as long as the station is
+		 * authorized, i.e., GTK keys are already installed (if needed)
+		 */
+		if (ap_sta_id < IWL_MVM_STATION_COUNT) {
+			struct ieee80211_sta *sta;
+
+			rcu_read_lock();
+
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
+			if (!IS_ERR_OR_NULL(sta)) {
+				struct iwl_mvm_sta *mvmsta =
+					iwl_mvm_sta_from_mac80211(sta);
+
+				if (mvmsta->sta_state ==
+				    IEEE80211_STA_AUTHORIZED)
+					cmd.filter_flags |=
+						cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
+			}
+
+			rcu_read_unlock();
+		}
 	} else {
 		ctxt_sta->is_assoc = cpu_to_le32(0);
 
@@ -703,7 +728,8 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 				       MAC_FILTER_IN_CONTROL_AND_MGMT |
 				       MAC_FILTER_IN_BEACON |
 				       MAC_FILTER_IN_PROBE_REQUEST |
-				       MAC_FILTER_IN_CRC32);
+				       MAC_FILTER_IN_CRC32 |
+				       MAC_FILTER_ACCEPT_GRP);
 	ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
 
 	/* Allocate sniffer station */
@@ -727,7 +753,8 @@ static int iwl_mvm_mac_ctxt_cmd_ibss(struct iwl_mvm *mvm,
 	iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
 
 	cmd.filter_flags = cpu_to_le32(MAC_FILTER_IN_BEACON |
-				       MAC_FILTER_IN_PROBE_REQUEST);
+				       MAC_FILTER_IN_PROBE_REQUEST |
+				       MAC_FILTER_ACCEPT_GRP);
 
 	/* cmd.ibss.beacon_time/cmd.ibss.beacon_tsf are curently ignored */
 	cmd.ibss.bi = cpu_to_le32(vif->bss_conf.beacon_int);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1c904b5226aa..a7bc00d1296f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3327,10 +3327,20 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		/* enable beacon filtering */
 		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
 
+		/*
+		 * Now that the station is authorized, i.e., keys were already
+		 * installed, need to indicate to the FW that
+		 * multicast data frames can be forwarded to the driver
+		 */
+		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+
 		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
 				     true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
+		/* Multicast data frames are no longer allowed */
+		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+
 		/* disable beacon filtering */
 		ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
 		WARN_ON(ret &&
-- 
2.23.0.rc1

