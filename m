Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622002DD6B5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgLQSAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgLQSAg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:00:36 -0500
Date:   Thu, 17 Dec 2020 18:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608227995;
        bh=Te50MoqqRMHM7fjIFunWe/+4qkBpnZytK59H2S49fM4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilLDIMRlgRmsmdMzazd1qa0e6wiD7KS9YgSsra4lPbkQqTB5T1q6VtZjqh0UzggMK
         8SjyDT7X3Q4XEKFZaEMUN7dMOtOFW/HywRmTivQ4woJmlMJoOqEs5w506PtNEmipmc
         we4z5VnekH2fXU57QFgcmAOlpYX7byYC2A8iJD3iuj7nDTfrL4xiUzVySvv8AvCsI9
         2sjciXGzkzdQVkki4/Dgff8PHOba4xVqM9bBHqKzmMxPGmN3zLf3oAMmpRLPJK6dtV
         tribldj1pGaaKMBCTSItIALNaWLii08g8qRDDJ08dG88pWyDW1nBgS3VaKQbzGGdIo
         TjvJ3DxcH8wLw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: mt76s: fix NULL pointer dereference in
 mt76s_process_tx_queue
Message-ID: <20201217175950.GD16606@lore-desk>
References: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
 <20201217163616.546AFC433CA@smtp.codeaurora.org>
 <20201217171105.GC16606@lore-desk>
 <58f03209-de19-0f35-fed3-d20366f933d2@nbd.name>
 <87r1nos4ym.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <87r1nos4ym.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 17, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
>=20
> > On 2020-12-17 18:11, Lorenzo Bianconi wrote:
> >>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>>=20
> >>> > Fix a possible NULL pointer dereference in mt76s_process_tx_queue t=
hat
> >>> > can occur if status thread runs before allocating tx queues
> >>> >=20
> >>> > Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76=
_worker")
> >>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>>=20
> >>> Failed to apply to wireless-drivers:
> >>=20
> >> Hi Kalle,
> >>=20
> >> sorry for the noise. I guess to apply this patch we need to apply even=
 the
> >> following series:
> >> https://patchwork.kernel.org/project/linux-wireless/cover/cover.160716=
4041.git.lorenzo@kernel.org/
> >>=20
> >> @Felix: do you think it is ok to apply "remove wake queue tx logic for
> >> usb/sdio" series to wireless-drivers?
> >
> > Yes, that makes sense.
>=20
> Ok, I assigned the series to me and changed this back to New state.
>=20
> The commit logs in series don't really answer to "why?", though.
> Lorenzo, can you reply to those patches and give more info how they
> help? Or are they just cleanup?

It is mostly a cleanup since after commit
90d494c99a99fa2eb858754345c4a9c851b409a0 ("mt76: improve tx queue stop/wake=
"),
we do not need the wake logic anymore in the status path since the queues
are no longer stopped in the tx path.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9uckwAKCRA6cBh0uS2t
rFkcAQDHB+L74RRN8L1UOWbM2e0+fr2zDvVAJSKxSb9gWYGznwEA56n/e2RIZuOd
qNbutjZBQUrJXpwcJm1KPx5uq7Zy+AM=
=4p3T
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
