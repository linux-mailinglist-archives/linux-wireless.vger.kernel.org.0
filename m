Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6878094AEA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfHSQu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37138 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727920AbfHSQu7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:59 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrN-0007zi-Ky; Mon, 19 Aug 2019 19:50:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:49:57 +0300
Message-Id: <20190819165007.10181-13-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 12/22] iwlwifi: mvm: start to remove the code for d0i3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

For runtime PM to work with d0i3 code, a lot of integration work needs
to be done with the platform (e.g. the out-of-band wake up interrupt)
and we currently don't have any platforms where this integration
happened.  So, this code has been pretty much stale for a while and
when someone enables it, it just breaks things.

Therefore, to simplify the code base and make sure no one enables this
by mistake, we will remove the whole code.

This is only the very start, much more work is needed.
Remove the places where we check iwl_mvm_is_d0i3_supported
but leave all the refs, those will be removed in a different
patch.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 438a8b5b90c2..07d576d29086 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -762,12 +762,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
 #ifdef CONFIG_PM_SLEEP
-	if (iwl_mvm_is_d0i3_supported(mvm) &&
-	    device_can_wakeup(mvm->trans->dev)) {
-		mvm->wowlan.flags = WIPHY_WOWLAN_ANY;
-		hw->wiphy->wowlan = &mvm->wowlan;
-	}
-
 	if ((unified || mvm->fw->img[IWL_UCODE_WOWLAN].num_sec) &&
 	    mvm->trans->ops->d3_suspend &&
 	    mvm->trans->ops->d3_resume &&
@@ -1359,17 +1353,6 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 	mutex_unlock(&mvm->mutex);
 }
 
-static void iwl_mvm_resume_complete(struct iwl_mvm *mvm)
-{
-	if (iwl_mvm_is_d0i3_supported(mvm) &&
-	    iwl_mvm_enter_d0i3_on_suspend(mvm))
-		WARN_ONCE(!wait_event_timeout(mvm->d0i3_exit_waitq,
-					      !test_bit(IWL_MVM_STATUS_IN_D0I3,
-							&mvm->status),
-					      HZ),
-			  "D0i3 exit on resume timed out\n");
-}
-
 static void
 iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 			      enum ieee80211_reconfig_type reconfig_type)
@@ -1381,7 +1364,6 @@ iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 		iwl_mvm_restart_complete(mvm);
 		break;
 	case IEEE80211_RECONFIG_TYPE_SUSPEND:
-		iwl_mvm_resume_complete(mvm);
 		break;
 	}
 }
-- 
2.23.0.rc1

