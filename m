Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A47129BDD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLWXrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54702 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfLWXrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQD-00010j-Cw; Tue, 24 Dec 2019 01:47:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:16 +0200
Message-Id: <20191223234721.1513938-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223234721.1513938-1-luca@coelho.fi>
References: <20191223234721.1513938-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 2/7] iwlwifi: mvm: fix potential SKB leak on TXQ TX
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we transmit after TXQ dequeue, we aren't paying attention to
the return value of the transmit functions, leading to a potential
SKB leak.

Refactor the code a bit (and rename ..._tx to ..._tx_sta) to check
for this happening.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: cfbc6c4c5b91 ("iwlwifi: mvm: support mac80211 TXQs model")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 28 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  4 +--
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a46204b905d2..6717f25c46b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -755,6 +755,20 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	return ret;
 }
 
+static void iwl_mvm_tx_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
+			   struct ieee80211_sta *sta)
+{
+	if (likely(sta)) {
+		if (likely(iwl_mvm_tx_skb_sta(mvm, skb, sta) == 0))
+			return;
+	} else {
+		if (likely(iwl_mvm_tx_skb_non_sta(mvm, skb) == 0))
+			return;
+	}
+
+	ieee80211_free_txskb(mvm->hw, skb);
+}
+
 static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 			   struct ieee80211_tx_control *control,
 			   struct sk_buff *skb)
@@ -798,14 +812,7 @@ static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (sta) {
-		if (iwl_mvm_tx_skb(mvm, skb, sta))
-			goto drop;
-		return;
-	}
-
-	if (iwl_mvm_tx_skb_non_sta(mvm, skb))
-		goto drop;
+	iwl_mvm_tx_skb(mvm, skb, sta);
 	return;
  drop:
 	ieee80211_free_txskb(hw, skb);
@@ -855,10 +862,7 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 				break;
 			}
 
-			if (!txq->sta)
-				iwl_mvm_tx_skb_non_sta(mvm, skb);
-			else
-				iwl_mvm_tx_skb(mvm, skb, txq->sta);
+			iwl_mvm_tx_skb(mvm, skb, txq->sta);
 		}
 	} while (atomic_dec_return(&mvmtxq->tx_request));
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3ec8de00f3aa..e5b21f8b02e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1508,8 +1508,8 @@ int __must_check iwl_mvm_send_cmd_status(struct iwl_mvm *mvm,
 int __must_check iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id,
 					     u16 len, const void *data,
 					     u32 *status);
-int iwl_mvm_tx_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
-		   struct ieee80211_sta *sta);
+int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
+		       struct ieee80211_sta *sta);
 int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb);
 void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 			struct iwl_tx_cmd *tx_cmd,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index eaeb8501c9b5..ddfc9a668036 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1201,8 +1201,8 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	return -1;
 }
 
-int iwl_mvm_tx_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
-		   struct ieee80211_sta *sta)
+int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
+		       struct ieee80211_sta *sta)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct ieee80211_tx_info info;
-- 
2.24.0

