Return-Path: <linux-wireless+bounces-27883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25827BC4645
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A57C4EEC7C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009872571DA;
	Wed,  8 Oct 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAeJ7Y5G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06102F5A1C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920142; cv=none; b=iaEyWhozo7OcaSztcuuF8SiLhng+yBFLn07nFQAKE44km1JcrRKzxh+OMx+kkgb1AVi9gTX+/SqLJJHaS66vaC1iSUwQRchFPG7p4JKJ60pEjs5Teul1bGhQl7329lDtBpMqniBKI5hkqdob3amhYyAvsPoAvhX+V3w5Y7nFvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920142; c=relaxed/simple;
	bh=rm5wdK2uJNnErMUOf4H7M2S9QIT0yFPobsLvDwKPFgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LER93wYTF36HcVCSsDKxAPgUWJb4jYG0YORwZTiNvI4QD8r1IG3iurXGAlQgzFWskYL4xLlcBdJs38+U5/Fuj264TOpIfBDn4aZaR4bzv7WgLsIjmBoreJeWBS09MLM03hYQ4V3/J5Gk2NlWPSAqeNr2QRISAJqu873jzN7qngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAeJ7Y5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02499C113D0;
	Wed,  8 Oct 2025 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759920142;
	bh=rm5wdK2uJNnErMUOf4H7M2S9QIT0yFPobsLvDwKPFgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WAeJ7Y5GNB4E4Y1VCg1NEphRXbA6Rs/sRnHaxI1qP0Q+mXg1gZEh0zoNDP2j88f1b
	 7jaBLtOVa5+q5H92c8wgVH+8NTbqaPadVJE1+AJcD8ymZbzgkcb3ycagf0sK2IcDq5
	 YjraSm+orTRtElVRLiQkCj8aNFjUvotXk51fIMrk7amhemiSx2o+6w8tcA41dhetVP
	 XWmEhb28SKhRkoodDG/0LpUrTzhUVMGO6RQfs2sVpPTvRje/l+IbBYNpI+sbT/ZFLb
	 NRIxS7kP56B7oPK8ngBvVFNe3wdmTjYihVk5gcZf+KAnrNfgXw7JzHlrMjk0ZKm1ex
	 n3A6jImSzI/Tg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Oct 2025 12:41:49 +0200
Subject: [PATCH mt76 2/2] wifi: mt76: use GFP_DMA32 for page_pool buffer
 allocation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-wed-fixes-v1-2-8f7678583385@kernel.org>
References: <20251008-wed-fixes-v1-0-8f7678583385@kernel.org>
In-Reply-To: <20251008-wed-fixes-v1-0-8f7678583385@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Daniel Pawlik <pawlik.dan@gmail.com>, Matteo Croce <teknoraver@meta.com>
X-Mailer: b4 0.14.2

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set GFP_DMA32 flag for page_pool buffers allocation since the hw relies
on 32-bit DMA addresses for WED offloading.

Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
Tested-by: Matteo Croce <teknoraver@meta.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7753afa3d883d6c7104bbb68d1d61b562e828ac5..aed5dc347ab11903ed34ac33bc20dea63a9e926c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1869,7 +1869,8 @@ mt76_get_page_pool_buf(struct mt76_queue *q, u32 *offset, u32 size)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_frag(q->page_pool, offset, size);
+	page = page_pool_alloc_frag(q->page_pool, offset, size,
+				    GFP_ATOMIC | __GFP_NOWARN | GFP_DMA32);
 	if (!page)
 		return NULL;
 

-- 
2.51.0


