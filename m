Return-Path: <linux-wireless+bounces-9011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CD908B19
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D5289845
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A589195FEF;
	Fri, 14 Jun 2024 11:55:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D814D29B;
	Fri, 14 Jun 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366107; cv=none; b=TUCbj0mEnj/BQVvsj9U0MkWam7Fc0FA08o+r606I6C32I+3DrR3jY1JbwBkzg2w8CPY2NGYF1z0hPzo8y9uBA5lDTJX5WIytTUEpcXa5UyFbu5B0p4tJzmS0H99dzUqKlRCIDT/i+UIQrRu11zZSIjNdlfiw/GTPNwfV9sLZUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366107; c=relaxed/simple;
	bh=IgYl4TaWzLNfd0vfqkiTp8kN4qlpKAD1hY7bmvXK82s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5jIXvNbSBcmgmP6YTlMvKat4K9JsVvlc8SKN9DRr8H6pJLcR1TXRWac4o7Awfyulwuwf3BzzrcHmH5Sv5LF8kvIQhTo4I7TsUuA/CPfxaqKZ2dP5bZWtBQvmOijUyGNWui22tE+ePau2VaMa6rPiIhSCHct1VMuGb1MZIdBQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso2201633a12.3;
        Fri, 14 Jun 2024 04:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718366104; x=1718970904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j41Weqp75RphGFqrj1Kspbcz878tK8UuoQ8p5OS9G6Y=;
        b=iqyiOpq3yf+eRYmBljDDsF6mn27GNzHfr7/ZivtRKSiDRzqfr5j6jJor/AcSRxgWSx
         46EgzZZ+syLtRfLYzXdp6ARONc//Byx0hnte9URkZjAFk7CI3FsyGJg1n+wIIY5jGTAw
         Vctczey+QtP776cl05w/SxL4eHtgkZqmks4C8Qi4fB++rSqxWTB4/NhIgc51h0NmCCT5
         43Zsiv4ecYv2JR9i3feoHVd04gEPTrkxA45XA4/DycFpZgBdQBVttoEbIu0yDw2lmO31
         AzhbZI+ryCVev3Q3GG5A0zsA/J39Ot1LZwwM15279D/VbJ/2/ztaScxe/SnPP45W79IF
         3izg==
X-Forwarded-Encrypted: i=1; AJvYcCX6XO8Ad7Zsb87w5Xs9ZYnfEg2nK6p3KZNNIXQAs5LWygp+6rjcsPmdbre+eXyjz4WtdFkSm3ruDp6lWbfCe+sj5etVdv6QGMFIYUkebezxpTwlTb3GZ05W0wSBKFdCsiwnEy8d25Zr3/QP9Xs=
X-Gm-Message-State: AOJu0Yy4BiH920AlE4Ta8Oo+fxgggc0zndD21r8NOxwv9VP/0VBQ4Ri3
	L3o/6hr0r2VWnBIizSjs2Hly0zXlWn7oveqWCpnUg3B9b4alfK1Z
X-Google-Smtp-Source: AGHT+IGDv+rRVYXWIZxDXGLLU+IncjYEVdIVPKRohIoNGMvyTkPIIyHCi73g3GoJ8mJ678jlzTSVRw==
X-Received: by 2002:a17:906:6c9a:b0:a6e:57ff:7700 with SMTP id a640c23a62f3a-a6f60d421aamr138247566b.42.1718366103309;
        Fri, 14 Jun 2024 04:55:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fe5sm181083866b.18.2024.06.14.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 04:55:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Alexander Couzens <lynxis@fe80.eu>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Ingo Rohloff <lundril@gmx.de>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Benjamin Lin <benjamin-jw.lin@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] wifi: mt76: un-embedd netdev from mt76_dev
Date: Fri, 14 Jun 2024 04:52:42 -0700
Message-ID: <20240614115317.657700-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_devices from struct mt76_dev by converting them
into pointers, and allocating them dynamically. Use the leverage
alloc_netdev_dummy() to allocate the net_device object at
mt76_dma_init().

The free of the device occurs at mt76_dma_cleanup().

Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---

PS: Due to the lack of hardware, this patch was not tested on a real
hardware, unfortunately.

PS2: this is the last driver that is still using embedded netdevices.

 drivers/net/wireless/mediatek/mt76/debugfs.c  |  6 ++--
 drivers/net/wireless/mediatek/mt76/dma.c      | 31 +++++++++++++++----
 drivers/net/wireless/mediatek/mt76/dma.h      |  5 +++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +--
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  6 ++--
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt792x_dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  2 +-
 12 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index ae83be572b94..b6a2746c187d 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -33,8 +33,8 @@ mt76_napi_threaded_set(void *data, u64 val)
 	if (!mt76_is_mmio(dev))
 		return -EOPNOTSUPP;
 
-	if (dev->napi_dev.threaded != val)
-		return dev_set_threaded(&dev->napi_dev, val);
+	if (dev->napi_dev->threaded != val)
+		return dev_set_threaded(dev->napi_dev, val);
 
 	return 0;
 }
