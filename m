Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7C2F9314
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbhAQOxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40760 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729071AbhAQOx3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:29 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Q1-003sgA-Lc; Sun, 17 Jan 2021 16:52:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:32 +0200
Message-Id: <iwlwifi.20210117164916.1f75d426ebe4.I58f6612f7e168c655bdef206a53e5bc117c84cf5@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 7/9] iwlwifi: mvm: simplify TX power setting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to double this code, just put it into the common
code that's called in all the cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4e14a97bd168..04fda8250291 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2401,12 +2401,6 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			IWL_ERR(mvm, "failed to update power mode\n");
 	}
 
-	if (changes & BSS_CHANGED_TXPOWER) {
-		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d\n",
-				bss_conf->txpower);
-		iwl_mvm_set_tx_power(mvm, vif, bss_conf->txpower);
-	}
-
 	if (changes & BSS_CHANGED_CQM) {
 		IWL_DEBUG_MAC80211(mvm, "cqm info_changed\n");
 		/* reset cqm events tracking */
@@ -2638,12 +2632,6 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 	    iwl_mvm_mac_ctxt_beacon_changed(mvm, vif))
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
-	if (changes & BSS_CHANGED_TXPOWER) {
-		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d\n",
-				bss_conf->txpower);
-		iwl_mvm_set_tx_power(mvm, vif, bss_conf->txpower);
-	}
-
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
 		int ret = iwl_mvm_ftm_start_responder(mvm, vif);
 
@@ -2683,6 +2671,12 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 		WARN_ON_ONCE(1);
 	}
 
+	if (changes & BSS_CHANGED_TXPOWER) {
+		IWL_DEBUG_CALIB(mvm, "Changing TX Power to %d dBm\n",
+				bss_conf->txpower);
+		iwl_mvm_set_tx_power(mvm, vif, bss_conf->txpower);
+	}
+
 	mutex_unlock(&mvm->mutex);
 }
 
-- 
2.29.2

