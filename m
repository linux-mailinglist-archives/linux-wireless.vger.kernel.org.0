Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E842D0199
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLFIXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:23:50 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34694 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgLFIXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:23:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpJ4-003A2r-2x; Sun, 06 Dec 2020 10:22:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:58 +0200
Message-Id: <iwlwifi.20201206100942.1556f9faa431.I9ac366aa97db045be4daa4ba263267a3ac6a6a2f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: mvm: clear up iwl_mvm_notify_rx_queue() argument type
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The argument type to iwl_mvm_notify_rx_queue() is currently just
a u8 *, but that's misleading because we actually need the inner
data to be of type struct iwl_mvm_internal_rxq_notif, because we
interpret it when we get it back from the device (to check the
sync bool and possibly the cookie.)

Therefore, clear up any potential confusion and require that the
data passed is of type struct iwl_mvm_internal_rxq_notif *.

Also, while at it, rename the "count" to "notif_size" as "count"
doesn't really clearly say what it's counting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 13 +++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f1d345dfc36..766aeeaf1fcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5101,8 +5101,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 			   mvm->trans->num_rx_queues);
 	}
 
-	ret = iwl_mvm_notify_rx_queue(mvm, qmask, (u8 *)notif,
-				      size, !notif->sync);
+	ret = iwl_mvm_notify_rx_queue(mvm, qmask, notif, size, !notif->sync);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to trigger RX queues sync (%d)\n", ret);
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 047bd47df32e..7e28a088f3e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1615,7 +1615,8 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 				  struct iwl_rx_cmd_buffer *rxb, int queue);
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const u8 *data, u32 count, bool async);
+			    const struct iwl_mvm_internal_rxq_notif *notif,
+			    u32 notif_size, bool async);
 void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 			    struct iwl_rx_cmd_buffer *rxb, int queue);
 void iwl_mvm_rx_tx_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1d51ec95ec21..ef5bd58ef742 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -510,26 +510,27 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 }
 
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
-			    const u8 *data, u32 count, bool async)
+			    const struct iwl_mvm_internal_rxq_notif *notif,
+			    u32 notif_size, bool async)
 {
 	u8 buf[sizeof(struct iwl_rxq_sync_cmd) +
 	       sizeof(struct iwl_mvm_rss_sync_notif)];
 	struct iwl_rxq_sync_cmd *cmd = (void *)buf;
-	u32 data_size = sizeof(*cmd) + count;
+	u32 data_size = sizeof(*cmd) + notif_size;
 	int ret;
 
 	/*
 	 * size must be a multiple of DWORD
 	 * Ensure we don't overflow buf
 	 */
-	if (WARN_ON(count & 3 ||
-		    count > sizeof(struct iwl_mvm_rss_sync_notif)))
+	if (WARN_ON(notif_size & 3 ||
+		    notif_size > sizeof(struct iwl_mvm_rss_sync_notif)))
 		return -EINVAL;
 
 	cmd->rxq_mask = cpu_to_le32(rxq_mask);
-	cmd->count =  cpu_to_le32(count);
+	cmd->count =  cpu_to_le32(notif_size);
 	cmd->flags = 0;
-	memcpy(cmd->payload, data, count);
+	memcpy(cmd->payload, notif, notif_size);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(DATA_PATH_GROUP,
-- 
2.29.2

