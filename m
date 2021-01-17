Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC02F91DC
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbhAQLLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:11:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40614 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728120AbhAQLLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xB-003sZv-UY; Sun, 17 Jan 2021 13:10:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:29 +0200
Message-Id: <iwlwifi.20210117130510.1370c776cb31.Ic536bd1aee5368969fbf65db85b9b9b5dc9c6034@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: mvm: check more notification sizes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some notifications aren't handled by the general RX handler
code, due to multi-queue. Add size checks for them explicitly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 2a57e51f056a..8ef5399ad9be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -20,6 +20,10 @@
 void iwl_mvm_rx_rx_phy_cmd(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
+
+	if (unlikely(pkt_len < sizeof(mvm->last_phy_info)))
+		return;
 
 	memcpy(&mvm->last_phy_info, pkt->data, sizeof(mvm->last_phy_info));
 	mvm->ampdu_ref++;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 4dc7c65a1130..7509d73ae724 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1938,6 +1938,9 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
 	};
 
+	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*desc)))
+		return;
+
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
@@ -2067,6 +2070,9 @@ void iwl_mvm_rx_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_frame_release *release = (void *)pkt->data;
 
+	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*release)))
+		return;
+
 	iwl_mvm_release_frames_from_notif(mvm, napi, release->baid,
 					  le16_to_cpu(release->nssn),
 					  queue, 0);
@@ -2087,6 +2093,9 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 					 IWL_BAR_FRAME_RELEASE_TID_MASK);
 	struct iwl_mvm_baid_data *baid_data;
 
+	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*release)))
+		return;
+
 	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
 			 baid >= ARRAY_SIZE(mvm->baid_map)))
 		return;
-- 
2.29.2

