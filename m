Return-Path: <linux-wireless+bounces-21179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E014BA7D279
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 05:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB243AC996
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 03:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF07212B29;
	Mon,  7 Apr 2025 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCPUaBmV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C8801;
	Mon,  7 Apr 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996249; cv=none; b=GJ8rkE2BjNAOqPF89Hbk8ffc4p6tTCPungP/n6XL0QqN5+hcymnsvhzSazZXamqMTs8hU0s2qOXUxRTDM4Xpg0dScNWIhoX6yozt4THAVk19/fdNgW7juJ6dgS/JISa9FzowoUxYu6m5u5PBNGdw2hsxRbo6dZ+OL2oRUjx93Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996249; c=relaxed/simple;
	bh=MVqP/MRkeq5mWsnVeb6x8OKT7vqLIT1fVjO/24HiVfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltFjdd40CMU2lirNXSQQiFzvbgzkGHVmmWHNdtSzNXnYtWBJjjWv/XtpdeIV01sCqxKmN9e5zoqHen/NIknvooqZLP6D4RP1EoL5Y1iUa3bMe4rkU33OvXzbACt4x5FWHNeccz8QA7JEAZwY+SCGa9ZBiilELgSjmaJVtI1KnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCPUaBmV; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-227b828de00so35894295ad.1;
        Sun, 06 Apr 2025 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743996247; x=1744601047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fmK2IFe+fh1XGVBCh9dw/6nJ72mkqtroySmjWMxwgI=;
        b=PCPUaBmVDkeW/oVyBvEKw3ADFrth9DBNEQSM3KD2K1ZKKns5Ks8ZnDJWdWsR5Yrc+t
         aIso07UUzp47Bxv7fuAHqxhrjejKR/eSGoNI44WtSqX5TCSQ368TNtahOEh0IwzjYnUu
         +aJ/Clmkj+/B/sF7zZvzfWt89nt7SBRCv1sCtHi34+Hfn23dlq7VL6N9fTxVZAVErMeT
         c+Oy0/f/Rrbw8ll5IPrlvPVk1ZvwhmB7JR4ySUaxXTZV74DcxYcAbqQrndXh+RvgFitN
         4jSFYlkIgZNGjDpxB0H0rukLOE/Z9qnx0Lle/tc3ftwfsfZpwJ6F8SPIVz/rDKr5Mr2W
         xkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743996247; x=1744601047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fmK2IFe+fh1XGVBCh9dw/6nJ72mkqtroySmjWMxwgI=;
        b=KV3F2omBV6qKA/L+Y8YQOdkShYBK8+3UBXbww4IlDv5jzyDcGHOzMLuteIKdQPklf+
         6ZTce1rUiuJD+1h8PqvgpJVdMJnpnZCUuMF8mEWlovcvUOL1g2cRguciBngm27zdmjv4
         +tjRYIw+lZd2XE6wduJL5p8L6xxqgNjaxgP/ImUYIuBv3hpUs62KCkO/3Ao9QjyeJStY
         EPn44ZCk45ttyHFLmc7NPjR+c456TWuevXX4Ya1Ex0aPNzM3nfXLgcQhaD1pi4N4Aaay
         ZZiZS7k0pKBww75kLNMBos/C0pHnQOQWmaCn4UCxrzKzYpHkXAXGK+VtkSgcfuTh0jpG
         LoVw==
X-Forwarded-Encrypted: i=1; AJvYcCXEL8h/sElsyr0ylNLxBjWTJ9T8kGa52bSQ2b6BlhA5FgZhfwepg4/6F2tX8AJzT3UP7cBu9EaiytnJZV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqPg60RbuaOYhHu+4pH96kRKa0eUw6XW9VgKJCWOc9TWCttYD
	7jF5g5TtugZWQiLh2UkyC3VHtmiUFeISEL7G9X2+00Q8o9wAQ+4kCqNYVvYTNK9mAw==
X-Gm-Gg: ASbGncshgQped8N12REmEZFr7nyzRYMzB6l+l7NK5RIK8nYj3/3a9hfUel2GonZI8VM
	gJBtpVZZLAJOkTt7uT/jj4CeXYb37SIuTo4LEucoBqD8DhXW+D1sLnC0LBZd4Pcaz5P8aphCZuu
	+JNnvPDMUMzPLe4YAZSxJeTTxnmqbNBK6mPo1OqkiOWZlb7M8OhqmO6c1RNHhRLSKddtGuIuohX
	XETS4BlvMbbbWXFw7ph0YbACOBH8E0eNcAkteiR5Lgp9ORpbB9z/5pixCxNJ6v+xPv5/evPcxRI
	aFq5ZcNQ8qPGTUWxZck2kBpNzcyPF/9dgQDEL8EADH398IwaI62OX3zK+bmdLcY3B2iTKmE=
X-Google-Smtp-Source: AGHT+IGiiOhCXltCwB7LH7Uukc7MXJILMdaUq06pKBBwQ/EOPL92BM5re8lzHelAZXPlHg/PFyG3ew==
X-Received: by 2002:a17:902:d485:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22a95529550mr123048075ad.12.1743996247046;
        Sun, 06 Apr 2025 20:24:07 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978772ee4sm70065505ad.233.2025.04.06.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 20:24:06 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	bsdhenrymartin@gmail.com,
	rex.lu@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
Date: Mon,  7 Apr 2025 11:23:49 +0800
Message-Id: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_ioremap() returns NULL on error. Currently, mt7996_mmio_wed_init()
does not check for this case, which results in a NULL pointer
dereference.

Prevent null pointer dereference in mt7996_mmio_wed_init()

Fixes: 83eafc9251d6 ("wifi: mt76: mt7996: add wed tx support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add a blank after the check and correct the summary.

 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 13b188e281bd..af9169030bad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -323,6 +323,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 	wed->wlan.base = devm_ioremap(dev->mt76.dev,
 				      pci_resource_start(pci_dev, 0),
 				      pci_resource_len(pci_dev, 0));
+	if (!wed->wlan.base)
+		return -ENOMEM;
+
 	wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 
 	if (hif2) {
-- 
2.34.1


