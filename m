Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE36EF0A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfGTK0G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59458 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZ1-0000Hj-NI; Sat, 20 Jul 2019 13:26:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:33 +0300
Message-Id: <20190720102545.5952-5-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/16] iwlwiif: mvm: refactor iwl_mvm_notify_rx_queue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Instead of allocating memory for which we have an upper
limit, use a small buffer on stack.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c  | 17 +++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index ed69eec4fcd9..9b0bb89599fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -776,7 +776,6 @@ struct iwl_rss_config_cmd {
 	u8 indirection_table[IWL_RSS_INDIRECTION_TABLE_SIZE];
 } __packed; /* RSS_CONFIG_CMD_API_S_VER_1 */
 
-#define IWL_MULTI_QUEUE_SYNC_MSG_MAX_SIZE 128
 #define IWL_MULTI_QUEUE_SYNC_SENDER_POS 0
 #define IWL_MULTI_QUEUE_SYNC_SENDER_MSK 0xf
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index bf097329efa2..16078aa7c95f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -465,18 +465,20 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
 			    const u8 *data, u32 count)
 {
-	struct iwl_rxq_sync_cmd *cmd;
+	u8 buf[sizeof(struct iwl_rxq_sync_cmd) +
+	       sizeof(struct iwl_mvm_rss_sync_notif)];
+	struct iwl_rxq_sync_cmd *cmd = (void *)buf;
 	u32 data_size = sizeof(*cmd) + count;
 	int ret;
 
-	/* should be DWORD aligned */
-	if (WARN_ON(count & 3 || count > IWL_MULTI_QUEUE_SYNC_MSG_MAX_SIZE))
+	/*
+	 * size must be a multiple of DWORD
+	 * Ensure we don't overflow buf
+	 */
+	if (WARN_ON(count & 3 ||
+		    count > sizeof(struct iwl_mvm_rss_sync_notif)))
 		return -EINVAL;
 
-	cmd = kzalloc(data_size, GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
 	cmd->rxq_mask = cpu_to_le32(rxq_mask);
 	cmd->count =  cpu_to_le32(count);
 	cmd->flags = 0;
@@ -487,7 +489,6 @@ int iwl_mvm_notify_rx_queue(struct iwl_mvm *mvm, u32 rxq_mask,
 					   TRIGGER_RX_QUEUES_NOTIF_CMD),
 				   0, data_size, cmd);
 
-	kfree(cmd);
 	return ret;
 }
 
-- 
2.20.1

