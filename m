Return-Path: <linux-wireless+bounces-26603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6FB350FB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 03:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065B25E3352
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8B223338;
	Tue, 26 Aug 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q1P1ARQR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB814A8B
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756171585; cv=none; b=tXBacvecF9L61Xyeq94Gj8QNpBBE3Q5GNl4ov36qiZhymtXs3eMbaKzGyBGJgXbq/ZfNO1l9zmIEzyU2bJtjymr63pX5VqR0NlYZtmJj5NjSg09Gh6U+3KBoF2DFHyfdf+YJiUk82eDaczwDW2AX/b8oRvM6P6soLRCho0WtCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756171585; c=relaxed/simple;
	bh=kjKDYrWMqflIMKFz4YXvNgD31IbMEySv+12wmTjaWJk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rDd24Ohdis8aXN8T2W4z/lp/mSmwo9Jk1rp4cPSD3ENrcWToKiIaRKxB3+6X1dgoJf8hmVwM/1t+VB0BDJk+dXQV/s+bY3X++h3y/3iDUtbWdfZtqRspD268ahl1TbiMUkH/ZwZL5MHKL4uNczwt+2xub3BCdiqv+/xG8YizpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q1P1ARQR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q1QIhpC708775, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756171578; bh=EqaiXGlICgy11fHyRn0mhEHSHh04BSF4NBvw2giJJ8Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Q1P1ARQRe73KK2eOp5Rn2QK9AYEquiXG6txmyd0i6yfz4mOe4LygCk+OLSqtA51Gu
	 tBMifbWcYeaAtLGFRVNhR0pkblgDEfPGMn+fDKhO4BEmaUybz2OwLnFVIajpUQ+kSO
	 lZjG+1iXDjkI6gRTRwLJWwCwsJHDWjUBNWdJmf2hZVaEsEqKhOANr6i+8r7WvPTduR
	 720sYXIPk3R/svabECGs3VxgWksPHpwbBHJP7C1TwVlhLJrUgdOetMYLpxORqRhpeQ
	 FhnVqU2lFOHIVpd7a3EG8aIF/W7RQXZpeP2g8l/XoX8gDdd+TXcC0z3i2rzobXvQjo
	 8VZHL9pGNV4qA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q1QIhpC708775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 09:26:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 09:26:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 09:26:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking for PCI too
In-Reply-To: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
References: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <908dfa8e-30df-4b33-9c52-d9a2c6cfcff7@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 26 Aug 2025 09:26:18 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Commit 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting
> the LED") made rtw_led_set() sleep, but that's not allowed. Fix it by
> using the brightness_set_blocking member of struct led_classdev for
> PCI devices too. This one is allowed to sleep.
> 
> bad: scheduling from the idle thread!
> nix kernel: CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G        W  O        6.16.0 #1-NixOS PREEMPT(voluntary)
> nix kernel: Tainted: [W]=WARN, [O]=OOT_MODULE
> nix kernel: Hardware name: [REDACTED]
> nix kernel: Call Trace:
> nix kernel:  <IRQ>
> nix kernel:  dump_stack_lvl+0x63/0x90
> nix kernel:  dequeue_task_idle+0x2d/0x50
> nix kernel:  __schedule+0x191/0x1310
> nix kernel:  ? xas_load+0x11/0xd0
> nix kernel:  schedule+0x2b/0xe0
> nix kernel:  schedule_preempt_disabled+0x19/0x30
> nix kernel:  __mutex_lock.constprop.0+0x3fd/0x7d0
> nix kernel:  rtw_led_set+0x27/0x60 [rtw_core]
> nix kernel:  led_blink_set_nosleep+0x56/0xb0
> nix kernel:  led_trigger_blink+0x49/0x80
> nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
> nix kernel:  call_timer_fn+0x2f/0x140
> nix kernel:  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211]
> nix kernel:  __run_timers+0x21a/0x2b0
> nix kernel:  run_timer_softirq+0x8e/0x100
> nix kernel:  handle_softirqs+0xea/0x2c0
> nix kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> nix kernel:  __irq_exit_rcu+0xdc/0x100
> nix kernel:  sysvec_apic_timer_interrupt+0x7c/0x90
> nix kernel:  </IRQ>
> nix kernel:  <TASK>
> nix kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> nix kernel: RIP: 0010:cpuidle_enter_state+0xcc/0x450
> nix kernel: Code: 00 e8 08 7c 2e ff e8 d3 ee ff ff 49 89 c6 0f 1f 44 00 00 31 ff e8 c4 d1 2c ff 80 7d d7 00 0f 85 5d 02 00 00 fb 0f 1f 44 00 00 <45> 85 ff 0f 88 a0 01 00 00 49 63 f7 4c 89 f2 48 8d 0>
> nix kernel: RSP: 0018:ffffd579801c7e68 EFLAGS: 00000246
> nix kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> nix kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> nix kernel: RBP: ffffd579801c7ea0 R08: 0000000000000000 R09: 0000000000000000
> nix kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffff8eab0462a400
> nix kernel: R13: ffffffff9a7d7a20 R14: 00000003aebe751d R15: 0000000000000003
> nix kernel:  ? cpuidle_enter_state+0xbc/0x450
> nix kernel:  cpuidle_enter+0x32/0x50
> nix kernel:  do_idle+0x1b1/0x210
> nix kernel:  cpu_startup_entry+0x2d/0x30
> nix kernel:  start_secondary+0x118/0x140
> nix kernel:  common_startup_64+0x13e/0x141
> nix kernel:  </TASK>
> 
> Fixes: 26a8bf978ae9 ("wifi: rtw88: Lock rtwdev->mutex before setting the LED")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

fce6fee0817b wifi: rtw88: Use led->brightness_set_blocking for PCI too

---
https://github.com/pkshih/rtw.git


