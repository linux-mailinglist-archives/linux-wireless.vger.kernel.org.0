Return-Path: <linux-wireless+bounces-13230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2142987597
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919DC286DED
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF532AF1C;
	Thu, 26 Sep 2024 14:27:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F5136357
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360822; cv=none; b=jkHtDZP6lTIrLMwEE2VYcXlmYlyAr0AinGz6nFxnvYbZ7qBp92u/T9NffOE+MJQskIVqwNerwhN8iVMErTSuKTZZfILoEksnK3IEM+ozK7sZjQUEFbQOD8zoFYeKF8jFIV8BUtpi5iIVobmqsOevPvzxONne3zrm0JzmYyawQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360822; c=relaxed/simple;
	bh=+UG6KlHn70G5XrAq/IXOtWSKOl2G6F3h3ODVWL6Urcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4IN7DhKalFWpyKBXAQ3MgbzQc1W7poWWbe1w/iaeXsqkEf+9mTdmY0PG664nVpcWE1HCJ3U6cNr0aHhnplGr0gS6re36M/SS0zb0Yy0DpRFoyqnLWv2aMvaijbrmxM73k7XC9MOogS3kODBIPOnv2jCX1pTAttWpDiVDRdjqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1stpFg-000000005jn-1lUu;
	Thu, 26 Sep 2024 14:13:52 +0000
Date: Thu, 26 Sep 2024 15:13:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7996: extend flexibility of
 mt7996_mcu_get_eeprom()
Message-ID: <ZvVsGKmHHX2q_HRx@makrotopia.org>
References: <20240926032440.15978-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926032440.15978-1-shayne.chen@mediatek.com>

On Thu, Sep 26, 2024 at 11:24:38AM +0800, Shayne Chen wrote:
> Support passing customized buffer pointer and length to
> mt7996_mcu_get_eeprom().
> 
> This is the preparation for adding more variants support which needs to
> prefetch FEM module from efuse, and also fixes potential OOB issue when
> reading the last efuse block.
> 
> Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |  9 +++++++--
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 14 ++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  2 +-
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> index 4a8237118287..861aba68a725 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> @@ -86,8 +86,13 @@ static int mt7996_eeprom_load(struct mt7996_dev *dev)
>  		/* read eeprom data from efuse */
>  		block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, eeprom_blk_size);
>  		for (i = 0; i < block_num; i++) {
> -			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size);
> -			if (ret < 0)
> +			u32 len = eeprom_blk_size;
> +
> +			if (i == block_num - 1)
> +				len = MT7996_EEPROM_SIZE % eeprom_blk_size;
> +			ret = mt7996_mcu_get_eeprom(dev, i * eeprom_blk_size,
> +						    NULL, len);
> +			if (ret && ret != -EINVAL)
>  				return ret;
>  		}
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> index 327337b31279..fa7832f625d7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -3548,7 +3548,7 @@ int mt7996_mcu_set_eeprom(struct mt7996_dev *dev)
>  				 &req, sizeof(req), true);
>  }
>  
> -int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
> +int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len)
>  {
>  	struct {
>  		u8 _rsv[4];
> @@ -3577,15 +3577,21 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset)
>  	valid = le32_to_cpu(*(__le32 *)(skb->data + 16));
>  	if (valid) {
>  		u32 addr = le32_to_cpu(*(__le32 *)(skb->data + 12));
> -		u8 *buf = (u8 *)dev->mt76.eeprom.data + addr;
> +
> +		if (!buf)
> +			buf = (u8 *)dev->mt76.eeprom.data + addr;
> +		if (!buf_len || buf_len > MT7996_EEPROM_BLOCK_SIZE)
> +			buf_len = MT7996_EEPROM_BLOCK_SIZE;
>  
>  		skb_pull(skb, 48);
> -		memcpy(buf, skb->data, MT7996_EEPROM_BLOCK_SIZE);
> +		memcpy(buf, skb->data, buf_len);
> +	} else {
> +		ret = -EINVAL;
>  	}
>  
>  	dev_kfree_skb(skb);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index ab8c9070630b..55aa5f6ab77d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -476,7 +476,7 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
>  int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
>  			       struct ieee80211_sta *sta, void *data, u32 field);
>  int mt7996_mcu_set_eeprom(struct mt7996_dev *dev);
> -int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset);
> +int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_len);
>  int mt7996_mcu_get_eeprom_free_block(struct mt7996_dev *dev, u8 *block_num);
>  int mt7996_mcu_get_chip_config(struct mt7996_dev *dev, u32 *cap);
>  int mt7996_mcu_set_ser(struct mt7996_dev *dev, u8 action, u8 set, u8 band);
> -- 
> 2.39.2
> 

