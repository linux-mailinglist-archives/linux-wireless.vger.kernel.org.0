Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115E6312BA9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBHI0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 03:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhBHI0B (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 03:26:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EBA064E88;
        Mon,  8 Feb 2021 08:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612772721;
        bh=bJmRjsiSyDKB8EuLC2eCeYeypueQX53oW51yh6sXFfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eo7DmUfJYUIx/SZDqO85IQ8IWNd49kBkK7OlfjwjhefEPxaZFbs7b4NUxIfvQTX7W
         Nz0rDg8EtzSKkjBBpcygoUIiQCgZDwJu97nu5fCjpBuIvhcVV1TkFp1O1pT5OmIjWQ
         XF6Q0qBWHGuZhlEoKv2eARPHm8aWIpAFIacyEdFjc6zOZfl9JxUMa8r3TS7Gm06ZdH
         zZtT0iDXVoyXeqcZuohqKkMenBo1ZjePXPLSEHqRthrun40myN1EFUojw330qPIXrZ
         a4fUfCTZrRsN6vp+kjWbJvw7vMBPgbeyiKK3nF2EXbWEaVYrw+5an20DWsL7eQwB9E
         Hn6fsnA0aR13g==
Date:   Mon, 8 Feb 2021 09:25:16 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: dma: do not report truncated
 frames to mac80211
Message-ID: <20210208082516.GB2593@lore-desk>
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
 <87mtwfkr6u.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <87mtwfkr6u.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > If the fragment is discarded in mt76_add_fragment() since shared_info
> > frag array is full, discard truncated frames and do not forward them to
> > mac80211.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Should there be a Fixes line? I can add it.

I am not sure it needs a Fixes tag. If so you can use:

93a1d4791c10 ("mt76: dma: fix a possible memory leak in mt76_add_fragment()=
")

Regsrds,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCD1aQAKCRA6cBh0uS2t
rM8zAQDgnHedizncT61cn2dTeG6ZRl7eHrBzm/e0MgRdPttdZQEAnjcGwGTWT/Qg
+/yBT1AYYa+xGnKSj4MZs4QWDKw2pgA=
=fo7h
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
