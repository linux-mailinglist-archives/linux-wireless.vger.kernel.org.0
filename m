Return-Path: <linux-wireless+bounces-36898-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF25BGxrFWoBVAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36898-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 11:44:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A25D395E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB3D300EF9C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29A3D7D64;
	Tue, 26 May 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lEKKrvK4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61233CD8D3
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788300; cv=none; b=p/YQmBDQjLwMVX9HR9fd2Kva5k8j1DtPSqajUzcoWZEp5DvIFZTjh1UmAA+/NDRConrINTeiTSEKNKKCMrvLtEgyj2hff/MMKqJOki5DNIhSIWftcxchL2sERPz3KENmJ5RcyomflYZ3v+py1mCzx1CAZcy4dy18sVDsRSUp7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788300; c=relaxed/simple;
	bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5kuVhdP9lU+MKTHya2HTXkmHCghnQLPAkuh25ws494dWu0+bSl4Xjac544Q0QrKt6TsrVPxEFrdlOn4dWi/BfmyGG/M73xb6m+bNe1+ayd4+uyqX1fWGUavd8vKPfHhZcmsryzYmMwzHsvnCHkWWm5ztiqAUyDWlv13Vby8MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lEKKrvK4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe62837baso6037051f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779788297; x=1780393097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
        b=lEKKrvK49QgmB6x/y+qpXA1KA0bnbMEP6IO3yJzfYm3FBYiPa5hAcQMU6Z9eUMT1Ot
         y2U+uCnwT0Dph9Fy9Wu73sypiEmroqtd7H0h358q8bgNpXyTvNsXFkG5w/uKC4Qt1Aic
         IftxxMPtWO6sVN3DJ1bwOS2pmDQlaSlNlRSiv3fu9mhf0UoMeKUaxH5ByfzQWHn6nnK1
         GlIqILqAaaPTbQ3PoNcAKnmiOzbz0r5tbaTbBAdfObngsANtyBiOXgkdVDLygd30rzys
         VA2yfKASkWiYh9UoDqDQTzHe3OrNl7mGvDRIQxHWoVXEUoWMIdhTceUwajQ6ZOftmbBw
         IbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788297; x=1780393097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
        b=GSg96eD3RfBH2jKWhRuFCGROZclLywMneu+WJH9utc0mnYuLUh4FP5M3RbegBL+maS
         0BVwGKBc79g1RsPcI+Fzdxbe+5u0OzKqDif2bkmFhnmEuFDtB407KJBgxTGFf2kw/1tB
         lworVDzOyF2tt/jPw/3Eg1xI1Bp7nd1PsfBxTjZLhpbfbi/1Iua94S43di1nsXemIjTd
         aAcuSbmUtVGnCPevxOJF/F5gb/kMBEuLJ8bLme4dPqi2XVH59tRG6pQEiWVaRxS6Vi8W
         vSodtHp7x0oBBaIFe329ENKSQ5yFSBK9t7MrahzJBu2SbB2KBT2UZMYZ3RWTyUkfRiMt
         1BMA==
X-Forwarded-Encrypted: i=1; AFNElJ/k7RKGhgFTOJoBWyI8q3VTZBiCxTn9PMesQcGnwZG6Nks0LuPI/3EPOFmf1wn52QvSqF5XeuX5FIuTgWyJfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv/HLoNXkEEqirrhc1qaA0w3UA47mGTAMAzQZnYYnI8/GH9g1
	BDKtBiNWVe3dlpgz/2ans1f47cQcujmJmdGcYE2+sC66dhmr6LX138m2SXpN/SDv5vc=
