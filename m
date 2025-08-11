Return-Path: <linux-wireless+bounces-26268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95EAB21054
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 17:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FC1188CF81
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A32E3398;
	Mon, 11 Aug 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpecZ1e0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDF311C35;
	Mon, 11 Aug 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925812; cv=none; b=Ij8fELAAYTcDzS2SlQqB4+cl1ZJ4hhnw9az67HBHj7xpEM2d//mkQax/3SlJlUGH4v0O8dO+gSvTfnm/2NSIZHMxIsjao6KLmHbWP4hDxlJCNuYfuagUFvJfuyQFIi712T0AbHtoOfAgKPtxnI1m/wACI2ybb6oBda1JAwAs13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925812; c=relaxed/simple;
	bh=tAHh0dU7s4yE/R3KG7vQQ3ZFwAZYNYvhFkcrzsZ7+Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXEmdGnnPs0Zi0AaSX7Q+u5JkdiR+4k4CzxDe5hNkCoOADeIuQi3Ql/bMQvbRM64a/0RYDzE6Sa1qRwA4/Kz397BO0lBWuWrAdMAhFPSmxTIFPMUB8t7Vb3wTY6s7TdKGC39PQ1kXoGL0Zu6KeQHIxbn6N4hE08Ofca6lZOOVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpecZ1e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA9C4CEED;
	Mon, 11 Aug 2025 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754925811;
	bh=tAHh0dU7s4yE/R3KG7vQQ3ZFwAZYNYvhFkcrzsZ7+Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpecZ1e0jDDCr6Qh7fkIJPX8Fe0BIEak6YmWCgqMbi8S0zPbVekXfLyGhwt6+HXm2
	 qENmn7MKjdR1rgxBdjkh33LVO0WXMBdGEhCnlb45mCzYvuG3OqsNNePZdp8xhfzjxN
	 e8qNrSnR7zAPzc7ehvtJtTmsJeiUoUGfdVwOkzpGvy6gszUTOTSgaALy6SFYZHQnLp
	 ImyAXW+JF90RoZVWsQb58eDkqEk243aepbEXXhrTbnQ9NeejB8HIYV6+yaZ3woQ63Z
	 hk3tI3A5JKv82OYiuSEL/+v6zHTJN3LA4eKicf2DDLEHrv/tBIT1SDsPiJv5gECP1N
	 jW88fSnHZSytw==
Date: Mon, 11 Aug 2025 17:23:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	Rex Lu <rex.lu@mediatek.com>
Subject: Re: [PATCH net-next v2] net: mediatek: wed: Introduce MT7992 WED
 support to MT7988 SoC
Message-ID: <aJoK7e4aEKR96V4h@lore-rh-laptop>
References: <20250811-mt7992-wed-support-v2-1-e43024c05305@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tUkM0kw1EW+Gc919"
Content-Disposition: inline
In-Reply-To: <20250811-mt7992-wed-support-v2-1-e43024c05305@kernel.org>


--tUkM0kw1EW+Gc919
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce the second WDMA RX ring in WED driver for MT7988 SoC since the
> Mediatek MT7992 WiFi chipset supports two separated WDMA rings.
> Add missing MT7988 configurations to properly support WED for MT7992 in
> MT76 driver.

I sent this email twice wrongly. Please ignore this one.

Regards,
Lorenzo

