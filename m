Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF147A062
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhLSL2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51452 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235618AbhLSL2u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:50 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMx-001O73-Vg; Sun, 19 Dec 2021 13:28:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:33 +0200
Message-Id: <iwlwifi.20211219132536.a67b5b9db259.Ic55b306fcd2a3525b3993f4b7e00622dd95053ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: mvm: remove card state notification code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This notification ID was actually used for something else we
never implemented, but luckily we only had some debug code
here. Just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/alive.h    |  9 ---------
 .../net/wireless/intel/iwlwifi/fw/api/commands.h |  7 -------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c      | 16 ----------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     |  4 ----
 5 files changed, 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
index 7dd984fbe0f8..e00ab21e7358 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/alive.h
@@ -157,15 +157,6 @@ enum iwl_card_state_flags {
 	CARD_IS_RX_ON		= 0x10,
 };
 
-/**
- * struct iwl_radio_version_notif - information on the card state
- * ( CARD_STATE_NOTIFICATION = 0xa1 )
- * @flags: &enum iwl_card_state_flags
- */
-struct iwl_card_state_notif {
-	__le32 flags;
-} __packed; /* CARD_STATE_NTFY_API_S_VER_1 */
-
 /**
  * enum iwl_error_recovery_flags - flags for error recovery cmd
  * @ERROR_RECOVERY_UPDATE_DB: update db from blob sent
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index dab02a6a2622..641069753397 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -384,13 +384,6 @@ enum iwl_legacy_cmds {
 	 */
 	REDUCE_TX_POWER_CMD = 0x9f,
 
-	/**
-	 * @CARD_STATE_NOTIFICATION:
-	 * Card state (RF/CT kill) notification,
-	 * uses &struct iwl_card_state_notif
-	 */
-	CARD_STATE_NOTIFICATION = 0xa1,
-
 	/**
 	 * @MISSED_BEACONS_NOTIFICATION: &struct iwl_missed_beacons_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f48459da0fcc..6f4690e56a46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -12,8 +12,6 @@
 #include "iwl-op-mode.h"
 #include "fw/img.h"
 #include "iwl-debug.h"
-#include "iwl-csr.h" /* for iwl_mvm_rx_card_state_notif */
-#include "iwl-io.h" /* for iwl_mvm_rx_card_state_notif */
 #include "iwl-prph.h"
 #include "fw/acpi.h"
 #include "fw/pnvm.h"
@@ -1824,20 +1822,6 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 	return ret;
 }
 
-void iwl_mvm_rx_card_state_notif(struct iwl_mvm *mvm,
-				 struct iwl_rx_cmd_buffer *rxb)
-{
-	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_card_state_notif *card_state_notif = (void *)pkt->data;
-	u32 flags = le32_to_cpu(card_state_notif->flags);
-
-	IWL_DEBUG_RF_KILL(mvm, "Card state received: HW:%s SW:%s CT:%s\n",
-			  (flags & HW_CARD_DISABLED) ? "Kill" : "On",
-			  (flags & SW_CARD_DISABLED) ? "Kill" : "On",
-			  (flags & CT_KILL_CARD_DISABLED) ?
-			  "Reached" : "Not reached");
-}
-
 void iwl_mvm_rx_mfuart_notif(struct iwl_mvm *mvm,
 			     struct iwl_rx_cmd_buffer *rxb)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3d010afc69bc..1dcbb0eb63c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1624,8 +1624,6 @@ void iwl_mvm_rx_ba_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_ant_coupling_notif(struct iwl_mvm *mvm,
 				   struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_fw_error(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
-void iwl_mvm_rx_card_state_notif(struct iwl_mvm *mvm,
-				 struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_mfuart_notif(struct iwl_mvm *mvm,
 			     struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_shared_mem_cfg_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3a308585ed06..b278d302566c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -331,9 +331,6 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC,
 		   struct iwl_umac_scan_iter_complete_notif),
 
-	RX_HANDLER(CARD_STATE_NOTIFICATION, iwl_mvm_rx_card_state_notif,
-		   RX_HANDLER_SYNC, struct iwl_card_state_notif),
-
 	RX_HANDLER(MISSED_BEACONS_NOTIFICATION, iwl_mvm_rx_missed_beacons_notif,
 		   RX_HANDLER_SYNC, struct iwl_missed_beacons_notif),
 
@@ -454,7 +451,6 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(STATISTICS_NOTIFICATION),
 	HCMD_NAME(EOSP_NOTIFICATION),
 	HCMD_NAME(REDUCE_TX_POWER_CMD),
-	HCMD_NAME(CARD_STATE_NOTIFICATION),
 	HCMD_NAME(MISSED_BEACONS_NOTIFICATION),
 	HCMD_NAME(TDLS_CONFIG_CMD),
 	HCMD_NAME(MAC_PM_POWER_TABLE),
-- 
2.34.1

