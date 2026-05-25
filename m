Return-Path: <linux-wireless+bounces-36880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIGhKKk7FGpDLAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 14:08:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D15CA4B4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 14:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F4E83019F3F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B63815CC;
	Mon, 25 May 2026 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="Iouee/Mr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEEC3806AC
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710871; cv=none; b=HS+l489dzBKlXGqFqLrBfOW2Tf62D7xqGqvFYLnEBaomQWEvT/ZSI3mTfhuIjIlwA1diAUOVwuaRA8SMxuD26Kt9MwMrA72Ea9Tj8x7NTnmGX8Fxq9A/a01A/dUzixAMs7UflguEacw8SWCb8pwqTnCaMnZqGCWOxSLQuEXcON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710871; c=relaxed/simple;
	bh=nh+iolmP75Y2qpuH5i4RsRIM0gHKVVXMn7VPwJyUSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otEJeP/KGd9Pj5+5ssNf8r2ZT00/cf1hAymAvzl/bbEEf3Ry7/fPJDjhtdFl/9j5E+5dKZPmzuaSvGH8gJBpWuRB11Z0WdywTKSz+yRA3fpiIY8HCxH8RzyCdiYTGjj4ALNjKUaL1h8cHRFgsW2C3t+jQKNeZdTh/X+pxybj3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=Iouee/Mr; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RU2wwAEOKRHshRU2xw9Ybd; Mon, 25 May 2026 14:04:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779710679; bh=nh+iolmP75Y2qpuH5i4RsRIM0gHKVVXMn7VPwJyUSbk=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=Iouee/MrBuwntjoyTNrTmbY09Hvd0YZMyVy1qUdktw3THcwWrqfgT3lUS9KOYqcrY
	 OG7Frqta8p2oa4OLLv6Q4mGZBua6RjsujTVFEwRDj2oFSMjxtnhBHCWCthx0WMjk5Q
	 p/597uS8FdJkhetPqFEga8CZad60gAsE2+1/rn8aHpZK7BAqzCxDlrub6p3dR1Py9t
	 mbTYJh6XxnVaB6PMgV57uJJbR8F2uZfp+AF8J4Ep8Zz9v1L5O2XgwQJBEP2iahXxHv
	 k24UVI4bIbS+IGRe+BZsSBRvNfiJ0pA5n6EcDJCUsKsRSK/hoOLmf8SZsA+QRSFwg0
	 R4tF93F7yAoUA==
Date: Mon, 25 May 2026 14:04:38 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260525140438.265975e7@fedora>
In-Reply-To: <20260525100752.16cdb59e@barney>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
	<20260525100752.16cdb59e@barney>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4xfA8g/o0XpY+yYmGT4362WFYw+FY4UPH6Wtg1/Sr1mbAUUHQ2ZIfhJEsj0NXgOnq6wA5vwTSc1aBzeXEu0EpTiDX43vWlJOHXgNaPXLi4H4t7xoTg9iMZ
 /0++QQKC49mwiSt8ngrxGy1frLKbA8YtLZb8ho0vVU2VepkS/yuh/sCoR2bzHfV0VH29UxRUrntzgOael+Bx6PHsE2g0ftOm6w5Bwc7p9cprkQkYnovynmLN
 yQBhwF6R4rLXXBG2yh07obTPiFSd4fIJtgN8TQPhc/mSGqjrtiIgMMkE5fBsMdEK
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36880-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mythread.it:email,mythread.it:dkim]
X-Rspamd-Queue-Id: EF2D15CA4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno Mon, 25 May 2026 10:07:52 +0200
Michael B=C3=BCsch <m@bues.ch> ha scritto:

> On Sun, 24 May 2026 23:56:17 +0200
> Alessio Ferri <alessio.ferri@mythread.it> wrote:
>=20
> > Alessio Ferri (7):
> >       b43: add firmware mappings and remove comments wondering
> > about rev22 initvals b43: add d11 core revision 0x16 to id table
> >       b43: route d11 corerev 22 to 24-bit indirect radio access
> >       b43: support radio 2057 rev 8
> >       b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
> >       b43: add channel info table for N-PHY r8 + radio 2057 r8
> >       b43: add RF power offset for N-PHY r8 + radio 2057 r8
> >=20
> >  drivers/net/wireless/broadcom/b43/main.c        |  22 ++-
> >  drivers/net/wireless/broadcom/b43/radio_2057.c  | 230
> > ++++++++++++++++++++++--
> > drivers/net/wireless/broadcom/b43/tables_nphy.c |  58 ++++++ 3
> > files changed, 290 insertions(+), 20 deletions(-) =20
>=20
>=20
> Looks good and in general low risk because it doesn't change any code
> paths of supported hw revisions.
> I'd still prefer if somebody could test this change on another
> supported 2057 radio. I don't have such a device unfortunately.
>=20
> Does the D-Link DSL-3580L work with full expected wireless throughput
> after this change or are there any remaining known issues?
>=20
> Acked-by: Michael B=C3=BCsch <m@bues.ch>
>=20

Please clarify "full expected wireless throughput", HT is
not supported by b43, so it runs only with NOHT in g-like speed:

wireless.radio0=3Dwifi-device
wireless.radio0.type=3D'mac80211'
wireless.radio0.path=3D'platform/ubus/10007000.wlan/10004000.axi/bcma0:1'
wireless.radio0.band=3D'2g'
wireless.radio0.channel=3D'36'
wireless.radio0.htmode=3D'NOHT'
wireless.radio0.country=3D'IT'
wireless.default_radio0=3Dwifi-iface
wireless.default_radio0.device=3D'radio0'
wireless.default_radio0.network=3D'lan'
wireless.default_radio0.mode=3D'ap'
wireless.default_radio0.ssid=3D'DSL3580L'
wireless.default_radio0.encryption=3D'psk2'
wireless.default_radio0.disabled=3D'0'

Enabling HT for N chips is out of scope, also there nothing to
gain and a lot to risk, so i won't do it.

Once this lands, i would move to fix AC support for the only two chips
that require b43 to work (4352 & 4360). I own them both, in multiple
routers, so i can safely develop for them. It is also low risk as there
are no existings users.


