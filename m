Return-Path: <linux-wireless+bounces-27248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75925B53E94
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281B53B23B9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BE27C172;
	Thu, 11 Sep 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhryYs0W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704B1B0F19
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628992; cv=none; b=gO475q8iGmUepY1iEPt+pyscV99EuMKzQGnxFJK6RSq9Gb/txZIOmrJyOuTEfkSxsTqXo6ostiP6jtQx3oGYZ2muh3d+yOlv8FVn3xIYnHhZV31EWXH4trnpEjjohxtuS/wouF/C+vxzjcIt0yR3v40FPrB+vk1qQt3g+eZbHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628992; c=relaxed/simple;
	bh=gWqm9P9jpT3NwGmuN6Rh8mrFEFpNo/PCFN0JPA3juxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MY5LSw5b4U9lZS4ifq7BiBVyMQq4wRnTAunlfIuioc05csYEKxu2pBrXXLSTrPup1jg8Y0GeDGp8XrSZi18lKsHeg5HTwgqIqDz9ImBHB4dmPL0vcRFaspfFD25Zn1KajRd0mY6uq8ZGMHhBKENNQswRCAs6nSvybsB2CSGq+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhryYs0W; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso1051605a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757628990; x=1758233790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJGbQvKOank3p6da5RP7YzMSzAjqQT4QAALgpjG02Ys=;
        b=DhryYs0WaycxmeIisKmsJQgSMdVoBXJTpsrV8CqwLWBIdVk6m4aekZIISMPJVgJZ1d
         leKU4fdOHpMfrOAEY0c7lC0Xa8XXIvTz69xZs0OLgRv7bn7FWZ0RsJ2F/EGf0ISG9tVY
         YQ2kyzF6CpDiqOuzOPhfJrrhMgu0zb562dsgDO2sHuFCGLuzAgPE7at+JkezFd3LKwsY
         N/5gAsQDNVfYPqqu7P7Bqk7BzLkKdRnNy+srOPX+pnMbQO7rP60syidOE7ayirhrvjM7
         xYijRbyxkGjoYQFdFCT9eaAHvqdZLmCbyG/rVJfDTQrw3KOKAHi0KWL4YBaVhM34ms1A
         SA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628990; x=1758233790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJGbQvKOank3p6da5RP7YzMSzAjqQT4QAALgpjG02Ys=;
        b=kF/OsDjKJub0+XnnvB1CJgQfowiIyaG6xeZZ22WeeC22W7U40uAj5drWi7Jh9IN9hQ
         UN0UqZgFqVMXse6/G1oO025AvQT9F8LbD2cwEefoXfkwJ0/X9uTJrTw1h0dXYCicz1KN
         VbYOD8uDVytUGDK//w4oA4yo4+Sp9COULU4lpunE1ICAOS+3Am/1abixhu/6xMuJXnBf
         BR5AMKf+Ecl4tJDZ7CL/BU+V9KBZzrI5yCxi/MGJCnALmZC2ehaxr5hqFqQ/23Hs/qQC
         rVdr48ZB+nwwlQBp+vUbO1RCSZt6HSgIyd7/aWEcVJGHQ79MetRczklLLs5C7YFGGur3
         aS/g==
X-Gm-Message-State: AOJu0Yw7o583d75+WM8pazpT3m8csJr6BwWbcZvCib28xvNX1q0Zynym
	i4YsyoYUiU/bJrpQJIyVJC3U82cXnCI763YP+ccWcrK+CbSSnpaZxya+OhRKQQ==
X-Gm-Gg: ASbGncvTRZuMQ3zRu7HCdHt6nH2BmK5fP3uYQ5m3AEpnl9XEiK2pX1tZD7jok2HricX
	+RsMes8Lc9k5xiaCs92QWh9KV8qoCzWTP8U6zw66KFoRXWhwi2Zh9ajPXVnCE1P6wwO9VYEzMaf
	wETw4aqJfw60+4WHMLntOHmfmQLmBmAu2tgJ2CKSvzAaD0zzkeVnCTTgCFQ9tPhHto77wqnU5Gv
	N8xYfGV6eLaAzXw2HewtWD68WmBI/GahntNE00WQ3292egLUAcxQNmX5Gb6sVzUbuJRf9JZmbTd
	Zfpm6PjOeYE9LdAwJpjYahJLpfwr+U5iSjmOs4X7mixpFp59WOANaaS27o4UmGVimkg0B2d4uLQ
	osx6/9DI0EOv5UR/5WsPkUpcSWusU/3jdk/eDJlBbDLNUwbGvtUdIYJoGb9qnZJgb3lSWkjQ=
X-Google-Smtp-Source: AGHT+IHiZ0i/fqjHfxLIg5y5A42HChRZzH9Wsg1ARyoCs3aMcn6FX+kE2ZCfPOxdtSDNrlPgVgR80w==
X-Received: by 2002:a17:90b:250b:b0:32d:dfb5:36d8 with SMTP id 98e67ed59e1d1-32ddfb54564mr1649322a91.8.1757628989675;
        Thu, 11 Sep 2025 15:16:29 -0700 (PDT)
Received: from archlinux ([2601:644:8200:ac2f::9ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd9509002sm3333995a91.0.2025.09.11.15.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:16:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] wifi: mt76: mt76_eeprom_override to int
Date: Thu, 11 Sep 2025 15:16:19 -0700
Message-ID: <20250911221619.16035-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt76_eeprom_override has of_get_mac_address, which can return
-EPROBE_DEFER if the nvmem driver gets loaded after mt76 for some
reason.

Make sure this gets passed to probe so that nvmem mac overrides always
work.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c        | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 4 +---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 4 +---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 4 +++-
 13 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 443517d06c9f..a987c5e4eff6 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -163,13 +163,16 @@ static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 	return mt76_get_of_data_from_nvmem(dev, eep, "eeprom", len);
 }
 
