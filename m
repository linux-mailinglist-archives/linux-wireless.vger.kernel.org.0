Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A941E90D81
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHQGwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 02:52:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36404 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbfHQGwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 02:52:49 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hysZd-0006XT-Oy; Sat, 17 Aug 2019 09:52:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 17 Aug 2019 09:51:55 +0300
Message-Id: <20190817065200.9701-18-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190817065200.9701-1-luca@coelho.fi>
References: <20190817065200.9701-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 17/22] iwlwifi: mvm: remove d0i3_ap_sta_id
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This variable read, but never set. Remove it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 4 ----
 3 files changed, 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2a246f69229d..f4aa121f36f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1071,7 +1071,6 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 	ieee80211_iterate_interfaces(mvm->hw, 0, iwl_mvm_cleanup_iterator, mvm);
 
 	mvm->p2p_device_vif = NULL;
-	mvm->d0i3_ap_sta_id = IWL_MVM_INVALID_STA;
 
 	iwl_mvm_reset_phy_ctxts(mvm);
 	memset(mvm->fw_key_table, 0, sizeof(mvm->fw_key_table));
@@ -2335,9 +2334,6 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 					IWL_ERR(mvm,
 						"failed to remove AP station\n");
 
-				if (mvm->d0i3_ap_sta_id == mvmvif->ap_sta_id)
-					mvm->d0i3_ap_sta_id =
-						IWL_MVM_INVALID_STA;
 				mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
 			}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 03f3faa02781..4a9e8ae99cac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1015,9 +1015,6 @@ struct iwl_mvm {
 #endif
 #endif
 
-	/* d0i3 */
-	u8 d0i3_ap_sta_id;
-
 	wait_queue_head_t rx_sync_waitq;
 
 	/* BT-Coex */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 4fae0cb22195..b0f92c9b20f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1887,10 +1887,6 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 		/* unassoc - go ahead - remove the AP STA now */
 		mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
-
-		/* clear d0i3_ap_sta_id if no longer relevant */
-		if (mvm->d0i3_ap_sta_id == sta_id)
-			mvm->d0i3_ap_sta_id = IWL_MVM_INVALID_STA;
 	}
 
 	/*
-- 
2.23.0.rc1

