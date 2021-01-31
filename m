Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9180309EB2
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhAaUKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:10:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43164 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231346AbhAaUI2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:08:28 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMX-0041H2-N2; Sun, 31 Jan 2021 20:22:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:04 +0200
Message-Id: <iwlwifi.20210131201908.719de818c09a.I2788e6a4c411aa414eaa67e6b7b21d90ccd9d0c1@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: mvm: add tx fail time point
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This helps collect on any tx failure fw data to better understand what
went wrong.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 26 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b102fe116f04..03afced82afa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1324,12 +1324,24 @@ static void iwl_mvm_hwrate_to_tx_status(u32 rate_n_flags,
 }
 
 static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
-					    u32 status)
+					    u32 status, __le16 frame_control)
 {
 	struct iwl_fw_dbg_trigger_tlv *trig;
 	struct iwl_fw_dbg_trigger_tx_status *status_trig;
 	int i;
 
+	if ((status & TX_STATUS_MSK) != TX_STATUS_SUCCESS) {
+		enum iwl_fw_ini_time_point tp =
+			IWL_FW_INI_TIME_POINT_TX_FAILED;
+
+		if (ieee80211_is_action(frame_control))
+			tp = IWL_FW_INI_TIME_POINT_TX_WFD_ACTION_FRAME_FAILED;
+
+		iwl_dbg_tlv_time_point(&mvm->fwrt,
+				       tp, NULL);
+		return;
+	}
+
 	trig = iwl_fw_dbg_trigger_on(&mvm->fwrt, NULL,
 				     FW_DBG_TRIGGER_TX_STATUS);
 	if (!trig)
@@ -1447,7 +1459,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		if (skb_freed > 1)
 			info->flags |= IEEE80211_TX_STAT_ACK;
 
-		iwl_mvm_tx_status_check_trigger(mvm, status);
+		iwl_mvm_tx_status_check_trigger(mvm, status, hdr->frame_control);
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
 		iwl_mvm_hwrate_to_tx_status(le32_to_cpu(tx_resp->initial_rate),
@@ -1631,10 +1643,13 @@ static void iwl_mvm_rx_tx_cmd_agg_dbg(struct iwl_mvm *mvm,
 	struct agg_tx_status *frame_status =
 		iwl_mvm_get_agg_status(mvm, tx_resp);
 	int i;
+	bool tirgger_timepoint = false;
 
 	for (i = 0; i < tx_resp->frame_count; i++) {
 		u16 fstatus = le16_to_cpu(frame_status[i].status);
-
+		/* In case one frame wasn't transmitted trigger time point */
+		tirgger_timepoint |= ((fstatus & AGG_TX_STATE_STATUS_MSK) !=
+				      AGG_TX_STATE_TRANSMITTED);
 		IWL_DEBUG_TX_REPLY(mvm,
 				   "status %s (0x%04x), try-count (%d) seq (0x%x)\n",
 				   iwl_get_agg_tx_status(fstatus),
@@ -1643,6 +1658,11 @@ static void iwl_mvm_rx_tx_cmd_agg_dbg(struct iwl_mvm *mvm,
 					AGG_TX_STATE_TRY_CNT_POS,
 				   le16_to_cpu(frame_status[i].sequence));
 	}
+
+	if (tirgger_timepoint)
+		iwl_dbg_tlv_time_point(&mvm->fwrt,
+				       IWL_FW_INI_TIME_POINT_TX_FAILED, NULL);
+
 }
 #else
 static void iwl_mvm_rx_tx_cmd_agg_dbg(struct iwl_mvm *mvm,
-- 
2.29.2

