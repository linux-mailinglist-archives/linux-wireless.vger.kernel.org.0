Return-Path: <linux-wireless+bounces-26465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0ECB2CC55
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120F617F91C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659530FF10;
	Tue, 19 Aug 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7DPGIvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3931577B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629170; cv=none; b=bSL9A1sp1C+zt5ZkdbRq1XEKS8Uyzzqrggim1WfA57O6gOwe3Q5CP7W1zUSVnV15kTAGu8DQpI2SpCv0qeK/XuWvc0yIJK3DObKnHCXCKOOLw6sBQbNHETQp6/XguZHwCiSqTJB9hTMjpu8GQ7trwrbGTeRylDROdM8bwPdj6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629170; c=relaxed/simple;
	bh=2J4Lm6LjR2i7Hjcf3pjuPapEPXAY3BO4tYyB1039Fq0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ueRGPmqc+3gQxw8EImML9x1/wj9DijzzRDssjvg+6c9pRuiWRJnrm97GtdafIyWM68uF6549bnovgEOkxdev610xza/U9KrZC3z4nKcY2ETop8WFPNgUwHT83nBMhARpLgNNc0hHCvQt85mbf0WimMaaUa3bSCa41WbNQy8II38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7DPGIvg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b004954so41928895e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629166; x=1756233966; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g1kjADxRIRMWttW3PZ9KQXR3fzoVl5lt+DzCXXaFCQ=;
        b=D7DPGIvgIlLj+MsfZQ/DWUGuaaj+ELlY08Wdbb5+BUi1r5hJieZVKesUyaDYm8YyHD
         Xm9+2Z0uXgemeZCXwFYhOxOohtQA9pdbwXvKbIEiG/4/x2MnWNGyxYZ6QYDnesS/ZQo5
         96nwee+7Jb+XefuaZfd/VedWjtB5vTIJrTCCbWj7XTIM4fQZzhKbnBhqGJ67n2utTuey
         y9wnYEbTZiz81iyBrpK23cJK3NLgIFH1r4fM/8X+o8pPmOcAiaXyZf/fX3MhAnj0aUjk
         IG7isxr6etCW8owcn6kL0AycDSXnzV0SkMWhFppB0FCNPbJGZShcgp69Rz7tINStS4p0
         7vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629166; x=1756233966;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2g1kjADxRIRMWttW3PZ9KQXR3fzoVl5lt+DzCXXaFCQ=;
        b=gUpI8bknMSalEMrwHg7mEDb+4TJROPMIcmHIVaWMp04B44PBkBrlhrc9D/P1ZNjlPg
         GD+8ywW1357SpkgNRWKs2WME7YGw1U/MDWTqXq+gBGZTg6VYqgyp9C7hDtPg8wY0BWdr
         G/CV/o02IuFoVNum/47ox1IWLb+nIdWp0tlRADyAK9HT78Hr3SJDKGlA2F7L61y1eYp8
         67AzfU/nlMPcdK22xaKphCO8VkTAr4DnbSv2MYdr1sJ50g/72cbMc4pDqPlFi2Zd6jZH
         R/Zt0gXjUwqsfSbSsWG1tel2JlR6rgegf8/kAiXn9/NP16gSI6f5c0cnf/BvhqlPcEEN
         w08A==
X-Gm-Message-State: AOJu0YypAX774Uhy/Cz3rvbnwrEsWooqBHnPFpyvnE4c/Rnmoxw774/N
	CDJm6qtFSXTtr740e5cvNO0xWRZR2V5nDvbhr67PUiFIGaguQ3zcQxFeAF2Rpg==
X-Gm-Gg: ASbGncv4lss0g1UuifmTJnnsrbL21VZpuz1/a5mrS6YEV3OtezSJJXFLKyHwFgm3LBJ
	FQbfBux1vSQ+IqRuWUITD7Z0jvJYYe8rRKogSdsy6B0RLWxQFXP4KPTcTVoko4+zBS0m9XlF/eC
	pW+/V4yoMGUD/TTi6ngn57NzrMZF/JnZixIs6KZhLBG5E/45uAKf7V2+/rXKKw/DCk/LxucbaqP
	j6SmfQFaem1D3zR4efuf9iRZdIuf2pLF5QRRO+bFgWHk75LImLWNGzF/l2zItFfShDQyIRATXwv
	svOd5TRonRfVqh8xYEXYiqDaMtoEHK9/C71PbYSFdJqtaWyJZ66rozgR9PRwPM9fuUxCUiVaKJG
	xyhgV/LDbqsVMX1i97POVwCcqsiq6XQ==
X-Google-Smtp-Source: AGHT+IEwQnaGLq88/oJWMSLCfunsK88xqf77547De/anTaHn5fGrP8ASGfgBeH+y8fQwuVLw6gvS+g==
X-Received: by 2002:a05:600c:1f83:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-45b43e10c10mr30948795e9.33.1755629166133;
        Tue, 19 Aug 2025 11:46:06 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74ad27sm235793595e9.18.2025.08.19.11.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 11:46:05 -0700 (PDT)
