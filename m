Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48F045FF67
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhK0Ofs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Nov 2021 09:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhK0Odr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Nov 2021 09:33:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16323C061761
        for <linux-wireless@vger.kernel.org>; Sat, 27 Nov 2021 06:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C84B829F0
        for <linux-wireless@vger.kernel.org>; Sat, 27 Nov 2021 14:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E4C53FAD;
        Sat, 27 Nov 2021 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638023253;
        bh=psZ+IFS1ytT8ef0e5bTaNPW4wPXQRSYkPJuw/V1P0jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIvIW5WmixCYmIoldztjxyn1j4h7IwaKpoQteNm3tgf5at3VrEqoSZvjkA+4UDUpQ
         eyOPjS1HiXgIKqX5astKUGeSab3DVwVq2r716xzxguU4/msdZ1Cat8aaEuZXBIImbK
         tCmErk16i3RBM5Q1sRNvJ3AgN2n5b26ExagbQ7Nw4+rjz7RIkcUYfLQ+ULl+UkzII+
         0wBtt8j7rBY0PIExLsdjODqSCWY2n6yBE0fxQMSi94hxpbEynaQH3nTZM/UIal0EKK
         aBLo4LPciQBQqYm1gISiuBvot18Bcd/zbYOnURAoyE4FCcZ4tjjFJ9BAeyLopJTLAl
         MCNQdcERb9KlQ==
Date:   Sat, 27 Nov 2021 15:27:28 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>, sean.wang@mediatek.com
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Message-ID: <YaJAUOkLoQ3mOjcQ@lore-desk>
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
 <YaDo21+/MBeeuTDN@lore-desk>
 <87fsrj3qxo.fsf@codeaurora.org>
 <YaD8lT5csiLvmBzS@lore-desk>
 <87sfvij4eh.fsf@codeaurora.org>
 <YaEJ6hQ0uC32+Mts@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XZvknOft3AZA1dOn"
Content-Disposition: inline
In-Reply-To: <YaEJ6hQ0uC32+Mts@lore-desk>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--XZvknOft3AZA1dOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >=20
> > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >>=20
> > >> >> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >> >>=20
> > >> >> > Fix a possible idr pkt-id leak if the packet is dropped on tx s=
ide
> > >> >> >=20
> > >> >> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> > >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >> >> > Acked-by: Felix Fietkau <nbd@nbd.name>
> > >> >>=20
> > >> >> Patch applied to wireless-drivers.git, thanks.
> > >> >>=20
> > >> >> 2a9e9857473b mt76: fix possible pktid leak
> > >> >
> > >> > Hi Kalle,
> > >> >
> > >> > Unfortunately I found a regression introduced by this patch for mt=
7663u (and I
> > >> > guess for mt7921s as well). Do you want me to post a fix or just a=
 v2?
> > >>=20
> > >> I don't rebase my trees, so please post a fix. I was planning to sub=
mit
> > >> a pull request to net tree today, but is this so serious that I shou=
ld
> > >> skip that?
> > >
> > > I have already tested mt7663u but I do not have mt7921s hw for testin=
g (but the
> > > behaviour should be the same). I guess we can split the patch, just p=
ost the
> > > fix for mt7663u and let Sean the time to test it on mt7921s (I am not=
 sure
> > > mt7921s is already available on the market). In this way you can send=
 the PR
> > > today. What do you think?
> >=20
> > I think it's best to wait, I prefer to have proper build testing on my
> > tree before I submit the pull request.
>=20
> ack, fine to me. Let's wait for Sean in this case.

@Sean: if you want to test the code the patch is available here:
https://github.com/LorenzoBianconi/wireless-drivers/commit/1ffda36c7cbe3a6c=
fc31868895417d0cd6755306

Regards,
Lorenzo

>=20
> Regards,
> Lorenzo
>=20
> >=20
> > --=20
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >=20
> > https://wireless.wiki.kernel.org/en/developers/documentation/submitting=
patches



--XZvknOft3AZA1dOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaJAUAAKCRA6cBh0uS2t
rBSKAQDRQR8RjyPz9L5LTwu6E+eCCcWKLNHGmX30mQdDeiCkSAD7B0U5jnb0qgQQ
llis5tomON9irFGsO7vwv8i4pidLhwU=
=aS4N
-----END PGP SIGNATURE-----

--XZvknOft3AZA1dOn--
