Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99084C2D62
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiBXNjj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 08:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiBXNji (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 08:39:38 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5E25F36C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 05:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VMyIEEoc90IkE826BBN4FO4r3y31Hr4F0V0mhxWbplk=; b=Tyg3KRN8nTTmsS9uW7dksxGukl
        rRVRO5gWTngYsgdNGDlis4G0AWSUhyBt/0hD1lZqUpdEqDJBKUtFBuhACygv2+CzsTDei01ZhdzzE
        s7u3QP+iY4vZCznICD13D3d9ZdY/vl5raPhG3ZGmKU/tGWgGkw7netbdxpl162WFp+Ho=;
Received: from p200300daa7204f00019652c85c04bce2.dip0.t-ipconnect.de ([2003:da:a720:4f00:196:52c8:5c04:bce2] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nNEKo-00036C-UR
        for linux-wireless@vger.kernel.org; Thu, 24 Feb 2022 14:39:07 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: fix dfs state issue with 160 MHz channels
Date:   Thu, 24 Feb 2022 14:39:05 +0100
Message-Id: <20220224133905.49774-1-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

When operating on a mix of DFS and non-DFS channels, the driver only checks
the CAC status of the control channel. This causes beacons/tx to fail if the
control channel is on a non-DFS channel.
Fix this by calling cfg80211_reg_can_beacon to determine the DFS status of
all affected channels

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 8 +++++---
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9796419c99e1..372b94a665ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1658,7 +1658,7 @@ enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 		return MT_DFS_STATE_DISABLED;
 	}
 
-	if (phy->chandef.chan->dfs_state != NL80211_DFS_AVAILABLE)
+	if (!cfg80211_reg_can_beacon(hw->wiphy, &phy->chandef, NL80211_IFTYPE_AP))
 		return MT_DFS_STATE_CAC;
 
 	return MT_DFS_STATE_ACTIVE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 120760ea1c89..e98c6076a633 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2151,10 +2151,12 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
 
-	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
-	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
 		req.switch_reason = CH_SWITCH_DFS;
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8c014299daa1..119f9358162f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2811,10 +2811,12 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	}
 #endif
 
-	if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
-	else if (phy->mt76->hw->conf.radar_enabled &&
-		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
 		req.switch_reason = CH_SWITCH_DFS;
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 33a836825cca..e7adcba7a8bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -863,10 +863,12 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
 	else
 		req.channel_band = chandef->chan->band;
 
-	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	if (cmd == MCU_EXT_CMD(SET_RX_PATH))
+		req.switch_reason = CH_SWITCH_NORMAL;
+	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
-	else if ((chandef->chan->flags & IEEE80211_CHAN_RADAR) &&
-		 chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
+	else if (!cfg80211_reg_can_beacon(dev->mt76.hw->wiphy, chandef,
+					  NL80211_IFTYPE_AP))
 		req.switch_reason = CH_SWITCH_DFS;
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
-- 
2.32.0 (Apple Git-132)

