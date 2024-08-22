Return-Path: <linux-wireless+bounces-11779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF995AD0D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 07:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E321F212C8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D7524B0;
	Thu, 22 Aug 2024 05:48:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3A23CB
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305728; cv=none; b=aEubM0nYOvbFiZJehsbVinFz9b4Z2C3dUYEHN017hN1eOMShDgUuCuLXdGnPcbL3zWVxgZFOJsL/Eu4xXNtCfG4uJurPKmOtFubOLKfpwaOkVywcOZXIg6HBDWMorfkkgzCBYh3mCV5HgDXey64DhQpcYMaw59uoBxCPKpt7P/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305728; c=relaxed/simple;
	bh=V0LUbOaO3v7lTyCiSKCdTYpHtZqEnaKEO527s/vOQ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beuXIVFkWlNE8qlA09zd+H8o660E5IoaYvnbtir8s95qWNDvlPuKlD4Hm3q62A7Y4x8uUaCho2k4p6+o0xevXm2jr5/NQjE1sObKYUkHuY621FhHojQ8KS0m20Kc+nYoWcrSpoYpLkSu3uOutSdZLHvGyMgnIHfDh8JBMIhrIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sh0gY-00019z-B4; Thu, 22 Aug 2024 07:48:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sh0gX-002B5M-K2; Thu, 22 Aug 2024 07:48:37 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sh0gX-00HGYp-1f;
	Thu, 22 Aug 2024 07:48:37 +0200
Date: Thu, 22 Aug 2024 07:48:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 11/31] wifi: mwifiex: use priv index as bss_num
Message-ID: <ZsbRNbcq6tBeKPID@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-11-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-11-320d8de4a4b7@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2024 at 01:55:36PM +0200, Sascha Hauer wrote:
> Instead of looking up an unused bss_num each time we add a virtual
> interface, associate a fixed bss_num to each priv and for simplicity
> just use the array index.
> 
> With bss_num unique to each priv mwifiex_get_priv_by_id() doesn't need
> the bss_type argument anymore, so it's removed.

I misunderstood the driver here. I thought bss_num specifies the
instance and bss_type specifies the type of this instance. It's the
other way round: bss_num is the nth instance of type bss_type. Also
the device doesn't have 16 instances of configurable type, instead
it only has 1 station mode instance. Hence, when
bss_type == MWIFIEX_BSS_TYPE_STA every other bss_num than 0 is invalid.
Likewise there are also only three instances of type
MWIFIEX_BSS_TYPE_UAP available.

I made some assumptions on this misunderstanding throughout this series,
so it needs rework.

It would be really great to have some documentation about these devices.

