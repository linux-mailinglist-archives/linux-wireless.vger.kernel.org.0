Return-Path: <linux-wireless+bounces-24824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F648AF93AA
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF551883E87
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEC2D63E8;
	Fri,  4 Jul 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmrnlXC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68B38DDB
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634520; cv=none; b=k1Ukhbo4diI5d+DnVX1eqzPHjgnEXqztRFWIAB2ue3TU5nw5IVchguwdPCoyUFbdmWJo7epB88p7hi9pNftueNmJDNpx6zQoVDqldt5Y2sNsCaDDan/hOVna7ZE7b6LqBRSQnmHaaTKGDSW5AbfF+YjLs2gW8HuXRZ6VwHIQWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634520; c=relaxed/simple;
	bh=xmmgkhOPdCsWqSjAy5GTYM9jvYGbAUUkSpjcX1s/OSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiQaOAseAcUpGAW0awAQrWU29h7ouZKxp455vxF//r8YGkgs6QuYL2N02QD9MA1bVKbKkAeGpNMJZvphxd8pVOsItgNMHJ1l88YdWz0fqWZSBMqiqWaxEwRJaWgTcMwUf9xATjxkZ5ZiPBOLQ+TZQYI6MRFrJcxHtka7yaSlVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmrnlXC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490BEC4CEE3;
	Fri,  4 Jul 2025 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751634517;
	bh=xmmgkhOPdCsWqSjAy5GTYM9jvYGbAUUkSpjcX1s/OSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dmrnlXC7ahhj3kDevkJ8gOZkG8ke2rnFdOuDCXkCP/R3rVv9F7H3YmGC/CWCogpWo
	 pCGvIiiXYrReHsfsMsm79I0Vns6o+adslhypGlc8BR2UvjvfKwcImgdcpUle4E+gZ1
	 pGmXW0it45pUTv/HZL+10lsNztGurBN/GOhOB9YsAgpFQPSdJjxbKjGambxlZAZRFu
	 aPuDp3pAw2Bea1YoM/L9ck6PUSNA7hWQjqn/UTcy1eoM6Lig7ALeeVgIXP7pSbIIWx
	 onA4fQyqYQZ9/feTDg/lM4u8g637re+OCELS8BseyLtTVOMhBvoxuOmapZtRw2Welu
	 ZQkeovx3UgNUA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Jul 2025 15:08:09 +0200
Subject: [PATCH mt76 5/9] wifi: mt76: mt7996: Fix mlink lookup in
 mt7996_tx_prepare_skb
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-mt7996-mlo-fixes-v1-5-356456c73f43@kernel.org>
References: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
In-Reply-To: <20250704-mt7996-mlo-fixes-v1-0-356456c73f43@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Use proper link_id in mt7996_tx_prepare_skb routine for mlink lookup.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0dbd4662bc842947abf09f9ae3aa4a1d4b86cba8..0844f27b8458fe53c0765ece70fe91acdfc6510a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1087,9 +1087,9 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		if (wcid->offchannel)
 			mlink = rcu_dereference(mvif->mt76.offchannel_link);
 		if (!mlink)
-			mlink = &mvif->deflink.mt76;
+			mlink = rcu_dereference(mvif->mt76.link[wcid->link_id]);
 
-		txp->fw.bss_idx = mlink->idx;
+		txp->fw.bss_idx = mlink ? mlink->idx : mvif->deflink.mt76.idx;
 	}
 
 	txp->fw.token = cpu_to_le16(id);

-- 
2.50.0


