Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D0521361F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGCIQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgGCIQo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:44 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CF720826;
        Fri,  3 Jul 2020 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764204;
        bh=d1bIE0kDegwbTo99G0gWtdE6n0x1lRNv7QhH5gOvehM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBq11pbV34mqXydikYbZK9yGN8nfWoXJyLotcFrhsnKLB3VoM85TfCaRCHR50ZQWg
         4beR82H9XA5MGh0RgCVJJ7c4sHuAmXC4w9j9KZn8WLWXvbomYDVx20IgqeUtJ2QHCF
         kRuDiaJV07D1scqt5dgAPFLolcj17Ln+OmSXR/qI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 13/22] mt76: mt7615: run mt7615_mcu_set_roc holding mt76 mutex
Date:   Fri,  3 Jul 2020 10:15:52 +0200
Message-Id: <e3eeaddf7c676810b3cb13ba9c1b6c6c8386b085.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure to run mt7615_mcu_set_roc() holding mt76 mutex in order to
wake the device from low power state and avoid races

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c52b5c68ba97..47dca270150d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -871,9 +871,11 @@ void mt7615_roc_work(struct work_struct *work)
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
+	mt7615_mutex_acquire(phy->dev);
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7615_roc_iter, phy);
+	mt7615_mutex_release(phy->dev);
 	ieee80211_remain_on_channel_expired(phy->mt76->hw);
 }
 
@@ -991,20 +993,24 @@ static int mt7615_remain_on_channel(struct ieee80211_hw *hw,
 	if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return 0;
 
+	mt7615_mutex_acquire(phy->dev);
+
 	err = mt7615_mcu_set_roc(phy, vif, chan, duration);
 	if (err < 0) {
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
-		return err;
+		goto out;
 	}
 
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, HZ)) {
 		mt7615_mcu_set_roc(phy, vif, NULL, 0);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
-
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
 	}
 
-	return 0;
+out:
+	mt7615_mutex_release(phy->dev);
+
+	return err;
 }
 
 static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
@@ -1018,7 +1024,9 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
+	mt7615_mutex_acquire(phy->dev);
 	mt7615_mcu_set_roc(phy, vif, NULL, 0);
+	mt7615_mutex_release(phy->dev);
 
 	return 0;
 }
-- 
2.26.2