Sascha

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c  | 11 ++---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c    |  6 +--
>  drivers/net/wireless/marvell/mwifiex/main.c      |  1 +
>  drivers/net/wireless/marvell/mwifiex/main.h      | 54 ++++--------------------
>  drivers/net/wireless/marvell/mwifiex/sta_event.c |  3 +-
>  drivers/net/wireless/marvell/mwifiex/txrx.c      |  9 ++--
>  6 files changed, 19 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 784f342a9bf23..d5a2c8f726b9e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -952,8 +952,6 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
> -
>  	spin_lock_irqsave(&adapter->main_proc_lock, flags);
>  	adapter->main_locked = false;
>  	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> @@ -2999,8 +2997,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> -		priv = mwifiex_get_unused_priv_by_bss_type(
> -						adapter, MWIFIEX_BSS_TYPE_STA);
> +		priv = mwifiex_get_unused_priv(adapter);
>  		if (!priv) {
>  			mwifiex_dbg(adapter, ERROR,
>  				    "could not get free private struct\n");
> @@ -3029,8 +3026,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> -		priv = mwifiex_get_unused_priv_by_bss_type(
> -						adapter, MWIFIEX_BSS_TYPE_UAP);
> +		priv = mwifiex_get_unused_priv(adapter);
>  		if (!priv) {
>  			mwifiex_dbg(adapter, ERROR,
>  				    "could not get free private struct\n");
> @@ -3056,8 +3052,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EINVAL);
>  		}
>  
> -		priv = mwifiex_get_unused_priv_by_bss_type(
> -						adapter, MWIFIEX_BSS_TYPE_P2P);
> +		priv = mwifiex_get_unused_priv(adapter);
>  		if (!priv) {
>  			mwifiex_dbg(adapter, ERROR,
>  				    "could not get free private struct\n");
> diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> index 4f814110f750e..d91351384c6bb 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> @@ -496,8 +496,7 @@ int mwifiex_process_event(struct mwifiex_adapter *adapter)
>  							(u16) eventcause;
>  
>  	/* Get BSS number and corresponding priv */
> -	priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause),
> -				      EVENT_GET_BSS_TYPE(eventcause));
> +	priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause));
>  	if (!priv)
>  		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
>  
> @@ -847,8 +846,7 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
>  
>  	/* Get BSS number and corresponding priv */
>  	priv = mwifiex_get_priv_by_id(adapter,
> -			     HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)),
> -			     HostCmd_GET_BSS_TYPE(le16_to_cpu(resp->seq_num)));
> +			     HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)));
>  	if (!priv)
>  		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
>  	/* Clear RET_BIT from HostCmd */
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index 7cb90a6a8ccab..888f2801d6f2a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -85,6 +85,7 @@ static int mwifiex_register(void *card, struct device *dev,
>  		if (!adapter->priv[i])
>  			goto error;
>  
> +		adapter->priv[i]->bss_num = i;
>  		adapter->priv[i]->adapter = adapter;
>  		adapter->priv_num++;
>  	}
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
> index 541bc50a9561c..2938e55a38d79 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -1297,20 +1297,12 @@ mwifiex_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
>   * upon the BSS type and BSS number.
>   */
>  static inline struct mwifiex_private *
> -mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
> -		       u8 bss_num, u8 bss_type)
> +mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter, u8 bss_num)
>  {
> -	int i;
> -
> -	for (i = 0; i < adapter->priv_num; i++) {
> -		if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
> -			continue;
> +	if (bss_num >= MWIFIEX_MAX_BSS_NUM)
> +		return NULL;
>  
> -		if ((adapter->priv[i]->bss_num == bss_num) &&
> -		    (adapter->priv[i]->bss_type == bss_type))
> -			break;
> -	}
> -	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
> +	return adapter->priv[bss_num];
>  }
>  
>  /*
> @@ -1332,47 +1324,19 @@ mwifiex_get_priv(struct mwifiex_adapter *adapter,
>  	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
>  }
>  
> -/*
> - * This function checks available bss_num when adding new interface or
> - * changing interface type.
> - */
> -static inline u8
> -mwifiex_get_unused_bss_num(struct mwifiex_adapter *adapter, u8 bss_type)
> -{
> -	u8 i, j;
> -	int index[MWIFIEX_MAX_BSS_NUM];
> -
> -	memset(index, 0, sizeof(index));
> -	for (i = 0; i < adapter->priv_num; i++)
> -		if (adapter->priv[i]->bss_type == bss_type &&
> -		    !(adapter->priv[i]->bss_mode ==
> -		      NL80211_IFTYPE_UNSPECIFIED)) {
> -			index[adapter->priv[i]->bss_num] = 1;
> -		}
> -	for (j = 0; j < MWIFIEX_MAX_BSS_NUM; j++)
> -		if (!index[j])
> -			return j;
> -	return -1;
> -}
> -
>  /*
>   * This function returns the first available unused private structure pointer.
>   */
>  static inline struct mwifiex_private *
> -mwifiex_get_unused_priv_by_bss_type(struct mwifiex_adapter *adapter,
> -				    u8 bss_type)
> +mwifiex_get_unused_priv(struct mwifiex_adapter *adapter)
>  {
> -	u8 i;
> +	int i;
>  
>  	for (i = 0; i < adapter->priv_num; i++)
> -		if (adapter->priv[i]->bss_mode ==
> -		   NL80211_IFTYPE_UNSPECIFIED) {
> -			adapter->priv[i]->bss_num =
> -			mwifiex_get_unused_bss_num(adapter, bss_type);
> -			break;
> -		}
> +		if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
> +			return adapter->priv[i];
>  
> -	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
> +	return NULL;
>  }
>  
>  /*
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> index b5f3821a6a8f2..15f057d010a3d 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -456,8 +456,7 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
>  		for (i = 0; i < intf_num; i++) {
>  			bss_type = grp_info->bss_type_numlist[i] >> 4;
>  			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
> -			intf_priv = mwifiex_get_priv_by_id(adapter, bss_num,
> -							   bss_type);
> +			intf_priv = mwifiex_get_priv_by_id(adapter, bss_num);
>  			if (!intf_priv) {
>  				mwifiex_dbg(adapter, ERROR,
>  					    "Invalid bss_type bss_num\t"
> diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
> index f44e22f245110..21cfee3290377 100644
> --- a/drivers/net/wireless/marvell/mwifiex/txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
> @@ -31,8 +31,7 @@ int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
>  
>  	local_rx_pd = (struct rxpd *) (skb->data);
>  	/* Get the BSS number from rxpd, get corresponding priv */
> -	priv = mwifiex_get_priv_by_id(adapter, local_rx_pd->bss_num &
> -				      BSS_NUM_MASK, local_rx_pd->bss_type);
> +	priv = mwifiex_get_priv_by_id(adapter, local_rx_pd->bss_num & BSS_NUM_MASK);
>  	if (!priv)
>  		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
>  
> @@ -165,8 +164,7 @@ static int mwifiex_host_to_card(struct mwifiex_adapter *adapter,
>  	struct mwifiex_txinfo *tx_info;
>  
>  	tx_info = MWIFIEX_SKB_TXCB(skb);
> -	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num,
> -				      tx_info->bss_type);
> +	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num);
>  	if (!priv) {
>  		mwifiex_dbg(adapter, ERROR,
>  			    "data: priv not found. Drop TX packet\n");
> @@ -281,8 +279,7 @@ int mwifiex_write_data_complete(struct mwifiex_adapter *adapter,
>  		return 0;
>  
>  	tx_info = MWIFIEX_SKB_TXCB(skb);
> -	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num,
> -				      tx_info->bss_type);
> +	priv = mwifiex_get_priv_by_id(adapter, tx_info->bss_num);
>  	if (!priv)
>  		goto done;
>  
> 
> -- 
> 2.39.2
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

