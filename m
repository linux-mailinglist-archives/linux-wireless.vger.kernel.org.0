Return-Path: <linux-wireless+bounces-35208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ9xA6iJ6Gk6LgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:41:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A4443945
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3396E3051D91
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD23BFE3C;
	Wed, 22 Apr 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="v1YTomew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD613BFE26
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847154; cv=none; b=HEhdmvU7EFZ8Aya+k/hwflhbaTZjdY0xPpaDeECBIAlaofXA0lGGpsK52bUCWiY/Ng8rje51M+P8wz3aJNJqMMW+vDidLJgc+xKr19TnkYvQzGKvFomfFAOQvSGpVSUPBgUzNloCgpz6GbU5JDEVAkCqMHjglEOJqQL8Shl5rM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847154; c=relaxed/simple;
	bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km7Z0mzr0B6ZZ9vKJgJ57OIiFmwRT9L3LcuoSSuCoSg1NVyRNspArbbYNrJmstGVectSnWlTSISwjAroEaR9nEpS3OhvixRZhFuPAjVgjfe2iy22ZC8u/88QgEmZSByV91UUhADeFXHuRQHU2jNYjBcunM/eIzNUJ7stFn3gLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=v1YTomew; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so84839645e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776847152; x=1777451952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
        b=v1YTomew26XxGa7wn6+QxxofnmzDY8MG8Q6rSlhbD8KbXbHX3swtg4/aqHuKZEt5Ml
         5orPpH3A2YbkTX3LYpLEkerb58BPIUXoi+kYvqmVcgE/6QGws87PHA8mbzxqfVBLLihO
         GFXGG0HV2wRSCNebZG7x1mB6lZ8pamVNKzxYgwGcr5lAEQccQYtCNnwFlWrTCTU+3yOD
         n+2asT2SpzYDKVgGMCpnHu24R1rhDkcIqSL/6DE+q3ogCvfIPhS/gTpKhm9T9AVPIEBa
         KXMaWwS4onPU15IoQv4TVWG2sEILmc5unmE+wcltWJ95wMM8f/RmGQE0KlCYjxgVQHJx
         uQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847152; x=1777451952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aD5ZKvzwCJWOAYfguqrWQTS2cpGeKYz2zFLAh1cyFuE=;
        b=Qs+hYybp7Mng75rQRDKVoVKWSZ4aAgbEm8shdK7lEVrz5uMbONxGpZ7KTcfRe8Fk8J
         AX1ZlojmoGUXynjrr41wPsUCCRhLnRgb0cwDXTXiR0kKgYOQNLol/azzd1r2Ref7zgK9
         DzRwuDBl1ssQjB99SmOUMrKlxeMC66cBxRSWYiBxs0htDzogFfHleMqddfuk6M6Mkrzb
         AFEnkoN1BPUFtwfytClQT2WN06m1CE7RYn6VPgXv+jn08hHd++KzQ51VssdJWknCK5lE
         Hljy9udCpO5IAZUASWKJ61ME4DyAeWxe5Vp8SRUxgQZsXA3xxaqvGC28uLVYNKRCE3Wi
         hfQg==
X-Forwarded-Encrypted: i=1; AFNElJ9IzWX+ovQH1zREHXjNUl2T3YEAfWpBtSucF/VJk+BuDh8BzzBjDelEZDJFz4XBU2DSNChqJL3a4YrkfmqSLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6ABa7WhcHykfPes32UbMGlqjZgDvOp3e5jMUsacvUaZl+2Na
	cbCc48BeJ1QcKFh08xobvDSCUIqQ11cPtSIJoitStzvGmaBeIvsKHqVqsXEj9T1KjUU=
