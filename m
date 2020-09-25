Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A75279396
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgIYVbN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52384 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbgIYVbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ3-002J1P-Lu; Sat, 26 Sep 2020 00:31:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:50 +0300
Message-Id: <iwlwifi.20200926002540.869e829c815d.I70f374865b0acafc675a8d7959912eeaeb595acf@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/15] iwlwifi: mvm: use CHECKSUM_COMPLETE
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On newer hardware, we have the full checksum, so use it to report
CHECKSUM_COMPLETE and avoid the protocol specific hardware parsing.

Note that the hardware already parses/removes the SNAP header, so
we actually literally get what we need to report to the stack, as
we're expected to checksum everything after the L2 header (which
is translated/added by mac80211).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 73 ++++++++++++++-----
 2 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index b8b36a4f9eb9..05923e39b600 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -560,7 +560,11 @@ struct iwl_rx_mpdu_desc_v3 {
 	/**
 	 * @raw_xsum: raw xsum value
 	 */
-	__le32 raw_xsum;
+	__be16 raw_xsum;
+	/**
+	 * @reserved_xsum: reserved high bits in the raw checksum
+	 */
+	__le16 reserved_xsum;
 	/* DW11 */
 	/**
 	 * @rate_n_flags: RX rate/flags encoding
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c15f7dbc9516..5cade5946cc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -221,6 +221,31 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	skb_put_data(skb, hdr, hdrlen);
 	skb_put_data(skb, (u8 *)hdr + hdrlen + pad_len, headlen - hdrlen);
 
+	/*
+	 * If we did CHECKSUM_COMPLETE, the hardware only does it right for
+	 * certain cases and starts the checksum after the SNAP. Check if
+	 * this is the case - it's easier to just bail out to CHECKSUM_NONE
+	 * in the cases the hardware didn't handle, since it's rare to see
+	 * such packets, even though the hardware did calculate the checksum
+	 * in this case, just starting after the MAC header instead.
+	 */
+	if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		struct {
+			u8 hdr[6];
+			__be16 type;
+		} __packed *shdr = (void *)((u8 *)hdr + hdrlen + pad_len);
+
+		if (unlikely(headlen - hdrlen < sizeof(*shdr) ||
+			     !ether_addr_equal(shdr->hdr, rfc1042_header) ||
+			     (shdr->type != htons(ETH_P_IP) &&
+			      shdr->type != htons(ETH_P_ARP) &&
+			      shdr->type != htons(ETH_P_IPV6) &&
+			      shdr->type != htons(ETH_P_8021Q) &&
+			      shdr->type != htons(ETH_P_PAE) &&
+			      shdr->type != htons(ETH_P_TDLS))))
+			skb->ip_summed = CHECKSUM_NONE;
+	}
+
 	fraglen = len - headlen;
 
 	if (fraglen) {
@@ -393,22 +418,36 @@ static int iwl_mvm_rx_crypto(struct iwl_mvm *mvm, struct ieee80211_hdr *hdr,
 	return 0;
 }
 
-static void iwl_mvm_rx_csum(struct ieee80211_sta *sta,
+static void iwl_mvm_rx_csum(struct iwl_mvm *mvm,
+			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb,
-			    struct iwl_rx_mpdu_desc *desc)
+			    struct iwl_rx_packet *pkt)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
-	u16 flags = le16_to_cpu(desc->l3l4_flags);
-	u8 l3_prot = (u8)((flags & IWL_RX_L3L4_L3_PROTO_MASK) >>
-			  IWL_RX_L3_PROTO_POS);
-
-	if (mvmvif->features & NETIF_F_RXCSUM &&
-	    flags & IWL_RX_L3L4_TCP_UDP_CSUM_OK &&
-	    (flags & IWL_RX_L3L4_IP_HDR_CSUM_OK ||
-	     l3_prot == IWL_RX_L3_TYPE_IPV6 ||
-	     l3_prot == IWL_RX_L3_TYPE_IPV6_FRAG))
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	struct iwl_rx_mpdu_desc *desc = (void *)pkt->data;
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		if (pkt->len_n_flags & cpu_to_le32(FH_RSCSR_RPA_EN)) {
+			u16 hwsum = be16_to_cpu(desc->v3.raw_xsum);
+
+			skb->ip_summed = CHECKSUM_COMPLETE;
+			skb->csum = csum_unfold(~(__force __sum16)hwsum);
+		}
+	} else {
+		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+		struct iwl_mvm_vif *mvmvif;
+		u16 flags = le16_to_cpu(desc->l3l4_flags);
+		u8 l3_prot = (u8)((flags & IWL_RX_L3L4_L3_PROTO_MASK) >>
+				  IWL_RX_L3_PROTO_POS);
+
+		mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
+
+		if (mvmvif->features & NETIF_F_RXCSUM &&
+		    flags & IWL_RX_L3L4_TCP_UDP_CSUM_OK &&
+		    (flags & IWL_RX_L3L4_IP_HDR_CSUM_OK ||
+		     l3_prot == IWL_RX_L3_TYPE_IPV6 ||
+		     l3_prot == IWL_RX_L3_TYPE_IPV6_FRAG))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
 }
 
 /*
@@ -1796,7 +1835,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		}
 
 		if (ieee80211_is_data(hdr->frame_control))
-			iwl_mvm_rx_csum(sta, skb, desc);
+			iwl_mvm_rx_csum(mvm, sta, skb, pkt);
 
 		if (iwl_mvm_is_dup(sta, queue, rx_status, hdr, desc)) {
 			kfree_skb(skb);
-- 
2.28.0

