Return-Path: <linux-wireless+bounces-22242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150CAA4A46
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A2F4608AF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F784E1C;
	Wed, 30 Apr 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gmNk0Q7Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040E23507A
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746013130; cv=none; b=tvyszUWUws9SvK/QeRv+1hSruNLls6KNbSYkU2bU3zVywutH1qYalvuq9SIXFSWHAkSMZrpBTAgKNrRV0l7lqT9CZG833GYjP94LZ9U8lAocDAhmsJt7vGdVrvhilX7UoRBx4FaxTI5hDWIgtBIQRbhkM3BLhOxho6TGNbK5/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746013130; c=relaxed/simple;
	bh=9AnckJCG6gd1plf0Q0XYwEs3W0fyuV9EhX+8WgPI8dY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYSEJurqUhw1b+jW0PfU53Nby1FBd9HQCuwGFUTsjuo+yJWmI/8WFb6TIFuyc8g69Lhy8an23Y0dQ63EUMBeF5YYxbnceq5SdoKzJbpJemR7e48rl9bQL8WCVnABuwDJ9j8nNIGEMMJTys719ye70OzJcBj2H1WOMP4iqcU4v8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gmNk0Q7Z; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1746013120; x=1746272320;
	bh=0EFiUKiTKgq2MElHwvfQI4NNLvqB0a2OzXcjGOEO/JI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gmNk0Q7Z4Lxs8myur9amEAaLwgd9ZASNPABKiyNQQtR12y8ovsNrLHbYxVZNgVpS4
	 Jo48d5IhlI1Ga3xjRAc7gWe33ZmQzcLY5f5xTDpdn/g0oIeEm3yxHbgcMrtv0bl+hU
	 YJuD2LTjjtaXoUejq/Hw49BR2qEAKye2f3xlA7VroJi/eI4sfF+bqy9f0iA8TVaDNb
	 pZkQA0KRhKyDs7WJrt6QFvBUcmh1rGT7SDrf6gXdM9lVkCtmmPWjkLU/nymdEyhOW5
	 UUvYudnL4WtCcZKgAS8XntCAKW0Xpt/McLtMlZzgg1JFeIYLsRksdYM0vjxyKUjTmI
	 gtFqwuh56Ru/A==
Date: Wed, 30 Apr 2025 11:38:33 +0000
To: Mingyen Hsieh <Mingyen.Hsieh@mediatek.com>
From: fossben@pm.me
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Allan Wang <Allan.Wang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in kernel 6.14.3 and above
Message-ID: <Rc4t9joagJOAMRwFdiBdsR7ohouSCoRfWEle0muAuVQPREi2e33ZAua7v2-KYJ918HB3BXifBKZ9tn0DZ16wih1ASQgRjH95uqlnBSA-hnM=@pm.me>
In-Reply-To: <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me> <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
Feedback-ID: 134317997:user:proton
X-Pm-Message-ID: 2e01ae79f045946943168e8916213d6d7fbf7a62
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yen,

Here are the reproduction steps.

I have two Arch Linux machines:
    (A) one PC (hostname: arch-desktop) connected to the network via MT7925=
 wifi
    (B) one NAS box (hostname: arch-nas) connected to the network via Intel=
 I225-V ethernet

Both machines are running 6.14.4 and have Avahi + nss-mdns enabled accordin=
g to the Arch Wiki: https://wiki.archlinux.org/title/Avahi#Hostname_resolut=
ion

Both machines also have systemd-resolved configured in stub resolver mode b=
ut with MulticastDNS=3Dno to avoid conflicting with Avahi. Bug is reproduci=
ble without systemd-resolved as well, but I am listing it here for complete=
ness.

Steps:
1. On arch-desktop, attempt to `ping arch-nas.local`.
2. Ping will fail to go through with message: `ping: arch-nas.local: Name o=
r service not known`
3. Downgrade arch-desktop to 6.14.2 or below.
4. `ping arch-nas.local` again.
5. Ping should go through on IPv6 or IPv4. My network has IPv6 enabled so i=
t usually uses an IPv6 local address.

For the issue where the MT7925 wifi is unable to grab an IPv6 address, I be=
lieve it occurs when there's no active DHCP lease. Usually happens in the m=
orning when I turn on my PC. If I downgrade to 6.14.2, it will immediately =
grab a lease. Switching back to 6.14.4 retains that address for a while unt=
il I encounter it again next morning.

Thanks for looking into this!
Ben

On Wednesday, April 30th, 2025 at 1:48 AM, Mingyen Hsieh <Mingyen.Hsieh@med=
iatek.com> wrote:

> On Wed, 2025-04-30 at 01:14 +0000, fossben@pm.me wrote:
> >=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Hello all,
> >=20
> > After upgrading to 6.14.3 on my PC with a MT7925 chip, I noticed that
> > I could no longer ping *.local addresses provided by Avahi. In
> > addition, I also noticed that I was not able to get a DHCP IPv6
> > address from my router, no matter how many times I rebooted the
> > router or reconnected with NetworkManager.
> >=20
> > Reverting to 6.14.2 fixes both mDNS and IPv6 addresses immediately.
> > Going back to 6.14.3 immediately breaks mDNS again, but the IPv6
> > address will stay there for a while before disappearing later,
> > possibly because the DHCP lease expired? I am not sure exactly when
> > it stops working.
> >=20
> > I've done a kernel bisect between 6.14.2 and 6.14.3 and found the
> > offending commit that causes mDNS to fail:
> >=20
> > commit 80007d3f92fd018d0a052a706400e976b36e3c87
> > Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Date:=C2=A0=C2=A0 Tue Mar 4 16:08:50 2025 -0800
> >=20
> > =C2=A0=C2=A0=C2=A0 wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_=
cmd
> >=20
> > =C2=A0=C2=A0=C2=A0 commit cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 upst=
ream.
> >=20
> > =C2=A0=C2=A0=C2=A0 Integrate *mlo_sta_cmd and *sta_cmd for the MLO firm=
ware.
> >=20
> > =C2=A0=C2=A0=C2=A0 Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling M=
LO when the
> > firmware supports it")
> >=20
> > =C2=A0drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 59 ++++--------=
---
> > --------------------------------------------
> > =C2=A01 file changed, 4 insertions(+), 55 deletions(-)
> >=20
> > I do not know if this same commit is also causing the IPv6 issues as
> > testing that requires quite a bit of time to reproduce. What I do
> > know with certainty as of this moment is that it definitely breaks in
> > kernel 6.14.3.
> >=20
> > I've attached my hardware info as well as dmesg logs from the last
> > working kernel from the bisect and 6.14.4 which exhibits the issue.
> > Please let me know if there's any other info you need.
> >=20
> > Thanks!
> > Benjamin Xiao
>=20
> Hi,
>=20
> Thanks for reporting this issue, we will aim into this.
>=20
> Can you provide me with your testing steps?
>=20
> Best Regards,
> Yen.
>=20
> ************* MEDIATEK Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
>=20
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

