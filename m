Return-Path: <linux-wireless+bounces-29570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206CCAB465
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82323004CB0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Dec 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE71EA7CB;
	Sun,  7 Dec 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exwrY1HN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C8EACD
	for <linux-wireless@vger.kernel.org>; Sun,  7 Dec 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110904; cv=none; b=eVZudSdGZPw4M2YLj7AUqj1/5Ah1dzxiB+P2YngOtY3gqpRZgp6X3VV04OiRhNQ/yeI4EuI2B8z0NN3RMh+2jGwixHhDFAIHrfx8j78smqR7bDiTA+zQ996Bxt5ajefI9ymWVHRFutT982d46Uf1NPkr4g7lJAqQviGc8b3qRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110904; c=relaxed/simple;
	bh=bqsDsPbxbV+ZAvtl3tv+Ktog/KNy4HWzUtW68I/QJXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDu3uVmOXBQtK73b3qoVGHxmb6/7N8KtdC1JtZrmG/p+VjDHRdxP5bWOuVvXIpe0096WKOAvklL+3+9GT/vGJryOj4rorMLeCHhDWVn/MwR3gCyau/CTD/H+IDJBOzL2hnmVNv2pTUsVxWo8usm+aL1zO5kcLKJR4t+Q17eNS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exwrY1HN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34374febdefso3727679a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 04:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110902; x=1765715702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/EEIG21HgNJz0UJ1AA5wtG6iy/331f17scAhitLn5o=;
        b=exwrY1HN+7UxYLCZkLrp7oN7Pc27rdiz19cybKCxQ3EtMojAr1u3G4tkg4GX1j18Fi
         1wbbyo+ZrQYwoW9GZD4unhJ1c5qk+6XQD747H0eTeFy/cv3i5kHG74CC4kBssOJnpyTA
         Kye0tJQP1762XtCy9IF9ORUAN1UB4Y7cVO6nLaNBqwFBoozMmy0MSjwcajgihgDIoVy8
         2hrvZ3Dgn4/6xo//SeEsBy55+SUlyIoo19AfjZ8IcSIBjsypDytlGwQGGtpOYCQ2N6g4
         AcalzfmoyJBEws/i+IVLvsZPKPKS/zXXO/NnBclNohVCUeBd0ufc0dIHnn/nMK/ZbQoq
         GlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110902; x=1765715702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/EEIG21HgNJz0UJ1AA5wtG6iy/331f17scAhitLn5o=;
        b=vsa0XTNNVdyQUM1eeUy7WQCMVG13VEHfOqGi7+dTy39+NXlgVTOnZ/hg14fF/j/LSA
         B/gRq0POOaTOv/lJm79+MumVT+njw8pMQsowtLFkeo53N0vRnZ0ElAYbqKhDsnhQ3XmH
         KUoqj5EY/VzIGl8EE37v5Cv3lkfPDW91PlVyJfK7LibwMCA7S9WHZEPkR3lWc7YkKOi5
         H1wTLh5g7igGkE6X84rHY5dKDBl/S+jWvkFxG8pO9tTof4EiSwdY2JLjiXD8EyyXa2Hv
         WR23ske3mjeQKLO3XqsLFj72Xwv6y4tsgIJDsYlv1E5IfIDy3CxLCU+OFahCPpZl6xDr
         +/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVdnzBlBkQ2AgPZvnVNTU1n0wL4vDpKX/32WjagNDpwqfT49RP+HO5r9DlAmZc8TdNkgSHaSVgrHZfAQFBh9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnrJpLafwI+nFc9ydFk9B0mHxAeSU8U2K/6Mk7aoNmGIO5pg8
	WsKikP03gQNZxM9TfavwhqzFcR2MOHH+2OJKOYgfG89yf6qHSuRGSJFE
X-Gm-Gg: ASbGncu1Byo1EnBgYN6uOEDEy4L+WCyYJV1/gDa255V3wAStuVA9xEIwnvKiqHz1C1I
	+Z84josVHSwvog9JAcN+6LlHFMzHD/DwYGOrnSwkrSyCJUYrvRPorDumZkOUdZMvM+iM5UTYd5m
	oacBAiR8GcDZOlQhtvmqx7N7/sPfN4ITD192DibtU9kByWX0vEwbLUEb7tJEqKywxjpTzLe8kEH
	G8olUVr9t4CYGwfXC/yy/n/D9krOHglCwctXNkCV7CQcOrq/Z5nJbWW4DABrON/COkduUlVFFwm
	AQAYM12gvcPrL1eZdcnbyYDvj5Ht2KmowLDBl5hSzHlnw+R/vxpVxNOQWUAPienYBfm5f9RmB+K
	SAaqDstpm/gVsj8d6kEE9GqF2yNrbFCH1Y91MYlmWOB1hIt0eg04pg0QGv8QSAWHyZVc2ddvBeN
	PC/QQQjZTMDXKUGG6x
X-Google-Smtp-Source: AGHT+IFzu5EseF38E19GJggjBQNJ0c5DSWKeJaFT7L7ltbpOuzF8rj9ayEDgLA8p8R58T9CgSYJ4NA==
X-Received: by 2002:a17:90b:3d92:b0:349:8184:af8b with SMTP id 98e67ed59e1d1-349a24b0974mr4020138a91.7.1765110901873;
        Sun, 07 Dec 2025 04:35:01 -0800 (PST)
Received: from archlinux ([205.254.184.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea7dabcsm9090852a91.16.2025.12.07.04.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 04:35:01 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.or,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.co
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] drivers: net: wireless: Replace deprecated PCI function
Date: Sun,  7 Dec 2025 18:04:47 +0530
Message-ID: <20251207123447.93233-1-madhurkumar004@gmail.com>
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
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ec9686183251..5a82c3bf471f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -284,10 +284,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-	if (ret)
-		return ret;
-
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	if (!(cmd & PCI_COMMAND_MEMORY)) {
 		cmd |= PCI_COMMAND_MEMORY;
@@ -325,7 +321,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
 	dev->irq_map = &irq_map;
-	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
+	mt76_mmio_init(&dev->mt76, pcim_iomap_region(pdev, 0, pci_name(pdev)));
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
 	dev->phy.dev = dev;
-- 
2.52.0


