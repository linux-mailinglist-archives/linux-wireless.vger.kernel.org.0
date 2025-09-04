Return-Path: <linux-wireless+bounces-27016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA142B442FD
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA66F1C867C2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C9260580;
	Thu,  4 Sep 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE9RSFVX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18F23D7C7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003903; cv=none; b=VJkp7Pi6I4EDAZh+9FY0pywRPrQE3Gw1whVxrNVHWIp0MBErL+pHsyvXM4A3TaPD7aA7rNrJgd8hvYYb4eiXPRI9eXasPJjeqvbnrIlMY1bjdcy6BVlOpM6vsp5Y7XVYg96fFUnos+uiM7iKRNWjIgQp6rqJNGhamRkUKjnl01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003903; c=relaxed/simple;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcmL9DArpOlwXSVEbP20dSACBS5dxkxiZSu0ZvbkNVuWI1KC//inn/jn0hJs4ZTiScApheG4S8xgUBtVNriOSpW5cbuxWnx0Jq48DOv6LKAmEZBXQ2ItSVlBSjAFaEtHV5fIeyU7uHAN/Y6nG4XMQm+wszS593xBb3+ZxVyfZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE9RSFVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D22C4CEF0;
	Thu,  4 Sep 2025 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003903;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gE9RSFVXYTyMFHQJ0RSW6u7hHNfokidemYDegKmlp5QjvT0AMrfY/4YYh6D8D8vU0
	 /raqehO76RgY0pgwrL3cIbYt4DTt98PcmtR7o2TI3JBUyfKSyicMMm7xcI7W3dc0Qn
	 lEm/Ixjg4Sk7OlqhSC6oV2+yWMQ3ThklFAnXq8qK1GhA1klwGH48MlhFd2KZNFvzT7
	 YdO2a0sZKuwA5BB/lCL4+jmFtUoUGkS8aMSR1tIab0TEuIaLHYomrDLWArbS3NYxuD
	 CuZ3qWJ7tGMqYgqo2Zxme521koxLXaTSTgE0hQOduhR1WceXZsuMkqM1LeluQlS4iW
	 1gYOS2GaTvAvg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:37:56 +0200
Subject: [PATCH mt76 v4 02/15] wifi: mt76: Remove q->ndesc check in
 mt76_dma_rx_fill()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-2-2cd91e7229d6@kernel.org>
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

Remove q->ndesc check in mt76_dma_rx_fill routine since this is already
done in mt76_dma_rx_fill_buf().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 25c26ff8c8e24352f2bb31c6e185e628a56f609b..18c2a2de59897d038392a00ed5fb5a0de188ac95 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -671,9 +671,6 @@ int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 {
 	int frames;
 
-	if (!q->ndesc)
-		return 0;
-
 	spin_lock_bh(&q->lock);
 	frames = mt76_dma_rx_fill_buf(dev, q, allow_direct);
 	spin_unlock_bh(&q->lock);

-- 
2.50.1


