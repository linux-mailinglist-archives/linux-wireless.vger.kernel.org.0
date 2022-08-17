Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAE596A2A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiHQHQv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiHQHQu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 03:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035116B671
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 00:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E18161135
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 07:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2EC433D6;
        Wed, 17 Aug 2022 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660720608;
        bh=FNjxzBJcn3CYV/xVJ51Tq5PY0Ainm8ixx5B3ckFEkwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXrPDL2dBHAPnAYVR1SN3o2dzq+y3gYQVJ+KdoSnqUaArIis40WUQrHsK969NR5Bt
         gPnKaFZxWDH6Uwgx1DrG2TbkyS32mUwtVtnbY354EhO1H1P/s7q+8A5TjcaUnsLlea
         nR3C8BzWOFbDt+gLOY1CnovXkyI32IDuRpHTEJ1OnbY8wy8Xkd15k7gOPIfR+NPfnC
         R4Oo3RG0Gal3U7XCwqpiJsOq2cjMPkMorSroOQ1iEOqauFhMDYNVVoMUxDzKZzpMqM
         x8q2B4wx4drI9ljLC1JckGpPC4neFTh8Ww9oYGFUkYdanIJUBi4C/DfXDIVfKn5+zQ
         o3N14qhbMcJAg==
Date:   Wed, 17 Aug 2022 09:16:44 +0200
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
Subject: Re: [PATCH 6/9] wifi: mt76: mt7921: drop ieee80211_[start,
 stop]_queues in driver
Message-ID: <YvyV3EBXL1TBQrc0@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <44acac2a0c1ce4a5d554a24227f80c6ccb3af878.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Imdezpl1z2VRY1Ks"
Content-Disposition: inline
In-Reply-To: <44acac2a0c1ce4a5d554a24227f80c6ccb3af878.1660606893.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Imdezpl1z2VRY1Ks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> The firmware would be in charge of braking and continuing the traffic whi=
le
> the channel contexts are switching between different BSS and HW SCAN in t=
he
> background.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 76c8afc00c24..05b625e02265 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -175,15 +175,13 @@ mt7921_mcu_connection_loss_event(struct mt7921_dev =
*dev, struct sk_buff *skb)
>  static void
>  mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
>  {
> -	struct mt76_phy *mphy =3D &dev->mt76.phy;
>  	struct mt76_connac_mcu_bss_event *event;
> =20
>  	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
>  	event =3D (struct mt76_connac_mcu_bss_event *)skb->data;
> -	if (event->is_absent)
> -		ieee80211_stop_queues(mphy->hw);
> -	else
> -		ieee80211_wake_queues(mphy->hw);
> +
> +	dev_dbg(dev->mt76.dev, "BSS %d is %s\n", event->bss_idx,
> +		event->is_absent ? "Absent" : "Present");

do we really need this? I guess we can just drop mt7921_mcu_bss_event entir=
ely

Regards,
Lorenzo

>  }
> =20
>  static void
> --=20
> 2.25.1
>=20

--Imdezpl1z2VRY1Ks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvyV3AAKCRA6cBh0uS2t
rGbiAQCVTRg181gZRU2USMzy+MXhf31XRsa71hVB/N+lh8KdtwEA7qJyl2AFwuFP
PDEEZWrFjg269Fez6epcJ5Ih/WhlOwc=
=nXU9
-----END PGP SIGNATURE-----

--Imdezpl1z2VRY1Ks--
