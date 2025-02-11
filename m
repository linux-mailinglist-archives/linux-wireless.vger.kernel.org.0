Return-Path: <linux-wireless+bounces-18732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0187A2FFB2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 01:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909661882D61
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79E1CD1E0;
	Tue, 11 Feb 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ljW6Y6U8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B21E376C
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234774; cv=none; b=nNEGBAF6GR4nC+F4U2RYPgilk356OEJYEeCWhaInGtdYeB0pz3MmFqnS3sbuITCzFDY0KeGdlNLozJCko25E/0g8L46DPgWgfQWfSkHdfvAayFJznjGrtSwrucqNpBAkleLMKuy+VeMqIy039SDQGpcZfQe0xU1QRtlys63TUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234774; c=relaxed/simple;
	bh=Tt/rd17NatLTE2W3kWHSLqEpP8hB3ERZv1z4DlU10JE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8GK3s9uELMLrqUBTgcnRgyxAV9mDjdc2qW8MphLkrTC6BildqzAAIwsO/f8c+OXcTEFTpe3HIzfb02GiqDvUdoBIjNnepw99LeAmDnto6jiz4tSXPtZmu9uNyNDWqR+oFBcVR9NmQvwlDzRlpEEMu/PgtMbcepPRv03gPOtotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ljW6Y6U8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51B0jjT433227073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739234745; bh=Tt/rd17NatLTE2W3kWHSLqEpP8hB3ERZv1z4DlU10JE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ljW6Y6U8SN2N+bpTPZMNCi+vKnVQzF7FJBMPmORo/Qvct18bWWKmoA8HP4Jk9dmSr
	 teAux3OGcRDtB+QqVAUMy0gWj/8hwuhVCWYiceScbWCEZjT2L0+srpXOfoAvjK0aCm
	 c9i4HKGOR01L9XtsFBltVrih0qXctTVxwxu8Z3W1qlZXZBpjBaQKAEt1hZr8EpBZJR
	 LT8TTfx0IgkgQjO2mXMSmTBJrdehMclpcn5nE7tm4yiLW018zffcTBsZLH1JNMl8WR
	 bQqMohf24mPfLEWVm97+l3m05vD2oLeFEpJYLegI+0fcvVeEF3ili+J1TB8f8aAChZ
	 NYCoJay9U6JsA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51B0jjT433227073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 08:45:45 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 08:45:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Feb 2025 08:45:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 11 Feb 2025 08:45:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "petter@technux.se" <petter@technux.se>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        Linux wireless <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: 8821au: locking issues possible caused by firmware failed to leave lps state / failed to get tx report
Thread-Topic: rtw88: 8821au: locking issues possible caused by firmware failed
 to leave lps state / failed to get tx report
Thread-Index: AQHbe5nd20FWaLjZJEqRgphPuzJQObNBQnuQ
Date: Tue, 11 Feb 2025 00:45:44 +0000
Message-ID: <ff0487ce0bff400b819d8d8d55a04f19@realtek.com>
References: <84d07bb6109ae42ce4e708d6e293f6de@technux.se>
 <110cbd37e935161dbe0039a708f6428d@technux.se>
In-Reply-To: <110cbd37e935161dbe0039a708f6428d@technux.se>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

petter@technux.se <petter@technux.se> wrote:
>=20
> I have seen some issues with the LM808 dongle (8821au). I'm running
> 6.12.12 kernel with all missing rtw88 patches cherry-picked from latest
> Linux-wireless main track. The dongle seems to be working fine most of
> the time, when running traffic and load it, but sometimes during low
> traffic/idle I can see below crash that loop around. Any good ideas what
> is going on here? (running on armhf based platform)

Can you try the latest kernel?=20

>=20
> BR Petter
>=20
> Issue 1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Feb 08 10:32:08 machine kernel: rtw_8821au 1-1:1.0: firmware failed to
> leave lps state
> Feb 08 10:32:08 machine kernel:
> Feb 08 10:32:08 machine kernel:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Feb 08 10:32:08 machine kernel: WARNING: possible recursive locking
> detected
> Feb 08 10:32:08 machine kernel: 6.12.12-g8e187440f820 #0 Not tainted
> Feb 08 10:32:08 machine kernel:
> --------------------------------------------
> Feb 08 10:32:08 machine kernel: kworker/u4:4/25 is trying to acquire
> lock:
> Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3},
> at: rtw_leave_lps+0x1d4/0x208 [rtw88_core]
> Feb 08 10:32:08 machine kernel:
>                                but task is already holding lock:
> Feb 08 10:32:08 machine kernel: c4d8f050 (&rtwdev->mutex){+.+.}-{3:3},
> at: rtw_watch_dog_work+0x44/0x2e8 [rtw88_core]
> Feb 08 10:32:08 machine kernel:
>                                other info that might help us debug this:
> Feb 08 10:32:08 machine kernel:  Possible unsafe locking scenario:
> Feb 08 10:32:08 machine kernel:        CPU0
> Feb 08 10:32:08 machine kernel:        ----
> Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
> Feb 08 10:32:08 machine kernel:   lock(&rtwdev->mutex);
> Feb 08 10:32:08 machine kernel:
>                                 *** DEADLOCK ***
> Feb 08 10:32:08 machine kernel:  May be due to missing lock nesting
> notation
> Feb 08 10:32:08 machine kernel: 3 locks held by kworker/u4:4/25:
> Feb 08 10:32:08 machine kernel:  #0: c4eb64b4
> ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x1ac/0x71c
> Feb 08 10:32:08 machine kernel:  #1: f090df20
> ((work_completion)(&(&rtwdev->watch_dog_work)->work)){+.+.}-{0:0}, at:
> process_one_work+0x1d8/0x71c
> Feb 08 10:32:08 machine kernel:  #2: c4d8f050
> (&rtwdev->mutex){+.+.}-{3:3}, at: rtw_watch_dog_work+0x44/0x2e8
> [rtw88_core]

