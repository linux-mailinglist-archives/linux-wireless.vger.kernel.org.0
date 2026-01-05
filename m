Return-Path: <linux-wireless+bounces-30338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB6CF180C
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CF63029222
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D2256C6D;
	Mon,  5 Jan 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/kJHEr7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FF23C503
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572831; cv=none; b=CyZqj80MqVXx4DAJtQQ1Siiv6uhOPsW0relC96l82G5MMlrbHfEV/AmRls0dO9tBzn4E3CQQB6wdYeH36NJSsD9U2jyJHl8iOmw0V9gYaSv03H78l8wsJKXegh5pCt4Q4sG5jM7A/aNcNAaGoIdIVgx8f41LXUwUY0xemYBKWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572831; c=relaxed/simple;
	bh=TwK5yG1+7tBn7pEnm2Ulp9jAVc15XSZWmUbdiepn8ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEunJXUBemyjI0y1jkDDRUqLRFKyLgGWw7TPfb8MWAbyom9hpSYdvVitv8pVc/zVsDh8jrlXsDedxL5yX0x9/Y3nhX4MblYovXdT4qPePUwLBsRvqCq38xcRiMfoY3mKwj2AZYrqbKWReDQw4hbvnE6dSBHxNrqn/Dh45f4QfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/kJHEr7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0f3f74587so192078595ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572828; x=1768177628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx7Cxs6mPWElG9bplppz5XOkNbtbfz1JGfVMLJ0UqF4=;
        b=d/kJHEr7q3emXHT/zQLlKeFARXVu7ZG7xF7DSHu5CHUj7EkNjg1aFdo7sWMGgMbY5o
         or2vC8lIWzCcOoWCUyNKp6P++vbMwZEU/XVVmg6AX1/ScLFpnrSIfhLaL5nMkv2fpcWe
         qEIBR+RgneqiLSWml9rqKq5jcyAq/JzYcFVU6UTkOdD0CQdE5X0a1ijuouZ6TYgDvgAj
         vRpcXp+tbrOq8rzR2PqUmlruE3vJUM27HCQUdoiBLy0dqKLFa4C2mPrWN5P/mYRweLlu
         cfbT8RTKLA525iz1uigdQYRclT5ITNHLpsYy9HLIx06ae1tTpW+uDS1GQ3KExMtNsf/X
         AAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572828; x=1768177628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lx7Cxs6mPWElG9bplppz5XOkNbtbfz1JGfVMLJ0UqF4=;
        b=mPA9zwIbAdW9fAXS9XENi9LP6XPzuWxfU50xViug85z8cXr8j/OCk0iNZRZuz0zMDL
         9OFzcW3MNvUHNYW+Vb1eV7zw8zuEbGTKkYmTD7olA+ysla+iwHSvDJzQATHNQ/HYyZoH
         ub8S5boxbumLX1j2AMoUsYwXmZ8x7NqvaPAXaFS2VVOfV6Cn7tBiu+x1GKFd+3UVGRfh
         kQj395bJ6CrLl8TFI9CEYpq3r1Q1dK3/KOkJy26ScXfbLd/r5QDG3LnUlbxlGD1QbC3p
         qSi8jfrBST6Y9oERbZej9YCYCcK6WiAqvaieuJVGZ+nuGhJ9mj4ZtELErudrJUiJnUt4
         NMQw==
X-Forwarded-Encrypted: i=1; AJvYcCXTOQsfWm/cXDkwEBkFS8u+HBCEWbK1k9Rwf9B/D3odwAEnQlWJf9H+FrKcs3Lo0+MyOeNkTdRMtLyj8SvESg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzivxcWoiyKJz4r67GPjrhvOD+XHb0xOd5bapXQTgveBgwd6i2
	pPlpSVmfGgPY2Y+MoA8c8Atn2LTptrlHKSnrNypKuitcmh3AcJn3NTte
X-Gm-Gg: AY/fxX4YJ6NmacA8g/VPpsNX8DrmnxuygFjvfHr7A7s9iJZYkSCSkVlf08XSUXZcXI+
	ub2a1A8JSHBFmRpSHDirFpzbmRz7NzgN0UT+UmqASx6ZiSGOs0gM2WfylIdtbA7zqat7zLFDeYM
	whZ+WFcc6G4AKR05vNJepcEdxz6+geMRxDn85MSEtjuJ9qzaReLZO2pw/cLSo40krdjhgHJ8AgJ
	h7Cw0IdyyR5n6S9cMGY/mvZ/pVC3PkdJZgkJcsOX00kCknjg+jCIoP+IomLJqEcK5CmdR2SHqj1
	QRsQ/fzh306Dj6lUBMZp2R9obo1eGm/XQPW76XZDYlG2J6McQPe/QEDbXxMeMZK/lsLjICqb1Oi
	PTBuVm7OiqXu7qtOiYCi7JPvfXKG32UH6ucaEd5PKPKjus55fgdAhmXGKP14EaXiKIAfvrcdLJD
	yFTJ3lNllRMVuhZW5AWHawqs4NxhJRhqhbFHrKjlSk9VuDgEDBpDNXGFSZa1/Knt0=
X-Google-Smtp-Source: AGHT+IF2dXIfKchGTeNJHu2azmCNIm50WiML6/yJZT6JBX6bohZ5k2MDH1QBCndrXw+T70AJIWjSig==
X-Received: by 2002:a05:7022:eacd:b0:119:e569:fba6 with SMTP id a92af1059eb24-121722c348emr53252639c88.21.1767572828149;
        Sun, 04 Jan 2026 16:27:08 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:27:07 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 16/17] wifi: mt76: mt7925: add mutex protection in resume path
Date: Sun,  4 Jan 2026 16:26:37 -0800
Message-ID: <20260105002638.668723-17-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mutex protection around mt7925_mcu_set_deep_sleep() and
mt7925_mcu_regd_update() calls in the resume path to prevent
potential race conditions during resume operations.

These MCU operations require serialization, and the resume
path was the only call site missing mutex protection. Without
this, concurrent access during resume could corrupt firmware
state or cause race conditions with other MCU commands.

Found by static analysis (sparse/coccinelle) pattern matching
for unprotected MCU function calls.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index e9d62c6aee91..3a9e32a1759d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -584,10 +584,12 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	}
 
 	/* restore previous ds setting */
+	mt792x_mutex_acquire(dev);
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
 	mt7925_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
+	mt792x_mutex_release(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.51.0


