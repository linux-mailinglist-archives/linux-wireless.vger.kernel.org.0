Return-Path: <linux-wireless+bounces-25393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C018FB0434F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8317ACA0A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2C25DB12;
	Mon, 14 Jul 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLBWD7eM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3125F97A
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506222; cv=none; b=eWIczhgfyrOybhOnU9DquEY6+L1ZgmPIfSdOw5Mjxhzf37y431zwkmbc/JVghLYvArSx35/AchFrExwFsla80NYyVyOzlN+E88cmvW898idU4JPNgKRStzNaxzRfdQDBM1h/JWSeeyA0plQAGxJ+dGp4VRwIfmnu/PCM1w0+l/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506222; c=relaxed/simple;
	bh=ehhPScnBu/pFnDquLo0e3popXPH+ZYkTYjeUsGCcKDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcwoJIs/CHmUOtXr6JRR7OwPlK9d3NFpnDITtnfszitM3zWdB40+qj0DLdOZxwh6UGtmaXHMaLdyhKdw8ZOSSoMmfR6N4Fy9EbUSddTPE/ySL8z9BfzTZTIkOz7Ri9XLXD4Pb35wCYEz2l1juuWLcfogSd5kGZqEaKpYrOK8H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLBWD7eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7927C4CEF6;
	Mon, 14 Jul 2025 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506222;
	bh=ehhPScnBu/pFnDquLo0e3popXPH+ZYkTYjeUsGCcKDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLBWD7eM8rXUMq/WbFTynjwhv2j5xubJF4BCj3r639RoDUFNeAefpKx88r7Q72Z2b
	 xvEfFUS56TPCQzDzNf/qz7a7lWNWkafYyEh6qg6DapIVS9PVwyhtxBkC1F/h84Bgze
	 imXxFZKfCIh0GtrneXVGE7tq5Dfdal8BDu6PTM7xpcGZf7A59U1Lz/yz0T3M9maqf4
	 JHMvjkFoPrD7wvzfgf0UQYo0h4JN8PvA+liRPaLC4WyHPBQkrNAmZN12FTPlufZH7r
	 /pY59Fcmr7aF/NT27HC5+29ZjoGuYWP/D+gLbhzcwcJpCv3UICebyM8dk6raegNKF4
	 InQ0m3hnNwHxQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	krzk@kernel.org,
	lorenzo@kernel.org,
	horms@kernel.org
Subject: [RFC mt76 2/4] wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
Date: Mon, 14 Jul 2025 17:16:20 +0200
Message-ID: <3136109fae513b224587bf84de841735c09bce03.1752505597.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752505597.git.lorenzo@kernel.org>
References: <cover.1752505597.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preliminary patch to enable traffic forward offloading via the
Airoha NPU module available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index a66cda167374..48e5c4e98937 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -669,6 +669,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->ndesc = n_desc;
 	q->buf_size = bufsize;
 	q->hw_idx = idx;
+	q->dev = dev;
 
 	size = mt76_queue_is_wed_rro_ind(q) ? sizeof(struct mt76_wed_rro_desc)
 					    : sizeof(struct mt76_desc);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2912568612bc..db37de583709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -234,6 +234,7 @@ struct mt76_queue {
 	u16 flags;
 
 	struct mtk_wed_device *wed;
+	struct mt76_dev *dev;
 	u32 wed_regs;
 
 	dma_addr_t desc_dma;
-- 
2.50.1


