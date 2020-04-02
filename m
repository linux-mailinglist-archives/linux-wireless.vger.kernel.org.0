Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA619C8B0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgDBSTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBST3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:29 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F0A208E0;
        Thu,  2 Apr 2020 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851569;
        bh=pmfYUUcWhoVuBYlaL4fzrcHsW621cGa3FctPrnhrs20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkVd/cfonmTduLZ1Nu9UVAAmDXkWrsq+wEmBeUDYzs/KLN0LDhoMzXhvVaXevt3qo
         NNCx3UWvl1tRNKI7L3EjzikTgFk6G9bCdkoNkF+scnNuQKCcRw+5ls6llVOJMevpbR
         XvuV9sQpxqOEMkPERiVGbL/BtBUOviCk0D5Ms43g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 9/9] mt76: mt7615: add address parameter to mt7615_eeprom_init
Date:   Thu,  2 Apr 2020 20:18:56 +0200
Message-Id: <e7a70c983ab4a8a9c7852786448dfd19e192f716.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce address parameter to mt7615_eeprom_init routine in order to be
reused adding usb support to mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index dfa9a08b896d..23ed20553de2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -40,11 +40,11 @@ static int mt7615_efuse_read(struct mt7615_dev *dev, u32 base,
 	return 0;
 }
 
-static int mt7615_efuse_init(struct mt7615_dev *dev)
+static int mt7615_efuse_init(struct mt7615_dev *dev, u32 base)
 {
-	u32 val, base = mt7615_reg_map(dev, MT_EFUSE_BASE);
 	int i, len = MT7615_EEPROM_SIZE;
 	void *buf;
+	u32 val;
 
 	val = mt76_rr(dev, base + MT_EFUSE_BASE_CTRL);
 	if (val & MT_EFUSE_BASE_CTRL_EMPTY)
@@ -67,7 +67,7 @@ static int mt7615_efuse_init(struct mt7615_dev *dev)
 	return 0;
 }
 
-static int mt7615_eeprom_load(struct mt7615_dev *dev)
+static int mt7615_eeprom_load(struct mt7615_dev *dev, u32 addr)
 {
 	int ret;
 
@@ -75,7 +75,7 @@ static int mt7615_eeprom_load(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	return mt7615_efuse_init(dev);
+	return mt7615_efuse_init(dev, addr);
 }
 
 static int mt7615_check_eeprom(struct mt76_dev *dev)
@@ -265,11 +265,11 @@ static void mt7615_cal_free_data(struct mt7615_dev *dev)
 	}
 }
 
-int mt7615_eeprom_init(struct mt7615_dev *dev)
+int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 {
 	int ret;
 
-	ret = mt7615_eeprom_load(dev);
+	ret = mt7615_eeprom_load(dev, addr);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index be0f3a77e22f..6acaaf2732df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -146,6 +146,7 @@ static void mt7615_init_work(struct work_struct *work)
 
 static int mt7615_init_hardware(struct mt7615_dev *dev)
 {
+	u32 addr = mt7615_reg_map(dev, MT_EFUSE_BASE);
 	int ret, idx;
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
@@ -154,7 +155,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
-	ret = mt7615_eeprom_init(dev);
+	ret = mt7615_eeprom_init(dev, addr);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index bd5967f5b4b7..a6e5814b5941 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -358,7 +358,7 @@ int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
 int mt7615_register_ext_phy(struct mt7615_dev *dev);
 void mt7615_unregister_ext_phy(struct mt7615_dev *dev);
-int mt7615_eeprom_init(struct mt7615_dev *dev);
+int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr);
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
 				  struct ieee80211_channel *chan,
 				  u8 chain_idx);
-- 
2.25.1

