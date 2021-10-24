Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F24389CC
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJXPXV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58668 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231372AbhJXPXU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIv-000czj-V8; Sun, 24 Oct 2021 18:20:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:35 +0300
Message-Id: <iwlwifi.20211024181719.24b71b0cb741.I97deb70e18f259de51395a1e7c7e58c7b006c317@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/12] iwlwifi: rename CHANNEL_SWITCH_NOA_NOTIF to CHANNEL_SWITCH_START_NOTIF
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

There is no relation between the name and the purpose of the
notification. This notification is sent from FW when the channel switch
starts.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c        |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 6610d1234f74..d088c820b1a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -39,9 +39,9 @@ enum iwl_mac_conf_subcmd_ids {
 	PROBE_RESPONSE_DATA_NOTIF = 0xFC,
 
 	/**
-	 * @CHANNEL_SWITCH_NOA_NOTIF: &struct iwl_channel_switch_noa_notif
+	 * @CHANNEL_SWITCH_START_NOTIF: &struct iwl_channel_switch_start_notif
 	 */
-	CHANNEL_SWITCH_NOA_NOTIF = 0xFF,
+	CHANNEL_SWITCH_START_NOTIF = 0xFF,
 };
 
 #define IWL_P2P_NOA_DESC_COUNT	(2)
@@ -102,11 +102,11 @@ struct iwl_missed_vap_notif {
 } __packed; /* MISSED_VAP_NTFY_API_S_VER_1 */
 
 /**
- * struct iwl_channel_switch_noa_notif - Channel switch NOA notification
+ * struct iwl_channel_switch_start_notif - Channel switch start notification
  *
  * @id_and_color: ID and color of the MAC
  */
-struct iwl_channel_switch_noa_notif {
+struct iwl_channel_switch_start_notif {
 	__le32 id_and_color;
 } __packed; /* CHANNEL_SWITCH_START_NTFY_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cfb69e49a687..fd7d4abfb454 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1557,11 +1557,11 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 		ieee80211_beacon_set_cntdwn(vif, notif->csa_counter);
 }
 
-void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
-				      struct iwl_rx_cmd_buffer *rxb)
+void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
+					struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_channel_switch_noa_notif *notif = (void *)pkt->data;
+	struct iwl_channel_switch_start_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *csa_vif, *vif;
 	struct iwl_mvm_vif *mvmvif;
 	u32 id_n_color, csa_id, mac_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4277536e31c3..2b1dcd60e00f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1658,8 +1658,8 @@ void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 				   struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
-void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
-				      struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
+					struct iwl_rx_cmd_buffer *rxb);
 /* Bindings */
 int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 0ad45d11c9e0..232ad531d612 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -383,9 +383,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       iwl_mvm_probe_resp_data_notif,
 		       RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_probe_resp_data_notif),
-	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_NOA_NOTIF,
-		       iwl_mvm_channel_switch_noa_notif,
-		       RX_HANDLER_SYNC, struct iwl_channel_switch_noa_notif),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_START_NOTIF,
+		       iwl_mvm_channel_switch_start_notif,
+		       RX_HANDLER_SYNC, struct iwl_channel_switch_start_notif),
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_datapath_monitor_notif),
@@ -511,7 +511,7 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(CHANNEL_SWITCH_TIME_EVENT_CMD),
 	HCMD_NAME(SESSION_PROTECTION_CMD),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
-	HCMD_NAME(CHANNEL_SWITCH_NOA_NOTIF),
+	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
 
 /* Please keep this array *SORTED* by hex value.
-- 
2.33.0

