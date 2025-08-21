Return-Path: <linux-wireless+bounces-26513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05531B2FA20
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C39A3BFCBB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9497334717;
	Thu, 21 Aug 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puWzSoEp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF532A3DE
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782193; cv=none; b=I64TO4iyeOnkYS/d8elH66uJwlBfJEE4S9IPBKWzonW6wxybZkoa3gCfhZ1TDYiLwW4Qksxcky0nXKRp5+e4YfDoq4Vak28AoRB9GhZbMvLKazDWcu/V4ZnH5rSo1lZqEszTOFn+YWlm4QdN5SjPUup28cGqG6Gf/yJ0e8nvvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782193; c=relaxed/simple;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aN8G3ASGjvVAxm6W8cWNHZwm5zaS8rpFoVK3ZbQIVIje0yR5hUjd3kjAO4Zs2QHaK+tZ6I4MMAA8CQQvhkdKCYuXItE7wLoToYL12wkM5NxMzNjIwjC6Z4HKLXdN8iBVK7O6m7EfP+GDGhQC4c/XatZr5qkLXH5GsxAQCLb3rXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puWzSoEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6A8C4CEED;
	Thu, 21 Aug 2025 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782193;
	bh=W6N68IbV0jiwtH3MAFqH+TY6TjH35pe5n2zoPQK40aQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=puWzSoEpl5txlQgwkEJ+M1z2g/8hLX3dy1x+tFqG+fnLrzJWbyYpACswAVVLECW1C
	 TwOgeF02ptbWNJgxQIiFA99AR3L6y3TX2AxTUmNS1yH8kjoprPdALFxWNngZA8giHh
	 3f4Lv4y2ifDG1ZKD1M4kJwTVC2bbRc0QER8FE5HJuAXXL3gryrF07HHQIO9kRMWz6x
	 a1o0tYlKUDpKIkp1hQqzF5Lg20laqcfpicPHj5zHYdMJCh+4i4I3r0Rf3EqypKiCUk
	 h5SQfDjPAaua5wBKkgO+Fmj/71E2cEjsm2c7jAUpoO+cQrpgmj0MSxRjtC1QYfseYf
	 uXFLjs27W1QCA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:14:54 +0200
Subject: [PATCH mt76 02/14] wifi: mt76: Remove q->ndesc check in
 mt76_dma_rx_fill()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-2-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
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


