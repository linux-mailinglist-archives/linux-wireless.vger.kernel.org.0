Return-Path: <linux-wireless+bounces-30250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E627CECA30
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 23:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 064C53000E82
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 22:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B08301472;
	Wed, 31 Dec 2025 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8tFnLjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAA30AAD0
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767220628; cv=none; b=HRFMPqYjqHaCR5D7Pst4axqrRjYIHbcHKHsJBcsWndtDyRxSxIEpAd78M2yvUN1o+QWQmVWlm+dm7y2TLzq9c3uA08nQg7ZEazcNjlew5aKhqwEjhdxRJOsgTJyBMkL1b2hpvJrIrnbymgHc5i/lO8F4pdSh9rDUeK/uYjQdV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767220628; c=relaxed/simple;
	bh=oRqrRFGHp9Zedf0Kkom7ohXC/s2x9M7NKkmWrCTkdhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnoHKafbOe4oMYt4Jtmn+hFkfYZPwutxKUD4vK+VGVVo0gqBPFDSelD5Iu1eEUD2q2d/tHWbu1OMx18BTbxycGlJRHpqAo+Zm2dD43DWDev9zwywZpYAijWHIK3/n33lpiTaTArJrINAe8RpKHFehyEsX61W71VwR60YX1Ogyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8tFnLjW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2af7d09533so4419240a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767220626; x=1767825426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZB0aBwHBsHnm/b2GY2momvTrZBbqthwPjLSAEmi3GY=;
        b=N8tFnLjWxzhqeuln/oIzwxpRgFOE4VpAB0sYk33ZOQaQsAmyAEcKXf5XNXX9n9dy0o
         Q12PEvwMjiS6rvUP7iy2H725y0lADc7XQdWBG/Jup4/4ylAIgA/hrBaYP/h7WLCsfeQi
         5NfDwzURp++fPzPvNDMpBkpiWNvfsH8J4L8ZhmUV6D/v+efxRTZIt9Ohwo8jMoZ2SR3J
         xDXU2xHmJilPVdiogqYz8jvyql8H/Q9tP20TJJEDPRiYV4AsKnVRFyMTDtaiohDwz+/T
         wCU7D93YGcX5G9J6iy+18Z5nK+LBr2jzjhQAeZfyxahhP/HH2oRJ8YvjpFgu7fF6N527
         zjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767220626; x=1767825426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZB0aBwHBsHnm/b2GY2momvTrZBbqthwPjLSAEmi3GY=;
        b=I+O2eCwG+Ih8128sroIecU6AAYRVIeGoPnhMoDpHEcWEC8hJyY7ABYJLY89OK6c9S3
         otTZK7vic0O+YhV3plRX9vIRpmjm8N/4T9LF9mssYV8qgKixhIioE4XGWRxKR3Lex9wB
         k31YFCHFyz6RfXH57l+J4pbS+dp++18/bku8WnDIeQqIMJ5CJ0GO6txCKZZ8mIrYG9jv
         vZBXK5eT2qdYmdPNAHqsmrAVgIi+b1UoLw++Mvc/tNCPDB3ktK+SodREw2pZXaz1vs28
         3MR95e0kl8Vsb0vQhTdPsglGegiIXQ5ETuB6WYKhQ2UfllrsDB63sED9fjacC+3GMZIh
         ROQw==
X-Forwarded-Encrypted: i=1; AJvYcCVDdEnfqda10ulsi2LGsYz0WgXwiwBnHVDJ9FjayKpb8q9SHavcpnsiAIOEF6+PsRpeiGVT9mxcoHqUuMdVtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeUe25iP0oYVC2aoSHDRlP5VrcmSKSh8cmI5xTqaTWFQJeJPs
	7UA9zUcMTB8ER2pzEYWEAG8S0wcPJjwkLmrhID+dGgVxybaS17CiwgH1
