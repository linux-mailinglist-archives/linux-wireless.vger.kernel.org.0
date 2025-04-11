Return-Path: <linux-wireless+bounces-21439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E10AA85942
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 12:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CAA8A2492
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D422127A;
	Fri, 11 Apr 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Ww25decQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E116AA7
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366169; cv=none; b=EqTy/jalMbp87//fzTnCAOZJbUnxmLYOym7UFscgRTthIN5g05sabZyL+VZGrrwpPV+xh7RAIVrKrV9FwfrIO0XioUD99oxh/ERe6xgs/magtkCAcFwR31OKex7AHWzsL+M/xnARFqnzcOKaX3Shh5rmvBBoUjDbXns0PQOAI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366169; c=relaxed/simple;
	bh=OmOYNa0EGpnj3t6MhJA4Bq/LCmYoIAG5s5w9PZlaYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeB5x+eW34TzzxJZWstDFasNzPn5QZd+A6Tc29f+NCZSqbHAaGMN4hsaDWyALo6mrpdf5FHhXAbuTrocekPocmrvk2CVtHptXfo0kWMYO9HSBm6KiVWrpzQNFb5wvcgx9+YyOh01NX1lWWZkdN/7hXOfRbq1F1yv6SdWFdB2pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=Ww25decQ; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 2B4A6616609B;
	Fri, 11 Apr 2025 12:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1744366155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tzYYLA0PobK4E8GI3oZFvbbbicIQcGbi5+6FDmf7qE=;
	b=Ww25decQ+fOCwNINYlzEfYcu+UvEMN829/myalTFASshoyvj1Jp8934EjvI04oUUbvIUtp
	Sl7ahZqWNXNhtp4il3WDcgJlJtHKdUIQQx7rNShmfTLvcS1sQPkpQcfG+oP1Q8I0gH9FSn
	joThO9ZR6zYvFBC7KjKxzyQahKLEgJw=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Lingbo Kong <quic_lingbok@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject:
 Re: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing link
 interface to prevent duplicate deletion
Date: Fri, 11 Apr 2025 12:09:01 +0200
Message-ID: <12642200.O9o76ZdvQC@natalenko.name>
In-Reply-To: <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
References:
 <20250226113118.7626-1-quic_lingbok@quicinc.com>
 <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5875152.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5875152.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Fri, 11 Apr 2025 12:09:01 +0200
Message-ID: <12642200.O9o76ZdvQC@natalenko.name>
In-Reply-To: <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 11. dubna 2025 12:05:10, st=C5=99edoevropsk=C3=BD letn=C3=AD =
=C4=8Das Lorenzo Stoakes wrote:
> +cc Oleskandr who kindly pointed me at the v1 of this patch (see [0]).
>=20
> [0]:https://lore.kernel.org/all/20250124093352.481-1-quic_lingbok@quicinc=
=2Ecom/
>=20
> On Wed, Feb 26, 2025 at 07:31:18PM +0800, Lingbo Kong wrote:
> > Currently, when ath12k performs the remove link interface operation, if
> > there is an ongoing scan operation on the arvif, ath12k may execute the
> > remove link interface operation multiple times on the same arvif. This
> > occurs because, during the remove link operation, if a scan operation is
> > present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED eve=
nt
> > from the firmware. Upon receiving this event, ath12k will continue to
> > execute the ath12k_scan_vdev_clean_work() function, performing the remo=
ve
> > link interface operation on the same arvif again.
> >
> > To address this issue, before executing the remove link interface
> > operation, ath12k needs to check if there is an ongoing scan operation =
on
> > the current arvif. If such an operation exists, it should be aborted.
> >
> > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0=
_SILICONZ-3
> >
> > Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>=20
> Hey, thanks for this!
>=20
> Not sure on status of this, has the patch been taken for 6.15? As I don't
> see it in Linus's tree (not looking _that_ hard though). I don't think it=
's
> even in -next?

And in addition to Lorenzo's question, my question here is if this v2 could=
 be already made obsolete by 81e4be30544ee7 in v6.15-rc1? Or is it still ne=
eded even in v6.15-rc1?

Thanks.

