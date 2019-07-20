Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3346EF0C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfGTK0L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59480 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZ5-0000Hj-Vo; Sat, 20 Jul 2019 13:26:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:35 +0300
Message-Id: <20190720102545.5952-7-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 06/16] iwlwifi: mvm: add a wrapper around rs_tx_status to handle locks
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

iwl_mvm_rs_tx_status can be called from two places in the code, but the
mutex is taken only on one of the calls. Split it into a wrapper taking
locks and an internal __iwl_mvm_rs_tx_status function.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 28 ++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 02b4ef92543f..b50a47e86ef0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1218,8 +1218,10 @@ void iwl_mvm_rs_init_wk(struct work_struct *wk)
 	rcu_read_unlock();
 }
 
-void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			  int tid, struct ieee80211_tx_info *info, bool ndp)
+static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
+				   struct ieee80211_sta *sta,
+				   int tid, struct ieee80211_tx_info *info,
+				   bool ndp)
 {
 	int legacy_success;
 	int retries;
@@ -1451,6 +1453,21 @@ void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		rs_rate_scale_perform(mvm, sta, lq_sta, tid, ndp);
 }
 
+void iwl_mvm_rs_tx_status(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			  int tid, struct ieee80211_tx_info *info, bool ndp)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	/* If it's locked we are in middle of init flow
+	 * just wait for next tx status to update the lq_sta data
+	 */
+	if (!mutex_trylock(&mvmsta->lq_sta.rs_drv.mutex))
+		return;
+
+	__iwl_mvm_rs_tx_status(mvm, sta, tid, info, ndp);
+	mutex_unlock(&mvmsta->lq_sta.rs_drv.mutex);
+}
+
 /*
  * mac80211 sends us Tx status
  */
@@ -1472,15 +1489,8 @@ static void rs_drv_mac80211_tx_status(void *mvm_r,
 	    info->flags & IEEE80211_TX_CTL_NO_ACK)
 		return;
 
-	/* If it's locked we are in middle of init flow
-	 * just wait for next tx status to update the lq_sta data
-	 */
-	if (!mutex_trylock(&mvmsta->lq_sta.rs_drv.mutex))
-		return;
-
 	iwl_mvm_rs_tx_status(mvm, sta, rs_get_tid(hdr), info,
 			     ieee80211_is_qos_nullfunc(hdr->frame_control));
-	mutex_unlock(&mvmsta->lq_sta.rs_drv.mutex);
 }
 
 /*
-- 
2.20.1

