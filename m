Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C448D957
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 14:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiAMNzt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 08:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiAMNzs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 08:55:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D747C06173F
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 05:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A67A61CDE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1CBC36AE3;
        Thu, 13 Jan 2022 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642082147;
        bh=0yi7miC80eJvdinhs4soCLQBE+jBvBlyWx4ILlEeeWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKR7zTs1UbVjV6WgKd8Pdgo1Gaxb8V6w+tZTFqHaSXQGZeYBwBnDtdREShXrd6+1J
         qryYtFba27ZDpbTdjqdUZD083OhCfDDqHe1HsXt9v/c+IsDbH+y4sUJDINmyO1v/CM
         +TXYRQrHahmrwVUS5IVxVV1C0DOh9LP6S5MkTG2bh6Pm9qbeECJ38zRYhqFBvtyx1H
         tiQvrQI0Lrpfla/nqSwZUqFIFkHUMozyF0+34j/BeCkkN2Y62FRx9fZj8LJYwOngyE
         +0aHAtWItLffWjoFXNqPGpzpEb3F9xvDDfj7RrK3D5+lzYUUHDC65C6ftRfmzQ8G6O
         la4xCymo5Dndg==
Date:   Thu, 13 Jan 2022 14:55:43 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <bo.jiao@mediatek.com>
Subject: Re: [PATCH v2 3/5] mt76: mt7915: add support for MT7986
Message-ID: <YeAvXzG6ueZWxoGa@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
 <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
 <Yd7ZKb7Qsh4lGA5E@lore-desk>
 <2ab2731dc44494dbfe89363638cdcaf49351afbe.camel@mediatek.com>
 <Yd/8mXumr25iESux@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="deosE2qSAUpl8QTU"
Content-Disposition: inline
In-Reply-To: <Yd/8mXumr25iESux@lore-desk>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--deosE2qSAUpl8QTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Wed, 2022-01-12 at 14:35 +0100, Lorenzo Bianconi wrote:
> > > >=20
> > > > @@ -302,6 +316,15 @@ struct mt7915_dev {
> > > >  		u8 table_mask;
> > > >  		u8 n_agrt;
> > > >  	} twt;
> > > > +
> > > > +	struct reset_control *rstc;
> > > > +	void __iomem *dcm;
> > > > +	void __iomem *sku;
> > > > +
> > > > +	struct {
> > > > +		bool is_7975;
> > > > +		bool is_7976;
> > > > +	} adie[MT7986_MAX_ADIE_NUM];
> > >=20
> > > do we really need it? Can we just read data from chip when necessary?
> > > it is not
> > > access in the hot-path, right?
> > > I think it is easier and more readable.
> >=20
> > Adie registers are inaccessible after wfsys power on so we need some
> > places to store chip configuration.
> > We will modify it to make it more readable.
> > + u32 adie;
>=20
> what I mean is just continue reading these values after the first time (t=
hat is
> in common for both approaches).

ok, sorry I misread your reply. Anyway it seems to me we need these values =
just
in mt7986_wmac_enable() (or in routines called by mt7986_wmac_enable). Righ=
t?
If so maybe we can just store them in a local struct in mt7986_wmac_enable(=
).
What do you think?

Regards,
Lorenzo

>=20
> Regards,
> Lorenzo
>=20
> >=20
> > thanks,
> > Peter
> >=20



--deosE2qSAUpl8QTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeAvXwAKCRA6cBh0uS2t
rGbtAQDszbOeIxttHkVRqWbN0gIDFX47nidjwe49+fUAMinPyAD/RspZ1yRoxMxk
O7mDViAVXOkX/CzjlfI3W738AK/nYAA=
=4ixS
-----END PGP SIGNATURE-----

--deosE2qSAUpl8QTU--
