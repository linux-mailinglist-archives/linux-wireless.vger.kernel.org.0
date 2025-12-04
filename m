Return-Path: <linux-wireless+bounces-29495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B3CA2C30
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A30383007775
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A9279DC0;
	Thu,  4 Dec 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgt3/Ld7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BE1DF25F
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835902; cv=none; b=F/fEra/ThaGLYCLKXfxWElOmNzGbMlhL81VTxfQ9cjE+rg9NTKg19bkZkveM7xasciML4smESR9gCtCqdQq6hSaa/V/74TaTPjIWLW2FP/yi57R05bhCLHoiX6yPtD7jhRmxh/dmcao87bvegLE8PeqBnzT2IiMSqzCWXQXmu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835902; c=relaxed/simple;
	bh=u93GlNGVtfbcwxz+yLwcIQ5xn1Ynxqrvt18EqeLQzgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twOT5B+Ls+eec/Q2f8AVY+Gdl080UC30R6a9O5zb7cvlOk/xHamw4mh6H7w7HZt2v8PWJP1Rf0k+WeLQrDeYJChjrXmGX4XljOJtbrlJULhizIy5rcx0/f8FBA86QOG3TU89uE+S7+1QkqQgQHtiSEv5sv/pLuOclj82CYzX/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgt3/Ld7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EFDC16AAE;
	Thu,  4 Dec 2025 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835902;
	bh=u93GlNGVtfbcwxz+yLwcIQ5xn1Ynxqrvt18EqeLQzgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wgt3/Ld7dVsUZFMPeTl6QPQpobSdRbQNpr+mtWIzfvYILT4lDL63cX7pXs3/qrKRh
	 xXmeyQxq6phxV1/y6mtQeSCAOaBic8fVc512iHBJoxShh9PE4cE31/vccuv37JD/pn
	 vkvfNNBrg4a3E5oMIRHfUbFGfBUv+fyOPz/sLI0bg1wRicztLCbulN9WrokZdO7mAG
	 nF2s0t4suSLwXwErT5eQYvI7UNGx1mHMLLA7sP48d0pWHp3YB8DUEf3nPD4PSCm37a
	 OfzA/Ae3dfXjuAQQ7GXn632EuBk6rtYgcvtJ0vAxp3KxiQhIwKSf0k95k8XeTxlkuO
	 Ykj6y8844sVuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:49 +0100
Subject: [PATCH mt76 07/11] wifi: mt76: mt7996: Rename
 mt7996_npu_rxd_init() in mt7992_npu_rxd_init()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-7-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index d79f8dfbd7faa7695ea54b632ac86063fa8ffe3a..a9569278f73bf83454a0357e93602837c6ccaa86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -122,7 +122,7 @@ static int mt7996_npu_offload_init(struct mt7996_dev *dev,
 	return 0;
 }
 
-static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
+static int mt7992_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 {
 	u32 val;
 	int err;
@@ -304,7 +304,7 @@ int mt7996_npu_hw_init(struct mt7996_dev *dev)
 	if (err)
 		goto unlock;
 
-	err = mt7996_npu_rxd_init(dev, npu);
+	err = mt7992_npu_rxd_init(dev, npu);
 	if (err)
 		goto unlock;
 

-- 
2.52.0


