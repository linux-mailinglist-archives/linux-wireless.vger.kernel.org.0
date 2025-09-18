Return-Path: <linux-wireless+bounces-27462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB61B830C1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169116278FC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF622BDC2C;
	Thu, 18 Sep 2025 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sd9ySms0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC000275AF6;
	Thu, 18 Sep 2025 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174783; cv=none; b=cRXMFOVGk7Go11i9uUsLEZRrC+tsPWk1maPzVao609PTSitumjMrEaTqXEM7npPK9KFKnsyhoatLWMwh6nei/DB/UdSKzfAWhul8NdguigazhiGuFILKRB8WbZTm4+7N3nIfvw4RHWX8oadVn1wFf6JqDrjGA9TlHFmZD1iStmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174783; c=relaxed/simple;
	bh=GwYVZcy596gzyNc2VgHDcFlrrDBaNOk0qlMl/in1hls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qtbucfGfdaZlL/i4qIQNuf4zYCf4pmOyB/R57m4tLBrD+7FqGXJ65MQt0hz0uZWDD9ax2du2tJb8QGCUMTQPXY8njU1YbP0NGUWyl7PGUJxPrtDJqljuGpFFXMMGSre+yEANpJp46Fy7OKE6zC6DH1lnMVhWFeuKDBeddCWc4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sd9ySms0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I5qhllF1506084, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758174763; bh=7k3xrY/76jMCx7vEC4W4oxjtFuGHv4YWX2H08cfo7qM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Sd9ySms0j6p+0sA8Bid549EEJ3vL3yHyqVV2s4X9Mci28WhttiJ5Pc4XgJTILf4tE
	 DNgxM7tUwv7TLNVT+qoFlsXIzOw+Hcu4ajPnWqEpnw4USo2wUxLeYygfhBrN3RX0yn
	 fqRQN2kRksAua6w6RBZFn9Z6yNWue+8py00eD6SQC7Hj7uQh2ELiO31bjzOvN9OIJy
	 Wm0xKA5dWqCkuJNkTxaTvqMT5wcNgM0hEHkZXsZ6a5nFX/ci3q09oAadBi30sUt3pF
	 Vb1FFiRZABuLgX+wTlSTq2muJdr9KHLTP9DaD3v8UfpD9AeunGUniEe1T5nMI+MxqA
	 ha2mFYfAIkbCA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I5qhllF1506084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:52:43 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 13:52:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 18 Sep 2025 13:52:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 18 Sep 2025 13:52:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking dependency in ser_state_run()
Thread-Topic: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking
 dependency in ser_state_run()
Thread-Index: AQHcJ7kTTR/KBtdLoUaQE6OfgOgcSbSYcHzw
Date: Thu, 18 Sep 2025 05:52:41 +0000
Message-ID: <0b56e5a8cd7048a19625764bc323ba46@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-5-pchelkin@ispras.ru>
In-Reply-To: <20250917095302.2908617-5-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Lockdep gives a splat [1] when ser_hdl_work item is executed.  It is
> scheduled at mac80211 workqueue via ieee80211_queue_work() and takes a
> wiphy lock inside.  However, this workqueue can be flushed when e.g.
> closing the interface and wiphy lock is already taken in that case.
>=20
> Choosing wiphy_work_queue() for SER is likely not suitable.  Back on to
> the global workqueue.
>=20
> [1]:
>=20
>  WARNING: possible circular locking dependency detected
>  6.17.0-rc2 #17 Not tainted
>  ------------------------------------------------------
>  kworker/u32:1/61 is trying to acquire lock:
>  ffff88811bc00768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ser_state_run+0x5e/=
0x180 [rtw89_core]
>=20
>  but task is already holding lock:
>  ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at=
:
> process_one_work+0x7b5/0x1450
>=20
>  which lock already depends on the new lock.
>=20
>  the existing dependency chain (in reverse order) is:
>=20
>  -> #2 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}:
>         process_one_work+0x7c6/0x1450
>         worker_thread+0x49e/0xd00
>         kthread+0x313/0x640
>         ret_from_fork+0x221/0x300
>         ret_from_fork_asm+0x1a/0x30
>=20
>  -> #1 ((wq_completion)phy0){+.+.}-{0:0}:
>         touch_wq_lockdep_map+0x8e/0x180
>         __flush_workqueue+0x129/0x10d0
>         ieee80211_stop_device+0xa8/0x110
>         ieee80211_do_stop+0x14ce/0x2880
>         ieee80211_stop+0x13a/0x2c0
>         __dev_close_many+0x18f/0x510
>         __dev_change_flags+0x25f/0x670
>         netif_change_flags+0x7b/0x160
>         do_setlink.isra.0+0x1640/0x35d0
>         rtnl_newlink+0xd8c/0x1d30
>         rtnetlink_rcv_msg+0x700/0xb80
>         netlink_rcv_skb+0x11d/0x350
>         netlink_unicast+0x49a/0x7a0
>         netlink_sendmsg+0x759/0xc20
>         ____sys_sendmsg+0x812/0xa00
>         ___sys_sendmsg+0xf7/0x180
>         __sys_sendmsg+0x11f/0x1b0
>         do_syscall_64+0xbb/0x360
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
>  -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
>         __lock_acquire+0x124c/0x1d20
>         lock_acquire+0x154/0x2e0
>         __mutex_lock+0x17b/0x12f0
>         ser_state_run+0x5e/0x180 [rtw89_core]
>         rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
>         process_one_work+0x82d/0x1450
>         worker_thread+0x49e/0xd00
>         kthread+0x313/0x640
>         ret_from_fork+0x221/0x300
>         ret_from_fork_asm+0x1a/0x30
>=20
>  other info that might help us debug this:
>=20
>  Chain exists of:
>    &rdev->wiphy.mtx --> (wq_completion)phy0 --> (work_completion)(&ser->s=
er_hdl_work)
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock((work_completion)(&ser->ser_hdl_work));
>                                 lock((wq_completion)phy0);
>                                 lock((work_completion)(&ser->ser_hdl_work=
));
>    lock(&rdev->wiphy.mtx);
>=20
>   *** DEADLOCK ***
>=20
>  2 locks held by kworker/u32:1/61:
>   #0: ffff888103835148 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one=
_work+0xefa/0x1450
>   #1: ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0=
}, at:
> process_one_work+0x7b5/0x1450
>=20
>  stack backtrace:
>  CPU: 0 UID: 0 PID: 61 Comm: kworker/u32:1 Not tainted 6.17.0-rc2 #17 PRE=
EMPT(voluntary)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-2025052=
3-14.fc42 05/23/2025
>  Workqueue: phy0 rtw89_ser_hdl_work [rtw89_core]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5d/0x80
>   print_circular_bug.cold+0x178/0x1be
>   check_noncircular+0x14c/0x170
>   __lock_acquire+0x124c/0x1d20
>   lock_acquire+0x154/0x2e0
>   __mutex_lock+0x17b/0x12f0
>   ser_state_run+0x5e/0x180 [rtw89_core]
>   rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
>   process_one_work+0x82d/0x1450
>   worker_thread+0x49e/0xd00
>   kthread+0x313/0x640
>   ret_from_fork+0x221/0x300
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: ebfc9199df05 ("wifi: rtw89: add wiphy_lock() to work that isn't he=
ld wiphy_lock() yet")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

By the way, you mark this patchset as 'rtw'. Does it mean this patchset is
urgent to you? If not, it will be more smooth (avoid possible merge conflic=
t)
if it goes via 'rtw-next'. Let me know your preference.=20


