Return-Path: <linux-wireless+bounces-27162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7BB4A8C5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AEC189CC50
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A430F524;
	Tue,  9 Sep 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/KRVVd9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEC30EF88
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411135; cv=none; b=Eu4lI9ynhNRwWPLYzqNBqwrnYEqGsEhpsknHXZYUkv96q1Tjj3fHUtpPzz8XlvV8soycUj/EATSZQMeTFiS4kR7luCSwY+1hkYYlj69HG3i1wSRbrIValIvnsRcyL5bl+US6S+1C0Lk+mOXvohRrz7U1ep9kii43Q57S0kgfVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411135; c=relaxed/simple;
	bh=EBK8k2S6X2KR6Pt+1+kDe2+pVuB1UV/fasFSGIt5wbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFmU0bp2OYwsQ1pcqReO9CMUlWxprysIOQSTLdePFMYFGtQnIOFojpx9yNr4TTSTY8oCSlZZpU+31vQHFhHNxNBvcuzB+QWzTQ5KNz2vYETMFmfPJuHdvo/KYY8kqK5IDdPDuoT86DuIm4kLwj7kcwSiThRLRxhZ6pkfJU0NDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/KRVVd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33471C4CEF5;
	Tue,  9 Sep 2025 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411134;
	bh=EBK8k2S6X2KR6Pt+1+kDe2+pVuB1UV/fasFSGIt5wbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E/KRVVd9W7NVRy24vz4B79UNnmLJjT6/DkBnigViBJ1VIAbzW0XsxHBmK0FUZA5g8
	 0k4cW6jNgWojd8sbqiV3hLbJ8G0inFxrZOcDjCmq2dvd7c+FHoC1Dt/CmGzOfr2tuz
	 2/jjxfZoYqSDlNdesVTcbTA3L5sobEW8jpXtfslZFWGwu6Q4SEtYEMpdKAT4tuLyjO
	 xy3ZMkymGTfpz3o9Q/CbEm1vpGheUxH2rQ0kbK2jYSn9lNqMA7zKVQU6fN3tvd6I9U
	 Rpow4xbdehZ3U/GqiUh0MTp7tOK0cvSYAe0i2Jcl4jmnTI73AcmnFcM3dOwwzNomNO
	 hD6d+8j+W6T/A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:12 +0200
Subject: [PATCH mt76 v5 04/16] wifi: mt76: Do not always enable NAPIs for
 WED RRO queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-4-7d66f6eb7795@kernel.org>
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
2.51.0