There is a mutex_lock(&rtwdev->mutex) at rtw_watch_dog_work() obviously, bu=
t
I can't find rtw_leave_lps() tries to hold a lock. Could you use addr2line =
to
address where rtw_leave_lps+0x1d4/0x208 locate?=20


>=20
> Issue 2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Feb 07 20:23:45 machine kernel: rtw_8821au 1-1:1.0: firmware failed to
> leave lps state
> Feb 07 20:23:46 machine kernel: rtw_8821au 1-1:1.0: failed to get tx
> report from firmware
> Feb 07 20:23:46 machine kernel: BUG: scheduling while atomic:
> swapper/0/0/0x00000103
> Feb 07 20:23:46 machine kernel: INFO: lockdep is turned off.
> Feb 07 20:23:46 machine kernel: Modules linked in: rtw88_8821au
> rtw88_8821a rtw88_88xxa rtw88_usb rtw88_core mac80211 libarc4 cfg80211
> imx_sdma ip_tables x_tables
> Feb 07 20:23:46 machine kernel: irq event stamp: 10781843
> Feb 07 20:23:46 machine kernel: hardirqs last  enabled at (10781842):
> [<c0100c58>] __irq_svc+0xb8/0xd4
> Feb 07 20:23:46 machine kernel: hardirqs last disabled at (10781843):
> [<c0dcf33c>] _raw_spin_lock_irqsave+0x64/0x68
> Feb 07 20:23:46 machine kernel: softirqs last  enabled at (10781808):
> [<c012cbbc>] handle_softirqs+0x2b4/0x4a8
> Feb 07 20:23:46 machine kernel: softirqs last disabled at (10781821):
> [<c012cf30>] __irq_exit_rcu+0x12c/0x198
> Feb 07 20:23:46 machine kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not
> tainted 6.12.12-g8e187440f820 #0
> Feb 07 20:23:46 machine kernel: Hardware name: Freescale i.MX6 SoloX
> (Device Tree)
> Feb 07 20:23:46 machine kernel: Call trace:
> Feb 07 20:23:46 machine kernel:  unwind_backtrace from
> show_stack+0x10/0x14
> Feb 07 20:23:46 machine kernel:  show_stack from
> dump_stack_lvl+0x88/0xb8
> Feb 07 20:23:46 machine kernel:  dump_stack_lvl from
> __schedule_bug+0x64/0x84
> Feb 07 20:23:46 machine kernel:  __schedule_bug from
> __schedule+0x944/0xc70
> Feb 07 20:23:46 machine kernel:  __schedule from schedule+0x50/0x130
> Feb 07 20:23:46 machine kernel:  schedule from
> schedule_preempt_disabled+0x1c/0x2c
> Feb 07 20:23:46 machine kernel:  schedule_preempt_disabled from
> __mutex_lock+0x7d4/0x914
> Feb 07 20:23:46 machine kernel:  __mutex_lock from
> mutex_lock_nested+0x1c/0x24
> Feb 07 20:23:46 machine kernel:  mutex_lock_nested from
> rtw_tx_report_purge_timer+0x44/0x74 [rtw88_core]
> Feb 07 20:23:46 machine kernel:  rtw_tx_report_purge_timer [rtw88_core]
> from call_timer_fn+0xb4/0x310
> Feb 07 20:23:46 machine kernel:  call_timer_fn from
> __run_timers+0x278/0x324
> Feb 07 20:23:46 machine kernel:  __run_timers from
> run_timer_base+0x4c/0x6c
> Feb 07 20:23:46 machine kernel:  run_timer_base from
> run_timer_softirq+0x14/0x38
> Feb 07 20:23:46 machine kernel:  run_timer_softirq from
> handle_softirqs+0x160/0x4a8
> Feb 07 20:23:46 machine kernel:  handle_softirqs from
> __irq_exit_rcu+0x12c/0x198
> Feb 07 20:23:46 machine kernel:  __irq_exit_rcu from irq_exit+0x8/0x28
> Feb 07 20:23:46 machine kernel:  irq_exit from __irq_svc+0x90/0xd4
> Feb 07 20:23:46 machine kernel: Exception stack(0xc1401f48 to

rtw_tx_report_purge_timer() is a timer handler in BH context, so sleeping
is disallowed. I also can't find where it tries to hold a lock.
Please help to point out where rtw_tx_report_purge_timer+0x44/0x74 is.=20




