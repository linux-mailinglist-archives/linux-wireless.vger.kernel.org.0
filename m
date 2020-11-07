Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B22AA3F9
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgKGIuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727955AbgKGIuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:16 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvL-002on9-2j; Sat, 07 Nov 2020 10:50:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:07 +0200
Message-Id: <iwlwifi.20201107104557.a317376154da.I44fa3637373ba4bd421cdff2cabc761bffc0735f@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107085011.57943-1-luca@coelho.fi>
References: <20201107085011.57943-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 2/6] iwlwifi: mvm: use the HOT_SPOT_CMD to cancel an AUX ROC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The ROC that runs on the AUX ROC (meaning an ROC on the STA vif),
was added with the HOT_SPOT_CMD firmware command and must be
cancelled with that same command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: fe959c7b2049 ("iwlwifi: mvm: use the new session protection command")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 7fce79c1c114..a9ebe69a6670 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -988,10 +988,13 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		iwl_mvm_cancel_session_protection(mvm, mvmvif);
-
-		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+			iwl_mvm_cancel_session_protection(mvm, mvmvif);
 			set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status);
+		} else {
+			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
+						  &mvmvif->time_event_data);
+		}
 
 		iwl_mvm_roc_finished(mvm);
 
-- 
2.28.0

