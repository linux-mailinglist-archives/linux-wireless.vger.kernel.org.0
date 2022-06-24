Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FDF55A17A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiFXTNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jun 2022 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiFXTNG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jun 2022 15:13:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F182B7CD
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jun 2022 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zMZakQ7QZ8dM9Zo84u+FfjfAPencMcY9TB+qQHsTPNI=; b=KZdrGy104Sik6sJWo6MUXta82G
        EHrLEm+6oKqJsVO+S/lPRp9Xhogy1+A30Jk8KtgNnGMlKDfC+iln5Q60Mm9QFUR6LIHo+sQTeJV5S
        TZU/twfKq5pU0v5GBFkOQQr5ySJZ5RHADiJAATQC+NE2wbRQoHkOAeI+ixguEk95gAzw=;
Received: from p200300daa71a4800391046fbc91acf5a.dip0.t-ipconnect.de ([2003:da:a71a:4800:3910:46fb:c91a:cf5a] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o4ojn-0002r8-30
        for linux-wireless@vger.kernel.org; Fri, 24 Jun 2022 21:13:03 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7615: fix throughput regression on DFS channels
Date:   Fri, 24 Jun 2022 21:13:00 +0200
Message-Id: <20220624191300.52766-4-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624191300.52766-1-nbd@nbd.name>
References: <20220624191300.52766-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some reason, mt7615 reacts badly to repeatedly enabling/disabling the radar
detector without also switching the channel.
This results in very bad throughput on DFS channels, because
hw->conf.radar_enabled can get toggled a few times after CAC ends.
Fix this by always leaving the DFS detector enabled on DFS channels and instead
suppress unwanted detection events.

Fixes: 2c86f6752046 ("mt76: mt7615: fix/rewrite the dfs state handling logic")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  7 ++++---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 -------------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  3 +++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 -
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d9dd3d404986..038774b3ced0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2231,6 +2231,7 @@ mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
 
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 {
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	enum mt76_dfs_state dfs_state, prev_state;
@@ -2241,13 +2242,13 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 
 	prev_state = phy->mt76->dfs_state;
 	dfs_state = mt76_phy_dfs_state(phy->mt76);
+	if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
+	    dfs_state < MT_DFS_STATE_CAC)
+		dfs_state = MT_DFS_STATE_ACTIVE;
 
 	if (prev_state == dfs_state)
 		return 0;
 
-	if (prev_state == MT_DFS_STATE_UNKNOWN)
-		mt7615_dfs_stop_radar_detector(phy);
-
 	if (dfs_state == MT_DFS_STATE_DISABLED)
 		goto stop;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 277c22a4d049..28bc76c8e8e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -282,26 +282,6 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
 }
 
-static void mt7615_init_dfs_state(struct mt7615_phy *phy)
-{
-	struct mt76_phy *mphy = phy->mt76;
-	struct ieee80211_hw *hw = mphy->hw;
-	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
-
-	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
-		return;
-
-	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-	    !(mphy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
-		return;
-
-	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
-	    mphy->chandef.width == chandef->width)
-		return;
-
-	phy->dfs_state = -1;
-}
-
 int mt7615_set_channel(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
@@ -314,7 +294,6 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 
 	set_bit(MT76_RESET, &phy->mt76->state);
 
-	mt7615_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
 	if (is_mt7615(&dev->mt76) && dev->flash_eeprom) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 989b2a41b670..3d35381013f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -391,6 +391,9 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (r->band_idx && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
+	if (mt76_phy_dfs_state(mphy) < MT_DFS_STATE_CAC)
+		return;
+
 	ieee80211_radar_detected(mphy->hw);
 	dev->hw_pattern++;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 8499cdc4bb0d..93a9e8f46193 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -178,7 +178,6 @@ struct mt7615_phy {
 
 	u8 chfreq;
 	u8 rdd_state;
-	int dfs_state;
 
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
-- 
2.36.1

