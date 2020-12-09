Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7B2D4507
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgLIPGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:03 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35454 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730267AbgLIPGD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:03 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11o-003Dg4-Ha; Wed, 09 Dec 2020 17:05:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:04 +0200
Message-Id: <iwlwifi.20201209170243.ac610533ee8f.I4ed0149e0018fe5e1ae3c2a1cbc614954016063f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: mvm: fix a race in CSA that caused assert 0x3420
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

When we get a channel switch with a very long quiet period, we schedule
a work to disconnect after a while. This work runs in background. In the
meanwhile, we keep getting beacons and sending FW modify command for each.
This has a potential race, where we modify the CSA after we aborted it.

Protect the flow by setting csa_failed to true in case we abort, and check
it before sending the modify command.

This required a modification to the way we treat csa_failed in
iwl_mvm_post_channel_switch:
1. The variable isn't being reset anymore, so we can still look at it in
iwl_mvm_channel_switch_rx_beacon. This is fine, since we reset it when
starting a new CSA.
2. There is no more early return in case of csa_failed. This is fine,
since before this patch csa_failed was set only for GO, and for GO the
function is only resetting the power settings, which we want to restore
even in case of failure.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 44939666cde7..74631b699856 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1300,12 +1300,6 @@ static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	if (mvmvif->csa_failed) {
-		mvmvif->csa_failed = false;
-		ret = -EIO;
-		goto out_unlock;
-	}
-
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct iwl_mvm_sta *mvmsta;
 
@@ -1337,6 +1331,8 @@ static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 	ret = iwl_mvm_power_update_ps(mvm);
 
 out_unlock:
+	if (mvmvif->csa_failed)
+		ret = -EIO;
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
@@ -1364,9 +1360,10 @@ static void iwl_mvm_abort_channel_switch(struct ieee80211_hw *hw,
 					     WIDE_ID(MAC_CONF_GROUP,
 						     CHANNEL_SWITCH_TIME_EVENT_CMD),
 					     0, sizeof(cmd), &cmd));
+	mvmvif->csa_failed = true;
 	mutex_unlock(&mvm->mutex);
 
-	WARN_ON(iwl_mvm_post_channel_switch(hw, vif));
+	iwl_mvm_post_channel_switch(hw, vif);
 }
 
 static void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk)
@@ -4621,12 +4618,17 @@ static void iwl_mvm_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	}
 	mvmvif->csa_count = chsw->count;
 
-	IWL_DEBUG_MAC80211(mvm, "Modify CSA on mac %d\n", mvmvif->id);
+	mutex_lock(&mvm->mutex);
+	if (mvmvif->csa_failed)
+		goto out_unlock;
 
+	IWL_DEBUG_MAC80211(mvm, "Modify CSA on mac %d\n", mvmvif->id);
 	WARN_ON(iwl_mvm_send_cmd_pdu(mvm,
 				     WIDE_ID(MAC_CONF_GROUP,
 					     CHANNEL_SWITCH_TIME_EVENT_CMD),
-				     CMD_ASYNC, sizeof(cmd), &cmd));
+				     0, sizeof(cmd), &cmd));
+out_unlock:
+	mutex_unlock(&mvm->mutex);
 }
 
 static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
-- 
2.29.2

