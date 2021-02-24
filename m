Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17403238CB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhBXIhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 03:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhBXIhJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 03:37:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E93464F00;
        Wed, 24 Feb 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614155786;
        bh=mkRZfB816RwEiZ0LQ6UN9XhcOi5U8YawJlk98te3mgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QB3j6kceQX9uUgnCiKijUPAHADYG2UAK9L+wwC6bf4wnpB/UN2IoDQRtosR5C0xna
         Dljzz8r+bcVL6WVQ4sG9+qDcGgoezv2sB1dj14c2yzTdrloyoNYvitd4lWQl4qUFP3
         PJ1S0fznaf80OP7yd60IHaK1lZWq/q3OC5iPAQnrSDquA7zLoqU6n9/L7FjMv2GgAf
         WX9RqdAn/nCL5z6kpG/OYEIkxPwsJcL89tIp0h6LD/bBJTFzSm/XVsCaSzJJfj/jZE
         1+sYpId3OvxhAc2xPzejTvqnYrxgTmfayNcmemUq71wUfiHQ68Aut1tO3cPhb0FooV
         VJUFEEzm+XKuw==
Date:   Wed, 24 Feb 2021 09:36:20 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH v2 3/8] mt76: mt7921: switch to new api for hardware
 beacon filter
Message-ID: <YDYQBMOheHCS5wLC@lore-desk>
References: <cover.1613755428.git.lorenzo@kernel.org>
 <22be936230c356e9b57f541aaa40d6552783e92d.1613755428.git.lorenzo@kernel.org>
 <87wnuydofm.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jff0oNCEq/pt5fe"
Content-Disposition: inline
In-Reply-To: <87wnuydofm.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2jff0oNCEq/pt5fe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Current firmware only supports new api for enabling hardware beacon fil=
ter.
> >
> > Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
> > Beacon filter cmd have to rely on the associatied access point's beacon
> > interval and DTIM information.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> The Fixes tag is in odd place.

yes, I agree :)

@Felix: do I need to resubmit or can you take care of this?

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--2jff0oNCEq/pt5fe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYDYQAgAKCRA6cBh0uS2t
rP2gAP94YAOOvFtn0MYMakXMOZ8uDE+F3tptMSoeMrbL0nqqIwD/bAFQuSnNdL15
FOaSYU5ryPI3lusQY9DosUleq2kXJQc=
=1oMe
-----END PGP SIGNATURE-----

--2jff0oNCEq/pt5fe--
