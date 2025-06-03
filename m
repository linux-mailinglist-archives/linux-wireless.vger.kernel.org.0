Return-Path: <linux-wireless+bounces-23553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB4ACC4BE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572DD3A3E5E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC722ACEE;
	Tue,  3 Jun 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RFMd5vt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746D1D7E4A;
	Tue,  3 Jun 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948193; cv=none; b=n81Ac2+RyLz7whhUoQ9IeVyJzKc+DThpD41jPU3c+lAOXS47Uq5a3VCla/AIgwxRZM1U9ifgIt5uwZE1XjdtgflygnbFLnXNwJQaUveXOthltzxkWhjsg17vUDR86LsEoW+cu9DL3w//qh25H7ZFjGrKS86KnqisaZuelFq52g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948193; c=relaxed/simple;
	bh=cN651B07DXiBx3FK23+ouljV2W7aOhhbi+ZIbNVs/sk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULJTMtdLHM8KwHcQI99aVs9Gq6vCNRH4K0MqdXQ6/6FTlqB7jVRXvAzDEkLO+u5J3/6hLaUXYW+SkS1oUmTUXD1fgZXUuWp6OuhzujPC61fqarjHNYYwdhBJ7eB3u1Yfx3HKKgmrlZl4OhXDJwK7aURLeSpIbG5yOB/pTLTHUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RFMd5vt3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TQdZ74RkHcJ0nBbw7U/EMPDBs77v59i09mGTANKzU3Y=;
	t=1748948192; x=1750157792; b=RFMd5vt3eW508U2V1rOQH6KrBAkCNJy2zf2lQlLVwuaaIrF
	KCZyA1HdDKvq/3HxLTfz8DDsMibOEgJCSavJqEgh4F1byp+Qo8JGyzORNzJTgfi9goFqg/UauFztF
	FPdqNgRhyDC6bUGYrtWVbepviGaLhL+j0EytFyLlhlrVGW6popvSNOo7CwFJsor7QWNtsH1hh7oNy
	MEvd35uE4S3y/Ev6gXpuyVhLYdsszGktcGYRUUWJQxt6i1f7u4MDxSRKlezP3gJnM54dKPF5BliN3
	ZqZC4ODT7QaN/j33KTOMtK9uFcHhw/CF7sp1MvIwYzCAsqT1+x5ydoIj3zQijEUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uMPJj-0000000ABJ6-30mm;
	Tue, 03 Jun 2025 12:56:28 +0200
Message-ID: <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to
 indicate changed AP BSS parameters to drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Tue, 03 Jun 2025 12:56:26 +0200
In-Reply-To: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
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

On Tue, 2025-06-03 at 16:02 +0530, Gokul Sivakumar wrote:
> In cfg80211, added provision for the drivers which registers the callback=
=20
> .change_bss() cfg80211_ops, to find which set of AP BSS params are change=
d
> by the userpsace in the SET_BSS operation. With this the drivers can deci=
de
> to reject the operation if any of the changed AP BSS param is not support=
ed
> for explicit configuration. This helps ensuring that the driver does not
> partially handle the AP BSS params and avoid misleading the userspace tha=
t
> the SET_BSS operation is fully successful.
>=20
> Also introduced the "changed" bitmask check in all the drivers that are
> currently registering to .change_bss() cfg80211_ops. This would make the
> condition for handling SET_BSS operation equally stirct across all driver=
s.
>=20

Oh, nice! I'll have to look at it in more detail later, but one thing I
saw now is in patch 2 you have this:

> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>  0 =3D allow low-level bridging of frames between associated stations
>  1 =3D restrict low-level bridging of frames to isolate associated statio=
ns
> -1 =3D do not change existing setting

Is that -1 still true? Seems like now it should just be that
CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE isn't set and then you don't touch
it?

johannes

