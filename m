Return-Path: <linux-wireless+bounces-5536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2708916FC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A00B2189D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA554F95;
	Fri, 29 Mar 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ugYAtzg6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B12E407
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708929; cv=none; b=AYehCULHl1ADDwK3i7unnszchBeIhSWYRVyCHHxIAGexMNMCLy9zAIGroocRD9UI55mnIoUY5ZPJleJkirRmKpZZ3h3gaPcpyaExi63Rma3VPrPabCBsKpQcH4v1RdqFnauH2QcOeVIHPR26TtHp337QnZAtllXAzpJgfy/p3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708929; c=relaxed/simple;
	bh=dydfzT7P3eRPdObCVoKHHNtPG7e1NmNCkrARIJkur+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eybiIbmT6Xh/u9fW88hhM/ERsmphNM7MQe9N/fxBDLMk7DgcJ7VDGTJ47ZuUCN+Qk2QB+aXtfg7G4R5c+NFYIcGtILwLqDQl5oL8eyd8f7saRlX3tam+zgyg7DF/uQbDf9Zih6sZSTGrTNg+TmF7WtsivXr22CT0CrxfP5Y/6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ugYAtzg6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nLGl+Bj9Bx1rJiTarQxrnX0/+CCQLZ/HMxrDgPMI/i4=;
	t=1711708926; x=1712918526; b=ugYAtzg6du4WpUtTj4b5sF/g15CP4C8EYR5DllqwVTJzTkk
	gmVOOJTcLdQPrM8t/l9zgBX3u69OOGelM5VEGWR1FUFi6MwWbX6PIUIlxg70T4teFI6dkVOXvx+/9
	GyRiNoBeUmolV4608E92mcJtDxA/RPezP8SOrMVzAHSt18rTc5HOHwagS7vNGdPOKYmzNFsDBYPyL
	y9FvcPl6YwNO6NVPmekhf7tCdmth3jX9SWo0Yf0MEeeXPnP33Jl5Oy3I4m32yB0ga95rho6flG/H8
	n2iETdGSV0XmcIgjDdDCOURffO4zfo/x+7RduOh8j+DVW9QZ7X9//P/U9VIfdWRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rq9gQ-00000002YQn-39h5;
	Fri, 29 Mar 2024 11:42:02 +0100
Message-ID: <aab14e8217d2c0ef821aa2af726ee1697043780d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: don't use rate mask for scanning
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com, 
	linux-wireless@vger.kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>, 
	"lvc-project@linuxtesting.org"
	 <lvc-project@linuxtesting.org>
Date: Fri, 29 Mar 2024 11:42:01 +0100
In-Reply-To: <4e07f032-ad77-4fdb-a5e6-40323cb39be2@yandex.ru>
References: 
	<20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid>
	 <4e07f032-ad77-4fdb-a5e6-40323cb39be2@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-03-29 at 12:47 +0300, Dmitry Antipov wrote:
> On 3/27/24 00:08, Johannes Berg wrote:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > The rate mask is intended for use during operation, and
> > can be set to only have masks for the currently active
> > band. As such, it cannot be used for scanning which can
> > be on other bands as well.
> >=20
> > Simply ignore the rate masks during scanning to avoid
> > warnings from incorrect settings.
> >=20
> > Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dfdc5123366fb9c3fdc6d
> > Co-developed-by: Dmitry Antipov <dmantipov@yandex.ru>
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Ugh. Fedor has reported (and I have confirmed) that this still may be
> reproduced with https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12a8f=
d7f680000
> as:
>=20
> [   40.293787][ T5149] no supported rates for sta 08:02:11:00:00:01 (0xf,=
 band 0) in rate_mask 0xfff with flags 0x10
