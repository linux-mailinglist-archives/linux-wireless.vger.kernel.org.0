Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618A5F2E62
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJCJqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJCJpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 05:45:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7916D52446
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gsvEW9b4xM7C/0WZ9F58acduG6vrtTO9pEwJqtrYgH0=; b=t3dUFNs+ZP5kXm3/hzNc6rSPEE
        wltHNYoAi+szpRH3SWX5ZWoGn7QqQaFgEdLCFWfzrpbXcjziWBCVbYhSJcyfwI53Ft6U4MTgcfe2t
        eScXdeCxY0vdW6xXLcDkd22EFKTeVyFiaD5BfFuJLzK4hJcODfOd1Lxd2yaDjSYDjklk=;
Received: from p200300daa7301d00d4086823c46c59c0.dip0.t-ipconnect.de ([2003:da:a730:1d00:d408:6823:c46c:59c0] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ofHnz-009qu9-Hn
        for linux-wireless@vger.kernel.org; Mon, 03 Oct 2022 11:32:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] wifi: mt76: declare netdev support for scatter/gather on 7915e and 7921e
Date:   Mon,  3 Oct 2022 11:32:06 +0200
Message-Id: <20221003093206.86323-4-nbd@nbd.name>
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

This helps with locally generated TCP traffic to avoid unnecessary data
copying. Also bump the maximum number of fragments to the limit imposed
by the firmware txp struct.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index d3011965451d..ff49d3837b9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -330,7 +330,8 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM |
-			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			      NETIF_F_SG;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
@@ -368,7 +369,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 
-	hw->max_tx_fragments = 4;
+	hw->max_tx_fragments = 6;
 
 	if (phy->mt76->cap.has_2ghz) {
 		phy->mt76->sband_2g.sband.ht_cap.cap |=
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index b607f0a51c68..9543584abfb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -57,6 +57,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM |
 			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	if (mt76_is_mmio(&dev->mt76))
+		hw->netdev_features |= NETIF_F_SG;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
@@ -104,7 +106,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
-	hw->max_tx_fragments = 4;
+	hw->max_tx_fragments = 6;
 
 	return 0;
 }
-- 
2.36.1

