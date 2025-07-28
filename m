Return-Path: <linux-wireless+bounces-26036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AEAB13E57
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317811882573
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A777273D67;
	Mon, 28 Jul 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybw5xkxi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232727381E;
	Mon, 28 Jul 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716526; cv=none; b=UgxIJR82slxCGAeLwuQ6tVCohpQsspAs6nJpYXfM+7qHleb8q81PSPYS3WycxegRjJ6EEXSw7ep4MLaG2bEhD7KIkA426Kv+SpMJOXqW4yAwWnWMaCNdCqGBh2eSqtciejQAbFlwYUMyAqx0b3of7jfRaqAY8qdsrsDNRlrUWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716526; c=relaxed/simple;
	bh=/qr9LeDTif46lKIU0pPUJ5a3WdrpDcyO4yMMt+qGH1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwAs6bVnOFuzU6rHhZUHwU0LztUhkaRUo/eEs1KE3Zv4LQ380nXGuNeN/M6atCBEqbKizf2yGJSVt9O6dfJVoF9NohGUP+VMdNklWDRUg9f5D2pMCN07o0Rf/PuzSoc7yi4/7IzU+lvwjTuoY6RHHCEV7axVie+XLAEm5T5DLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybw5xkxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EB3C4CEE7;
	Mon, 28 Jul 2025 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753716525;
	bh=/qr9LeDTif46lKIU0pPUJ5a3WdrpDcyO4yMMt+qGH1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ybw5xkxiZq2PfosVO+KatdPw2FWGNQ9spYKphGv080KJ98ZkmHW7GyrYjT14bB/Kw
	 JbJvzbR0VRYIeYBr3BS+/Oxdx8k8ucPOshQottpZoynpIEZy578N/RKSE4RiJNLH9c
	 EKmSZF8tEhJiKC3LMp7Pv5PT2Cchj8IUWx2VkhnMWNzgey2d50i/eJQGFpCJA1MJV/
	 JA/bn2ljI1736B5u4XkEW5X4urtS6sbFllCGs5eQKFaxl4ahcX8xOfIarlxGsF/sAV
	 bbABF8JM5r7BWxG+y2fSATeSLQzAihiuHGli8icG5uXmuzRsk8lyNzDnixLq0MT/Kj
	 32QZEYKq0EnuQ==
Date: Mon, 28 Jul 2025 17:28:41 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	Rex Lu <rex.lu@mediatek.com>
Subject: Re: [PATCH net-next] net: mediatek: wed: Introduce MT7992 WED support
Message-ID: <aIeXKRmGxDROUDHt@lore-rh-laptop>
References: <20250727-mt7992-wed-support-v1-1-aad7da4dc877@kernel.org>
 <9314b674-dadb-4749-a792-bd4053eaae04@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WiCFpIaCoVI82VjZ"
Content-Disposition: inline
In-Reply-To: <9314b674-dadb-4749-a792-bd4053eaae04@linux.intel.com>


--WiCFpIaCoVI82VjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2025-07-27 2:50 PM, Lorenzo Bianconi wrote:
> > Introduce the second WDMA RX ring in WED driver since Meditake MT7992
>=20
> s/Meditake/Mediatek

ack, I will fix it in v2.

>=20
> > WiFi chipset support two separated WDMA rings. This is a preliminary
>=20
> s/support/supports

ack, I will fix it in v2.

