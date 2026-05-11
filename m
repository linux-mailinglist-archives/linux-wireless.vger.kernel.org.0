Return-Path: <linux-wireless+bounces-36211-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIIVOUaYAWomfgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36211-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:50:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28450A54F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 10:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FB230071E8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099A3B3BF0;
	Mon, 11 May 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QJvoOsSX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CE3803EB;
	Mon, 11 May 2026 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488981; cv=none; b=jnCbKDhLQbtqORZhVtQCgesWcIdfoyDuQmbvv3fWqS1dvkwTvWiLyUtzO7OaocT6EubucytNri415Ct3XLo1384AaT6qrEg68i84/7KxoiN/1KmvKf6cQAU9VXOGmG7lJ/y0dAXwcruTWJ2Yua2qbbO6qj2dbcWoA9u63LZlZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488981; c=relaxed/simple;
	bh=qjylKIBc5KinUUjxo7Y/aTLegs0v1G2kqDTtxsBiSvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTe+N8PhI+CXbGYqKGwEexNH4qZMis6LAGcWSGAdU19ljQXh4bMaAH2yUDzQ/WxFalWGZNNXRjVWpngubbSGTLlCXF6Pmb2EJ6CGVmr4i8BD8sf1f1oi/MFqAjQDs+x2Z7CE0+3PapBm1oCfdUxbDwWRgOG5tqa2Plj87UDZzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QJvoOsSX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XwL3IDuqaomcFx34nmfwW2LzMKHeaT4hfv7erpJXnj8=;
	t=1778488978; x=1779698578; b=QJvoOsSX50Yz6CiOJsNp5NbWRt6n6CE92PTnKS0X5qrgXDb
	IxSqv48fvsJrgT1qV1gaqBwtn4+E+OEVX9Sld66xnZyX7YbbcCgMLM+529CLqpEAa1TuVOyOOHqBv
	/ZCpJuGDThDgEfq7mL8ES61GkVFqJXq2/M8iRpVyOvwlQrdmCpAAsdKittMQ98QJaMQwyYAS9mUNN
	AuHOO9BFnGOLR4a1EZCk4iowwpzwNjxO9Cj2lHEEzx0zvhgeKRzgGNfs1hhVWp44d1cgcuhK/Dbu2
	U7KQOvPEyVY+qsdizNfuyNf0VHP7wK1RIij+98uYFgJ1M0CipDGep0hLtnuzOhCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMME3-0000000Ebsw-12Hs;
	Mon, 11 May 2026 10:42:55 +0200
Message-ID: <167a6eb4b9fd7c5f547f3b97a025ecc2705e3b8b.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_sta_current_bw
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>, syzbot
	 <syzbot+e2a0da81361722f4df3b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Mon, 11 May 2026 10:42:54 +0200
In-Reply-To: <64ddfb37q7ll3uyxbf3vuaicurz2p2lwqf5shnoepk53bucsll@o6uvujysizof> (sfid-20260511_042248_770794_A9B8EEF3)
References: <6a00ff4e.170a0220.1c0296.021e.GAE@google.com>
	 <64ddfb37q7ll3uyxbf3vuaicurz2p2lwqf5shnoepk53bucsll@o6uvujysizof>
	 (sfid-20260511_042248_770794_A9B8EEF3)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 1E28450A54F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36211-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,e2a0da81361722f4df3b];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hi Lachlan,

On Mon, 2026-05-11 at 12:22 +1000, Lachlan Hodges wrote:
> > WARNING: ./include/net/mac80211.h:8114 at ieee80211_chan_width_to_rx_bw=
 include/net/mac80211.h:8114 [inline], CPU#1: syz.4.4769/22510
> > WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw_tx_t=
o_sta net/mac80211/sta_info.c:3719 [inline], CPU#1: syz.4.4769/22510
> > WARNING: ./include/net/mac80211.h:8114 at ieee80211_sta_current_bw+0x36=
d/0x510 net/mac80211/sta_info.c:3745, CPU#1: syz.4.4769/22510
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 22510 Comm: syz.4.4769 Not tainted syzkaller #0 PREE=
MPT(full)=20
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 04/18/2026
> > RIP: 0010:ieee80211_chan_width_to_rx_bw include/net/mac80211.h:8114 [in=
line]
> > RIP: 0010:ieee80211_sta_current_bw_tx_to_sta net/mac80211/sta_info.c:37=
19 [inline]
> > RIP: 0010:ieee80211_sta_current_bw+0x36d/0x510 net/mac80211/sta_info.c:=
3745
> > Code: 00 00 00 eb 49 41 83 fe 05 74 30 41 83 fe 0d 75 13 e8 47 8f af f6=
 b8 04 00 00 00 eb 31 e8 3b 8f af f6 eb 28 e8 34 8f af f6 90 <0f> 0b 90 eb =
1d e8 29 8f af f6 b8 02 00 00 00 eb 13 e8 1d 8f af f6
> > RSP: 0018:ffffc90006f4eed8 EFLAGS: 00010283
> > RAX: ffffffff8b161cfc RBX: 1ffff1100d1da030 RCX: 0000000000080000
> > RDX: ffffc9000e5d2000 RSI: 0000000000000e31 RDI: 0000000000000e32
> > RBP: 0000000000000004 R08: ffff888054ad5c40 R09: 0000000000000007
> > R10: 000000000000000d R11: 0000000000000002 R12: ffff888068ed0180
> > R13: dffffc0000000000 R14: 0000000000000007 R15: 0000000000000000
> > FS:  00007fe58f5f66c0(0000) GS:ffff888125389000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000110c2c8823 CR3: 0000000038486000 CR4: 00000000003526f0
>=20
> This looks to be 10MHz given R14 =3D 7 which seems to be the operand
> being compared I think. The 2 patches I sent the other week should
> fix this occuring for any S1G bandwidths, not sure about 5 and 10MHz.

Thanks for taking a look at this! I'll apply those soon, seems the test
bot got stuck again.

> Atleast for this situation, it would be the same - we don't wanna
> recalc the mindef for 5 and 10MHz since the mindef isn't recalculated
> for 5/10MHz like S1G. But then I'm not sure the S1G workaround for
> ieee80211_sta_init_nss_bw_capa since maybe nss might be greater than
> 1 for 5/10MHz?

Technically, yes. However, 5/10 is pretty much unreachable in practice.
I had proposed removing it a long time ago, we should probably just do
that...

johannes

