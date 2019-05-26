Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29012AA33
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2019 16:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfEZOFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 May 2019 10:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEZOFj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 May 2019 10:05:39 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8579420863;
        Sun, 26 May 2019 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558879538;
        bh=WdhM3MZo2iIxOsg9rZ19IvSHSmhtIkZxZnwbm+UnTj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssKqD1K6FaEIjpPv+gXo6TSMeTOBfj3bbD5TcdMz/Obbz6v2DZQ9sKKzV7LPwbc5p
         9Z5QmRa+sAIh+xV4R+NeZND+A32+cV9mc4IcfKYE4zrQ52Nps98iZzTABfPYGhJ0E8
         phu9WAyQVzGNuBf8liyGtxQWE60cm1NqsHgz8XtY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 4/4] mt76: mt7615: rearrange locking in mt7615_config
Date:   Sun, 26 May 2019 16:05:13 +0200
Message-Id: <aa106a4711bd96351e9cb397a658c75171ee14c7.1558879234.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558879234.git.lorenzo@kernel.org>
References: <cover.1558879234.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since all the routines in mt7615_config grub mt76.mutex moves
mutex_lock/mutex_unlock at the beginning/end of mt7615_config

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index cedc4c25f34d..c8411750f62b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -191,31 +191,28 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	struct mt7615_dev *dev = hw->priv;
 	int ret = 0;
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		mutex_lock(&dev->mt76.mutex);
+	mutex_lock(&dev->mt76.mutex);
 
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
 		ret = mt7615_set_channel(dev, &hw->conf.chandef);
 		ieee80211_wake_queues(hw);
-
-		mutex_unlock(&dev->mt76.mutex);
 	}
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER)
 		ret = mt7615_mcu_set_tx_power(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		mutex_lock(&dev->mt76.mutex);
-
 		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
 			dev->mt76.rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 		else
 			dev->mt76.rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
 		mt76_wr(dev, MT_WF_RFCR, dev->mt76.rxfilter);
-
-		mutex_unlock(&dev->mt76.mutex);
 	}
+
+	mutex_unlock(&dev->mt76.mutex);
+
 	return ret;
 }
 
-- 
2.21.0

