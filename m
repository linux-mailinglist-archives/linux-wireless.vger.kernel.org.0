Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8135F2E40
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJCJie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJCJiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 05:38:15 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299AF56038
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bA1v0cTDoF3d5WltXt0DkzPsu+s70zuhiTzNZVu9q0s=; b=Po8hGjuuyA/NZgve65p6Vw06ZW
        GLCN5BQ2Y/Mp34e+Q7pQ1UZjCGqwXoHEI8zsa8riODtohg6bAzd8N/56fYxGkdD7KkaDxKC+fbs5n
        PLignCY6gNiQr1c7S+1WBm5bgpKoHhkm49mb4M7GuBVHOWRhYpySbFqNzz3NkIs0OuZI=;
Received: from p200300daa7301d00d4086823c46c59c0.dip0.t-ipconnect.de ([2003:da:a730:1d00:d408:6823:c46c:59c0] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ofHnz-009qu9-Bz
        for linux-wireless@vger.kernel.org; Mon, 03 Oct 2022 11:32:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] wifi: mt76: add tx checksum offload for mt7915 and mt7921
Date:   Mon,  3 Oct 2022 11:32:05 +0200
Message-Id: <20221003093206.86323-3-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221003093206.86323-1-nbd@nbd.name>
References: <20221003093206.86323-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Supports IPv4 and IPv6 TCP + UDP

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 8b7ec64abc95..562d01ec65c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -337,6 +337,9 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 		wmm = sta->wme;
 	}
 
+	val = FIELD_PREP(MT_TXD0_ETH_TYPE_OFFSET, 10);
+	txwi[0] |= cpu_to_le32(val);
+
 	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
 	      FIELD_PREP(MT_TXD1_TID, tid);
 
@@ -356,6 +359,8 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 
 	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		val |= MT_TXD7_IP_SUM | MT_TXD7_UDP_TCP_SUM;
 
 	txwi[7] |= cpu_to_le32(val);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 324db5291c85..d3011965451d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -329,7 +329,8 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->netdev_features = NETIF_F_RXCSUM;
+	hw->netdev_features = NETIF_F_RXCSUM |
+			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index dcdb3cf04ac1..b607f0a51c68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -55,7 +55,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->netdev_features = NETIF_F_RXCSUM;
+	hw->netdev_features = NETIF_F_RXCSUM |
+			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
-- 
2.36.1

