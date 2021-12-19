Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3B47A02D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhLSKSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51362 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235577AbhLSKSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:32 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGw-001O3b-0a; Sun, 19 Dec 2021 12:18:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:15 +0200
Message-Id: <iwlwifi.20211219121514.d5376ac6bcb0.Ic5f8470ea60c072bde9d1503e5f528b65e301e20@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: test roc running status bits before removing the sta
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

In some cases the sta is being removed twice since we do not test the
roc aux running before removing it. Start looking at the bit before
removing the sta.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Fixes: 2c2c3647cde4 ("iwlwifi: mvm: support ADD_STA_CMD_API_S ver 12")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/time-event.c   | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index e6813317edf3..b8c645b9880f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -49,14 +49,13 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, roc_done_wk);
 
 	/*
-	 * Clear the ROC_RUNNING /ROC_AUX_RUNNING status bit.
+	 * Clear the ROC_RUNNING status bit.
 	 * This will cause the TX path to drop offchannel transmissions.
 	 * That would also be done by mac80211, but it is racy, in particular
 	 * in the case that the time event actually completed in the firmware
 	 * (which is handled in iwl_mvm_te_handle_notif).
 	 */
 	clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
-	clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
 
 	synchronize_net();
 
@@ -82,9 +81,19 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 			mvmvif = iwl_mvm_vif_from_mac80211(mvm->p2p_device_vif);
 			iwl_mvm_flush_sta(mvm, &mvmvif->bcast_sta, true);
 		}
-	} else {
+	}
+
+	/*
+	 * Clear the ROC_AUX_RUNNING status bit.
+	 * This will cause the TX path to drop offchannel transmissions.
+	 * That would also be done by mac80211, but it is racy, in particular
+	 * in the case that the time event actually completed in the firmware
+	 * (which is handled in iwl_mvm_te_handle_notif).
+	 */
+	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status)) {
 		/* do the same in case of hot spot 2.0 */
 		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
+
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
 		 * of use */
-- 
2.34.1