> I keep hitting issues with my X870E CARBON wifi onboard motherboard wifi -
> most recently I saw a null pointer deref in ath12k_mac_remove_link_interf=
ace().
>=20
> This occurred when I tried changing the network interface, in fact I had
> first clicked on 'available networks' in network manager so quite likely a
> concurrent scan.
>=20
> I rather stupidly didn't copy/paste the text of it, but you can see the
> report in screenshot form at [1]. Apologies for shade being case on ath12k
> driver but you know, frustrations :))
>=20
> It's difficult for me to test your patch as I am having pretty awful
> firmware issue with this motherboard - if I powercycle in any way that ge=
ts
> interrupted, or especially if a kernel issue arises, then the ath12k modu=
le
> will not load on next boot, or at all going forward.
>=20
> Updating the kernel to, I think, a recent 6.13 (and now 6.14-1 where I
> observed this issue), got the wifi working again, seemingly randomly.
>=20
> Usually I have to try to reset the CMOS state, but doing so causes other
> issues so I generally try to avoid (I have a network workaround involving
> an ethernet wifi adapater, it's pretty... yeah).
>=20
> So I assume some non-volatile state gets corrupted somehow, I'm not sure =
if
> you had any insights into how I might more sanely reset that?
>=20
> Anyway regardless thanks for your efforts, if the wifi adapter appears
> again then I will test this and can give T-b tags if so.
>=20
> Cheers, Lorenzo
>=20
> [1]:https://fosstodon.org/@ljs/114318530969496869
>=20
> > ---
> > 1.rebase to ath-next
> >
> >  drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wirele=
ss/ath/ath12k/mac.c
> > index 3e3afdc56fc9..551133483f44 100644
> > --- a/drivers/net/wireless/ath/ath12k/mac.c
> > +++ b/drivers/net/wireless/ath/ath12k/mac.c
> > @@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80=
211_hw *hw,
> >  	if (ahvif->vdev_type !=3D WMI_VDEV_TYPE_MONITOR &&
> >  	    ar->num_started_vdevs =3D=3D 1 && ar->monitor_vdev_created)
> >  		ath12k_mac_monitor_stop(ar);
> > +
> > +	if (ar->scan.arvif =3D=3D arvif && ar->scan.state =3D=3D ATH12K_SCAN_=
RUNNING) {
> > +		ath12k_scan_abort(ar);
> > +		ar->scan.arvif =3D NULL;
> > +	}
> >  }
> >
> >  static int
> >
> > base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
> > --
> > 2.34.1
> >
> >
>=20


=2D-=20
Oleksandr Natalenko, MSE
--nextPart5875152.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmf46j0ACgkQil/iNcg8
M0u59w/+JLrQFAOGSFWbC/UhynjmZ86NrK07p98NnY9XEKpAYASb5r1FUfntYW2w
SIFfVU0koipT/j+sx1YDSpSksqs5aZrpNIw4yqV1HNNMCCoJv0WridzgvAqAegjt
yVhNuqZ6bqRaMJOhsorCwj2nYO2DF27ZV1vdggQDqYW+HoL9XbTNA47suAwDJaaH
1Aa3vwvwu1EgqW/T5SLUUX5mWIEvtIIaWazQ/6OJzgGNtNIloAaxvZLfWOk2vQuL
2U2LdHQPvA7fTjK/kAvHOlMnrQCHbYg+YmwH6z45Lem2tR+VZ62qxXNQI4tou5n4
kNiGiAk+MZOUC1QH//RQ+WEI11qEoH71O60IlcpeOYe6MWZrA89iynyJr+nFPJGH
F67S+ffX7ahsBbHcPJjj4Nlc4BgiYvNc51Mcjg9hJ/Kt4B4XqJMSUBpuo8FBeGVW
BoOXrPZiwFQBlqUD3cizpPmXR5tRBlU6KlXOKoEwyZpkjYuhl3dGFFk7OnULIeA4
Gr8phhYBQUEEmoAqd74JGpIqj6BE6fYFaE+7ELUqAhiYVf4O5yh7omGYcxNyYmcY
AC8W9j8Ua8DSO9C+RNGnnLQXd+ZKGtK4CYzIh4hZMlsfHRe4juLsv3hmX9CX9WVL
5yPyhq3eH3wtA3xom+C+1n+8qkBRHxE3EfS5C3fPHcGpitXTkXs=
=w6FT
-----END PGP SIGNATURE-----

--nextPart5875152.DvuYhMxLoT--




