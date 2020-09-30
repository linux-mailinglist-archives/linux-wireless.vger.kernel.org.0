Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F227EA06
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgI3Nbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53384 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730197AbgI3Nbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCn-002MJ5-Ed; Wed, 30 Sep 2020 16:31:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:23 +0300
Message-Id: <iwlwifi.20200930161256.fa11d1f523b6.Id105899da82c2b08ee62b57133c4ff72bfd0bb80@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: phy-ctxt: add new API VER 3 for phy context cmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The API added the ability to send for CDB nic what LMAC ID
the cmd belongs to.

Also driver always set apply_time to zero so no need to pass it as
a param and anyway in new API it's removed for no use.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  32 ++++-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 126 +++++++++++++-----
 2 files changed, 116 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index b833b80ea3d6..e6a069683462 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018        Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018, 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -181,15 +179,37 @@ struct iwl_phy_context_cmd_tail {
  * @ci: channel info
  * @tail: command tail
  */
-struct iwl_phy_context_cmd {
+struct iwl_phy_context_cmd_v1 {
 	/* COMMON_INDEX_HDR_API_S_VER_1 */
 	__le32 id_and_color;
 	__le32 action;
-	/* PHY_CONTEXT_DATA_API_S_VER_1 */
+	/* PHY_CONTEXT_DATA_API_S_VER_3 */
 	__le32 apply_time;
 	__le32 tx_param_color;
 	struct iwl_fw_channel_info ci;
 	struct iwl_phy_context_cmd_tail tail;
 } __packed; /* PHY_CONTEXT_CMD_API_VER_1 */
 
+/**
+ * struct iwl_phy_context_cmd - config of the PHY context
+ * ( PHY_CONTEXT_CMD = 0x8 )
+ * @id_and_color: ID and color of the relevant Binding
+ * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @lmac_id: the lmac id the phy context belongs to
+ * @ci: channel info
+ * @rxchain_info: ???
+ * @dsp_cfg_flags: set to 0
+ * @reserved: reserved to align to 64 bit
+ */
+struct iwl_phy_context_cmd {
+	/* COMMON_INDEX_HDR_API_S_VER_1 */
+	__le32 id_and_color;
+	__le32 action;
+	/* PHY_CONTEXT_DATA_API_S_VER_3 */
+	struct iwl_fw_channel_info ci;
+	__le32 lmac_id;
+	__le32 rxchain_info;
+	__le32 dsp_cfg_flags;
+	__le32 reserved;
+} __packed; /* PHY_CONTEXT_CMD_API_VER_3 */
 #endif /* __iwl_fw_api_phy_ctxt_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 0243dbe8ac49..a5da4106ba5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -7,8 +7,8 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
- * Copyright(c) 2017           Intel Deutschland GmbH
- * Copyright(c) 2018           Intel Corporation
+ * Copyright(c) 2017        Intel Deutschland GmbH
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -30,7 +30,7 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
- * Copyright(c) 2018           Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -125,30 +125,19 @@ u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef)
  */
 static void iwl_mvm_phy_ctxt_cmd_hdr(struct iwl_mvm_phy_ctxt *ctxt,
 				     struct iwl_phy_context_cmd *cmd,
-				     u32 action, u32 apply_time)
+				     u32 action)
 {
-	memset(cmd, 0, sizeof(struct iwl_phy_context_cmd));
-
 	cmd->id_and_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(ctxt->id,
 							    ctxt->color));
 	cmd->action = cpu_to_le32(action);
-	cmd->apply_time = cpu_to_le32(apply_time);
 }
 
-/*
- * Add the phy configuration to the PHY context command
- */
-static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
-				      struct iwl_phy_context_cmd *cmd,
-				      struct cfg80211_chan_def *chandef,
-				      u8 chains_static, u8 chains_dynamic)
+static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
+					 __le32 *rxchain_info,
+					 u8 chains_static,
+					 u8 chains_dynamic)
 {
 	u8 active_cnt, idle_cnt;
-	struct iwl_phy_context_cmd_tail *tail =
-		iwl_mvm_chan_info_cmd_tail(mvm, &cmd->ci);
-
-	/* Set the channel info data */
-	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
 
 	/* Set rx the chains */
 	idle_cnt = chains_static;
@@ -166,19 +155,58 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 		active_cnt = 2;
 	}
 
