Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC71AD78B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgDQHht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:37:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56428 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgDQHht (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:37:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPLZJ-000KPp-Bw; Fri, 17 Apr 2020 10:37:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 10:37:38 +0300
Message-Id: <20200417073738.2049606-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v5.7] iwlwifi: fix WGDS check when WRDS is disabled
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In the reference BIOS implementation, WRDS can be disabled without
disabling WGDS.  And this happens in most cases where WRDS is
disabled, causing the WGDS without WRDS check and issue an error.

To avoid this issue, we change the check so that we only considered it
an error if the WRDS entry doesn't exist.  If the entry (or the
selected profile is disabled for any other reason), we just silently
ignore WGDS.

Cc: stable@vger.kernel.org # 4.14+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205513
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

Kalle, I'm going to assing this directly to you, since this should go
to v5.7-rc*.


 drivers/net/wireless/intel/iwlwifi/fw/acpi.c |  9 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 25 +++++++++-----------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index ba2aff3af0fe..e3a33388be70 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -296,9 +296,14 @@ int iwl_sar_select_profile(struct iwl_fw_runtime *fwrt,
 		if (!prof->enabled) {
 			IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
 					profs[i]);
-			/* if one of the profiles is disabled, we fail all */
-			return -ENOENT;
+			/*
+			 * if one of the profiles is disabled, we
+			 * ignore all of them and return 1 to
+			 * differentiate disabled from other failures.
+			 */
+			return 1;
 		}
+
 		IWL_DEBUG_INFO(fwrt,
 			       "SAR EWRD: chain %d profile index %d\n",
 			       i, profs[i]);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a4038f289ab3..2a4a55f3b073 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -727,6 +727,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		struct iwl_dev_tx_power_cmd_v4 v4;
 	} cmd;
 
+	int ret;
 	u16 len = 0;
 
 	cmd.v5.v3.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS);
@@ -741,9 +742,14 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		len = sizeof(cmd.v4.v3);
 
 
-	if (iwl_sar_select_profile(&mvm->fwrt, cmd.v5.v3.per_chain_restriction,
-				   prof_a, prof_b))
-		return -ENOENT;
+	ret = iwl_sar_select_profile(&mvm->fwrt,
+				     cmd.v5.v3.per_chain_restriction,
+				     prof_a, prof_b);
+
+	/* return on error or if the profile is disabled (positive numeber) */
+	if (!ret)
+		return ret;
+
 	IWL_DEBUG_RADIO(mvm, "Sending REDUCE_TX_POWER_CMD per chain\n");
 	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
 }
@@ -1034,16 +1040,7 @@ static int iwl_mvm_sar_init(struct iwl_mvm *mvm)
 				"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
 				ret);
 
-	ret = iwl_mvm_sar_select_profile(mvm, 1, 1);
-	/*
-	 * If we don't have profile 0 from BIOS, just skip it.  This
-	 * means that SAR Geo will not be enabled either, even if we
-	 * have other valid profiles.
-	 */
-	if (ret == -ENOENT)
-		return 1;
-
-	return ret;
+	return iwl_mvm_sar_select_profile(mvm, 1, 1);
 }
 
 static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
@@ -1272,7 +1269,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	ret = iwl_mvm_sar_init(mvm);
 	if (ret == 0) {
 		ret = iwl_mvm_sar_geo_init(mvm);
-	} else if (ret > 0 && !iwl_sar_get_wgds_table(&mvm->fwrt)) {
+	} else if (ret == -ENOENT && !iwl_sar_get_wgds_table(&mvm->fwrt)) {
 		/*
 		 * If basic SAR is not available, we check for WGDS,
 		 * which should *not* be available either.  If it is
-- 
2.25.1

