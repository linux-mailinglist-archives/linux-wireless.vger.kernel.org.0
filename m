Return-Path: <linux-wireless+bounces-5992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE889D302
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 09:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ED9B2202A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 07:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AE7605D;
	Tue,  9 Apr 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oCHa0mwv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5C77F3E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647654; cv=none; b=Hf5DgqM2f15VQ5m6vNqHlvdKMk9kVPaxmaAH5sS0hzz57LMs0AdMCXDAUuEFOaoOwxT7RfEpKLHZQ9oChCn4hqXzk3IJOfauo3A3Nlq8omSVMXX3ZsctWhj2pgKSXJRm2Rh/LtZ1zl7EOGkr/Su7hC/aLFtz5MaojW8tuEG9amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647654; c=relaxed/simple;
	bh=UBjmVtZTeLj1Qs2Exby5oEPuKYF9uOFHr6Q153h1/lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CP3+kJGPapdiKU0KsZ3KhecbZsXdh9yhVfu2USD3WWfuyTy3E/Lu6eHoAm+u+QNa1Ep8VYpp4Du57OtqIKl6T9aH/0r0K0EGYrcNKDCf8iYpFjRXQ/SY6XuIbvMVU6w+lWEmLRk/ArZMrTB+j4VvUD4hNEQ770Hzsqj/r1wBXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oCHa0mwv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E7zU6ngw1lpux53cHnV1BIegiawKGPh+YJ3jRVXooxc=;
	t=1712647649; x=1713857249; b=oCHa0mwvtrMaqgc66qA1VeNpdhnhlV9hRD0GrX02UsP9f9P
	GfRYUvsrjM1dPJ8h8LlX/V+XqdrL1xpDKzcsMQSN8IZ0pGG4BnBODUDfRLjvpOE4tVmjBqjveZlF/
	j/vtb8Us1XiLvri/W+Wg6ot6FDOwm0IS5hephbyzDsSV7dn9UTfvUTtjhkGRuF6MZLSHM0Q6Kkg8X
	C2ZhY0ID0dAVc428CokJqLAOFPEZ2YIxPFg/J2QaueyHfspf+rlEgD+/R0fna+pG/8oUhWdzdPbv/
	KTUJffKwq5KYaA6r+mVAvRF5WXUijM3eFNIIec/3RPk8nYMQQ/bDZ1XL4DNZ4C9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ru5t7-0000000HRE1-34yk;
	Tue, 09 Apr 2024 09:27:26 +0200
Message-ID: <98081f4e417cf20beea41288ca7b75235b8fe0e0.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: handle sdata->u.ap.active flag with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 09 Apr 2024 09:27:24 +0200
In-Reply-To: <15bc7705-5da9-4c56-aa45-81972bad5e01@quicinc.com>
References: <20240326151141.3824454-1-quic_adisi@quicinc.com>
	 <bae1e71edcc13e73e8ef7f24d30140a4a6aefb98.camel@sipsolutions.net>
	 <15bc7705-5da9-4c56-aa45-81972bad5e01@quicinc.com>
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

On Tue, 2024-04-09 at 09:27 +0530, Aditya Kumar Singh wrote:
> On 4/8/24 23:55, Johannes Berg wrote:
> > On Tue, 2024-03-26 at 20:41 +0530, Aditya Kumar Singh wrote:
> >=20
> > > @@ -1232,7 +1256,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if=
_data *sdata,
> > >   	}
> > >  =20
> > >   	rcu_assign_pointer(link->u.ap.beacon, new);
> > > -	sdata->u.ap.active =3D true;
> > > +
> > > +	if (ieee80211_num_beaconing_links(sdata) <=3D 1)
> > > +		sdata->u.ap.active =3D true;
> >=20
> > I don't understand this change. Neither the <=3D 1 really, nor the fact
> > that you actually _make_ this change.
> >=20
>=20
> The place above where we are checking number of beaconing links, at that=
=20
> point at least 1 should be active. Since before checking, we have done=
=20
> rcu_assign_pointer() so at least 1 should be there. That is why that=20
> condition.
>=20
> If it is more than 1, then this is not the first link which is going to=
=20
> come up and hence there is no need to set the flag again.

Hmm, OK, I guess that makes some sense. However, it's also completely
pointless, since setting it =3Dtrue when it's already =3Dtrue doesn't reall=
y
do anything. Adding the code seems to imply it should avoid setting it
in some cases, which isn't actually the case.

Besides, doing the counting is almost certainly far more expensive than
simply setting it to true when it's already true. Certainly the state
should be =3Dtrue after this function is called.

If you really think the extra write might be a problem (it isn't though)
then you'd still want to write it as "if (!active) active=3Dtrue" since
that's actually checking the right thing. But ... that really wouldn't
matter in all but the highest-performance code meant to deal with high
(CPU/core) parallelism.

So this is just a long-winded way of saying: don't do that, just keep it
unconditionally setting active.

> > > @@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wi=
phy, struct net_device *dev,
> > >   		if (old)
> > >   			kfree_rcu(old, rcu_head);
> > >   		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
> > > -		sdata->u.ap.active =3D false;
> > > +
> > > +		if (!ieee80211_num_beaconing_links(sdata))
> > > +			sdata->u.ap.active =3D false;
> >=20
> > =3D=3D 0 maybe?
> >=20
>=20
> Yeah can do. I prefer "!expr" over "expr =3D=3D 0". Do you have any prefe=
rence?

I think for something that actually _counts_, like here, I'd (slightly)
prefer =3D=3D0. It's obviously equivalent, but it seems more natural to
write "is number of beaconing links equal to zero" rather than "is not
number of beaconing links".

I may be influenced too much by Dan's thoughts on the matter ;-)

https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

> > Or maybe we should just save/restore the value instead?
> >=20
> > >   	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
> > >   		netif_carrier_off(vlan->dev);
> > >  =20
> > > -	if (ieee80211_num_beaconing_links(sdata) <=3D 1)
> >=20
> > Unrelated, but it looks like the VLAN netif_carrier_off() handling abov=
e
> > is also wrong and should really go into this if block as well.
> >=20
>=20
> Yeah MLO VLAN changes would do that? The previous change was focusing on=
=20
> the AP mode alone and I did not want to break anything in VLAN so did=20
> not touch it there.

Sure sure, just drive-by observation.

johannes

