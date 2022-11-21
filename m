Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC24632373
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKUN3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 08:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiKUN3a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 08:29:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595DC2BB0F
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 05:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8F386119E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 13:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1BBC433D6;
        Mon, 21 Nov 2022 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669037368;
        bh=cWh1QvLmilyvblGjUu5vKbNUPCx9wjcZJPvwWjTs5mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cv3q9PPoVnDJaHGC+5HVFFoyDi8Wk+8lCN1WAyhsaIsCSI3qqdebbAGgsoe7aPUPD
         /dNIwrM8VH4MKkuVlOPdgmmMbuDaj3B7+RbQGFtkLWfBUgrl05gRM1EGcvh3hS2LmS
         lP6jHcnLNQRB3Ilx5z9WlzRyDwQ68gR9mKE8S0286OLk7nZmtvyDuRGXvmkLYAUTAo
         RnZhIyu9XOIcYUQR70M1lIY1TJrSxYJySf+aq8d1NYEBEtuOEqNSD37vzLifXdpAjt
         1jnJjSBhDolYsArouoLeCh/lsI4zeatQ77b6YdpKYbZ29ueo1IgkZpDskBygnaPTp4
         T7P+DezG4Azog==
Date:   Mon, 21 Nov 2022 14:29:24 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sujuan Chen <sujuan.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7915: add wds support when wed is enabled
Message-ID: <Y3t9NOKseNw2myzE@lore-desk>
References: <af04db938bf9633225c4358058a39aa3be0e218e.1669022945.git.sujuan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4sWz01hsBUi3DRx4"
Content-Disposition: inline
In-Reply-To: <af04db938bf9633225c4358058a39aa3be0e218e.1669022945.git.sujuan.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--4sWz01hsBUi3DRx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The current WED only supports 256 wcid, whereas mt7986 can support up to =
512 entries,
> so firmware provides a rule to get sta_info by DA when wcid is set to 0x3=
ff by txd.
> Also, WED provides a register to overwrite txd wcid, that is, wcid[9:8] c=
an
> be overwritten by 0x3 and wcid[7:0] is set to 0xff by host driver.
>=20
> However, firmware is unable to get sta_info from DA as DA !=3D RA for 4ad=
dr cases,
> so firmware and wifi host driver both use wcid (256 - 271) and (768 ~ 783)
> for sync up to get correct sta_info
>=20
> Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> ---
> This patch is based on=20
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D697444
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++
>  .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
>  .../wireless/mediatek/mt76/mt7615/pci_init.c  |  2 +-
>  .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 24 +++++++++--
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 11 ++++-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 ++
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
>  drivers/net/wireless/mediatek/mt76/util.c     | 42 ++++++++++++++++++-
>  drivers/net/wireless/mediatek/mt76/util.h     |  2 +-
>  17 files changed, 91 insertions(+), 18 deletions(-)
>=20

Hi Sujuan,

I took just a brief look at the patch, but I think you can significantly
reduce the patch size doing something like:

int __mt76_wcid_alloc(u32 *mask, int size, u8 flag)
{
	...
}

static inline int mt76_wcid_alloc(u32 *mask, int size)
{
	return __mt76_wcid_alloc(, 0);
}

> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 33f87e518d68..1763b582c020 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -38,6 +38,12 @@
>  #define MT_WED_Q_RX(_n)		__MT_WED_Q(MT76_WED_Q_RX, _n)
>  #define MT_WED_Q_TXFREE		__MT_WED_Q(MT76_WED_Q_TXFREE, 0)
> =20
> +enum mt76_wed_state {
> +	MT76_WED_DISABLED,
> +	MT76_WED_ACTIVE,
> +	MT76_WED_WDS_ACTIVE,
> +};
> +
>  struct mt76_dev;
>  struct mt76_phy;
>  struct mt76_wcid;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7603/main.c
> index ca50feb0b3a9..d788bb59a113 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
> @@ -347,7 +347,7 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee8021=
1_vif *vif,
>  	int idx;
>  	int ret =3D 0;
> =20
> -	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7603_WTBL_STA - 1);
> +	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7603_WTBL_STA - 1, 0);
>  	if (idx < 0)
>  		return -ENOSPC;
> =20

