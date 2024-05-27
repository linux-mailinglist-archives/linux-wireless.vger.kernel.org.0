Return-Path: <linux-wireless+bounces-8108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8678D0428
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105DE1F21903
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83D16D9B9;
	Mon, 27 May 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvWkoY4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8015F405;
	Mon, 27 May 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819477; cv=none; b=SQByzxeNan2xzKaerF3esek86J6W4bQtK8Z75lqbRe+M92gSlm0WKemYq6zUggcHC0LO3DwU5Wa/aA/3tsc3rPGN/BZXbwuG/xTTLoZhS5Y7/Bbl7sV0puZIVoAuZj/mUj9TesCVwSyQscetjgBO0x3kLXgD1v/RYbou5sSTMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819477; c=relaxed/simple;
	bh=XYkTLSRQDTcxmvQu5eHrjpEjE9SsJfxPR7keFDJH58g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCtjgPIpiz6xvPRWIaBuf7XB29OBoD3q9uuHxb6G9U53XlN/5kJzLj+Vf5Ojm32TFLCURd0BhL/fmyKQuO3mucJQIEkGzxto6wdvpZhGRezmpczsJrXeNV6jfgyRaZKhbs500zlsSQ20bgxS02NJeX/fGIwJ/IVxkgUurQlliJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvWkoY4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26680C2BBFC;
	Mon, 27 May 2024 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819477;
	bh=XYkTLSRQDTcxmvQu5eHrjpEjE9SsJfxPR7keFDJH58g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvWkoY4B/KX7YYfunqKxbVkM2CnpujKIzYuj/1mdyfQ/HXDfuvp21e5ivem5BMu/M
	 Q0pqVFyyIVM92mp8+fCAUPMcu3Ux2q9Mncmx8tAazTMJALIKfqFHn8TDJgTseTlaVL
	 FzUblO7S7a1t71kHytiYEXZoWHMYpZfpSkYPZ1WphH0ae1vAmiFLOU3lSQoaxOdmpH
	 uDRYNhwQegznLLf6LtG4FPL8O+xAzmCo2s8veZTAN1hGrohKkv+jesFKb3qAFB0zOZ
	 flCzXZ0Y78gJiI2+TTm+IWJxCtHRJpCmQZXXolfNhVmS7T6yjY4nDeUJOZF/Q9iXC+
	 MC/bIXHAQmOoA==
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
Subject: [PATCH AUTOSEL 6.1 13/17] wifi: mt76: mt7921s: fix potential hung tasks during chip recovery
Date: Mon, 27 May 2024 10:16:50 -0400
Message-ID: <20240527141712.3853988-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 49ddca84f7862..cae7c21ca1f8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -883,6 +883,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	int i, ret;
 
 	dev_dbg(dev->mt76.dev, "chip reset\n");
+	set_bit(MT76_RESET, &dev->mphy.state);
 	dev->hw_full_reset = true;
 	ieee80211_stop_queues(hw);
 
@@ -911,6 +912,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	}
 
 	dev->hw_full_reset = false;
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
 	ieee80211_iterate_active_interfaces(hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 8dd60408b117e..cb20ddcad137c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -78,7 +78,6 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -129,7 +128,6 @@ int mt7921e_mac_reset(struct mt7921_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index fd07b66233920..46af03803de73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -98,7 +98,6 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -135,7 +134,6 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index fc4fb94635645..2a81c2f663449 100644
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


