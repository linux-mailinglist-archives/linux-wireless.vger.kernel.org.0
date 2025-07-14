Return-Path: <linux-wireless+bounces-25392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E864B04368
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 17:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F14A2091
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681C25E448;
	Mon, 14 Jul 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZHKVqaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B625DB12
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506219; cv=none; b=Gdj+zcGgZrZ3/wYHyyDdcSqdVVlpFza4pIhmjhj4KbSHantTPltPxgRSEZciOn1WyN1VBV6EyBcJGMGCTaVBY/zKRbU4ZLkUCC99dNe7bAU8/u6vJUQ7qOLyh+BP3GEBuFvleg+gC8JuR18M3hW8iIF/Bjz5JGpmqKX1bsIefGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506219; c=relaxed/simple;
	bh=H3mnst5PJ8yNkfvT4AUb7ofM/mh624lIAEQ/llNlbfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+N4RvWPPuwZTpxPo/MmzXZtlhbTKb0RSfj3XgjG38a9rKB3CvC9N4hnIkPx/JEkdQgvjyif0cPbTXl6oTHB6+hRQQ30Zn5NeZG6DQ6wbvYZxjPlzfdJ8BP5eZTozBkAFbeMq2OYI82NRi8FEWE1Q7sSSz5Ydu5t7udtlCxOz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZHKVqaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4579C4CEED;
	Mon, 14 Jul 2025 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506219;
	bh=H3mnst5PJ8yNkfvT4AUb7ofM/mh624lIAEQ/llNlbfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZHKVqaCHe0d7nIOYk/dFqDtpZnNMC+YFG1oTSdbItmc6LOR4F3BAc81YenfeNFmz
	 GvP/BjZia5IVxXcXUTjNYLqFHpAoPJ/mqi8dFf4azH0iqt0aFU539/XpCwIIRhhti8
	 1BbCMjzAEkLmeiOxajnUIOyvcRoIlzih5lP2yZY5QFGmjPAQmWpGFP6+ngYEoR06eO
	 LoB/imSCbNFVWiLWfgLdyJTMooHbABJwi+WDqQpGht/Pci4MdZeQtgSCMS2792Sm9p
	 lG/L1ZCl+wFuZhc3Q9/Eg/+nVwchJWs8sqadjcm3w8RH1z7EWoccg7ghe6foUhzeYu
	 HDghe8dmOxhWw==
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
Subject: [RFC mt76 1/4] wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
Date: Mon, 14 Jul 2025 17:16:19 +0200
Message-ID: <e7f8cda2eafe3bb1c04779f05fc58d52c2838fd9.1752505597.git.lorenzo@kernel.org>
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

This is a preliminary patch to enable traffic forward offloading between
the MT76 NIC and Airoha ethernet one via the Airoha NPU module available
on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 31 ------------------------
 drivers/net/wireless/mediatek/mt76/dma.h | 31 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 87f531297f85..a66cda167374 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -7,37 +7,6 @@
 #include "mt76.h"
 #include "dma.h"
 
-#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
-
-#define Q_READ(_q, _field) ({						\
-	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
-	u32 _val;							\
-	if ((_q)->flags & MT_QFLAG_WED)					\
-		_val = mtk_wed_device_reg_read((_q)->wed,		\
-					       ((_q)->wed_regs +	\
-					        _offset));		\
-	else								\
-		_val = readl(&(_q)->regs->_field);			\
-	_val;								\
-})
-
-#define Q_WRITE(_q, _field, _val)	do {				\
-	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
-	if ((_q)->flags & MT_QFLAG_WED)					\
-		mtk_wed_device_reg_write((_q)->wed,			\
-					 ((_q)->wed_regs + _offset),	\
-					 _val);				\
-	else								\
-		writel(_val, &(_q)->regs->_field);			\
-} while (0)
-
-#else
-
-#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
-#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)
-
-#endif
-
 static struct mt76_txwi_cache *
 mt76_alloc_txwi(struct mt76_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index e3ddc7a83757..982722b2e5a5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -41,6 +41,37 @@
 #define MT_FCE_INFO_LEN			4
 #define MT_RX_RXWI_LEN			32
 
+#if IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED)
+
+#define Q_READ(_q, _field) ({						\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	u32 _val;							\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		_val = mtk_wed_device_reg_read((_q)->wed,		\
+					       ((_q)->wed_regs +	\
+					        _offset));		\
+	else								\
+		_val = readl(&(_q)->regs->_field);			\
+	_val;								\
+})
+
+#define Q_WRITE(_q, _field, _val)	do {				\
+	u32 _offset = offsetof(struct mt76_queue_regs, _field);		\
+	if ((_q)->flags & MT_QFLAG_WED)					\
+		mtk_wed_device_reg_write((_q)->wed,			\
+					 ((_q)->wed_regs + _offset),	\
+					 _val);				\
+	else								\
+		writel(_val, &(_q)->regs->_field);			\
+} while (0)
+
+#else
+
+#define Q_READ(_q, _field)		readl(&(_q)->regs->_field)
+#define Q_WRITE(_q, _field, _val)	writel(_val, &(_q)->regs->_field)
+
+#endif
+
 struct mt76_desc {
 	__le32 buf0;
 	__le32 ctrl;
-- 
2.50.1


