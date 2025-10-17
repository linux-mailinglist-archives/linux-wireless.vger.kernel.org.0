Return-Path: <linux-wireless+bounces-28019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA950BE74BA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0841E563D5B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE4E2BD02A;
	Fri, 17 Oct 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnIae8sq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804825F984
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691059; cv=none; b=GNSRoVlhogfQz1iParCZs4uDy/p3WQr1e2nRVJIIO4miROXhaV5p3gi4mwdk5bfYfc9FkEnpMP5lMaFwouZxeUE/hGZgq/kM1s01uss8qPkkfTMakQ6iNIerS+C3ubyqEaNNK3dcQI4mgteASCVnrNz7a+B7yOIQ/6+BgfryiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691059; c=relaxed/simple;
	bh=SvzJNk+DqsvUzhRIiCdh9c4/NM7yKR2xIHNC6vUjOLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbQO25zOAjM1NdClQ9VxY+uHncsEZMhOV6pAdHoqt1pGelvNRF3J/JLjDGWfQjDqTKpLMF7HN9oKGv8ARelZ4lrozadbxRTY1QYXpbHl9FMFzNEfOmV0PLljk2ro0c00hsncuXGqzfY5yY4e2b30MBjocdpIub5OZET/nRnJuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnIae8sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F1C4CEE7;
	Fri, 17 Oct 2025 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691059;
	bh=SvzJNk+DqsvUzhRIiCdh9c4/NM7yKR2xIHNC6vUjOLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TnIae8sq/IBlZzHRCHOLf+FL5lBZYiEzRrvgxY41PvR7eSxm+ufAVeIMVeyLPoBNk
	 vGF0bU6kB+gRZjB0inw+uXcjKuwCGZel5hKwqIlJNyMDqxkPJPOvCwy8oIylQRRDYo
	 LQPr+KWw+1cdm8x1NlSEBB98J2auhDV36FWn4+ducA7m0LabjuNXSZueiUNY9wCdy/
	 3Fp7YPMm5qdZgZhH5USRUbyc4JW2qMf0lamDGfh0QpQistWKmxZj8+8q+n3lSPhUJa
	 FbcTmjQ4TkmyH7eabQt8HDX1TmQHpVNXTSL9m8BGtYWhJ0iOIvU/w9UjbbKCCTstRg
	 h/YC7bBTdVq+Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 10:50:31 +0200
Subject: [PATCH mt76 v2 3/5] wifi: mt76: Add the capability to set TX token
 start ID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mt76-npu-devel-v2-3-ddaa90901723@kernel.org>
References: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
In-Reply-To: <20251017-mt76-npu-devel-v2-0-ddaa90901723@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable traffic forward offloading via the
Airoha NPU module available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 drivers/net/wireless/mediatek/mt76/tx.c   | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b0ff65427088128a6a83557b195f0e98aa012b32..a66b89bc4b4a5b9a4a8a21a0fea6c465d34ce552 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -944,6 +944,7 @@ struct mt76_dev {
 	struct idr token;
 	u16 wed_token_count;
 	u16 token_count;
+	u16 token_start;
 	u16 token_size;
 
 	spinlock_t rx_token_lock;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index b09b7dfab4169357901a001f89d16be64811044f..9ec6d0b53a84ad73472e6f4fbe9672753d43b9c1 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -847,8 +847,10 @@ int mt76_token_consume(struct mt76_dev *dev, struct mt76_txwi_cache **ptxwi)
 
 	spin_lock_bh(&dev->token_lock);
 
-	token = idr_alloc(&dev->token, *ptxwi, 0, dev->token_size, GFP_ATOMIC);
-	if (token >= 0)
+	token = idr_alloc(&dev->token, *ptxwi, dev->token_start,
+			  dev->token_start + dev->token_size,
+			  GFP_ATOMIC);
+	if (token >= dev->token_start)
 		dev->token_count++;
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED

-- 
2.51.0


