Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64363DBAC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiK3RNf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 12:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiK3RND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 12:13:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332908B18E
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 09:09:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC6FCB81C37
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 17:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08056C433D7;
        Wed, 30 Nov 2022 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669828173;
        bh=egobHfAE82ERuhdrxaZwV1hKFHc2d2ZHkUMGyEs1SHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhMphUQUpRIjtXcmvOl5pDwhSRhlkxjIRqFcCVq1eyQ599mqwohh2HAfeR9OMJ6Dp
         QXmWZcCZBm/Fy2PjE4iX3Mp0Lz4eTAcFi0u8J9Zfv+jFSiheb8238fvku+5JAmoFjo
         lVEkqP7vZ+ztftxEV8lxq16qgSCRVriZlB/p0B68xlfcI8/fXlamgcM7Q7nQUy51Oy
         m+sIsPC0YFKwzYFlofn3qnDnyFe/a0HviIJqrwACEwMPbKaFRIoTTum3PQ66LF6sfd
         sqhnCcynPhzMCwUdNKOW7Gq+sCvyCQ1HNq6KMBKo54R8+haFMBKoOmz/OjvFKFRyL9
         OQ90QJSDDoIHA==
Date:   Wed, 30 Nov 2022 18:09:29 +0100
From:   "lorenzo@kernel.org" <lorenzo@kernel.org>
To:     Deren Wu =?utf-8?B?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Cc:     Evelyn Tsai =?utf-8?B?KOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Leon Yen =?utf-8?B?KOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        Stella Chang =?utf-8?B?KOW8teabieS9qSk=?= 
        <Stella.Chang@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        KM Lin =?utf-8?B?KOael+aYhuawkSk=?= <km.lin@mediatek.com>,
        Soul Huang =?utf-8?B?KOm7g+iHs+aYtik=?= 
        <Soul.Huang@mediatek.com>,
        YN Chen =?utf-8?B?KOmZs+W9peWvpyk=?= <YN.Chen@mediatek.com>,
        Posh Sun =?utf-8?B?KOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        Eric-SY Chang =?utf-8?B?KOW8teabuOa6kCk=?= 
        <Eric-SY.Chang@mediatek.com>,
        CH Yeh =?utf-8?B?KOiRieW/l+ixqik=?= <ch.yeh@mediatek.com>,
        Robin Chiu =?utf-8?B?KOmCseWci+a/sSk=?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mt76: mt7921s: fix slab-out-of-bounds access in
 sdio host
Message-ID: <Y4eOSUzLAW8x802i@lore-desk>
References: <631e6a06fb640ec4f81c92b57d31eb0f7b23c351.1669814212.git.deren.wu@mediatek.com>
 <Y4dsznJ+GBalfzvx@lore-desk>
 <5b41c02ace6538122ebd656db5bec748fcd6e14e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IsI5c3S3RXYk6V18"
Content-Disposition: inline
In-Reply-To: <5b41c02ace6538122ebd656db5bec748fcd6e14e.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--IsI5c3S3RXYk6V18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lore,
>=20
> On Wed, 2022-11-30 at 15:46 +0100, Lorenzo Bianconi wrote:
> > > SDIO may need addtional 512 bytes to align bus operation. If the
> > > tailroom
> > > of this skb is not big enough, we would access invalid memory
> > > region.
> > > For low level operation, take xmit_buf instead of skb to keep valid
> > > memory
> > > access in SDIO.
> > > Note: xmit_buf is big enough for single skb size
> > >=20
> > > Fixes: 764dee47e2c1 ("mt76: sdio: move common code in mt76_sdio
> > > module")
> > > Tested-by: YN Chen <YN.Chen@mediatek.com>
> > > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/sdio_txrx.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > > b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > > index bfc4de50a4d2..ebea5c4e8da5 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> > > @@ -254,7 +254,8 @@ static int mt76s_tx_run_queue(struct mt76_dev
> > > *dev, struct mt76_queue *q)
> > > =20
> > >  		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))=20
> > > {
> > >  			__skb_put_zero(e->skb, 4);
> > > -			err =3D __mt76s_xmit_queue(dev, e->skb->data,
> > > +			memcpy(sdio->xmit_buf, e->skb->data, e->skb-
> > > >len);
> >=20
> > (even if it is not critical for performance) iirc the skb from the
> > mcu is
> > always linear, I guess we can use __skb_grow() instead. What do you
> > think?
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> _skb_grow() looks good for me. It's a balance solution for this case.
> If you have no concern about the patch below, I will post v2 after UT.
> :)
>=20
>         if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
>                 __skb_put_zero(e->skb, 4);
> +               err =3D __skb_grow(e->skb, roundup(e->skb->len,
> +                                                sdio->func-
> >cur_blksize));

can we merge __skb_put_zero() and __skb_grow()? Does sdio chip require the 4
last bytes to be 0?

Regards,
Lorenzo

> +               if (err)
> +                       return err;
>                 err =3D __mt76s_xmit_queue(dev, e->skb->data,
>                                                  e->skb->len);
>=20
>=20
> Regards,
> Deren
>=20
> > > +			err =3D __mt76s_xmit_queue(dev, sdio->xmit_buf,
> > >  						 e->skb->len);
> > >  			if (err)
> > >  				return err;
> > > --=20
> > > 2.18.0
> > >=20

--IsI5c3S3RXYk6V18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY4eOSQAKCRA6cBh0uS2t
rIE7AQDEqCVfDhShTRqXBb5ZtxyFKVj/QHV60c8Gz7LUNX07SAEA15WjsxxuSzBQ
utdndpZ+ufqI77vcexMCLwUaQ03cbQY=
=4eey
-----END PGP SIGNATURE-----

--IsI5c3S3RXYk6V18--
