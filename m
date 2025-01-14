Return-Path: <linux-wireless+bounces-17484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02699A105E1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3556C18881E7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53F20F995;
	Tue, 14 Jan 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b="2cx/QHZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.vapourmail.eu (mail.vapourmail.eu [5.75.183.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC1234CE0;
	Tue, 14 Jan 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.183.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855373; cv=none; b=ix1s/CHQta2mmBfE1AbmPfp//gBi4JPcb6o2xyt92A+fARo4UIvytmL7EI/yiWLkmPmkBIjbDPaXYM2ab7GEMJkh+MD4QEpcfBTWvx/6fwA2DThr3KQr6ONUTq6lMwo6zWAfumjuhPemyL9EHg9f7Q2+i4uxxA9P4a3tIdSz0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855373; c=relaxed/simple;
	bh=RP3FCB+SXv/jNTr5x1Irlv76KRajHH9p0qejlpwzuws=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QHVudNPygao+FkgTrX3kFSTATz2wrpAy9qNvu6mnhpJ+CmoiI1G20lNLa8wracV22OJRpWqVo+JSlpwQFs4NSaCiAsGaxLwXTDth4EeSM4FjCxsk8LDairTWDqkEYkeur1BvY1mUP0VD16VJg9OutkkoHnOmiV1iaWQ/MYQ8xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=johnrowley.me; spf=pass smtp.mailfrom=johnrowley.me; dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b=2cx/QHZF; arc=none smtp.client-ip=5.75.183.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=johnrowley.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnrowley.me
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 586A3C46BA;
	Tue, 14 Jan 2025 11:37:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=dkim; t=1736854673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP3FCB+SXv/jNTr5x1Irlv76KRajHH9p0qejlpwzuws=;
	b=2cx/QHZFgsgb39hYjt0ENbjY8tedP36R4z4jDsqcn5z6vuOW8uvHwMiMIEJe7Kkv4yuqrO
	/lzZsXNasvw6T9QZHkIT/h8/wiessRnvcIuDaI1PdtFTL14gUwgyVeNyDgFlwwuIZPOOV5
	9+0Li599scTWddrow24oZ3tHjeENouTfhjDlBqtTAk1MflACMY1XV9ZfWRctjq2h6nDrOo
	JjVEj5tkpE1GcCjlSO95TjZj27mZbPs4fHbbUCaXP4n/mx1Rby0h3LXjABkSoSZjsL6BbT
	ei3zr1z81ptPY8+iDRd0uUPXW8CsGx8NDy8LclxM2jrM+q4YsNguNE0dMlJXVw==
Date: Tue, 14 Jan 2025 11:37:49 +0000 (GMT)
From: John Rowley <lkml@johnrowley.me>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org
Message-ID: <4e8eba1c-b0df-4930-8b88-319587f8ddd3@johnrowley.me>
In-Reply-To: <202412301022.BCAC61BD6C@keescook>
References: <1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain> <20241230053806.GA129354@ax162> <202412301022.BCAC61BD6C@keescook>
Subject: Re: UBSAN array-index-out-of-bounds: cfg80211_scan_6ghz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4e8eba1c-b0df-4930-8b88-319587f8ddd3@johnrowley.me>
X-Last-TLS-Session-Version: TLSv1.3

----------------------------------------

From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
CC: John Rowley <lkml@johnrowley.me>; johannes@sipsolutions.net; linux-wire=
less@vger.kernel.org; stable@vger.kernel.org; gustavoars@kernel.org; linux-=
hardening@vger.kernel.org
Date: 30 Dec 2024 18:35:34
Subject: Re: UBSAN array-index-out-of-bounds: cfg80211_scan_6ghz

> On Sun, Dec 29, 2024 at 10:38:06PM -0700, Nathan Chancellor wrote:
>> Hi John,
>>=20
>> On Sat, Dec 28, 2024 at 11:21:27AM +0000, John Rowley wrote:
>>> Hi, I'm experiencing UBSAN array-index-out-of-bounds errors while using
>>> my Framework 13" AMD laptop with its Mediatek MT7922 wifi adapter
>>> (mt7921e).
>>>=20
>>> It seems to happen only once on boot, and occurs with both kernel
>>> versions 6.12.7 and 6.13-rc4, both compiled from vanilla upstream kerne=
l
>>> sources on Fedora 41 using the kernel.org LLVM toolchain (19.1.6).
>>>=20
>>> I can try some other kernel series if necessary, and also a bisect if I
>>> find a working version, but that may take me a while.
>>=20
>> This looks related to UBSAN_BOUNDS and the fact that version of clang
>> supports the __counted_by attribute. I do not have much time at the
>> moment to look at this but I have added Kees, Gustavo, and
>> linux-hardening for further analysis.
>>=20
>> Cheers,
>> Nathan
>>=20
>>> I wasn't sure if I should mark this as a regression, as I'm not sure
>>> which/if there is a working kernel version at this point.
>>>=20
>>> Thanks.
>>>=20
>>> ----
>>>=20
>>> [=C2=A0=C2=A0 17.754417] UBSAN: array-index-out-of-bounds in /data/linu=
x/net/wireless/scan.c:766:2
>>> [=C2=A0=C2=A0 17.754423] index 0 is out of range for type 'struct ieee8=
0211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *=
[]')
>=20
> This is this line:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->channels[n_channels] =
=3D chan;
>=20
> and later:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->n_channels++;
>=20
> Patch should be:
>=20
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 1c6fd45aa809..ccdbeb604639 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -763,12 +763,11 @@ static=C2=A0 void cfg80211_scan_req_add_chan(struct=
 cfg80211_scan_request *request,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0 request->n_channels++;
> =C2=A0=C2=A0=C2=A0 request->channels[n_channels] =3D chan;
> =C2=A0=C2=A0=C2=A0 if (add_to_6ghz)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->scan_6ghz_params[requ=
est->n_6ghz_params].channel_idx =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n_chan=
nels;
> -
> -=C2=A0=C2=A0 request->n_channels++;
> }
>=20
> static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,
>=20
>=20
> --=20
> Kees Cook
Apologies for not replying sooner but the above patch works perfectly. Than=
ks!

