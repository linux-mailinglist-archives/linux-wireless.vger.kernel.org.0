Return-Path: <linux-wireless+bounces-30873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89248D29804
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86CAB3028324
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06F32470A;
	Fri, 16 Jan 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZkU1bdU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D4318132
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525551; cv=none; b=oesLCYgq9Qroq4Ggrfi59Xjgm7njyQCYDfMdLUFYTNhCIzbt7gxCnC71lVr9L0vRsEE/+RUhW2GrXPt2HD57ELaeec/kUVJd3WLene90ou9/v6bNTGBLjEQ3Pok099qNbG/0MujBRUkJTyHE4Myc4WeEvQ/mwCbdhQQgvqyk5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525551; c=relaxed/simple;
	bh=yGyc3K+9APMkKCyvio1xpxkU1KL5Q828KBPgc4VkbUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV+tqsbBrLg3Lz7o3HI6JE+pLeXBCFxi4hGnskOBcgoKXCPulIIwZBMMIcEBpCf4Na/0H6czH41O8oXI2i04m4Cvzi0xpSHaXcwiZzPZOu96jt9pUpYMODstd2yhR3cq4IbHWeFLi/prs7RNV1a3Vp40kJ5XP0KIYY15tWBh6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZkU1bdU; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b04a410f42so1852816eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525546; x=1769130346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLWOoyw2E8LXJk20xk6S4eG/DnEYq6CXxfM8xw/u51Q=;
        b=NZkU1bdU/30bQgw/qKpC9YOH527eIe+aShAKEnKmV4bjJL5meuNxlfJgkVYUpdaVpl
         xFC1Mx633QoVPCMPlar8YT/F1o+rjZDhOuiMoWSOVE3Iu3sUEIkBT3Ep95XMlZDNEqbP
         CmZ8VKmIxczYxhR470jcO9+RlJ3KjPe9ELHyeEJyY8a/JeFJObiCvfy5CuvcHfdsc8Ms
         piceKnnZXybsM7aRGs7PhM68nxxvXRN1XRamgQDi/1JtrVJljq9mSQvXgNp9WsKeX2WU
         Vd6HCy3He9cN1/rSY9jdQUKQJBbwWXJQvHWxc3kDcSf5L+4EfIVJCRZKa4ulpsRAr7Ab
         Ny+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525546; x=1769130346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLWOoyw2E8LXJk20xk6S4eG/DnEYq6CXxfM8xw/u51Q=;
        b=HMnfzYmyYmrQVNUCzNOsvVzBxLGye74HtVrI/qwveT6yVhb2ynPZdR6e+mTn1Bc+cd
         dQf+UEKgAU7TrgWxYB7/AJ3O5EV5d3xWJ/bP/rVgb1kGn89OzD7ryBLCD3euDP19uqOk
         650pt/wEPTSBYZ5PWEB7cMUs+UqBk3kukof3SJ6cbcvlQk+gpj/hMQN+j3/QtTjdTE1C
         G0t4qXMph8eNfO8kZZn5vNO3NisRLgYfASk4xek85A2kmD1m+qzZHXBCLIvRDl8vvR9Z
         T1nYsdYIT+Y7VywBvXvCydWe3CuLvs2bSlA1jOdI/hdErvtU50owbQyHEdvWbUVm5eZY
         gmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUed8xtDZUD1t04duO1EJahE5Ug01U//cY4fReWT9Sud409OOYn8LZZBllv2P7GvN59OEN9HiDrhWMoHsRyZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1NctHZc1TsC5JoLxIRh8cWwezVDjkrGCXGkAuyUsGQFYFEaV
	9bdMHl02GfhnR2pCUAa8YiQ0YDFSfKJpHJEWUObF8HSnqbwlVX7Wnmx1
X-Gm-Gg: AY/fxX5nahi/cGLpfblxuCiw9RII55OvY7qpHDRL1W3+XiExO4Q34oMHOCAldwqHUXt
	U60DwgkMp6RKudwIMDA5jNXXlAtOOxsPzKpKGaNkvlq9puXJ8n+6Dq5tdjMH6UyKspPcdkFH/C0
	cnOhlYxcE4UJRvwdiZn6NMDfBCJC++Yj0C/NBSn9ceqTQcqXbVJS61glveY4wmooUBh+m+/P2Ho
	jRgLwlAazNySJqYDi66LWSH12NCKQq/3Bc4Yr7wUWJhZZynbqtiy2GFmlPEUV5wJVHqh4U5V+pw
	n7a43msx+aAPW9XhnF+ADxn+zWoAN1b/Js5niQv8FL+LOQ1dGDdIRQWY8Wuhk/3VMTfJkMQvDAd
	uOgpXJZY/kBvCS2XJEDMmeRJ1VPWLbCk1qvAAlrXdIRyQ2t0x7SJnyqxGKE0+JoQ1zwrSiOsgCY
	iUWY860yBgMqw/azlpZVaZ5tQUgEPdqFMWxutVEY9X1maFLl1FNeBfedlHij1EwQ==
X-Received: by 2002:a05:7301:3804:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b6b4e64b90mr1425584eec.21.1768525545632;
        Thu, 15 Jan 2026 17:05:45 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:45 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 15/21] wifi: mt76: mt792x: fix firmware reload failure after previous load crash
Date: Thu, 15 Jan 2026 17:05:13 -0800
Message-ID: <20260116010519.37001-16-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

If the firmware loading process crashes or is interrupted after
acquiring the patch semaphore but before releasing it, subsequent
firmware load attempts will fail with 'Failed to get patch semaphore'
because the semaphore is still held.

This issue manifests as devices becoming unusable after suspend/resume
failures or firmware crashes, requiring a full hardware reboot to
recover. This has been widely reported on MT7921 and MT7925 devices.

Example error log:
  mt7921e 0000:c2:00.0: Failed to get patch semaphore
  mt7921e 0000:c2:00.0: probe with driver mt7921e failed with error -5

Apply the same fix that was applied to MT7915 in commit 79dd14f:
1. Release the patch semaphore before starting firmware load (in case
   it was held by a previous failed attempt)
2. Restart MCU firmware to ensure clean state
3. Wait briefly for MCU to be ready

This fix applies to both MT7921 and MT7925 drivers which share the
mt792x_load_firmware() function.

Fixes: 583204ae70f9 ("wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module")
Link: https://github.com/openwrt/mt76/commit/79dd14f2e8161b656341b6653261779199aedbe4
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 9dc768aa8b..05598202b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -936,6 +936,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 {
 	int ret;
 
+	/* Release semaphore if taken by previous failed load attempt.
+	 * This prevents "Failed to get patch semaphore" errors when
+	 * recovering from firmware crashes or suspend/resume failures.
+	 */
+	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
+	if (ret < 0)
+		dev_dbg(dev->mt76.dev, "Semaphore release returned %d (may be expected)\n", ret);
+
+	/* Always restart MCU to ensure clean state before loading firmware */
+	mt76_connac_mcu_restart(&dev->mt76);
+
+	/* Wait for MCU to be ready after restart */
+	msleep(100);
+
 	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
 	if (ret)
 		return ret;
-- 
2.52.0


