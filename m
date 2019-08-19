Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430DD94AE9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfHSQu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37132 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727920AbfHSQu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:57 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrT-0007zi-Hh; Mon, 19 Aug 2019 19:50:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:50:03 +0300
Message-Id: <20190819165007.10181-19-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 18/22] iwlwifi: mvm: remove iwl_mvm_update_d0i3_power_mode
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Also change the signature of the power functions that won't
receive d0i3=true anymore.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 -
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 82 +++----------------
 2 files changed, 11 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4a9e8ae99cac..15780e994a30 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1845,9 +1845,6 @@ iwl_mvm_beacon_filter_debugfs_parameters(struct ieee80211_vif *vif,
 					 struct iwl_beacon_filter_cmd *cmd)
 {}
 #endif
-int iwl_mvm_update_d0i3_power_mode(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif,
-				   bool enable, u32 flags);
 int iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 u32 flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 36f5fa1ee793..22136e4832ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -127,12 +127,11 @@ int iwl_mvm_beacon_filter_send_cmd(struct iwl_mvm *mvm,
 static
 void iwl_mvm_beacon_filter_set_cqm_params(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
-					  struct iwl_beacon_filter_cmd *cmd,
-					  bool d0i3)
+					  struct iwl_beacon_filter_cmd *cmd)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (vif->bss_conf.cqm_rssi_thold && !d0i3) {
+	if (vif->bss_conf.cqm_rssi_thold) {
 		cmd->bf_energy_delta =
 			cpu_to_le32(vif->bss_conf.cqm_rssi_hyst);
 		/* fw uses an absolute value for this */
@@ -849,8 +848,7 @@ iwl_mvm_beacon_filter_debugfs_parameters(struct ieee80211_vif *vif,
 static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 struct iwl_beacon_filter_cmd *cmd,
-					 u32 cmd_flags,
-					 bool d0i3)
+					 u32 cmd_flags)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -859,13 +857,11 @@ static int _iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 	    vif->type != NL80211_IFTYPE_STATION || vif->p2p)
 		return 0;
 
-	iwl_mvm_beacon_filter_set_cqm_params(mvm, vif, cmd, d0i3);
-	if (!d0i3)
-		iwl_mvm_beacon_filter_debugfs_parameters(vif, cmd);
+	iwl_mvm_beacon_filter_set_cqm_params(mvm, vif, cmd);
+	iwl_mvm_beacon_filter_debugfs_parameters(vif, cmd);
 	ret = iwl_mvm_beacon_filter_send_cmd(mvm, cmd, cmd_flags);
 
-	/* don't change bf_enabled in case of temporary d0i3 configuration */
-	if (!ret && !d0i3)
+	if (!ret)
 		mvmvif->bf_data.bf_enabled = true;
 
 	return ret;
@@ -880,12 +876,12 @@ int iwl_mvm_enable_beacon_filter(struct iwl_mvm *mvm,
 		.bf_enable_beacon_filter = cpu_to_le32(1),
 	};
 
-	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, flags, false);
+	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, flags);
 }
 
 static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
-					  u32 flags, bool d0i3)
+					  u32 flags)
 {
 	struct iwl_beacon_filter_cmd cmd = {};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -896,8 +892,7 @@ static int _iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 
 	ret = iwl_mvm_beacon_filter_send_cmd(mvm, &cmd, flags);
 
-	/* don't change bf_enabled in case of temporary d0i3 configuration */
-	if (!ret && !d0i3)
+	if (!ret)
 		mvmvif->bf_data.bf_enabled = false;
 
 	return ret;
@@ -907,7 +902,7 @@ int iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  u32 flags)
 {
-	return _iwl_mvm_disable_beacon_filter(mvm, vif, flags, false);
+	return _iwl_mvm_disable_beacon_filter(mvm, vif, flags);
 }
 
 static int iwl_mvm_power_set_ps(struct iwl_mvm *mvm)
@@ -958,7 +953,7 @@ static int iwl_mvm_power_set_ba(struct iwl_mvm *mvm,
 				       !vif->bss_conf.ps ||
 				       iwl_mvm_vif_low_latency(mvmvif));
 
-	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, 0, false);
+	return _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd, 0);
 }
 
 int iwl_mvm_power_update_ps(struct iwl_mvm *mvm)
@@ -1022,58 +1017,3 @@ int iwl_mvm_power_update_mac(struct iwl_mvm *mvm)
 
 	return 0;
 }
-
-int iwl_mvm_update_d0i3_power_mode(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif,
-				   bool enable, u32 flags)
-{
-	int ret;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mac_power_cmd cmd = {};
-
-	if (vif->type != NL80211_IFTYPE_STATION || vif->p2p)
-		return 0;
-
-	if (!vif->bss_conf.assoc)
-		return 0;
-
-	iwl_mvm_power_build_cmd(mvm, vif, &cmd, !enable);
-
-	iwl_mvm_power_log(mvm, &cmd);
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	memcpy(&mvmvif->mac_pwr_cmd, &cmd, sizeof(cmd));
-#endif
-	ret = iwl_mvm_send_cmd_pdu(mvm, MAC_PM_POWER_TABLE, flags,
-				   sizeof(cmd), &cmd);
-	if (ret)
-		return ret;
-
-	/* configure beacon filtering */
-	if (mvmvif != mvm->bf_allowed_vif)
-		return 0;
-
-	if (enable) {
-		struct iwl_beacon_filter_cmd cmd_bf = {
-			IWL_BF_CMD_CONFIG_D0I3,
-			.bf_enable_beacon_filter = cpu_to_le32(1),
-		};
-		/*
-		 * When beacon storing is supported - disable beacon filtering
-		 * altogether - the latest beacon will be sent when exiting d0i3
-		 */
-		if (fw_has_capa(&mvm->fw->ucode_capa,
-				IWL_UCODE_TLV_CAPA_BEACON_STORING))
-			ret = _iwl_mvm_disable_beacon_filter(mvm, vif, flags,
-							     true);
-		else
-			ret = _iwl_mvm_enable_beacon_filter(mvm, vif, &cmd_bf,
-							    flags, true);
-	} else {
-		if (mvmvif->bf_data.bf_enabled)
-			ret = iwl_mvm_enable_beacon_filter(mvm, vif, flags);
-		else
-			ret = iwl_mvm_disable_beacon_filter(mvm, vif, flags);
-	}
-
-	return ret;
-}
-- 
2.23.0.rc1

