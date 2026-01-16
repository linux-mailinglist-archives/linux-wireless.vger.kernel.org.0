Return-Path: <linux-wireless+bounces-30860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FAED2980A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C8930A0D93
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B15315D39;
	Fri, 16 Jan 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXicS9PO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A79314D14
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525529; cv=none; b=FuR/NnUIzCn/5uhl6BznTZ4dJFOsLRndnh5Q0LxaVm3ErzTN8LZDDkiXVvl7v+NiwOvsUpvfYsdepEHPlW9oKaQNtOR8+ggwe7x/mjSrj6pZ8ndaVIvqkxbzXgGJsD3RNfdqIUNH14Yoe8wsaO5IvpF85VwMJONSvOFPiQIDcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525529; c=relaxed/simple;
	bh=RODJo0dX5b/DRTFhY2cSaN8LgFh3iNNX0MJ6nJMpBFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeHFuzCP6NEcRt3TCu/DrfuDIAWgP8Ip1GlOLur+y+q7OEi4cUMkzXd36S8lShb3iLtxLXwmYxVeZTIC1HU3IWOEtvpXQSlo3e4MN2IXKiEYZX4sFGXTgG8kbvZG9h/+GvV4oggU7VYcQfBbo/8vENMmiPGlQNkPJr0BQXUsx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXicS9PO; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b19939070fso3506756eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525527; x=1769130327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AlYUZTasc+1BNyrEOuxrME8CBfLRDkLtwgOBsYdMoM=;
        b=NXicS9POL4+PpSDerqVhuMTiywoBCZ/6mVfMRB2410dymDLNBVSyiAAEGRdQ51HmJS
         sPLlMp20wt1hseJWJiMCUjCbKpywp4ZN7buFXlq5d0RiTO1z4coBY6JYly02KwKPR5po
         pph3WjAK5Ise3jmCy3Pd/h7lwrQpAYd7aNFlykHLM6SLKG/OUqvFpqLKsdepZTwqzAxM
         yUTVKQZI6uUvMb+57VRXKxSdPA3HN2tjDP8i2heb2hYV06pDjf2dPAtQUqxfLXUP0I5R
         IWzSm0LiyDAazFe458DibD++jnO7pWazexuA67Dstdx/rrrm9BP/+qsQGUs77v4iHItI
         udPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525527; x=1769130327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AlYUZTasc+1BNyrEOuxrME8CBfLRDkLtwgOBsYdMoM=;
        b=kw8eD9RPLv7gvW1lMEhmrmZ8LWjLNef//K2KRDj57sTNaOycDRYzysSBqv7WVQB6hw
         MSqyB6ZJiz+Xb/pscXXu57/C3tDJOu7LSlNZbT0y8HwEwnVYWf2FfBg8XR3DqcSv1DoP
         +0slgDGXl0Y6MySUNHNSl6jo2VKCy7kNFOIHfJxVZVJ2jRIuQAjOve0KzYhNTv8u/cSb
         rvONG867zULielUNool83yFh7qqFGSccUWjjmztVpbofSq4F+GjWpHPXhtS34a3LZCx8
         QyOdVegfiPL5+N7X5FADHZqbfeI+ZlzLvuVpPKEdbsBpwSwA9k8HY08L2X2DVa3tph2j
         FSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoFEe2FVZO6wSRzEl9HIUCi1GmLXMfBTd30bxG5RhG1m04GMqcE3vaAIZMi7I74voWjFrWtKp1itNpS7RD/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rzXszud7qdFNynqp9CJm27HNTlzIuKN1MiWkvD1M+sbfv2FX
	tNO8u+e+OLsIH83pmaefR61ufYzFPQsOX+YFU7xHzzaRH3+gSIdoNNAX
X-Gm-Gg: AY/fxX7tyZpAMBqG4zNKWaYrqjkjNOvVDP4iHzDY5oO0myxxYRc0sfsc7S37qye5Rpm
	qwVZnbMwzwuhUDzpqMq+SagBatbikL7bM+siipjGjMXdXVg/bh8dhOETS8IsOX63SPugQ1mbdGd
	k0vSJE8WQTbfSWw2A0gv9hmuTa625cmuKFgZUN7s8un26Ffez6zwhUaocAKNASEwLtMRafRo/4c
	iaOQFnuW8lSazuNe2KTS6r/OUzhNKIkIsdcS4oRSyUpRe6u6CqLhwH6N+E/JE3kgGwYf7MXfbqQ
	K5y5DRVSJkc8Yl2iwzowhi7Yq9kYaJIG4WzQ0NqCnIEedOyHp3JQGCu5nPo4tVzefjQo+P8vT/e
	HyHWa1OXndoCBtl8ecuFmSDCxrdbfSnEVLNLfA1lOmmkFqfe31crTWeGR9PzkkW5EQjo/wVuE8k
	085dVCoBZH/imhEivBhYrAgJF46TSGx9baQc/uhkBt59ea0hi7S1bu4rXo1aamZg==
X-Received: by 2002:a05:7301:650c:b0:2ae:51ae:5cfd with SMTP id 5a478bee46e88-2b6b4104264mr1496968eec.22.1768525526187;
        Thu, 15 Jan 2026 17:05:26 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:25 -0800 (PST)
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
Subject: [PATCH v4 02/21] wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort
Date: Thu, 15 Jan 2026 17:05:00 -0800
Message-ID: <20260116010519.37001-3-zac@zacbowling.com>
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

During firmware recovery and ROC (Remain On Channel) abort operations,
the driver iterates over active interfaces and calls MCU functions that
require the device mutex to be held, but the mutex was not acquired.

This causes system-wide deadlocks where the system becomes completely
unresponsive. From logs on affected systems:

  INFO: task kworker/u128:0:48737 blocked for more than 122 seconds.
  Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
  Call Trace:
   __schedule+0x426/0x12c0
   schedule+0x27/0xf0
   schedule_preempt_disabled+0x15/0x30
   __mutex_lock.constprop.0+0x3d0/0x6d0
   mt7925_mac_reset_work+0x85/0x170 [mt7925_common]

The deadlock manifests approximately every 5 minutes when the adapter
tries to hop to a better BSSID, triggering firmware reset. Network
commands (ip, ifconfig, etc.) hang indefinitely, processes get stuck
in uninterruptible sleep (D state), and reboot hangs as well.

Add mutex protection around interface iteration in:
- mt7925_mac_reset_work(): Called during firmware recovery after MCU
  timeouts to reconnect all interfaces
- mt7925_roc_abort_sync() in suspend path: Called during suspend to
  clean up Remain On Channel operations

This matches the pattern used in mt7615 and other MediaTek drivers where
interface iteration callbacks invoke MCU functions with mutex held:

  // mt7615/main.c - roc_work has mutex protection
  mt7615_mutex_acquire(phy->dev);
  ieee80211_iterate_active_interfaces(...);
  mt7615_mutex_release(phy->dev);

Note: Sean Wang from MediaTek has submitted an alternative fix for the
ROC path using cancel_delayed_work() instead of cancel_delayed_work_sync().
Both approaches address the deadlock; this one adds explicit mutex
protection which may be superseded by the upstream fix.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Link: https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-nullptr-dereference/79301
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 184efe8afa..06420ac6ed 100644
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
index c4161754c0..e9d62c6aee 100644
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
2.52.0


