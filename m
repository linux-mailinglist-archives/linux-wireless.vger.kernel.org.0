Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1248C4EE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353627AbiALNfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 08:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiALNfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 08:35:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DCC06173F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 05:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5163F61946
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 13:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1A0C36AE5;
        Wed, 12 Jan 2022 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641994542;
        bh=CXYKorIBHGN9d30FVTKG1cqWPb9VwVeX6FGd9kMXTP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRrV0WAj4IRE0KxcOE64YEF7ZRIc7DZEDS0n0jOZxhjLhtK1PysLAgGGfQoT9XeiT
         duVRfM5q3Wv1sprRvnhyaE2Ru1R8TRWq3040NqaH/Dinq/LlrqjhrmJdblT/HW9oPj
         RWz6F3Lbi5gPyOtsOCubuPYVHd+CE7pZtYe/9heoYZheGRs03BnbJHogf29yQzijfg
         4Tq83b2ZtmOyK4TrkgBue4dvT8TBIZ/1PtX2smbCk6Uw4hFLlF2dBQx9C9RLhLakAi
         +zLuZZJGLPOAhI2GhbxU5M2vYVfI6fSXYCnlIkQPm7QR5iYXR9/5bHTwkFqb3TWF37
         cZaUAW2ULE1Cg==
Date:   Wed, 12 Jan 2022 14:35:37 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH v2 3/5] mt76: mt7915: add support for MT7986
Message-ID: <Yd7ZKb7Qsh4lGA5E@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
 <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ncgu8TBvae2CHRjk"
Content-Disposition: inline
In-Reply-To: <8b2098132192c0381e41ac78a47b7318d5c28b04.1641901681.git.Bo.Jiao@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Ncgu8TBvae2CHRjk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>=20
> This adds MT7986 SoC integrated multi-band 4x4 WiFi 6/6E.
>=20
> Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
>  .../wireless/mediatek/mt76/mt7915/Makefile    |    1 +
>  .../wireless/mediatek/mt76/mt7915/eeprom.c    |   82 +-
>  .../wireless/mediatek/mt76/mt7915/eeprom.h    |   13 +
>  .../net/wireless/mediatek/mt76/mt7915/init.c  |   20 +-
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |   48 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |    9 +-
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   53 +-
>  .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  125 +-
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |   47 +
>  .../net/wireless/mediatek/mt76/mt7915/regs.h  |  276 +++-
>  .../net/wireless/mediatek/mt76/mt7915/soc.c   | 1131 +++++++++++++++++
>  .../wireless/mediatek/mt76/mt7915/testmode.c  |    2 +-
>  drivers/net/wireless/mediatek/mt76/testmode.c |    5 +-
>  14 files changed, 1738 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/soc.c
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 426adbb..4dbb769 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -115,6 +115,11 @@ static inline bool is_mt7916(struct mt76_dev *dev)
>  	return mt76_chip(dev) =3D=3D 0x7906;
>  }
> =20
> +static inline bool is_mt7986(struct mt76_dev *dev)
> +{
> +	return mt76_chip(dev) =3D=3D 0x7986;
> +}
> +
>  static inline bool is_mt7622(struct mt76_dev *dev)
>  {
>  	if (!IS_ENABLED(CONFIG_MT7622_WMAC))
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7915/Makefile
> index 80e4924..b794ceb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
> @@ -6,3 +6,4 @@ mt7915e-y :=3D pci.o init.o dma.o eeprom.o main.o mcu.o m=
ac.o \
>  	     debugfs.o mmio.o
> =20
>  mt7915e-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> +mt7915e-$(CONFIG_MT7986_WMAC) +=3D soc.o
> \ No newline at end of file
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index 6aa749b..0147c93 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -36,27 +36,59 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
>  	switch (val) {
>  	case 0x7915:
>  	case 0x7916:
> +	case 0x7986:
>  		return 0;
>  	default:
>  		return -EINVAL;
>  	}
>  }
> =20
> +static char *mt7915_eeprom_name(struct mt7915_dev *dev)
> +{
> +	char *ret =3D MT7915_EEPROM_DEFAULT;

you can drop this assignement

> +
> +	switch (mt76_chip(&dev->mt76)) {
> +	case 0x7915:
> +		ret =3D dev->dbdc_support ?
> +		      MT7915_EEPROM_DEFAULT_DBDC : MT7915_EEPROM_DEFAULT;

nit: directly return is more readable I guess

> +		break;
> +	case 0x7986:
> +		switch (mt7915_check_adie(dev, true)) {
> +		case MT7976_ONE_ADIE_DBDC:
> +			ret =3D MT7986_EEPROM_MT7976_DEFAULT_DBDC;
> +			break;
> +		case MT7975_ONE_ADIE:
> +			ret =3D MT7986_EEPROM_MT7975_DEFAULT;
> +			break;
> +		case MT7976_ONE_ADIE:
> +			ret =3D MT7986_EEPROM_MT7976_DEFAULT;
> +			break;
> +		case MT7975_DUAL_ADIE:
> +			ret =3D MT7986_EEPROM_MT7975_DUAL_DEFAULT;
> +			break;
> +		case MT7976_DUAL_ADIE:
> +			ret =3D MT7986_EEPROM_MT7976_DUAL_DEFAULT;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		ret =3D MT7916_EEPROM_DEFAULT;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

[...]

>  	u8 reserved1[15];
>  } __packed;
> =20
> +#define fw_name(_dev, name, ...)	({			\
> +	char *_fw;						\
> +	switch (mt76_chip(&(_dev)->mt76)) {			\
> +	case 0x7915:						\
> +		_fw =3D MT7915_##name;				\
> +		break;						\
> +	case 0x7986:						\
> +		_fw =3D MT7986_##name##__VA_ARGS__;		\
> +		break;						\
> +	default:						\
> +		_fw =3D MT7916_##name;				\
> +		break;						\
> +	}							\
> +	_fw;							\
> +})
> +
> +#define fw_name_var(_dev, name)		(mt7915_check_adie(dev, false) ?	\
> +					 fw_name(_dev, name) :			\
> +					 fw_name(_dev, name, _MT7975))

can we use inline routines instead of macros?

