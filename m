Return-Path: <linux-wireless+bounces-22384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AB3AA8341
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 00:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A64D189E532
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F61DDC2C;
	Sat,  3 May 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvcK7mTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3315350B;
	Sat,  3 May 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746311997; cv=none; b=qOQ84snHOOQgf7u+eu/y8cxFoUxhPqroLxoFdekG4KWRAXIK4MsMlXkMgkNHLERhfulHzE564AYDp/M0g3Z5dYhi02gcMAg2eP46p1qa4rgHFmNP6Zt5noMr4be5mY2KBcb+xp9pZ8f0ONX5Y5EHnMm059pyJiZma6MNnhBAoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746311997; c=relaxed/simple;
	bh=q/xAnCXUh7gKnEZY83rtkQmLm5+SBilPqhFLOnA9tCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoeCyG2zUnyMC3v0NhgCi9dVHUtN9IqfceYa0kCouHE/bvGwg9WLi0W1ikTLxhkdWzd7wL/b5MuFKPCczL9LZ8kJFJxFyQ7pVFjeHRal/5FgxzPBwkpSI8DRjFMBJmjFWwV3UAS5X2GYZNz7JfsadLAnyTPLySjxPGPQJOsUu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvcK7mTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D60FC4CEE3;
	Sat,  3 May 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746311997;
	bh=q/xAnCXUh7gKnEZY83rtkQmLm5+SBilPqhFLOnA9tCc=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
	b=DvcK7mTkvKmWGxzoRf9hCH1JhrQTgb2jv2whuFoqqKpflpZKLD3Ngz3jHjnDWZxj4
	 O9qfOFXAFPN9FlJsNhATlg2xM690ZevuWT1K0H2EzAJHKHs0OnGgoeOQuHZrj7iQXF
	 QSGPvxaV9mEzP9/pyKH+faQUrxgw5N2cpJn4QePSKkYuAotHLiSBmC6tUpx1KJyygi
	 8ZHfeaWwT/8M0enFKllfh8NwDlbvQJTCZH280co1jzKPuVp7wY1nScU8IqxfdejtdF
	 0j9QsWR5IjUg6pNDr0KTdwffoqDYSph/HC3ZCRckMbd1vkePbUuOXc8mS9PxmKjIjr
	 5OFIr4EC54VvQ==
Message-ID: <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in
 kernel 6.14.3 and above
From: Niklas Schnelle <niks@kernel.org>
Reply-To: niks@kernel.org
To: Mingyen Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=98=8E=E8=AB=BA=29?=	
 <Mingyen.Hsieh@mediatek.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>,  "fossben@pm.me"	 <fossben@pm.me>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 "linux-mediatek@lists.infradead.org"
	 <linux-mediatek@lists.infradead.org>, Allan Wang
 =?UTF-8?Q?=28=E7=8E=8B=E5=AE=B6=E5=81=89=29?=
	 <Allan.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Sun, 04 May 2025 00:39:52 +0200
In-Reply-To: <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
References: 
	<EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me>
	 <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-30 at 06:47 +0000, Mingyen Hsieh (=E8=AC=9D=E6=98=8E=E8=AB=
=BA) wrote:
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

Hi Yan,

I see the same IPv6 issue on my Framework 13 (Ryzen 5 AI 340) with an
mt7925e WiFI module.=C2=A0My setup is just a home router with native IPv6
both for my uplink and in the LAN. The problems with IPv6 can already
be seen just in the LAN for example by checking which IP was used for
SSH, in my setup it should always be IPv6 but falls back to IPv4 in the
broken state.

As another data point, I tried reverting cb1353ef3473 ("wifi: mt76:
mt7925: integrate *mlo_sta_cmd and *sta_cmd") on top of 6.15.-rc4. This
fully restores IPv6 for me. Also note I'm running this with the mt7925
firmware version 20250425073330 from linux-firmware's master branch as
I had some dropped connections with earlier firmware.

So it definitely looks like that commit also broke IPv6 and not just
mDNS. Note that if if I use DHCPv6 instead of router advertisements, on
the latest firmware, but without the revert, I get a global IPv6
address added to the interface but then native IPv6 addresses are still
uncreachable. With the offending patch reverted my SSH session to an
IPv6 only host works fine and is stable. Also I'd be willing to test a
proper fix as I rely on IPv6 heavily due to having to use CGNAT for
IPv4 but not for IPv6.


Thanks,
Niklas

