Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132AF2D0335
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgLFLIa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34824 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727700AbgLFLIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:30 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrtC-003AAN-B1; Sun, 06 Dec 2020 13:07:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:29 +0200
Message-Id: <iwlwifi.20201206130357.5f34620c1dbd.I4fa68bb2b1c7dcc52ddd381c4042722d27c4a34d@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206110729.488452-1-luca@coelho.fi>
References: <20201206110729.488452-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: validate firmware sync response size
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We send some data to the firmware and expect to get it back,
but we shouldn't really trust the firmware on this. Check the
size of all the data we send down to avoid using bad or just
uninitialized data when the firmware doesn't respond right.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index b27aa4760347..e4f73b6cd94c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -747,10 +747,18 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rxq_sync_notification *notif;
 	struct iwl_mvm_internal_rxq_notif *internal_notif;
+	u32 len = iwl_rx_packet_payload_len(pkt);
 
 	notif = (void *)pkt->data;
 	internal_notif = (void *)notif->payload;
 
+	if (WARN_ONCE(len < sizeof(*notif) + sizeof(*internal_notif),
+		      "invalid notification size %d (%d)",
+		      len, (int)(sizeof(*notif) + sizeof(*internal_notif))))
+		return;
+	/* remove only the firmware header, we want all of our payload below */
+	len -= sizeof(*notif);
+
 	if (internal_notif->sync &&
 	    mvm->queue_sync_cookie != internal_notif->cookie) {
 		WARN_ONCE(1, "Received expired RX queue sync message\n");
@@ -759,11 +767,22 @@ void iwl_mvm_rx_queue_notif(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	switch (internal_notif->type) {
 	case IWL_MVM_RXQ_EMPTY:
+		WARN_ONCE(len != sizeof(*internal_notif),
+			  "invalid empty notification size %d (%d)",
+			  len, (int)sizeof(*internal_notif));
 		break;
 	case IWL_MVM_RXQ_NOTIF_DEL_BA:
+		if (WARN_ONCE(len != sizeof(struct iwl_mvm_rss_sync_notif),
+			      "invalid delba notification size %d (%d)",
+			      len, (int)sizeof(struct iwl_mvm_rss_sync_notif)))
+			break;
 		iwl_mvm_del_ba(mvm, queue, (void *)internal_notif->data);
 		break;
 	case IWL_MVM_RXQ_NSSN_SYNC:
+		if (WARN_ONCE(len != sizeof(struct iwl_mvm_rss_sync_notif),
+			      "invalid nssn sync notification size %d (%d)",
+			      len, (int)sizeof(struct iwl_mvm_rss_sync_notif)))
+			break;
 		iwl_mvm_nssn_sync(mvm, napi, queue,
 				  (void *)internal_notif->data);
 		break;
-- 
2.29.2

