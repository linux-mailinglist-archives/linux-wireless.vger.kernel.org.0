Return-Path: <linux-wireless+bounces-30252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E3CECB25
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 01:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B534D30039F3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF51E521A;
	Thu,  1 Jan 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV8Zt8Pv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC81D5CD1
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226978; cv=none; b=FaIXHKy0qKMMm8K5aZ1tqAUujWzPBqYOZtPKGcIVEpxNxHb6pX4LBLuc9Xc4fEkTTjPWITfnqbXZt0Otm8dpnxUiLt6l14hDLG+BVZTOVuzDneLj6+F5YB+7jxN2qrfenwAsoM6Wm8xVCqnoLeTTYvaJBkyL9iTf7dV5h7obDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226978; c=relaxed/simple;
	bh=uXmkWv5M339UFdEp2HwyEfhQgSaymFjQa8XRiW9b+YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgiEucqxxZ/+pjvgu4vmC4C5Rrbm6B9ktmCvjiZEC0TLPq77neDc1G8rnHWqzz9MfsJAmYn3i+iMnhMTtsrNh13/RM0ATV5fvmQbgQwfItxLgPZmOICv//pbQt6BjPl9VFNKnAePHod3oQoPRGLeTtlOf0+ZY64+7dQG/TwN/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV8Zt8Pv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so8647759b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767226976; x=1767831776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7hP4/6MzXBlCphVpjUPnbzonToHfVmgk1yWMeGEYqo=;
        b=TV8Zt8PvBWfYIqLzhDvEBRBTvX5IQGayxC8yQ1YP/TyY1PYBY6ncNnzBFTMGawlVNS
         SZipty6EhCqWQtnDUMJP8JinUp5tsv4uXeqi6DZbRnIWbQWcjQLZZ8YVTQBj99NOGSVc
         unCWyI32wdNtfXXbpzgVCdkkcsHUJTjsRtWOLch4zl1HXCp4F/9goGhrK7kfhRvrJtr8
         UIGWyrdTo6+yBfLS5rH0AcVvJd1j4dBdT4LNxn4pioAhgXQ8Pmjy3ncy1GyyNMX5ibxM
         c25aK4MMgvVHFYdInyAWyMDh68RCxtykHmaEDvujnETOx8lSnbL7DAtUSJar7mEA7UTa
         UiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767226976; x=1767831776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7hP4/6MzXBlCphVpjUPnbzonToHfVmgk1yWMeGEYqo=;
        b=oZoO0tRm4LPy8CjwT1JxNM7R/Mmicon4jV4/shdrmQ8KGBrmwhKDYFGDYmeGf5lPpi
         LJNF/y2oijENwCXq5jvQF3XBXcPhxmJXZVxpQ4x/AfegVWv+/xzs6zX+nmODOiFrSeGs
         ViPfeSH3xqrL6nrIfVRW+rO6mlPdQin+1/6OdL94q0R6DX2CnV3jt9wbwmooRNciChAB
         cI8PpdM56ju1RCHys1Qh56Ym8FVTSftYwUR8jkzFJ0q1doWCpDiIMb6pcXZ+93Lhm3A4
         NF9MoRILKBKuA3x2p0WLHLSStkd3ThAA9I7IxUTjdI+hOK0/OJnulDZ4TRVLn/CZxbkO
         xhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4pXbdAHMWjml3K4VdDr+pk+N+tT1e0qLU0DefrOHAzHvZw+YTWbkTLfnAspNUYzRpfQhgSYVjZqKo9Z92Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCTlAb9Kgg2fpfcmq4KOQ4Yq2q29Wti4h/RgyPhnjclcmnrBl
	T7bjcExeb41AkZHBqLi9u0RUaAEQes0mbYMqxsk7X3/kPHpBZbQRVmIz
X-Gm-Gg: AY/fxX5oGJMT6F8iOzhjMED4nn+4frT20TSbuEJzUnxtwdRFp6mE9twPCRGUUlItSCS
	4RvgPA6rd+0cAVnsiYbiF5t/SyE0FxNWp7d3R/UFbGSt0EIdTs4bqFQbh1CPlkrECHeoVbxY50E
	gWdgItzQ1r6SXG1HRhvLi+96tZZJrLUozU5K5fYKQJ1SkF1ldoeZRmG7lqQRsqvlpEq3fSdGIV+
	yUxMztlAsDtnIuwRXGtwJIvjKf41FfXUusIN+KAymJ9jFuIXDhupwuVNop9BaK5VoH152zGKgJo
	ohtGu+K8Dj3WvKRouqgJV5VyYQvDEv3c81QWUqnDjrJrAvlEd2074xLzZc4aEx1Kol5RzylFC3c
	caJKr3eFJ59vujeHjRXJP6CYCVcHweAdj54cuJ19zkhBv+rIjUEbmcR44EhsoGcymSSsWQ2LEaP
	o+LjBKkbv7ICs54QxMK6PIaPMAFlL4KBPJ9aA1a7FLM/JVOtT2sa2O6KcPOsifSwLQw2MpF5aIE
	A==
X-Google-Smtp-Source: AGHT+IGvR3F8ZvfS9X6tm+SOPzohfY0S2Rtcb+Z9cxmiC/usD4FDeoHXUceXcAntkCJaJbwQT2hJig==
X-Received: by 2002:a05:7022:e24:b0:119:e56b:98ab with SMTP id a92af1059eb24-121722b7ac5mr34376559c88.18.1767226976361;
        Wed, 31 Dec 2025 16:22:56 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm110976431c88.8.2025.12.31.16.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 16:22:55 -0800 (PST)
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
	sean.wang@mediatek.com,
	zac@zacbowling.com
Subject: [PATCH 2/3] wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort
Date: Wed, 31 Dec 2025 16:22:53 -0800
Message-ID: <20260101002253.19078-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231223702.30957-1-zbowling@gmail.com>
References: <20251231223702.30957-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

During firmware recovery and ROC (Remain On Channel) abort operations,
the driver iterates over active interfaces and calls MCU functions that
require the device mutex to be held, but the mutex was not acquired.

This causes system-wide hangs where network commands hang indefinitely,
processes get stuck in uninterruptible sleep (D state), and the system
becomes completely unresponsive requiring force reboot.

Add mutex protection around interface iteration in:
- mt7925_mac_reset_work(): Called during firmware recovery after MCU
  timeouts to reconnect all interfaces
- mt7925_roc_abort_sync(): Called during suspend/resume and when aborting
  Remain On Channel operations

This matches the pattern used elsewhere in the driver where interface
iteration callbacks invoke MCU functions.

Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 184efe8afa10..06420ac6ed55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1331,9 +1331,11 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	dev->hw_full_reset = false;
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 
 	mt7925_regd_change(&dev->phy, "00");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..e9d62c6aee91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -455,7 +455,9 @@ static int mt7925_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7925_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.51.0


