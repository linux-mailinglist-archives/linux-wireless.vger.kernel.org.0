Return-Path: <linux-wireless+bounces-22447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2AAA8E1B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 10:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1DE3B5DF3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F41EC00C;
	Mon,  5 May 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pOHlkCF2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0F1EE03D;
	Mon,  5 May 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433230; cv=none; b=JEJ0eHp0ODdAx56kARBaVoOOifBvPpc5RFgp2XccU5FxhnioZdljC3/GVDadUJ42pLRR6VcGG23ZRNA4eYEgW896HVtLXD+IlyQifZ6q9lj7nJ4he0LEIyKPaLOPq9OqP7x3nZYBcFN/Y358M9QyReDh6fE+eHIx51CLslNtAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433230; c=relaxed/simple;
	bh=2nld4hcGgo6X0z6GWVU9T2qu2SGGif3NrxrDhDm+P9w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=he642hu1QfI2qGiwgAPUm6uZpnaBhpT4mP28pSM6rOB+/5VzNAwKhUGj9OxkDxMZFfj3tMtn/O/xzTnyQL81xdxHTzKrIWExnXUIUhSU+n5BIHllq4oKbd/fNzLutISZg72fLSBRjtubazQsqTYIJm/j7gbqbUs1KM1I/1+ek8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pOHlkCF2; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1746433220; x=1746692420;
	bh=PPmY1q+mDq92unxZt7p8cEaDwhs2YRbB62LoxxnlFpE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=pOHlkCF2T1ravadpuvayGDQeSZ/x50ch5YmOm3ewP8GVMn2aegoZ5eQ/WmTsEGd6o
	 VtySB0xnk+5XpQqit9qXlw8yxfbgxpay7ezwsHcrv+hSL1chyzvZEuhbPhFJJDLQZ4
	 CEGgn4Yy5Gu4KNvSN1IcI90m/lNT2VQh4+PS6YI+xZnTtI1NP1MkJMel6/tmNHOXlN
	 daR1dNrHA0AZwjetkfqbrlD9EW3mFaS2b1WJlGCu+sqfGp9wafe31MR8s+Z7Htew3Z
	 URtcBKqp+u9YK2/xY/tYAka7XJ/YyIwKbg0ib0xpAowPqcfUt2Yl/61QBmJkdgK63j
	 NgzSGvQNVWEQQ==
Date: Mon, 05 May 2025 08:20:16 +0000
To: Mingyen Hsieh <Mingyen.Hsieh@mediatek.com>
From: fossben@pm.me
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "niks@kernel.org" <niks@kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Allan Wang <Allan.Wang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925: mDNS and IPv6 broken in kernel 6.14.3 and above
Message-ID: <Q8fBN4506NOX9rrFspv9q0xuQRlE1YcHDbwfRUlXy7if-Lv-kGyIXPrNN2kOMoWENMYCfTmOhAhnSCs4gtUvpzEf0O_JZ_BV__V3B_A7iU8=@pm.me>
In-Reply-To: <28ef2cc608d071d1530902d7b5df045555ab5651.camel@mediatek.com>
References: <EmWnO5b-acRH1TXbGnkx41eJw654vmCR-8_xMBaPMwexCnfkvKCdlU5u19CGbaapJ3KRu-l3B-tSUhf8CCQwL0odjo6Cd5YG5lvNeB-vfdg=@pm.me> <f73dec60b60dd7bb3be40c1feefbe223c7afe19b.camel@mediatek.com> <5ae1ef34c9844d6d0f5fb167dd596a4c43321367.camel@kernel.org> <28ef2cc608d071d1530902d7b5df045555ab5651.camel@mediatek.com>
Feedback-ID: 134317997:user:proton
X-Pm-Message-ID: fef2514a1a9fdd3fff94770a5f82dde0aa08ad69
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, May 5th, 2025 at 12:48 AM, Mingyen Hsieh <Mingyen.Hsieh@mediatek=
.com> wrote:

