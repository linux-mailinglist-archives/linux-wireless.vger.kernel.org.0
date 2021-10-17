Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240FD430959
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbhJQN21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343707AbhJQN2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B4-000YdS-Jv; Sun, 17 Oct 2021 16:26:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:26:02 +0300
Message-Id: <iwlwifi.20211017162352.95e4bebb069b.I635280e5d26c70414ac6eb5d62b46fe4bd942818@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: mvm: remove session protection after auth/assoc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When auth/assoc completes, we should remove session protection,
except when association is successful, where we need it until a
beacon is received from the AP.

In particular, in the case of assoc comeback, currently the session
protection event just times out, leading to confusing messages:

  wlan0: 42:00:00:00:00:00 rejected association temporarily; comeback duration 1000 TU (1024 ms)
  iwlwifi 0000:00:00.0: Not associated and the session protection is over already...
  wlan0: Connection to AP 42:00:00:00:00:00 lost
  wlan0: associate with 42:00:00:00:00:00 (try 2/3)

mac80211 never does anything on the "Connection ... lost" as it's
not even connected.

Removing the session protection when it's no longer needed removes
those confusing messages and lets the device do other things in the
allocated time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4660f21c4e79..adca7c78b815 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3347,6 +3347,21 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static void iwl_mvm_mac_mgd_complete_tx(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_prep_tx_info *info)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	/* for successful cases (auth/assoc), don't cancel session protection */
+	if (info->success)
+		return;
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_stop_session_protection(mvm, vif);
+	mutex_unlock(&mvm->mutex);
+}
+
 static int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
 					struct cfg80211_sched_scan_request *req,
@@ -5347,6 +5362,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.sta_rc_update = iwl_mvm_sta_rc_update,
 	.conf_tx = iwl_mvm_mac_conf_tx,
 	.mgd_prepare_tx = iwl_mvm_mac_mgd_prepare_tx,
+	.mgd_complete_tx = iwl_mvm_mac_mgd_complete_tx,
 	.mgd_protect_tdls_discover = iwl_mvm_mac_mgd_protect_tdls_discover,
 	.flush = iwl_mvm_mac_flush,
 	.sched_scan_start = iwl_mvm_mac_sched_scan_start,
-- 
2.33.0

