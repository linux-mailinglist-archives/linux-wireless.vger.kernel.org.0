Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B702D450C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbgLIPGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35484 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730267AbgLIPGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:07 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11s-003Dg4-3e; Wed, 09 Dec 2020 17:05:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:09 +0200
Message-Id: <iwlwifi.20201209170243.23e372ce9b7a.I7bfd6809f8f5feb75f79397646e6656e95688a0e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] iwlwifi: tighten RX MPDU bounds checks
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Previously, we added checks that the contained MPDU size is long
enough, but really we should also check that the notification
itself fits into the data. Add some checks for that.

Also add unlikely() annotations on the previously added checks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |  6 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  5 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 32 +++++++++++++------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index d06278558b33..ecbf8d3cddae 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -794,6 +794,12 @@ static void iwlagn_rx_reply_rx(struct iwl_priv *priv,
 		IWL_ERR(priv, "MPDU frame without cached PHY data\n");
 		return;
 	}
+
+	if (unlikely(pkt_len < sizeof(*amsdu))) {
+		IWL_DEBUG_DROP(priv, "Bad REPLY_RX_MPDU_CMD size\n");
+		return;
+	}
+
 	phy_res = &priv->last_phy_res;
 	amsdu = (struct iwl_rx_mpdu_res_start *)pkt->data;
 	header = (struct ieee80211_hdr *)(pkt->data + sizeof(*amsdu));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 0d2f7b069a52..79d1778e6bc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -298,6 +298,11 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	u32 rx_pkt_status;
 	u8 crypt_len = 0;
 
+	if (unlikely(pkt_len < sizeof(*rx_res))) {
+		IWL_DEBUG_DROP(mvm, "Bad REPLY_RX_MPDU_CMD size\n");
+		return;
+	}
+
 	phy_info = &mvm->last_phy_info;
 	rx_res = (struct iwl_rx_mpdu_res_start *)pkt->data;
 	hdr = (struct ieee80211_hdr *)(pkt->data + sizeof(*rx_res));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e4f73b6cd94c..8d33739c29ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1574,16 +1574,15 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
 	struct ieee80211_hdr *hdr;
-	u32 len = le16_to_cpu(desc->mpdu_len);
+	u32 len;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	u32 rate_n_flags, gp2_on_air_rise;
-	u16 phy_info = le16_to_cpu(desc->phy_info);
+	u16 phy_info;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
 	u8 crypt_len = 0, channel, energy_a, energy_b;
 	size_t desc_size;
 	struct iwl_mvm_rx_phy_data phy_data = {
-		.d4 = desc->phy_data4,
 		.info_type = IWL_RX_PHY_INFO_TYPE_NONE,
 	};
 	bool csi = false;
@@ -1591,13 +1590,22 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		desc_size = sizeof(*desc);
+	else
+		desc_size = IWL_RX_DESC_SIZE_V1;
+
+	if (unlikely(pkt_len < desc_size)) {
+		IWL_DEBUG_DROP(mvm, "Bad REPLY_RX_MPDU_CMD size\n");
+		return;
+	}
+
 	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 		channel = desc->v3.channel;
 		gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
 		energy_a = desc->v3.energy_a;
 		energy_b = desc->v3.energy_b;
-		desc_size = sizeof(*desc);
 
 		phy_data.d0 = desc->v3.phy_data0;
 		phy_data.d1 = desc->v3.phy_data1;
@@ -1609,7 +1617,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		gp2_on_air_rise = le32_to_cpu(desc->v1.gp2_on_air_rise);
 		energy_a = desc->v1.energy_a;
 		energy_b = desc->v1.energy_b;
-		desc_size = IWL_RX_DESC_SIZE_V1;
 
 		phy_data.d0 = desc->v1.phy_data0;
 		phy_data.d1 = desc->v1.phy_data1;
@@ -1617,16 +1624,21 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.d3 = desc->v1.phy_data3;
 	}
 
-	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
-		phy_data.info_type =
-			le32_get_bits(phy_data.d1,
-				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
+	len = le16_to_cpu(desc->mpdu_len);
 
-	if (len + desc_size > pkt_len) {
+	if (unlikely(len + desc_size > pkt_len)) {
 		IWL_DEBUG_DROP(mvm, "FW lied about packet len\n");
 		return;
 	}
 
+	phy_info = le16_to_cpu(desc->phy_info);
+	phy_data.d4 = desc->phy_data4;
+
+	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
+		phy_data.info_type =
+			le32_get_bits(phy_data.d1,
+				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
+
 	hdr = (void *)(pkt->data + desc_size);
 	/* Dont use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
-- 
2.29.2