> [   40.294789][ T5149] WARNING: CPU: 1 PID: 5149 at net/mac80211/rate.c:3=
80 __rate_control_send_low+0x6af/0x810
> [   40.295624][ T5149] Modules linked in:
> [   40.296369][ T5149] CPU: 1 PID: 5149 Comm: repro3 Not tainted 6.9.0-rc=
1-00179-g46ad21a6b2e3 #1
> [   40.296918][ T5149] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.3-1.fc39 04/01/2014
> [   40.297534][ T5149] RIP: 0010:__rate_control_send_low+0x6af/0x810
> [   40.297946][ T5149] Code: 8b ac a8 d4 00 00 00 e8 df 4d 4f f7 44 8b 44=
 24 04 45 89 f9 89 d9 48 8b 74 24 18 89 ea 48 c7 c7 60 68 4e 8c e8 62 a0 11=
 f7 90 <0f> 0b 90 90 e9 1f fd ff ff 48 8b 7c 24 28=20
> e8 ce 16 ab f7 e9 13 fc
> [   40.299218][ T5149] RSP: 0018:ffffc9000350ed40 EFLAGS: 00010282
> [   40.299624][ T5149] RAX: 0000000000000000 RBX: 0000000000000000 RCX: f=
fffffff8150f9b9
> [   40.300192][ T5149] RDX: ffff88810b509cc0 RSI: ffffffff8150f9c6 RDI: 0=
000000000000001
> [   40.300743][ T5149] RBP: 000000000000000f R08: 0000000000000001 R09: 0=
000000000000000
> [   40.301291][ T5149] R10: 0000000000000000 R11: 0000000000000006 R12: f=
fff88801985f228
> [   40.301812][ T5149] R13: ffff888107edb088 R14: 000000000000000c R15: 0=
000000000000010
> [   40.302335][ T5149] FS:  00007f16474fe740(0000) GS:ffff888135c00000(00=
00) knlGS:0000000000000000
> [   40.302945][ T5149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   40.303385][ T5149] CR2: 00007f16474ff0e8 CR3: 0000000109dc0000 CR4: 0=
0000000000006f0
> [   40.303957][ T5149] Call Trace:
> [   40.304221][ T5149]  <TASK>
> [   40.308220][ T5149]  rate_control_send_low+0x116/0x7e0
> [   40.308786][ T5149]  rate_control_get_rate+0x1be/0x590
> [   40.309153][ T5149]  ieee80211_tx_h_rate_ctrl+0xaa1/0x1a50
> [   40.310581][ T5149]  invoke_tx_handlers_late+0x133b/0x2ae0
> [   40.312476][ T5149]  ieee80211_tx+0x306/0x420
> [   40.314290][ T5149]  ieee80211_xmit+0x30e/0x3e0
> [   40.314651][ T5149]  __ieee80211_tx_skb_tid_band+0x29b/0x700
> [   40.315090][ T5149]  ieee80211_tx_skb_tid+0x176/0x4f0
> [   40.315483][ T5149]  ieee80211_mgmt_tx+0x129a/0x2160
> [   40.315868][ T5149]  cfg80211_mlme_mgmt_tx+0x910/0x1570
> [   40.316277][ T5149]  nl80211_tx_mgmt+0x7ad/0xcf0
> [   40.317822][ T5149]  genl_family_rcv_msg_doit+0x205/0x2f0
> [   40.319083][ T5149]  genl_rcv_msg+0x56c/0x810
> [   40.321628][ T5149]  netlink_rcv_skb+0x16e/0x440
> [   40.324076][ T5149]  genl_rcv+0x28/0x40
> [   40.324359][ T5149]  netlink_unicast+0x545/0x820
> [   40.325810][ T5149]  netlink_sendmsg+0x8b8/0xd70
> [   40.327175][ T5149]  ____sys_sendmsg+0xacf/0xca0
> [   40.328673][ T5149]  ___sys_sendmsg+0x135/0x1e0
> [   40.330261][ T5149]  __sys_sendmsg+0x117/0x1f0
> [   40.330761][ T5149]  do_syscall_64+0xd3/0x260
> [   40.331047][ T5149]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>=20
> Note that the backtrace is different and this
> one comes from MLME rather than scanning.
>=20

Yeah, that's not a huge surprise. I'll have to check where this comes
from, but chances are also there we shouldn't use the rate mask for all
the same reasons outlined previously for scanning.

johannes

