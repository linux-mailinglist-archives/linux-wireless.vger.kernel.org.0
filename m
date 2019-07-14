Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF667E6C
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNJ4y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 05:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNJ4x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 05:56:53 -0400
Received: from lore-desk-wlan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065292064A;
        Sun, 14 Jul 2019 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563098213;
        bh=PAxZQ3SN1e3X2UG12rpAKhAMaZKoC8inZ1h4yaZd/6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbjGr4ChdZVOAT3S476M2cZa7yP9R1C4ln7Dkc/iMTT06SAK5jzB+WfvUp37/hv6R
         4jwcMQMdo5dzJD37Lsy8ko6TCLCVP8RECz6YD/RTDKE6gEOx4+aoVCG+lf1ETsiBYh
         8Iba0Z9XIf60qu5kzBwo0t+ppDIcyxpcGvrJeC+0=
Date:   Sun, 14 Jul 2019 11:56:48 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mac80211: add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE to
 ieee80211_key_flags
Message-ID: <20190714095648.GA30218@lore-desk-wlan>
References: <1dd6dd782121d0b9cc32dec6a01db474e568ffb2.1563030033.git.lorenzo@kernel.org>
 <0112d5d6a0c83dbb800811b414ca1d5b3266e9dd.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <0112d5d6a0c83dbb800811b414ca1d5b3266e9dd.camel@sipsolutions.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2019-07-13 at 17:03 +0200, Lorenzo Bianconi wrote:
> > Add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE flag to ieee80211_key_flags in or=
der
> > to allow the driver to notify mac80211 to allocate mmie space for AES_C=
MAC
> > hw cipher. Moreover mac80211 will set MMIE pn while MIC will be computed
> > in hw.
>=20
> Hmm. It probably should be called something like GENERATE_MMIE in line
> with GENERATE_IV_MGMT etc.?
>=20
> Purely adding the *space* wouldn't really be all that useful, we're not
> really going to apply our tailroom request to this since it's a
> (relatively rare) mgmt. frame, so ...

Hi Johannes,

ack, I will post v2 fixing it.

Regards,
Lorenzo

>=20
> johannes
>=20

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXSr8XAAKCRA6cBh0uS2t
rIzqAQDRs/YiVUlxJ3u0Sll8IRGkO3jAb8QSWm6eUochpG2V1wEAwo45pKTKK8rW
OvoQ4oYoEY8OeR/vCM6oVzkf3sukGAE=
=jKf4
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
