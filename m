Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48049FAD3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348950AbiA1Nev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37864 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348941AbiA1Neu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:50 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROq-0002DK-HY;
        Fri, 28 Jan 2022 15:34:49 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:32 +0200
Message-Id: <iwlwifi.20220128153014.a89fa3bd9d91.Ibe58c5d9e882dad43aa857aa1c8f54f3358c667b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/13] iwlwifi: mvm: support new BAID allocation command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to some rearchitecting inside the firmware, a new BAID
allocation command is being introduced. Support it. Note
that with it the firmware no longer returns "no space" but
will crash instead, so check for that before sending the
command to the firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 74 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 72 +++++++++++++++++-
 3 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 89236f42c5a4..b0b8f067d544 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -57,6 +57,13 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	CHEST_COLLECTOR_FILTER_CONFIG_CMD = 0x14,
 
+	/**
+	 * @RX_BAID_ALLOCATION_CONFIG_CMD: Allocate/deallocate a BAID for an RX
+	 *	blockack session, uses &struct iwl_rx_baid_cfg_cmd for the
+	 *	command, and &struct iwl_rx_baid_cfg_resp as a response.
+	 */
+	RX_BAID_ALLOCATION_CONFIG_CMD = 0x16,
+
 	/**
 	 * @MONITOR_NOTIF: Datapath monitoring notification, using
 	 *	&struct iwl_datapath_monitor_notif
@@ -257,4 +264,71 @@ struct iwl_rlc_config_cmd {
 	u8 reserved[3];
 } __packed; /* RLC_CONFIG_CMD_API_S_VER_2 */
 
