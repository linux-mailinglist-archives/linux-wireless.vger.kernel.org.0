Return-Path: <linux-wireless+bounces-1140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4679081B2CC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028DD288FB3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0540C1C;
	Thu, 21 Dec 2023 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOiKugYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5226405D0
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 09:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5312C433C7;
	Thu, 21 Dec 2023 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703151683;
	bh=4KB9cNfKyUtmstEW8ccP6ovy2zqVxJYT1eY1JmYfZcg=;
	h=From:To:Cc:Subject:Date:From;
	b=OOiKugYq0AEpmAk309FFVzvkuUnsOSvSyJoBPoESRrdpgEDm7w4lx+VUxdj+Jix7P
	 6ZTHxrhMvLkOFfKDXFtyilEJIDEyQr+S1f7jyH0/zwYVafd1w8cYKHxE7TmAP0nojz
	 g6tOmBfV86PANZEQX4WAIewpW9LZYVxuX6RGOnm9WOH4vIHeJnyB4BBDNblQIqIIUv
	 aslzZGLv+mlco3vOKOB6hYI1YmwmeFbPRpP6HY/Zz+TgdlTpq7IhnZQlq3b++2K9in
	 zcAyzXcbB7jyegeuSQtkRjxGTDksTjC5M/TJkLNb+nuBtC+AK8nH6b3qQTym6fKeXF
	 T9LWd8Tv1BvtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org,
	sujuan.chen@mediatek.com
Subject: [PATCH] wifi: mt76: mt7996: fix fw loading timeout
Date: Thu, 21 Dec 2023 10:41:18 +0100
Message-ID: <7c0df5b926c2fd6383cde8c9ee50b313443110ab.1703151499.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following firmware loading error due to a wrong dma register
configuration if wed is disabled.

[    8.245881] mt7996e_hif 0001:01:00.0: assign IRQ: got 128
[    8.251308] mt7996e_hif 0001:01:00.0: enabling device (0000 -> 0002)
[    8.257674] mt7996e_hif 0001:01:00.0: enabling bus mastering
[    8.263488] mt7996e 0000:01:00.0: assign IRQ: got 126
[    8.268537] mt7996e 0000:01:00.0: enabling device (0000 -> 0002)
[    8.274551] mt7996e 0000:01:00.0: enabling bus mastering
[   28.648773] mt7996e 0000:01:00.0: Message 00000010 (seq 1) timeout
[   28.654959] mt7996e 0000:01:00.0: Failed to get patch semaphore
[   29.661033] mt7996e: probe of 0000:01:00.0 failed with error -11

Suggested-by: Sujuan Chen" <sujuan.chen@mediatek.com>
Fixes: 4920a3a1285f ("wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 885ddf2c0d01..73e633d0d700 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -237,7 +237,8 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 				 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_RX_DMA_EN |
 				 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+				 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2 |
+				 MT_WFDMA0_GLO_CFG_EXT_EN);
 
 		if (dev->hif2)
 			mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-- 
2.43.0


