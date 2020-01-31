Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD07714EDB8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAaNpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:56016 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728793AbgAaNpo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWcA-0002Nv-Rh; Fri, 31 Jan 2020 15:45:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:30 +0200
Message-Id: <20200131134530.931641-8-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131134530.931641-1-luca@coelho.fi>
References: <20200131134530.931641-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 7/7] iwlwifi: d3: read all FW CPUs error info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Continue the wakeup flow only if no FW CPUs have an error

If we don't check for error in all FW CPUs the driver can think
based on one CPU that the FW is operational and try to access
and send commands.

Also, handle the error_id endianness correctly as le32

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 52 ++++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 8878409d2f07..22a32eb10f01 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1897,27 +1897,55 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 		ieee80211_resume_disconnect(vif);
 }
 
-static int iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif)
+static bool iwl_mvm_rt_status(struct iwl_trans *trans, u32 base, u32 *err_id)
 {
-	u32 base = mvm->trans->dbg.lmac_error_event_table[0];
 	struct error_table_start {
 		/* cf. struct iwl_error_event_table */
 		u32 valid;
-		u32 error_id;
+		__le32 err_id;
 	} err_info;
 
-	iwl_trans_read_mem_bytes(mvm->trans, base,
+	if (!base)
+		return false;
+
+	iwl_trans_read_mem_bytes(trans, base,
 				 &err_info, sizeof(err_info));
+	if (err_info.valid && err_id)
+		*err_id = le32_to_cpu(err_info.err_id);
 
-	if (err_info.valid &&
-	    err_info.error_id == RF_KILL_INDICATOR_FOR_WOWLAN) {
-		struct cfg80211_wowlan_wakeup wakeup = {
-			.rfkill_release = true,
-		};
-		ieee80211_report_wowlan_wakeup(vif, &wakeup, GFP_KERNEL);
+	return !!err_info.valid;
+}
+
+static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif)
+{
+	u32 err_id;
+
+	/* check for lmac1 error */
+	if (iwl_mvm_rt_status(mvm->trans,
+			      mvm->trans->dbg.lmac_error_event_table[0],
+			      &err_id)) {
+		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN) {
+			struct cfg80211_wowlan_wakeup wakeup = {
+				.rfkill_release = true,
+			};
+			ieee80211_report_wowlan_wakeup(vif, &wakeup,
+						       GFP_KERNEL);
+		}
+		return true;
 	}
-	return err_info.valid;
+
+	/* check if we have lmac2 set and check for error */
+	if (iwl_mvm_rt_status(mvm->trans,
+			      mvm->trans->dbg.lmac_error_event_table[1], NULL))
+		return true;
+
+	/* check for umac error */
+	if (iwl_mvm_rt_status(mvm->trans,
+			      mvm->trans->dbg.umac_error_event_table, NULL))
+		return true;
+
+	return false;
 }
 
 static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
-- 
2.24.1

