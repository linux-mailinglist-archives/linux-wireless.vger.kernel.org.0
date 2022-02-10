Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495464B1386
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbiBJQw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbiBJQw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:28 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2EA1BE
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:27 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDe-000Bxy-Su;
        Thu, 10 Feb 2022 18:22:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:32 +0200
Message-Id: <iwlwifi.20220210181930.bc424f15cc4b.I06d9acae11dc69b2500666f497017a3fd4e2acd5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 09/11] iwlwifi: mvm: update BAID allocation command again
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to some issues found in integration, the command now has
the (old) station mask and TID in modify/remove instead of
the BAID, adjust accordingly.

Since we don't use modify yet (and never will with v1 of the
API), just add v1 remove inside the existing union, and use
that, this way we don't have to duplicate everything, only
the remove code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 31 +++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 +++-
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index d268a9cba5ce..43619acc29fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -304,22 +304,34 @@ struct iwl_rx_baid_cfg_cmd_alloc {
 
 /**
  * struct iwl_rx_baid_cfg_cmd_modify - BAID modification data
- * @sta_id_mask: station ID mask
- * @baid: the BAID to modify
+ * @old_sta_id_mask: old station ID mask
+ * @new_sta_id_mask: new station ID mask
+ * @tid: TID of the BAID
  */
 struct iwl_rx_baid_cfg_cmd_modify {
-	__le32 sta_id_mask;
-	__le32 baid;
-} __packed; /* RX_BAID_ALLOCATION_MODIFY_CMD_API_S_VER_1 */
+	__le32 old_sta_id_mask;
+	__le32 new_sta_id_mask;
+	__le32 tid;
+} __packed; /* RX_BAID_ALLOCATION_MODIFY_CMD_API_S_VER_2 */
 
 /**
- * struct iwl_rx_baid_cfg_cmd_remove - BAID removal data
+ * struct iwl_rx_baid_cfg_cmd_remove_v1 - BAID removal data
  * @baid: the BAID to remove
  */
-struct iwl_rx_baid_cfg_cmd_remove {
+struct iwl_rx_baid_cfg_cmd_remove_v1 {
 	__le32 baid;
 } __packed; /* RX_BAID_ALLOCATION_REMOVE_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_rx_baid_cfg_cmd_remove - BAID removal data
+ * @sta_id_mask: the station mask of the BAID to remove
+ * @tid: the TID of the BAID to remove
+ */
+struct iwl_rx_baid_cfg_cmd_remove {
+	__le32 sta_id_mask;
+	__le32 tid;
+} __packed; /* RX_BAID_ALLOCATION_REMOVE_CMD_API_S_VER_2 */
+
 /**
  * struct iwl_rx_baid_cfg_cmd - BAID allocation/config command
  * @action: the action, from &enum iwl_rx_baid_action
@@ -329,9 +341,10 @@ struct iwl_rx_baid_cfg_cmd {
 	union {
 		struct iwl_rx_baid_cfg_cmd_alloc alloc;
 		struct iwl_rx_baid_cfg_cmd_modify modify;
+		struct iwl_rx_baid_cfg_cmd_remove_v1 remove_v1;
 		struct iwl_rx_baid_cfg_cmd_remove remove;
-	}; /* RX_BAID_ALLOCATION_OPERATION_API_U_VER_1 */
-} __packed; /* RX_BAID_ALLOCATION_CONFIG_CMD_API_S_VER_1 */
+	}; /* RX_BAID_ALLOCATION_OPERATION_API_U_VER_2 */
+} __packed; /* RX_BAID_ALLOCATION_CONFIG_CMD_API_S_VER_2 */
 
 /**
  * struct iwl_rx_baid_cfg_resp - BAID allocation response
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 03869bb7dcee..9adca4619a15 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2659,8 +2659,12 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
 		baid = -EIO;
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1) == 1) {
+		cmd.remove_v1.baid = cpu_to_le32(baid);
+		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
-		cmd.remove.baid = cpu_to_le32(baid);
+		cmd.remove.sta_id_mask = cpu_to_le32(BIT(mvm_sta->sta_id));
+		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
 	ret = iwl_mvm_send_cmd_pdu_status(mvm, cmd_id, sizeof(cmd),
-- 
2.34.1