Message-ID: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
Date: Tue, 19 Aug 2025 21:46:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking for
 PCI too
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting
the LED") made rtw_led_set() sleep, but that's not allowed. Fix it by
using the brightness_set_blocking member of struct led_classdev for
PCI devices too. This one is allowed to sleep.

bad: scheduling from the idle thread!
nix kernel: CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G        W  O        6.16.0 #1-NixOS PREEMPT(voluntary)
nix kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
nix kernel: Hardware name: [REDACTED]
nix kernel: Call Trace:
nix kernel:  <IRQ>
nix kernel:  dump_stack_lvl+0x63/0x90
nix kernel:  dequeue_task_idle+0x2d/0x50
nix kernel:  __schedule+0x191/0x1310
nix kernel:  ? xas_load+0x11/0xd0
nix kernel:  schedule+0x2b/0xe0
nix kernel:  schedule_preempt_disabled+0x19/0x30
nix kernel:  __mutex_lock.constprop.0+0x3fd/0x7d0
nix kernel:  rtw_led_set+0x27/0x60 [rtw_core]
nix kernel:  led_blink_set_nosleep+0x56/0xb0
nix kernel:  led_trigger_blink+0x49/0x80
nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
nix kernel:  call_timer_fn+0x2f/0x140
nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
nix kernel:  __run_timers+0x21a/0x2b0
nix kernel:  run_timer_softirq+0x8e/0x100
nix kernel:  handle_softirqs+0xea/0x2c0
nix kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
nix kernel:  __irq_exit_rcu+0xdc/0x100
nix kernel:  sysvec_apic_timer_interrupt+0x7c/0x90
nix kernel:  </IRQ>
nix kernel:  <TASK>
nix kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
nix kernel: RIP: 0010:cpuidle_enter_state+0xcc/0x450
nix kernel: Code: 00 e8 08 7c 2e ff e8 d3 ee ff ff 49 89 c6 0f 1f 44 00 00 31 ff e8 c4 d1 2c ff 80 7d d7 00 0f 85 5d 02 00 00 fb 0f 1f 44 00 00 <45> 85 ff 0f 88 a0 01 00 00 49 63 f7 4c 89 f2 48 8d 0>
nix kernel: RSP: 0018:ffffd579801c7e68 EFLAGS: 00000246
nix kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
nix kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
nix kernel: RBP: ffffd579801c7ea0 R08: 0000000000000000 R09: 0000000000000000
nix kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff8eab0462a400
nix kernel: R13: ffffffff9a7d7a20 R14: 00000003aebe751d R15: 0000000000000003
nix kernel:  ? cpuidle_enter_state+0xbc/0x450
nix kernel:  cpuidle_enter+0x32/0x50
nix kernel:  do_idle+0x1b1/0x210
nix kernel:  cpu_startup_entry+0x2d/0x30
nix kernel:  start_secondary+0x118/0x140
nix kernel:  common_startup_64+0x13e/0x141
nix kernel:  </TASK>

Fixes: 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting the LED")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
I'm not sure if the commit hash will be correct by the time that
commit makes it into mainline?
---
 drivers/net/wireless/realtek/rtw88/led.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/led.c b/drivers/net/wireless/realtek/rtw88/led.c
index 7f9ace351a5b..4cc62e49d167 100644
--- a/drivers/net/wireless/realtek/rtw88/led.c
+++ b/drivers/net/wireless/realtek/rtw88/led.c
@@ -6,8 +6,8 @@
 #include "debug.h"
 #include "led.h"
 
-static void rtw_led_set(struct led_classdev *led,
-			enum led_brightness brightness)
+static int rtw_led_set(struct led_classdev *led,
+		       enum led_brightness brightness)
 {
 	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
 
@@ -16,12 +16,6 @@ static void rtw_led_set(struct led_classdev *led,
 	rtwdev->chip->ops->led_set(led, brightness);
 
 	mutex_unlock(&rtwdev->mutex);
-}
-
-static int rtw_led_set_blocking(struct led_classdev *led,
-				enum led_brightness brightness)
-{
-	rtw_led_set(led, brightness);
 
 	return 0;
 }
@@ -46,10 +40,7 @@ void rtw_led_init(struct rtw_dev *rtwdev)
 	if (!rtwdev->chip->ops->led_set)
 		return;
 
-	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
-		led->brightness_set = rtw_led_set;
-	else
-		led->brightness_set_blocking = rtw_led_set_blocking;
+	led->brightness_set_blocking = rtw_led_set;
 
 	snprintf(rtwdev->led_name, sizeof(rtwdev->led_name),
 		 "rtw88-%s", dev_name(rtwdev->dev));
-- 
2.50.1


