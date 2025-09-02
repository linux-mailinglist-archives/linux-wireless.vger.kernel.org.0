Return-Path: <linux-wireless+bounces-26948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6045B40DC4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6E5547D86
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 19:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3533EB17;
	Tue,  2 Sep 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT33Y4td"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847720C038
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840711; cv=none; b=Ei0qZo14VvUG7KiUaNWln/ubYrfwW6pNP5MBHacEw7+8D25mreTSVYC/SIvnXra6a7sEhiB7kdXRFVG+jBADq1vDQ5gbDyl9n+tKpEm8Q8zXp6o/EBKh3zCc7h/6Px+HxXMOVlwRJhGUMSKlnA1NfzGdOv1C8dIc4qg8yCqegTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840711; c=relaxed/simple;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzfFF0r+q2XuzLIxDzdsUT1d26iWulElA+94isF+xwxd1W6ZuKtuJJpkKVzXBCsUUFlIFEtGISPr9WEF4FxGw0WtRpr7H1zNrTmVaIlkxV2B/H8fZ/x9sjuBEfzbillykUlxiqrzFilwgfG1Uflm3dGxmfgrldSYpYM43SJJbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT33Y4td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C144C4CEED;
	Tue,  2 Sep 2025 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840711;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cT33Y4td/U+q9z8KfGp7ejLVtlQ3GF+JT/JPonNoCs++TpyQZ2T4+El/zxnAOrDNE
	 lHjPfpIfsH5kiV3KYQc6ghvWsKBAaehQrbKA0HL3NliFWTT/5UEes1XZjB0QflN5F9
	 xAKV2163+7qsf5d2wUXTBfCSNa+FEmF/HFiOX5XwJd2PJo1jJsw5sTit+zQBc/UktU
	 veXrpzV/bqw8O1ZtaaO67WAO8k+7w14boPhb7XZBCwRBM3o9Mu6hRd6uFvJOtjVW0V
	 w7mPLoCjr4NbolJVZM/k8wJLuu2K2ANbVcz6MmJx+5QrtXiVD5SKEBVdWjQGeg8JVz
	 5N1o0K9dy1GHA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Sep 2025 21:17:59 +0200
Subject: [PATCH mt76 v3 09/15] wifi: mt76: mt7996: Fix RX packets
 configuration for primary WED device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-mt7996-rro-rework-v3-9-8f813890959e@kernel.org>
References: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
In-Reply-To: <20250902-mt7996-rro-rework-v3-0-8f813890959e@kernel.org>
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


