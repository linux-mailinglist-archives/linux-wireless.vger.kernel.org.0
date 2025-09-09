Return-Path: <linux-wireless+bounces-27160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC6B4A8C3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EB188DF19
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDC30C631;
	Tue,  9 Sep 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0g7Ih2+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8182D0C8B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411129; cv=none; b=d1v/h0ZrthuvUvOjlMjoS2Qm+Sc0cqjV1xdqzaZ3ja1kJPHFi66VBoJC7klb6LTQ22JrMo9+wUBCREsRXhE/DSoZdgIwmKgbQAWloxPLVWQuUS9HCehFi1rK+EKVfhGshydaxRuo90R8UxKjlVTX17TIkUfIyAU/wRaUVD3WnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411129; c=relaxed/simple;
	bh=Jp5wZrmPG3Ay7WaTm/T/7P4Kr9YN5jTWdIuMkNr5b/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3iX/WDbzzXJ01BosXBjgiFoEtyqJcjc+yM6KeRtVdzpOOn23qhiiWKqDaDmlZNdA4zhMAhfPqrj5S//ZZ8JAnydN8LcwM88ijE3kLPMnCeO6zxnzn76bH+pahOL853Q1TmAlA1FpZngVLfnIZjI4icDho2DFbCna0D9MYX3tcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0g7Ih2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E483AC4CEF4;
	Tue,  9 Sep 2025 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411129;
	bh=Jp5wZrmPG3Ay7WaTm/T/7P4Kr9YN5jTWdIuMkNr5b/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e0g7Ih2+8FHHLbL9Ra0lwCbT7tWWUlbMWoKNEWSmUMaTtsmEZJ8+WWm+9xW/OuSOW
	 u/DenXPbBMT2i5GV0kEVwn86vDpx4Q0qVLRk81g6AHN8uESqyxzBVscKL4NcrYx9dB
	 FS1IcC3ac1vc0P1k16Te41ymP0Xs0sDKYxQJnsCLJ7djIGmCbdML+eTh4rVnSI3ucS
	 NtuvEdQ49lzh4DkxLeeNwHBmq7btBbgRSDfUHCg5hcHOjpZsp55eCscUhzeu9BbUWS
	 lBGw3HVZYCAivaKA5uDaf4kwMO0d4sVmyNQAmXBWcJ/gkowruNZ1kBeRSxIwe0nNso
	 /Lb4MdxHEK5tA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:10 +0200
Subject: [PATCH mt76 v5 02/16] wifi: mt76: Remove q->ndesc check in
 mt76_dma_rx_fill()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-2-7d66f6eb7795@kernel.org>
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
2.51.0


