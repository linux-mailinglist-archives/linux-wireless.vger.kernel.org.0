Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4B33668C9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhDUKEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhDUKEA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4F8B61430;
        Wed, 21 Apr 2021 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618999407;
        bh=Kt6k64ofavrYNWx4jU3WxDs8uhFd3PclCOGGizTdj1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce//A4tiFaI7Ck8Z5tk7esCjAtfZN+p8Z5uVoUyZ+1NGHAdqW9rWJbJ0YJc4MKYSg
         Os/G/CTg10niMl8uUd2UQiFJJZPEGJXcsoflMmAkPW7QlrrnfaoJDY11lKr+ECnNVS
         TO5Yy3R5FGNRpDbiGAFpiqB2ehzJoECr2pqW80ciDkWbN3MnfU77zYgY6EmM0GlWrQ
         CQESq755+t8ojAf/ltu4Fqx4X/WEk5zdAYZTPPKFzQ2eXeUJkFwoN5UcPNZZBDnPEX
         QkwYI2VBXu3XWociCYboXFMR5o5ui9RQWrxkfN4ROQG2W4I0PqUM2bOz2PUuF4zGZP
         yWJBmeNtGXarg==
Date:   Wed, 21 Apr 2021 12:03:22 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for
 PCI devices
Message-ID: <YH/4aqmfV1sJKjgY@lore-desk>
References: <20210326180819.142480-1-toke@redhat.com>
 <87a6puimgu.fsf@toke.dk>
 <87lf9cj969.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L8QW3+bAb9+wFMA0"
Content-Disposition: inline
In-Reply-To: <87lf9cj969.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--L8QW3+bAb9+wFMA0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Toke H=F8iland-J=F8rgensen <toke@redhat.com> writes:
>=20
> >> When the error check in ath9k_hw_read_revisions() was added, it checke=
d for
> >> -EIO which is what ath9k_regread() in the ath9k_htc driver uses. Howev=
er,
> >> for plain ath9k, the register read function uses ioread32(), which just
> >> returns -1 on error. So if such a read fails, it still gets passed thr=
ough
> >> and ends up as a weird mac revision in the log output.
> >>
> >> Fix this by changing ath9k_regread() to return -1 on error like ioread=
32()
> >> does, and fix the error check to look for that instead of -EIO.
> >>
> >> Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV regist=
er")
> >> Signed-off-by: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> >
> > Hi Kalle
> >
> > This patch is merged as "deferred" in patchwork - what's up with that?
>=20
> Just lack of time on my part. Reviewed-by tags would help a lot :)

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--L8QW3+bAb9+wFMA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYH/4aAAKCRA6cBh0uS2t
rJVtAQCdL4nnW9Jd8W/hZLlBn/eidn3rZ2E4asRPcdamMTjeegD/R6nl07Ih7ZW7
2+GjbkHsfdROXCqBcOJ1FSatJ1/rGAQ=
=aVsC
-----END PGP SIGNATURE-----

--L8QW3+bAb9+wFMA0--
