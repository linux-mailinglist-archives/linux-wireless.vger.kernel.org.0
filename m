Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB73D578D59
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiGRWMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRWMb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 18:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0031376
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 15:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A23B8124B
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 22:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFFDC341C0;
        Mon, 18 Jul 2022 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658182347;
        bh=xuEBZAMFlkeQ8csFA8rfMNdciRkANyRKQIQb5OMD2Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVE584MiBk4opyD8B3ila+raoI7hvHfL4nItCc4ZqkDGSp/wB+ofxbkwx6j4uptrK
         NWSxG9pP6AgDh+8qnkmE13nrQhmcghQeXJeHTQt4tVf5jVVCA9MjL5j/nTKPyjJDLl
         1cIr9ajUqKH10K0qVzBReYY2buRJX1/xps3XlD56fcHrdLyOmXhbYvWgOs7iyaGCPO
         2kb4Zlel+QzVqFWScH9ikalvbtCdgJJten/SfPKXMz/dt2j0Ur/6HlqzAJ4f4ffrhj
         r9KOG3gm3kBRh36I0MQpZZLZPuRRpMRTzTcuVfRozXyedfUaLgApGlZRMjUF2AIlBa
         0TtIP/kK+r1qg==
Date:   Tue, 19 Jul 2022 00:12:24 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/4] mt76: mt7921u: remove unnecessary MT76_STATE_SUSPEND
Message-ID: <YtXayNzRHEQ2ut2l@lore-desk>
References: <a1437e413116364ac9f3b777c7922ca0728ddc0d.1658176701.git.sean.wang@kernel.org>
 <2938c18e2a14e26de293adcf68cd851ca0a7474a.1658176701.git.sean.wang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MetnIjz+5ZCpraq0"
Content-Disposition: inline
In-Reply-To: <2938c18e2a14e26de293adcf68cd851ca0a7474a.1658176701.git.sean.wang@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MetnIjz+5ZCpraq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> remove unnecessary MT76_STATE_SUSPEND manipulation to be consistent
> with the mt7921[e, s] driver.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/usb.c
> index 124d62c0dfa4..a8ea03d4f990 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> @@ -313,8 +313,6 @@ static int mt7921u_suspend(struct usb_interface *intf=
, pm_message_t state)
>  	mt76u_stop_rx(&dev->mt76);
>  	mt76u_stop_tx(&dev->mt76);
> =20
> -	set_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
> -
>  	return 0;
> =20
>  failed:
> @@ -354,8 +352,6 @@ static int mt7921u_resume(struct usb_interface *intf)
>  			goto failed;
>  	}
> =20
> -	clear_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
> -
>  	err =3D mt76u_resume_rx(&dev->mt76);
>  	if (err < 0)
>  		goto failed;
> --=20
> 2.25.1
>=20

--MetnIjz+5ZCpraq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYtXayAAKCRA6cBh0uS2t
rBb9AQCLIcE0D+bIK36JveSLI9KH5D89zJ9ktnGQHzlWY7WWvwEAvnNqDBIKVlIU
NKfbokH7KQK55UAEAMMV0LK7XKddjwQ=
=X1MV
-----END PGP SIGNATURE-----

--MetnIjz+5ZCpraq0--
