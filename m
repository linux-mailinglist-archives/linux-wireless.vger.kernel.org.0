Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D432349FAD2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348939AbiA1Nev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:51 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37862 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348937AbiA1Neu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:50 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROp-0002DK-Me;
        Fri, 28 Jan 2022 15:34:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:31 +0200
Message-Id: <iwlwifi.20220128153014.8ec17e282b24.I37c008a9141a2868ee4560e6de303e8bfbb93502@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/13] iwlwifi: mvm: refactor iwl_mvm_sta_rx_agg()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Refactor the firmware call in iwl_mvm_sta_rx_agg() out into
its own function to be able to change it more easily in the
next patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 99 ++++++++++----------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ea3be00d5d1e..23e5b377f723 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2547,14 +2547,58 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 	}
 }
 
+static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvm_sta,
+			      bool start, int tid, u16 ssn, u16 buf_size)
+{
+	struct iwl_mvm_add_sta_cmd cmd = {
+		.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color),
+		.sta_id = mvm_sta->sta_id,
+		.add_modify = STA_MODE_MODIFY,
+	};
+	u32 status;
+	int ret;
+
+	if (start) {
+		cmd.add_immediate_ba_tid = tid;
+		cmd.add_immediate_ba_ssn = cpu_to_le16(ssn);
+		cmd.rx_ba_window = cpu_to_le16(buf_size);
+		cmd.modify_mask = STA_MODIFY_ADD_BA_TID;
+	} else {
+		cmd.remove_immediate_ba_tid = tid;
+		cmd.modify_mask = STA_MODIFY_REMOVE_BA_TID;
+	}
+
+	status = ADD_STA_SUCCESS;
+	ret = iwl_mvm_send_cmd_pdu_status(mvm, ADD_STA,
+					  iwl_mvm_add_sta_cmd_size(mvm),
+					  &cmd, &status);
+	if (ret)
+		return ret;
+
+	switch (status & IWL_ADD_STA_STATUS_MASK) {
+	case ADD_STA_SUCCESS:
+		IWL_DEBUG_HT(mvm, "RX BA Session %sed in fw\n",
+			     start ? "start" : "stopp");
+		if (WARN_ON(start && iwl_mvm_has_new_rx_api(mvm) &&
+			    !(status & IWL_ADD_STA_BAID_VALID_MASK)))
+			return -EINVAL;
+		return u32_get_bits(status, IWL_ADD_STA_BAID_MASK);
+	case ADD_STA_IMMEDIATE_BA_FAILURE:
+		IWL_WARN(mvm, "RX BA Session refused by fw\n");
+		return -ENOSPC;
+	default:
+		IWL_ERR(mvm, "RX BA Session failed %sing, status 0x%x\n",
+			start ? "start" : "stopp", status);
+		return -EIO;
+	}
+}
+
 int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u16 ssn, bool start, u16 buf_size, u16 timeout)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_mvm_add_sta_cmd cmd = {};
 	struct iwl_mvm_baid_data *baid_data = NULL;
-	int ret;
-	u32 status;
+	int ret, baid;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -2604,59 +2648,18 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			reorder_buf_size / sizeof(baid_data->entries[0]);
 	}
 
-	cmd.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color);
-	cmd.sta_id = mvm_sta->sta_id;
-	cmd.add_modify = STA_MODE_MODIFY;
-	if (start) {
-		cmd.add_immediate_ba_tid = (u8) tid;
-		cmd.add_immediate_ba_ssn = cpu_to_le16(ssn);
-		cmd.rx_ba_window = cpu_to_le16(buf_size);
-	} else {
-		cmd.remove_immediate_ba_tid = (u8) tid;
-	}
-	cmd.modify_mask = start ? STA_MODIFY_ADD_BA_TID :
-				  STA_MODIFY_REMOVE_BA_TID;
-
-	status = ADD_STA_SUCCESS;
-	ret = iwl_mvm_send_cmd_pdu_status(mvm, ADD_STA,
-					  iwl_mvm_add_sta_cmd_size(mvm),
-					  &cmd, &status);
-	if (ret)
+	baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size);
+	if (baid < 0) {
+		ret = baid;
 		goto out_free;
-
-	switch (status & IWL_ADD_STA_STATUS_MASK) {
-	case ADD_STA_SUCCESS:
-		IWL_DEBUG_HT(mvm, "RX BA Session %sed in fw\n",
-			     start ? "start" : "stopp");
-		break;
-	case ADD_STA_IMMEDIATE_BA_FAILURE:
-		IWL_WARN(mvm, "RX BA Session refused by fw\n");
-		ret = -ENOSPC;
-		break;
-	default:
-		ret = -EIO;
-		IWL_ERR(mvm, "RX BA Session failed %sing, status 0x%x\n",
-			start ? "start" : "stopp", status);
-		break;
 	}
 
-	if (ret)
-		goto out_free;
-
 	if (start) {
-		u8 baid;
-
 		mvm->rx_ba_sessions++;
 
 		if (!iwl_mvm_has_new_rx_api(mvm))
 			return 0;
 
-		if (WARN_ON(!(status & IWL_ADD_STA_BAID_VALID_MASK))) {
-			ret = -EINVAL;
-			goto out_free;
-		}
-		baid = (u8)((status & IWL_ADD_STA_BAID_MASK) >>
-			    IWL_ADD_STA_BAID_SHIFT);
 		baid_data->baid = baid;
 		baid_data->timeout = timeout;
 		baid_data->last_rx = jiffies;
@@ -2684,7 +2687,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		WARN_ON(rcu_access_pointer(mvm->baid_map[baid]));
 		rcu_assign_pointer(mvm->baid_map[baid], baid_data);
 	} else  {
-		u8 baid = mvm_sta->tid_to_baid[tid];
+		baid = mvm_sta->tid_to_baid[tid];
 
 		if (mvm->rx_ba_sessions > 0)
 			/* check that restart flow didn't zero the counter */
-- 
2.34.1

