Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D16468460
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384782AbhLDLO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50402 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384765AbhLDLO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:28 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwX-0017RD-92; Sat, 04 Dec 2021 13:11:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:48 +0200
Message-Id: <iwlwifi.20211204130722.139d74d2b063.I4cfbb594c110ea9b250e2306c30601f847db2c1a@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: update rate scale in moving back to assoc state
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In assoc state we only use narrow bandwidth, due to phy/radio not
configured to max bandwidth.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index cb8104503091..2f8ac9c4d2d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3383,6 +3383,11 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				     true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
+		/* once we move into assoc state, need to update rate scale to
+		 * disable using wide bandwidth
+		 */
+		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
+				     false);
 		if (!sta->tdls) {
 			/* Multicast data frames are no longer allowed */
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 958702403a45..970b92fd7042 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -291,8 +291,12 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	notif = (void *)pkt->data;
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[notif->sta_id]);
 	if (IS_ERR_OR_NULL(sta)) {
-		IWL_ERR(mvm, "Invalid sta id (%d) in FW TLC notification\n",
-			notif->sta_id);
+		/* can happen in remove station flow where mvm removed internally
+		 * the station before removing from FW
+		 */
+		IWL_DEBUG_RATE(mvm,
+			       "Invalid mvm RCU pointer for sta id (%d) in TLC notification\n",
+			       notif->sta_id);
 		goto out;
 	}
 
-- 
2.33.1

