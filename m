Return-Path: <linux-wireless+bounces-3860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D585D8C6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 14:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F0F1C22D31
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C46995F;
	Wed, 21 Feb 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uFzrB6sp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790F29AB
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520896; cv=none; b=DJCgXhjrv1B0M2BiMru3Mfq9vtVEPU1v7FyNXPJjgXrl4B1voE9Tcth4MHZ5/byKtppKL6h+f9A+Q6Ue3pbBmq0Z9ZQ20LSUaScoT6h5+S8CAWSJOEcGkqABgCUyEfrgqSkqSt8n87sFjutql6zR3Gt723n/coJZx8GTFgMWwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520896; c=relaxed/simple;
	bh=hGe1RdnoTh5KxC8PeNvwrC1ExfByuAxRyBrJCXCPpZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKpWXwfiDDJiTgx0VtIHDhLW5IeVh+9cpQUpYcaxYRjsywjZMAkF4m9jXan7Ir8FkK0MU0tGEJz9dux3kHkLyFIsSMSE6s6x6q1BtY2BdgGSyPp/eky6hX1V+iBj5xK03JvZDOMO7Yhd0mgM8bp8LKUCtFbUW0WPPBaNrPtZ92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uFzrB6sp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4aQ7Dnt6iuqy5qDbCQx8nSHenBO7Vro4S3BB/XmUg6s=;
	t=1708520894; x=1709730494; b=uFzrB6spG1MTx0q0izsauTA2ctdjG3EQqy9QoDfgG0iQRoK
	sVs0MXGJm4r+pqVDQ7+fz9wBCcEUJz4aMqFbOLRDg+kF8FcYf/o6NI8cO9BgYum0CBR0HF6lu7/dx
	HGuk7/N3qD1+MXNAJaNQWf/hcAsZ1Xj8BZ+g8h5eeClBJKv03ZL7waEoMHxqEMp7lSP2wov9LpQ/p
	ulBaSLIl7lPU62fbDGh1lZnl+wSZNrakDb+IVfmHNDFEMV5nr/vzuYOKlBjunmcz+DbEKnMgbQkGl
	sUpfs781GMPvgAdibHoi6nRW4OQlH5AwApC7YZr0/wvt2JhqUCC1mmso6r7kF/XA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rcmKS-00000002H2a-29bP;
	Wed, 21 Feb 2024 14:08:05 +0100
Message-ID: <31b97f3c18129edd835ca4d968cd59947efab950.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, Ping-Ke Shih
	 <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@openwrt.org>
Date: Wed, 21 Feb 2024 14:08:03 +0100
In-Reply-To: <beee9cc5-6174-473b-bd57-1101430f200b@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <beee9cc5-6174-473b-bd57-1101430f200b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Wed, 2024-02-21 at 18:22 +0530, Aditya Kumar Singh wrote:
> On 2/21/24 13:39, Johannes Berg wrote:
> > Qualcomm:
> >   - copies and updates CSA/ECSA elements all by itself
> >   - btw, not sure here about probe responses, does it do that too?
>=20
> We had a thought about keeping this CSA/ECSA handling at host/kernel=20
> level only. But the major point of concern is _synchronization_ among=20
> firmware of each of the links participating in the MLD.

Sure.

> * Even if we ignore TSF/TBTT synchronization for a moment, how firmware=
=20
> will know when to transmit the beacon with a particular counter or when=
=20
> CSA has finished on other link? If rely on host's update then there is=
=20
> room for further delay and hence errors.
>       - This is because, counter value on the reported link depends on=
=20
> the last beacon transmitted by the affected link.

Sure.

I don't think anyone suggested that the host will put the exact counter
value there, just to have the template.

> * Host can send the template on all links

Right.

> but how to ensure that first=20
> template is reached on the affected link and then only on the partner=20
> links? Host will queue the command properly but reaping of the command=
=20
> on n (no of links) independent firmware can not be guaranteed in the=20
> same order in which host has filled. It depends how busy each of host to=
=20
> firmware path is.

True, and there's a potential for race conditions there I suppose, but I
suppose in the Intel, Realtek and hwsim case at least we wouldn't have
*different* firmwares running multiple links, but a single one.

In any case, you could solve this even with multiple, by applying the
new template only after you have the CSA'ing link's new beacon template,
if it requires filling in CSA counters, or such.

> * And then obviously, considering TSF/TBTT will be again complicating=20
> the synchronization part and making it more difficult to manage just via=
=20
> host.

Again, not suggesting that it is managed completely by the host, just
the templates.

> Hence there is a strong urge to let firmware handle all this for beacons.

Sure, that's fine, your call :)

> As far as how firmware will _magically_ communicate among themselves is=
=20
> concerned, we have *IPC* in place to achieve that. One link firmware can=
=20
> talk to other link firmware when required.

:-)

It probably doesn't actually help you make it race-free though, so does
it really matter? But again, it's your call how you want to do it, and
we'll just have to handle it in software appropriately. While I'd prefer
to have _one_ way of doing things, at least so far we've basically seen
one way of having the host involved and ath12k not having the host
involved, so it's all still really simple.

> 				Kernel Level
> _________________________________________________________________________=
___
>   -------------- 	      -------------- 		 --------------
> >   Firmware 1 |  <- IPC ->  |   Firmware 2 | <- IPC -> |   Firmware 3 |
> >    on HW 1   |	     |    on HW 2   |           |    on HW 3   |
>   -------------- 	      --------------             --------------
>=20
>=20
> Hence, host just needs to update template of the affected link and=20
> indicate to firmware that it is a critical update. This firmware then=20
> can indicate other link firmware(s) to append CSA/ECSA IE with a given=
=20
> counter value to its beacon via this IPC.

Sure. You still have a race, because if you send a message over IPC
saying that the CSA needs to be included and it's just before the TBTT,
chances are the TBTT event will still happen without that. So in a sense
it's similar to the host updating the partner link's beacon template
"too late". You can have a situation where the CSA link's template is
updated just before _its_ TBTT, and the partner link's TBTT is just a
little bit later, but the update is delayed ...

You could probably solve that by making your IPC synchronous but then
you risk your TBTT timings in cases like this.

Arguably, I'm not sure it matters. I'm thinking we'll enforce that the
CSA must be in progress when updating the partner links beacon/probe
response templates referring to it (*), but ... ultimately,  I think we
can accept that the partner link updates the CSA one beacon later if
their TBTTs are very close.


(*) and now that I think about it, that might have to immediately come
with a separate template to use _after_ the switch, like CSA does for
the CSA link

>  Parsing the IE and=20
> de-fragmenting and fragmenting it again can be done by firmware itself.=
=20
> (Agree that it is bit complex but when comparing with complexity of=20
> maintaining synchronicity across links, this looks more doable)

That sync maintenance is because of your hardware design though, others
don't necessarily have that because multiple links are handled by the
same NIC, not separate ones.

> Hence we have taken "offloading beacons fully to firmware" approach.

Sure, fair enough.

> For probe responses, it is handled in host/kernel only. Firmware sends=
=20
> back the last transmitted count in beacon to host. So we have the last=
=20
> transmitted count info. Per STA profile generation logic is also there.=
=20
> So we manage via that.

So I think like in Realtek's case I'd probably advocate doing that in
the driver with the offsets given by hostapd/software stack, although
that requires having *two* feature flags, one for beacons and one for
probe responses ... since you lack the "magic" for probe responses.

johannes

