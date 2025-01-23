Return-Path: <linux-wireless+bounces-17846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D8A19BE9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738EC188DEC5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4635965;
	Thu, 23 Jan 2025 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POmKc8l2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7491EF01;
	Thu, 23 Jan 2025 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593128; cv=none; b=R71Vgd71aR21fmI27hNYBiaB7rDRpIr0+WsPgPUWLJLKHpZpOigDft8yh+E2IncSXt1o3oUdpHJVX9js2/T1ONYfXN8zjFJABsJYgyvjAmHE8kUZTNxXOABhlUtpEuMr6KY+yDvEaofS38Q4hMAlKu3ZNTtoNi8mnXyj9tvns9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593128; c=relaxed/simple;
	bh=mtHl+eiTIUYaHdG7xSOt9tfDm1HS0Z8cvpdxG4XToQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adUm/W5R7kPbcN8OR93L6/ql8eGu75Gme5Hr+aYQlesyyZOqwmJtLC1PcML+VqogZCjT6cGzjkt3zoM0HK/1qc2GlBdASKzlOPJjN8VPQ0FGRBbhPpav9O6mGhhleyQmpOustCbJjDGzmdRzFbB7lTCOEhWfH2qgWlrytlESWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POmKc8l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4267CC4CEE7;
	Thu, 23 Jan 2025 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593128;
	bh=mtHl+eiTIUYaHdG7xSOt9tfDm1HS0Z8cvpdxG4XToQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POmKc8l2Tcbmf2GFl3LsnaAfk/mCsEHKB4OQd1qQlk2/1ja5KHPb3+7+pdNyTrsww
	 Og/RUipCSZLGhPIG3abZcgx/PS8viglhq726BUQLe+HIqBkOlyqDyHXHs5ss5OwHai
	 S0Nw2vI4rPIT5/Jw6FAEkhQmu7V31ZouVlyaEs9YGCkn+JeqvYHe8I5eeiZsfMQWYI
	 pITaOO6mW8xXGF1CVRjnApAyepl9fi2Ft+RXpdmM5Rvk+o1XeiykDbBkKyzwK6N8QI
	 9qUCM2e808b3skwL0GHCM622JA8WaEFvYKE9pe7QlbgejSu88MYvimTsendi/EIusj
	 myBVv4X6lTNXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	quan.zhou@mediatek.com,
	johannes.berg@intel.com,
	emmanuel.grumbach@intel.com,
	leitao@debian.org,
	mingyen.hsieh@mediatek.com,
	leon.yen@mediatek.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	kuniyu@amazon.com,
	romieu@fr.zoreil.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH net v2 7/7] wifi: mt76: move napi_enable() from under BH
Date: Wed, 22 Jan 2025 16:45:20 -0800
Message-ID: <20250123004520.806855-8-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123004520.806855-1-kuba@kernel.org>
References: <20250123004520.806855-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt76 does a lot of:

  local_bh_disable();
  napi_enable(...napi);
  napi_schedule(...napi);
  local_bh_enable();

local_bh_disable() is not a real lock, its most likely taken
because napi_schedule() requires that we invoke softirqs at
some point. napi_enable() needs to take a mutex, so move it
from under the BH protection.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - reword the commit msg slightly
v1: https://lore.kernel.org/20250121221519.392014-8-kuba@kernel.org

CC: nbd@nbd.name
CC: lorenzo@kernel.org
CC: ryder.lee@mediatek.com
CC: shayne.chen@mediatek.com
CC: sean.wang@mediatek.com
CC: kvalo@kernel.org
CC: matthias.bgg@gmail.com
CC: angelogioacchino.delregno@collabora.com
CC: quan.zhou@mediatek.com
CC: johannes.berg@intel.com
CC: emmanuel.grumbach@intel.com
CC: leitao@debian.org
CC: mingyen.hsieh@mediatek.com
CC: leon.yen@mediatek.com
CC: deren.wu@mediatek.com
CC: chui-hao.chiu@mediatek.com
CC: kuniyu@amazon.com
CC: romieu@fr.zoreil.com
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c |  9 ++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c |  8 ++++++--
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c |  8 +++++---
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c   |  8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c |  7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 17 +++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c |  7 +++++--
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c |  7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c |  7 +++++--
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c |  7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 12 ++++++------
 12 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index a259f4dd9540..413973d05b43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1479,14 +1479,13 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 	mt7603_beacon_set_timer(dev, -1, beacon_int);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-
 	napi_enable(&dev->mt76.napi[0]);
-	napi_schedule(&dev->mt76.napi[0]);
-
 	napi_enable(&dev->mt76.napi[1]);
