Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B927F65EA98
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 13:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjAEMVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 07:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjAEMU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 07:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2E7CFC
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 04:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F1C619BA
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 12:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA8FC433EF;
        Thu,  5 Jan 2023 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672921257;
        bh=juxFBCgvEME4z/TbdrM7n4SUdXzlYdWndiMH3p2yjwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOF4rvPzqICje2OAHhjX0BWdZCWMbvwykVOsHzs+FkENgUR5gjAQWAOalr8LP5dmI
         6cPi0maWpuxIthwRwTqzrFnaJztN3/9ac5uAyYqUmROijWCIbjwPGZzToSTiX/tyUi
         nyxzaAX5UkaGPlCNVLdSuh7z/nd46fEIhsPPXnB29KWlNRcug0kKBWuCI93gl+EZNP
         34nnLezX9AeKyx5YjZPkuJXzC8OyCJj1ihPjw3wiqREbLa2sypjppYZBGZaZb5qdLV
         nEueDRHzrz52VPmoMbvZLc0USoeXpyoCoZmc0Z3rMJDi2icqzDTZTULVriAbjFQ281
         4lYaL+jcHbkjw==
Date:   Thu, 5 Jan 2023 13:20:53 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] wifi: mt76: mt7915: wed: enable red per-band token
 drop
Message-ID: <Y7bApSqBT2LXdBhu@lore-desk>
References: <20230105114711.31430-1-chui-hao.chiu@mediatek.com>
 <20230105114711.31430-2-chui-hao.chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmQD/Wz6P1yDMR6h"
Content-Disposition: inline
In-Reply-To: <20230105114711.31430-2-chui-hao.chiu@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--nmQD/Wz6P1yDMR6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Enable RED to limit the number of token used by each band. If single band
> uses too many tokens, it would hurt the throughput of the other bands.The
> software path can solve this problem by AQL so enable RED for HW path onl=
y.
>=20
> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 54 ++++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>  3 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index f1e942b9a887..855a434ecf54 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1171,6 +1171,7 @@ enum {
>  	MCU_EXT_CMD_GET_MIB_INFO =3D 0x5a,
>  	MCU_EXT_CMD_TXDPD_CAL =3D 0x60,
>  	MCU_EXT_CMD_CAL_CACHE =3D 0x67,
> +	MCU_EXT_CMD_RED_ENABLE =3D 0x68,
>  	MCU_EXT_CMD_SET_RADAR_TH =3D 0x7c,
>  	MCU_EXT_CMD_SET_RDD_PATTERN =3D 0x7d,
>  	MCU_EXT_CMD_MWDS_SUPPORT =3D 0x80,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 37a3c1f082d9..a7bc2043a0db 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2291,6 +2291,57 @@ mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
>  				 sizeof(req), true);
>  }
> =20
> +static int mt7915_red_set_watermark(struct mt7915_dev *dev)
> +{
> +#define RED_GLOBAL_TOKEN_WATERMARK 2
> +	u16 nbuf =3D dev->mt76.mmio.wed.wlan.nbuf;

I do not think this patch compile if CONFIG_NET_MEDIATEK_SOC_WED is not ena=
bled

> +	struct {
> +		__le32 args[3];

please remove blank lines.

> +
> +		u8 cmd;
> +		u8 version;
> +		u8 __rsv1[4];
> +		u16 len;

I guess it should be __le16 here

> +
> +		__le16 high_mark;
> +		__le16 low_mark;
> +		u8 __rsv2[12];
> +	} __packed req =3D {
> +		.args[0] =3D cpu_to_le32(MCU_WA_PARAM_RED_SETTING),
> +		.cmd =3D RED_GLOBAL_TOKEN_WATERMARK,
> +		.len =3D cpu_to_le16(sizeof(req) - sizeof(req.args)),
> +
> +		.high_mark =3D cpu_to_le16(nbuf - 256),
> +		.low_mark =3D cpu_to_le16(nbuf - 256 - 1536),
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_PARAM_CMD(SET), &req,
> +				 sizeof(req), false);
> +}
> +
> +int mt7915_mcu_set_red(struct mt7915_dev *dev, bool enabled)
> +{
> +#define RED_DISABLE		0
> +#define RED_BY_WA_ENABLE	2
> +	int ret;
> +	u32 red_type =3D enabled ? RED_BY_WA_ENABLE : RED_DISABLE;
> +	__le32 req =3D cpu_to_le32(red_type);
> +
> +	if (enabled) {
> +		ret =3D mt7915_red_set_watermark(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RED_ENABLE), &req,
> +				sizeof(req), false);
> +	if (ret < 0)
> +		return ret;
> +
> +	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
> +				 MCU_WA_PARAM_RED, enabled, 0);
> +}
> +
>  int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
>  {
>  	int ret;
> @@ -2339,8 +2390,7 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
>  	if (ret)
>  		return ret;
> =20
> -	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
> -				 MCU_WA_PARAM_RED, 0, 0);
> +	return mt7915_mcu_set_red(dev, mtk_wed_device_active(&dev->mt76.mmio.we=
d));
>  }
> =20
>  int mt7915_mcu_init(struct mt7915_dev *dev)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.h
> index 29b5434bfdb8..b9ea297f382c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -278,6 +278,7 @@ enum {
>  	MCU_WA_PARAM_PDMA_RX =3D 0x04,
>  	MCU_WA_PARAM_CPU_UTIL =3D 0x0b,
>  	MCU_WA_PARAM_RED =3D 0x0e,
> +	MCU_WA_PARAM_RED_SETTING =3D 0x40,
>  };
> =20
>  enum mcu_mmps_mode {
> --=20
> 2.18.0
>=20

--nmQD/Wz6P1yDMR6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY7bApQAKCRA6cBh0uS2t
rAsvAP9mZKXqpp2epDkFm0bNBgQ7LTYmBaNqGJqwj5MS8FGkmAEAgZg22ZD7PjAh
MWyhtpouBJ86QGz4io2W9CGV0gtuzAw=
=S45w
-----END PGP SIGNATURE-----

--nmQD/Wz6P1yDMR6h--
