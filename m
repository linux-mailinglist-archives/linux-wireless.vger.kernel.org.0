Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F312D032F
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgLFLIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:20 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34786 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbgLFLIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt6-003AAN-U7; Sun, 06 Dec 2020 13:07:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:21 +0200
Message-Id: <iwlwifi.20201206130357.18e5e8aa5881.Id62b2da8a0ccccbb114407db82ca485d07749d39@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: mvm: clean up scan state on failure
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We keep the scan status per UID in scan_uid_status field when the
iwl_mvm_build_scan_cmd() function is called. If we error out after
this, e.g. due to FW restart being in progress, we're not cleaning
up properly, and can run into warnings later.

Clean up internal variables when starting fails after calling the
iwl_mvm_build_scan_cmd() function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3ec01a301857..f6d08d606dfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2146,8 +2146,10 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	ret = iwl_mvm_fill_scan_sched_params(params, tail_v2->schedule,
 					     &tail_v2->delay);
-	if (ret)
+	if (ret) {
+		mvm->scan_uid_status[uid] = 0;
 		return ret;
+	}
 
 	if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
 		tail_v2->preq = params->preq;
@@ -2458,7 +2460,7 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 				  struct iwl_mvm_scan_params *params,
 				  int type)
 {
-	int uid, i;
+	int uid, i, err;
 	u8 scan_ver;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -2490,7 +2492,11 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 		return ver_handler->handler(mvm, vif, params, type, uid);
 	}
 
-	return iwl_mvm_scan_umac(mvm, vif, params, type, uid);
+	err = iwl_mvm_scan_umac(mvm, vif, params, type, uid);
+	if (err)
+		return err;
+
+	return uid;
 }
 
 int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
@@ -2503,7 +2509,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		.dataflags = { IWL_HCMD_DFL_NOCOPY, },
 	};
 	struct iwl_mvm_scan_params params = {};
-	int ret;
+	int ret, uid;
 	struct cfg80211_sched_scan_plan scan_plan = { .iterations = 1 };
 
 	lockdep_assert_held(&mvm->mutex);
@@ -2550,11 +2556,11 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
-	ret = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params,
+	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params,
 				     IWL_MVM_SCAN_REGULAR);
 
-	if (ret)
-		return ret;
+	if (uid < 0)
+		return uid;
 
 	iwl_mvm_pause_tcm(mvm, false);
 
@@ -2566,6 +2572,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		 */
 		IWL_ERR(mvm, "Scan failed! ret %d\n", ret);
 		iwl_mvm_resume_tcm(mvm);
+		mvm->scan_uid_status[uid] = 0;
 		return ret;
 	}
 
@@ -2591,7 +2598,7 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		.dataflags = { IWL_HCMD_DFL_NOCOPY, },
 	};
 	struct iwl_mvm_scan_params params = {};
-	int ret;
+	int ret, uid;
 	int i, j;
 	bool non_psc_included = false;
 
@@ -2683,12 +2690,12 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		return -ENOBUFS;
 	}
 
-	ret = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
+	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
 
 	if (non_psc_included)
 		kfree(params.channels);
-	if (ret)
-		return ret;
+	if (uid < 0)
+		return uid;
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
@@ -2701,6 +2708,8 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		 * should try to send the command again with different params.
 		 */
 		IWL_ERR(mvm, "Sched scan failed! ret %d\n", ret);
+		mvm->scan_uid_status[uid] = 0;
+		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
 	return ret;
-- 
2.29.2