[...]

>  	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>  }
> =20
> @@ -1448,15 +1462,19 @@ mt7915_net_fill_forward_path(struct ieee80211_hw =
*hw,
>  	if (!mtk_wed_device_active(wed))
>  		return -ENODEV;
> =20
> -	if (msta->wcid.idx > 0xff)
> +	if (msta->wcid.idx > MT7915_WTBL_STA)
>  		return -EIO;
> =20
>  	path->type =3D DEV_PATH_MTK_WDMA;
>  	path->dev =3D ctx->dev;
>  	path->mtk_wdma.wdma_idx =3D wed->wdma_idx;
>  	path->mtk_wdma.bss =3D mvif->mt76.idx;
> -	path->mtk_wdma.wcid =3D is_mt7915(&dev->mt76) ? msta->wcid.idx : 0x3ff;
>  	path->mtk_wdma.queue =3D phy !=3D &dev->phy;
> +	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags) ||
> +	    is_mt7915(&dev->mt76))
> +		path->mtk_wdma.wcid =3D msta->wcid.idx;
> +	else
> +		path->mtk_wdma.wcid =3D 0x3ff;
> =20
>  	ctx->dev =3D NULL;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 2769d6c897d9..aeeeff9b2143 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2303,8 +2303,15 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *de=
v)
>  	if (ret)
>  		return ret;
> =20
> -	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
> -		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
> +	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
> +		if (is_mt7915(&dev->mt76))
> +			mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY),
> +					  0, 0, 0);
> +		else
> +			mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
> +					  MCU_WA_PARAM_WED_VERSION,
> +					  dev->mt76.mmio.wed.rev_id, 0);
> +	}

can you please honor mt7915_mcu_wa_cmd() returned value?