-void
+int
 mt76_eeprom_override(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 	struct device_node *np = dev->dev->of_node;
+	int err;
 
-	of_get_mac_address(np, phy->macaddr);
+	err = of_get_mac_address(np, phy->macaddr);
+	if (err == -EPROBE_DEFER)
+		return err;
 
 	if (!is_valid_ether_addr(phy->macaddr)) {
 		eth_random_addr(phy->macaddr);
@@ -177,6 +180,8 @@ mt76_eeprom_override(struct mt76_phy *phy)
 			 "Invalid MAC address, using random address %pM\n",
 			 phy->macaddr);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_eeprom_override);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 127637454c82..47c143e6a79a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1268,7 +1268,7 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len);
 
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
-void mt76_eeprom_override(struct mt76_phy *phy);
+int mt76_eeprom_override(struct mt76_phy *phy);
 int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
 int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
 				const char *cell_name, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index f5a6b03bc61d..88382b537a33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -182,7 +182,6 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 		dev->mphy.antenna_mask = 1;
 
 	dev->mphy.chainmask = dev->mphy.antenna_mask;
-	mt76_eeprom_override(&dev->mphy);
 
-	return 0;
+	return mt76_eeprom_override(&dev->mphy);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index ccedea7e8a50..d4bc7e11e772 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -351,8 +351,6 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
 
-	mt76_eeprom_override(&dev->mphy);
-
-	return 0;
+	return mt76_eeprom_override(&dev->mphy);
 }
 EXPORT_SYMBOL_GPL(mt7615_eeprom_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index aae80005a3c1..3e7af3e58736 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -570,7 +570,10 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	       ETH_ALEN);
 	mphy->macaddr[0] |= 2;
 	mphy->macaddr[0] ^= BIT(7);
-	mt76_eeprom_override(mphy);
+
+	ret = mt76_eeprom_override(mphy);
+	if (ret)
+		return ret;
 
 	/* second phy can only handle 5 GHz */
 	mphy->cap.has_5ghz = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index 4de45a56812d..d4506b8b46fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -332,7 +332,11 @@ int mt76x0_eeprom_init(struct mt76x02_dev *dev)
 
 	memcpy(dev->mphy.macaddr, (u8 *)dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
-	mt76_eeprom_override(&dev->mphy);
+
+	err = mt76_eeprom_override(&dev->mphy);
+	if (err)
+		return err;
+
 	mt76x02_mac_setaddr(dev, dev->mphy.macaddr);
 
 	mt76x0_set_chip_cap(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 156b16c17b2b..221805deb42f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -499,7 +499,9 @@ int mt76x2_eeprom_init(struct mt76x02_dev *dev)
 
 	mt76x02_eeprom_parse_hw_cap(dev);
 	mt76x2_eeprom_get_macaddr(dev);
-	mt76_eeprom_override(&dev->mphy);
+	ret = mt76_eeprom_override(&dev->mphy);
+	if (ret)
+		return ret;
 	dev->mphy.macaddr[0] &= ~BIT(1);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index c0f3402d30bb..38dfd5de365c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -284,9 +284,7 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
 	       ETH_ALEN);
 
-	mt76_eeprom_override(&dev->mphy);
-
-	return 0;
+	return mt76_eeprom_override(&dev->mphy);
 }
 
 int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 3e30ca5155d2..5ea8b46e092e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -702,7 +702,9 @@ mt7915_register_ext_phy(struct mt7915_dev *dev, struct mt7915_phy *phy)
 		mphy->macaddr[0] |= 2;
 		mphy->macaddr[0] ^= BIT(7);
 	}
-	mt76_eeprom_override(mphy);
+	ret = mt76_eeprom_override(mphy);
+	if (ret)
+		return ret;
 
 	/* init wiphy according to mphy and phy */
 	mt7915_init_wiphy(phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 14e17dc90256..b9098a7331b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -189,7 +189,9 @@ static int __mt7921_init_hardware(struct mt792x_dev *dev)
 	if (ret)
 		goto out;
 
-	mt76_eeprom_override(&dev->mphy);
+	ret = mt76_eeprom_override(&dev->mphy);
+	if (ret)
+		goto out;
 
 	ret = mt7921_mcu_set_eeprom(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 4249bad83c93..d7d5afe365ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -249,7 +249,9 @@ static int __mt7925_init_hardware(struct mt792x_dev *dev)
 	if (ret)
 		goto out;
 
-	mt76_eeprom_override(&dev->mphy);
+	ret = mt76_eeprom_override(&dev->mphy);
+	if (ret)
+		goto out;
 
 	ret = mt7925_mcu_set_eeprom(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 87c6192b6384..da3231c9aa11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -334,9 +334,8 @@ int mt7996_eeprom_init(struct mt7996_dev *dev)
 		return ret;
 
 	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR, ETH_ALEN);
-	mt76_eeprom_override(&dev->mphy);
 
-	return 0;
+	return mt76_eeprom_override(&dev->mphy);
 }
 
 int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a9599c286328..0537475573ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -667,7 +667,9 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 		if (band == MT_BAND2)
 			mphy->macaddr[0] ^= BIT(6);
 	}
-	mt76_eeprom_override(mphy);
+	ret = mt76_eeprom_override(mphy);
+	if (ret)
+		goto error;
 
 	/* init wiphy according to mphy and phy */
 	mt7996_init_wiphy_band(mphy->hw, phy);
-- 
2.51.0


