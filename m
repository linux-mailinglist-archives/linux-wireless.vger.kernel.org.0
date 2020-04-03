Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88119DE4E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 21:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDCTCJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 15:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgDCTCJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 15:02:09 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7467220719;
        Fri,  3 Apr 2020 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585940528;
        bh=TvmHYFBwtBBq6TsHZWr+61xJbkuRmX83vcGTmf6P+OI=;
        h=From:To:Cc:Subject:Date:From;
        b=Tt7i8AocTD6W6zhRMOMZPqPWFqb34TiR9Eq621HY8f23tU2YOZaPeMPDJnWBL2OeI
         QGIzx/6ej0Yz7zNuIrDEqCmZEo4GdRTYlaf+Q3wu0zAFpPtKUb2lf+7z5HzIdqe5+a
         KRsuqd0dHd/hN7kZoCPHLKra/7NN6rPe1XeqFgVk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com, blogic@openwrt.org
Subject: [PATCH] mt76: mt7615: do not always reset the dfs state setting the channel
Date:   Fri,  3 Apr 2020 21:01:56 +0200
Message-Id: <1e14db9a59cf91292b8a80cac2f8e6d757b87662.1585936644.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211/hostapd runs mt7615_set_channel with the same channel
parameters sending multiple rdd commands overwriting the previous ones.
This behaviour is causing tpt issues on dfs channels.
Fix the issue checking new channel freq/width with the running one.

Fixes: 5dabdf71e94e ("mt76: mt7615: add multiple wiphy support to the dfs support code")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c91f0896b09f..3e0d26183905 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -220,6 +220,25 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
+static void mt7615_init_dfs_state(struct mt7615_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_hw *hw = mphy->hw;
+	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
+
+	if (hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		return;
+
+	if (!(chandef->chan->flags & IEEE80211_CHAN_RADAR))
+		return;
+
+	if (mphy->chandef.chan->center_freq == chandef->chan->center_freq &&
+	    mphy->chandef.width == chandef->width)
+		return;
+
+	phy->dfs_state = -1;
+}
+
 static int mt7615_set_channel(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
@@ -231,7 +250,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
-	phy->dfs_state = -1;
+	mt7615_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
 	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
-- 
2.25.1

