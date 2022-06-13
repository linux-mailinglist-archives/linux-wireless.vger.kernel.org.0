Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32FF54833C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiFMJcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiFMJcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:32:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F418E18
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 706DDB80D74
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 09:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EABC341C4;
        Mon, 13 Jun 2022 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655112723;
        bh=SddoYtToYnd60vSjGq+xaMPEhrFsty5ft9T+UA0njtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSqHDkRMztXJ1K9i7c9jfF/kjwwUcOLm/+pUCvqqtDW/5yMzZPamcEsKmwE3vy34e
         yQRGS+aqwqP+iUI81Yft/cULbLm9rEx+gX+RvpV+UEWcZ08Vt8Dj0vib8zTItDC6FV
         z5//94arY5H6nVQF8CUpP4LUqyGKNaLJzYe3ShwruNldf58AJTOh+62cmWiY9ymj/F
         o+G3KAnEm0wox/FGUFfjKv8W42sU3LH24qpnQs4KlPa5WEXx50VwYHbQzMwu2QjVCp
         e/QZY4CPxu+hvWdtGlQqN7Tlq6xh9uRLAz0Q1BiYhmbYs8m9jefSxhk3MBWUYSzcHx
         o6IqoEL+4FXBw==
Date:   Mon, 13 Jun 2022 11:31:59 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921s: fix possible sdio deadlock in command fail
Message-ID: <YqcED2AWOP+mFPQV@lore-desk>
References: <7122534ce50527e099a23fa198683a0e20c6db38.1654998031.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A5J39+V/GstiCcPe"
Content-Disposition: inline
In-Reply-To: <7122534ce50527e099a23fa198683a0e20c6db38.1654998031.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--A5J39+V/GstiCcPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Move sdio_release_host() to final resource handing
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Fixes: b12deb5e86fa ("mt76: mt7921s: fix mt7921s_mcu_[fw|drv]_pmctrl")
> Reported-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> index 54a5c712a3c3..1856d677fff4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> @@ -156,9 +156,9 @@ int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
> =20
>  	err =3D readx_poll_timeout(mt76s_read_pcr, &dev->mt76, status,
>  				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
> +err:
>  	sdio_release_host(func);
> =20
> -err:
>  	if (err < 0) {
>  		dev_err(dev->mt76.dev, "firmware own failed\n");
>  		clear_bit(MT76_STATE_PM, &mphy->state);
> --=20
> 2.18.0
>=20

--A5J39+V/GstiCcPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYqcEDwAKCRA6cBh0uS2t
rKi5AP9bBre9sLH9PTh+EH3Jr/qpaTrLs7r4oOzOHR1pYRujYwEA110zit1P/R1p
V2NpPVVAmKVq5M9jc72S1elD2wL+hws=
=1cka
-----END PGP SIGNATURE-----

--A5J39+V/GstiCcPe--
