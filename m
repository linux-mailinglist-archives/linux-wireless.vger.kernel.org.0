Return-Path: <linux-wireless+bounces-3588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AC854B7D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 15:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B91C21566
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA458210;
	Wed, 14 Feb 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aEwF6wr7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2D43157
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921285; cv=none; b=Jv7CvJOMiviFTuaIlcASUYimU4CYtc+YwIARMvLrGLXH1D1NtB9yY3SwaH/ywFCVH5UyIZqRX3qWNT56W2Jw1Fn+JbwH7fGGdkr5DWu/F1PjhJ2/fmwCZh5n5TfAmAb61hUojmLWXajnWReA1qhwSnISN3str9zPeHoCZGpLDT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921285; c=relaxed/simple;
	bh=tsYInJ51PUy2CmJYVm5/6JM1F+CAabp08OzRmn7ZP+g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HB0Cr3he1JEKOacO4fciW2NErgTMFXn5EGagkcQHUJNy0uYzY7A4MOxpMswbdiAm1sCl1PPnARsEU/gIo8gvDqsL4zpkafexMGSodg8W2jgTOvSisF9L5pF3LeDsZF4O8zDQ2uj+KzpbGQ0HPLxjfyGd9M0meoGCHC+a2KUFRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aEwF6wr7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y7D0ZCQM39P9yAtVSGieH7wkwCxdhwDLnwLqRoN3MC0=;
	t=1707921283; x=1709130883; b=aEwF6wr7h6q1kIGAqigGYbUedKFxiJc5becN/Uj4lYvp8XY
	uMLjCzF7Qoz2QjO76Lu9y3FMePmdoxa5RSfAgFznPbhuaH4pYeHL4SG5hNPV2Pov8tBY+1zO7av/0
	VBj4PcMjjjhI3UyboA0UY/hRLXCo7EiVAKtk4EQywFZ4LDcMJF/y0P6Hjbr0d+i5tB04MvQUq8HFe
	FxDBr8p62uvHirDPjbjFp8zr4mNQzLSvvPxZUQNMXW12BSxGoi/+BGitOa8Tn6a+54f4RZKND6lsP
	QbMJhHjiN/cgpf5WVURmK+WQujYu7w8KXIplZCHvu2P51+Sni8i309gd2MWNOwRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raGLQ-00000009AEG-1Bc6;
	Wed, 14 Feb 2024 15:34:40 +0100
Message-ID: <311c594bddde32bacd45acbfa6f40fa7670e51c6.camel@sipsolutions.net>
Subject: Re: brcmfmac AP mode
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, KeithG <ys3al35l@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 14 Feb 2024 15:34:39 +0100
In-Reply-To: <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com>
References: 
	<CAG17S_MOiC43F2wXMG-Y6nQgitZQJs18jESQJrX+aC6=MQb6ew@mail.gmail.com>
	 <e0825627-4652-4c5a-ae29-33c270a38bc0@gmail.com>
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

I have no experience with brcmfmac, but ...

>=20
> I was helping Keith out here and wanted to provide a bit more=20
> information. I found there were a few differences between IWD and=20
> wpa_supplicant related to scanning which may aid in figuring out why=20
> brcmfmac is behaving this way:
>=20
>  =C2=A0- IWD scans using the wdev ID where wpa_supplicant uses ifindex. N=
ot=20
> sure if this has anything to do with the difference behavior.

This is not even visible to the driver, it's entirely resolved in
nl80211, so no impact here.

>  =C2=A0- Passive scans (which IWD prefers) seem to exacerbate the behavio=
r.=20
> Simple testing using "wpa_cli scan" showed wpa_supplicant was only using=
=20
> active scans. I also tested with iw and saw repeatable disconnects when=
=20
> passive scanning. Disconnects while using active scans (using iw) were=
=20
> much less frequent.

This makes sense, especially if it's __ap rather than __p2p_go type,
since it *has* to be off the channel for some time -- especially for
passive scans it has to be off-channel for more than a typical interval
to even do scanning correctly.

>  =C2=A0- Scanning with IWD, wpa_supplicant, or iw, passive or active, alw=
ays=20
> resulted in beacon loss for clients connected to the AP. This was 100%=
=20
> guaranteed. The clients just could recover when active scans were used=
=20
> over passive. But either way this does not seem like normal behavior,=20
> the AP interface should still be beaconing on its active channel during=
=20
> a scan right?

That's "normal" in the sense that you have to be off the channel for
scanning, and if you're off the channel you can't transmit beacons on
it?

For P2P GO rather than AP it should publish NoA descriptors in the
beacon to let clients know there won't be a beacon.

Now it's perhaps possible to time - especially active - scanning so you
can still beacon somewhat and inbetween, but I suppose the firmware
doesn't do that here.

In fact even outside of the beaconing, APs aren't expected to be off-
channel, clients can send data to them after all. Again P2P GO solves
that with NoA, but the spec itself has no good way to solve this and I'm
not even sure it would even want to.

In any case, you could argue that starting AP and client and then
scanning is pretty much _asking_ for trouble.

> If this isn't possible or can't be done reliably then=20
> should the interface combinations be changed to disallow concurrent sta=
=20
> + AP mode interfaces?

Maybe it could restrict it to P2P GO instead of AP? But then people will
anyway just notice that they can use P2P GO and connect arbitrary
clients to it (not just P2P client), then those clients won't honour the
NoA because they're not P2P, and then you're back to the exact same
situation...

johannes

