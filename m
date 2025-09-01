Return-Path: <linux-wireless+bounces-26906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4FB3F02F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 22:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E76B7A5264
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72A275106;
	Mon,  1 Sep 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtMiiqi/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C79274B34
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760323; cv=none; b=YOyeyLKDhdn8R3AcZuGS9vW6K1s+42MIAtgrip+PQc9ITzAL3xK3hdfyVutiNxAs5YTQ422Vzn5MXPG/jLUDn+y5hv/rTTODp8UCEJYTsOwaq2dFKXeoVzxae2OVEtdKqM7UbcoY7CK/VVVCwYz2ODleQEXGvK+Hi4WHaWUsdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760323; c=relaxed/simple;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lu/1LPHVbopqBRBlNk8bPLjdaVAAK8aNrpacGmFo8gujHzcxKCV5jywCKGaYsWB5Yb2779cncjX1YPzwagcNaa0PRdaLaHUBR3ZnDNFy2d6lb60/dVyy4nkCETsdnTVB/m+Zeou9pIvmNYx9fRy5bpl3tGVw6HG1qleHMzmm7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtMiiqi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E5DC4CEF0;
	Mon,  1 Sep 2025 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756760323;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZtMiiqi/k0YkYWbqza5g2kWLIvjtuyhm0IjWzZ2/uLeNfF8cp2u5XI3ySn7WbVkEN
	 QLOJRgDz+1Hzq3jix3h01yFmlmuMuZCHJ4uQ1OIqJyfbp2CSsMmvFcabr/iRUD4vvi
	 JNOYDDFhI/4AAQxC75B18pUSJxNDrpMUDvRt52mK5tip8utiT/P/Zmtq2YzLRlLceL
	 MzuSC+nG1ZR48GJeFQ68aLyZBUEyFRhOD4TUBSoCSPh1E6/ccdQBi7ITAfuZSsl/8r
	 9Lj8cvLFZ1gy7uHSreOTzeEfY4kz2NgRDtKrDXBD7642WBtrXmLY0UWQTKnX63IHpy
	 xHoHgwQLxRTwQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 01 Sep 2025 22:58:04 +0200
Subject: [PATCH mt76 v2 08/14] wifi: mt76: mt7996: Fix RX packets
 configuration for primary WED device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mt7996-rro-rework-v2-8-1f95086b51d1@kernel.org>
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

In order to properly set the number of rx packets for primary WED device
if hif device is available, move hif pointer initialization before
running mt7996_mmio_wed_init routine.

Fixes: 83eafc9251d6d ("wifi: mt76: mt7996: add wed tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 19e99bc1c6c4157fb3c2c1b9ee70ed00a6e28a73..f5ce50056ee94e2915fd189419905acc8cebd853 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -137,6 +137,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mdev = &dev->mt76;
 	mt7996_wfsys_reset(dev);
 	hif2 = mt7996_pci_init_hif2(pdev);
+	dev->hif2 = hif2;
 
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
@@ -161,7 +162,6 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	if (hif2) {
 		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
-		dev->hif2 = hif2;
 
 		ret = mt7996_mmio_wed_init(dev, hif2_dev, true, &hif2_irq);
 		if (ret < 0)

-- 
2.50.1


