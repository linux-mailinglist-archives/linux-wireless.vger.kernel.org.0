Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BF589924
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiHDIQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiHDIQp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 04:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C661D59
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 01:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DB6AB824A7
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 08:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA01BC433D6;
        Thu,  4 Aug 2022 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659600996;
        bh=TgAmjiVkTrdSm/6pnCy/kBDPBm8BpNosKqAmgj2xAkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izHp11RiDUxVAvYxKVVfQxEUN6795gsrZDGyRUVQJ2/UI3u2Zp0nQqalkKCjoUkfn
         Ww3QHNifuyPVF/fz9uOuu20jYHfjtVQopNwjliju5SpGWMe6Pc6+AUSpCgmcWLVSxR
         zn0FEwSFJS97LlNC1+w5f9Pb5V0Wb2o9mRaJk78X8Ln9opBRmdAmuKrZzT4Z3VzMAm
         pQ5//lS9Hl0lHLFB67iUFhfUOmcQjvK21Pvza5QrUYfIxOxH2GNa2pvxD8WgwEtJ55
         eA0IzJLqxQlSFos+dnG2E1LlpgK6fx0zSi1650lP6QaqQQwjLD6eyNMCKDC/cCnrOc
         VtaMIqAymFP0Q==
Date:   Thu, 4 Aug 2022 10:16:31 +0200
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
Subject: Re: [PATCH] mt76: mt7921: apply the previous MCU timeout
Message-ID: <YuuAX3aa/bmL5ZdM@localhost.localdomain>
References: <b0dfe8afc5cf88ab9a6d54c88fba4a29631c125a.1659571732.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t1gystbou+6iIMQK"
Content-Disposition: inline
In-Reply-To: <b0dfe8afc5cf88ab9a6d54c88fba4a29631c125a.1659571732.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--t1gystbou+6iIMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Apply back the previous MCU timeout that can trigger the chip reset to
> recover the fatal error in time.
>=20
> Fixes: 8fcd1fb7cbd5 ("mt76: move mt76_connac2_mcu_fill_message in
>  mt76_connac module")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>  b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 0afcadce87fc..da8223c515eb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -3050,7 +3050,10 @@ int mt76_connac2_mcu_fill_message(struct mt76_dev
>  *dev, struct sk_buff *skb,
>  	u8 seq;
> =20
>  	/* TODO: make dynamic based on msg type */
> -	dev->mcu.timeout =3D 20 * HZ;
> +	if (is_mt7921(dev))
> +		dev->mcu.timeout =3D 3 * HZ;
> +	else
> +		dev->mcu.timeout =3D 20 * HZ;

Hi Sean,

I did not get the fix here since we are setting dev->mcu.timeout in
mt76_connac2_mcu_fill_message caller (e.g. mt7921s_mcu_send_message).
Am I missing something?

Regards,
Lorenzo

> =20
>  	seq =3D ++dev->mcu.msg_seq & 0xf;
>  	if (!seq)
> --=20
> 2.25.1
>=20

--t1gystbou+6iIMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYuuAXAAKCRA6cBh0uS2t
rGTHAP9ExebmolMqnxYqbtRdAAq10uHV8hUpGFllKQ066SKV7AD/aMllw/3B1LV5
D8K3fkvd/co6o2v+ZmTf/MmY3NymZAE=
=RqkO
-----END PGP SIGNATURE-----

--t1gystbou+6iIMQK--
