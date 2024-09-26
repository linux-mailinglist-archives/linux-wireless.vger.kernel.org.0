Return-Path: <linux-wireless+bounces-13229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7500987541
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD01F21FB1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259C76410;
	Thu, 26 Sep 2024 14:14:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1577132139
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360068; cv=none; b=ZXe9hb9SkA7/M4l8WoWmTRFw12mv/e7h2C3g3+geb6cLqplZd5/1zLa1BRyFhNZNqkberbcL60FdgTSZWmBa/4zABsMxU5R5JLyeokBUNqp0GrodN2SrMeI9vbu+wEhcUi+sapc9Hyh3qRrvRYo5x8fWqyPji+TxvYFm2ziR7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360068; c=relaxed/simple;
	bh=5qjgyKQX5imT8lLPGmbDQkBwQkUHyzoTi2agIv5uHKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbRlPErw36vaV8SY5Mi+3XmjDLvpz4+QiVKs9lI1Bc/wPgH3SmdkE4sRXE3XUHi7IhdokvGHjBgtkY2nT+uilgd8JUUejX8UkeJeneKYKSSs2XYQiTyY+w43KUL7TBz1bvQLDTrL58SXfYu2p9KEWNxZGQGpCzOSM61mHDyhdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1stpGC-000000005kT-321X;
	Thu, 26 Sep 2024 14:14:24 +0000
Date: Thu, 26 Sep 2024 15:14:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH 3/3] wifi: mt76: mt7996: set correct background radar
 capability
Message-ID: <ZvVsPqwRdL5GltTX@makrotopia.org>
References: <20240926032440.15978-1-shayne.chen@mediatek.com>
 <20240926032440.15978-3-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926032440.15978-3-shayne.chen@mediatek.com>

On Thu, Sep 26, 2024 at 11:24:40AM +0800, Shayne Chen wrote:
> From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> 
> Some of the variants do not support background radar, so add a helper
> to report background radar capability.
> 
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Tested-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  .../net/wireless/mediatek/mt76/mt7996/init.c  |  7 ++++---
>  .../wireless/mediatek/mt76/mt7996/mt7996.h    | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> index bf70799b4bc4..f6a010b61a8a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -390,9 +390,10 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
>  
> -	if (!mdev->dev->of_node ||
> -	    !of_property_read_bool(mdev->dev->of_node,
> -				   "mediatek,disable-radar-background"))
> +	if (mt7996_has_background_radar(phy->dev) &&
> +	    (!mdev->dev->of_node ||
> +	     !of_property_read_bool(mdev->dev->of_node,
> +				    "mediatek,disable-radar-background")))
>  		wiphy_ext_feature_set(wiphy,
>  				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
>  
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 3f3278f43c79..9aec97dd81d9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -447,6 +447,25 @@ mt7996_band_valid(struct mt7996_dev *dev, u8 band)
>  	return band <= MT_BAND2;
>  }
>  
> +static inline bool
> +mt7996_has_background_radar(struct mt7996_dev *dev)
> +{
> +	switch (mt76_chip(&dev->mt76)) {
> +	case 0x7990:
> +		if (dev->var.type == MT7996_VAR_TYPE_233)
> +			return false;
> +		break;
> +	case 0x7992:
> +		if (dev->var.type == MT7992_VAR_TYPE_23)
> +			return false;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  extern const struct ieee80211_ops mt7996_ops;
>  extern struct pci_driver mt7996_pci_driver;
>  extern struct pci_driver mt7996_hif_driver;
> -- 
> 2.39.2
> 