> +
>  #define MCU_PATCH_ADDRESS		0x200000
> =20
>  #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
> @@ -89,6 +109,7 @@ mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, _=
_le16 *he_mcs,
>  			  const u16 *mask)
>  {
>  	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +	struct mt7915_dev *dev =3D msta->vif->phy->dev;
>  	struct cfg80211_chan_def *chandef =3D &msta->vif->phy->mt76->chandef;
>  	int nss, max_nss =3D sta->rx_nss > 3 ? 4 : sta->rx_nss;
>  	u16 mcs_map;
> @@ -141,8 +162,9 @@ mt7915_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, =
__le16 *he_mcs,
>  		mcs_map &=3D ~(0x3 << (nss * 2));
>  		mcs_map |=3D mcs << (nss * 2);
> =20
> -		/* only support 2ss on 160MHz */
> -		if (nss > 1 && (sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160))
> +		/* only support 2ss on 160MHz for mt7915 */
> +		if (is_mt7915(&dev->mt76) && nss > 1 &&
> +		    sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160)
>  			break;
>  	}
> =20
> @@ -153,6 +175,8 @@ static void
>  mt7915_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta, __le16 *vht_mcs,
>  			   const u16 *mask)
>  {
> +	struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +	struct mt7915_dev *dev =3D msta->vif->phy->dev;
>  	u16 mcs_map =3D le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
>  	int nss, max_nss =3D sta->rx_nss > 3 ? 4 : sta->rx_nss;
>  	u16 mcs;
> @@ -174,8 +198,9 @@ mt7915_mcu_set_sta_vht_mcs(struct ieee80211_sta *sta,=
 __le16 *vht_mcs,
> =20
>  		vht_mcs[nss] =3D cpu_to_le16(mcs & mask[nss]);
> =20
> -		/* only support 2ss on 160MHz */
> -		if (nss > 1 && (sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160))
> +		/* only support 2ss on 160MHz for mt7915 */
> +		if (is_mt7915(&dev->mt76) && nss > 1 &&
> +		    sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160)
>  			break;
>  	}
>  }
> @@ -1948,7 +1973,6 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
>  {
>  	const struct mt7915_patch_hdr *hdr;
>  	const struct firmware *fw =3D NULL;
> -	const char *patch;
>  	int i, ret, sem;
> =20
>  	sem =3D mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, 1);
> @@ -1962,8 +1986,8 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
>  		return -EAGAIN;
>  	}
> =20
> -	patch =3D is_mt7915(&dev->mt76) ? MT7915_ROM_PATCH : MT7916_ROM_PATCH;
> -	ret =3D request_firmware(&fw, patch, dev->mt76.dev);
> +	ret =3D request_firmware(&fw, fw_name_var(dev, ROM_PATCH),
> +			       dev->mt76.dev);
>  	if (ret)
>  		goto out;
> =20
> @@ -2082,11 +2106,10 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
>  {
>  	const struct mt7915_fw_trailer *hdr;
>  	const struct firmware *fw;
> -	const char *mcu;
>  	int ret;
> =20
> -	mcu =3D is_mt7915(&dev->mt76) ? MT7915_FIRMWARE_WM : MT7916_FIRMWARE_WM;
> -	ret =3D request_firmware(&fw, mcu, dev->mt76.dev);
> +	ret =3D request_firmware(&fw, fw_name_var(dev, FIRMWARE_WM),
> +			       dev->mt76.dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -2110,8 +2133,8 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
> =20
>  	release_firmware(fw);
> =20
> -	mcu =3D is_mt7915(&dev->mt76) ? MT7915_FIRMWARE_WA : MT7916_FIRMWARE_WA;
> -	ret =3D request_firmware(&fw, mcu, dev->mt76.dev);
> +	ret =3D request_firmware(&fw, fw_name(dev, FIRMWARE_WA),
> +			       dev->mt76.dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -2670,10 +2693,8 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *ph=
y, int cmd)
>  		req.tx_streams_num =3D fls(phy->mt76->test.tx_antenna_mask);
>  		req.rx_streams =3D phy->mt76->test.tx_antenna_mask;
> =20
> -		if (ext_phy) {
> -			req.tx_streams_num =3D 2;
> -			req.rx_streams >>=3D 2;
> -		}
> +		if (ext_phy)
> +			req.rx_streams >>=3D dev->chainshift;
>  	}
>  #endif
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index e8ff686..e71b575 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -17,6 +17,11 @@ static const u32 mt7915_reg[] =3D {
>  	[INT1_MASK_CSR]		=3D 0xd708c,
>  	[INT_MCU_CMD_SOURCE]	=3D 0xd51f0,
>  	[INT_MCU_CMD_EVENT]	=3D 0x3108,
> +	[WFDMA0_ADDR]		=3D 0xd4000,
> +	[WFDMA0_PCIE1_ADDR]	=3D 0xd8000,
> +	[WFDMA_EXT_CSR_ADDR]	=3D 0xd7000,
> +	[CBTOP1_PHY_END]	=3D 0x77ffffff,
> +	[INFRA_MCU_ADDR_END]	=3D 0x7c3fffff,
>  };
> =20
>  static const u32 mt7916_reg[] =3D {
> @@ -26,6 +31,25 @@ static const u32 mt7916_reg[] =3D {
>  	[INT1_MASK_CSR]		=3D 0xd8204,
>  	[INT_MCU_CMD_SOURCE]	=3D 0xd41f0,
>  	[INT_MCU_CMD_EVENT]	=3D 0x2108,
> +	[WFDMA0_ADDR]		=3D 0xd4000,
> +	[WFDMA0_PCIE1_ADDR]	=3D 0xd8000,
> +	[WFDMA_EXT_CSR_ADDR]	=3D 0xd7000,
> +	[CBTOP1_PHY_END]	=3D 0x7fffffff,
> +	[INFRA_MCU_ADDR_END]	=3D 0x7c085fff,
> +};
> +
> +static const u32 mt7986_reg[] =3D {
> +	[INT_SOURCE_CSR]	=3D 0x24200,
> +	[INT_MASK_CSR]		=3D 0x24204,
> +	[INT1_SOURCE_CSR]	=3D 0x28200,
> +	[INT1_MASK_CSR]		=3D 0x28204,
> +	[INT_MCU_CMD_SOURCE]	=3D 0x241f0,
> +	[INT_MCU_CMD_EVENT]	=3D 0x54000108,
> +	[WFDMA0_ADDR]		=3D 0x24000,
> +	[WFDMA0_PCIE1_ADDR]	=3D 0x28000,
> +	[WFDMA_EXT_CSR_ADDR]	=3D 0x27000,
> +	[CBTOP1_PHY_END]	=3D 0x7fffffff,
> +	[INFRA_MCU_ADDR_END]	=3D 0x7c085fff,
>  };
> =20
>  static const u32 mt7915_offs[] =3D {
> @@ -264,12 +288,69 @@ static const struct __map mt7916_reg_map[] =3D {
>  	{ 0x0, 0x0, 0x0 }, /* imply end of search */
>  };
> =20
> +static const struct __map mt7986_reg_map[] =3D {
> +	{ 0x54000000, 0x402000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
> +	{ 0x55000000, 0x403000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
> +	{ 0x56000000, 0x404000, 0x1000 }, /* WFDMA_2 (Reserved) */
> +	{ 0x57000000, 0x405000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
> +	{ 0x58000000, 0x406000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
> +	{ 0x59000000, 0x407000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
> +	{ 0x820c0000, 0x408000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> +	{ 0x820c8000, 0x40c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> +	{ 0x820cc000, 0x40e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
> +	{ 0x820e0000, 0x420000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> +	{ 0x820e1000, 0x420400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> +	{ 0x820e2000, 0x420800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> +	{ 0x820e3000, 0x420c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> +	{ 0x820e4000, 0x421000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> +	{ 0x820e5000, 0x421400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> +	{ 0x820ce000, 0x421c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> +	{ 0x820e7000, 0x421e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> +	{ 0x820cf000, 0x422000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> +	{ 0x820e9000, 0x423400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> +	{ 0x820ea000, 0x424000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> +	{ 0x820eb000, 0x424200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> +	{ 0x820ec000, 0x424600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> +	{ 0x820ed000, 0x424800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> +	{ 0x820ca000, 0x426000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
> +	{ 0x820d0000, 0x430000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
> +	{ 0x00400000, 0x480000, 0x10000}, /* WF_MCU_SYSRAM */
> +	{ 0x00410000, 0x490000, 0x10000}, /* WF_MCU_SYSRAM */
> +	{ 0x820f0000, 0x4a0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
> +	{ 0x820f1000, 0x4a0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
> +	{ 0x820f2000, 0x4a0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> +	{ 0x820f3000, 0x4a0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
> +	{ 0x820f4000, 0x4a1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
> +	{ 0x820f5000, 0x4a1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
> +	{ 0x820f7000, 0x4a1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
> +	{ 0x820f9000, 0x4a3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
> +	{ 0x820fa000, 0x4a4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
> +	{ 0x820fb000, 0x4a4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
> +	{ 0x820fc000, 0x4a4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
> +	{ 0x820fd000, 0x4a4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
> +	{ 0x820c4000, 0x4a8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
> +	{ 0x820b0000, 0x4ae000, 0x1000 }, /* [APB2] WFSYS_ON */
> +	{ 0x80020000, 0x4b0000, 0x10000}, /* WF_TOP_MISC_OFF */
> +	{ 0x81020000, 0x4c0000, 0x10000}, /* WF_TOP_MISC_ON */
> +	{ 0x89000000, 0x4d0000, 0x1000 }, /* WF_MCU_CFG_ON */
> +	{ 0x89010000, 0x4d1000, 0x1000 }, /* WF_MCU_CIRQ */
> +	{ 0x89020000, 0x4d2000, 0x1000 }, /* WF_MCU_GPT */
> +	{ 0x89030000, 0x4d3000, 0x1000 }, /* WF_MCU_WDT */
> +	{ 0x80010000, 0x4d4000, 0x1000 }, /* WF_AXIDMA */
> +	{ 0x0, 0x0, 0x0 }, /* imply end of search */
> +};
> +
>  static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
>  {
>  	u32 offset =3D FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
>  	u32 base =3D FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
> -	u32 l1_remap =3D is_mt7915(&dev->mt76) ?
> -			MT_HIF_REMAP_L1 : MT_HIF_REMAP_L1_MT7916;
> +	u32 l1_remap;
> +
> +	if (is_mt7986(&dev->mt76))
> +		return MT_CONN_INFRA_OFFSET(addr);
> +
> +	l1_remap =3D is_mt7915(&dev->mt76) ?
> +		   MT_HIF_REMAP_L1 : MT_HIF_REMAP_L1_MT7916;
> =20
>  	dev->bus_ops->rmw(&dev->mt76, l1_remap,
>  			  MT_HIF_REMAP_L1_MASK,
> @@ -295,17 +376,19 @@ static u32 mt7915_reg_map_l2(struct mt7915_dev *dev=
, u32 addr)
>  		/* use read to push write */
>  		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
>  	} else {
> +		u32 ofs =3D is_mt7986(&dev->mt76) ? 0x400000 : 0;
> +
>  		offset =3D FIELD_GET(MT_HIF_REMAP_L2_OFFSET_MT7916, addr);
>  		base =3D FIELD_GET(MT_HIF_REMAP_L2_BASE_MT7916, addr);
> =20
> -		dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2_MT7916,
> +		dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2_MT7916 + ofs,
>  				  MT_HIF_REMAP_L2_MASK_MT7916,
>  				  FIELD_PREP(MT_HIF_REMAP_L2_MASK_MT7916, base));
> =20
>  		/* use read to push write */
> -		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2_MT7916);
> +		dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2_MT7916 + ofs);
> =20
> -		offset +=3D MT_HIF_REMAP_BASE_L2_MT7916;
> +		offset +=3D (MT_HIF_REMAP_BASE_L2_MT7916 + ofs);
>  	}
> =20
>  	return offset;
> @@ -338,11 +421,20 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev=
, u32 addr)
> =20
>  	if ((addr >=3D MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
>  	    (addr >=3D MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
> -	    (addr >=3D MT_WFSYS1_PHY_START && addr <=3D MT_WFSYS1_PHY_END) ||
> -	    (addr >=3D MT_CBTOP1_PHY_START && addr <=3D MT_CBTOP1_PHY_END) ||
> -	    (addr >=3D MT_CBTOP2_PHY_START && addr <=3D MT_CBTOP2_PHY_END))
> +	    (addr >=3D MT_WFSYS1_PHY_START && addr <=3D MT_WFSYS1_PHY_END))
> +		return mt7915_reg_map_l1(dev, addr);
> +
> +	if (dev_is_pci(dev->mt76.dev) &&
> +	    ((addr >=3D MT_CBTOP1_PHY_START && addr <=3D MT_CBTOP1_PHY_END) ||
> +	     (addr >=3D MT_CBTOP2_PHY_START && addr <=3D MT_CBTOP2_PHY_END)))
>  		return mt7915_reg_map_l1(dev, addr);
> =20
> +	/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
> +	if (addr >=3D MT_INFRA_MCU_START && addr <=3D MT_INFRA_MCU_END) {
> +		addr =3D addr - MT_INFRA_MCU_START + MT_INFRA_BASE;
> +		return mt7915_reg_map_l1(dev, addr);
> +	}
> +
>  	return mt7915_reg_map_l2(dev, addr);
>  }
> =20
> @@ -393,6 +485,12 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
>  		dev->reg.map =3D mt7916_reg_map;
>  		dev->reg.map_size =3D ARRAY_SIZE(mt7916_reg_map);
>  		break;
> +	case 0x7986:
> +		dev->reg.reg_rev =3D mt7986_reg;
> +		dev->reg.offs_rev =3D mt7916_offs;
> +		dev->reg.map =3D mt7986_reg_map;
> +		dev->reg.map_size =3D ARRAY_SIZE(mt7986_reg_map);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -587,11 +685,22 @@ static int __init mt7915_init(void)
>  	if (ret)
>  		pci_unregister_driver(&mt7915_hif_driver);
> =20
> +	if (IS_ENABLED(CONFIG_MT7986_WMAC)) {
> +		ret =3D platform_driver_register(&mt7986_wmac_driver);
> +		if (ret) {
> +			pci_unregister_driver(&mt7915_pci_driver);
> +			pci_unregister_driver(&mt7915_hif_driver);
> +		}
> +	}
> +
>  	return ret;
>  }
> =20
>  static void __exit mt7915_exit(void)
>  {
> +	if (IS_ENABLED(CONFIG_MT7986_WMAC))
> +		platform_driver_unregister(&mt7986_wmac_driver);
> +
>  	pci_unregister_driver(&mt7915_pci_driver);
>  	pci_unregister_driver(&mt7915_hif_driver);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index cd7ee71..3081c6b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -35,9 +35,20 @@
>  #define MT7916_FIRMWARE_WM		"mediatek/mt7916_wm.bin"
>  #define MT7916_ROM_PATCH		"mediatek/mt7916_rom_patch.bin"
> =20
> +#define MT7986_FIRMWARE_WA		"mediatek/mt7986_wa.bin"
> +#define MT7986_FIRMWARE_WM		"mediatek/mt7986_wm.bin"
> +#define MT7986_FIRMWARE_WM_MT7975	"mediatek/mt7986_wm_mt7975.bin"
> +#define MT7986_ROM_PATCH		"mediatek/mt7986_rom_patch.bin"
> +#define MT7986_ROM_PATCH_MT7975		"mediatek/mt7986_rom_patch_mt7975.bin"
> +
>  #define MT7915_EEPROM_DEFAULT		"mediatek/mt7915_eeprom.bin"
>  #define MT7915_EEPROM_DEFAULT_DBDC	"mediatek/mt7915_eeprom_dbdc.bin"
>  #define MT7916_EEPROM_DEFAULT		"mediatek/mt7916_eeprom.bin"
> +#define MT7986_EEPROM_MT7975_DEFAULT		"mediatek/mt7986_eeprom_mt7975.bin"
> +#define MT7986_EEPROM_MT7975_DUAL_DEFAULT	"mediatek/mt7986_eeprom_mt7975=
_dual.bin"
> +#define MT7986_EEPROM_MT7976_DEFAULT		"mediatek/mt7986_eeprom_mt7976.bin"
> +#define MT7986_EEPROM_MT7976_DEFAULT_DBDC	"mediatek/mt7986_eeprom_mt7976=
_dbdc.bin"
> +#define MT7986_EEPROM_MT7976_DUAL_DEFAULT	"mediatek/mt7986_eeprom_mt7976=
_dual.bin"
> =20
>  #define MT7915_EEPROM_SIZE		3584
>  #define MT7916_EEPROM_SIZE		4096
> @@ -56,6 +67,8 @@
>  #define MT7915_MAX_STA_TWT_AGRT		8
>  #define MT7915_MAX_QUEUE		(__MT_RXQ_MAX + __MT_MCUQ_MAX + 2)
> =20
> +#define MT7986_MAX_ADIE_NUM		2
> +
>  struct mt7915_vif;
>  struct mt7915_sta;
>  struct mt7915_dfs_pulse;
> @@ -270,6 +283,7 @@ struct mt7915_dev {
>  	struct mt7915_phy phy;
> =20
>  	u16 chainmask;
> +	u16 chainshift;
>  	u32 hif_idx;
> =20
>  	struct work_struct init_work;
> @@ -302,6 +316,15 @@ struct mt7915_dev {
>  		u8 table_mask;
>  		u8 n_agrt;
>  	} twt;
> +
> +	struct reset_control *rstc;
> +	void __iomem *dcm;
> +	void __iomem *sku;
> +
> +	struct {
> +		bool is_7975;
> +		bool is_7976;
> +	} adie[MT7986_MAX_ADIE_NUM];

do we really need it? Can we just read data from chip when necessary? it is=
 not
access in the hot-path, right?
I think it is easier and more readable.

>  };
> =20
>  enum {
> @@ -379,11 +402,35 @@ static inline u8 mt7915_lmac_mapping(struct mt7915_=
dev *dev, u8 ac)
>  	return 3 - ac;
>  }
> =20
> +static inline u32 mt7915_check_adie(struct mt7915_dev *dev, bool sku)
> +{
> +	u32 mask =3D sku ? MT_CONNINFRA_SKU_MASK : MT_ADIE_TYPE_MASK;
> +
> +	if (!is_mt7986(&dev->mt76))
> +		return 0;
> +
> +	return mt76_rr(dev, MT_CONNINFRA_SKU_DEC_ADDR) & mask;
> +}
> +
>  extern const struct ieee80211_ops mt7915_ops;
>  extern const struct mt76_testmode_ops mt7915_testmode_ops;
>  extern struct pci_driver mt7915_pci_driver;
>  extern struct pci_driver mt7915_hif_driver;
> +extern struct platform_driver mt7986_wmac_driver;
> +
> +#ifdef CONFIG_MT7986_WMAC
> +int mt7986_wmac_enable(struct mt7915_dev *dev);
> +void mt7986_wmac_disable(struct mt7915_dev *dev);
> +#else
> +static inline int mt7986_wmac_enable(struct mt7915_dev *dev)
> +{
> +	return 0;
> +}
> =20
> +static inline void mt7986_wmac_disable(struct mt7915_dev *dev)
> +{
> +}
> +#endif
>  struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
>  				     void __iomem *mem_base, u32 device_id);
>  irqreturn_t mt7915_irq_handler(int irq, void *dev_instance);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7915/regs.h
> index 6a0f681..7eda28c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> @@ -25,6 +25,11 @@ enum reg_rev {
>  	INT1_MASK_CSR,
>  	INT_MCU_CMD_SOURCE,
>  	INT_MCU_CMD_EVENT,
> +	WFDMA0_ADDR,
> +	WFDMA0_PCIE1_ADDR,
> +	WFDMA_EXT_CSR_ADDR,
> +	CBTOP1_PHY_END,
> +	INFRA_MCU_ADDR_END,
>  	__MT_REG_MAX,
>  };
> =20
> @@ -497,7 +502,7 @@ enum offs_rev {
>  #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
> =20
>  /* WFDMA0 */
> -#define MT_WFDMA0_BASE			0xd4000
> +#define MT_WFDMA0_BASE			__REG(WFDMA0_ADDR)
>  #define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
> =20
>  #define MT_WFDMA0_RST			MT_WFDMA0(0x100)
> @@ -545,7 +550,7 @@ enum offs_rev {
>  #define MT_WFDMA1_PRI_DLY_INT_CFG0	MT_WFDMA1(0x2f0)
> =20
>  /* WFDMA CSR */
> -#define MT_WFDMA_EXT_CSR_BASE		0xd7000
> +#define MT_WFDMA_EXT_CSR_BASE		__REG(WFDMA_EXT_CSR_ADDR)
>  #define MT_WFDMA_EXT_CSR(ofs)		(MT_WFDMA_EXT_CSR_BASE + (ofs))
> =20
>  #define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR(0x30)
> @@ -559,7 +564,7 @@ enum offs_rev {
>  #define MT_PCIE_RECOG_ID_SEM		BIT(31)
> =20
>  /* WFDMA0 PCIE1 */
> -#define MT_WFDMA0_PCIE1_BASE		0xd8000
> +#define MT_WFDMA0_PCIE1_BASE		__REG(WFDMA0_PCIE1_ADDR)
>  #define MT_WFDMA0_PCIE1(ofs)		(MT_WFDMA0_PCIE1_BASE + (ofs))
> =20
>  #define MT_WFDMA0_PCIE1_BUSY_ENA	MT_WFDMA0_PCIE1(0x13c)
> @@ -662,6 +667,16 @@ enum offs_rev {
>  #define MT_TOP_PWR_HW_CTRL		BIT(4)
>  #define MT_TOP_PWR_PWR_ON		BIT(7)
> =20
> +#define MT_TOP_RGU_SYSRAM_PDN		(MT_TOP_RGU_BASE + 0x050)
> +#define MT_TOP_RGU_SYSRAM_SLP		(MT_TOP_RGU_BASE + 0x054)
> +#define MT_TOP_WFSYS_PWR		(MT_TOP_RGU_BASE + 0x010)
> +#define MT_TOP_PWR_EN_MASK		BIT(7)
> +#define MT_TOP_PWR_ACK_MASK		BIT(6)
> +#define MT_TOP_PWR_KEY_MASK		GENMASK(31, 16)
> +
> +#define MT7986_TOP_WM_RESET		(MT_TOP_RGU_BASE + 0x120)
> +#define MT7986_TOP_WM_RESET_MASK	BIT(0)
> +
>  /* l1/l2 remap */
>  #define MT_HIF_REMAP_L1			0xf11ac
>  #define MT_HIF_REMAP_L1_MT7916		0xfe260
> @@ -685,9 +700,201 @@ enum offs_rev {
>  #define MT_WFSYS1_PHY_START		0x18800000
>  #define MT_WFSYS1_PHY_END		0x18bfffff
>  #define MT_CBTOP1_PHY_START		0x70000000
> -#define MT_CBTOP1_PHY_END		0x7fffffff
> +#define MT_CBTOP1_PHY_END		__REG(CBTOP1_PHY_END)
>  #define MT_CBTOP2_PHY_START		0xf0000000
>  #define MT_CBTOP2_PHY_END		0xffffffff
> +#define MT_INFRA_MCU_START		0x7c000000
> +#define MT_INFRA_MCU_END		__REG(INFRA_MCU_ADDR_END)
> +#define MT_CONN_INFRA_OFFSET(p)		((p) - MT_INFRA_BASE)
> +
> +/* CONN INFRA CFG */
> +#define MT_CONN_INFRA_BASE		0x18001000
> +#define MT_CONN_INFRA(ofs)		(MT_CONN_INFRA_BASE + (ofs))
> +
> +#define MT_CONN_INFRA_EFUSE		MT_CONN_INFRA(0x020)
> +
> +#define MT_CONN_INFRA_ADIE_RESET	MT_CONN_INFRA(0x030)
> +#define MT_CONN_INFRA_ADIE1_RESET_MASK	BIT(0)
> +#define MT_CONN_INFRA_ADIE2_RESET_MASK	BIT(2)
> +
> +#define MT_CONN_INFRA_OSC_RC_EN		MT_CONN_INFRA(0x380)
> +
> +#define MT_CONN_INFRA_OSC_CTRL		MT_CONN_INFRA(0x300)
> +#define MT_CONN_INFRA_OSC_RC_EN_MASK	BIT(7)
> +#define MT_CONN_INFRA_OSC_STB_TIME_MASK	GENMASK(23, 0)
> +
> +#define MT_CONN_INFRA_HW_CTRL		MT_CONN_INFRA(0x200)
> +#define MT_CONN_INFRA_HW_CTRL_MASK	BIT(0)
> +
> +#define MT_CONN_INFRA_WF_SLP_PROT	MT_CONN_INFRA(0x540)
> +#define MT_CONN_INFRA_WF_SLP_PROT_MASK	BIT(0)
> +
> +#define MT_CONN_INFRA_WF_SLP_PROT_RDY	MT_CONN_INFRA(0x544)
> +#define MT_CONN_INFRA_CONN_WF_MASK	(BIT(29) | BIT(31))
> +#define MT_CONN_INFRA_CONN		(BIT(25) | BIT(29) | BIT(31))
> +
> +#define MT_CONN_INFRA_EMI_REQ		MT_CONN_INFRA(0x414)
> +#define MT_CONN_INFRA_EMI_REQ_MASK	BIT(0)
> +#define MT_CONN_INFRA_INFRA_REQ_MASK	BIT(5)
> +
> +/* AFE */
> +#define MT_AFE_CTRL_BASE(_band)		(0x18003000 + ((_band) << 19))
> +#define MT_AFE_CTRL(_band, ofs)		(MT_AFE_CTRL_BASE(_band) + (ofs))
> +
> +#define MT_AFE_DIG_EN_01(_band)		MT_AFE_CTRL(_band, 0x00)
> +#define MT_AFE_DIG_EN_02(_band)		MT_AFE_CTRL(_band, 0x04)
> +#define MT_AFE_DIG_EN_03(_band)		MT_AFE_CTRL(_band, 0x08)
> +#define MT_AFE_DIG_TOP_01(_band)	MT_AFE_CTRL(_band, 0x0c)
> +
> +#define MT_AFE_PLL_STB_TIME(_band)	MT_AFE_CTRL(_band, 0xf4)
> +#define MT_AFE_PLL_STB_TIME_MASK	(GENMASK(30, 16) | GENMASK(14, 0))
> +#define MT_AFE_PLL_STB_TIME_VAL		(FIELD_PREP(GENMASK(30, 16), 0x4bc) | \
> +					 FIELD_PREP(GENMASK(14, 0), 0x7e4))
> +#define MT_AFE_BPLL_CFG_MASK		GENMASK(7, 6)
> +#define MT_AFE_WPLL_CFG_MASK		GENMASK(1, 0)
> +#define MT_AFE_MCU_WPLL_CFG_MASK	GENMASK(3, 2)
> +#define MT_AFE_MCU_BPLL_CFG_MASK	GENMASK(17, 16)
> +#define MT_AFE_PLL_CFG_MASK		(MT_AFE_BPLL_CFG_MASK | \
> +					 MT_AFE_WPLL_CFG_MASK | \
> +					 MT_AFE_MCU_WPLL_CFG_MASK | \
> +					 MT_AFE_MCU_BPLL_CFG_MASK)
> +#define MT_AFE_PLL_CFG_VAL		(FIELD_PREP(MT_AFE_BPLL_CFG_MASK, 0x1) | \
> +					 FIELD_PREP(MT_AFE_WPLL_CFG_MASK, 0x2) | \
> +					 FIELD_PREP(MT_AFE_MCU_WPLL_CFG_MASK, 0x1) | \
> +					 FIELD_PREP(MT_AFE_MCU_BPLL_CFG_MASK, 0x2))
> +
> +#define MT_AFE_DIG_TOP_01_MASK		GENMASK(18, 15)
> +#define MT_AFE_DIG_TOP_01_VAL		FIELD_PREP(MT_AFE_DIG_TOP_01_MASK, 0x9)
> +
> +#define MT_AFE_RG_WBG_EN_RCK_MASK	BIT(0)
> +#define MT_AFE_RG_WBG_EN_BPLL_UP_MASK	BIT(21)
> +#define MT_AFE_RG_WBG_EN_WPLL_UP_MASK	BIT(20)
> +#define MT_AFE_RG_WBG_EN_PLL_UP_MASK	(MT_AFE_RG_WBG_EN_BPLL_UP_MASK | \
> +					 MT_AFE_RG_WBG_EN_WPLL_UP_MASK)
> +#define MT_AFE_RG_WBG_EN_TXCAL_MASK	GENMASK(21, 17)
> +
> +#define MT_ADIE_SLP_CTRL_BASE(_band)	(0x18005000 + ((_band) << 19))
> +#define MT_ADIE_SLP_CTRL(_band, ofs)	(MT_ADIE_SLP_CTRL_BASE(_band) + (of=
s))
> +
> +#define MT_ADIE_SLP_CTRL_CK0(_band)	MT_ADIE_SLP_CTRL(_band, 0x120)
> +
> +/* ADIE */
> +#define MT_ADIE_CHIP_ID			0x02c
> +#define MT_ADIE_CHIP_ID_MASK		GENMASK(31, 16)
> +
> +#define MT_ADIE_RG_TOP_THADC_BG		0x034
> +#define MT_ADIE_VRPI_SEL_CR_MASK	GENMASK(15, 12)
> +#define MT_ADIE_VRPI_SEL_EFUSE_MASK	GENMASK(6, 3)
> +
> +#define MT_ADIE_RG_TOP_THADC		0x038
> +#define MT_ADIE_PGA_GAIN_MASK		GENMASK(25, 23)
> +#define MT_ADIE_PGA_GAIN_EFUSE_MASK	GENMASK(2, 0)
> +#define MT_ADIE_LDO_CTRL_MASK		GENMASK(27, 26)
> +#define MT_ADIE_LDO_CTRL_EFUSE_MASK	GENMASK(6, 5)
> +
> +#define MT_AFE_RG_ENCAL_WBTAC_IF_SW	0x070
> +#define MT_ADIE_EFUSE_RDATA0		0x130
> +
> +#define MT_ADIE_EFUSE2_CTRL		0x148
> +#define MT_ADIE_EFUSE_CTRL_MASK		BIT(1)
> +
> +#define MT_ADIE_EFUSE_CFG		0x144
> +#define MT_ADIE_EFUSE_MODE_MASK		GENMASK(7, 6)
> +#define MT_ADIE_EFUSE_ADDR_MASK		GENMASK(25, 16)
> +#define MT_ADIE_EFUSE_VALID_MASK	BIT(29)
> +#define MT_ADIE_EFUSE_KICK_MASK		BIT(30)
> +
> +#define MT_ADIE_THADC_ANALOG		0x3a6
> +
> +#define MT_ADIE_THADC_SLOP		0x3a7
> +#define MT_ADIE_ANA_EN_MASK		BIT(7)
> +
> +#define MT_ADIE_7975_XTAL_CAL		0x3a1
> +#define MT_ADIE_TRIM_MASK		GENMASK(6, 0)
> +#define MT_ADIE_EFUSE_TRIM_MASK		GENMASK(5, 0)
> +#define MT_ADIE_XO_TRIM_EN_MASK		BIT(7)
> +#define MT_ADIE_XTAL_DECREASE_MASK	BIT(6)
> +
> +#define MT_ADIE_7975_XO_TRIM2		0x3a2
> +#define MT_ADIE_7975_XO_TRIM3		0x3a3
> +#define MT_ADIE_7975_XO_TRIM4		0x3a4
> +#define MT_ADIE_7975_XTAL_EN		0x3a5
> +
> +#define MT_ADIE_XO_TRIM_FLOW		0x3ac
> +#define MT_ADIE_XTAL_AXM_80M_OSC	0x390
> +#define MT_ADIE_XTAL_AXM_40M_OSC	0x391
> +#define MT_ADIE_XTAL_TRIM1_80M_OSC	0x398
> +#define MT_ADIE_XTAL_TRIM1_40M_OSC	0x399
> +#define MT_ADIE_WRI_CK_SEL		0x4ac
> +#define MT_ADIE_RG_STRAP_PIN_IN		0x4fc
> +#define MT_ADIE_XTAL_C1			0x654
> +#define MT_ADIE_XTAL_C2			0x658
> +#define MT_ADIE_RG_XO_01		0x65c
> +#define MT_ADIE_RG_XO_03		0x664
> +
> +#define MT_ADIE_CLK_EN			0xa00
> +
> +#define MT_ADIE_7975_XTAL		0xa18
> +#define MT_ADIE_7975_XTAL_EN_MASK	BIT(29)
> +
> +#define MT_ADIE_7975_COCLK		0xa1c
> +#define MT_ADIE_7975_XO_2		0xa84
> +#define MT_ADIE_7975_XO_2_FIX_EN	BIT(31)
> +
> +#define MT_ADIE_7975_XO_CTRL2		0xa94
> +#define MT_ADIE_7975_XO_CTRL2_C1_MASK	GENMASK(26, 20)
> +#define MT_ADIE_7975_XO_CTRL2_C2_MASK	GENMASK(18, 12)
> +#define MT_ADIE_7975_XO_CTRL2_MASK	(MT_ADIE_7975_XO_CTRL2_C1_MASK | \
> +					 MT_ADIE_7975_XO_CTRL2_C2_MASK)
> +
> +#define MT_ADIE_7975_XO_CTRL6		0xaa4
> +#define MT_ADIE_7975_XO_CTRL6_MASK	BIT(16)
> +
> +/* TOP SPI */
> +#define MT_TOP_SPI_ADIE_BASE(_band)	(0x18004000 + ((_band) << 19))
> +#define MT_TOP_SPI_ADIE(_band, ofs)	(MT_TOP_SPI_ADIE_BASE(_band) + (ofs))
> +
> +#define MT_TOP_SPI_BUSY_CR(_band)	MT_TOP_SPI_ADIE(_band, 0)
> +#define MT_TOP_SPI_POLLING_BIT		BIT(5)
> +
> +#define MT_TOP_SPI_ADDR_CR(_band)	MT_TOP_SPI_ADIE(_band, 0x50)
> +#define MT_TOP_SPI_READ_ADDR_FORMAT	(BIT(12) | BIT(13) | BIT(15))
> +#define MT_TOP_SPI_WRITE_ADDR_FORMAT	(BIT(13) | BIT(15))
> +
> +#define MT_TOP_SPI_WRITE_DATA_CR(_band)	MT_TOP_SPI_ADIE(_band, 0x54)
> +#define MT_TOP_SPI_READ_DATA_CR(_band)	MT_TOP_SPI_ADIE(_band, 0x58)
> +
> +/* CONN INFRA CKGEN */
> +#define MT_INFRA_CKGEN_BASE		0x18009000
> +#define MT_INFRA_CKGEN(ofs)		(MT_INFRA_CKGEN_BASE + (ofs))
> +
> +#define MT_INFRA_CKGEN_BUS		MT_INFRA_CKGEN(0xa00)
> +#define MT_INFRA_CKGEN_BUS_CLK_SEL_MASK	BIT(23)
> +#define MT_INFRA_CKGEN_BUS_RDY_SEL_MASK	BIT(29)
> +
> +#define MT_INFRA_CKGEN_BUS_WPLL_DIV_1	MT_INFRA_CKGEN(0x008)
> +#define MT_INFRA_CKGEN_BUS_WPLL_DIV_2	MT_INFRA_CKGEN(0x00c)
> +
> +#define MT_INFRA_CKGEN_RFSPI_WPLL_DIV	MT_INFRA_CKGEN(0x040)
> +#define MT_INFRA_CKGEN_DIV_SEL_MASK	GENMASK(7, 2)
> +#define MT_INFRA_CKGEN_DIV_EN_MASK	BIT(0)
> +
> +/* CONN INFRA BUS */
> +#define MT_INFRA_BUS_BASE		0x1800e000
> +#define MT_INFRA_BUS(ofs)		(MT_INFRA_BUS_BASE + (ofs))
> +
> +#define MT_INFRA_BUS_OFF_TIMEOUT	MT_INFRA_BUS(0x300)
> +#define MT_INFRA_BUS_TIMEOUT_LIMIT_MASK	GENMASK(14, 7)
> +#define MT_INFRA_BUS_TIMEOUT_EN_MASK	GENMASK(3, 0)
> +
> +#define MT_INFRA_BUS_ON_TIMEOUT		MT_INFRA_BUS(0x31c)
> +#define MT_INFRA_BUS_EMI_START		MT_INFRA_BUS(0x360)
> +#define MT_INFRA_BUS_EMI_END		MT_INFRA_BUS(0x364)
> +
> +/* CONN_INFRA_SKU */
> +#define MT_CONNINFRA_SKU_DEC_ADDR	0x18050000
> +#define MT_CONNINFRA_SKU_MASK		GENMASK(15, 0)
> +#define MT_ADIE_TYPE_MASK		BIT(1)
> =20
>  /* FW MODE SYNC */
>  #define MT_SWDEF_MODE			0x41f23c
> @@ -746,6 +953,67 @@ enum offs_rev {
>  #define MT_HW_REV			0x70010204
>  #define MT_WF_SUBSYS_RST		0x70002600
> =20
> +#define MT_TOP_WFSYS_WAKEUP		MT_TOP(0x1a4)
> +#define MT_TOP_WFSYS_WAKEUP_MASK	BIT(0)
> +
> +#define MT_TOP_MCU_EMI_BASE		MT_TOP(0x1c4)
> +#define MT_TOP_MCU_EMI_BASE_MASK	GENMASK(19, 0)
> +
> +#define MT_TOP_CONN_INFRA_WAKEUP	MT_TOP(0x1a0)
> +#define MT_TOP_CONN_INFRA_WAKEUP_MASK	BIT(0)
> +
> +#define MT_TOP_WFSYS_RESET_STATUS	MT_TOP(0x2cc)
> +#define MT_TOP_WFSYS_RESET_STATUS_MASK	BIT(30)
> +
> +/* SEMA */
> +#define MT_SEMA_BASE			0x18070000
> +#define MT_SEMA(ofs)			(MT_SEMA_BASE + (ofs))
> +
> +#define MT_SEMA_RFSPI_STATUS		(MT_SEMA(0x2000) + (11 * 4))
> +#define MT_SEMA_RFSPI_RELEASE		(MT_SEMA(0x2200) + (11 * 4))
> +#define MT_SEMA_RFSPI_STATUS_MASK	BIT(1)
> +
> +/* MCU BUS */
> +#define MT_MCU_BUS_BASE			0x18400000
> +#define MT_MCU_BUS(ofs)			(MT_MCU_BUS_BASE + (ofs))
> +
> +#define MT_MCU_BUS_TIMEOUT		MT_MCU_BUS(0xf0440)
> +#define MT_MCU_BUS_TIMEOUT_SET_MASK	GENMASK(7, 0)
> +#define MT_MCU_BUS_TIMEOUT_CG_EN_MASK	BIT(28)
> +#define MT_MCU_BUS_TIMEOUT_EN_MASK	BIT(31)
> +
> +#define MT_MCU_BUS_REMAP		MT_MCU_BUS(0x120)
> +
> +/* TOP CFG */
> +#define MT_TOP_CFG_BASE			0x184b0000
> +#define MT_TOP_CFG(ofs)			(MT_TOP_CFG_BASE + (ofs))
> +
> +#define MT_TOP_CFG_IP_VERSION_ADDR	MT_TOP_CFG(0x010)
> +
> +/* TOP CFG ON */
> +#define MT_TOP_CFG_ON_BASE		0x184c1000
> +#define MT_TOP_CFG_ON(ofs)		(MT_TOP_CFG_ON_BASE + (ofs))
> +
> +#define MT_TOP_CFG_ON_ROM_IDX		MT_TOP_CFG_ON(0x604)
> +
> +/* SLP CTRL */
> +#define MT_SLP_BASE			0x184c3000
> +#define MT_SLP(ofs)			(MT_SLP_BASE + (ofs))
> +
> +#define MT_SLP_STATUS			MT_SLP(0x00c)
> +#define MT_SLP_WFDMA2CONN_MASK		(BIT(21) | BIT(23))
> +#define MT_SLP_CTRL_EN_MASK		BIT(0)
> +#define MT_SLP_CTRL_BSY_MASK		BIT(1)
> +
> +/* MCU BUS DBG */
> +#define MT_MCU_BUS_DBG_BASE		0x18500000
> +#define MT_MCU_BUS_DBG(ofs)		(MT_MCU_BUS_DBG_BASE + (ofs))
> +
> +#define MT_MCU_BUS_DBG_TIMEOUT		MT_MCU_BUS_DBG(0x0)
> +#define MT_MCU_BUS_DBG_TIMEOUT_SET_MASK GENMASK(31, 16)
> +#define MT_MCU_BUS_DBG_TIMEOUT_CK_EN_MASK BIT(3)
> +#define MT_MCU_BUS_DBG_TIMEOUT_EN_MASK	BIT(2)
> +
>  /* PCIE MAC */
>  #define MT_PCIE_MAC_BASE		0x74030000
>  #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/soc.c
> new file mode 100644
> index 0000000..076fcb9
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
> @@ -0,0 +1,1131 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2022 MediaTek Inc. */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/of_gpio.h>
> +#include <linux/iopoll.h>
> +#include <linux/reset.h>
> +#include <linux/of_net.h>
> +
> +#include "mt7915.h"
> +
> +/* INFRACFG */
> +#define MT_INFRACFG_CONN2AP_SLPPROT	0x0d0
> +#define MT_INFRACFG_AP2CONN_SLPPROT	0x0d4
> +
> +#define MT_INFRACFG_RX_EN_MASK		BIT(16)
> +#define MT_INFRACFG_TX_RDY_MASK		BIT(4)
> +#define MT_INFRACFG_TX_EN_MASK		BIT(0)
> +
> +/* TOP POS */
> +#define MT_TOP_POS_FAST_CTRL		0x114
> +#define MT_TOP_POS_FAST_EN_MASK		BIT(3)
> +
> +#define MT_TOP_POS_SKU			0x21c
> +#define MT_TOP_POS_SKU_MASK		GENMASK(31, 28)
> +#define MT_TOP_POS_SKU_ADIE_DBDC_MASK	BIT(2)
> +
> +enum {
> +	ADIE_SB,
> +	ADIE_DBDC
> +};
> +
> +static int
> +mt76_wmac_spi_read(struct mt7915_dev *dev, u8 adie, u32 addr, u32 *val)
> +{
> +	int ret;
> +	u32 cur;
> +
> +	ret =3D read_poll_timeout(mt76_rr, cur, !(cur & MT_TOP_SPI_POLLING_BIT),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, MT_TOP_SPI_BUSY_CR(adie));
> +	if (ret)
> +		return ret;
> +
> +	mt76_wr(dev, MT_TOP_SPI_ADDR_CR(adie),
> +		MT_TOP_SPI_READ_ADDR_FORMAT | addr);
> +	mt76_wr(dev, MT_TOP_SPI_WRITE_DATA_CR(adie), 0);
> +
> +	ret =3D read_poll_timeout(mt76_rr, cur, !(cur & MT_TOP_SPI_POLLING_BIT),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, MT_TOP_SPI_BUSY_CR(adie));
> +	if (ret)
> +		return ret;
> +
> +	*val =3D mt76_rr(dev, MT_TOP_SPI_READ_DATA_CR(adie));
> +
> +	return 0;
> +}
> +
> +static int
> +mt76_wmac_spi_write(struct mt7915_dev *dev, u8 adie, u32 addr, u32 val)
> +{
> +	int ret;
> +	u32 cur;
> +
> +	ret =3D read_poll_timeout(mt76_rr, cur, !(cur & MT_TOP_SPI_POLLING_BIT),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, MT_TOP_SPI_BUSY_CR(adie));
> +	if (ret)
> +		return ret;
> +
> +	mt76_wr(dev, MT_TOP_SPI_ADDR_CR(adie),
> +		MT_TOP_SPI_WRITE_ADDR_FORMAT | addr);
> +	mt76_wr(dev, MT_TOP_SPI_WRITE_DATA_CR(adie), val);
> +
> +	return read_poll_timeout(mt76_rr, cur, !(cur & MT_TOP_SPI_POLLING_BIT),
> +				 USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				 dev, MT_TOP_SPI_BUSY_CR(adie));
> +}
> +
> +static int
> +mt76_wmac_spi_rmw(struct mt7915_dev *dev, u8 adie,
> +		  u32 addr, u32 mask, u32 val)
> +{
> +	u32 cur, ret;
> +
> +	ret =3D mt76_wmac_spi_read(dev, adie, addr, &cur);
> +	if (ret)
> +		return ret;
> +
> +	cur &=3D ~mask;
> +	cur |=3D val;
> +
> +	return mt76_wmac_spi_write(dev, adie, addr, cur);
> +}
> +
> +static int
> +mt7986_wmac_adie_efuse_read(struct mt7915_dev *dev, u8 adie,
> +			    u32 addr, u32 *data)
> +{
> +	int ret, temp;
> +	u32 val, mask;
> +
> +	ret =3D mt76_wmac_spi_write(dev, adie, MT_ADIE_EFUSE_CFG,
> +				  MT_ADIE_EFUSE_CTRL_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_EFUSE2_CTRL, BIT(30), 0x0);
> +	if (ret)
> +		return ret;
> +
> +	mask =3D (MT_ADIE_EFUSE_MODE_MASK | MT_ADIE_EFUSE_ADDR_MASK |
> +		MT_ADIE_EFUSE_KICK_MASK);
> +	val =3D FIELD_PREP(MT_ADIE_EFUSE_MODE_MASK, 0) |
> +	      FIELD_PREP(MT_ADIE_EFUSE_ADDR_MASK, addr) |
> +	      FIELD_PREP(MT_ADIE_EFUSE_KICK_MASK, 1);
> +	ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_EFUSE2_CTRL, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D read_poll_timeout(mt76_wmac_spi_read, temp,
> +				!FIELD_GET(MT_ADIE_EFUSE_KICK_MASK, val),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, adie, MT_ADIE_EFUSE2_CTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt76_wmac_spi_read(dev, adie, MT_ADIE_EFUSE2_CTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(MT_ADIE_EFUSE_VALID_MASK, val) =3D=3D 1)
> +		ret =3D mt76_wmac_spi_read(dev, adie, MT_ADIE_EFUSE_RDATA0,
> +					 data);
> +
> +	return ret;
> +}
> +
> +#define mt76_wmac_spi_lock(dev)					\
> +{									\
> +	u32 cur;							\
> +									\
> +	read_poll_timeout(mt76_rr, cur,					\
> +			  FIELD_GET(MT_SEMA_RFSPI_STATUS_MASK, cur),	\
> +			  1000, 1000 * MSEC_PER_SEC, false, dev,	\
> +			  MT_SEMA_RFSPI_STATUS);			\
> +}
> +
> +#define mt76_wmac_spi_unlock(dev) mt76_wr(dev, MT_SEMA_RFSPI_RELEASE, 1)

inline routines instead of macros

> +
> +static u32 mt76_wmac_rmw(void __iomem *base, u32 offset, u32 mask, u32 v=
al)
> +{
> +	val |=3D readl(base + offset) & ~mask;
> +	writel(val, base + offset);
> +
> +	return val;
> +}
> +
> +static u8 mt7986_wmac_check_adie_type(struct mt7915_dev *dev)
> +{
> +	u32 val;
> +
> +	val =3D readl(dev->sku + MT_TOP_POS_SKU);
> +
> +	return FIELD_GET(MT_TOP_POS_SKU_ADIE_DBDC_MASK, val);
> +}
> +
> +static int mt7986_wmac_consys_reset(struct mt7915_dev *dev, bool enable)
> +{
> +	if (!enable)
> +		return reset_control_assert(dev->rstc);
> +
> +	mt76_wmac_rmw(dev->sku, MT_TOP_POS_FAST_CTRL,
> +		      MT_TOP_POS_FAST_EN_MASK,
> +		      FIELD_PREP(MT_TOP_POS_FAST_EN_MASK, 0x1));
> +
> +	return reset_control_deassert(dev->rstc);
> +}
> +
> +static int mt7986_wmac_gpio_setup(struct mt7915_dev *dev)
> +{
> +	struct pinctrl_state *state;
> +	struct pinctrl *pinctrl;
> +	int ret;
> +	u8 type;
> +
> +	type =3D mt7986_wmac_check_adie_type(dev);
> +	pinctrl =3D devm_pinctrl_get(dev->mt76.dev);
> +
> +	switch (type) {
> +	case ADIE_SB:
> +		state =3D pinctrl_lookup_state(pinctrl, "default");
> +		if (IS_ERR_OR_NULL(state))
> +			return -EINVAL;
> +		break;
> +	case ADIE_DBDC:
> +		state =3D pinctrl_lookup_state(pinctrl, "dbdc");
> +		if (IS_ERR_OR_NULL(state))
> +			return -EINVAL;
> +		break;
> +	}
> +
> +	ret =3D pinctrl_select_state(pinctrl, state);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(500, 1000);
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_consys_lockup(struct mt7915_dev *dev, bool enable)
> +{
> +	int ret;
> +	u32 cur;
> +
> +	mt76_wmac_rmw(dev->dcm, MT_INFRACFG_AP2CONN_SLPPROT,
> +		      MT_INFRACFG_RX_EN_MASK,
> +		      FIELD_PREP(MT_INFRACFG_RX_EN_MASK, enable));
> +	ret =3D read_poll_timeout(readl, cur, !(cur & MT_INFRACFG_RX_EN_MASK),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev->dcm + MT_INFRACFG_AP2CONN_SLPPROT);
> +	if (ret)
> +		return ret;
> +
> +	mt76_wmac_rmw(dev->dcm, MT_INFRACFG_AP2CONN_SLPPROT,
> +		      MT_INFRACFG_TX_EN_MASK,
> +		      FIELD_PREP(MT_INFRACFG_TX_EN_MASK, enable));
> +	ret =3D read_poll_timeout(readl, cur, !(cur & MT_INFRACFG_TX_RDY_MASK),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev->dcm + MT_INFRACFG_AP2CONN_SLPPROT);
> +	if (ret)
> +		return ret;
> +
> +	mt76_wmac_rmw(dev->dcm, MT_INFRACFG_CONN2AP_SLPPROT,
> +		      MT_INFRACFG_RX_EN_MASK,
> +		      FIELD_PREP(MT_INFRACFG_RX_EN_MASK, enable));
> +	mt76_wmac_rmw(dev->dcm, MT_INFRACFG_CONN2AP_SLPPROT,
> +		      MT_INFRACFG_TX_EN_MASK,
> +		      FIELD_PREP(MT_INFRACFG_TX_EN_MASK, enable));
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_coninfra_check(struct mt7915_dev *dev)
> +{
> +	u32 cur;
> +
> +	return read_poll_timeout(mt76_rr, cur, (cur =3D=3D 0x02070000),
> +				 USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> +				 false, dev, MT_CONN_INFRA_BASE);
> +}
> +
> +static int mt7986_wmac_coninfra_setup(struct mt7915_dev *dev)
> +{
> +	struct device *pdev =3D dev->mt76.dev;
> +	struct reserved_mem *rmem;
> +	struct device_node *np;
> +	u32 val;
> +
> +	np =3D of_parse_phandle(pdev->of_node, "memory-region", 0);
> +	if (!np)
> +		return -EINVAL;
> +
> +	rmem =3D of_reserved_mem_lookup(np);
> +	if (!rmem)
> +		return -EINVAL;
> +
> +	val =3D (rmem->base >> 16) & MT_TOP_MCU_EMI_BASE_MASK;
> +
> +	/* Set conninfra subsys PLL check */
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
> +		       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
> +		       MT_INFRA_CKGEN_BUS_RDY_SEL_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_TOP_MCU_EMI_BASE,
> +		       MT_TOP_MCU_EMI_BASE_MASK, val);
> +
> +	mt76_wr(dev, MT_INFRA_BUS_EMI_START, rmem->base);
> +	mt76_wr(dev, MT_INFRA_BUS_EMI_END, rmem->size);
> +
> +	mt76_rr(dev, MT_CONN_INFRA_EFUSE);
> +
> +	/* Set conninfra sysram */
> +	mt76_wr(dev, MT_TOP_RGU_SYSRAM_PDN, 0);
> +	mt76_wr(dev, MT_TOP_RGU_SYSRAM_SLP, 1);
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_sku_setup(struct mt7915_dev *dev)
> +{
> +	int i, ret;
> +	u32 data;
> +
> +	for (i =3D 0; i < MT7986_MAX_ADIE_NUM; i++) {
> +		if (!i)
> +			mt76_rmw_field(dev, MT_CONN_INFRA_ADIE_RESET,
> +				       MT_CONN_INFRA_ADIE1_RESET_MASK, 0x1);
> +		else
> +			mt76_rmw_field(dev, MT_CONN_INFRA_ADIE_RESET,
> +				       MT_CONN_INFRA_ADIE2_RESET_MASK, 0x1);
> +
> +		mt76_wmac_spi_lock(dev);
> +		ret =3D mt76_wmac_spi_read(dev, i, MT_ADIE_CHIP_ID, &data);
> +		mt76_wmac_spi_unlock(dev);
> +		if (ret)
> +			return ret;
> +
> +		data =3D FIELD_GET(MT_ADIE_CHIP_ID_MASK, data);
> +		dev->adie[i].is_7975 =3D (data =3D=3D 0x7975);
> +		dev->adie[i].is_7976 =3D (data =3D=3D 0x7976);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_adie_thermal_cal(struct mt7915_dev *dev, u8 adie)
> +{
> +	int ret;
> +	u32 data, val;
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, MT_ADIE_THADC_ANALOG,
> +					  &data);
> +	if (ret || FIELD_GET(MT_ADIE_ANA_EN_MASK, data)) {
> +		val =3D FIELD_GET(MT_ADIE_VRPI_SEL_EFUSE_MASK, data);
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_RG_TOP_THADC_BG,
> +					MT_ADIE_VRPI_SEL_CR_MASK,
> +					FIELD_PREP(MT_ADIE_VRPI_SEL_CR_MASK, val));
> +		if (ret)
> +			return ret;
> +
> +		val =3D FIELD_GET(MT_ADIE_PGA_GAIN_EFUSE_MASK, data);
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_RG_TOP_THADC,
> +					MT_ADIE_PGA_GAIN_MASK,
> +					FIELD_PREP(MT_ADIE_PGA_GAIN_MASK, val));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, MT_ADIE_THADC_SLOP,
> +					  &data);
> +	if (ret || FIELD_GET(MT_ADIE_ANA_EN_MASK, data)) {
> +		val =3D FIELD_GET(MT_ADIE_LDO_CTRL_EFUSE_MASK, data);
> +
> +		return mt76_wmac_spi_rmw(dev, adie, MT_ADIE_RG_TOP_THADC,
> +					 MT_ADIE_LDO_CTRL_MASK,
> +					 FIELD_PREP(MT_ADIE_LDO_CTRL_MASK, val));
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mt7986_read_efuse_xo_trim_7976(struct mt7915_dev *dev, u8 adie,
> +			       bool is_40m, int *result)
> +{
> +	int ret;
> +	u32 data, addr;
> +
> +	addr =3D is_40m ? MT_ADIE_XTAL_AXM_40M_OSC : MT_ADIE_XTAL_AXM_80M_OSC;
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, addr, &data);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(MT_ADIE_XO_TRIM_EN_MASK, data)) {
> +		*result =3D 64;
> +	} else {
> +		*result =3D FIELD_GET(MT_ADIE_TRIM_MASK, data);
> +		addr =3D is_40m ? MT_ADIE_XTAL_TRIM1_40M_OSC :
> +				MT_ADIE_XTAL_TRIM1_80M_OSC;
> +		ret =3D mt7986_wmac_adie_efuse_read(dev, adie, addr, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (FIELD_GET(MT_ADIE_XO_TRIM_EN_MASK, data) &&
> +		    FIELD_GET(MT_ADIE_XTAL_DECREASE_MASK, data))
> +			*result -=3D FIELD_GET(MT_ADIE_EFUSE_TRIM_MASK, data);
> +		else if (FIELD_GET(MT_ADIE_XO_TRIM_EN_MASK, data))
> +			*result +=3D FIELD_GET(MT_ADIE_EFUSE_TRIM_MASK, data);
> +
> +		*result =3D max(0, min(127, *result));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_adie_xtal_trim_7976(struct mt7915_dev *dev, u8 ad=
ie)
> +{
> +	int ret, trim_80m, trim_40m;
> +	u32 data, val, mode;
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, MT_ADIE_XO_TRIM_FLOW,
> +					  &data);
> +	if (ret || !FIELD_GET(BIT(1), data))
> +		return 0;
> +
> +	ret =3D mt7986_read_efuse_xo_trim_7976(dev, adie, false, &trim_80m);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_read_efuse_xo_trim_7976(dev, adie, true, &trim_40m);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt76_wmac_spi_read(dev, adie, MT_ADIE_RG_STRAP_PIN_IN, &val);
> +	if (ret)
> +		return ret;
> +
> +	mode =3D FIELD_PREP(GENMASK(6, 4), val);
> +	if (!mode || mode =3D=3D 0x2) {
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_XTAL_C1,
> +					GENMASK(31, 24),
> +					FIELD_PREP(GENMASK(31, 24), trim_80m));
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_XTAL_C2,
> +					GENMASK(31, 24),
> +					FIELD_PREP(GENMASK(31, 24), trim_80m));
> +	} else if (mode =3D=3D 0x3 || mode =3D=3D 0x4 || mode =3D=3D 0x6) {
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_XTAL_C1,
> +					GENMASK(23, 16),
> +					FIELD_PREP(GENMASK(23, 16), trim_40m));
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_XTAL_C2,
> +					GENMASK(23, 16),
> +					FIELD_PREP(GENMASK(23, 16), trim_40m));
> +	}
> +
> +	return ret;
> +}
> +
> +static int mt7986_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
> +{
> +	if (mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_TOP_THADC, 0x4a563b00) ||
> +	    mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_01, 0x1d59080f) ||
> +	    mt76_wmac_spi_write(dev, adie, MT_ADIE_RG_XO_03, 0x34c00fe0))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int
> +mt7986_read_efuse_xo_trim_7975(struct mt7915_dev *dev, u8 adie,
> +			       u32 addr, u32 *result)
> +{
> +	int ret;
> +	u32 data;
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, addr, &data);
> +	if (ret)
> +		return ret;
> +
> +	if ((data & MT_ADIE_XO_TRIM_EN_MASK)) {
> +		if ((data & MT_ADIE_XTAL_DECREASE_MASK))
> +			*result -=3D (data & MT_ADIE_EFUSE_TRIM_MASK);
> +		else
> +			*result +=3D (data & MT_ADIE_EFUSE_TRIM_MASK);
> +
> +		*result =3D (*result & MT_ADIE_TRIM_MASK);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_adie_xtal_trim_7975(struct mt7915_dev *dev, u8 ad=
ie)
> +{
> +	int ret;
> +	u32 data, result =3D 0, value;
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, MT_ADIE_7975_XTAL_EN,
> +					  &data);
> +	if (ret || !(data & BIT(1)))
> +		return 0;
> +
> +	ret =3D mt7986_wmac_adie_efuse_read(dev, adie, MT_ADIE_7975_XTAL_CAL,
> +					  &data);
> +	if (ret)
> +		return ret;
> +
> +	if (data & MT_ADIE_XO_TRIM_EN_MASK)
> +		result =3D (data & MT_ADIE_TRIM_MASK);
> +
> +	ret =3D mt7986_read_efuse_xo_trim_7975(dev, adie, MT_ADIE_7975_XO_TRIM2,
> +					     &result);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_read_efuse_xo_trim_7975(dev, adie, MT_ADIE_7975_XO_TRIM3,
> +					     &result);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_read_efuse_xo_trim_7975(dev, adie, MT_ADIE_7975_XO_TRIM4,
> +					     &result);
> +	if (ret)
> +		return ret;
> +
> +	/* Update trim value to C1 and C2*/
> +	value =3D FIELD_GET(MT_ADIE_7975_XO_CTRL2_C1_MASK, result) |
> +		FIELD_GET(MT_ADIE_7975_XO_CTRL2_C2_MASK, result);
> +	ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_7975_XO_CTRL2,
> +				MT_ADIE_7975_XO_CTRL2_MASK, value);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt76_wmac_spi_read(dev, adie, MT_ADIE_7975_XTAL, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value & MT_ADIE_7975_XTAL_EN_MASK) {
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_7975_XO_2,
> +					MT_ADIE_7975_XO_2_FIX_EN, 0x0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return mt76_wmac_spi_rmw(dev, adie, MT_ADIE_7975_XO_CTRL6,
> +				 MT_ADIE_7975_XO_CTRL6_MASK, 0x1);
> +}
> +
> +static int mt7986_wmac_adie_patch_7975(struct mt7915_dev *dev, u8 adie)
> +{
> +	if (/* disable CAL LDO and fine tune RFDIG LDO */
> +	    mt76_wmac_spi_write(dev, adie, 0x348, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x378, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3a8, 0x00000002) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3d8, 0x00000002) ||
> +	    /* set CKA driving and filter */
> +	    mt76_wmac_spi_write(dev, adie, 0xa1c, 0x30000aaa) ||
> +	    /* set CKB LDO to 1.4V */
> +	    mt76_wmac_spi_write(dev, adie, 0xa84, 0x8470008a) ||
> +	    /* turn on SX0 LTBUF */
> +	    mt76_wmac_spi_write(dev, adie, 0x074, 0x00000002) ||
> +	    /* CK_BUF_SW_EN =3D 1 (all buf in manual mode.) */
> +	    mt76_wmac_spi_write(dev, adie, 0xaa4, 0x01001fc0) ||
> +	    /* BT mode/WF normal mode 00000005 */
> +	    mt76_wmac_spi_write(dev, adie, 0x070, 0x00000005) ||
> +	    /* BG thermal sensor offset update */
> +	    mt76_wmac_spi_write(dev, adie, 0x344, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x374, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3a4, 0x00000088) ||
> +	    mt76_wmac_spi_write(dev, adie, 0x3d4, 0x00000088) ||
> +	    /* set WCON VDD IPTAT to "0000" */
> +	    mt76_wmac_spi_write(dev, adie, 0xa80, 0x44d07000) ||
> +	    /* change back LTBUF SX3 drving to default value */
> +	    mt76_wmac_spi_write(dev, adie, 0xa88, 0x3900aaaa) ||
> +	    /* SM input cap off */
> +	    mt76_wmac_spi_write(dev, adie, 0x2c4, 0x00000000) ||
> +	    /* set CKB driving and filter */
> +	    mt76_wmac_spi_write(dev, adie, 0x2c8, 0x00000072))
> +		return -ETIMEDOUT;

quite hard to read

Regards,
Lorenzo

> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_adie_cfg(struct mt7915_dev *dev, u8 adie)
> +{
> +	int ret;
> +
> +	mt76_wmac_spi_lock(dev);
> +	ret =3D mt76_wmac_spi_write(dev, adie, MT_ADIE_CLK_EN, ~0);
> +	if (ret)
> +		goto out;
> +
> +	if (dev->adie[adie].is_7975) {
> +		ret =3D mt76_wmac_spi_rmw(dev, adie, MT_ADIE_7975_COCLK,
> +					BIT(1), 0x1);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D mt7986_wmac_adie_thermal_cal(dev, adie);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D mt7986_wmac_adie_xtal_trim_7975(dev, adie);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D mt7986_wmac_adie_patch_7975(dev, adie);
> +	} else if (dev->adie[adie].is_7976) {
> +		if (mt7986_wmac_check_adie_type(dev) =3D=3D ADIE_DBDC) {
> +			ret =3D mt76_wmac_spi_write(dev, adie,
> +						  MT_ADIE_WRI_CK_SEL, 0x1c);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		ret =3D mt7986_wmac_adie_thermal_cal(dev, adie);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D mt7986_wmac_adie_xtal_trim_7976(dev, adie);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D mt7986_wmac_adie_patch_7976(dev, adie);
> +	}
> +out:
> +	mt76_wmac_spi_unlock(dev);
> +
> +	return ret;
> +}
> +
> +static int mt7986_wmac_afe_cal(struct mt7915_dev *dev, u8 adie, bool dbd=
c)
> +{
> +	int ret;
> +	u8 idx;
> +
> +	mt76_wmac_spi_lock(dev);
> +	if (dev->adie[adie].is_7975)
> +		ret =3D mt76_wmac_spi_write(dev, adie,
> +					  MT_AFE_RG_ENCAL_WBTAC_IF_SW,
> +					  0x80000000);
> +	else
> +		ret =3D mt76_wmac_spi_write(dev, adie,
> +					  MT_AFE_RG_ENCAL_WBTAC_IF_SW,
> +					  0x88888005);
> +	if (ret)
> +		goto out;
> +
> +	idx =3D dbdc ? ADIE_DBDC : adie;
> +
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_01(idx),
> +		       MT_AFE_RG_WBG_EN_RCK_MASK, 0x1);
> +	usleep_range(60, 100);
> +
> +	mt76_rmw(dev, MT_AFE_DIG_EN_01(idx),
> +		 MT_AFE_RG_WBG_EN_RCK_MASK, 0x0);
> +
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_03(idx),
> +		       MT_AFE_RG_WBG_EN_BPLL_UP_MASK, 0x1);
> +	usleep_range(30, 100);
> +
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_03(idx),
> +		       MT_AFE_RG_WBG_EN_WPLL_UP_MASK, 0x1);
> +	usleep_range(60, 100);
> +
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_01(idx),
> +		       MT_AFE_RG_WBG_EN_TXCAL_MASK, 0x1f);
> +	usleep_range(800, 1000);
> +
> +	mt76_rmw(dev, MT_AFE_DIG_EN_01(idx),
> +		 MT_AFE_RG_WBG_EN_TXCAL_MASK, 0x0);
> +	mt76_rmw(dev, MT_AFE_DIG_EN_03(idx),
> +		 MT_AFE_RG_WBG_EN_PLL_UP_MASK, 0x0);
> +
> +	ret =3D mt76_wmac_spi_write(dev, adie, MT_AFE_RG_ENCAL_WBTAC_IF_SW,
> +				  0x5);
> +
> +out:
> +	mt76_wmac_spi_unlock(dev);
> +
> +	return ret;
> +}
> +
> +static void mt7986_wmac_subsys_pll_initial(struct mt7915_dev *dev, u8 ba=
nd)
> +{
> +	mt76_rmw(dev, MT_AFE_PLL_STB_TIME(band),
> +		 MT_AFE_PLL_STB_TIME_MASK, MT_AFE_PLL_STB_TIME_VAL);
> +
> +	mt76_rmw(dev, MT_AFE_DIG_EN_02(band),
> +		 MT_AFE_PLL_CFG_MASK, MT_AFE_PLL_CFG_VAL);
> +
> +	mt76_rmw(dev, MT_AFE_DIG_TOP_01(band),
> +		 MT_AFE_DIG_TOP_01_MASK, MT_AFE_DIG_TOP_01_VAL);
> +}
> +
> +static void mt7986_wmac_subsys_setting(struct mt7915_dev *dev)
> +{
> +	/* Subsys pll init */
> +	mt7986_wmac_subsys_pll_initial(dev, 0);
> +	mt7986_wmac_subsys_pll_initial(dev, 1);
> +
> +	/* Set legacy OSC control stable time*/
> +	mt76_rmw(dev, MT_CONN_INFRA_OSC_RC_EN,
> +		 MT_CONN_INFRA_OSC_RC_EN_MASK, 0x0);
> +	mt76_rmw(dev, MT_CONN_INFRA_OSC_CTRL,
> +		 MT_CONN_INFRA_OSC_STB_TIME_MASK, 0x80706);
> +
> +	/* prevent subsys from power on/of in a short time interval */
> +	mt76_rmw(dev, MT_TOP_WFSYS_PWR,
> +		 MT_TOP_PWR_ACK_MASK | MT_TOP_PWR_KEY_MASK,
> +		 MT_TOP_PWR_KEY);
> +}
> +
> +static int mt7986_wmac_bus_timeout(struct mt7915_dev *dev)
> +{
> +	mt76_rmw_field(dev, MT_INFRA_BUS_OFF_TIMEOUT,
> +		       MT_INFRA_BUS_TIMEOUT_LIMIT_MASK, 0x2);
> +
> +	mt76_rmw_field(dev, MT_INFRA_BUS_OFF_TIMEOUT,
> +		       MT_INFRA_BUS_TIMEOUT_EN_MASK, 0xf);
> +
> +	mt76_rmw_field(dev, MT_INFRA_BUS_ON_TIMEOUT,
> +		       MT_INFRA_BUS_TIMEOUT_LIMIT_MASK, 0xc);
> +
> +	mt76_rmw_field(dev, MT_INFRA_BUS_ON_TIMEOUT,
> +		       MT_INFRA_BUS_TIMEOUT_EN_MASK, 0xf);
> +
> +	return mt7986_wmac_coninfra_check(dev);
> +}
> +
> +static void mt7986_wmac_clock_enable(struct mt7915_dev *dev)
> +{
> +	u32 cur;
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS_WPLL_DIV_1,
> +		       MT_INFRA_CKGEN_DIV_SEL_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS_WPLL_DIV_2,
> +		       MT_INFRA_CKGEN_DIV_SEL_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS_WPLL_DIV_1,
> +		       MT_INFRA_CKGEN_DIV_EN_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS_WPLL_DIV_2,
> +		       MT_INFRA_CKGEN_DIV_EN_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_RFSPI_WPLL_DIV,
> +		       MT_INFRA_CKGEN_DIV_SEL_MASK, 0x8);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_RFSPI_WPLL_DIV,
> +		       MT_INFRA_CKGEN_DIV_EN_MASK, 0x1);
> +
> +	mt76_rmw_field(dev, MT_INFRA_CKGEN_BUS,
> +		       MT_INFRA_CKGEN_BUS_CLK_SEL_MASK, 0x0);
> +
> +	mt76_rmw_field(dev, MT_CONN_INFRA_HW_CTRL,
> +		       MT_CONN_INFRA_HW_CTRL_MASK, 0x1);
> +
> +	mt76_rmw(dev, MT_TOP_CONN_INFRA_WAKEUP,
> +		 MT_TOP_CONN_INFRA_WAKEUP_MASK, 0x1);
> +
> +	usleep_range(900, 1000);
> +
> +	mt76_wmac_spi_lock(dev);
> +	if (dev->adie[0].is_7975 || dev->adie[0].is_7976) {
> +		mt76_rmw_field(dev, MT_ADIE_SLP_CTRL_CK0(0),
> +			       MT_SLP_CTRL_EN_MASK, 0x1);
> +
> +		read_poll_timeout(mt76_rr, cur, !(cur & MT_SLP_CTRL_BSY_MASK),
> +				  USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				  dev, MT_ADIE_SLP_CTRL_CK0(0));
> +	}
> +	if (dev->adie[1].is_7975 || dev->adie[1].is_7976) {
> +		mt76_rmw_field(dev, MT_ADIE_SLP_CTRL_CK0(1),
> +			       MT_SLP_CTRL_EN_MASK, 0x1);
> +
> +		read_poll_timeout(mt76_rr, cur, !(cur & MT_SLP_CTRL_BSY_MASK),
> +				  USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				  dev, MT_ADIE_SLP_CTRL_CK0(0));
> +	}
> +	mt76_wmac_spi_unlock(dev);
> +
> +	mt76_rmw(dev, MT_TOP_CONN_INFRA_WAKEUP,
> +		 MT_TOP_CONN_INFRA_WAKEUP_MASK, 0x0);
> +	usleep_range(900, 1000);
> +}
> +
> +static int mt7986_wmac_top_wfsys_wakeup(struct mt7915_dev *dev, bool ena=
ble)
> +{
> +	mt76_rmw_field(dev, MT_TOP_WFSYS_WAKEUP,
> +		       MT_TOP_WFSYS_WAKEUP_MASK, enable);
> +
> +	usleep_range(900, 1000);
> +
> +	if (!enable)
> +		return 0;
> +
> +	return mt7986_wmac_coninfra_check(dev);
> +}
> +
> +static int mt7986_wmac_wm_enable(struct mt7915_dev *dev, bool enable)
> +{
> +	u32 cur;
> +
> +	mt76_rmw_field(dev, MT7986_TOP_WM_RESET,
> +		       MT7986_TOP_WM_RESET_MASK, enable);
> +	if (!enable)
> +		return 0;
> +
> +	return read_poll_timeout(mt76_rr, cur, (cur =3D=3D 0x1d1e),
> +				 USEC_PER_MSEC, 5000 * USEC_PER_MSEC, false,
> +				 dev, MT_TOP_CFG_ON_ROM_IDX);
> +}
> +
> +static int mt7986_wmac_wfsys_poweron(struct mt7915_dev *dev, bool enable)
> +{
> +	u32 mask =3D MT_TOP_PWR_EN_MASK | MT_TOP_PWR_KEY_MASK;
> +	u32 cur;
> +
> +	mt76_rmw(dev, MT_TOP_WFSYS_PWR, mask,
> +		 MT_TOP_PWR_KEY | FIELD_PREP(MT_TOP_PWR_EN_MASK, enable));
> +
> +	return read_poll_timeout(mt76_rr, cur,
> +		(FIELD_GET(MT_TOP_WFSYS_RESET_STATUS_MASK, cur) =3D=3D enable),
> +		USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +		dev, MT_TOP_WFSYS_RESET_STATUS);
> +}
> +
> +static int mt7986_wmac_wfsys_setting(struct mt7915_dev *dev)
> +{
> +	int ret;
> +	u32 cur;
> +
> +	/* Turn off wfsys2conn bus sleep protect */
> +	mt76_rmw(dev, MT_CONN_INFRA_WF_SLP_PROT,
> +		 MT_CONN_INFRA_WF_SLP_PROT_MASK, 0x0);
> +
> +	ret =3D mt7986_wmac_wfsys_poweron(dev, true);
> +	if (ret)
> +		return ret;
> +
> +	/* Check bus sleep protect */
> +
> +	ret =3D read_poll_timeout(mt76_rr, cur,
> +				!(cur & MT_CONN_INFRA_CONN_WF_MASK),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, MT_CONN_INFRA_WF_SLP_PROT_RDY);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D read_poll_timeout(mt76_rr, cur, !(cur & MT_SLP_WFDMA2CONN_MASK),
> +				USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				dev, MT_SLP_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	return read_poll_timeout(mt76_rr, cur, (cur =3D=3D 0x02060000),
> +				 USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +				 dev, MT_TOP_CFG_IP_VERSION_ADDR);
> +}
> +
> +static void mt7986_wmac_wfsys_set_timeout(struct mt7915_dev *dev)
> +{
> +	u32 mask =3D MT_MCU_BUS_TIMEOUT_SET_MASK |
> +		   MT_MCU_BUS_TIMEOUT_CG_EN_MASK |
> +		   MT_MCU_BUS_TIMEOUT_EN_MASK;
> +	u32 val =3D FIELD_PREP(MT_MCU_BUS_TIMEOUT_SET_MASK, 1) |
> +		  FIELD_PREP(MT_MCU_BUS_TIMEOUT_CG_EN_MASK, 1) |
> +		  FIELD_PREP(MT_MCU_BUS_TIMEOUT_EN_MASK, 1);
> +
> +	mt76_rmw(dev, MT_MCU_BUS_TIMEOUT, mask, val);
> +
> +	mt76_wr(dev, MT_MCU_BUS_REMAP, 0x810f0000);
> +
> +	mask =3D MT_MCU_BUS_DBG_TIMEOUT_SET_MASK |
> +	       MT_MCU_BUS_DBG_TIMEOUT_CK_EN_MASK |
> +	       MT_MCU_BUS_DBG_TIMEOUT_EN_MASK;
> +	val =3D FIELD_PREP(MT_MCU_BUS_DBG_TIMEOUT_SET_MASK, 0x3aa) |
> +	      FIELD_PREP(MT_MCU_BUS_DBG_TIMEOUT_CK_EN_MASK, 1) |
> +	      FIELD_PREP(MT_MCU_BUS_DBG_TIMEOUT_EN_MASK, 1);
> +
> +	mt76_rmw(dev, MT_MCU_BUS_DBG_TIMEOUT, mask, val);
> +}
> +
> +static int mt7986_wmac_sku_update(struct mt7915_dev *dev)
> +{
> +	u32 val;
> +
> +	if (dev->adie[0].is_7976 && dev->adie[1].is_7976)
> +		val =3D 0xf;
> +	else if (dev->adie[0].is_7975 && dev->adie[1].is_7975)
> +		val =3D 0xd;
> +	else if (dev->adie[0].is_7976)
> +		val =3D 0x7;
> +	else if (dev->adie[1].is_7975)
> +		val =3D 0x8;
> +	else if (dev->adie[1].is_7976)
> +		val =3D 0xa;
> +	else
> +		return -EINVAL;
> +
> +	mt76_wmac_rmw(dev->sku, MT_TOP_POS_SKU, MT_TOP_POS_SKU_MASK,
> +		      FIELD_PREP(MT_TOP_POS_SKU_MASK, val));
> +
> +	mt76_wr(dev, MT_CONNINFRA_SKU_DEC_ADDR, val);
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_adie_setup(struct mt7915_dev *dev, u8 adie)
> +{
> +	int ret;
> +
> +	if (!(dev->adie[adie].is_7975 || dev->adie[adie].is_7976))
> +		return 0;
> +
> +	ret =3D mt7986_wmac_adie_cfg(dev, adie);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_afe_cal(dev, adie, false);
> +	if (ret)
> +		return ret;
> +
> +	if (!adie && (mt7986_wmac_check_adie_type(dev) =3D=3D ADIE_DBDC))
> +		ret =3D mt7986_wmac_afe_cal(dev, adie, true);
> +
> +	return ret;
> +}
> +
> +static int mt7986_wmac_subsys_powerup(struct mt7915_dev *dev)
> +{
> +	int ret;
> +
> +	mt7986_wmac_subsys_setting(dev);
> +
> +	ret =3D mt7986_wmac_bus_timeout(dev);
> +	if (ret)
> +		return ret;
> +
> +	mt7986_wmac_clock_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int mt7986_wmac_wfsys_powerup(struct mt7915_dev *dev)
> +{
> +	int ret;
> +
> +	ret =3D mt7986_wmac_wm_enable(dev, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_wfsys_setting(dev);
> +	if (ret)
> +		return ret;
> +
> +	mt7986_wmac_wfsys_set_timeout(dev);
> +
> +	return mt7986_wmac_wm_enable(dev, true);
> +}
> +
> +int mt7986_wmac_enable(struct mt7915_dev *dev)
> +{
> +	int ret;
> +
> +	ret =3D mt7986_wmac_consys_reset(dev, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_gpio_setup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_consys_lockup(dev, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_coninfra_check(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_coninfra_setup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_sku_setup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_adie_setup(dev, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_adie_setup(dev, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_subsys_powerup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_top_wfsys_wakeup(dev, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mt7986_wmac_wfsys_powerup(dev);
> +	if (ret)
> +		return ret;
> +
> +	return mt7986_wmac_sku_update(dev);
> +}
> +
> +void mt7986_wmac_disable(struct mt7915_dev *dev)
> +{
> +	u32 cur;
> +
> +	mt7986_wmac_top_wfsys_wakeup(dev, true);
> +
> +	/* Turn on wfsys2conn bus sleep protect */
> +	mt76_rmw_field(dev, MT_CONN_INFRA_WF_SLP_PROT,
> +		       MT_CONN_INFRA_WF_SLP_PROT_MASK, 0x1);
> +
> +	/* Check wfsys2conn bus sleep protect */
> +	read_poll_timeout(mt76_rr, cur, !(cur ^ MT_CONN_INFRA_CONN),
> +			  USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +			  dev, MT_CONN_INFRA_WF_SLP_PROT_RDY);
> +
> +	mt7986_wmac_wfsys_poweron(dev, false);
> +
> +	/* Turn back wpll setting */
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_02(0), MT_AFE_MCU_BPLL_CFG_MASK, 0x2);
> +	mt76_rmw_field(dev, MT_AFE_DIG_EN_02(0), MT_AFE_WPLL_CFG_MASK, 0x2);
> +
> +	/* Reset EMI */
> +	mt76_rmw_field(dev, MT_CONN_INFRA_EMI_REQ,
> +		       MT_CONN_INFRA_EMI_REQ_MASK, 0x1);
> +	mt76_rmw_field(dev, MT_CONN_INFRA_EMI_REQ,
> +		       MT_CONN_INFRA_EMI_REQ_MASK, 0x0);
> +	mt76_rmw_field(dev, MT_CONN_INFRA_EMI_REQ,
> +		       MT_CONN_INFRA_INFRA_REQ_MASK, 0x1);
> +	mt76_rmw_field(dev, MT_CONN_INFRA_EMI_REQ,
> +		       MT_CONN_INFRA_INFRA_REQ_MASK, 0x0);
> +
> +	mt7986_wmac_top_wfsys_wakeup(dev, false);
> +	mt7986_wmac_consys_lockup(dev, true);
> +	mt7986_wmac_consys_reset(dev, false);
> +}
> +
> +static int mt7986_wmac_init(struct mt7915_dev *dev)
> +{
> +	struct device *pdev =3D dev->mt76.dev;
> +	struct platform_device *pfdev =3D to_platform_device(pdev);
> +
> +	dev->dcm =3D devm_platform_ioremap_resource(pfdev, 1);
> +	if (IS_ERR(dev->dcm))
> +		return PTR_ERR(dev->dcm);
> +
> +	dev->sku =3D devm_platform_ioremap_resource(pfdev, 2);
> +	if (IS_ERR(dev->sku))
> +		return PTR_ERR(dev->sku);
> +
> +	dev->rstc =3D devm_reset_control_get(pdev, "consys");
> +	if (IS_ERR(dev->rstc))
> +		return PTR_ERR(dev->rstc);
> +
> +	return mt7986_wmac_enable(dev);
> +}
> +
> +static int mt7986_wmac_probe(struct platform_device *pdev)
> +{
> +	void __iomem *mem_base;
> +	struct mt7915_dev *dev;
> +	struct mt76_dev *mdev;
> +	int irq, ret;
> +	u64 chip_id;
> +
> +	chip_id =3D (u64)of_device_get_match_data(&pdev->dev);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	mem_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mem_base)) {
> +		dev_err(&pdev->dev, "Failed to get memory resource\n");
> +		return PTR_ERR(mem_base);
> +	}
> +
> +	dev =3D mt7915_mmio_probe(&pdev->dev, mem_base, chip_id);
> +	if (IS_ERR(dev))
> +		return PTR_ERR(dev);
> +
> +	mdev =3D &dev->mt76;
> +	ret =3D devm_request_irq(mdev->dev, irq, mt7915_irq_handler,
> +			       IRQF_SHARED, KBUILD_MODNAME, dev);
> +	if (ret)
> +		goto free_device;
> +
> +	mt76_wr(dev, MT_INT_MASK_CSR, 0);
> +
> +	ret =3D mt7986_wmac_init(dev);
> +	if (ret)
> +		goto free_irq;
> +
> +	ret =3D mt7915_register_device(dev);
> +	if (ret)
> +		goto free_irq;
> +
> +	return 0;
> +
> +free_irq:
> +	devm_free_irq(mdev->dev, irq, dev);
> +
> +free_device:
> +	mt76_free_device(&dev->mt76);
> +
> +	return ret;
> +}
> +
> +static int mt7986_wmac_remove(struct platform_device *pdev)
> +{
> +	struct mt7915_dev *dev =3D platform_get_drvdata(pdev);
> +
> +	mt7915_unregister_device(dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt7986_wmac_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt7986-wmac", .data =3D (u32 *)0x7986 },
> +	{},
> +};
> +
> +struct platform_driver mt7986_wmac_driver =3D {
> +	.driver =3D {
> +		.name =3D "mt7986-wmac",
> +		.of_match_table =3D mt7986_wmac_of_match,
> +	},
> +	.probe =3D mt7986_wmac_probe,
> +	.remove =3D mt7986_wmac_remove,
> +};
> +
> +MODULE_FIRMWARE(MT7986_FIRMWARE_WA);
> +MODULE_FIRMWARE(MT7986_FIRMWARE_WM);
> +MODULE_FIRMWARE(MT7986_FIRMWARE_WM_MT7975);
> +MODULE_FIRMWARE(MT7986_ROM_PATCH);
> +MODULE_FIRMWARE(MT7986_ROM_PATCH_MT7975);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drive=
rs/net/wireless/mediatek/mt76/mt7915/testmode.c
> index 8300f26..8a00cac 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
> @@ -456,7 +456,7 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool =
en)
>  			u8 tx_ant =3D td->tx_antenna_mask;
> =20
>  			if (phy !=3D &dev->phy)
> -				tx_ant >>=3D 2;
> +				tx_ant >>=3D dev->chainshift;
>  			phy->test.spe_idx =3D spe_idx_map[tx_ant];
>  		}
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/=
wireless/mediatek/mt76/testmode.c
> index 1a01ad7..382b456 100644
> --- a/drivers/net/wireless/mediatek/mt76/testmode.c
> +++ b/drivers/net/wireless/mediatek/mt76/testmode.c
> @@ -409,7 +409,6 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif,
>  	struct mt76_dev *dev =3D phy->dev;
>  	struct mt76_testmode_data *td =3D &phy->test;
>  	struct nlattr *tb[NUM_MT76_TM_ATTRS];
> -	bool ext_phy =3D phy !=3D &dev->phy;
>  	u32 state;
>  	int err;
>  	int i;
> @@ -447,8 +446,8 @@ int mt76_testmode_cmd(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif,
>  	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_LDPC], &td->tx_rate_ldpc, 0,=
 1) ||
>  	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_STBC], &td->tx_rate_stbc, 0,=
 1) ||
>  	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_LTF], &td->tx_ltf, 0, 2) ||
> -	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask,
> -			   1 << (ext_phy * 2), phy->antenna_mask << (ext_phy * 2)) ||
> +	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA],
> +			   &td->tx_antenna_mask, 0, 0xff) ||
>  	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_SPE_IDX], &td->tx_spe_idx, 0, 27)=
 ||
>  	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_DUTY_CYCLE],
>  			   &td->tx_duty_cycle, 0, 99) ||
> --=20
> 2.18.0
>=20

--Ncgu8TBvae2CHRjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd7ZKQAKCRA6cBh0uS2t
rPsOAP4vB+46zqIMKyERDBXi+3wf1yKZ+P51t0i/jU6RMmWXOgD+K+JEkBfF3VKI
PJrx72fSZzVPd97OFr2hgvtWaVSRFgI=
=OLLr
-----END PGP SIGNATURE-----

--Ncgu8TBvae2CHRjk--
