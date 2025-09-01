Return-Path: <linux-wireless+bounces-26900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBEB3F029
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890161A87713
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094D272E41;
	Mon,  1 Sep 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOpYCgvf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5E1DDA0E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760308; cv=none; b=V7fWsBqPobaEOMkxHZfyb5PpVCBxLh7qUeVV/z82QOa3y3DnyI6++mrJol5IbFihpqeqX5GgcDy/krODzFcHba6ARExC3rXbil0IZBeSwfjw5jx/yPSeB6v8nWtjAiElesT+Boh9Shv+GLO9vnJTkWQlVGS9IvJ/8VK3dTvxXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760308; c=relaxed/simple;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbxCM+wFKAzbOMQExZi0djWQYkqNpMr+bIgcz/5JvuMOuH2psTkLcBVSva6EWzrgW2Y12sM3TSV4tQNHKPuK8IRsnzQytZgOkA4uiFWoAZmEqUeyBMVPvlbjD8Oy6/C4lU5EKuQeAVby33SG4mkkNiG9dLBgFD6G/c3mR5oQX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOpYCgvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89354C4CEF0;
	Mon,  1 Sep 2025 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760307;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QOpYCgvfSGepSbGpUdTTjQGO67nTfgPMz+YnpSz7rN+eVNw2q+jiKKy8Z3qcSKHI9
	 omRE9CCusBBxyTnckKXEatOoGBWxaAXoLTj/wI0QNbaIRNJ7t4nvOpTwQwnS0vZjoW
	 MSR7O7cfPmJzlil5P6yt3QBJa35+V0Afls60WEK8VwJ1x8RzbVF5QjrBeuWWS3edWu
	 hGmer9G9BjzMNuzMFDndm6IKFw9ZVQCz+fEqv8lYgy5RJH+keDOFu9Qku/cnpFoq50
	 jCTPV7+BoZBWDgYupKwYVeFs+kaWgorUQ6TxRkOJRwbZykBT7mGfwa2maln8CWsR68
	 N/myA5/ytyNUA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 22:57:58 +0200
Subject: [PATCH mt76 v2 02/14] wifi: mt76: Remove q->ndesc check in
 mt76_dma_rx_fill()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-rro-rework-v2-2-1f95086b51d1@kernel.org>
References: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
In-Reply-To: <20250901-mt7996-rro-rework-v2-0-1f95086b51d1@kernel.org>
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