> On Sun, 2025-05-04 at 00:39 +0200, Niklas Schnelle wrote:
> >=20
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > On Wed, 2025-04-30 at 06:47 +0000, Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA) wrote:
> > > On Wed, 2025-04-30 at 01:14 +0000, fossben@pm.me=C2=A0wrote:
> > > >=20
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >=20
> > > >=20
> > > > Hello all,
> > > >=20
> > > > After upgrading to 6.14.3 on my PC with a MT7925 chip, I noticed
> > > > that
> > > > I could no longer ping *.local addresses provided by Avahi. In
> > > > addition, I also noticed that I was not able to get a DHCP IPv6
> > > > address from my router, no matter how many times I rebooted the
> > > > router or reconnected with NetworkManager.
> > > >=20
> > > > Reverting to 6.14.2 fixes both mDNS and IPv6 addresses
> > > > immediately.
> > > > Going back to 6.14.3 immediately breaks mDNS again, but the IPv6
> > > > address will stay there for a while before disappearing later,
> > > > possibly because the DHCP lease expired? I am not sure exactly
> > > > when
> > > > it stops working.
> > > >=20
> > > > I've done a kernel bisect between 6.14.2 and 6.14.3 and found the
> > > > offending commit that causes mDNS to fail:
> > > >=20
> > > > commit 80007d3f92fd018d0a052a706400e976b36e3c87
> > > > Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > > > Date:=C2=A0=C2=A0 Tue Mar 4 16:08:50 2025 -0800
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 wifi: mt76: mt7925: integrate *mlo_sta_cmd and *=
sta_cmd
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 commit cb1353ef34735ec1e5d9efa1fe966f05ff1dc1e1 =
upstream.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Integrate *mlo_sta_cmd and *sta_cmd for the MLO =
firmware.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabli=
ng MLO when
> > > > the
> > > > firmware supports it")
> > > >=20
> > > > =C2=A0drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 59 ++++----=
---
> > > > ----
> > > > --------------------------------------------
> > > > =C2=A01 file changed, 4 insertions(+), 55 deletions(-)
> > > >=20
> > > > I do not know if this same commit is also causing the IPv6 issues
> > > > as
> > > > testing that requires quite a bit of time to reproduce. What I do
> > > > know with certainty as of this moment is that it definitely
> > > > breaks in
> > > > kernel 6.14.3.
> > > >=20
> > > > I've attached my hardware info as well as dmesg logs from the
> > > > last
> > > > working kernel from the bisect and 6.14.4 which exhibits the
> > > > issue.
> > > > Please let me know if there's any other info you need.
> > > >=20
> > > > Thanks!
> > > > Benjamin Xiao
> > >=20
> > > Hi,
> > >=20
> > > Thanks for reporting this issue, we will aim into this.
> > >=20
> > > Can you provide me with your testing steps?
> > >=20
> > > Best Regards,
> > > Yen.
> > >=20
> >=20
> > Hi Yan,
> >=20
> > I see the same IPv6 issue on my Framework 13 (Ryzen 5 AI 340) with an
> > mt7925e WiFI module. My setup is just a home router with native IPv6
> > both for my uplink and in the LAN. The problems with IPv6 can already
> > be seen just in the LAN for example by checking which IP was used for
> > SSH, in my setup it should always be IPv6 but falls back to IPv4 in
> > the
> > broken state.
> >=20
> > As another data point, I tried reverting cb1353ef3473 ("wifi: mt76:
> > mt7925: integrate *mlo_sta_cmd and *sta_cmd") on top of 6.15.-rc4.
> > This
> > fully restores IPv6 for me. Also note I'm running this with the
> > mt7925
> > firmware version 20250425073330 from linux-firmware's master branch
> > as
> > I had some dropped connections with earlier firmware.
> >=20
> > So it definitely looks like that commit also broke IPv6 and not just
> > mDNS. Note that if if I use DHCPv6 instead of router advertisements,
> > on
> > the latest firmware, but without the revert, I get a global IPv6
> > address added to the interface but then native IPv6 addresses are
> > still
> > uncreachable. With the offending patch reverted my SSH session to an
> > IPv6 only host works fine and is stable. Also I'd be willing to test
> > a
> > proper fix as I rely on IPv6 heavily due to having to use CGNAT for
> > IPv4 but not for IPv6.
> >=20
> >=20
> > Thanks,
> > Niklas
>=20
> Hi Benjamin & Niklas,
>=20
> Can you help to try this patch? I can get IPv6 address through this
> patch.
>=20
> If it can work at your environment as well, i will upstream it and add
> test tag with you.
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index a42b584634ab..fd756f0d18f8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -2183,14 +2183,14 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
>                         mt7925_mcu_sta_mld_tlv(skb, info->vif, info-
> >link_sta->sta);
>                         mt7925_mcu_sta_eht_mld_tlv(skb, info->vif,
> info->link_sta->sta);
>                 }
> -
> -               mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info-
> >link_sta);
>         }
>=20
>         if (!info->enable) {
>                 mt7925_mcu_sta_remove_tlv(skb);
>                 mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
>                                         sizeof(struct tlv));
> +       } else {
> +               mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info-
> >link_sta);
>         }
>=20
>         return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
>=20
>=20
> Thanks~
> Yen.

Hi Yen,

I manually applied the changes on top of 6.14.5 and mDNS seems to work alon=
g with IPv6! I will do more testing for the rest of the day to see if the i=
ssue is completely fixed but so far looks good at least for the 5 minutes I=
've been testing it.

Thanks for the fix,
Ben

