Return-Path: <linux-wireless+bounces-26943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA0B40DBF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C333547C62
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037C33EB17;
	Tue,  2 Sep 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuxYmlWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69F2F83D0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840698; cv=none; b=WiqSjKMs1MRIidGZLLPfx4WH+miX7qvXDhvpDeNJVVoULcivX6mvE6mE8z/yDU3pJWMn8P/A/9A4wlp5myo3Vb83Z9R/79fFRC0vauLyH91OsXEU8+WSxhwO+4EgpbfvyIqcIrlTqasbYNzn8Kg2lpwIcPzxK+DOuanoZBHvm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840698; c=relaxed/simple;
	bh=jtgRLf0FRRSizIapqgfH1YFeyTX28uqo02yIy46q7Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1mtHTTYHK+nV39GMdj5SRNCSvVOhVuI4BKbnRy5yhjPUun7TXklc3GKIEko541cMrO1HHd60TImfUN5jbY0ftixMH489mJ+2RNSxH4mWYauY5joYoVJs9z326UVCugNNa8WSV6BJPitAwBrEaU8KOO2r4gHoI+TsoI3dLJvr/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuxYmlWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE36C4CEED;
	Tue,  2 Sep 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840698;
	bh=jtgRLf0FRRSizIapqgfH1YFeyTX28uqo02yIy46q7Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nuxYmlWGRH7w9WvT0rhVg9y8/iR0d2ac2YOcCxERdFEjgSVol5JNMoHznQSBrtsvJ
	 bkeoQIYadceH9fKZGdOvW5KdVd2cu/4k7xH24NLX+yKi/hJd14VTbBbQBA57z5kSTl
	 SepTnIoLL5NJOzwAEghxbledxFHN7cNLvZ//El0wnFwX9yYtfDnim7D5/wW0d5BJEz
	 274kYdmN0ohhrFbMNsZAT72P+cQXltDPTotIz2sYhxFhaZPjW2/9UHESYJHN3BdoMn
	 Pd2an0k39kTzP9cvsPZaLgn5Hn7vJ3k+dbkwymqT4n8DWp2BNsCvHkR4d5e4gRZZjO
	 /Yte6+8xvSnQw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Sep 2025 21:17:54 +0200
Subject: [PATCH mt76 v3 04/15] wifi: mt76: Do not always enable NAPIs for
 WED RRO queues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-mt7996-rro-rework-v3-4-8f813890959e@kernel.org>
References: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
In-Reply-To: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
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