> =20
>  	ret =3D mt7915_mcu_set_mwds(dev, 1);
>  	if (ret)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.h
> index c19b5d66c0e1..59e1ea35f77f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -260,6 +260,7 @@ enum {
>  	MCU_WA_PARAM_PDMA_RX =3D 0x04,
>  	MCU_WA_PARAM_CPU_UTIL =3D 0x0b,
>  	MCU_WA_PARAM_RED =3D 0x0e,
> +	MCU_WA_PARAM_WED_VERSION =3D 0x32,
>  };
> =20
>  enum mcu_mmps_mode {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index 1fcf34f57a16..d90793d082b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -773,6 +773,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void=
 *pdev_ptr,
> =20
>  	dev->mt76.rx_token_size =3D wed->wlan.rx_npkt;
> =20
> +	if (!is_mt7915(&dev->mt76))
> +		wed->wlan.wcid_512 =3D true;
> +
>  	if (mtk_wed_device_attach(wed))
>  		return 0;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 79b8055ce4c4..702ff300f8f7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -283,7 +283,7 @@ static int mt7921_init_wcid(struct mt7921_dev *dev)
>  	int idx;
> =20
>  	/* Beacon and mgmt frames should occupy wcid 0 */
> -	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
> +	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1, 0);
>  	if (idx)
>  		return -ENOSPC;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 41df17efdb3a..3d8771fcb847 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -814,7 +814,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
>  	struct mt7921_vif *mvif =3D (struct mt7921_vif *)vif->drv_priv;
>  	int ret, idx;
> =20
> -	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
> +	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1, 0);
>  	if (idx < 0)
>  		return -ENOSPC;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/init.c
> index cd1657e3585d..4cf055040519 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -433,7 +433,7 @@ static int mt7996_init_hardware(struct mt7996_dev *de=
v)
>  		return ret;
> =20
>  	/* Beacon and mgmt frames should occupy wcid 0 */
> -	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
> +	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA, 0);
>  	if (idx)
>  		return -ENOSPC;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 21dea3fa7dc1..fd40b515cc5b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -579,7 +579,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct =
ieee80211_vif *vif,
>  	u8 band_idx =3D mvif->phy->mt76->band_idx;
>  	int ret, idx;
> =20
> -	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
> +	idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA, 0);
>  	if (idx < 0)
>  		return -ENOSPC;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wire=
less/mediatek/mt76/util.c
> index 581964425468..0850149f4200 100644
> --- a/drivers/net/wireless/mediatek/mt76/util.c
> +++ b/drivers/net/wireless/mediatek/mt76/util.c
> @@ -42,9 +42,14 @@ bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset=
, u32 mask, u32 val,
>  }
>  EXPORT_SYMBOL_GPL(__mt76_poll_msec);
> =20
> -int mt76_wcid_alloc(u32 *mask, int size)
> +int mt76_wcid_alloc(u32 *mask, int size, u8 flag)
>  {
> +#define MT76_WED_WDS_MIN    256
> +#define MT76_WED_WDS_CNT    16
> +
>  	int i, idx =3D 0, cur;
> +	int min =3D MT76_WED_WDS_MIN;
> +	int max =3D min + MT76_WED_WDS_CNT;
> =20
>  	for (i =3D 0; i < DIV_ROUND_UP(size, 32); i++) {
>  		idx =3D ffs(~mask[i]);
> @@ -53,13 +58,46 @@ int mt76_wcid_alloc(u32 *mask, int size)
> =20
>  		idx--;
>  		cur =3D i * 32 + idx;
> -		if (cur >=3D size)

I think it easier to understand the code if you run the code below just if =
wed
is active, right?

		if (!mtk_wed_device_active())
			break;

Regards,
Lorenzo

> +
> +		switch (flag) {
> +		case MT76_WED_DISABLED:
> +			if (cur >=3D size)
> +				goto error;
> +
>  			break;
> +		case MT76_WED_ACTIVE:
> +			if (cur >=3D min && cur < max)
> +				continue;
> +
> +			if (cur >=3D size) {
> +				u32 end =3D MT76_WED_WDS_CNT - 1;
> +
> +				i =3D min / 32;
> +				idx =3D ffs(~mask[i] & GENMASK(end, 0));
> +				if (!idx)
> +					goto error;
> +				idx--;
> +				cur =3D min + idx;
> +			}
> +
> +			break;
> +		case MT76_WED_WDS_ACTIVE:
> +			if (cur < min)
> +				continue;
> +			if (cur >=3D max)
> +				goto error;
> +
> +			break;
> +		default:
> +			WARN_ON(1);
> +			break;
> +		}
> =20
>  		mask[i] |=3D BIT(idx);
>  		return cur;
>  	}
> =20
> +error:
>  	return -1;
>  }
>  EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
> diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wire=
less/mediatek/mt76/util.h
> index 260965dde94c..c72460e78389 100644
> --- a/drivers/net/wireless/mediatek/mt76/util.h
> +++ b/drivers/net/wireless/mediatek/mt76/util.h
> @@ -27,7 +27,7 @@ enum {
>  #define MT76_INCR(_var, _size) \
>  	(_var =3D (((_var) + 1) % (_size)))
> =20
> -int mt76_wcid_alloc(u32 *mask, int size);
> +int mt76_wcid_alloc(u32 *mask, int size, u8 flag);
> =20
>  static inline void
>  mt76_wcid_mask_set(u32 *mask, int idx)
> --=20
> 2.18.0
>=20

--4sWz01hsBUi3DRx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY3t9NAAKCRA6cBh0uS2t
rObQAPwNYRulKepgTU0B1qNYRE0uPT7orCR1j0BS5qfXYq1aMQEAsUei85AOMXQH
92KdqpB5sup52VlmwqLEQasYiVKwiQY=
=1iw/
-----END PGP SIGNATURE-----

--4sWz01hsBUi3DRx4--