>=20
> > patch to properly support WED for MT7992 in MT76 driver.
> >=20
> > Co-developed-by: Rex Lu <rex.lu@mediatek.com>
> > Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/ethernet/mediatek/mtk_wed.c          | 33 +++++++++++++++=
++++-----
> >   drivers/net/ethernet/mediatek/mtk_wed.h          |  2 +-
> >   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  6 ++---
> >   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 12 ++++-----
> >   include/linux/soc/mediatek/mtk_wed.h             |  2 +-
> >   5 files changed, 38 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index 73c26fcfd85e7be3040abea8e80ff4bee881016c..44a7b4b9d5a4e7cb2c6173f=
f97024ef74c241058 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -59,7 +59,9 @@ struct mtk_wed_flow_block_priv {
> >   static const struct mtk_wed_soc_data mt7622_data =3D {
> >   	.regmap =3D {
> >   		.tx_bm_tkid		=3D 0x088,
> > -		.wpdma_rx_ring0		=3D 0x770,
> > +		.wpdma_rx_ring =3D {
> > +			0x770,
> > +		},
> >   		.reset_idx_tx_mask	=3D GENMASK(3, 0),
> >   		.reset_idx_rx_mask	=3D GENMASK(17, 16),
> >   	},
> > @@ -70,7 +72,9 @@ static const struct mtk_wed_soc_data mt7622_data =3D {
> >   static const struct mtk_wed_soc_data mt7986_data =3D {
> >   	.regmap =3D {
> >   		.tx_bm_tkid		=3D 0x0c8,
> > -		.wpdma_rx_ring0		=3D 0x770,
> > +		.wpdma_rx_ring =3D {
> > +			0x770,
> > +		},
> >   		.reset_idx_tx_mask	=3D GENMASK(1, 0),
> >   		.reset_idx_rx_mask	=3D GENMASK(7, 6),
> >   	},
> > @@ -81,7 +85,10 @@ static const struct mtk_wed_soc_data mt7986_data =3D=
 {
> >   static const struct mtk_wed_soc_data mt7988_data =3D {
>=20
> In the patch description you mention the mt7992 chip, however you are add=
ing
> a second rx_ring definition for the mt7988, is this correct?

yes, since MT7992 is the WiFi chiset that is the WED funcationality consumer
while MT7988 is the SoC ethernet controller. I will add more info in the co=
mmit
log.

>=20
> >   	.regmap =3D {
> >   		.tx_bm_tkid		=3D 0x0c8,
> > -		.wpdma_rx_ring0		=3D 0x7d0,
> > +		.wpdma_rx_ring =3D {
> > +			0x7d0,
> > +			0x7d8,
> > +		},
> >   		.reset_idx_tx_mask	=3D GENMASK(1, 0),
> >   		.reset_idx_rx_mask	=3D GENMASK(7, 6),
> >   	},
> > @@ -621,8 +628,8 @@ mtk_wed_amsdu_init(struct mtk_wed_device *dev)
> >   		return ret;
> >   	}
> > -	/* eagle E1 PCIE1 tx ring 22 flow control issue */
> > -	if (dev->wlan.id =3D=3D 0x7991)
> > +	/* Kite and Eagle E1 PCIE1 tx ring 22 flow control issue */
> > +	if (dev->wlan.id =3D=3D 0x7991 || dev->wlan.id =3D=3D 0x7992)
> >   		wed_clr(dev, MTK_WED_AMSDU_FIFO, MTK_WED_AMSDU_IS_PRIOR0_RING);
> >   	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_AMSDU_EN);
> > @@ -1239,7 +1246,11 @@ mtk_wed_set_wpdma(struct mtk_wed_device *dev)
> >   		return;
> >   	wed_w32(dev, MTK_WED_WPDMA_RX_GLO_CFG, dev->wlan.wpdma_rx_glo);
> > -	wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring0, dev->wlan.wpdma_rx);
> > +	wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring[0],
> > +		dev->wlan.wpdma_rx[0]);
> > +	if (mtk_wed_is_v3(dev->hw))
>=20
> You also have mtk_wed_is_v3_or_greater() defined in the header, why not u=
se
> that?

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> > +		wed_w32(dev, dev->hw->soc->regmap.wpdma_rx_ring[1],
> > +			dev->wlan.wpdma_rx[1]);
> >   	if (!dev->wlan.hw_rro)
> >   		return;
> > @@ -2323,6 +2334,16 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 ir=
q_mask)
> >   		if (!dev->rx_wdma[i].desc)
> >   			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> > +	if (dev->wlan.hw_rro) {
> > +		for (i =3D 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
> > +			u32 addr =3D MTK_WED_RRO_MSDU_PG_CTRL0(i) +
> > +				   MTK_WED_RING_OFS_COUNT;
> > +
> > +			if (!wed_r32(dev, addr))
> > +				wed_w32(dev, addr, 1);
> > +		}
> > +	}
> > +
> >   	mtk_wed_hw_init(dev);
> >   	mtk_wed_configure_irq(dev, irq_mask);
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethe=
rnet/mediatek/mtk_wed.h
> > index c1f0479d7a7182919e77c40efc30ade37abfad58..b49aee9a8b65156310e4f66=
a17921e5320b3077c 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.h
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.h
> > @@ -17,7 +17,7 @@ struct mtk_wed_wo;
> >   struct mtk_wed_soc_data {
> >   	struct {
> >   		u32 tx_bm_tkid;
> > -		u32 wpdma_rx_ring0;
> > +		u32 wpdma_rx_ring[MTK_WED_RX_QUEUES];
> >   		u32 reset_idx_tx_mask;
> >   		u32 reset_idx_rx_mask;
> >   	} regmap;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers=
/net/wireless/mediatek/mt76/mt7915/mmio.c
> > index 4a82f8e4c118061fc76459dc0e38f7ee27e25a3a..36488aa6cc20117de4f5b76=
b80beca149015e055 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > @@ -664,8 +664,8 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, vo=
id *pdev_ptr,
> >   					 MT_RXQ_WED_RING_BASE;
> >   		wed->wlan.wpdma_rx_glo =3D pci_resource_start(pci_dev, 0) +
> >   					 MT_WPDMA_GLO_CFG;
> > -		wed->wlan.wpdma_rx =3D pci_resource_start(pci_dev, 0) +
> > -				     MT_RXQ_WED_DATA_RING_BASE;
> > +		wed->wlan.wpdma_rx[0] =3D pci_resource_start(pci_dev, 0) +
> > +					MT_RXQ_WED_DATA_RING_BASE;
> >   	} else {
> >   		struct platform_device *plat_dev =3D pdev_ptr;
> >   		struct resource *res;
> > @@ -687,7 +687,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, vo=
id *pdev_ptr,
> >   		wed->wlan.wpdma_tx =3D res->start + MT_TXQ_WED_RING_BASE;
> >   		wed->wlan.wpdma_txfree =3D res->start + MT_RXQ_WED_RING_BASE;
> >   		wed->wlan.wpdma_rx_glo =3D res->start + MT_WPDMA_GLO_CFG;
> > -		wed->wlan.wpdma_rx =3D res->start + MT_RXQ_WED_DATA_RING_BASE;
> > +		wed->wlan.wpdma_rx[0] =3D res->start + MT_RXQ_WED_DATA_RING_BASE;
> >   	}
> >   	wed->wlan.nbuf =3D MT7915_HW_TOKEN_SIZE;
> >   	wed->wlan.tx_tbit[0] =3D is_mt7915(&dev->mt76) ? 4 : 30;
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers=
/net/wireless/mediatek/mt76/mt7996/mmio.c
> > index 30b40f4a91be81d429d11f15036167396756d2dc..fb2428a9b877899a0a6fb87=
9aba84e1f6e7840f2 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> > @@ -503,9 +503,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, vo=
id *pdev_ptr,
> >   		}
> >   		wed->wlan.wpdma_rx_glo =3D wed->wlan.phy_base + hif1_ofs + MT_WFDMA=
0_GLO_CFG;
> > -		wed->wlan.wpdma_rx =3D wed->wlan.phy_base + hif1_ofs +
> > -				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> > -				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
> > +		wed->wlan.wpdma_rx[0] =3D wed->wlan.phy_base + hif1_ofs +
> > +					MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> > +					MT7996_RXQ_BAND0 * MT_RING_SIZE;
> >   		wed->wlan.id =3D MT7996_DEVICE_ID_2;
> >   		wed->wlan.tx_tbit[0] =3D ffs(MT_INT_TX_DONE_BAND2) - 1;
> > @@ -518,9 +518,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, vo=
id *pdev_ptr,
> >   		wed->wlan.wpdma_rx_glo =3D wed->wlan.phy_base + MT_WFDMA0_GLO_CFG;
> > -		wed->wlan.wpdma_rx =3D wed->wlan.phy_base +
> > -				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> > -				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
> > +		wed->wlan.wpdma_rx[0] =3D wed->wlan.phy_base +
> > +					MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
> > +					MT7996_RXQ_BAND0 * MT_RING_SIZE;
> >   		wed->wlan.wpdma_rx_rro[0] =3D wed->wlan.phy_base +
> >   					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND0) +
> > diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/m=
ediatek/mtk_wed.h
> > index d8949a4ed0dc9d41b3364e85a21e15d258519c45..c4ff6bab176db1f51cd94ac=
4198df0caeb557df2 100644
> > --- a/include/linux/soc/mediatek/mtk_wed.h
> > +++ b/include/linux/soc/mediatek/mtk_wed.h
> > @@ -147,7 +147,7 @@ struct mtk_wed_device {
> >   		u32 wpdma_tx;
> >   		u32 wpdma_txfree;
> >   		u32 wpdma_rx_glo;
> > -		u32 wpdma_rx;
> > +		u32 wpdma_rx[MTK_WED_RX_QUEUES];
> >   		u32 wpdma_rx_rro[MTK_WED_RX_QUEUES];
> >   		u32 wpdma_rx_pg;
> >=20
> > ---
> > base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
> > change-id: 20250718-mt7992-wed-support-456a50d51f81
>=20
> Best,
> Dawid

--WiCFpIaCoVI82VjZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIeXJgAKCRA6cBh0uS2t
rBgTAP95nJNJMUnd+tYgGJ6YL+nch76ILgIQuge7qAYAGer73wD43roZCTCelett
0JefP45RncInvfee3oEY9fU+nwONDA==
=CTqr
-----END PGP SIGNATURE-----

--WiCFpIaCoVI82VjZ--

