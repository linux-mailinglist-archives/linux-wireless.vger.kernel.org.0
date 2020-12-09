Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799CD2D4CD2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgLIV1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:27:24 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35808 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387941AbgLIV1Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:27:24 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6ph-003Drx-Dj; Wed, 09 Dec 2020 23:17:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:24 +0200
Message-Id: <iwlwifi.20201209231352.7c721ad37014.Id5746874ecfa208b60baa62691b2d9dc5dd4d89c@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 20/47] iwlwifi: validate MPDU length against notification length
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The MPDU contained in a notification shouldn't be larger than the
notification size itself is, validate this.

Reported-by: Haggai Abramovsky <haggai.abramovsky@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   | 10 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  8 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  6 ++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 9d55ece05020..d06278558b33 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018, 2020 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portionhelp of the ieee80211 subsystem header files.
@@ -786,7 +786,7 @@ static void iwlagn_rx_reply_rx(struct iwl_priv *priv,
 	struct iwl_rx_phy_res *phy_res;
 	__le32 rx_pkt_status;
 	struct iwl_rx_mpdu_res_start *amsdu;
-	u32 len;
+	u32 len, pkt_len = iwl_rx_packet_len(pkt);
 	u32 ampdu_status;
 	u32 rate_n_flags;
 
@@ -798,6 +798,12 @@ static void iwlagn_rx_reply_rx(struct iwl_priv *priv,
 	amsdu = (struct iwl_rx_mpdu_res_start *)pkt->data;
 	header = (struct ieee80211_hdr *)(pkt->data + sizeof(*amsdu));
 	len = le16_to_cpu(amsdu->byte_count);
+
+	if (unlikely(len + sizeof(*amsdu) + sizeof(__le32) > pkt_len)) {
+		IWL_DEBUG_DROP(priv, "FW lied about packet len\n");
+		return;
+	}
+
 	rx_pkt_status = *(__le32 *)(pkt->data + sizeof(*amsdu) + len);
 	ampdu_status = iwlagn_translate_rx_status(priv,
 						  le32_to_cpu(rx_pkt_status));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 2ffe92d79148..af3151553569 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -349,7 +349,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_mpdu_res_start *rx_res;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
-	u32 len;
+	u32 len, pkt_len = iwl_rx_packet_payload_len(pkt);
 	u32 rate_n_flags;
 	u32 rx_pkt_status;
 	u8 crypt_len = 0;
@@ -358,6 +358,12 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rx_res = (struct iwl_rx_mpdu_res_start *)pkt->data;
 	hdr = (struct ieee80211_hdr *)(pkt->data + sizeof(*rx_res));
 	len = le16_to_cpu(rx_res->byte_count);
+
+	if (unlikely(len + sizeof(*rx_res) + sizeof(__le32) > pkt_len)) {
+		IWL_DEBUG_DROP(mvm, "FW lied about packet len\n");
+		return;
+	}
+
 	rx_pkt_status = get_unaligned_le32((__le32 *)
 		(pkt->data + sizeof(*rx_res) + len));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 22bd3a84aaac..1d51ec95ec21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1607,6 +1607,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
 	struct ieee80211_hdr *hdr;
 	u32 len = le16_to_cpu(desc->mpdu_len);
+	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	u32 rate_n_flags, gp2_on_air_rise;
 	u16 phy_info = le16_to_cpu(desc->phy_info);
 	struct ieee80211_sta *sta = NULL;
@@ -1653,6 +1654,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			le32_get_bits(phy_data.d1,
 				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
 
+	if (len + desc_size > pkt_len) {
+		IWL_DEBUG_DROP(mvm, "FW lied about packet len\n");
+		return;
+	}
+
 	hdr = (void *)(pkt->data + desc_size);
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
-- 
2.29.2