+
+	local_bh_disable();
+	napi_schedule(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.napi[0]);
 	napi_schedule(&dev->mt76.napi[1]);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 9a278589df4e..68010e27f065 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -164,12 +164,16 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
 
 	mt76_worker_enable(&mdev->tx_worker);
-	local_bh_disable();
+
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
-		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_schedule(&mdev->napi[i]);
+	}
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index a0ca3bbdfcaf..c2e4e6aabd9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -262,12 +262,14 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
+	}
+
+	local_bh_disable();
+	napi_schedule(&dev->mt76.tx_napi);
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 	local_bh_enable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 1eb955f3ca13..b456ccd00d58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -282,14 +282,16 @@ static int mt76x0e_resume(struct pci_dev *pdev)
 
 	mt76_worker_enable(&mdev->tx_worker);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		mt76_queue_rx_reset(dev, i);
 		napi_enable(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
 		napi_schedule(&mdev->napi[i]);
 	}
-
-	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7d840ad4ae65..a82c75ba26e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -504,12 +504,14 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	mt76_worker_enable(&dev->mt76.tx_worker);
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
-	napi_schedule(&dev->mt76.tx_napi);
-
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
+	}
+
+	local_bh_disable();
+	napi_schedule(&dev->mt76.tx_napi);
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 	local_bh_enable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 67c9d1caa0bd..727bfdd00b40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -151,12 +151,15 @@ mt76x2e_resume(struct pci_dev *pdev)
 
 	mt76_worker_enable(&mdev->tx_worker);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
-		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_schedule(&mdev->napi[i]);
+	}
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 13bdc0a7174c..2ba6eb3038ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1356,10 +1356,15 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 
 	mt7915_dma_reset(dev, true);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		if (mdev->q_rx[i].ndesc) {
 			napi_enable(&dev->mt76.napi[i]);
+		}
+	}
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		if (mdev->q_rx[i].ndesc) {
 			napi_schedule(&dev->mt76.napi[i]);
 		}
 	}
@@ -1419,8 +1424,9 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	if (phy2)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
+
+	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
@@ -1570,9 +1576,12 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	if (phy2)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
+	}
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 	local_bh_enable();
@@ -1581,8 +1590,8 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
+	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ba870e1b05fb..a0c9df3c2cc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -523,12 +523,15 @@ static int mt7921_pci_resume(struct device *device)
 
 	mt76_worker_enable(&mdev->tx_worker);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
-		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_schedule(&mdev->napi[i]);
+	}
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 2452b1a2d118..881812ba03ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -81,9 +81,12 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 
 	mt792x_wpdma_reset(dev, true);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
+	}
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_schedule(&dev->mt76.napi[i]);
 	}
 	local_bh_enable();
@@ -115,8 +118,8 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	err = __mt7921_start(&dev->phy);
 out:
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
+	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index f36893e20c61..c7b5dc1dbb34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -556,12 +556,15 @@ static int mt7925_pci_resume(struct device *device)
 
 	mt76_worker_enable(&mdev->tx_worker);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		napi_enable(&mdev->napi[i]);
-		napi_schedule(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		napi_schedule(&mdev->napi[i]);
+	}
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index faedbf766d1a..4578d16bf456 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -101,12 +101,15 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 
 	mt792x_wpdma_reset(dev, true);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		napi_enable(&dev->mt76.napi[i]);
-		napi_schedule(&dev->mt76.napi[i]);
 	}
 	napi_enable(&dev->mt76.tx_napi);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		napi_schedule(&dev->mt76.napi[i]);
+	}
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index bc8cba4dca47..019c925ae600 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1695,7 +1695,6 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 
 	mt7996_dma_reset(dev, true);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(mdev, i) {
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
 		    mt76_queue_is_wed_rro(&mdev->q_rx[i]))
@@ -1703,10 +1702,11 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 
 		if (mdev->q_rx[i].ndesc) {
 			napi_enable(&dev->mt76.napi[i]);
+			local_bh_disable();
 			napi_schedule(&dev->mt76.napi[i]);
+			local_bh_enable();
 		}
 	}
-	local_bh_enable();
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
@@ -1764,8 +1764,8 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	if (phy3)
 		clear_bit(MT76_RESET, &phy3->mt76->state);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
+	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
@@ -1958,23 +1958,23 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	if (phy3)
 		clear_bit(MT76_RESET, &phy3->mt76->state);
 
-	local_bh_disable();
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
 		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
 			continue;
 
 		napi_enable(&dev->mt76.napi[i]);
+		local_bh_disable();
 		napi_schedule(&dev->mt76.napi[i]);
+		local_bh_enable();
 	}
-	local_bh_enable();
 
 	tasklet_schedule(&dev->mt76.irq_tasklet);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
+	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
 	local_bh_enable();
 
-- 
2.48.1