X-Gm-Gg: Acq92OEpQMRKLe8JBWi7pXV0QM2RTB1rFbM4yDGjdBCyBKpkNG9bp8EihjOhn8ybjTw
	6V0mfE+AGeipA2m5YpLbn1E2Vo5vjCXDfJiCGuNcfbVshf68KEbVwYq2y21efwVUtlXeIBBrWa4
	D6I2UxmhrEwpfg6BWpbDz6cppE47reiKRMKeYArzKvpUme/5YBP+80NrGM48Ct2V8BddGyR4K/h
	CcoEfbtNCqmdqQ2hMS+WCtPdo6FaBMeVWdkfsT0GoG9AHhulnKJ8ys9ZJ2fSfm+hCTsp8z5syen
	H/4GE3ek8OhYrdYxdduu2wBM3gaEoGvtJKFHLCv1Bes6cw5Hh9sebY7oI2XRMyiEOCvHTzvoO/m
	24k0+d3JUzWLcHarCiqQcatlyr09LDn2DfC9ySP5kX/ETlJWVHFCO4Vl+LnFq0sWyNI3cwQehxZ
	Eys90FpoTnl6z+fKfdYtQFsAeOc1fzMET59OSNZxEWvEp/5tqOaRigl4+0Vky7qaU5vbP7vJvRx
	6Kx3JIakUprOg==
X-Received: by 2002:a05:6000:1447:b0:452:d03a:7abe with SMTP id ffacd0b85a97d-45eb38b91c3mr32067787f8f.17.1779788297057;
        Tue, 26 May 2026 02:38:17 -0700 (PDT)
Received: from localhost (p200300f65f47db047ec792ae18ec05cd.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7ec7:92ae:18ec:5cd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d49132sm34150219f8f.24.2026.05.26.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 11:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <ahVpRY6lxiWbJ7Qc@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtihelpcu7j6kvgw"
Content-Disposition: inline
In-Reply-To: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-36898-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email,baylibre.com:dkim]
X-Rspamd-Queue-Id: 625A25D395E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vtihelpcu7j6kvgw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> Hi Uwe,
>=20
> On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello,
> >
> > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *)=
 and
> > > this is used a lot through the kernel. For example it enables the usu=
al
> > > practice to store pointers in sdio_driver_id's .driver_data member.
> > >
> > > This works fine, but involves casting and thus isn't type-safe.
> > > Additionally with the CHERI architecture extension there are machines
> > > with sizeof(void *) > sizeof(long) for with the traditional approach =
of
> > > storing a pointer in .driver_data doesn't work.
> > >
> > > By replacing the plain unsigned long .driver_data by an anonymous uni=
on,
> > > most of the casting can be dropped and it yields a working solution f=
or
> > > CHERI.
> > >
> > > All users of struct sdio_driver_id are initialized in a way that is
> > > compatible with the new definition, so no adaptions are needed there.
> >
> > sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
> > log and once in the short log. If you consider applying this patch
> > please adapt the commit message accordingly.
>=20
> No problem I can fix them up once applying.

Now that Ulf gave his blessing, would you please merge the first patch
and the bluetooth ones (#2 and #3)? I will follow up then once your tree
hits Linus's tree with the remaining patches for wifi.

Please don't forget about s/sdio_driver_id/sdio_device_id/.

Thanks
Uwe

--vtihelpcu7j6kvgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoVagQACgkQj4D7WH0S
/k5P8Af7B8UAQJSjX3WHqmRdJihAfbJzuB0qsIl9eOVYHCAaEiAnVpqnjNkntHIU
lX0CcswR4fXl9pEV+1mobDSLHsbDhg9BtXTuAm4pavvYRoS5isVyCkasNUeNDGt9
B68NNR4oKyApL/DFvXCG4CPWrhA8TL+m9HE7DCkm2IYcH2TB2WdUCQnnQFV8E94x
1eyEfCrTCqn5UlW+2urdJLmngSk7o3yv1wJ36pgHxMNQMXU8mPWN4nOCqEZAvtmP
CrtRviKQ1QpRXNBA7blduSvvqqfr7uQEKta7E2argdEhkor6XY/fTTlu687QRi6n
Po62G/0XCxIUYpanmYULzD9YbpSlyA==
=Zdz8
-----END PGP SIGNATURE-----

--vtihelpcu7j6kvgw--

