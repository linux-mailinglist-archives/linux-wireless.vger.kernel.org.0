Return-Path: <linux-wireless+bounces-8103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B68D039B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A111C21A23
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455C17F37B;
	Mon, 27 May 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5YUqmag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2B16ABE2;
	Mon, 27 May 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819313; cv=none; b=ohKBJO39l11d7indVSwGnvG+ydasfEp+y8twMsXLqpZDSh4DQX4+OJMFdk7kRSHvIBfPIRLKnQ1eL9dcypl5P//6q/0aje6DsFN9Pt2KjKQapZvJwHmS4NSfaY/MC2CndqsQZJ6R0V/fyqOY42RZVKOQDrherKFntHH76gHdYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819313; c=relaxed/simple;
	bh=x3V+F4/2QeO/JDxzdGbicGzEx4qIlmPs3Ym+NTYFZQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfHT+VMwPJHYnsBYXWULhu/9CBjLqMQvyyTVFvh6qtOQa//JP2c0nCg/aRvoKfvishvjZULm4p0CKBQ3XajcB/Uw1N77Ay8RSDEoJMM8Mqpggm6yxl6KTuVQe/gbxOOz3olEJWHgiOmcr5H0an5FPqE8xc34YaPvXxND35yaSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5YUqmag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA81CC4AF0E;
	Mon, 27 May 2024 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819313;
	bh=x3V+F4/2QeO/JDxzdGbicGzEx4qIlmPs3Ym+NTYFZQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5YUqmagyv8rkxCexM5pGFE0R4IkMnPY2rRplIw96kGYv05UBlfKdykAQ3inwOF4w
	 UelSnxV/TPWWVXNxFs5nfmVhW0nKT7otSg3I+Pd0Fy85o8TzXi7aZvdaiDQV40OXHk
	 SG8BVFwERSieBjJooBJaqVB/iTGFL0lVjPWYhwYwDfai+Kz4pF3+NDB2nMelu5ckUZ
	 dPtTwnIN949iKJ4q78TfFqUlP2YulR3sPwRj5M0/i5NAmXVt+Q8dU2vvTfMiKikbYI
	 oE0AMOh9tHyQNTgyI/oqLIYAdJBLvMrYfVj2Swve+rw28K/69PwIBXR5pjk5OvcklA
	 k5anqUVDdzwaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Yen <leon.yen@mediatek.com>,
	Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	deren.wu@mediatek.com,
	horms@kernel.org,
	kernel@mattwhitlock.name,
	wang.zhao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 23/30] wifi: mt76: mt7921s: fix potential hung tasks during chip recovery
Date: Mon, 27 May 2024 10:13:32 -0400
Message-ID: <20240527141406.3852821-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Leon Yen <leon.yen@mediatek.com>

[ Upstream commit ecf0b2b8a37c8464186620bef37812a117ff6366 ]

During chip recovery (e.g. chip reset), there is a possible situation that
kernel worker reset_work is holding the lock and waiting for kernel thread
stat_worker to be parked, while stat_worker is waiting for the release of
the same lock.
It causes a deadlock resulting in the dumping of hung tasks messages and
possible rebooting of the device.

This patch prevents the execution of stat_worker during the chip recovery.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  | 2 --
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 2 --
 drivers/net/wireless/mediatek/mt76/sdio.c            | 3 ++-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 867e14f6b93a0..73e42ef429837 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -663,6 +663,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	int i, ret;
 
 	dev_dbg(dev->mt76.dev, "chip reset\n");
+	set_bit(MT76_RESET, &dev->mphy.state);
 	dev->hw_full_reset = true;
 	ieee80211_stop_queues(hw);
 
@@ -691,6 +692,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	}
 
 	dev->hw_full_reset = false;
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
 	ieee80211_iterate_active_interfaces(hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index c866144ff0613..031ba9aaa4e2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -64,7 +64,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -115,7 +114,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 389eb0903807e..1f77cf71ca701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -98,7 +98,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -135,7 +134,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 3e88798df0178..a4ed00eebc483 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -499,7 +499,8 @@ static void mt76s_tx_status_data(struct mt76_worker *worker)
 	dev = container_of(sdio, struct mt76_dev, sdio);
 
 	while (true) {
-		if (test_bit(MT76_REMOVED, &dev->phy.state))
+		if (test_bit(MT76_RESET, &dev->phy.state) ||
+		    test_bit(MT76_REMOVED, &dev->phy.state))
 			break;
 
 		if (!dev->drv->tx_status_data(dev, &update))
-- 
2.43.0


