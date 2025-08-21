Return-Path: <linux-wireless+bounces-26526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC05B2FC23
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BC16C34B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBC22069A;
	Thu, 21 Aug 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8HJDQVw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C91F78E6
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785308; cv=none; b=Pm8A8h0Bu+iCbz263ouo1lqTgQ9hy18JeDWbVkrkrx3R5SaBeo5wedkQLpZEQR6dbxKVLASX3Fiw+zwV/q4ZFg8GiwYsxFar3P0kLi8gEDPh62CcLfMzuCyA5Xy1jPgBbRLSeOSxLBOK3b10vc+tQvlFfwf3wn1wJtCAiEZu55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785308; c=relaxed/simple;
	bh=B6BaXKPpufmYzoHe7gx9hMW4COlLdLcZFaWYUfankt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qr8UzxrO0N8MhNqyyEvM5yXJB3H29VPjYIJBNhXkIAHPmJK56Ui+NpVdRnQ8zv/JDDLKrqpUcZmtBL7xQjvJvHY5v+exhkxteDcMfxgTv3J8FThJHYm8FIG8BvcrjhynZDtkG9UofwLVKGuZS7EyjYaUp697cvCC6AWZltWlqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8HJDQVw; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f82a3a9eso9436451fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785305; x=1756390105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SggLUqp+aDgIsxocbiWuQ2N5x9BFxBqfhUeE9v32pHA=;
        b=N8HJDQVwK4TAOicCziQLCpK+eIZi6hx8VV9hpf1ZpjQcXIWlfhiIf6n2nB+EAsMW8v
         ZkB+8DkDKAFR2TivivUZNRAFo40wDTx3EdJKK/xZ1/tOopOW7S4qf8/GeEQ9oQMtABLC
         LjhQ+ghJcVebRULy8Q9xaw71RUL2Uu+3mywiZRmGlmum/L4KjHhtbl6lHlOj3/3ej8BA
         F+P3AvG7SKGu9f2f6Oddq48wxb5DhdvA8Meqx7GeyqYhv11udxzhndWwmymeZYyxFuG3
         e4+bySi5yFkV4KDAqrMcznydbEvVT8TmomGQjEaT/qozaGXQy0+WN9lZCWJvfen7FCWR
         wByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785305; x=1756390105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SggLUqp+aDgIsxocbiWuQ2N5x9BFxBqfhUeE9v32pHA=;
        b=LSe7Melf9pQrb8mmpQkazXhpw7LrEF6k2+7IGSDCjggOtUFQRs254jU7R7fzYWIk4H
         ktdE/dFcRibShO15i3cX4FbQc8vsYp+F+4PCWzFqwSS/BUOEbIsqozTbR4R2+Bjm8EaW
         9hqdPsRHFTi4wRQC2oXhSZCceorsfBNVSN0CpxJPbVvnrwkkPMdPkOTOpTRFLkhk/Sz6
         idMZmuhdnxvWMgQu6boxxmW2KkjxLefhEfWIar8vBhXDN8wbmpSm80wc7jetWpfXphc+
         OMweZcZEN/qerQfqa8HgyY2g8IlR5Vi3SXXuMnumW4htFxjpMtnEV8FOAhkLazlxwYW8
         ojgA==
X-Forwarded-Encrypted: i=1; AJvYcCUvX7H9RqDuzQ/zKgK6LS5CyHpwNZEVS9pC9xYUdR7RZYcLG2gWFMyQfI67GC2I5vL+cekOXn43bCRC8i2u7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+Yy1mtSkPBeVLUCB0JTkNza1Zaw0WY/W4y8ZHJV4sOKTNMaM
	pXObHqRCvJ3wIVtFUoJEdQThwdRTLxIWhSLFzbm5EfkMaaMe4U33uCdSQEUbqQ==
X-Gm-Gg: ASbGncuSq7kbmat7Sae0fx9hLGX1hLVb/OhkGaLouqM2CfNVmmJaPDIJZ0P65R4tH23
	4KC2NpXGVi8S5Eqh2ibUjqk0xmCgquMH1gNW/5fUntuzbU8tmOTTy49Z4GYe5f86k86AAr3Wi7X
	90Im01B3i2F9D/8YpaUuY+Lta7W2mcS+iKSOL+eRyq2gmf/6uyTqbk+Cts8pXiP0tTXscqsi8L6
	zzJjBRLhSbimp4yNjtwWTzILctxmUplkPAxFyK9WiB4QquvD9lYvCF2wwM5nLC7YJOAa1yNsEJd
	FkavF/WOupDkNIl7hc7g0mU9mnJKeaMbyPwgBqo21WrPgeuLd9mV8y+bHDI5PCfyfza+ZYf8oiU
	R3W8kRHldp5uKB0HX2lrayXc2QFOt0g==
