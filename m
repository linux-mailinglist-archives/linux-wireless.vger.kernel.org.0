Return-Path: <linux-wireless+bounces-230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485587FE7D6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 04:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3281B20E48
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 03:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4987B134D8;
	Thu, 30 Nov 2023 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4W0xKW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FDFD67;
	Wed, 29 Nov 2023 19:52:06 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d7e6df999fso318412a34.1;
        Wed, 29 Nov 2023 19:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316326; x=1701921126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ7N9YtES1a0DlRuZSgil/lx/WENnW1vYXJvjd/eox4=;
        b=V4W0xKW3JubweiYTxAW19gX4PehpQMcwk/exiru+ZKlKvHkXFUtIXUqOBSyG4eEydm
         ND0iYDOtM/yERpsXF1Lb8YRsply1HxgwI4Fbwk00uTY3YSJzOwJOtBI62TqBW3C+pxrs
         7aYh+x8L1zP616QXk5R4jOQfR0TanUs+JFDNFJlVcyVNlZHRjwkyv/tqBe8Z6e+iQALE
         yGvLCaKgOCS5g36CpnX/rLUNYKEqR47tMTrRxuyxrr+9G04LbAmZbrC8ZaRIANAE+A+4
         CsVO/oeaCgY1umXBEDXt4OPYFQ5FBurHRNLLsm9DZGzRQ3eFW69hJQyjpRjNYre19pqu
         00EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316326; x=1701921126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ7N9YtES1a0DlRuZSgil/lx/WENnW1vYXJvjd/eox4=;
        b=L0lPvSIVIO9ZW+MX87XUVqXkPz2MV/SE0o6addUa5Rqucqfq2BmtXnh+VO6ww0ZceK
         JvHib5QBHGyyNP9oAm4veQvr8GduxH+n1cop0nyuJK1O6XufoEYumNMUZnBcyInSTf0S
         NfCQNaQwuWcQRFLZ1/BUSbSAir4/JrNh3CQDuJwW9SQpV1Gb5wLWZvIF1ONSlaobvof3
         GQmjGYirSg3BDZhabu4eOFhk3cDhyObMCHgBIVrqSG02auCFnmK5l0lIyaKCsKMu7CKf
         DXvF8phgrEHAERa+atUvuCpaTmxO0nlJhfvjDz0OE8K+fmoWKLGyMrseoIrLJOjgE1or
         Fejg==
X-Gm-Message-State: AOJu0Yzjd8rYjEATZlxl9+illFi96PYq0m7nQKYXtoYTDuLYFv0unyjN
	t2QeM4KMGeSe7hhIjOBDiYkC+CvO/c6oeQ==
X-Google-Smtp-Source: AGHT+IHbHvpjIEjrCitzC7tr5ZCNCJ6mcLNgd03Agutg6T8XrYdJeQAzDJL77sXh7LMNpxIKOJEwBw==
X-Received: by 2002:a05:6830:1450:b0:6d8:53a5:7033 with SMTP id w16-20020a056830145000b006d853a57033mr3186774otp.0.1701316326204;
        Wed, 29 Nov 2023 19:52:06 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c11-20020a65674b000000b005c259cef481sm171441pgu.59.2023.11.29.19.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:52:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A2CBD10205C43; Thu, 30 Nov 2023 10:52:03 +0700 (WIB)
Date: Thu, 30 Nov 2023 10:52:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Genes Lists <lists@sapience.com>, tglx@linutronix.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	gregory.greenman@intel.com, kvalo@kernel.org,
	Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Linux Regressions <regressions@lists.linux.dev>
Subject: Re: crash with 6.7 rc2 and rc3
Message-ID: <ZWgG48xjHEgG3u9w@archie.me>
References: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
 <ZWV7JworMrjHJHsO@archie.me>
 <cf2dcc97-845d-4860-be4d-5822d2ebbfca@sapience.com>
 <022c67aa-b90a-4756-8725-5f7fba7dc780@sapience.com>
 <2ce6a24f-fc9b-45d2-8a11-73a3e69ffa13@sapience.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KxZoA7PtHbqu5DUy"
Content-Disposition: inline
In-Reply-To: <2ce6a24f-fc9b-45d2-8a11-73a3e69ffa13@sapience.com>


--KxZoA7PtHbqu5DUy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 12:53:28PM -0500, Genes Lists wrote:
> On 11/28/23 14:56, Genes Lists wrote:
> > On 11/28/23 05:39, Genes Lists wrote:
> > > On 11/28/23 00:31, Bagas Sanjaya wrote:
> > > > On Mon, Nov 27, 2023 at 03:55:37PM -0500, Genes Lists wrote:
> > > > >=20
> > > > > lenovo laptop boots fine under 6.7rc1 and older including 6.6.2 s=
table.
> > > > > but not for 6.7 rc2 or rc3.
> > > > >=20
> > > > > ...
> >=20
> >=20
>=20
> This appears to be build related. Starting from scratch with builds and t=
hey
> are now working fine.
>=20
> My sincere apologies - please ignore/close this as (silly) user error.
>=20

Telling regzbot:

#regzbot resolve: fixed by clean build

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--KxZoA7PtHbqu5DUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWgG3wAKCRD2uYlJVVFO
o5kHAP4uvok9RabEEM91N9uXtEExho0ks8Br/ecWYC+dAMAingEAurtRwwGCaZI5
/OMmCilhJPR5UnBxrnD6Mkc7OgBfHgY=
=4mkp
-----END PGP SIGNATURE-----

--KxZoA7PtHbqu5DUy--

