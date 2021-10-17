Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311C430783
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbhJQJmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53652 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241728AbhJQJme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eV-000YUg-AF; Sun, 17 Oct 2021 12:40:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:10 +0300
Message-Id: <iwlwifi.20211017123741.954001ec079f.I9deb8bc7520ad569a453f72c8d99adc9c99c9be3@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: correct sta-state logic for TDLS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For TDLS stations, much of the sta-state logic shouldn't apply,
since they don't affect the link to the AP. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5374faa15684..56da2759777c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3194,32 +3194,35 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		if (iwl_mvm_phy_ctx_count(mvm) > 1)
 			iwl_mvm_teardown_tdls_peers(mvm);
 
-		if (sta->tdls)
+		if (sta->tdls) {
 			iwl_mvm_tdls_check_trigger(mvm, vif, sta->addr,
 						   NL80211_TDLS_ENABLE_LINK);
+		} else {
+			/* enable beacon filtering */
+			WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
 
-		/* enable beacon filtering */
-		WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
-
-		/*
-		 * Now that the station is authorized, i.e., keys were already
-		 * installed, need to indicate to the FW that
-		 * multicast data frames can be forwarded to the driver
-		 */
-		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+			/*
+			 * Now that the station is authorized, i.e., keys were already
+			 * installed, need to indicate to the FW that
+			 * multicast data frames can be forwarded to the driver
+			 */
+			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+		}
 
 		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
 				     true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
-		/* Multicast data frames are no longer allowed */
-		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+		if (!sta->tdls) {
+			/* Multicast data frames are no longer allowed */
+			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 
-		/* disable beacon filtering */
-		ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
-		WARN_ON(ret &&
-			!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-				  &mvm->status));
+			/* disable beacon filtering */
+			ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
+			WARN_ON(ret &&
+				!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+					  &mvm->status));
+		}
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH) {
-- 
2.33.0