>=20
> Co-developed-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Fix commit log
> - Rebase on top of net-next main branch
> - Link to v1: https://lore.kernel.org/r/20250727-mt7992-wed-support-v1-1-=
aad7da4dc877@kernel.org
> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c          | 33 ++++++++++++++++++=
+-----
>  drivers/net/ethernet/mediatek/mtk_wed.h          |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  6 ++---
>  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 12 ++++-----
>  include/linux/soc/mediatek/mtk_wed.h             |  2 +-
>  5 files changed, 38 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethern=
et/mediatek/mtk_wed.c
> index 0a80d8f8cff7f415a60b0cd68c0c9c07e2c88f36..3dbb113b792cf00fb4f89ab20=
f7e7fa72ecac260 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -59,7 +59,9 @@ struct mtk_wed_flow_block_priv {
>  static const struct mtk_wed_soc_data mt7622_data =3D {
>  	.regmap =3D {
>  		.tx_bm_tkid		=3D 0x088,
> -		.wpdma_rx_ring0		=3D 0x770,
> +		.wpdma_rx_ring =3D {
> +			0x770,
> +		},
>  		.reset_idx_tx_mask	=3D GENMASK(3, 0),
>  		.reset_idx_rx_mask	=3D GENMASK(17, 16),
>  	},
> @@ -70,7 +72,9 @@ static const struct mtk_wed_soc_data mt7622_data =3D {
>  static const struct mtk_wed_soc_data mt7986_data =3D {
>  	.regmap =3D {
>  		.tx_bm_tkid		=3D 0x0c8,
> -		.wpdma_rx_ring0		=3D 0x770,
> +		.wpdma_rx_ring =3D {
> +			0x770,
> +		},
>  		.reset_idx_tx_mask	=3D GENMASK(1, 0),
>  		.reset_idx_rx_mask	=3D GENMASK(7, 6),
>  	},
> @@ -81,7 +85,10 @@ static const struct mtk_wed_soc_data mt7986_data =3D {
>  static const struct mtk_wed_soc_data mt7988_data =3D {
>  	.regmap =3D {
>  		.tx_bm_tkid		=3D 0x0c8,
> -		.wpdma_rx_ring0		=3D 0x7d0,
> +		.wpdma_rx_ring =3D {
> +			0x7d0,
> +			0x7d8,
> +		},
>  		.reset_idx_tx_mask	=3D GENMASK(1, 0),
>  		.reset_idx_rx_mask	=3D GENMASK(7, 6),
>  	},
> @@ -621,8 +628,8 @@ mtk_wed_amsdu_init(struct mtk_wed_device *dev)
>  		return ret;
>  	}
> =20
> -	/* eagle E1 PCIE1 tx ring 22 flow control issue */
> -	if (dev->wlan.id =3D=3D 0x7991)
> +	/* Kite and Eagle E1 PCIE1 tx ring 22 flow control issue */
> +	if (dev->wlan.id =3D=3D 0x7991 || dev->wlan.id =3D=3D 0x7992)
>  		wed_clr(dev, MTK_WED_AMSDU_FIFO, MTK_WED_AMSDU_IS_PRIOR0_RING);
> =20
>  	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_AMSDU_EN);
> @@ -1239,7 +1246,11 @@ mtk_wed_set_wpdma(struct mtk_wed_device *dev)
>  		return;
> =20
>  	wed_w32(dev, MTK_WED_WPDMA_RX_GLO_CFG, dev->wlan.wpdma_rx_glo);
> -	wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring0, dev->wlan.wpdma_rx);
> +	wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring[0],
> +		dev->wlan.wpdma_rx[0]);
> +	if (mtk_wed_is_v3_or_greater(dev->hw))
> +		wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring[1],
> +			dev->wlan.wpdma_rx[1]);
> =20
>  	if (!dev->wlan.hw_rro)
>  		return;
> @@ -2323,6 +2334,16 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_=
mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> =20
> +	if (dev->wlan.hw_rro) {
> +		for (i =3D 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
> +			u32 addr =3D MTK_WED_RRO_MSDU_PG_CTRL0(i) +
> +				   MTK_WED_RING_OFS_COUNT;
> +
> +			if (!wed_r32(dev, addr))
> +				wed_w32(dev, addr, 1);
> +		}
> +	}
> +
>  	mtk_wed_hw_init(dev);
>  	mtk_wed_configure_irq(dev, irq_mask);
> =20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethern=
et/mediatek/mtk_wed.h
> index c1f0479d7a7182919e77c40efc30ade37abfad58..b49aee9a8b65156310e4f66a1=
7921e5320b3077c 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.h
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.h
> @@ -17,7 +17,7 @@ struct mtk_wed_wo;
>  struct mtk_wed_soc_data {
>  	struct {
>  		u32 tx_bm_tkid;
> -		u32 wpdma_rx_ring0;
> +		u32 wpdma_rx_ring[MTK_WED_RX_QUEUES];
>  		u32 reset_idx_tx_mask;
>  		u32 reset_idx_rx_mask;
>  	} regmap;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index 4a82f8e4c118061fc76459dc0e38f7ee27e25a3a..36488aa6cc20117de4f5b76b8=
0beca149015e055 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -664,8 +664,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void=
 *pdev_ptr,
>  					 MT_RXQ_WED_RING_BASE;
>  		wed->wlan.wpdma_rx_glo =3D pci_resource_start(pci_dev, 0) +
>  					 MT_WPDMA_GLO_CFG;
> -		wed->wlan.wpdma_rx =3D pci_resource_start(pci_dev, 0) +
> -				     MT_RXQ_WED_DATA_RING_BASE;
> +		wed->wlan.wpdma_rx[0] =3D pci_resource_start(pci_dev, 0) +
> +					MT_RXQ_WED_DATA_RING_BASE;
>  	} else {
>  		struct platform_device *plat_dev =3D pdev_ptr;
>  		struct resource *res;
> @@ -687,7 +687,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void=
 *pdev_ptr,
>  		wed->wlan.wpdma_tx =3D res->start + MT_TXQ_WED_RING_BASE;
>  		wed->wlan.wpdma_txfree =3D res->start + MT_RXQ_WED_RING_BASE;
>  		wed->wlan.wpdma_rx_glo =3D res->start + MT_WPDMA_GLO_CFG;
> -		wed->wlan.wpdma_rx =3D res->start + MT_RXQ_WED_DATA_RING_BASE;
> +		wed->wlan.wpdma_rx[0] =3D res->start + MT_RXQ_WED_DATA_RING_BASE;
>  	}
>  	wed->wlan.nbuf =3D MT7915_HW_TOKEN_SIZE;
>  	wed->wlan.tx_tbit[0] =3D is_mt7915(&dev->mt76) ? 4 : 30;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/mmio.c
> index 30b40f4a91be81d429d11f15036167396756d2dc..fb2428a9b877899a0a6fb879a=
ba84e1f6e7840f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> @@ -503,9 +503,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void=
 *pdev_ptr,
>  		}
> =20
>  		wed->wlan.wpdma_rx_glo =3D wed->wlan.phy_base + hif1_ofs + MT_WFDMA0_G=
LO_CFG;
> -		wed->wlan.wpdma_rx =3D wed->wlan.phy_base + hif1_ofs +
> -				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> -				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
> +		wed->wlan.wpdma_rx[0] =3D wed->wlan.phy_base + hif1_ofs +
> +					MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> +					MT7996_RXQ_BAND0 * MT_RING_SIZE;
> =20
>  		wed->wlan.id =3D MT7996_DEVICE_ID_2;
>  		wed->wlan.tx_tbit[0] =3D ffs(MT_INT_TX_DONE_BAND2) - 1;
> @@ -518,9 +518,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void=
 *pdev_ptr,
