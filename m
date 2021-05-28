Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54CF39415F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhE1KxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 06:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236661AbhE1KxK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 06:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAC9D611C9;
        Fri, 28 May 2021 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622199096;
        bh=U7nAhSet6qmUJ2H84uWnzuqsqcrl05T/3pRlfiTFo/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMTqSdUui7OUaBe5AZAgCnl8dVxD1ahwrzz/PmIOWzPibvo2WpgNMlH5OiEIVd9jI
         fPm6ue4eMXQ5rq4G2mfyU0EslQI4LVJF+cZNBtYRQshSdeESwI5JomyPQTtZNmXD/x
         CyOsz1NcsKxrXmBdsyxgN5lagGOJhUaInq0UhbHnWxee67T/CcirctfgYJE/o7jeHb
         z1iPls2uDvWHVtCI7ZxMUbphBfv/PV0mAqVFSSBbTxP+8KnDk0B/jKT0c6s0aWjbdo
         9eGLMPbtjgoP7phqpcMDC9PXhk0NwMzdKDbaoriT/DgeC6oyyMsRYg3gnYy5EajiGU
         eO7loWQgN7Biw==
Date:   Fri, 28 May 2021 12:51:31 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: move interface_modes configuration in hw specific
 code
Message-ID: <YLDLM2Pxw1USmtr6@lore-desk>
References: <2b1f297ab8fd61241d86ff18f9c1ca634289c3f2.1621582373.git.lorenzo@kernel.org>
 <a3039b37-e41f-dc13-c719-2958324bc98d@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tkmHrt39L5LnDZ9w"
Content-Disposition: inline
In-Reply-To: <a3039b37-e41f-dc13-c719-2958324bc98d@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tkmHrt39L5LnDZ9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 2021-05-21 09:35, Lorenzo Bianconi wrote:
> > Move wiphy interface_modes configuration in hw specific code since some
> > drivers (e.g. mt7921) do not support all operating modes (mt7921 suppor=
ts
> > sta only in the current codebase)
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I'd prefer moving it to mt76_alloc_device and mt76_alloc_phy, which
> allows the driver to override it.
>=20
> - Felix

ack, I will fix it in v2.

Regards,
Lorenzo

--tkmHrt39L5LnDZ9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLDLLQAKCRA6cBh0uS2t
rJJXAQD2uEktDfMzdBGgUqV5noMPvcmJuYXgQ9bgWhW+iWd/BQD/ZVMK2Sii68dk
xSG6o6E7JuJgW85rL2KfmRFVS6cTHgs=
=NR/N
-----END PGP SIGNATURE-----

--tkmHrt39L5LnDZ9w--
