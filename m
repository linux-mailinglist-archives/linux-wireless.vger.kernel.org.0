Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAA7A9EBC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjIUULf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjIUULX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:23 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED687B94D
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H4oZQOsqSRYHINWYGOgZgDL1uvm2SVUKaVUh+Us9cMU=; b=d3Evum5Fjr6rK2gO+byn1WhNLt
        GhItIUEOcniUyYs2hq3zzaMpOVtNRMAffq2u/zuvTBq5klCPjiRxmSqPd3xuJ5HYrlBbW0X5naAO9
        /ytGoiRBoCZ/mJogZuXpbUH5QW5XET+d1IpHoY/y98PllU8NM9lyX00ujWUJi5yDWvk8=;
Received: from p54ae986d.dip0.t-ipconnect.de ([84.174.152.109] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qjEbm-005Auc-DH
        for linux-wireless@vger.kernel.org; Thu, 21 Sep 2023 10:00:22 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915 add tc offloading support
Date:   Thu, 21 Sep 2023 10:00:21 +0200
Message-ID: <20230921080021.18016-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is used for offloading flows from WLAN to Ethernet, or from WLAN to WLAN

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f4d77eba7191..81478289f17e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -344,6 +344,9 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM;
 
+	if (mtk_wed_device_active(&mdev->mmio.wed))
+		hw->netdev_features |= NETIF_F_HW_TC;
+
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d527ab28d4ef..a3fd54cc1911 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1653,6 +1653,20 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 
 	return 0;
 }
+
+static int
+mt7915_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    struct net_device *netdev, enum tc_setup_type type,
+		    void *type_data)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+
+	if (!mtk_wed_device_active(wed))
+		return -EOPNOTSUPP;
+
+	return mtk_wed_device_setup_tc(wed, netdev, type, type_data);
+}
 #endif
 
 const struct ieee80211_ops mt7915_ops = {
@@ -1707,5 +1721,6 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_radar_background = mt7915_set_radar_background,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7915_net_fill_forward_path,
+	.net_setup_tc = mt7915_net_setup_tc,
 #endif
 };
-- 
2.41.0

