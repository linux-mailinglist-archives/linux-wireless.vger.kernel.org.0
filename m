Return-Path: <linux-wireless+bounces-29600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE7CADE5B
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 347063051167
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24E321420;
	Mon,  8 Dec 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGUMTOpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD0320CD6
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214621; cv=none; b=B+hMUT/CDWBLnFdYPn/95fy4jDMkWjAtZTJXy0zq6uOgvVZWa+c/4R4GKSxsHexT58npixQJFnqh6Jm3pbTkWTmM5l7QEkI3TqthVhEAnnVq8tmSUT2OANGPZg467wQMYJEwAx/qKBUo7p9Vg6BzqgZpUkcF1XQUw8N22NATwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214621; c=relaxed/simple;
	bh=1zqi7IkyiQmGQtW4fxzCdlaX9sD5CxjoxU2e6jjcli0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tX93rznorbsh8e2sf0ysXWHrWoar9BTPga2HR7G4UomP5G3OsM+ipnNRgq7/nQFPtswsyUwxJM2yeQj2FuxC0l92KUP16D5q7OtBMiK6mybDKwNo6sC1tLGiAazk+Vjue9daQ2JP/bp1Shzd6jCnRsh9GQlV01UhyNTH96PDefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGUMTOpi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ba49f92362so2607033b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 09:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765214619; x=1765819419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PgfWpyXRTYw7pqOmQBjZJ0wQoN6AGdnNEKUvt/DRi4=;
        b=RGUMTOpiWrWr3L1Z0+oJkq/2/HVa1eUtr5ShGXeTL8KXVigaCtelzeuVz4+pcJf803
         1zjzSSW47b4fBvJMdiTETiCF8sIzTbWmfQldLjCIxc2Q7I7ydgltahh0y/72oq8yzOFM
         vBsWlpXhclxgB/ckyGmzf9uEMAwmoSl8Of8X5ffIMqS7Scdh/jVNoAVPDjKiHyiHnAZ9
         roHtrt1uKcyL/oYhFgUdE4g7tU6IWJ49SEA0J0zt+soQ49unK6bSzOwKP1+vSP1mtXxR
         jfxl9YaYcRN8mMD4fMFHlQi+E0iXb2Jy5VfTkRY8IfQvDoAppYBwpOOrXiXWT7Y5v6HM
         +nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765214619; x=1765819419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PgfWpyXRTYw7pqOmQBjZJ0wQoN6AGdnNEKUvt/DRi4=;
        b=v0Ch90u0B3ALSdfJFJ2jn7y4+gKlI5ZWVKkSpkB7H//pXn75jWVhGgLGC0RFkTmu2Z
         b6r2+exr7JBEF5QdrOGph3prVkNYje1mfIhE+bpgldfLP5T+3xe0pm3Uz2oZXFDFKa/m
         IgGRWBpEc19m6XHzDe7sTYtijFhMKrAhdw2Q5rjBLhsYlrvMOr9gcHNgouofsPR3G8vo
         3MRGwqEfPL/x41peQ0fasQ+UhOcGQUyVfh7Ci0vna6BQFG07htA1Vcln8RFS5POd+JDG
         CP01IWLre3E6Z3vsyrkq3D1qvoS9MnUEGiqicOzCGSsVogTytZFMQgov5Mkgf5L7vxp9
         Gkyw==
X-Gm-Message-State: AOJu0Yx3mM70gFyjMY7qxMhYKZDMZ87tqW3a+y0l1owLY4NE+ZVVukHL
	zwiNE8h7MsAzxiJi+FytBQKclo0JjGcjL3uXJzQEWSnxAgENih7qv6yqAO5CxCFv
X-Gm-Gg: ASbGnctHuwwgsDhrFMwuBA2gJnXdWgEkQWyE28QXBnt8fZe8MJ987+IuAgyliVAIQCV
	yZ3z8NDN/ON9Ahxpmd0+oYGzdVTIvrtyDzz54zomQ4KHEsgKOvzfbMh7QFxtj29cR6/T2nCJ8hG
	XA9YJSDz+jtdezOWKudI79JoDdh47guGpdHCFqyVS1aJWUaxJyZUkOlvhIYzQzuNTHGlIkRtdp7
	+BrhEcZ2Cj/CMfOJFr0k1jOawkLFmwYUJZaq20Ul0yJdlH82yUVKZLmAqulr8gBMCoMCOu1chl/
	JPhUkXVRW1Vs2OQnrm68QMSbs0IovOLroJ63m3/P8+a1pfvex1V084UEr3BsK/8MOcTrI1fdeWI
	Co790z43MN/XZtCI4jxDH34m+8QWcrUgn9Ap7riilCFQmXztAmUlUBSwPiKLi9vg4TE50VT1Wd9
	LbqZ+gysD/0iI4
X-Google-Smtp-Source: AGHT+IH3U7wAIn1n8s7LBxALn5cXyfQ0bJrUjXZQ0dex2XlkC4L563Ju/0lyvT1vRLhXem3jcORmOQ==
X-Received: by 2002:a05:6a00:181b:b0:7aa:d1d4:bb7b with SMTP id d2e1a72fcca58-7f03be92eaamr104219b3a.16.1765214619055;
        Mon, 08 Dec 2025 09:23:39 -0800 (PST)
Received: from archlinux ([36.255.84.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a0533f08sm13766369b3a.23.2025.12.08.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 09:23:38 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] wifi: mt76: mt7921: Replace deprecated PCI function
Date: Mon,  8 Dec 2025 22:53:31 +0530
Message-ID: <20251208172331.89705-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions() have been
deprecated.
Replace them with pcim_iomap_region().

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ec9686183251..65c7fe671137 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -276,6 +276,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
+	void __iomem *regs;
 	u16 cmd, chipid;
 	u8 features;
 	int ret;
@@ -284,10 +285,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-	if (ret)
-		return ret;
-
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	if (!(cmd & PCI_COMMAND_MEMORY)) {
 		cmd |= PCI_COMMAND_MEMORY;
@@ -321,11 +318,15 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mdev);
 
+	regs =  pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
 	dev->irq_map = &irq_map;
-	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	mt76_mmio_init(&dev->mt76, regs);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
 	dev->phy.dev = dev;
-- 
2.52.0


