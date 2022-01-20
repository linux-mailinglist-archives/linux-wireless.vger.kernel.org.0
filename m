Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33BD494EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359696AbiATNTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 08:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiATNTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 08:19:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4619C061574;
        Thu, 20 Jan 2022 05:19:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741E8616CD;
        Thu, 20 Jan 2022 13:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F91C340E0;
        Thu, 20 Jan 2022 13:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684740;
        bh=svWuVG30BEbWofm+H5ZH2UveapXX1u96Z7k+t8gonX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/cqcdMCrpDBKsk9PhsEB2TjyNuMsFnmxVWqSKRpMbzgqSjojN1QMih90Bnkwi6Ll
         IcRv7autdVnJLFFLSHWJBlcbqGXGVPBNQdePo3ozjszq8MyEaHou96DLa/xV3DJn44
         IYRDVvf3D6H9WFJ3Co2fKjBTS3DV2YqKomp8+Qiav2gC8u3orAy/B/2Lfg4d2bb5G7
         Om4DqwwRjrZ2SpRrryNaNm1z7HolnR/nzYf6r0XIz3VLXjcyx8PsrCk0+V/bEBYstf
         s+6Iami6AQqAYGEOzSM7LWcck5ZCKp+LFs9s6Gx1NszGfI2nas6bz0NpmDM7uJ4Y4z
         CK84V/ys+KzIg==
Date:   Thu, 20 Jan 2022 14:18:56 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings:net:wireless:mediatek,mt76: add
 disable-radar-offchan
Message-ID: <YelhQGs6MW3W13Ni@lore-desk>
References: <cover.1642009736.git.lorenzo@kernel.org>
 <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
 <87v8yeimqz.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNMthz8N4ZRQ07eP"
Content-Disposition: inline
In-Reply-To: <87v8yeimqz.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tNMthz8N4ZRQ07eP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Add the capability to disable/enable radar/CAC detection running on
> > a dedicated offchannel chain available on some hw.
> > Offchannel radar/CAC detection allows to avoid CAC downtime switching
> > on a different channel during CAC detection on the selected radar
> > channel.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/wireless/mediatek,mt76.yaml  | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>=20
> Was the recommendation so that devicetree binding patches should be
> first in the patchset?

ah, ok..I was not aware of it :)

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--tNMthz8N4ZRQ07eP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYelhQAAKCRA6cBh0uS2t
rE+HAPY8PMr1c2yiGJQ/bAYsMCLVRL2b/BOTqN/J3UfAi34xAQC8Ht+EVzQopKZ3
RZHgYXhJfCVQdqxoGlTS2MCMaTFxCA==
=wh+F
-----END PGP SIGNATURE-----

--tNMthz8N4ZRQ07eP--
