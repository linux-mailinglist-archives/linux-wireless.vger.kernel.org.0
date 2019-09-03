Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16BA62BA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfICHiF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:38:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40352 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbfICHiF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:38:05 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Nl-0004Cd-Qo; Tue, 03 Sep 2019 10:37:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:14 +0300
Message-Id: <20190903073714.32278-22-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 21/21] iwlwifi: dbg: remove iwl_fw_cancel_dumps function
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Use cancel_delayed_work_sync on the dump workers only in case of
unloading the op mode. In any other case use iwl_fw_flush_dumps or
iwl_fw_dbg_stop_sync (depends if the op mode mutex is held or not).
This way, the driver will wait until debug data is collected in all
cases but op mode unloading.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h       | 11 -----------
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h   |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 -
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 14181e6dc00d..e3b5dd34643f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -321,17 +321,6 @@ static inline void iwl_fw_flush_dumps(struct iwl_fw_runtime *fwrt)
 	}
 }
 
-static inline void iwl_fw_cancel_dumps(struct iwl_fw_runtime *fwrt)
-{
-	int i;
-
-	iwl_dbg_tlv_del_timers(fwrt->trans);
-	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
-		cancel_delayed_work_sync(&fwrt->dump.wks[i].wk);
-		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
-	}
-}
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_cancel_timestamp(struct iwl_fw_runtime *fwrt)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 8b8ab6d692b6..be436c18a047 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -203,6 +203,10 @@ static inline void iwl_fw_runtime_free(struct iwl_fw_runtime *fwrt)
 		kfree(active->trig);
 		active->trig = NULL;
 	}
+
+	iwl_dbg_tlv_del_timers(fwrt->trans);
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
+		cancel_delayed_work_sync(&fwrt->dump.wks[i].wk);
 }
 
 void iwl_fw_runtime_suspend(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 11b24d143cb6..2d14c59ccbdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1243,7 +1243,6 @@ static void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	 */
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
-	iwl_fw_cancel_dumps(&mvm->fwrt);
 	cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
 	cancel_delayed_work_sync(&mvm->scan_timeout_dwork);
 	iwl_fw_free_dump_desc(&mvm->fwrt);
-- 
2.23.0.rc1

