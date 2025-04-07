Return-Path: <linux-wireless+bounces-21182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF3A7D3E6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A53166204
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 06:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AA218593;
	Mon,  7 Apr 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/QvLLUW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC733CA;
	Mon,  7 Apr 2025 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006756; cv=none; b=E6yiVYMyzp7ok85flLyhxms2jRnJQrbP+wufVCRthw2KmgBqD7+kpEkniph8YGdfupb/QNEuix9QAUVbK/kremnRRpQf8Q4n9t2pDOz8gIW+hBDp1oCyMv2yqrjoskkau+pdeMil2O7SGOQCTFjmrWTQtXpnKXnvUIFqdMyLDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006756; c=relaxed/simple;
	bh=rMi4SaQfSsO2kX1MJ5kZcFlcuLlPcxUnvEN2ZnToOUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyaJBwTY9EKJEzMnl4e5YMHb/Dvq1lb9oPW8x4ncHUfmohm3+TRR1gZq32Zuzo4pceziWUNuFHe/0qREFi1moQV3H+h1CL54xOnIFXkrDOQemYn0cNCS3o9hvPe9wgN6EMsLobpQpZazsaA4RaG1okjC5CqznNhTsT9DD9fLddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/QvLLUW; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-af9065f0fc0so2545447a12.2;
        Sun, 06 Apr 2025 23:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744006754; x=1744611554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dFXeq2CgWYu3KZ9DVuWvCtQbxPHL6sdTWZtnaoyOKs=;
        b=U/QvLLUWF0j+GKYLPwJjYpAApUWR0V6QF4qFlxtM+gTEkXewT/z83Gf1no5BHZRRFf
         +EDI5cCdUiVF+zkE1SBkrUyA7HakFzGqZhBBiI2o18SMXuAzRcm7lrAjN85kODGakOZV
         KF31loaG6ngEc4Bs2nsIYm4B8ej8/kBRZIbQrwWDrWdgAtfL4JjrNcLno7BX1yOeSWxV
         zBtbvLSV0eJkcvAlteOq62r9icYTNrkS4/um1L16ZOSJH1UC3/ucNhLHUSwda+vI4ok/
         fxEpM5si/mfkoXjKotY4WeoKE+i9WiwH7JskrWQH1LzxCuqMOI1d/7xDBPmqIyKgMdzV
         2n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744006754; x=1744611554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dFXeq2CgWYu3KZ9DVuWvCtQbxPHL6sdTWZtnaoyOKs=;
        b=EG59S2LzAmttuxbarybJg4x6NP1c7H2XpUZ3Np971B8fWH4Bczw34Zr4kc+H4GrmTQ
         pLWBDxbKAKTAJ5VXYaQpLk9oXusuKuq7wqYs6bRbHArUQVd5cDGB7Ilali0zHZwnjWnZ
         QJkMKtnxQvCyUD1lia7YWSrAweLR1+zyuNO2LJVpJ9RKIdrM7Xi9IyEd/tp5enFOri2w
         J4jQ18PA8NXDWUrZdf1PaE80+VTE4f17lWhncch4wDfYri06s2gSEYx3RK4HF9MGrhSH
         9NJY767aAgBK6IgvRDWsLmbd2A78/AbTSoe50y+5o+L68FvoLihUJab1gnvWHMHMLeQj
         G0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVbINI200Sbnrbmq6BE3ynOfSJib3shmZ0LZcvKyJJtFyL6zrJfmbjwJ5rx66CSLPnVPZeKUkHwtGsxtRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0tMfUQ3SLWko3Nr7DJlkTywn8siLZeQfrDOoNhCwQirBXOy3
	4T7nxrVYBhcRPNjWFNl+zHTebPO2vf3XKA2dpbiTSTYCChDeODcX
X-Gm-Gg: ASbGncsNfPf1ST452m0BKnMr+4mQSmN2CvVYBDkNA/8fSUtd/cYMqH7aFwtyFjiuuil
	sVWID9MFRRPAFNI9TZiLEVpZx5a7wj/+qQIzBJJU5lb8uHkexe2CDK+AA7qnAzQEKNmGCuhO2Ok
	3hQcPR5OYEy1Txr2uGkEFghYywUhm+FREza852kMgv/fML61yKpyCn9p1iL21NE76CQUbrnRoO7
	AWZBrp5qvQbDTMSZR4/odw8mBEcsnpUvOoWjtjkemynAPOQfc0VM/ylbwzi2s7gblTPsLIYq3Se
	n8mqXAa07kfGvap3d5k7wXm/XwtJYPgJU4Ghx0pq09EBmPsN59wCnZmN2GqIBrkHPo2Sbso=
X-Google-Smtp-Source: AGHT+IHeXC09XSFChpRb9qXhzMWyzY1i/YN7qCwEDFJ4TLe1zHG3OW/lwBLze1CQACFTsx9I7iunWw==
X-Received: by 2002:a17:90a:d450:b0:2ff:5357:1c7e with SMTP id 98e67ed59e1d1-306a48a4b94mr15463045a91.20.1744006754416;
        Sun, 06 Apr 2025 23:19:14 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983b9cfbsm7967837a91.31.2025.04.06.23.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:19:13 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()
Date: Mon,  7 Apr 2025 14:19:00 +0800
Message-Id: <20250407061900.85317-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, mt7915_mmio_wed_init()
does not check for this case, which results in a NULL pointer
dereference.

Prevent null pointer dereference in mt7915_mmio_wed_init().

Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add a blank line after each test and correct commit message.

 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 876f0692850a..9c4d5cea0c42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -651,6 +651,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.base = devm_ioremap(dev->mt76.dev,
 					      pci_resource_start(pci_dev, 0),
 					      pci_resource_len(pci_dev, 0));
+		if (!wed->wlan.base)
+			return -ENOMEM;
+
 		wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 		wed->wlan.wpdma_int = pci_resource_start(pci_dev, 0) +
 				      MT_INT_WED_SOURCE_CSR;
@@ -678,6 +681,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
 		wed->wlan.base = devm_ioremap(dev->mt76.dev, res->start,
 					      resource_size(res));
+		if (!wed->wlan.base)
+			return -ENOMEM;
+
 		wed->wlan.phy_base = res->start;
 		wed->wlan.wpdma_int = res->start + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = res->start + MT_INT_MASK_CSR;
-- 
2.34.1