@@ -44,7 +44,7 @@ mt76_napi_threaded_get(void *data, u64 *val)
 {
 	struct mt76_dev *dev = data;
 
-	*val = dev->napi_dev.threaded;
+	*val = dev->napi_dev->threaded;
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f4f88c444e21..bf67b1f2348a 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -916,7 +916,7 @@ int mt76_dma_rx_poll(struct napi_struct *napi, int budget)
 	struct mt76_dev *dev;
 	int qid, done = 0, cur;
 
-	dev = container_of(napi->dev, struct mt76_dev, napi_dev);
+	dev = mt76_from_netdev(napi->dev);
 	qid = napi - dev->napi;
 
 	rcu_read_lock();
@@ -940,18 +940,35 @@ static int
 mt76_dma_init(struct mt76_dev *dev,
 	      int (*poll)(struct napi_struct *napi, int budget))
 {
+	struct mt76_dev **priv;
 	int i;
 
-	init_dummy_netdev(&dev->napi_dev);
-	init_dummy_netdev(&dev->tx_napi_dev);
-	snprintf(dev->napi_dev.name, sizeof(dev->napi_dev.name), "%s",
+	dev->napi_dev = alloc_netdev_dummy(sizeof(struct mt76_dev *));
+	if (!dev->napi_dev)
+		return -ENOMEM;
+
+	/* napi_dev private data points to mt76_dev parent, so, mt76_dev
+	 * can be retrieved given napi_dev
+	 */
+	priv = netdev_priv(dev->napi_dev);
+	*priv = dev;
+
+	dev->tx_napi_dev = alloc_netdev_dummy(sizeof(struct mt76_dev *));
+	if (!dev->tx_napi_dev) {
+		free_netdev(dev->napi_dev);
+		return -ENOMEM;
+	}
+	priv = netdev_priv(dev->tx_napi_dev);
+	*priv = dev;
+
+	snprintf(dev->napi_dev->name, sizeof(dev->napi_dev->name), "%s",
 		 wiphy_name(dev->hw->wiphy));
-	dev->napi_dev.threaded = 1;
+	dev->napi_dev->threaded = 1;
 	init_completion(&dev->mmio.wed_reset);
 	init_completion(&dev->mmio.wed_reset_complete);
 
 	mt76_for_each_q_rx(dev, i) {
-		netif_napi_add(&dev->napi_dev, &dev->napi[i], poll);
+		netif_napi_add(dev->napi_dev, &dev->napi[i], poll);
 		mt76_dma_rx_fill(dev, &dev->q_rx[i], false);
 		napi_enable(&dev->napi[i]);
 	}
@@ -1019,5 +1036,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 
 	mt76_free_pending_txwi(dev);
 	mt76_free_pending_rxwi(dev);
+	free_netdev(dev->napi_dev);
+	free_netdev(dev->tx_napi_dev);
 }
 EXPORT_SYMBOL_GPL(mt76_dma_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 1de5a2b20f74..6454a5eca13e 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -116,4 +116,9 @@ mt76_dma_should_drop_buf(bool *drop, u32 ctrl, u32 buf1, u32 info)
 	}
 }
 
+static inline struct mt76_dev *mt76_from_netdev(struct net_device *dev)
+{
+	return *(struct mt76_dev **)netdev_priv(dev);
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 11b9f22ca7f3..15f83b5adac7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -831,8 +831,8 @@ struct mt76_dev {
 
 	struct mt76_mcu mcu;
 
-	struct net_device napi_dev;
-	struct net_device tx_napi_dev;
+	struct net_device *napi_dev;
+	struct net_device *tx_napi_dev;
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 14304b063715..ea017f22fff2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -242,7 +242,7 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7603_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index e7135b2f1742..966e3d2c295f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -67,7 +67,7 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7615_dev *dev;
 
-	dev = container_of(napi, struct mt7615_dev, mt76.tx_napi);
+	dev = (struct mt7615_dev *)mt76_from_netdev(napi->dev);
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		napi_complete(napi);
 		queue_work(dev->mt76.wq, &dev->pm.wake_work);
@@ -89,7 +89,7 @@ static int mt7615_poll_rx(struct napi_struct *napi, int budget)
 	struct mt7615_dev *dev;
 	int done;
 
-	dev = container_of(napi->dev, struct mt7615_dev, mt76.napi_dev);
+	dev = (struct mt7615_dev *)mt76_from_netdev(napi->dev);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		napi_complete(napi);
@@ -282,7 +282,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7615_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index e5ad635d3c56..35b7ebc2c9c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -239,7 +239,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt76x02_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 0baa82c8df5a..0c62272fe7d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -578,7 +578,7 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	if (ret < 0)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7915_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index f768e9389ac6..e75e7b6d3aaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -219,7 +219,7 @@ static int mt7921_dma_init(struct mt792x_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt792x_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 07b74d492ce1..577574fb7a1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -254,7 +254,7 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt792x_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 5cc2d59b774a..45aed1e1b1a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -340,7 +340,7 @@ int mt792x_poll_rx(struct napi_struct *napi, int budget)
 	struct mt792x_dev *dev;
 	int done;
 
-	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
+	dev = (struct mt792x_dev *)mt76_from_netdev(napi->dev);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
 		napi_complete(napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 73e633d0d700..69a7d9b2e38b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -641,7 +641,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	netif_napi_add_tx(&dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
 			  mt7996_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
-- 
2.43.0


