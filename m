Return-Path: <linux-wireless+bounces-13228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E0987540
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF95282022
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5613049E;
	Thu, 26 Sep 2024 14:14:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DD67A0D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360053; cv=none; b=Xjs0gg+gAHeetxF/IXHOUxDrHKv9snRZ6/5AWqEtSvCpwOyu8HWUNkN8ivXV0+sJnNTcG2+oj0YbgJEu6aUz5fsLzhS3A+/8ueVxAqk2RtWTkITwI3FAe633ajAfg8iYwF/4Qq0RqwCqNa7cYZ6aeK93mSxpTyz1qHnklTgkzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360053; c=relaxed/simple;
	bh=QTG44pMreHsb080yyx/6T3lYfS+78iY27fUSBoGhBaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuJuXMKqbXT59VNuoXoFl8Gd7UfvNmj2MRJxBYGiaH6v1kbh7X1cc1ivaosng/iIuHkXZWmk4zp5NI58B5qsDJ8VKL3X3wl+yIT8t+rGySgxY17wXsltUHLKuqoG6eqweJPQlmvShXj3x2sHzsOqUSKU5OLq4fWFHaeILwMSMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1stpFx-000000005kA-25Gl;
	Thu, 26 Sep 2024 14:14:09 +0000
Date: Thu, 26 Sep 2024 15:14:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH 2/3] wifi: mt76: mt7996: add suuport for more variants
Message-ID: <ZvVsLmEY6Q2uDJzP@makrotopia.org>
References: <20240926032440.15978-1-shayne.chen@mediatek.com>
 <20240926032440.15978-2-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926032440.15978-2-shayne.chen@mediatek.com>

