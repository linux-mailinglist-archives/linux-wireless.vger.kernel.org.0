Return-Path: <linux-wireless+bounces-10473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254F193AE07
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23B7B21045
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A274BE1;
	Wed, 24 Jul 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E/SefcR/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C921C2AD;
	Wed, 24 Jul 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810834; cv=none; b=AhlnNjLYp2OoFXkdDdoIFNPlrbsqMA/Mud+u0QJNr3N6Fpywu9PY/KFvQNM4b7rhHXDuLu9AgrE6csCAhLPAOgOEVGastNlBsbF3w4m+afXldKJWGlohnzr6attAOMu8SOxtof7+iJ6rU7xTBcQAylu1dj+T3pKNIuHpXmpYS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810834; c=relaxed/simple;
	bh=GjBzsYD6K6w17JNxvzYv8w4oRfzXrpu2qCSi4+bb+28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYNIsxnQ8jGO+cmBnNzgX6aGJBkYPl24cBg9arkOhiVDGHZaeawk0zJft/SdTM59J+J+Ib3IDXQtp0zbQEYF1U1M2+49moJ+eMsz8YDnJYqtfVq30Z6rqzquawrXCig489x+krahE8JwWJCmTSRQ/m8wgf6ZLsfDUN5YOysHBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E/SefcR/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hsI3nZ44Y5P47LGt5BrokAu47Wy+gx9WyMBY6tap8m0=;
	t=1721810830; x=1723020430; b=E/SefcR/J70dNYw9EJMzJ9F42SY1hYsCFKG1szGi79RRjSJ
	DZUxGR3r6SGdzBbobcMY7T72x8+Ur4lke4strsdSigBg3fI7c7mTCdu+parU/WfL7hOG5ztR9imZ0
	nwaNYGBGsJXG3xGWeES7ZWtyyovGMMfcNKgF9H6Ipcw2S96rej4tUYsipZwnz0o2ZOpZ9FczOVYNV
	EuGEymq/6GbwppZt6m69dafQ9X5a3rcgpPwFjg2bLcWB7OH2pF5jYFFz+HE9iz1UZMsAb/MgjzI78
	HMqDoLBfhTDemBOv6WViMbSfAS3SvqoU+0vz0h2ba5EGZbnLfKFwfgXsWWTDkZqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWXeL-0000000DJUi-3qkP;
	Wed, 24 Jul 2024 10:47:06 +0200
Message-ID: <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Felix
 Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
 <ryder.lee@mediatek.com>
Cc: Michael <ZeroBeat@gmx.de>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Date: Wed, 24 Jul 2024 10:47:04 +0200
In-Reply-To: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-07-24 at 09:58 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> Johannes, Felix, Lorenzo, Ryder, I noticed a report about a regression
> in bugzilla.kernel.org that (for my untrained eyes) appears to be a bug
> in some code paths of mt76x2u that was exposed by 0d9c2beed116e6 ("wifi:
> mac80211: fix monitor channel with chanctx emulation") [v6.10-rc5,
> v6.9.7] from Johannes.
>=20
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219086 :
>=20
> >  Michael 2024-07-23 15:38:43 UTC
> >=20
> > After a user opened this discussion:
> > https://github.com/ZerBea/hcxdumptool/discussions/465
> >=20
> > Jul 21 05:40:39 rpi4b-aarch kernel: mt76x2u 2-2:1.0 wlan1: entered prom=
iscuous mode
> > Jul 21 05:40:45 rpi4b-aarch kernel: Unable to handle kernel NULL pointe=
r dereference at virtual address 0000000000000000
> > Jul 21 05:40:45 rpi4b-aarch kernel: Mem abort info:
> > Jul 21 05:40:45 rpi4b-aarch kernel:   ESR =3D 0x0000000096000044
> > Jul 21 05:40:45 rpi4b-aarch kernel:   EC =3D 0x25: DABT (current EL), I=
L =3D 32 bits
> > Jul 21 05:40:45 rpi4b-aarch kernel:   SET =3D 0, FnV =3D 0
> > Jul 21 05:40:45 rpi4b-aarch kernel:   EA =3D 0, S1PTW =3D 0
> > Jul 21 05:40:45 rpi4b-aarch kernel:   FSC =3D 0x04: level 0 translation=
 fault
> > Jul 21 05:40:45 rpi4b-aarch kernel: Data abort info:
> > Jul 21 05:40:45 rpi4b-aarch kernel:   ISV =3D 0, ISS =3D 0x00000044, IS=
S2 =3D 0x00000000
> > Jul 21 05:40:45 rpi4b-aarch kernel:   CM =3D 0, WnR =3D 1, TnD =3D 0, T=
agAccess =3D 0
> > Jul 21 05:40:45 rpi4b-aarch kernel:   GCS =3D 0, Overlay =3D 0, DirtyBi=
t =3D 0, Xs =3D 0
> > Jul 21 05:40:45 rpi4b-aarch kernel: user pgtable: 4k pages, 48-bit VAs,=
 pgdp=3D0000000041300000
> >=20

Not too well-versed with ARM, does that tel me anything about where in
the code the crash was? Without any further information I don't think I
can see anything here, and I don't have an affected device.

johannes

