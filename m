Return-Path: <linux-wireless+bounces-27166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14510B4A8CD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779EC188338F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F131352D;
	Tue,  9 Sep 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT6mlgAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7A313278
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411145; cv=none; b=MTKqYDmGRr+OLUeZqiaoXR0ZpAmOMKpektO9886ZZjhqC1egvcCOwWPijf/tuuaqbzUZsDtWAgB8Hr3rvVQb4q+yC84HFLEjps+vpGngzW0x1RuXOcF0reD/t2FZws+zxPgXgsDSvMyY3VFYgZ0luZrhimdwKpSlXFrt6jb/s7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411145; c=relaxed/simple;
	bh=+bYMMlIim5Z/oTtnD/xYw2d8f71yyRUWB+j4XgoMTrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyOn2nNtZeSJn0gQNyZW38gjhKQtEVIbvNmDzhgn6cjVdy4ZWcaHxfvcWuC848BOrlTuPfGO8z/0I/gnJ4xSuhg0AHrzfTIy/JyB8/+MW/tEX7ZDr6qN/yJNkMXwUteGVsWvytB/HEYIOMMnuH5JQs2OTbW/PnzHVm678n7PAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT6mlgAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE8C4CEF4;
	Tue,  9 Sep 2025 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411145;
	bh=+bYMMlIim5Z/oTtnD/xYw2d8f71yyRUWB+j4XgoMTrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nT6mlgAHcjo3vZLy51X6xLeqHrupPFhfNrqyI2V4lETMWcUHzFgA6O+cFSSNNx4UX
	 /KSjkTwuXVxT/A8OuQK2y1x0aozLYI+WYAZKik1p2ESkoKM7kNHPDX+5Vk4U2mK0YE
	 bFCtfPcHcVKQMZdsvAOffrwnsDVCgKM3TPz0ZfrrGlWYs6lO0oY49wlMTXEca+2zK4
	 LHU8Qvii8vSzTqRwLp9Vfcz2hil8vpHyMxFqzAY6NkfRVN2YEBexw84CS1KtzLi8Ee
	 dIWYfOogE7BdjI8N1Y7T+ns1AfzU1wa25WUNNl4rQPBGrB1pMTVCBETJGC6kh0V54Q
	 JqHwv8CfQn5nw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:16 +0200
Subject: [PATCH mt76 v5 08/16] wifi: mt76: mt7996: Fix tx-queues
 initialization for second phy on mt7996
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-8-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
In-Reply-To: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Benjamin Lin <benjamin-jw.lin@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

Fix the second phy tx queue initialization if hif device is not
available for MT7990 chipset.

Fixes: 83eafc9251d6d ("wifi: mt76: mt7996: add wed tx support")
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 73a55eea535872f94d2328ea5d832d82bf02abb2..a472c9bd4fd8ae88a5213bda8225c91716423f6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -703,13 +703,20 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 
 	/* init wiphy according to mphy and phy */
 	mt7996_init_wiphy_band(mphy->hw, phy);
-	ret = mt7996_init_tx_queues(mphy->priv,
-				    MT_TXQ_ID(band),
-				    MT7996_TX_RING_SIZE,
-				    MT_TXQ_RING_BASE(band) + hif1_ofs,
-				    wed);
-	if (ret)
-		goto error;
+
+	if (is_mt7996(&dev->mt76) && !dev->hif2 && band == MT_BAND1) {
+		int i;
+
+		for (i = 0; i <= MT_TXQ_PSD; i++)
+			mphy->q_tx[i] = dev->mt76.phys[MT_BAND0]->q_tx[0];
+	} else {
+		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band),
+					    MT7996_TX_RING_SIZE,
+					    MT_TXQ_RING_BASE(band) + hif1_ofs,
+					    wed);
+		if (ret)
+			goto error;
+	}
 
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));

-- 
2.51.0


