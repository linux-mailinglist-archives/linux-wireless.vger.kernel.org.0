Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20F78101
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2019 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfG1TDg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jul 2019 15:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfG1TDg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jul 2019 15:03:36 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BFA2075C;
        Sun, 28 Jul 2019 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564340615;
        bh=AW6EFXQRY6fWpKO0SVFpFyi035a3N4g9CuRCBGyzGqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hY+jzDR9RefAdN50oElNmM318DmEqYb9rG79DmUXcRe7Pn7nNbol0q5RHU3pQ1XHu
         gji12x8TMNvA9P81VYuF9TG9GyB+20iU4GW21d2wqjIcAIpnANWOG3mbFai0FIyf5a
         /xg0Yhsqwr7ZLhZYdLzqwOy5iH7Kday5U78lj8qM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 1/2] mt76: mt7615: rework locking scheme for mt7615_set_channel
Date:   Sun, 28 Jul 2019 21:03:17 +0200
Message-Id: <42bc4988d7233568c0b9a9e90eef3683a72b7ab8.1564340063.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564340063.git.lorenzo@kernel.org>
References: <cover.1564340063.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7603 driver, move mt76.mutex lock inside
mt7615_set_channel since we need to grab mt76.mutex in mt7615_mac_work.
This is a preliminary patch to add Smart Carrier Sense (SCS) support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 900253e85db9..9138153f4686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -135,6 +135,8 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	int ret;
 
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
 	mt7615_dfs_check_channel(dev);
@@ -143,18 +145,18 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 
 	ret = mt7615_mcu_set_channel(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = mt7615_dfs_init_radar_detector(dev);
-	if (ret < 0)
-		return ret;
 
+out:
 	clear_bit(MT76_RESET, &dev->mt76.state);
+	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_txq_schedule_all(&dev->mt76);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
-	return 0;
+	return ret;
 }
 
 static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
@@ -213,14 +215,14 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 	struct mt7615_dev *dev = hw->priv;
 	int ret = 0;
 
-	mutex_lock(&dev->mt76.mutex);
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
 		ret = mt7615_set_channel(dev);
 		ieee80211_wake_queues(hw);
 	}
 
+	mutex_lock(&dev->mt76.mutex);
+
 	if (changed & IEEE80211_CONF_CHANGE_POWER)
 		ret = mt7615_mcu_set_tx_power(dev);
 
-- 
2.21.0

