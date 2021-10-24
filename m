Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3A4389CD
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJXPXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58674 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231548AbhJXPXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIx-000czj-3F; Sun, 24 Oct 2021 18:20:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:36 +0300
Message-Id: <iwlwifi.20211024181719.411c174d9e5e.I03c701c2e9e6788f34546e538264763db0ab30ef@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mvm: extend session protection on association
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we receive an association response, a significant amount
of time might have passed since we sent the corresponding
association request (mac80211 will wait up to 500ms for the TX
and then 100ms for the response after ACK was received). But
the time event is touched only when we send the assoc request,
so it might not have much time remaining, more easily causing
the (dreaded)

  No beacon heard and the session protection is over already...

message.

Refactor iwl_mvm_mac_mgd_prepare_tx() and split out a new
function iwl_mvm_protect_assoc(), and call it on successful
association to extend the time event to the minimum time if
necessary.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 64 +++++++++++++------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d7d7d8a85c6d..9fb9c7dad314 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2236,6 +2236,34 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		IWL_ERR(mvm, "Failed to config FW to work HE!\n");
 }
 
+static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif,
+				  u32 duration_override)
+{
+	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
+	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
+
+	if (duration_override > duration)
+		duration = duration_override;
+
+	/* Try really hard to protect the session and hear a beacon
+	 * The new session protection command allows us to protect the
+	 * session for a much longer time since the firmware will internally
+	 * create two events: a 300TU one with a very high priority that
+	 * won't be fragmented which should be enough for 99% of the cases,
+	 * and another one (which we configure here to be 900TU long) which
+	 * will have a slightly lower priority, but more importantly, can be
+	 * fragmented so that it'll allow other activities to run.
+	 */
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
+		iwl_mvm_schedule_session_protection(mvm, vif, 900,
+						    min_duration, false);
+	else
+		iwl_mvm_protect_session(mvm, vif, duration,
+					min_duration, 500, false);
+}
+
 static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *bss_conf,
@@ -2319,6 +2347,20 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 				u32 dur = (11 * vif->bss_conf.beacon_int) / 10;
 				iwl_mvm_protect_session(mvm, vif, dur, dur,
 							5 * dur, false);
+			} else if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+					     &mvm->status) &&
+				   !vif->bss_conf.dtim_period) {
+				/*
+				 * If we're not restarting and still haven't
+				 * heard a beacon (dtim period unknown) then
+				 * make sure we still have enough minimum time
+				 * remaining in the time event, since the auth
+				 * might actually have taken quite a while
+				 * (especially for SAE) and so the remaining
+				 * time could be small without us having heard
+				 * a beacon yet.
+				 */
+				iwl_mvm_protect_assoc(mvm, vif, 0);
 			}
 
 			iwl_mvm_sf_update(mvm, vif, false);
@@ -3332,29 +3374,9 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 				       struct ieee80211_prep_tx_info *info)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
-	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
-
-	if (info->duration > duration)
-		duration = info->duration;
 
 	mutex_lock(&mvm->mutex);
-	/* Try really hard to protect the session and hear a beacon
-	 * The new session protection command allows us to protect the
-	 * session for a much longer time since the firmware will internally
-	 * create two events: a 300TU one with a very high priority that
-	 * won't be fragmented which should be enough for 99% of the cases,
-	 * and another one (which we configure here to be 900TU long) which
-	 * will have a slightly lower priority, but more importantly, can be
-	 * fragmented so that it'll allow other activities to run.
-	 */
-	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD))
-		iwl_mvm_schedule_session_protection(mvm, vif, 900,
-						    min_duration, false);
-	else
-		iwl_mvm_protect_session(mvm, vif, duration,
-					min_duration, 500, false);
+	iwl_mvm_protect_assoc(mvm, vif, info->duration);
 	mutex_unlock(&mvm->mutex);
 }
 
-- 
2.33.0

