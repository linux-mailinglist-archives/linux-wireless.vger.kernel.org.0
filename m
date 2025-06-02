Return-Path: <linux-wireless+bounces-23528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95072ACAA93
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 10:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796D23A4F9A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5171D47AD;
	Mon,  2 Jun 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BabfcZ10"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D819D8A7
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748852879; cv=none; b=LjlTQ/NcR8wWy4642OnUfnu9ZX59MQGhi2ug9fen+t6b7vgQIes4gxUfW9qImDZJKY3/vcEOOExBLnTB0YyCGm+tyj9SDVgAUvup9P+wMWiW490nWfpv94BCyPDnDzrMgW35AVFa9YjNvp5ABgKtZ7ArnxTPJt10UKrphgANosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748852879; c=relaxed/simple;
	bh=D0gBCmSPA6iVgrWW9TLkKYSeIPUgu0qgyFdY/gzq/tI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjNUCxJXzjxIoJ1rHNiWi57AOE+cJUSKyqiXi8O5ej78eXV5TIGsjq2McAqihStNM9tBQu22ecYDhlthFrsw7bFnFkA75xPU4LPviPkaiBJbTLSPL1dYLc19o7MWKyI8vm6ShJoYgdX2pJmGNg2H7xAOuoaDVmbI/jY3ZIyVc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BabfcZ10; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fRSGvOgDpGxo990pxalG64FhyojHc659LC83rY/Nomk=;
	t=1748852878; x=1750062478; b=BabfcZ10eCchdZBvn43jL2P/yB8FBK5VjZ3gcVaEqnq4H78
	0PxO8lvm3TqjKNI9leLH5tF25MwW+oZwhgcImmk22YpXrgyr1n5gXdvLF6l36zMEhchP33YRkI+40
	QHj+s7D+bpkN53qrS5tDxiAkNymrTn71ZUJIuuBJwY43JP9iloSwKMr3COhhz1HgC5+ehLnlt/syi
	ynrNGitQKsI+5s1OMAOyUCn8iFYVj8LBSsBayrdCmKJt8keu77nkpTUAtz54az23mmEeILcKRO+qE
	9KkxzEuC/KxLBfZQMYsDsFGYFWe11l8s3q1Bk2/5rd483flM6mhUDgiLF9Am7Cnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uM0WQ-00000004suN-24KQ;
	Mon, 02 Jun 2025 10:27:54 +0200
Message-ID: <0ad998b5ecd0c1d6521441fd06a1bc7e1a93ddf0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: correctly parse S1G
 beacon optional elements
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 02 Jun 2025 10:27:53 +0200
In-Reply-To: <20250602053521.410650-1-lachlan.hodges@morsemicro.com> (sfid-20250602_073606_163032_3B072028)
References: <20250602053521.410650-1-lachlan.hodges@morsemicro.com>
	 (sfid-20250602_073606_163032_3B072028)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")

Should it really be wireless-next rather than wireless with this? We're
still even in the merge window, so seems entirely appropriate to put it
into wireless instead, even if the bug is old, rather than wait months
for it to release?

It also seems you should split this to cfg80211 and mac80211, if
possible, and have two different Fixes: lines? The cfg80211 part this
has might fix the above, but for the mac80211 part that doesn't seem
plausible?

> +/**
> + * ieee80211_s1g_has_next_tbtt - check if IEEE80211_S1G_BCN_NEXT_TBTT
> + * @fc: frame control bytes in little-endian byteorder
> + * Return: whether or not the frame contains the variable-length
> + *  next TBTT field

nit: the indentation should be a tab there (and in the later instances
in the other functions)

> +/**
> + * ieee80211_s1g_optional_len - determine length of optional S1G beacon =
fields
> + * @fc: frame control bytes in little-endian byteorder
> + * Return: total length in bytes of the optional fixed-length fields
> + *
> + * S1G beacons may contain up to three optional fixed-length fields that
> + * precede the variable-length information elements (IEs). Whether these

Also kind of nit, but the current spec versions (for a long time) have
stopped calling it "information elements" and say just "elements"
instead, I've been trying to at least do that in new code in Linux.

>  	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
>  		struct ieee80211_ext *ext =3D (void *) mgmt;
> -
> -		if (ieee80211_is_s1g_short_beacon(ext->frame_control))
> -			variable =3D ext->u.s1g_short_beacon.variable;
> -		else
> -			variable =3D ext->u.s1g_beacon.variable;
> +		variable =3D ext->u.s1g_beacon.variable
> +					+ ieee80211_s1g_optional_len(ext->frame_control);

Please do this like in other code:

	variable =3D ... +
		   ...;


(also more instances below)

>  	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
> -		ext =3D (void *) mgmt;
> -		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
> -			min_hdr_len =3D offsetof(struct ieee80211_ext,
> -					       u.s1g_short_beacon.variable);
> -		else
> -			min_hdr_len =3D offsetof(struct ieee80211_ext,
> -					       u.s1g_beacon.variable);
> +		ext =3D (struct ieee80211_ext *)mgmt;

Keeping the (void *) cast seems fine? I guess you can remove the space
if you like :)

Overall though I like the fact that we don't try to distinguish the
whole short/normal beacon thing, that was always a bit of a mess, and if
it fixes more bugs while at it ... nice :)

johannes

