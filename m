Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB83130B7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhBHLYH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232608AbhBHLVb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:21:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3D964E7A;
        Mon,  8 Feb 2021 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612783239;
        bh=MEQ7pYB5mWdi2KmSloHjSHfrmcATwSo6nvkb+hqN+bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4WxzzZb7Tv3fJnYMttKdNcCWvIWQ+Wbp5nv0GZgZkWOM9zo9m6UeCzBiBm9EZAHq
         2MJIC8s0gw6BmAq2thvIC+7OSiqN6VXQmqnsjUDfei2T8lcklbgEJiLdgPIFaLFdVP
         Xlp/Sgh7+j9MgyOBD0ctj9X9b5xoNLkkX1dnBnAplSvIIpUDRQdWRNY135o2tdg/0a
         68eIK+Z6k8gv5rEWVySLr2fqKR0mmY+JEF0J0/o1EcXx2qqX6PbnYvoRGCrUKEpZ8I
         TpGBiX89Z8arop2JUgqeQMp5hKIbkoikAusbI4IawfhrbiZMzfwLKEplWc20rQqGHw
         JWEoTV6Vumuag==
Date:   Mon, 8 Feb 2021 12:20:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: dma: do not report truncated
 frames to mac80211
Message-ID: <20210208112035.GD2593@lore-desk>
References: <a03166fcc8214644333c68674a781836e0f57576.1612697217.git.lorenzo@kernel.org>
 <87mtwfkr6u.fsf@tynnyri.adurom.net>
 <20210208082516.GB2593@lore-desk>
 <87im735593.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <87im735593.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > If the fragment is discarded in mt76_add_fragment() since shared_info
> >> > frag array is full, discard truncated frames and do not forward them=
 to
> >> > mac80211.
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> Should there be a Fixes line? I can add it.
> >
> > I am not sure it needs a Fixes tag.
>=20
> I think the commit log should have some kind of description about the
> background of the issue, for example if this is a recent regression or
> has been there forever etc.

Agree. Can you please check the commit log below?

Regards,
Lorenzo

"
Commit 'b102f0c522cf6 ("mt76: fix array overflow on receiving too many
fragments for a packet")' fixes a possible OOB access but it introduces a
memory leak since the pending frame is not released to page_frag_cache if
the frag array of skb_shared_info is full.
Commit '93a1d4791c10 ("mt76: dma: fix a possible memory leak in
mt76_add_fragment()")' fixes the issue but does not free the truncated skb =
that
is forwarded to mac80211 layer. Fix the leftover issue discarding even trun=
cated
skbs.
"

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCEegAAKCRA6cBh0uS2t
rIACAQCwd+cSlOBOL131ueVvtm5gy62L+CALDu/eW4DXenIxGwEA1yJkyvBql/0X
kfmyvmneSVsXdNenau4MYtDSjwZ5/AM=
=MiDi
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
