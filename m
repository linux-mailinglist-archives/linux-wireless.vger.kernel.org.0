Return-Path: <linux-wireless+bounces-8098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B78D0327
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C9729EC54
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BA15FA76;
	Mon, 27 May 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqI7gwa/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF215F413;
	Mon, 27 May 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819194; cv=none; b=G6IxK28wtbTBkNqTUBNp+ZsPSbjJREd44Xuc/pLSZ1DOesUAomEOyFDaHGJFnf41D7i2cw0yrxo6dTTFzYeY0G2vLMzkeM4kf+N/mfd9/4SaBxNtLrbGYuHhCIbgKpltXozsVwkOSvGfj5laAaWJNM8puaVCwyeigKaIoArUD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819194; c=relaxed/simple;
	bh=x3V+F4/2QeO/JDxzdGbicGzEx4qIlmPs3Ym+NTYFZQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXq9OF4XNsWCLEnuG99/7I16Py3GQqf4LiiUPcUFV4Zps9vWsqz+FAPuPD5aP3FildUUpH13ULHwc9/qwFQa3sBq9WH5MlCxflIQ6ub2BNoRnmJ1aNjMM4XLq749wzlDvQz7DjUoiUdxXEJzOJXNB/73EhAeeGO5PawPomeZMNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqI7gwa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B4C2BBFC;
	Mon, 27 May 2024 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819194;
	bh=x3V+F4/2QeO/JDxzdGbicGzEx4qIlmPs3Ym+NTYFZQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqI7gwa/aaYYapPYmn7ZK8TJiG53I9DF15SZVF4ArDBlNxpyD4rtIQ3hOvdlPW9R9
	 2gOHmWYpazCwFs+Cc+l9CBt+EJpwcm5knT4eVgEq7wQFIhfB+91+ncm0TVOZjc6Za2
	 mlf53jRfIIx5Ce0XgBoDWkSCRV6Rjhr86bPPl6LWgxaDF3PsqtILQyqjaRBNCg6qe0
	 rWO02l6i73eXBYa3lAgePGaY2+J2PySdELWppLVcSQu1Jh0dXDOhghZwhVYZq8ViW8
	 okfpQCdXgK20alYvb/hzy4rPTesuT3GZ8P7lKJE6IfPWr3Tvbr0u9xYxtvJJSkAEJJ
	 o2LMCZqQx0wsw==
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
	sean.wang@mediatek.com,
	kernel@mattwhitlock.name,
	wang.zhao@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 27/35] wifi: mt76: mt7921s: fix potential hung tasks during chip recovery
Date: Mon, 27 May 2024 10:11:32 -0400
Message-ID: <20240527141214.3844331-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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


