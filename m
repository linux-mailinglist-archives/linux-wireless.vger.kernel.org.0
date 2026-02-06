Return-Path: <linux-wireless+bounces-31617-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDAFKQOwhWkRFAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31617-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 10:10:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12FAFBDB0
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 10:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1696F301C8B8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F467355023;
	Fri,  6 Feb 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BO/LqVu/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31D279DB6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368739; cv=none; b=Ebs/mjww9ypUCT+P8lxIq7ByRG3ecIbl+VuzKYtSlj0Unc57EWNuvwjgmnAR5A9kaO7hda8Ch4IS2jF4yVvHdEdhMYwzj74duPyb9jWTxra2p7roWC7cs/QmdM7jwGTuwIQ8MGAmhKxgf2kFjdKm1pa3qQIcUxR3HmW4cRUMEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368739; c=relaxed/simple;
	bh=dG0pbqfYZ9+4xchyCn4MVHiuj30L0YjdNVsxXOP3nQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BrcWMMRcASFlD/NqaRh1l8BXQmYRYJNEcYMW1F/5jDAD55LMp7LuqTeXTGs2aBdym6Q93+rSo/LWLWY4eJK68EfEMD8FLnfWefmlmZMTGHYfWqIne8ovLXrFiD1y3GClimT+h32Hivpcb3Ns/zrR3NxTh64YLbbS+CYpsDJ/Ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BO/LqVu/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dG0pbqfYZ9+4xchyCn4MVHiuj30L0YjdNVsxXOP3nQI=;
	t=1770368739; x=1771578339; b=BO/LqVu/ub83CmCpf7m++E+l1fZHIra/YbqfD9PfbDGwrZN
	hz8Sr5LYr086txAAhFEeO0eyYw8tWwsnGfRYXaYtkKAEbEypZuJK0C0X6euQB666IiwPAcX49bD69
	qGbtigMrr09gp5fgCIG77z3hMEj/i85tb6W2z6Eqfpwz6glpxENA8CtcrhGlaX5L6XhNb/J3Po0Q9
	Il2R4hDlC7ELU1HULRbHaD9La+WdUCGrZNltdyRxH4kK83vBMogENalhrS2Dhw0hXnQ2g2D3m6bMg
	wlIkD9Jk+DeTYybMEhpQOgWF3U8Tw2hJ7QK+4B1Jw7YWh1JWYQKd1we7nOj/6tWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1voHmQ-0000000Gge9-0OTT;
	Fri, 06 Feb 2026 10:05:34 +0100
Message-ID: <3643c9d1111a0076c7d420a16d0f97c29ac6575d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] AP: Always re-add stations that use MLO
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, Rameshkumar
 Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Andrei Otcheretianski
	 <andrei.otcheretianski@intel.com>
Date: Fri, 06 Feb 2026 10:05:33 +0100
In-Reply-To: <0c167905-6ba7-4e6e-8a4e-455507d8497e@oss.qualcomm.com>
References: <20260126160300.2600380-5-benjamin@sipsolutions.net>
	 <20260126160300.2600380-7-benjamin@sipsolutions.net>
	 <612a2814-216d-435b-a58a-1f17169a944b@oss.qualcomm.com>
	 <707fe82d66e77aed06002c529322eb9689db027b.camel@sipsolutions.net>
	 <fcef3c86-5384-4211-9f6b-be6ef562cef5@oss.qualcomm.com>
	 <97511b524cecf4862d8a83038017c23bc7d715b8.camel@sipsolutions.net>
	 <0c167905-6ba7-4e6e-8a4e-455507d8497e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31617-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: F12FAFBDB0
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 22:34 +0530, Ramasamy Kaliappan wrote:
> Hi,
>=20
> On 1/30/2026 5:32 PM, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Thu, 2026-01-29 at 22:56 +0530, Rameshkumar Sundaram wrote:
> > > On 1/29/2026 3:38 PM, Benjamin Berg wrote:
> > > > [SNIP]
> > > > That said, to properly fix this we need an nl80211/mac80211 API tha=
t
> > > > permits us to disable address translation for the frame. Otherwise =
we
> > > > would still get the address translated to the old link address shou=
ld
> > > > the new link address match the MLD address.
> > > >=20
> > >=20
> > > That's true=E2=80=94even probe responses get translated when the old =
link
> > > address matches the new link MLD address.
> > >=20
> > > Few other cases I encountered:
> > > Consider an ML STA with ML address M associated with link A and link =
B,
> > > using link addresses X and Y respectively. If the STA sends an
> > > authentication frame with address Y on link A, it gets translated to =
M
> > > (even though link A has no STA with address Y) and forwarded to link =
B.
> > > As a result, hostapd is unaware of the actual TA and queues the
> > > authentication reply to the MLD address on link B. This frame will
> > > eventually be transmitted over the air on link B with address Y.
> >=20
> > Honestly, that type of link confusion seems like a bug. We should be
> > able to avoid that as we hopefully know on which link the frame was
> > received.
> >=20
> > > This will be true even if STA associated in one link and tries to roa=
m
> > > to other link of MLD using same link and ML addresses.
> > >=20
> > > There also cases where an ML STA roams/re-associates as legacy (non-M=
L)
> > > STA with ML address as link address. The reply would go out with old
> > > link address.
> >=20
> > Yes, I think that case is similar a station using its MLD Address on
> > the association link and returning on another link.
> >=20
> > > It seems that address translation at the driver/mac80211 level for
> > > management frames could be avoided for both TX and RX, allowing hosta=
pd
> > > to handle these frames and their replies more efficiently in cases of
> > > roaming and address reuse.
> >=20
> > Doing address translation in the TX path is required if the
> > hardware/driver should decide on which link to TX the frame. For RX, it
> > seems sensible to me to do the translation when it is possible.
> >=20
> > I talked a bit to Johannes about this today, and my current proposal
> > would be add a new flag that is set when mac80211 did not find (RX) or
> > should not use (TX) a STA for the frame.
> >=20
> > More specifically I think that we could:
> > =C2=A0 * Fix the link address based STA lookup to only work when the fr=
ame
> > =C2=A0=C2=A0=C2=A0 was received on the correct link (the bug from above=
).
> > =C2=A0 * Make sure we drop robust management frames without a STA as we=
 do
