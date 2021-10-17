Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB72430956
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbhJQN2Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53874 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343705AbhJQN2X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6B2-000YdS-2R; Sun, 17 Oct 2021 16:26:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:59 +0300
Message-Id: <20211017132604.480251-2-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: mvm: remove csi from iwl_mvm_pass_packet_to_mac80211()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Remove the unused csi parameter from
iwl_mvm_pass_packet_to_mac80211().  It is not used anymore, but was
accidentally left in.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 0f2ff94d5dfb..e0601f802628 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -240,8 +240,7 @@ static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 					    struct napi_struct *napi,
 					    struct sk_buff *skb, int queue,
-					    struct ieee80211_sta *sta,
-					    bool csi)
+					    struct ieee80211_sta *sta)
 {
 	if (iwl_mvm_check_pn(mvm, skb, queue, sta))
 		kfree_skb(skb);
@@ -619,7 +618,7 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		while ((skb = __skb_dequeue(skb_list))) {
 			iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb,
 							reorder_buf->queue,
-							sta, false);
+							sta);
 			reorder_buf->num_stored--;
 		}
 	}
@@ -1653,7 +1652,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_mvm_rx_phy_data phy_data = {
 		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
 	};
-	bool csi = false;
 	u32 format;
 	bool is_sgi;
 
@@ -2004,7 +2002,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc))
 		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue,
-						sta, csi);
+						sta);
 out:
 	rcu_read_unlock();
 }
-- 
2.33.0

