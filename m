Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505BB220D46
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgGOMqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 08:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgGOMqw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 08:46:52 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D7D20578;
        Wed, 15 Jul 2020 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594817211;
        bh=LUQQhBBASoPZElhUy4axpOH/WkASNyRO6lpmJu3TVp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VI56JxnZNOiGDaX489hQtK8c2CJh2yuxy2RPc9v3+GENBvjOAu8v3cCNEYBAlODSE
         HWz2LB8RL7Vz4pzm44ZVgnxNVqJCNVePZU9xSMyVs7g8Ns7rY7Ux6J4Oz0ylZ5ytrQ
         HwUFnfsQD1D5SkRorCRkefKFkc1h019E3K0X66lc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/6] mt76: mt7615: sdio code must access rate/key regs in preocess context
Date:   Wed, 15 Jul 2020 14:46:28 +0200
Message-Id: <1d237c95444232a13e90f315048480242699424c.1594815602.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594815602.git.lorenzo@kernel.org>
References: <cover.1594815602.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As usb, sdio relies on mt76 workqueue to configure tx rate or upload
keys to the hw. This is a preliminary patch to add SDIO support to
mt76 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index afac8d81d317..3dd8dd28690e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -967,7 +967,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	struct mt7615_rate_desc rd;
 	u32 w5, w27, addr;
 
-	if (mt76_is_usb(&dev->mt76)) {
+	if (!mt76_is_mmio(&dev->mt76)) {
 		mt7615_mac_queue_rate_update(phy, sta, probe_rate, rates);
 		return;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 79453c890f20..2d0b1f49fdbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -417,10 +417,10 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	if (mt76_is_usb(&dev->mt76))
-		err = mt7615_queue_key_update(dev, cmd, msta, key);
-	else
+	if (mt76_is_mmio(&dev->mt76))
 		err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+	else
+		err = mt7615_queue_key_update(dev, cmd, msta, key);
 
 	mt7615_mutex_release(dev);
 
-- 
2.26.2