> =20
>  		wed->wlan.wpdma_rx_glo =3D wed->wlan.phy_base + MT_WFDMA0_GLO_CFG;
> =20
> -		wed->wlan.wpdma_rx =3D wed->wlan.phy_base +
> -				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> -				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
> +		wed->wlan.wpdma_rx[0] =3D wed->wlan.phy_base +
> +					MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> +					MT7996_RXQ_BAND0 * MT_RING_SIZE;
> =20
>  		wed->wlan.wpdma_rx_rro[0] =3D wed->wlan.phy_base +
>  					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND0) +
> diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/med=
iatek/mtk_wed.h
> index d8949a4ed0dc9d41b3364e85a21e15d258519c45..c4ff6bab176db1f51cd94ac41=
98df0caeb557df2 100644
> --- a/include/linux/soc/mediatek/mtk_wed.h
> +++ b/include/linux/soc/mediatek/mtk_wed.h
> @@ -147,7 +147,7 @@ struct mtk_wed_device {
>  		u32 wpdma_tx;
>  		u32 wpdma_txfree;
>  		u32 wpdma_rx_glo;
> -		u32 wpdma_rx;
> +		u32 wpdma_rx[MTK_WED_RX_QUEUES];
>  		u32 wpdma_rx_rro[MTK_WED_RX_QUEUES];
>  		u32 wpdma_rx_pg;
> =20
>=20
> ---
> base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
> change-id: 20250718-mt7992-wed-support-456a50d51f81
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--tUkM0kw1EW+Gc919
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaJoK6gAKCRA6cBh0uS2t
rMloAQDn7DXObmUzbddOqjkd2V7tmNtj1rtHscOfahKnaXJgVQD9GiMoNpQbc8Ap
ubPxbbzkSbSnYHUfX5m+UPl/krunngY=
=S99v
-----END PGP SIGNATURE-----

--tUkM0kw1EW+Gc919--

