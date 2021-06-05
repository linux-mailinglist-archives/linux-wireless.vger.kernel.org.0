Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845A939C85D
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFENOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Jun 2021 09:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFENOl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Jun 2021 09:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E561613F8;
        Sat,  5 Jun 2021 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622898773;
        bh=lqVvZ7QbT0xSHk4kQ5yBhVXa9vjtWtfQhjdKUC3ZHMI=;
        h=From:To:Cc:Subject:Date:From;
        b=Doxjq5B7ES6Xyte3toVZeN+Qx/rXTQTM8RKjTeqczMulNbhLV/V1upBzjtG4U6kjR
         eojjEpFPI2euVzEZ4PeoYpnd0Uei1cYN0u6dXl5qhXOrnNndMygueRr8GP8KfzfHTT
         SExHDoKKaQPEsS6PxekvFVvDuONh4L2Ujuj+/mMdq8t110BSlJTHRtDig8fKg8IhbK
         7WBwDuEbLuQVgToqNSROhOErCylnqxsBoMhBkllQOrnkETLWxqleQNY3fWoh/EBol5
         BI2U/mgLEBnAVPvIWmlJyDf2dpYqoXUIrbmtMYVW3XbCCdxVTyfHbp/YwECHsT1u4l
         LHrW13O5Wtknw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        deren.wu@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: make mt7921_set_channel static
Date:   Sat,  5 Jun 2021 15:12:48 +0200
Message-Id: <42d6bd1e1c308b7a5bf83ea3c89cda3b0b70e755.1622898694.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make mt7921_set_channel routine static since it is only used in main.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 6b60eec85d0b..6c6cebe3ed34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -326,7 +326,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
 
-int mt7921_set_channel(struct mt7921_phy *phy)
+static int mt7921_set_channel(struct mt7921_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8aa8d2ecdffa..087067e7ea5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -261,7 +261,6 @@ int mt7921_mcu_init(struct mt7921_dev *dev);
 int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
-int mt7921_set_channel(struct mt7921_phy *phy);
 int mt7921_mcu_sta_add(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		       struct ieee80211_vif *vif, bool enable);
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
-- 
2.31.1

