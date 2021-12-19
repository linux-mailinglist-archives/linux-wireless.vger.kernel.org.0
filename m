Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053A47A060
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhLSL2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51442 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235641AbhLSL2s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:48 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMw-001O73-EP; Sun, 19 Dec 2021 13:28:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:31 +0200
Message-Id: <iwlwifi.20211219132536.915e1f69f062.Id837e917f1c2beaca7c1eb33333d622548918a76@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: fix AUX ROC removal
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD is set, removing a time event
always tries to cancel session protection. However, AUX ROC does
not use session protection so it was never removed. As a result,
if the driver tries to allocate another AUX ROC event right after
cancelling the first one, it will fail with a warning.
In addition, the time event data passed to iwl_mvm_remove_aux_roc_te()
is incorrect. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index b8c645b9880f..ab06dcda1462 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -696,11 +696,14 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 	iwl_mvm_te_clear_data(mvm, te_data);
 	spin_unlock_bh(&mvm->time_event_lock);
 
-	/* When session protection is supported, the te_data->id field
+	/* When session protection is used, the te_data->id field
 	 * is reused to save session protection's configuration.
+	 * For AUX ROC, HOT_SPOT_CMD is used and the te_data->id field is set
+	 * to HOT_SPOT_CMD.
 	 */
 	if (fw_has_capa(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
+			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD) &&
+	    id != HOT_SPOT_CMD) {
 		if (mvmvif && id < SESSION_PROTECT_CONF_MAX_ID) {
 			/* Session protection is still ongoing. Cancel it */
 			iwl_mvm_cancel_session_protection(mvm, mvmvif, id);
@@ -1036,7 +1039,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			iwl_mvm_p2p_roc_finished(mvm);
 		} else {
 			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
-						  &mvmvif->time_event_data);
+						  &mvmvif->hs_time_event_data);
 			iwl_mvm_roc_finished(mvm);
 		}
 
-- 
2.34.1

