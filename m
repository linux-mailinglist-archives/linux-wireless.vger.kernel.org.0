Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0425720BB70
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgFZVZo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZVZn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:25:43 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B2320B80;
        Fri, 26 Jun 2020 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206743;
        bh=pPcCbVgcEboVVAYAy++sxqhrZnM4Fe9FZuWUms+LUgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQP3kyCkAB2lMx3iSm2r/fynLQIO/I2M8DkFhv2miI8rI+zBSOd3NpiupR4m5yFMU
         Om/NvacGc6P0YdDeW4zYXP9KiDObky2liv+lP9Qn4l8bYiVBu+nHOD7ylV29wAl15W
         n4q3z9UOYOkGt9KkhmPrTzklHRTnItqb26sHkkWQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/17] mt76: mt7615: wake device before configuring hw keys
Date:   Fri, 26 Jun 2020 23:25:06 +0200
Message-Id: <0bc5bc1f94fa2bcaa0abc51a5bada9f921135471.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
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
index b63dc12a0342..8ac63ea7cbb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -339,7 +339,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
-	int idx = key->keyidx;
+	int idx = key->keyidx, err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -369,6 +369,8 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
+	mt7615_mutex_acquire(dev, &dev->mt76.mutex);
+
 	if (cmd == SET_KEY) {
 		key->hw_key_idx = wcid->idx;
 		wcid->hw_key_idx = idx;
@@ -379,9 +381,13 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			    cmd == SET_KEY ? key : NULL);
 
 	if (mt76_is_usb(&dev->mt76))
-		return mt7615_queue_key_update(dev, cmd, msta, key);
+		err = mt7615_queue_key_update(dev, cmd, msta, key);
+	else
+		err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 
-	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+	mt7615_mutex_release(dev, &dev->mt76.mutex);
+
+	return err;
 }
 
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
-- 
2.26.2