On Thu, Sep 26, 2024 at 11:24:39AM +0800, Shayne Chen wrote:
> Current varaints supported:
> - mt7996 chipset: tri-band, 4+4+4 NSS, eFEM
> - mt7992 chipset: dual-band, 4+4 NSS, eFEM
> 
> This patch adds support for the following variants:
> - mt7996 chipset:
>   - tri-band, 4+4+4 NSS, iFEM
>   - tri-band, 2+3+3 NSS, eFEM
>   - tri-band, 2+3+3 NSS, iFEM
> - mt7992 chipset:
>   - dual-band, 4+4 NSS, iFEM
>   - dual-band, 4+4 NSS, with band0 iFEM and band1 eFEM
>   - dual-band, 2+3 NSS, eFEM
>   - dual-band, 2+3 NSS, iFEM
> 
> Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  .../wireless/mediatek/mt76/mt7996/eeprom.c    | 206 +++++++++++++-----
>  .../wireless/mediatek/mt76/mt7996/eeprom.h    |   2 +
>  .../net/wireless/mediatek/mt76/mt7996/init.c  |  78 +++++++
>  .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  16 +-
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    |  46 +++-
>  .../net/wireless/mediatek/mt76/mt7996/regs.h  |   9 +
>  6 files changed, 289 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> index 861aba68a725..da94751df020 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> @@ -25,17 +25,108 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
>  static char *mt7996_eeprom_name(struct mt7996_dev *dev)
>  {
>  	switch (mt76_chip(&dev->mt76)) {
> -	case 0x7990:
> -		return MT7996_EEPROM_DEFAULT;
>  	case 0x7992:
> -		return MT7992_EEPROM_DEFAULT;
> +		switch (dev->var.type) {
> +		case MT7992_VAR_TYPE_23:
> +			if (dev->var.fem == MT7996_FEM_INT)
> +				return MT7992_EEPROM_DEFAULT_23_INT;
> +			return MT7992_EEPROM_DEFAULT_23;
> +		case MT7992_VAR_TYPE_44:
> +		default:
> +			if (dev->var.fem == MT7996_FEM_INT)
> +				return MT7992_EEPROM_DEFAULT_INT;
> +			if (dev->var.fem == MT7996_FEM_MIX)
> +				return MT7992_EEPROM_DEFAULT_MIX;
> +			return MT7992_EEPROM_DEFAULT;
> +		}
> +	case 0x7990:
> +	default:
> +		switch (dev->var.type) {
> +		case MT7996_VAR_TYPE_233:
> +			if (dev->var.fem == MT7996_FEM_INT)
> +				return MT7996_EEPROM_DEFAULT_233_INT;
> +			return MT7996_EEPROM_DEFAULT_233;
> +		case MT7996_VAR_TYPE_444:
> +		default:
> +			if (dev->var.fem == MT7996_FEM_INT)
> +				return MT7996_EEPROM_DEFAULT_INT;
> +			return MT7996_EEPROM_DEFAULT;
> +		}
> +	}
> +}
> +
> +static void
> +mt7996_eeprom_parse_stream(const u8 *eeprom, u8 band_idx, u8 *path,
> +			   u8 *rx_path, u8 *nss)
> +{
> +	switch (band_idx) {
> +	case MT_BAND1:
> +		*path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND1,
> +				  eeprom[MT_EE_WIFI_CONF + 2]);
> +		*rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND1,
> +				     eeprom[MT_EE_WIFI_CONF + 3]);
> +		*nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND1,
> +				 eeprom[MT_EE_WIFI_CONF + 5]);
> +		break;
> +	case MT_BAND2:
> +		*path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND2,
> +				  eeprom[MT_EE_WIFI_CONF + 2]);
> +		*rx_path = FIELD_GET(MT_EE_WIFI_CONF4_RX_PATH_BAND2,
> +				     eeprom[MT_EE_WIFI_CONF + 4]);
> +		*nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND2,
> +				 eeprom[MT_EE_WIFI_CONF + 5]);
> +		break;
>  	default:
> -		return MT7996_EEPROM_DEFAULT;
> +		*path = FIELD_GET(MT_EE_WIFI_CONF1_TX_PATH_BAND0,
> +				  eeprom[MT_EE_WIFI_CONF + 1]);
> +		*rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND0,
> +				     eeprom[MT_EE_WIFI_CONF + 3]);
> +		*nss = FIELD_GET(MT_EE_WIFI_CONF4_STREAM_NUM_BAND0,
> +				 eeprom[MT_EE_WIFI_CONF + 4]);
> +		break;
>  	}
>  }
>  
> +static bool mt7996_eeprom_variant_valid(struct mt7996_dev *dev, const u8 *def)
> +{
> +#define FEM_INT	0
> +#define FEM_EXT	3
> +	u8 *eeprom = dev->mt76.eeprom.data, fem[2];
> +	int i;
> +
> +	for (i = 0; i < 2; i++)
> +		fem[i] = u8_get_bits(eeprom[MT_EE_WIFI_CONF + 6 + i],
> +				     MT_EE_WIFI_PA_LNA_CONFIG);
> +
> +	if (dev->var.fem == MT7996_FEM_EXT &&
> +	    !(fem[0] == FEM_EXT && fem[1] == FEM_EXT))
> +		return false;
> +	else if (dev->var.fem == MT7996_FEM_INT &&
> +		 !(fem[0] == FEM_INT && fem[1] == FEM_INT))
> +		return false;
> +	else if (dev->var.fem == MT7996_FEM_MIX &&
> +		 !(fem[0] == FEM_INT && fem[1] == FEM_EXT))
> +		return false;
> +
> +	for (i = 0; i < __MT_MAX_BAND; i++) {
> +		u8 path, rx_path, nss;
> +		u8 def_path, def_rx_path, def_nss;
> +
> +		if (!dev->mt76.phys[i])
> +			continue;
> +
> +		mt7996_eeprom_parse_stream(eeprom, i, &path, &rx_path, &nss);
> +		mt7996_eeprom_parse_stream(def, i, &def_path, &def_rx_path,
> +					   &def_nss);
> +		if (path > def_path || rx_path > def_rx_path || nss > def_nss)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int
> -mt7996_eeprom_load_default(struct mt7996_dev *dev)
> +mt7996_eeprom_check_or_use_default(struct mt7996_dev *dev, bool use_default)
>  {
>  	u8 *eeprom = dev->mt76.eeprom.data;
>  	const struct firmware *fw = NULL;
> @@ -51,6 +142,10 @@ mt7996_eeprom_load_default(struct mt7996_dev *dev)
>  		goto out;
>  	}
>  
> +	if (!use_default && mt7996_eeprom_variant_valid(dev, fw->data))
> +		goto out;
> +
> +	dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
>  	memcpy(eeprom, fw->data, MT7996_EEPROM_SIZE);
>  	dev->flash_mode = true;
>  
> @@ -62,48 +157,68 @@ mt7996_eeprom_load_default(struct mt7996_dev *dev)
>  
>  static int mt7996_eeprom_load(struct mt7996_dev *dev)
>  {
> +	bool use_default = false;
>  	int ret;
>  
>  	ret = mt76_eeprom_init(&dev->mt76, MT7996_EEPROM_SIZE);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret) {
> +	if (ret && !mt7996_check_eeprom(dev)) {
>  		dev->flash_mode = true;
> -	} else {
> -		u8 free_block_num;
> -		u32 block_num, i;
> +		goto out;
> +	}
> +
> +	if (!dev->flash_mode) {
>  		u32 eeprom_blk_size = MT7996_EEPROM_BLOCK_SIZE;
> +		u32 block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
> +		u8 free_block_num;
> +		int i;
>  
> +		memset(dev->mt76.eeprom.data, 0, MT7996_EEPROM_SIZE);
>  		ret = mt7996_mcu_get_eeprom_free_block(dev, &free_block_num);
>  		if (ret < 0)
>  			return ret;
>  
>  		/* efuse info isn't enough */
> -		if (free_block_num >= 59)
> -			return -EINVAL;
> +		if (free_block_num >= 59) {
> +			use_default = true;
> +			goto out;
> +		}
> +
> +		/* check if eeprom data from fw is valid */
> +		if (mt7996_mcu_get_eeprom(dev, 0, NULL, 0) ||
> +		    mt7996_check_eeprom(dev)) {
> +			use_default = true;
> +			goto out;
> +		}
>  
> -		/* read eeprom data from efuse */
> -		block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
> -		for (i = 0; i < block_num; i++) {
> +		/* read eeprom data from fw */
> +		for (i = 1; i < block_num; i++) {
>  			u32 len = eeprom_blk_size;
>  
>  			if (i == block_num - 1)
>  				len = MT7996_EEPROM_SIZE % eeprom_blk_size;
>  			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size,
>  						    NULL, len);
> -			if (ret && ret != -EINVAL)
> -				return ret;
> +			if (ret && ret != -EINVAL) {
> +				use_default = true;
> +				goto out;
> +			}
>  		}
>  	}
>  
> -	return mt7996_check_eeprom(dev);
> +out:
> +	return mt7996_eeprom_check_or_use_default(dev, use_default);
>  }
>  
> -static int mt7996_eeprom_parse_efuse_hw_cap(struct mt7996_dev *dev)
> +static int mt7996_eeprom_parse_efuse_hw_cap(struct mt7996_phy *phy,
> +					    u8 *path, u8 *rx_path, u8 *nss)
>  {
>  #define MODE_HE_ONLY		BIT(0)
>  #define WTBL_SIZE_GROUP		GENMASK(31, 28)
> +#define STREAM_CAP(_offs)	((cap & (0x7 << (_offs))) >> (_offs))
> +	struct mt7996_dev *dev = phy->dev;
>  	u32 cap = 0;
>  	int ret;
>  
> @@ -112,13 +227,17 @@ static int mt7996_eeprom_parse_efuse_hw_cap(struct mt7996_dev *dev)
>  		return ret;
>  
>  	if (cap) {
> +		u8 band_offs = phy->mt76->band_idx * 3;
> +
>  		dev->has_eht = !(cap & MODE_HE_ONLY);
>  		dev->wtbl_size_group = u32_get_bits(cap, WTBL_SIZE_GROUP);
> +		*nss = min_t(u8, *nss, STREAM_CAP(1 + band_offs));
> +		*path = min_t(u8, *path, STREAM_CAP(10 + band_offs));
> +		*rx_path = min_t(u8, *rx_path, STREAM_CAP(19 + band_offs));
>  	}
>  
> -	if (dev->wtbl_size_group < 2 || dev->wtbl_size_group > 4 ||
> -	    is_mt7992(&dev->mt76))
> -		dev->wtbl_size_group = 2; /* set default */
> +	if (dev->wtbl_size_group < 2 || dev->wtbl_size_group > 4)
> +		dev->wtbl_size_group = is_mt7996(&dev->mt76) ? 4 : 2;
>  
>  	return 0;
>  }
> @@ -168,32 +287,10 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
>  	int max_path = 5, max_nss = 4;
>  	int ret;
>  
> -	switch (band_idx) {
> -	case MT_BAND1:
> -		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND1,
> -				 eeprom[MT_EE_WIFI_CONF + 2]);
> -		rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND1,
> -				    eeprom[MT_EE_WIFI_CONF + 3]);
> -		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND1,
> -				eeprom[MT_EE_WIFI_CONF + 5]);
> -		break;
> -	case MT_BAND2:
> -		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND2,
> -				 eeprom[MT_EE_WIFI_CONF + 2]);
> -		rx_path = FIELD_GET(MT_EE_WIFI_CONF4_RX_PATH_BAND2,
> -				    eeprom[MT_EE_WIFI_CONF + 4]);
> -		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND2,
> -				eeprom[MT_EE_WIFI_CONF + 5]);
> -		break;
> -	default:
> -		path = FIELD_GET(MT_EE_WIFI_CONF1_TX_PATH_BAND0,
> -				 eeprom[MT_EE_WIFI_CONF + 1]);
> -		rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND0,
> -				    eeprom[MT_EE_WIFI_CONF + 3]);
> -		nss = FIELD_GET(MT_EE_WIFI_CONF4_STREAM_NUM_BAND0,
> -				eeprom[MT_EE_WIFI_CONF + 4]);
> -		break;
> -	}
> +	mt7996_eeprom_parse_stream(eeprom, band_idx, &path, &rx_path, &nss);
> +	ret = mt7996_eeprom_parse_efuse_hw_cap(phy, &path, &rx_path, &nss);
> +	if (ret)
> +		return ret;
>  
>  	if (!path || path > max_path)
>  		path = max_path;
> @@ -213,10 +310,6 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
>  		dev->chainshift[band_idx + 1] = dev->chainshift[band_idx] +
>  						hweight16(mphy->chainmask);
>  
> -	ret = mt7996_eeprom_parse_efuse_hw_cap(dev);
> -	if (ret)
> -		return ret;
> -
>  	return mt7996_eeprom_parse_band_config(phy);
>  }
>  
> @@ -225,15 +318,8 @@ int mt7996_eeprom_init(struct mt7996_dev *dev)
>  	int ret;
>  
>  	ret = mt7996_eeprom_load(dev);
> -	if (ret < 0) {
> -		if (ret != -EINVAL)
> -			return ret;
> -
> -		dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
> -		ret = mt7996_eeprom_load_default(dev);
> -		if (ret)
> -			return ret;
> -	}
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = mt7996_eeprom_parse_hw_cap(dev, &dev->phy);
>  	if (ret < 0)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
> index 412d6e2f8014..7a771ca2434c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
> @@ -40,6 +40,8 @@ enum mt7996_eeprom_field {
>  #define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(2, 0)
>  #define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(5, 3)
>  
> +#define MT_EE_WIFI_PA_LNA_CONFIG		GENMASK(1, 0)
> +
>  #define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
>  #define MT_EE_RATE_DELTA_SIGN			BIT(6)
>  #define MT_EE_RATE_DELTA_EN			BIT(7)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> index 5e96973226bb..bf70799b4bc4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -884,6 +884,76 @@ static void mt7996_wed_rro_work(struct work_struct *work)
>  #endif
>  }
>  
> +static int mt7996_variant_type_init(struct mt7996_dev *dev)
> +{
> +	u32 val = mt76_rr(dev, MT_PAD_GPIO);
> +	u8 var_type;
> +
> +	switch (mt76_chip(&dev->mt76)) {
> +	case 0x7990:
> +		if (val & MT_PAD_GPIO_2ADIE_TBTC)
> +			var_type = MT7996_VAR_TYPE_233;
> +		else
> +			var_type = MT7996_VAR_TYPE_444;
> +		break;
> +	case 0x7992:
> +		if (val & MT_PAD_GPIO_ADIE_SINGLE)
> +			var_type = MT7992_VAR_TYPE_23;
> +		else if (u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992))
> +			var_type = MT7992_VAR_TYPE_44;
> +		else
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev->var.type = var_type;
> +	return 0;
> +}
> +
> +static int mt7996_variant_fem_init(struct mt7996_dev *dev)
> +{
> +#define MT7976C_EFUSE_OFFSET	0x470
> +	u8 buf[MT7996_EEPROM_BLOCK_SIZE], idx, adie_idx, adie_comb;
> +	u32 regval, val = mt76_rr(dev, MT_PAD_GPIO);
> +	u16 adie_id, adie_ver;
> +	bool is_7976c;
> +	int ret;
> +
> +	if (is_mt7992(&dev->mt76)) {
> +		adie_idx = (val & MT_PAD_GPIO_ADIE_SINGLE) ? 0 : 1;
> +		adie_comb = u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992);
> +	} else {
> +		adie_idx = 0;
> +		adie_comb = u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB);
> +	}
> +
> +	ret = mt7996_mcu_rf_regval(dev, MT_ADIE_CHIP_ID(adie_idx), &regval, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = mt7996_mcu_get_eeprom(dev, MT7976C_EFUSE_OFFSET, buf, sizeof(buf));
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +
> +	adie_ver = u32_get_bits(regval, MT_ADIE_VERSION_MASK);
> +	idx = MT7976C_EFUSE_OFFSET % MT7996_EEPROM_BLOCK_SIZE;
> +	is_7976c = adie_ver == 0x8a10 || adie_ver == 0x8b00 ||
> +		   adie_ver == 0x8c10 || buf[idx] == 0xc;
> +
> +	adie_id = u32_get_bits(regval, MT_ADIE_CHIP_ID_MASK);
> +	if (adie_id == 0x7975 || adie_id == 0x7979 ||
> +	    (adie_id == 0x7976 && is_7976c))
> +		dev->var.fem = MT7996_FEM_INT;
> +	else if (adie_id == 0x7977 && adie_comb == 1)
> +		dev->var.fem = MT7996_FEM_MIX;
> +	else
> +		dev->var.fem = MT7996_FEM_EXT;
> +
> +	return 0;
> +}
> +
>  static int mt7996_init_hardware(struct mt7996_dev *dev)
>  {
>  	int ret, idx;
> @@ -899,6 +969,10 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
>  	INIT_LIST_HEAD(&dev->wed_rro.poll_list);
>  	spin_lock_init(&dev->wed_rro.lock);
>  
> +	ret = mt7996_variant_type_init(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = mt7996_dma_init(dev);
>  	if (ret)
>  		return ret;
> @@ -913,6 +987,10 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = mt7996_variant_fem_init(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = mt7996_eeprom_init(dev);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index fa7832f625d7..83bbdece45df 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -14,11 +14,23 @@
>  	char *_fw;						\
>  	switch (mt76_chip(&(_dev)->mt76)) {			\
>  	case 0x7992:						\
> -		_fw = MT7992_##name;				\
> +		switch ((_dev)->var.type) {			\
> +		case MT7992_VAR_TYPE_23:			\
> +			_fw = MT7992_##name##_23;		\
> +			break;					\
> +		default:					\
> +			_fw = MT7992_##name;			\
> +		}						\
>  		break;						\
>  	case 0x7990:						\
>  	default:						\
> -		_fw = MT7996_##name;				\
> +		switch ((_dev)->var.type) {			\
> +		case MT7996_VAR_TYPE_233:			\
> +			_fw = MT7996_##name##_233;		\
> +			break;					\
> +		default:					\
> +			_fw = MT7996_##name;			\
> +		}						\
>  		break;						\
>  	}							\
>  	_fw;							\
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 55aa5f6ab77d..3f3278f43c79 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -34,13 +34,32 @@
>  #define MT7996_FIRMWARE_DSP		"mediatek/mt7996/mt7996_dsp.bin"
>  #define MT7996_ROM_PATCH		"mediatek/mt7996/mt7996_rom_patch.bin"
>  
> +#define MT7996_FIRMWARE_WA_233		"mediatek/mt7996/mt7996_wa_233.bin"
> +#define MT7996_FIRMWARE_WM_233		"mediatek/mt7996/mt7996_wm_233.bin"
> +#define MT7996_FIRMWARE_DSP_233		MT7996_FIRMWARE_DSP
> +#define MT7996_ROM_PATCH_233		"mediatek/mt7996/mt7996_rom_patch_233.bin"
> +
>  #define MT7992_FIRMWARE_WA		"mediatek/mt7996/mt7992_wa.bin"
>  #define MT7992_FIRMWARE_WM		"mediatek/mt7996/mt7992_wm.bin"
>  #define MT7992_FIRMWARE_DSP		"mediatek/mt7996/mt7992_dsp.bin"
>  #define MT7992_ROM_PATCH		"mediatek/mt7996/mt7992_rom_patch.bin"
>  
> +#define MT7992_FIRMWARE_WA_23		"mediatek/mt7996/mt7992_wa_23.bin"
> +#define MT7992_FIRMWARE_WM_23		"mediatek/mt7996/mt7992_wm_23.bin"
> +#define MT7992_FIRMWARE_DSP_23		"mediatek/mt7996/mt7992_dsp_23.bin"
> +#define MT7992_ROM_PATCH_23		"mediatek/mt7996/mt7992_rom_patch_23.bin"
> +
>  #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
> +#define MT7996_EEPROM_DEFAULT_INT	"mediatek/mt7996/mt7996_eeprom_2i5i6i.bin"
> +#define MT7996_EEPROM_DEFAULT_233	"mediatek/mt7996/mt7996_eeprom_233.bin"
> +#define MT7996_EEPROM_DEFAULT_233_INT	"mediatek/mt7996/mt7996_eeprom_233_2i5i6i.bin"
> +
>  #define MT7992_EEPROM_DEFAULT		"mediatek/mt7996/mt7992_eeprom.bin"
> +#define MT7992_EEPROM_DEFAULT_INT	"mediatek/mt7996/mt7992_eeprom_2i5i.bin"
> +#define MT7992_EEPROM_DEFAULT_MIX	"mediatek/mt7996/mt7992_eeprom_2i5e.bin"
> +#define MT7992_EEPROM_DEFAULT_23	"mediatek/mt7996/mt7992_eeprom_23.bin"
> +#define MT7992_EEPROM_DEFAULT_23_INT	"mediatek/mt7996/mt7992_eeprom_23_2i5i.bin"
> +
>  #define MT7996_EEPROM_SIZE		7680
>  #define MT7996_EEPROM_BLOCK_SIZE	16
>  #define MT7996_TOKEN_SIZE		16384
> @@ -95,6 +114,22 @@ enum mt7996_ram_type {
>  	MT7996_RAM_TYPE_DSP,
>  };
>  
> +enum mt7996_var_type {
> +	MT7996_VAR_TYPE_444,
> +	MT7996_VAR_TYPE_233,
> +};
> +
> +enum mt7992_var_type {
> +	MT7992_VAR_TYPE_44,
> +	MT7992_VAR_TYPE_23,
> +};
> +
> +enum mt7996_fem_type {
> +	MT7996_FEM_EXT,
> +	MT7996_FEM_INT,
> +	MT7996_FEM_MIX,
> +};
> +
>  enum mt7996_txq_id {
>  	MT7996_TXQ_FWDL = 16,
>  	MT7996_TXQ_MCU_WM,
> @@ -329,6 +364,10 @@ struct mt7996_dev {
>  	spinlock_t reg_lock;
>  
>  	u8 wtbl_size_group;
> +	struct {
> +		u8 type:4;
> +		u8 fem:4;
> +	} var;
>  };
>  
>  enum {
> @@ -405,12 +444,7 @@ mt7996_band_valid(struct mt7996_dev *dev, u8 band)
>  	if (is_mt7992(&dev->mt76))
>  		return band <= MT_BAND1;
>  
> -	/* tri-band support */
> -	if (band <= MT_BAND2 &&
> -	    mt76_get_field(dev, MT_PAD_GPIO, MT_PAD_GPIO_ADIE_COMB) <= 1)
> -		return true;
> -
> -	return band == MT_BAND0 || band == MT_BAND2;
> +	return band <= MT_BAND2;
>  }
>  
>  extern const struct ieee80211_ops mt7996_ops;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
> index 47b429d8bfbe..06e307b5b02e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
> @@ -660,8 +660,17 @@ enum offs_rev {
>  #define MT_TOP_MISC				MT_TOP(0xf0)
>  #define MT_TOP_MISC_FW_STATE			GENMASK(2, 0)
>  
> +/* ADIE */
> +#define MT_ADIE_CHIP_ID(_idx)			(0x0f00002c + ((_idx) << 28))
> +#define MT_ADIE_VERSION_MASK			GENMASK(15, 0)
> +#define MT_ADIE_CHIP_ID_MASK			GENMASK(31, 16)
> +
>  #define MT_PAD_GPIO				0x700056f0
>  #define MT_PAD_GPIO_ADIE_COMB			GENMASK(16, 15)
> +#define MT_PAD_GPIO_2ADIE_TBTC			BIT(19)
> +/* for mt7992 */
> +#define MT_PAD_GPIO_ADIE_COMB_7992		GENMASK(17, 16)
> +#define MT_PAD_GPIO_ADIE_SINGLE			BIT(15)
>  
>  #define MT_HW_REV				0x70010204
>  #define MT_HW_REV1				0x8a00
> -- 
> 2.39.2
> 

