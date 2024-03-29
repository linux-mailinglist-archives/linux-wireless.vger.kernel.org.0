Return-Path: <linux-wireless+bounces-5531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724289165C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B5B224AC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478F2577A;
	Fri, 29 Mar 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Xc+qD7Ab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F422093
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705996; cv=none; b=fuNcxosxpyeq99LzjCjNzKHb5kpN7nI+0VDHq7HhPMlC4JeWX+9HHaKPhCDQ1FSeYX9pOrbxDQ+BchyUWAhR1OJnVibcfirsW73Ruz3bFFdLR87z37tO6/D0BWUW5qa9a3ocHdS8EdYKvnvcY/rnXU9X1DZHkK12sxMSnw306rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705996; c=relaxed/simple;
	bh=YZHV6Jhq7ixN7meNDgt3zc9af+PJBfQhSi6vGtJ+Va8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=ry8AAxeAEps1cWkn7L9HmTK5h2fxx8gp9dLl7dPbLMt1J7vFV50vyZ9ijOSUwyyCHD+QtwwHxIBXjaQon+HL+/jkYd+w4IkLwN/14kmpNktq0NH6tfjeOK34DMCRLsqUPndH1yAjSzSY5mgSG6JRkVSu0X0WN802hNe9jdOqTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Xc+qD7Ab; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:410d:0:640:81ab:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 6A05061774;
	Fri, 29 Mar 2024 12:47:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jlKueE1o64Y0-cfZqvBPF;
	Fri, 29 Mar 2024 12:47:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711705667; bh=GMHZwWjrhWcAXBsidj49S4mXS+pfMUM/YhH4AziqFww=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=Xc+qD7AbNzolBBCSQPS8mfS67UM97OBGiPkcBCPoa8G2+GrvU0oy/Ghl45+La0gkn
	 yqjc24+7Cpy39n10Jv5TAHik7gQMUhe70X7wBe5MZyOiitNXivHKAgWIRmBnkaWnYg
	 Vo73DqmZnQxqplFOWNMzVMBkbdGTvyF7IoR8sOEE=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4e07f032-ad77-4fdb-a5e6-40323cb39be2@yandex.ru>
Date: Fri, 29 Mar 2024 12:47:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>,
 syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com,
 linux-wireless@vger.kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH] wifi: mac80211: don't use rate mask for scanning
In-Reply-To: <20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 00:08, Johannes Berg wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The rate mask is intended for use during operation, and
> can be set to only have masks for the currently active
> band. As such, it cannot be used for scanning which can
> be on other bands as well.
> 
> Simply ignore the rate masks during scanning to avoid
> warnings from incorrect settings.
> 
> Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
> Co-developed-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Ugh. Fedor has reported (and I have confirmed) that this still may be
reproduced with https://syzkaller.appspot.com/text?tag=ReproC&x=12a8fd7f680000
as:

[   40.293787][ T5149] no supported rates for sta 08:02:11:00:00:01 (0xf, band 0) in rate_mask 0xfff with flags 0x10
[   40.294789][ T5149] WARNING: CPU: 1 PID: 5149 at net/mac80211/rate.c:380 __rate_control_send_low+0x6af/0x810
[   40.295624][ T5149] Modules linked in:
[   40.296369][ T5149] CPU: 1 PID: 5149 Comm: repro3 Not tainted 6.9.0-rc1-00179-g46ad21a6b2e3 #1
[   40.296918][ T5149] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
[   40.297534][ T5149] RIP: 0010:__rate_control_send_low+0x6af/0x810
[   40.297946][ T5149] Code: 8b ac a8 d4 00 00 00 e8 df 4d 4f f7 44 8b 44 24 04 45 89 f9 89 d9 48 8b 74 24 18 89 ea 48 c7 c7 60 68 4e 8c e8 62 a0 11 f7 90 <0f> 0b 90 90 e9 1f fd ff ff 48 8b 7c 24 28 
e8 ce 16 ab f7 e9 13 fc
[   40.299218][ T5149] RSP: 0018:ffffc9000350ed40 EFLAGS: 00010282
[   40.299624][ T5149] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8150f9b9
[   40.300192][ T5149] RDX: ffff88810b509cc0 RSI: ffffffff8150f9c6 RDI: 0000000000000001
[   40.300743][ T5149] RBP: 000000000000000f R08: 0000000000000001 R09: 0000000000000000
[   40.301291][ T5149] R10: 0000000000000000 R11: 0000000000000006 R12: ffff88801985f228
[   40.301812][ T5149] R13: ffff888107edb088 R14: 000000000000000c R15: 0000000000000010
[   40.302335][ T5149] FS:  00007f16474fe740(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
[   40.302945][ T5149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.303385][ T5149] CR2: 00007f16474ff0e8 CR3: 0000000109dc0000 CR4: 00000000000006f0
[   40.303957][ T5149] Call Trace:
[   40.304221][ T5149]  <TASK>
[   40.308220][ T5149]  rate_control_send_low+0x116/0x7e0
[   40.308786][ T5149]  rate_control_get_rate+0x1be/0x590
[   40.309153][ T5149]  ieee80211_tx_h_rate_ctrl+0xaa1/0x1a50
[   40.310581][ T5149]  invoke_tx_handlers_late+0x133b/0x2ae0
[   40.312476][ T5149]  ieee80211_tx+0x306/0x420
[   40.314290][ T5149]  ieee80211_xmit+0x30e/0x3e0
[   40.314651][ T5149]  __ieee80211_tx_skb_tid_band+0x29b/0x700
[   40.315090][ T5149]  ieee80211_tx_skb_tid+0x176/0x4f0
[   40.315483][ T5149]  ieee80211_mgmt_tx+0x129a/0x2160
[   40.315868][ T5149]  cfg80211_mlme_mgmt_tx+0x910/0x1570
[   40.316277][ T5149]  nl80211_tx_mgmt+0x7ad/0xcf0
[   40.317822][ T5149]  genl_family_rcv_msg_doit+0x205/0x2f0
[   40.319083][ T5149]  genl_rcv_msg+0x56c/0x810
[   40.321628][ T5149]  netlink_rcv_skb+0x16e/0x440
[   40.324076][ T5149]  genl_rcv+0x28/0x40
[   40.324359][ T5149]  netlink_unicast+0x545/0x820
[   40.325810][ T5149]  netlink_sendmsg+0x8b8/0xd70
[   40.327175][ T5149]  ____sys_sendmsg+0xacf/0xca0
[   40.328673][ T5149]  ___sys_sendmsg+0x135/0x1e0
[   40.330261][ T5149]  __sys_sendmsg+0x117/0x1f0
[   40.330761][ T5149]  do_syscall_64+0xd3/0x260
[   40.331047][ T5149]  entry_SYSCALL_64_after_hwframe+0x6d/0x75

Note that the backtrace is different and this
one comes from MLME rather than scanning.

Dmitry


