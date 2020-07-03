Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D598B213614
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgGCIQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 04:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgGCIQc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:32 -0400
Received: from lore-desk.lan (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC19206A1;
        Fri,  3 Jul 2020 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593764191;
        bh=i/P2xdEkqGxE9To+bO0Ue/nBR35UyDkm4uABqmr0tOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkQAxXmYHbhBlWQeiA9XJkJJJo8aLrQkjs2FJpg6KarY/Sdb4P6z1hww1nvHX9HJj
         7Fchk2n+Vc918QU46tzsIkRm1NX+x0e0soJ36imCI0WGWvNY6h9apUOuy1TkktiB53
         R87scwShr4VIvFmnvCocARLpUeTOMJ3WPyfUpA5c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 06/22] mt76: mt7615: wake device before configuring hw keys
Date:   Fri,  3 Jul 2020 10:15:45 +0200
Message-Id: <ebb32b3fc8eb1a36a65d3d56bb16c5ae377ea35a.1593763584.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593763584.git.lorenzo@kernel.org>
References: <cover.1593763584.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure the device is in full-power before uploading keys to the hw

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 5f2c50a2449b..3c230479b36c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -336,7 +336,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
-	int idx = key->keyidx;
+	int idx = key->keyidx, err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -366,6 +366,8 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
+	mt7615_mutex_acquire(dev);
+
 	if (cmd == SET_KEY) {
 		key->hw_key_idx = wcid->idx;
 		wcid->hw_key_idx = idx;
@@ -376,9 +378,13 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    cmd == SET_KEY ? key : NULL);
 
 	if (mt76_is_usb(&dev->mt76))
-		return mt7615_queue_key_update(dev, cmd, msta, key);
+		err = mt7615_queue_key_update(dev, cmd, msta, key);
+	else
+		err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 
-	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+	mt7615_mutex_release(dev);
+
+	return err;
 }
 
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
-- 
2.26.2

