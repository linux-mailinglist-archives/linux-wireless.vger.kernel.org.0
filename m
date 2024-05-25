Return-Path: <linux-wireless+bounces-8060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296538CEE69
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF42818D7
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7409E54D;
	Sat, 25 May 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZhyibm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E83DDC4
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716631294; cv=none; b=rqfqb+zNsh2D1gqSBfazj4B2QLJl8duJR3zHKR5Lvvg3Gc5hfwwSNbv4q7JcaTLoTlUGK5X3Zyw02HPtRL8Ryl1xKMshEO+apgWJLyzm5ALhf2uQJVkR0JGN9tSbWypLvCPvpoFUdhShBgS6LYbBWpknfry7UJBAOAd/mHE9Fns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716631294; c=relaxed/simple;
	bh=S0SHdYS9UNoUMOP734Arqb8be//jKkeLc+re/LWGCP4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pO5lIKRT1U6do38frIyacTUCa95eToWmLRUCXoEbq8HKPRXZgCeX9Xhb9gMnlazbAoK+DJdUE9O4TfZztcLMpYyTWVc8WNaOeGAqA8rpJW+jX9ymPfm8V/aO6iHtpGmJUa39XGIc5xxi20QRrU3UP3Y5RkbTYWGxjyTcio7kH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZhyibm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38845C2BD11;
	Sat, 25 May 2024 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716631294;
	bh=S0SHdYS9UNoUMOP734Arqb8be//jKkeLc+re/LWGCP4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iZhyibm2F6YPe56ejWniH2yAr7g4ANffe7QohK+KKLDbeW2283t/hycH4UxGlWgGx
	 9tH0u0n3QlpGD+awirfyQl9Zn+bYn6sp2Kye5kdCuJeI0PsI+fyXXOo+nto+YR6IUq
	 IolWOCsEUNgFZ0c/ZJHVCRPQhoyKNMXgw+eXPy8Q1oXsZaVjfzMVjhb4jxJ4AC0YfC
	 fol7Uvrz0+z6WziLaL9km7ost2Xff80WnV/co73XmiONZmgqK5Kn1Ar5PGQNTfcL1B
	 BuVyn+1YSA+oW818fXfDC0cXbe7qVm557s4nqui/eHwuNeBBTddwP6vWsAOtuaIRyb
	 R2RLSE+zyWhRA==
From: Kalle Valo <kvalo@kernel.org>
To: <kevin_yang@realtek.com>
Cc: <johannes@sipsolutions.net>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
References: <20240523082200.15544-1-kevin_yang@realtek.com>
Date: Sat, 25 May 2024 13:01:31 +0300
In-Reply-To: <20240523082200.15544-1-kevin_yang@realtek.com> (kevin yang's
	message of "Thu, 23 May 2024 16:22:00 +0800")
Message-ID: <874jamnrb8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<kevin_yang@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> In MLD connection, link_data/link_conf are dynamically allocated. They
> don't point to vif->bss_conf. So, there will be no chanreq assigned to
> vif->bss_conf and then the chan will be NULL. To get deflink's chanreq,
> we change the code to access vif->link_conf with deflink's link id.
>
> This way should also work in non-MLD connection, because non-MLD deflink
> link id should be 0 and non-MLD link_conf[0] will point to vif->bss_conf.
>
> Crash log (with rtw89 version under MLO development):
> [ 9890.526087] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 9890.526102] #PF: supervisor read access in kernel mode
> [ 9890.526105] #PF: error_code(0x0000) - not-present page
> [ 9890.526109] PGD 0 P4D 0
> [ 9890.526114] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 9890.526119] CPU: 2 PID: 6367 Comm: kworker/u16:2 Kdump: loaded Tainted: G           OE      6.9.0 #1
> [ 9890.526123] Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB3WW (2.73 ) 11/28/2018
> [ 9890.526126] Workqueue: phy2 rtw89_core_ba_work [rtw89_core]
> [ 9890.526203] RIP: 0010:ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211
> [ 9890.526279] Code: f7 e8 d5 93 3e ea 48 83 c4 28 89 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 49 8b 84 24 e0 f1 ff ff 48 8b 80 90 1b 00 00 <83> 38 03 0f 84 37 fe ff ff bb ea ff ff ff eb cc 49 8b 84 24 10 f3
> All code
> ========
>    0:	f7 e8                	imul   %eax
>    2:	d5                   	(bad)
>    3:	93                   	xchg   %eax,%ebx
>    4:	3e ea                	ds (bad)
>    6:	48 83 c4 28          	add    $0x28,%rsp
>    a:	89 d8                	mov    %ebx,%eax
>    c:	5b                   	pop    %rbx
>    d:	41 5c                	pop    %r12
>    f:	41 5d                	pop    %r13
>   11:	41 5e                	pop    %r14
>   13:	41 5f                	pop    %r15
>   15:	5d                   	pop    %rbp
>   16:	c3                   	retq
>   17:	cc                   	int3
>   18:	cc                   	int3
>   19:	cc                   	int3
>   1a:	cc                   	int3
>   1b:	49 8b 84 24 e0 f1 ff 	mov    -0xe20(%r12),%rax
>   22:	ff
>   23:	48 8b 80 90 1b 00 00 	mov    0x1b90(%rax),%rax
>   2a:*	83 38 03             	cmpl   $0x3,(%rax)		<-- trapping instruction
>   2d:	0f 84 37 fe ff ff    	je     0xfffffffffffffe6a
>   33:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
>   38:	eb cc                	jmp    0x6
>   3a:	49                   	rex.WB
>   3b:	8b                   	.byte 0x8b
>   3c:	84 24 10             	test   %ah,(%rax,%rdx,1)
>   3f:	f3                   	repz
>
> Code starting with the faulting instruction
> ===========================================
>    0:	83 38 03             	cmpl   $0x3,(%rax)
>    3:	0f 84 37 fe ff ff    	je     0xfffffffffffffe40
>    9:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
>    e:	eb cc                	jmp    0xffffffffffffffdc
>   10:	49                   	rex.WB
>   11:	8b                   	.byte 0x8b
>   12:	84 24 10             	test   %ah,(%rax,%rdx,1)
>   15:	f3                   	repz
> [ 9890.526285] RSP: 0018:ffffb8db09013d68 EFLAGS: 00010246
> [ 9890.526291] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9308e0d656c8
> [ 9890.526295] RDX: 0000000000000000 RSI: ffffffffab99460b RDI: ffffffffab9a7685
> [ 9890.526300] RBP: ffffb8db09013db8 R08: 0000000000000000 R09: 0000000000000873
> [ 9890.526304] R10: ffff9308e0d64800 R11: 0000000000000002 R12: ffff9308e5ff6e70
> [ 9890.526308] R13: ffff930952500e20 R14: ffff9309192a8c00 R15: 0000000000000000
> [ 9890.526313] FS:  0000000000000000(0000) GS:ffff930b4e700000(0000) knlGS:0000000000000000
> [ 9890.526316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9890.526318] CR2: 0000000000000000 CR3: 0000000391c58005 CR4: 00000000001706f0
> [ 9890.526321] Call Trace:
> [ 9890.526324]  <TASK>
> [ 9890.526327] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 9890.526335] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
> [ 9890.526340] ? page_fault_oops (arch/x86/mm/fault.c:713)
> [ 9890.526347] ? search_module_extables (kernel/module/main.c:3256 (discriminator 3))
> [ 9890.526353] ? ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>

Kevin's s-o-b missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

