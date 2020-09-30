Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA527EEDC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgI3QUG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53412 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728674AbgI3QUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepn-002MPc-OL; Wed, 30 Sep 2020 19:20:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:49 +0300
Message-Id: <iwlwifi.20200930191738.0ba403d72e7c.I5fa3aa0538f3fbf8c3885b27a1204b5b0464c20a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: align RX status flags with firmware
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are some bits declared here that simply don't exist
in the firmware, and some are missing (e.g. the key) from
what the firmware has. Align this and move all the fields
into a single one for this status word, which makes this a
bit easier.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 23 ++++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 12 +++++-----
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 05923e39b600..8a8a204bfe26 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -308,17 +308,11 @@ enum iwl_rx_mpdu_status {
 	IWL_RX_MPDU_STATUS_EXT_IV_MATCH		= BIT(13),
 	IWL_RX_MPDU_STATUS_KEY_ID_MATCH		= BIT(14),
 	IWL_RX_MPDU_STATUS_ROBUST_MNG_FRAME	= BIT(15),
-};
 
-enum iwl_rx_mpdu_hash_filter {
-	IWL_RX_MPDU_HF_A1_HASH_MASK		= 0x3f,
-	IWL_RX_MPDU_HF_FILTER_STATUS_MASK	= 0xc0,
-};
+	IWL_RX_MPDU_STATUS_KEY			= 0x3f0000,
+	IWL_RX_MPDU_STATUS_DUPLICATE		= BIT(22),
 
-enum iwl_rx_mpdu_sta_id_flags {
-	IWL_RX_MPDU_SIF_STA_ID_MASK		= 0x1f,
-	IWL_RX_MPDU_SIF_RRF_ABORT		= 0x20,
-	IWL_RX_MPDU_SIF_FILTER_STATUS_MASK	= 0xc0,
+	IWL_RX_MPDU_STATUS_STA_ID		= 0x1f000000,
 };
 
 #define IWL_RX_REORDER_DATA_INVALID_BAID 0x7f
@@ -672,15 +666,8 @@ struct iwl_rx_mpdu_desc {
 	/**
 	 * @status: &enum iwl_rx_mpdu_status
 	 */
-	__le16 status;
-	/**
-	 * @hash_filter: hash filter value
-	 */
-	u8 hash_filter;
-	/**
-	 * @sta_id_flags: &enum iwl_rx_mpdu_sta_id_flags
-	 */
-	u8 sta_id_flags;
+	__le32 status;
+
 	/* DW6 */
 	/**
 	 * @reorder_data: &enum iwl_rx_mpdu_reorder_data
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 5cade5946cc4..ea29aeb86eef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -333,7 +333,7 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 			     struct iwl_rx_mpdu_desc *desc,
 			     u32 pkt_flags, int queue, u8 *crypt_len)
 {
-	u16 status = le16_to_cpu(desc->status);
+	u32 status = le32_to_cpu(desc->status);
 
 	/*
 	 * Drop UNKNOWN frames in aggregation, unless in monitor mode
@@ -1707,10 +1707,10 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	 * Keep packets with CRC errors (and with overrun) for monitor mode
 	 * (otherwise the firmware discards them) but mark them as bad.
 	 */
-	if (!(desc->status & cpu_to_le16(IWL_RX_MPDU_STATUS_CRC_OK)) ||
-	    !(desc->status & cpu_to_le16(IWL_RX_MPDU_STATUS_OVERRUN_OK))) {
+	if (!(desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_CRC_OK)) ||
+	    !(desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_OVERRUN_OK))) {
 		IWL_DEBUG_RX(mvm, "Bad CRC or FIFO: 0x%08X.\n",
-			     le16_to_cpu(desc->status));
+			     le32_to_cpu(desc->status));
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
 	/* set the preamble flag if appropriate */
@@ -1770,8 +1770,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	rcu_read_lock();
 
-	if (desc->status & cpu_to_le16(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
-		u8 id = desc->sta_id_flags & IWL_RX_MPDU_SIF_STA_ID_MASK;
+	if (desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_SRC_STA_FOUND)) {
+		u8 id = le32_get_bits(desc->status, IWL_RX_MPDU_STATUS_STA_ID);
 
 		if (!WARN_ON_ONCE(id >= ARRAY_SIZE(mvm->fw_id_to_mac_id))) {
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[id]);
-- 
2.28.0

