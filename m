Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04A431335F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBHNd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 08:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBHNdV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 08:33:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0860564DD5;
        Mon,  8 Feb 2021 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612791160;
        bh=U/t1IwV4ufUUzFNMKU88aGBBQ6IzUhzBsbhwEAmEs8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcqXZDxEe9hQYI2EY054RB0ZN+wx43xyPV1k9dt1TeMary+tHuz+z6G1WoGEA7JhJ
         ptzSE8qz34rcX8xH8i5Hv1FcMOi1+6ItnG2aOqZ0RMpNFsvUW6IzP+hx/N/uTMfwdV
         8I6Y3Y5Bx0G+M+P1W4qVzPYiGgDuSJoueA2mO5gPtksMOwr/RKhHDFm2DmR3dHvyIy
         RUK1JCR/KXrcvgxOdYPwDmfqiT9olxR+Rqorqk6buPlCPqLlOu2r5ah0rem3rDywbS
         UwXDS0H5lG8lUtgDLpTmae4Dcq7wJiMYhX33VZcdrfIyzkrT/3iNBxEPUDCjgl+3s5
         nDzbZyH3AlfHg==
Date:   Mon, 8 Feb 2021 14:32:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: dma: do not report truncated
 frames to mac80211
Message-ID: <20210208133235.GF2593@lore-desk>
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
 <87mtwfkr6u.fsf@tynnyri.adurom.net>
 <20210208082516.GB2593@lore-desk>
 <87im735593.fsf@codeaurora.org>
 <20210208112035.GD2593@lore-desk>
 <87a6se667c.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <87a6se667c.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> >>=20
> >> >> > If the fragment is discarded in mt76_add_fragment() since shared_=
info
> >> >> > frag array is full, discard truncated frames and do not forward t=
hem to
> >> >> > mac80211.
> >> >> >
> >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> >>=20
> >> >> Should there be a Fixes line? I can add it.
> >> >
> >> > I am not sure it needs a Fixes tag.
> >>=20
> >> I think the commit log should have some kind of description about the
> >> background of the issue, for example if this is a recent regression or
> >> has been there forever etc.
> >
> > Agree. Can you please check the commit log below?
> >
> > "
> > Commit 'b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> > fragments for a packet")' fixes a possible OOB access but it introduces=
 a
> > memory leak since the pending frame is not released to page_frag_cache =
if
> > the frag array of skb_shared_info is full.
> > Commit '93a1d4791c10 ("mt76: dma: fix a possible memory leak in
> > mt76_add_fragment()")' fixes the issue but does not free the truncated =
skb that
> > is forwarded to mac80211 layer. Fix the leftover issue discarding even =
truncated
> > skbs.
> > "
>=20
> Looks good, but I think the recommended style for commit ids is not to
> use ' chararacter. So I would change it to this:
>=20
> ----------------------------------------------------------------------
> Commit b102f0c522cf6 ("mt76: fix array overflow on receiving too many
> fragments for a packet") fixes a possible OOB access but it introduces a
> memory leak since the pending frame is not released to page_frag_cache
> if the frag array of skb_shared_info is full. Commit 93a1d4791c10
> ("mt76: dma: fix a possible memory leak in mt76_add_fragment()") fixes
> the issue but does not free the truncated skb that is forwarded to
> mac80211 layer. Fix the leftover issue discarding even truncated skbs.
> ----------------------------------------------------------------------
>=20
> Should I add that to the commit log and queue the patch to be applied
> after the merge window opens?

ack, fine to me, thx.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCE9cQAKCRA6cBh0uS2t
rNF/AP4yrNcPIxu95cRWcmp5dFjLC2PxSmQAu5oiYlAQra/ahgD/QpZHnQgQASfq
+mWVdixoVTL1ePsz59fJxgm340KJ4AU=
=Dkrz
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
