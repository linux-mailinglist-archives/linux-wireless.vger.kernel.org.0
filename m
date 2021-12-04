Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293FD46845A
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354131AbhLDLOX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50366 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353891AbhLDLOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:22 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwR-0017RD-EG; Sat, 04 Dec 2021 13:10:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:42 +0200
Message-Id: <iwlwifi.20211204130722.483977310ca2.If7eba02594f20dabd22d758e1c917fbca54b2ddd@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/12] iwlwifi: mvm: remove session protection upon station removal
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the station is removed we need to remove the session protection
that may be still running.
Note that we need also to remove the session protection upon unassoc in
case the station is kept in the AUTH state.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9d84be991469..cb8104503091 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3405,16 +3405,16 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		if (vif->type == NL80211_IFTYPE_AP) {
 			mvmvif->ap_assoc_sta_count--;
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
-		} else if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-			/* remove session protection if still running */
+		} else if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			iwl_mvm_stop_session_protection(mvm, vif);
-		}
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_NONE) {
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_NONE &&
 		   new_state == IEEE80211_STA_NOTEXIST) {
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+			iwl_mvm_stop_session_protection(mvm, vif);
 		ret = iwl_mvm_rm_sta(mvm, vif, sta);
 		if (sta->tdls) {
 			iwl_mvm_recalc_tdls_state(mvm, vif, false);
-- 
2.33.1

