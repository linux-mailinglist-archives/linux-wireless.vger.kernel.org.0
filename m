Return-Path: <linux-wireless+bounces-27018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B6B44300
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF541CC159E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267672D47EB;
	Thu,  4 Sep 2025 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnsNh7VM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020462D12EA
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003910; cv=none; b=Nq5wmEdLbMlJ7mz6IkQO6/VqayYLMCoJgYRA6rfHu54EZDRdp87Y7J8KMwLlkKdgFjVAiD34KyKO1ffnWkCvlYuyLXpVWQiD25c7irXEgh0yBEOkfFX4rvLxDqSb/odf10OJ4Vf9F9doIOkhrW03mlxhNj0DbF2DqUv32cSg7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003910; c=relaxed/simple;
	bh=jtgRLf0FRRSizIapqgfH1YFeyTX28uqo02yIy46q7Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m99ZcSI2OG0gD3Y5NXEeM2BB7H+zLqqBN/P2DcKKNm/I5bwbrHvY5MkQx0sAxikCBGPWpbPnwbiooIMhg6hEvGcOcBEdU2gzVGMPQsGp2q/P39sxysox4MPm1hK6xjHcNlfPtDTTB4BzBmdtKSBe5SjoRC/fEj1cgWuNcdNrRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnsNh7VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D2EC4CEF1;
	Thu,  4 Sep 2025 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003908;
	bh=jtgRLf0FRRSizIapqgfH1YFeyTX28uqo02yIy46q7Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnsNh7VMJZzaYGqHuQqdkPobXeL19Tu7b2Lm8MCbusSaOU2CkGRdFAfNoX/ut3QpN
	 YzbVuu3BhkbPHY0McN5WeuhnhoZkMlKMwrJqYuH4maqd847Us/unbd7bVzRQ+h6xW8
	 1iUZZog+Vao9A+JdN3EHZQ8rrNeo+6BSV6rRYTJqyvCbNC55942BadG7QXTbqPDnT5
	 yy8cDbixT038l/I5G+fMm4DA8bBKwN5SquObq7iQMJzKOk47t+nZBELoOv9Znn/AXK
	 NjAqSGZEd6isRDrOceT5dr1pKfLST/QCeCiXn5H/t38unDwIuhcvuQu5tfHr80UA2x
	 qTrEwZAzDgB8w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:37:58 +0200
Subject: [PATCH mt76 v4 04/15] wifi: mt76: Do not always enable NAPIs for
 WED RRO queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-4-2cd91e7229d6@kernel.org>
References: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
In-Reply-To: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Do not initialize NAPIs for WED RRO queues if WED is active.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 68b1dd1dbbe0e2b4850e02ee70253b5e248c69bf..f882b4e10858a233a5422ede80d79c21965136e9 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -967,6 +967,10 @@ mt76_dma_init(struct mt76_dev *dev,
 	init_completion(&dev->mmio.wed_reset_complete);
 
 	mt76_for_each_q_rx(dev, i) {
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    mt76_queue_is_wed_rro(&dev->q_rx[i]))
+			continue;
+
 		netif_napi_add(dev->napi_dev, &dev->napi[i], poll);
 		mt76_dma_rx_fill_buf(dev, &dev->q_rx[i], false);
 		napi_enable(&dev->napi[i]);

-- 
2.50.1