X-Google-Smtp-Source: AGHT+IFWJA2w6cpPmcj4XidpU6GkJtkECy5s2g5n5GAvPHjAVDMVBl1AstY1boEGGlTkKzmyUjThWQ==
X-Received: by 2002:a05:651c:1541:b0:333:b9db:f994 with SMTP id 38308e7fff4ca-3354a462257mr8793211fa.6.1755785304580;
        Thu, 21 Aug 2025 07:08:24 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a646edcsm31422311fa.71.2025.08.21.07.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:08:24 -0700 (PDT)
Message-ID: <c4b1d9c4-59c1-4508-ad3d-3a3e0d3f7ee7@gmail.com>
Date: Thu, 21 Aug 2025 17:08:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking
 for PCI too
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
 <aba7583da5fc48bca933d4b5d2fae6aa@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <aba7583da5fc48bca933d4b5d2fae6aa@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2025 03:26, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Commit 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting
>> the LED") made rtw_led_set() sleep, but that's not allowed. Fix it by
>> using the brightness_set_blocking member of struct led_classdev for
>> PCI devices too. This one is allowed to sleep.
>>
>> bad: scheduling from the idle thread!
>> nix kernel: CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G        W  O        6.16.0 #1-NixOS
>> PREEMPT(voluntary)
>> nix kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
>> nix kernel: Hardware name: [REDACTED]
>> nix kernel: Call Trace:
>> nix kernel:  <IRQ>
>> nix kernel:  dump_stack_lvl+0x63/0x90
>> nix kernel:  dequeue_task_idle+0x2d/0x50
>> nix kernel:  __schedule+0x191/0x1310
>> nix kernel:  ? xas_load+0x11/0xd0
>> nix kernel:  schedule+0x2b/0xe0
>> nix kernel:  schedule_preempt_disabled+0x19/0x30
>> nix kernel:  __mutex_lock.constprop.0+0x3fd/0x7d0
>> nix kernel:  rtw_led_set+0x27/0x60 [rtw_core]
>> nix kernel:  led_blink_set_nosleep+0x56/0xb0
>> nix kernel:  led_trigger_blink+0x49/0x80
>> nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
>> nix kernel:  call_timer_fn+0x2f/0x140
>> nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
>> nix kernel:  __run_timers+0x21a/0x2b0
>> nix kernel:  run_timer_softirq+0x8e/0x100
>> nix kernel:  handle_softirqs+0xea/0x2c0
>> nix kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
>> nix kernel:  __irq_exit_rcu+0xdc/0x100
>> nix kernel:  sysvec_apic_timer_interrupt+0x7c/0x90
>> nix kernel:  </IRQ>
>> nix kernel:  <TASK>
>> nix kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> nix kernel: RIP: 0010:cpuidle_enter_state+0xcc/0x450
>> nix kernel: Code: 00 e8 08 7c 2e ff e8 d3 ee ff ff 49 89 c6 0f 1f 44 00 00 31 ff e8 c4 d1 2c ff 80 7d d7
>> 00 0f 85 5d 02 00 00 fb 0f 1f 44 00 00 <45> 85 ff 0f 88 a0 01 00 00 49 63 f7 4c 89 f2 48 8d 0>
>> nix kernel: RSP: 0018:ffffd579801c7e68 EFLAGS: 00000246
>> nix kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
>> nix kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> nix kernel: RBP: ffffd579801c7ea0 R08: 0000000000000000 R09: 0000000000000000
>> nix kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff8eab0462a400
>> nix kernel: R13: ffffffff9a7d7a20 R14: 00000003aebe751d R15: 0000000000000003
>> nix kernel:  ? cpuidle_enter_state+0xbc/0x450
>> nix kernel:  cpuidle_enter+0x32/0x50
>> nix kernel:  do_idle+0x1b1/0x210
>> nix kernel:  cpu_startup_entry+0x2d/0x30
>> nix kernel:  start_secondary+0x118/0x140
>> nix kernel:  common_startup_64+0x13e/0x141
>> nix kernel:  </TASK>
>>
>> Fixes: 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting the LED")
> 
> Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>> I'm not sure if the commit hash will be correct by the time that
>> commit makes it into mainline?
> 
> We always go via wireless / wireless-next tree, so the commit must be there
> already. Only question is that you want 6.17 (currently -rc2) or 6.18 (next)?
> I think this should be 6.17, so tree selection of subject tag should be
> "rtw" instead of "rtw-next". 
> 
> 

Commit 26a8bf978ae9 is not in wireless-next yet, only in rtw-next.

