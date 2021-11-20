Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400DA458012
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Nov 2021 19:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhKTTAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Nov 2021 14:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKTTAc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Nov 2021 14:00:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ABEF6052B;
        Sat, 20 Nov 2021 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637434648;
        bh=aSBVSYoVT+zL9QbFBmp/iQL58faUeQCFhUMOdgT/tjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lW0O7hR3EQ7EUEauk6zCxwE077JN6uBobxiJdNTpx2tP0qpITadc13ynAKxX5Cjap
         dL4Yats09xRrKD6yv9BAXNSVCWj13+zmO6P6nZN+dDh7HjRB7BGltgUe6ShYqwk0gn
         68R5bAJXKioI4AGw7vrv3VJ4EPyPVt09qpBGOk/zU7yGtJrozLt+YIeoMvgw5C7D7f
         7H/cP3IXgvKFho2ySYuiFvEfGqUm6FhFOhEQGcdBmQIpJGFunD+LXACIr2ZIIHWfsD
         zfm80oOuxAItPRbhh4IbvbzKaUjOk2WBZkATUM9uf0bMPhrplNZD03bGfaN90R3yQH
         aEOd/bcdo2mTg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: honor mt76_connac_mcu_set_rate_txpower return value in mt7921_config
Date:   Sat, 20 Nov 2021 19:57:17 +0100
Message-Id: <94a8016bd53be9ee8504006b3f83c1abdef04c46.1637434570.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check return code from mt76_connac_mcu_set_rate_txpower() in mt7921_config
routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index b144f5491798..14261f845c58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -456,7 +456,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
-	int ret;
+	int ret = 0;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
@@ -468,8 +468,11 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 
 	mt7921_mutex_acquire(dev);
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER)
-		mt76_connac_mcu_set_rate_txpower(phy->mt76);
+	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+		ret = mt76_connac_mcu_set_rate_txpower(phy->mt76);
+		if (ret)
+			goto out;
+	}
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
@@ -484,9 +487,10 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_wr(dev, MT_WF_RFCR(0), phy->rxfilter);
 	}
 
+out:
 	mt7921_mutex_release(dev);
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.31.1

