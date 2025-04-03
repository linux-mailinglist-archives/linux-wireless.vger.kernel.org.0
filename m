Return-Path: <linux-wireless+bounces-21113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F1A79C65
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 08:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E28E3B3168
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE322171B;
	Thu,  3 Apr 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5jSSbz4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94F2206BA;
	Thu,  3 Apr 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663184; cv=none; b=HDN5qEWDpFIMBUMJRpo2uGZUq1HLuzRvfDo/reKTxYV5qm+AvCkWn9uOBuwhWdfbO8NlokNDtnXHNosU7EroSTltNwZUA248f7MIkm/ik9zYE3mv9eSPmNR/y5SIFyUx1p/3iOKrzzEQRf1o+6iL+x5zRGTjy5kpxnF65h9u85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663184; c=relaxed/simple;
	bh=3LMMyPWYrPaO1cDrSCXeewS3gpsknQrqdu/udRmPNoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YX1X/aPyw62yzb0ABveOqDZnQ3FBflE4FzFdcZ65YXLL0btzyogDeig4RJMI6RzgwJMzRzuD3s/jR/KdNr/UzHZnGi35nYch0qX6P0woDd88RBC6V4OCscUNiMM1JZK183RbxicabGd7HqZUxBPRP3eH1ibGcVstegoHevzyeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5jSSbz4; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-ae727e87c26so404617a12.0;
        Wed, 02 Apr 2025 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743663182; x=1744267982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYpub62Wj/3iZGVbuufafvobpQVv5WnPv4mXzMUeJJg=;
        b=G5jSSbz4s5ShfzPkrROH1r5TTO5M2hjvOCZt8lIWZs0+E4juui/RxHuStvrC4w4rV+
         MQ+6NDr4SpM3bNFfJ3x11R20mn8X2BtF0dnG6EPm4n76vkPybY9OoAcjUwXiWe6Hvyjb
         npKK/VJw3SJ3QRbVJP72WHzieXMQ98sgJjoNiwpf/pbcx8BIKo3A8oMuvlCfyUkOt4Wv
         Ikqlvx9W5ofUzln4Nsq//RidlH6b6RGx6pJK+i4bp6Cu8RIZy3BTDQVhN1xb8j5GRB/D
         kQWDs9Iz+Z1AhzdF5rRzFjQBd1aiBccyt/ufOUilOOnD80NcT4YuddbbXCHRx3L2sFvb
         GoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743663182; x=1744267982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYpub62Wj/3iZGVbuufafvobpQVv5WnPv4mXzMUeJJg=;
        b=aVDrJtj8kFcAAndFTMXjz8Srk+761e9RCgPetUWN93Gg5+87Ze315WBaLwnsP4N2k/
         y7LVcJ7xintEHeuRb/3AdjwnJET/LY1ELrrhYEopIrR3WD9KkZ2Jwyf7t5Z1UV2zMNWy
         cTzDOHitaDzRKylL46nEA0vh24MUYIq8z4OiwmFQFtotkDm9VWvOKerY0KWuUfAlYRG2
         VhnvMzVATkASSaeEtfpAos36j8Ua2IBo6tNHebrtdxkExMr5brQNtzU3eDLE6rMLnOA7
         Fl5r5EpVsxO54EeYoNv7oG8S2BYlYaW5t5QpUI9bF2KX8XJ8b1EslXG80FyaYjSevsz3
         UsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpacQ7ohQIa1nGA57mTUSiMw3V7PIHbX0sn7cWeOHpnyYEbopj17G3iPf73hVaXo/dp8ycaGzCqHS1M7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1/f3ZM2EDr3efJ8Czlr5RZMXeikFC5k9fhZV1hLyiHSo4vcD
	VylucYavXTTjdoluerzP886x44jxvckZt+uVvHVmA3Uk5TsYyZ03
X-Gm-Gg: ASbGncvv7/Z4HIHmg1sTML/wvYDGP38uH2p1NbgS6TD95JuBdhjQErTdR4lLRp0qnkL
	Xow2g2gEIr8UXrSYMbd+b/yIxXOOmWOVTkZvcn9fCdYVzkVsfeBVbJcqUHCYmaYv4roXZ7EvVmv
	QMJMrxzBABIwAdBqCWfoYN7eZYxMOWHw5osX6sUtozqZLYD1GrpKr+ctxKuhk8FNAsyECND6dzs
	LUnXy8tI/bUQ7horMQwoAeN9Y7aMZCyrtYZJODrfSVxEGkfVvXWjefqXyiTJcRsj1C0pt9DY0dR
	WF8VjcQPqd2uAW5lpj2Qx24fRDjELVlByiEgt1Hc67C6f0ejmUunyVNO02zWDC2J50fcii4=
X-Google-Smtp-Source: AGHT+IGCE0kTnOZqlcdKdPI+1K7KQk4hgTqPsTiKisFEbAoBuiq5zTXBPIVyS00/eWSAdgWF3j/lhQ==
X-Received: by 2002:a05:6a21:6d8f:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-200f8a6dee2mr2134125637.0.1743663182000;
        Wed, 02 Apr 2025 23:53:02 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc2cff95sm541118a12.15.2025.04.02.23.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:53:01 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	wiagn233@outlook.com,
	chad@monroe.io,
	bsdhenrymartin@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1] wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()
Date: Thu,  3 Apr 2025 14:52:51 +0800
Message-Id: <20250403065251.64749-1-bsdhenrymartin@gmail.com>
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

Add NULL check after devm_ioremap() to prevent this issue.

Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 876f0692850a..e1f2e32c4bdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -651,6 +651,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.base = devm_ioremap(dev->mt76.dev,
 					      pci_resource_start(pci_dev, 0),
 					      pci_resource_len(pci_dev, 0));
+		if (!wed->wlan.base)
+			return -ENOMEM;
 		wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 		wed->wlan.wpdma_int = pci_resource_start(pci_dev, 0) +
 				      MT_INT_WED_SOURCE_CSR;
@@ -678,6 +680,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
 		wed->wlan.base = devm_ioremap(dev->mt76.dev, res->start,
 					      resource_size(res));
+		if (!wed->wlan.base)
+			return -ENOMEM;
 		wed->wlan.phy_base = res->start;
 		wed->wlan.wpdma_int = res->start + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = res->start + MT_INT_MASK_CSR;
-- 
2.34.1