+/**
+ * enum iwl_rx_baid_action - BAID allocation/config action
+ * @IWL_RX_BAID_ACTION_ADD: add a new BAID session
+ * @IWL_RX_BAID_ACTION_MODIFY: modify the BAID session
+ * @IWL_RX_BAID_ACTION_REMOVE: remove the BAID session
+ */
+enum iwl_rx_baid_action {
+	IWL_RX_BAID_ACTION_ADD,
+	IWL_RX_BAID_ACTION_MODIFY,
+	IWL_RX_BAID_ACTION_REMOVE,
+}; /*  RX_BAID_ALLOCATION_ACTION_E_VER_1 */
+
+/**
+ * struct iwl_rx_baid_cfg_cmd_alloc - BAID allocation data
+ * @sta_id_mask: station ID mask
+ * @tid: the TID for this session
+ * @reserved: reserved
+ * @ssn: the starting sequence number
+ * @win_size: RX BA session window size
+ */
+struct iwl_rx_baid_cfg_cmd_alloc {
+	__le32 sta_id_mask;
+	u8 tid;
+	u8 reserved[3];
+	__le16 ssn;
+	__le16 win_size;
+} __packed; /* RX_BAID_ALLOCATION_ADD_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_rx_baid_cfg_cmd_modify - BAID modification data
+ * @sta_id_mask: station ID mask
+ * @baid: the BAID to modify
+ */
+struct iwl_rx_baid_cfg_cmd_modify {
+	__le32 sta_id_mask;
+	__le32 baid;
+} __packed; /* RX_BAID_ALLOCATION_MODIFY_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_rx_baid_cfg_cmd_remove - BAID removal data
+ * @baid: the BAID to remove
+ */
+struct iwl_rx_baid_cfg_cmd_remove {
+	__le32 baid;
+} __packed; /* RX_BAID_ALLOCATION_REMOVE_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_rx_baid_cfg_cmd - BAID allocation/config command
+ * @action: the action, from &enum iwl_rx_baid_action
+ */
+struct iwl_rx_baid_cfg_cmd {
+	__le32 action;
+	union {
+		struct iwl_rx_baid_cfg_cmd_alloc alloc;
+		struct iwl_rx_baid_cfg_cmd_modify modify;
+		struct iwl_rx_baid_cfg_cmd_remove remove;
+	}; /* RX_BAID_ALLOCATION_OPERATION_API_U_VER_1 */
+} __packed; /* RX_BAID_ALLOCATION_CONFIG_CMD_API_S_VER_1 */
+
+/**
+ * struct iwl_rx_baid_cfg_resp - BAID allocation response
+ * @baid: the allocated BAID
+ */
+struct iwl_rx_baid_cfg_resp {
+	__le32 baid;
+}; /* RX_BAID_ALLOCATION_RESPONSE_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index e4ebda64cd52..e7d3032cd3f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -421,6 +421,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_BROADCAST_TWT		= (__force iwl_ucode_tlv_capa_t)60,
 	IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO		= (__force iwl_ucode_tlv_capa_t)61,
 	IWL_UCODE_TLV_CAPA_RFIM_SUPPORT			= (__force iwl_ucode_tlv_capa_t)62,
+	IWL_UCODE_TLV_CAPA_BAID_ML_SUPPORT		= (__force iwl_ucode_tlv_capa_t)63,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 23e5b377f723..ef4d52672674 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2547,8 +2547,10 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 	}
 }
 
-static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvm_sta,
-			      bool start, int tid, u16 ssn, u16 buf_size)
+static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
+				  struct iwl_mvm_sta *mvm_sta,
+				  bool start, int tid, u16 ssn,
+				  u16 buf_size)
 {
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color),
@@ -2593,6 +2595,62 @@ static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvm_sta,
 	}
 }
 
+static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
+				  struct iwl_mvm_sta *mvm_sta,
+				  bool start, int tid, u16 ssn,
+				  u16 buf_size, int baid)
+{
+	struct iwl_rx_baid_cfg_cmd cmd = {
+		.action = start ? cpu_to_le32(IWL_RX_BAID_ACTION_ADD) :
+				  cpu_to_le32(IWL_RX_BAID_ACTION_REMOVE),
+	};
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
+
+	if (start) {
+		cmd.alloc.sta_id_mask = cpu_to_le32(BIT(mvm_sta->sta_id));
+		cmd.alloc.tid = tid;
+		cmd.alloc.ssn = cpu_to_le16(ssn);
+		cmd.alloc.win_size = cpu_to_le16(buf_size);
+		baid = -EIO;
+	} else {
+		cmd.remove.baid = cpu_to_le32(baid);
+	}
+
+	ret = iwl_mvm_send_cmd_pdu_status(mvm, cmd_id, sizeof(cmd),
+					  &cmd, &baid);
+	if (ret)
+		return ret;
+
+	if (!start) {
+		/* ignore firmware baid on remove */
+		baid = 0;
+	}
+
+	IWL_DEBUG_HT(mvm, "RX BA Session %sed in fw\n",
+		     start ? "start" : "stopp");
+
+	if (baid < 0 || baid >= ARRAY_SIZE(mvm->baid_map))
+		return -EINVAL;
+
+	return baid;
+}
+
+static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvm_sta,
+			      bool start, int tid, u16 ssn, u16 buf_size,
+			      int baid)
+{
+	if (fw_has_capa(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_CAPA_BAID_ML_SUPPORT))
+		return iwl_mvm_fw_baid_op_cmd(mvm, mvm_sta, start,
+					      tid, ssn, buf_size, baid);
+
+	return iwl_mvm_fw_baid_op_sta(mvm, mvm_sta, start,
+				      tid, ssn, buf_size);
+}
+
 int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u16 ssn, bool start, u16 buf_size, u16 timeout)
 {
@@ -2648,7 +2706,15 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			reorder_buf_size / sizeof(baid_data->entries[0]);
 	}
 
-	baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size);
+	if (iwl_mvm_has_new_rx_api(mvm) && !start) {
+		baid = mvm_sta->tid_to_baid[tid];
+	} else {
+		/* we don't really need it in this case */
+		baid = -1;
+	}
+
+	baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size,
+				  baid);
 	if (baid < 0) {
 		ret = baid;
 		goto out_free;
-- 
2.34.1

