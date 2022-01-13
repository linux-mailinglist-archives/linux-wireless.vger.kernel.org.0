Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76EC48D59F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 11:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiAMKTL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiAMKTK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 05:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969EDC061748
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 02:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3448761BE3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 10:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC7EC36AE3;
        Thu, 13 Jan 2022 10:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642069149;
        bh=11HpoOh79JImMu5a+CtI+2j1zpNTutiJy7Ap/Qb5gg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p29KM/aLH7N+JAphxB1qVFmPiDXN8RjhOy1d39xx4d5oKjblr5GzGtRhjoxrMWzBU
         /UuSs5tuG/05fkdEUi5ChDqtIo/QJoxMch50XxeK4pRyaINS7LSBDLNxVo96OX0svx
         TYdZaaMyyWVq/ofRXOfWDLvW8EcrKRISSnE6LftbDoGJgDjuCRgQPSoPxoQSIXPE1b
         8SwDVm1CgCuiCxKEM9zb9rX8eP+aZgdKI06yL4l2C87nO5yVZpmCMHo27V6UBKvHvB
         CQDp4KSEyN1acGiEzaf9W4XmPz7wHRmHHRyt+143KVNm7YkX77Z2GfdJyEmPWm1XAa
         4VZ7Yk2tTmQiw==
Date:   Thu, 13 Jan 2022 11:19:05 +0100
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
Message-ID: <Yd/8mXumr25iESux@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
 <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
 <Yd7ZKb7Qsh4lGA5E@lore-desk>
 <2ab2731dc44494dbfe89363638cdcaf49351afbe.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvfcff8cOfewXKH7"
Content-Disposition: inline
In-Reply-To: <2ab2731dc44494dbfe89363638cdcaf49351afbe.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cvfcff8cOfewXKH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 2022-01-12 at 14:35 +0100, Lorenzo Bianconi wrote:
> > >=20
> > > @@ -302,6 +316,15 @@ struct mt7915_dev {
> > >  		u8 table_mask;
> > >  		u8 n_agrt;
> > >  	} twt;
> > > +
> > > +	struct reset_control *rstc;
> > > +	void __iomem *dcm;
> > > +	void __iomem *sku;
> > > +
> > > +	struct {
> > > +		bool is_7975;
> > > +		bool is_7976;
> > > +	} adie[MT7986_MAX_ADIE_NUM];
> >=20
> > do we really need it? Can we just read data from chip when necessary?
> > it is not
> > access in the hot-path, right?
> > I think it is easier and more readable.
>=20
> Adie registers are inaccessible after wfsys power on so we need some
> places to store chip configuration.
> We will modify it to make it more readable.
> + u32 adie;

what I mean is just continue reading these values after the first time (tha=
t is
in common for both approaches).

Regards,
Lorenzo

>=20
> thanks,
> Peter
>=20

--cvfcff8cOfewXKH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd/8mQAKCRA6cBh0uS2t
rGVEAQCHrAHThMVJZHLoWahbCNC98g2po/d7grDNMgd+uxWRPgD9Ec6DtqPdJcYF
DXkzu4YqSEGJ6gSqxKP0Yf9A1u7q6w0=
=ALze
-----END PGP SIGNATURE-----

--cvfcff8cOfewXKH7--