> > =C2=A0=C2=A0=C2=A0 not want to get into trouble with the next change.
> > =C2=A0 * Change ieee80211_rx_for_interface so that it uses only
> > =C2=A0=C2=A0=C2=A0 link_sta_info_get_bss if we are an MLD and sta_info_=
get_bss
> > =C2=A0=C2=A0=C2=A0 otherwise.
> > =C2=A0=C2=A0=C2=A0 Right now, we will find the station if we see the ML=
D Address in the
> > =C2=A0=C2=A0=C2=A0 frame even when it is not a valid link address.
> > =C2=A0 * Add a new nl80211 attribute NL80211_ATTR_FRAME_NO_STA to be us=
ed
> > =C2=A0=C2=A0=C2=A0 together with NL80211_CMD_FRAME for both TX and RX.
> > =C2=A0=C2=A0=C2=A0=C2=A0 - In the RX case, add the attribute if we have=
 no station. If the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attribute does not exist, then hos=
tapd should assume the address was
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 translated.
> > =C2=A0=C2=A0=C2=A0=C2=A0 - In the TX case, plumb the information throug=
h to mac80211 and avoid
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doing a station lookup based on th=
e address.
> >=20
> > I think this would be enough to then solve the problem in hostapd.
> >=20
>=20
> I feel this approach should work. I'm trying to understand how it=20
> behaves in the following scenario where the STA reconnects with the same=
=20
> link address but a new(different) MLD address.
>=20
> Consider a situation where an already associated STA sends a reconnect=
=20
> request using the same link addresses but a different MLD address.
>=20
> For example, assume the station was originally connected using M as the=
=20
> MLD address, with L1 and L2 as its link addresses. When the STA=20
> reconnects (or roam back), it may use a new MLD address B while still
> using the same link addresses L1 and L2.
>=20
> In such a case, mac80211 will still find the existing STA entry based on=
=20
> the link address, and address translation would map the link address to=
=20
> the old mld address. Since the STA lookup succeeds,=20
> NL80211_ATTR_FRAME_NO_STA would be set to 0.
>=20
> How is this expected to be handled in hostapd? I believe hostapd will
> also need additional logic to correctly handle this case, since the
> link address maps to an already=E2=80=91known STA, but the MLD address ha=
s changed.
> Otherwise, hostapd may end up replying to the old MLD address or=20
> associating the frame with the wrong MLD context.

I am not sure we really need to care about this case, but, I think we
can handle it just fine if we want to.

In this case is mac80211 would translate the address to the MLD Address
and would not include the NO_STA flag. hostapd can look up the MLD
Address in its database and translate the address back to the link
address for its internal use. It can also explicitly TX the response to
the link address by setting the NO_STA flag.

So, I think it is an interesting corner case and we need to make sure
to not get confused by it. But, hostapd should be able to handle it.
Either by simply rejecting the AUTH or by making sure the MLD addresses
are all correct if the association succeeds.

Btw. I did start looking into doing the mac80211/cfg80211 changes. How
should we do it with hostapd? Is someone on your side maybe able to
work on the hostapd part?

Benjamin

