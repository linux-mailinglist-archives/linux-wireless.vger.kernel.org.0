Return-Path: <linux-wireless+bounces-27167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BFB4A8D1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EB188402D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3573101DB;
	Tue,  9 Sep 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAxOVDt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695E312805
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411148; cv=none; b=OvSQfBKuTndHw6x6aw5fPJfJlJX0JZyQVc0leikM1i6VQuBxpHvwh7NcYrNnM1NUqDluUUCiBU80hjYUVmXivf6qUUUYfyrmV+ZX5L63sAYSsfLg+E/k4IrUQthxbW1TbMnA+B2CcDCvA6gWgLxfpuuR2oZScFJWrqQTq/HMw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411148; c=relaxed/simple;
	bh=Ldn4i3vhsJn/28YVTCdrkXvUwM0PE9DmYm36ZQcXL8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxPeZB6Dc/IHTZJgiOG/QeOOnxdwC0ZF0V6WnYJoGqvW5FwEb59IANoN5SZel5reh74TsKB2q3Iea5igMU0KvD3IBogun8mY8kcTY5aLlQFqBJJWQMDy5HwrJlgiAeS8nZZ2S+SbTb4XMbAcxnPe5UIKlbo2DyOjEls4VYp6u2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAxOVDt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C28C4CEF4;
	Tue,  9 Sep 2025 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411147;
	bh=Ldn4i3vhsJn/28YVTCdrkXvUwM0PE9DmYm36ZQcXL8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZAxOVDt9FnS7usAHgmcnkkArIhnWgdLOIcwFMsShZCU2LQeNGX2aSFbXJtJE0AU6k
	 rsFvxn77EoDxVVq/m0Q6hIFuRaHlTllduxnqrxnW2EO0TcOAQQEuJMuSYxve3wt6MO
	 QoOl+rFmxMrzoDZMaHQ3sBEwAz6v3DkqSBGVVd88bhBI3XH/tGx9ndxEZ/eLsIp8Lt
	 9VYavIdtJJLHsA6DFKXIv5yLHAi8IMlL7bw0Sdz7o/RKBdhtOiZG6DHIo8DUXaNXva
	 488otiJ4SlxNx34f7Kqd7KyUrdbwmLHQXGPFYUgkua+3uHpwY32EDj4zL3jeed/yZS
	 c4g5s5DZbqj8g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:17 +0200
Subject: [PATCH mt76 v5 09/16] wifi: mt76: mt7996: Fix RX packets
 configuration for primary WED device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-9-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
In-Reply-To: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

In order to properly set the number of rx packets for primary WED device
if hif device is available, move hif pointer initialization before
running mt7996_mmio_wed_init routine.

Fixes: 83eafc9251d6d ("wifi: mt76: mt7996: add wed tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 19e99bc1c6c4157fb3c2c1b9ee70ed00a6e28a73..f5ce50056ee94e2915fd189419905acc8cebd853 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -137,6 +137,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mdev = &dev->mt76;
 	mt7996_wfsys_reset(dev);
 	hif2 = mt7996_pci_init_hif2(pdev);
+	dev->hif2 = hif2;
 
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
@@ -161,7 +162,6 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	if (hif2) {
 		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
-		dev->hif2 = hif2;
 
 		ret = mt7996_mmio_wed_init(dev, hif2_dev, true, &hif2_irq);
 		if (ret < 0)

-- 
2.51.0


