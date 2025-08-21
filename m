Return-Path: <linux-wireless+bounces-26519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA64B2FA3D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DB562181E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5C3314CA;
	Thu, 21 Aug 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0W+/UVm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CB3277BD
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782218; cv=none; b=Go7fXd6Gy5XxYXh46QJl8DoU+XVa5G+38Zid3zIXnYX3XNslcXriG/Aw9NS+tFxMqxpxHjmv6c76DfTNUyXvmjqd9ZljouA2+2jQ63NPymOnsmRAkrZknNulJVQ8DPZ5xyc37siDY3Bl9eTERKWELcy+nlRBYaq5iqOjahZAjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782218; c=relaxed/simple;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xxol8V6c4F1MxDaRfgrOj9zGWSzTq3Z1PoyYwhpAIWRnDNy2+EYR3oK4TPzbHnX/yvTqRBXQ8nqvGaYmixyckhhfiWZwBI3L4nE5kERcckbirhChwoTCpwo4j28oDI33SFMgcoN5XHtejtlNmSKMCfQBQn64RchB6MyQznf6qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0W+/UVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2B1C19421;
	Thu, 21 Aug 2025 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782218;
	bh=MFLQY/3DGbD2c7bfFL0UAO+xBUCRpSIBXkqsHYgalMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T0W+/UVmWuPKjmne48qcUHTCFqmOaWTNzEymiVNdPJNB6Z6wJ9vUHXdWBMYSsK8O8
	 AguHNa9mGIGRkOYiDn1LVSIxWmFMCtvzJsKtakHiR4TEHSrIbRgH3dPRrVz2AlfdOk
	 asbxqS7lsTjidCnTlhCsDmQAEHbSk4SOIMFiqGACXnlce9ump2PjnRJdfFQclGPP9y
	 64a1vINKAZ7al6xu7Xemm797u+QmCzS2+UqCheDEu7jbR0ERAU1sQqv9NpW1Sayu0o
	 v2//+xvlnKZyeDP5xBUTbdvMI8KttckWvGoPSCxMUQFBe0l8GeEqcCUxxcnmE7/bjT
	 FJsZV9UZwu88w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:15:00 +0200
Subject: [PATCH mt76 08/14] wifi: mt76: mt7996: Fix RX packets
 configuration for primary WED device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-8-6c8477ad969f@kernel.org>
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


