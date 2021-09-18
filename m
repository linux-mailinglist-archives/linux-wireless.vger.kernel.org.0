Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100314105E9
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhIRKQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Sep 2021 06:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233233AbhIRKQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Sep 2021 06:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631960111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/7EmwLFFDQP/KzrTW8Ir1otVMUhMlWVF+7ZHoCcdtQ=;
        b=Kilshjg/Cz6ET7vHMA0VpafT7gIlEoX3WLT2SfTvhGQQkbD/1ITpyrPwOF1pel+R6X/h8A
        q9Q5/F3WNo+g1hwhhmi0R8plr1cHY2jTYhWbAEuKKoCubzgVsgJjvXZaJBA5rXLdBXeMvR
        slM+lwCR8VMcWFKL3qrmKmWdYLqkfQE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-yNpg0uoDMqyO0q8dQnowIg-1; Sat, 18 Sep 2021 06:15:09 -0400
X-MC-Unique: yNpg0uoDMqyO0q8dQnowIg-1
Received: by mail-ed1-f69.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso11465508edp.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Sep 2021 03:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/7EmwLFFDQP/KzrTW8Ir1otVMUhMlWVF+7ZHoCcdtQ=;
        b=MM5qDxO6TdkQ36y/b6I9P+X6WV6KAjAEUqP+t8IJ9hhO/ZFSViN9YupV25SpWQT+9T
         KpgxyrG0n/sqwSPA2kdF0me6u7J7SRG5dynfmmA0Dw24UfyGqEt/LEKW7z0H5f0XQuBx
         VELEClh2p+/nlWgaO3weT2Sj7b3EFmnUNFDh9Na/8k4ieGYVyCd88BlRYGEW7tywj0yP
         r6vTIJOJHzU5HDRHreL6ftihNUxnC+qn29rTOaSePweL3FxbvI3Zuyesoqb+575PpmEo
         soOqeM5MEvxzk4aT/yNkDKhbs7ssB9YeqOolTFaqy1dq++GV9Czy9xg0gkjivkvkFmeV
         qZtw==
X-Gm-Message-State: AOAM533VdG39hgUOSkbeIV33ffu7N2r2R2jjtubDFM18A9CC6CDJmDVg
        eneZEGWKgt2ZYQgSVuMs6HuUm/S24qFr8gZ8IGy46csLM2AFWsUGm/uQodPm7D1O6cXnyrwhYak
        RmLqqVGQikkcT/VHKCfscK1fLjyw=
X-Received: by 2002:a17:906:1f49:: with SMTP id d9mr18011184ejk.150.1631960108328;
        Sat, 18 Sep 2021 03:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/8lI6Vy9wCLjIieh2EG36R/DLCixISYQ/RXFzHWu3L2yJ9ELZcaUS1Q5KoPy0Qy0gCUhpXA==
X-Received: by 2002:a17:906:1f49:: with SMTP id d9mr18011156ejk.150.1631960108096;
        Sat, 18 Sep 2021 03:15:08 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id g21sm3440295ejs.53.2021.09.18.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 03:15:07 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:15:04 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 06/16] mt76: connac: move mcu reg access utility
 routines in mt76_connac_lib module
Message-ID: <YUW8KBTC7t3PHJwF@lore-desk>
References: <cover.1631918993.git.objelf@gmail.com>
 <42112d6b7b1c09bcdfa37d4417e55ef45c09ceff.1631918993.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjmTM+NR3uzpPGj1"
Content-Disposition: inline
In-Reply-To: <42112d6b7b1c09bcdfa37d4417e55ef45c09ceff.1631918993.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tjmTM+NR3uzpPGj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Move mcu reg access shared between mt7663s and mt7921s in mt76_connac_lib
> module.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 27 +++++++++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index ae692052de97..a53f6344a184 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2406,6 +2406,33 @@ void mt76_connac_mcu_set_suspend_iter(void *priv, =
u8 *mac,
>  }
>  EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_iter);
> =20
> +u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
> +{
> +	struct {
> +		__le32 addr;
> +		__le32 val;
> +	} __packed req =3D {
> +		.addr =3D cpu_to_le32(offset),
> +	};
> +
> +	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
> +				 true);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_rr);

It seems quite a common code, does it worth to move them in mcu.c? (mt76 mo=
dule)

Regards,
Lorenzo

> +
> +void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
> +{
> +	struct {
> +		__le32 addr;
> +		__le32 val;
> +	} __packed req =3D {
> +		.addr =3D cpu_to_le32(offset),
> +		.val =3D cpu_to_le32(val),
> +	};
> +
> +	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
>  #endif /* CONFIG_PM */
> =20
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index ea46dde364e1..6c410c4a8d6e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1111,4 +1111,6 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev=
 *dev, struct sk_buff *skb,
>  int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
>  int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
>  				  struct ieee80211_vif *vif);
> +u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
> +void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
>  #endif /* __MT76_CONNAC_MCU_H */
> --=20
> 2.25.1
>=20

--tjmTM+NR3uzpPGj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUW8JgAKCRA6cBh0uS2t
rJmOAP4xMokaGnfDzC2YzQvKQtrtKFOOFICvPWlGDeQ3K5WovAD/WdXEiTcKyGhR
hhW3fjRW1DWZUXK3Psyij8xtd+ov4Ak=
=mDxl
-----END PGP SIGNATURE-----

--tjmTM+NR3uzpPGj1--

