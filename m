Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB6327EA02
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgI3Nbj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53354 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730481AbgI3Nbi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCl-002MJ5-3d; Wed, 30 Sep 2020 16:31:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:20 +0300
Message-Id: <iwlwifi.20200930161256.2704e4c384c9.Ib738ffa2bc6ce635a855944a71a01fd6b82929a4@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: mvm: add d3 prints
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

This is long overdue - add a special WOWLAN flag, and D3
prints. It will ease debug and enable test automation. Use
a new flag, instead of one that currently isn't used.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 063d8add147f..528eba441926 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project.
  *
@@ -139,7 +139,7 @@ do {                                            			\
 /* 0x00000F00 - 0x00000100 */
 #define IWL_DL_POWER		0x00000100
 #define IWL_DL_TEMP		0x00000200
-#define IWL_DL_RPM		0x00000400
+#define IWL_DL_WOWLAN		0x00000400
 #define IWL_DL_SCAN		0x00000800
 /* 0x0000F000 - 0x00001000 */
 #define IWL_DL_ASSOC		0x00001000
@@ -205,7 +205,7 @@ do {                                            			\
 #define IWL_DEBUG_POWER(p, f, a...)	IWL_DEBUG(p, IWL_DL_POWER, f, ## a)
 #define IWL_DEBUG_11H(p, f, a...)	IWL_DEBUG(p, IWL_DL_11H, f, ## a)
 #define IWL_DEBUG_TPT(p, f, a...)	IWL_DEBUG(p, IWL_DL_TPT, f, ## a)
-#define IWL_DEBUG_RPM(p, f, a...)	IWL_DEBUG(p, IWL_DL_RPM, f, ## a)
+#define IWL_DEBUG_WOWLAN(p, f, a...)	IWL_DEBUG(p, IWL_DL_WOWLAN, f, ## a)
 #define IWL_DEBUG_LAR(p, f, a...)	IWL_DEBUG(p, IWL_DL_LAR, f, ## a)
 #define IWL_DEBUG_FW_INFO(p, f, a...)		\
 		IWL_DEBUG(p, IWL_DL_INFO | IWL_DL_FW, f, ## a)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 5f6092d548cf..20c30a6be259 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -377,6 +377,8 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		break;
 	}
 
+	IWL_DEBUG_WOWLAN(mvm, "GTK cipher %d\n", data->kek_kck_cmd->gtk_cipher);
+
 	if (data->configure_keys) {
 		mutex_lock(&mvm->mutex);
 		/*
@@ -878,6 +880,9 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		kek_kck_cmd.replay_ctr = mvmvif->rekey_data.replay_ctr;
 		kek_kck_cmd.akm = cpu_to_le32(mvmvif->rekey_data.akm);
 
+		IWL_DEBUG_WOWLAN(mvm, "setting akm %d\n",
+				 mvmvif->rekey_data.akm);
+
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WOWLAN_KEK_KCK_MATERIAL, cmd_flags,
 					   cmd_size,
@@ -1542,6 +1547,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	ieee80211_iter_keys(mvm->hw, vif,
 			    iwl_mvm_d3_update_keys, &gtkdata);
 
+	IWL_DEBUG_WOWLAN(mvm, "num of GTK rekeying %d\n",
+			 le32_to_cpu(status->num_of_gtk_rekeys));
 	if (status->num_of_gtk_rekeys) {
 		struct ieee80211_key_conf *key;
 		struct {
@@ -1554,6 +1561,9 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		};
 		__be64 replay_ctr;
 
+		IWL_DEBUG_WOWLAN(mvm,
+				 "Received from FW GTK cipher %d, key index %d\n",
+				 conf.conf.cipher, conf.conf.keyidx);
 		switch (gtkdata.cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_GCMP:
@@ -1740,6 +1750,9 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	if (IS_ERR_OR_NULL(fw_status))
 		goto out_unlock;
 
+	IWL_DEBUG_WOWLAN(mvm, "wakeup reason 0x%x\n",
+			 le32_to_cpu(fw_status->wakeup_reasons));
+
 	status.pattern_number = le16_to_cpu(fw_status->pattern_number);
 	for (i = 0; i < 8; i++)
 		status.qos_seq_ctr[i] =
-- 
2.28.0