X-Gm-Gg: AeBDiesoBsSPpuqUutM9M9kpuQ7Y8YIXD7MJlf3YNR5KnfJ1hR3MuE/STBX76IwQOQW
	ilHMEp3v7m2YbVDGv3vg+9NfSXQuupMHJL+sUe0FkJ30r8z+zv75JOG182JuYpn9Vpemrb0wL56
	xF1W5NTUCaaB7gCuh6gUCyPOg8VmuKLHbieHUxD5SlkgOmdxeHOz9O8Q6BwEXImAYRSRSeTj0fU
	ht0iOxMryXAmrRKA296Izk8LWosOuZm51wrnZ/o1Qd3zocLxqhyH+Up65MQiYn0k+ag2aSjnYNK
	95q3fM3WCZ4Da2jx15eWSKT9XfujVxNPtzggjB9OMWyzz4hJYZEJLdjdybjqA9Sl4gwM1fwqdF3
	eHanWcl7ujWq+VrqsO2ksFrPdTFaGXtbokiDPtCWoJzkaCfokS9iFo91YKmfSpNbmk2ZlvKMmv5
	VInHYgduUoKcoWNUmVHA0cPQVZEV7z4OdfQ2AsNFWBO1kW9E30SxQpgLmDK9C61a9GzFMhqIZM6
	+TtWTKiqXPoX76GVs2dR+nDFA==
X-Received: by 2002:a05:600c:890c:b0:487:1108:48af with SMTP id 5b1f17b1804b1-488fb7389a6mr245381575e9.4.1776847151437;
        Wed, 22 Apr 2026 01:39:11 -0700 (PDT)
Received: from localhost (p200300f65f114e08a760282010012dc7.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:a760:2820:1001:2dc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc0f8188sm455887645e9.2.2026.04.22.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:39:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:39:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <aeiHTPOA9jQrNWkX@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
 <aehwG2Egt93-sPVB@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqsqetyrnjrxwten"
Content-Disposition: inline
In-Reply-To: <aehwG2Egt93-sPVB@ashevche-desk.local>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-35208-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6F2A4443945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vqsqetyrnjrxwten
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

On Wed, Apr 22, 2026 at 09:52:11AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2026 at 10:12:41AM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> > > On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub)
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (Th=
e Capable Hub) wrote:
> > > > > On all current Linux architectures sizeof(long) =3D=3D sizeof(voi=
d *) and
> > > > > this is used a lot through the kernel. For example it enables the=
 usual
> > > > > practice to store pointers in sdio_driver_id's .driver_data membe=
r.
> > > > >
> > > > > This works fine, but involves casting and thus isn't type-safe.
> >=20
> > To be honest, with the involved void* this isn't really type-safe
> > either, but at least the data keeps being a pointer which is really
> > helpful on CHERI. FTR: The alternative would be to use uintptr_t instead
> > of unsigned long, which also has proponents in the CHERI community and
> > which is used in the current vendor patch stack.
>=20
> FWIW, Linus categorically told that it has to be no uintptr_t in the Linu=
x kernel.

Then I'm lucky that this patch set doesn't introduce uintptr_t and so we
can delay the discussion with Linus about that. (And we will have to
hold that discussion at some point, because on CHERI we have
sizeof(unsigned long) =3D 8 < sizeof(void *) =3D 16. I didn't check, but I
think also unsigned long long cannot hold a void*.

Best regards
Uwe

--vqsqetyrnjrxwten
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnoiSsACgkQj4D7WH0S
/k74eggAtKiYZRohFpdNo44fvylrlq/Mfus5ZHYrI8EWLZuC+qMr7/LiHwZ8cxVQ
atxZNwrK0qRyfjUM/lFUKvVOSQwTQzqaMGF0dNjfTVALktKCe6sLNr+gOXDqofhx
UZn90knvTDOO5WfcrIf1K/ojUlgsGJ/4r63JkF3ZXPn8I3zd3NFFjhgn/ZzJkx74
5CJywELP1+kmz3pLRw0rHztfMl3gmPTsxCWqHmxLNsNtSVskl2dRZH9FMfvNKCQo
KwuE7hCxtAWO4py/igcaNXz/fS0nMSCqIo3IbxAzqfJAnHgPpGrvAKSOB4GLVCoc
hmaPoy6M67vqAg5NjGB4uniPlgvymw==
=8Fwl
-----END PGP SIGNATURE-----

--vqsqetyrnjrxwten--