-	tail->rxchain_info = cpu_to_le32(iwl_mvm_get_valid_rx_ant(mvm) <<
+	*rxchain_info = cpu_to_le32(iwl_mvm_get_valid_rx_ant(mvm) <<
 					PHY_RX_CHAIN_VALID_POS);
-	tail->rxchain_info |= cpu_to_le32(idle_cnt << PHY_RX_CHAIN_CNT_POS);
-	tail->rxchain_info |= cpu_to_le32(active_cnt <<
+	*rxchain_info |= cpu_to_le32(idle_cnt << PHY_RX_CHAIN_CNT_POS);
+	*rxchain_info |= cpu_to_le32(active_cnt <<
 					 PHY_RX_CHAIN_MIMO_CNT_POS);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	if (unlikely(mvm->dbgfs_rx_phyinfo))
-		tail->rxchain_info = cpu_to_le32(mvm->dbgfs_rx_phyinfo);
+		*rxchain_info = cpu_to_le32(mvm->dbgfs_rx_phyinfo);
 #endif
+}
+
+/*
+ * Add the phy configuration to the PHY context command
+ */
+static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
+					 struct iwl_phy_context_cmd_v1 *cmd,
+					 struct cfg80211_chan_def *chandef,
+					 u8 chains_static, u8 chains_dynamic)
+{
+	struct iwl_phy_context_cmd_tail *tail =
+		iwl_mvm_chan_info_cmd_tail(mvm, &cmd->ci);
+
+	/* Set the channel info data */
+	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
+
+	iwl_mvm_phy_ctxt_set_rxchain(mvm, &tail->rxchain_info,
+				     chains_static, chains_dynamic);
 
 	tail->txchain_info = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
 }
 
+/*
+ * Add the phy configuration to the PHY context command
+ */
+static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
+				      struct iwl_phy_context_cmd *cmd,
+				      struct cfg80211_chan_def *chandef,
+				      u8 chains_static, u8 chains_dynamic)
+{
+	if (chandef->chan->band == NL80211_BAND_2GHZ ||
+	    !iwl_mvm_is_cdb_supported(mvm))
+		cmd->lmac_id = cpu_to_le32(IWL_LMAC_24G_INDEX);
+	else
+		cmd->lmac_id = cpu_to_le32(IWL_LMAC_5G_INDEX);
+
+	/* Set the channel info data */
+	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
+
+	iwl_mvm_phy_ctxt_set_rxchain(mvm, &cmd->rxchain_info,
+				     chains_static, chains_dynamic);
+}
+
 /*
  * Send a command to apply the current phy configuration. The command is send
  * only if something in the configuration changed: in case that this is the
@@ -189,20 +217,46 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt,
 				  struct cfg80211_chan_def *chandef,
 				  u8 chains_static, u8 chains_dynamic,
-				  u32 action, u32 apply_time)
+				  u32 action)
 {
-	struct iwl_phy_context_cmd cmd;
 	int ret;
-	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
-
-	/* Set the command header fields */
-	iwl_mvm_phy_ctxt_cmd_hdr(ctxt, &cmd, action, apply_time);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					PHY_CONTEXT_CMD, 1);
+
+	if (ver == 3) {
+		struct iwl_phy_context_cmd cmd = {};
+
+		/* Set the command header fields */
+		iwl_mvm_phy_ctxt_cmd_hdr(ctxt, &cmd, action);
+
+		/* Set the command data */
+		iwl_mvm_phy_ctxt_cmd_data(mvm, &cmd, chandef,
+					  chains_static,
+					  chains_dynamic);
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
+					   0, sizeof(cmd), &cmd);
+	} else if (ver < 3) {
+		struct iwl_phy_context_cmd_v1 cmd = {};
+		u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
+
+		/* Set the command header fields */
+		iwl_mvm_phy_ctxt_cmd_hdr(ctxt,
+					 (struct iwl_phy_context_cmd *)&cmd,
+					 action);
+
+		/* Set the command data */
+		iwl_mvm_phy_ctxt_cmd_data_v1(mvm, &cmd, chandef,
+					     chains_static,
+					     chains_dynamic);
+		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
+					   0, len, &cmd);
+	} else {
+		IWL_ERR(mvm, "PHY ctxt cmd error ver %d not supported\n", ver);
+		return -EOPNOTSUPP;
+	}
 
-	/* Set the command data */
-	iwl_mvm_phy_ctxt_cmd_data(mvm, &cmd, chandef,
-				  chains_static, chains_dynamic);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD, 0, len, &cmd);
 	if (ret)
 		IWL_ERR(mvm, "PHY ctxt cmd error. ret=%d\n", ret);
 	return ret;
@@ -223,7 +277,7 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				      chains_static, chains_dynamic,
-				      FW_CTXT_ACTION_ADD, 0);
+				      FW_CTXT_ACTION_ADD);
 }
 
 /*
@@ -257,7 +311,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 		/* ... remove it here ...*/
 		ret = iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 					     chains_static, chains_dynamic,
-					     FW_CTXT_ACTION_REMOVE, 0);
+					     FW_CTXT_ACTION_REMOVE);
 		if (ret)
 			return ret;
 
@@ -269,7 +323,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	ctxt->width = chandef->width;
 	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				      chains_static, chains_dynamic,
-				      action, 0);
+				      action);
 }
 
 void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
-- 
2.28.0