X-Gm-Gg: AY/fxX4adpkbMIRT0DrRadGcAeAZAzZ44WFIUyCAOtqBerrbTcIduI1ivAd4PbJirQd
	if7e8XdmmZH1ExTp7MMB270FVY6RB5OELc0sjtEBOslLOsGBTwwb6EvQ/+euyJ/PvmRUoj4JCrp
	xf+rO3ZdLzlG2rU1bO/WRwhCE1K9EXzTrIelmBnW5zon554ibr/ozJU0Yd9s5tllBDC32Mb3/mZ
	EBAiFe7KymWkY5YFJfCmi+ze6bQw9ObFfXx+ibPFALAmPXv9oq101ZLfH0FbnXE+B0xKADVS02C
	cpa+l8NkHB9DeLGQhk8/ZlVUPLFQhDRDDcAk5W1KU6Djm14PHW9fUDaUhPnkTl/xhv43Ev3pDge
	TZGENhQpVVWpkgI48T/ZOtI+1N0N1eqz0aV4IVhpLDsdFn5V22YwWLwxeX9mIK7dSWykxp0wEiN
	5FEM1zFeka1zFFU0OtnqVtysllmXuohhgqlPKtoalxzl68XqEGAy5evkb0hnwz6A==
X-Google-Smtp-Source: AGHT+IFDO7PqMSfJ9kZvMehwUr1S7PTSmbtdpd6FcboT9jIMWivuwfE88+jhwgbCLEm+TMz2XJeAbg==
X-Received: by 2002:a05:7300:d58b:b0:2b0:4f34:eed3 with SMTP id 5a478bee46e88-2b05ec3d5e0mr20245885eec.27.1767220626281;
        Wed, 31 Dec 2025 14:37:06 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffd5f86sm80818712eec.5.2025.12.31.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 14:37:05 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zac@zacbowling.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort paths
Date: Wed, 31 Dec 2025 14:37:02 -0800
Message-ID: <20251231223702.30957-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAA5_Hq7vNOy9oCGkkgyukq2OP=a5yL_3ZKBdmNtBXS+zp6byiQ@mail.gmail.com>
References: <CAA5_Hq7vNOy9oCGkkgyukq2OP=a5yL_3ZKBdmNtBXS+zp6byiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

This patch is a follow-up to the NULL pointer dereference fix (commit
6790e656030fb23527aa5c0d6eaa28ce029335b1). While that patch prevented
kernel panics from NULL pointer dereferences, it did not address the
underlying system hangs and deadlocks that occur during firmware
recovery.

The issue manifests on Framework Desktop systems with MT7925 WiFi cards
when:
1. Switching between WiFi networks
2. Disconnecting/reconnecting ethernet while WiFi is active
3. Firmware message timeouts trigger hardware reset recovery

During these operations, MCU message timeouts can occur, triggering
mt792x_reset() which queues reset_work. The reset work and ROC abort
functions iterate over active interfaces and call MCU functions that
require the device mutex to be held, but the mutex was not acquired
before the iteration.

This causes system-wide hangs where:
- Network commands (ip, etc.) hang indefinitely
- Processes get stuck in uninterruptible sleep (D state)
- Tailscale and other network services timeout
- System becomes completely unresponsive requiring force reboot

The hang occurs because:
1. Firmware timeouts trigger hardware reset via mt792x_reset()
2. Reset work (mt7925_mac_reset_work) or ROC abort (mt7925_roc_abort_sync)
   tries to iterate interfaces and call MCU functions
3. MCU operations block indefinitely waiting for mutex that's held
   elsewhere, or deadlock occurs
4. Network stack becomes unresponsive

Add mutex protection around interface iteration in both:
- mt7925_mac_reset_work(): Called during firmware recovery after MCU
  timeouts to reconnect all interfaces
- mt7925_roc_abort_sync(): Called during suspend/resume and when aborting
  Remain On Channel operations

This matches the pattern used elsewhere in the driver (e.g., in
mt7925_roc_iter, mt7925_mcu_set_suspend_iter, etc.) where interface
iteration callbacks invoke MCU functions.

Note: The author does not have deep familiarity with this codebase, but
this fix has been tested and appears to resolve the panic and deadlock
issues observed on Framework Desktop hardware with MT7925 WiFi cards.

Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3001a62a8b67..1f7661175623 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -459,10 +459,13 @@ void mt7925_roc_abort_sync(struct mt792x_dev *dev)
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
+		mt792x_mutex_acquire(dev);
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
 					     mt7925_roc_iter, (void *)phy);
+		mt792x_mutex_release(dev);
+	}
 }
 EXPORT_SYMBOL_GPL(mt7925_roc_abort_sync);
 
-- 
2.51.0


