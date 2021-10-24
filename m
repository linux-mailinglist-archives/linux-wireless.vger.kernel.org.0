Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A404389CB
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJXPXU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58662 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231547AbhJXPXT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIu-000czj-U4; Sun, 24 Oct 2021 18:20:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:34 +0300
Message-Id: <iwlwifi.20211024181719.6192e2363784.Ie9c2bfdc30dcfff2c4dd7c393c79e3ac182840a9@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: mvm: remove session protection on disassoc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we somehow get disassociated while still waiting for a beacon
during connection, we can end up printing the

  No beacon heard and the session protection is over already...

message even if we aren't really quite waiting for it anymore.
Remove the time event, if it's running, when we get disassociated
and don't need to wait for beacons anymore.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2645dd8fef83..d7d7d8a85c6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3237,6 +3237,9 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		if (vif->type == NL80211_IFTYPE_AP) {
 			mvmvif->ap_assoc_sta_count--;
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+		} else if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
+			/* remove session protection if still running */
+			iwl_mvm_stop_session_protection(mvm, vif);
 		}
 		ret = 0;
 	} else if (old_state == IEEE80211_STA_AUTH &&
-- 
2.33.0

