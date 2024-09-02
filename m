Return-Path: <linux-wireless+bounces-12334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682F96836E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F4B1C222EE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CEC1D2797;
	Mon,  2 Sep 2024 09:38:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AF18661C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269900; cv=none; b=ZCa/eBkWEUB+gCF/yKewnAM39DPBQZ4Gv2WlAc39ob6kogI+2nGUgZS5Esrdd6+sOsRNQlZG0OUQRZTNYhFKXiJ9oESpDZWt1EohicRnmhgnpETTeiY8z8PtKFqLuuTvskuikdQ5XiztNQI4uuUT56YbvwJcP+SmRfSeRoXeoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269900; c=relaxed/simple;
	bh=dLzr0c/PZntjBpHySEmFS2LU4eZWwLlzvHOPTF+fi7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WENptU9XY2wMYcEJ0+DhCn4BtgZlooookv7tcFTzQXn7J7HKovfZYJA2dPBBTzDpGxIqw8WTHhoXRgJFN/05+7qotLue/IwJdzRnxRNUxwnsEP9KQ3yXKKI0O5ZXgAKgxRTmaapN0RvMZT+FiEBqd2aD9ccwGpoZIM8rjJUxexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sl3Vl-0003zW-QR; Mon, 02 Sep 2024 11:38:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sl3Vl-004s3f-5P; Mon, 02 Sep 2024 11:38:13 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sl3Vl-002X0H-0C;
	Mon, 02 Sep 2024 11:38:13 +0200
Date: Mon, 2 Sep 2024 11:38:13 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on different
 channel
Message-ID: <ZtWHhSQlPVMekW1I@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902084311.2607-1-yu-hao.lin@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> Current firmware doesn't support AP and STA running on different
> channels simultaneously.

As mentioned here:

https://lore.kernel.org/all/ZtGnWC7SPHt7Vbbp@pengutronix.de/

AP and STA can indeed have different channels when DRCS is enabled, so I
think you have to check this in your patch.

Maybe the same question here again: Wouldn't it make sense to enable
DRCS by default?

Sascha

> FW crash would occur in such case.
> This patch avoids the issue by disabling AP and STA to run on
> different channels.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
> 
> v2:
>    - clean up code.
> 
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
>  drivers/net/wireless/marvell/mwifiex/util.c   | 44 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
>  3 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 722ead51e912..3dbcab463445 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>  		break;
>  
>  	case MWIFIEX_BSS_ROLE_STA:
> -		if (priv->media_connected) {
> -			mwifiex_dbg(adapter, ERROR,
> -				    "cannot change wiphy params when connected");
> -			return -EINVAL;
> -		}
> +		if (priv->media_connected)
> +			break;
> +
>  		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
>  			ret = mwifiex_set_rts(priv,
>  					      wiphy->rts_threshold);
> @@ -2069,6 +2067,9 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
>  	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
>  		return -1;
>  
> +	if (!mwifiex_is_channel_setting_allowable(priv, params->chandef.chan))
> +		return -EOPNOTSUPP;
> +
>  	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
>  	if (!bss_cfg)
>  		return -ENOMEM;
> @@ -2463,6 +2464,9 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
>  		return -EFAULT;
>  	}
>  
> +	if (!mwifiex_is_channel_setting_allowable(priv, sme->channel))
> +		return -EOPNOTSUPP;
> +
>  	mwifiex_dbg(adapter, INFO,
>  		    "info: Trying to associate to bssid %pM\n", sme->bssid);
>  
> @@ -4298,6 +4302,9 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
>  		return -EINVAL;
>  	}
>  
> +	if (!mwifiex_is_channel_setting_allowable(priv, req->bss->channel))
> +		return -EOPNOTSUPP;
> +
>  	if (priv->auth_alg != WLAN_AUTH_SAE &&
>  	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
>  		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 42c04bf858da..6512562c9fb4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -323,6 +323,50 @@ int mwifiex_debug_info_to_buffer(struct mwifiex_private *priv, char *buf,
>  	return p - buf;
>  }
>  
> +bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
> +					  struct ieee80211_channel *check_chan)
> +{
> +	struct mwifiex_adapter *adapter = priv->adapter;
> +	int i;
> +	struct mwifiex_private *tmp_priv;
> +	u8 bss_role = GET_BSS_ROLE(priv);
> +	struct ieee80211_channel *set_chan;
> +
> +	for (i = 0; i < MWIFIEX_MAX_BSS_NUM; i++) {
> +		tmp_priv = adapter->priv[i];
> +		if (tmp_priv == priv)
> +			continue;
> +
> +		set_chan = NULL;
> +		if (bss_role == MWIFIEX_BSS_ROLE_STA) {
> +			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_UAP &&
> +			    netif_carrier_ok(tmp_priv->netdev) &&
> +			    cfg80211_chandef_valid(&tmp_priv->bss_chandef))
> +				set_chan = tmp_priv->bss_chandef.chan;
> +		} else if (bss_role == MWIFIEX_BSS_ROLE_UAP) {
> +			struct mwifiex_current_bss_params *bss_params =
> +				&tmp_priv->curr_bss_params;
> +			int channel = bss_params->bss_descriptor.channel;
> +			enum nl80211_band band =
> +				mwifiex_band_to_radio_type(bss_params->band);
> +			int freq =
> +				ieee80211_channel_to_frequency(channel, band);
> +
> +			if (GET_BSS_ROLE(tmp_priv) == MWIFIEX_BSS_ROLE_STA &&
> +			    tmp_priv->media_connected)
> +				set_chan = ieee80211_get_channel(adapter->wiphy, freq);
> +		}
> +
> +		if (set_chan && !ieee80211_channel_equal(check_chan, set_chan)) {
> +			mwifiex_dbg(adapter, ERROR,
> +				    "AP/STA must run on the same channel\n");
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static int
>  mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
>  			  struct rxpd *rx_pd)
> diff --git a/drivers/net/wireless/marvell/mwifiex/util.h b/drivers/net/wireless/marvell/mwifiex/util.h
> index 4699c505c0a0..16f092bb0823 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.h
> +++ b/drivers/net/wireless/marvell/mwifiex/util.h
> @@ -86,4 +86,17 @@ static inline void le16_unaligned_add_cpu(__le16 *var, u16 val)
>  	put_unaligned_le16(get_unaligned_le16(var) + val, var);
>  }
>  
> +/* Current firmware doesn't support AP and STA running on different
> + * channels simultaneously in normal mode.
> + * FW crash would occur in such case.
> + * This function is used to check if check_chan can be set to FW or not.
> + *
> + * Return:
> + * %true if check_chan can be set to FW without issues.
> + * %false there is already other channel is set to FW, setting of
> + * check_chan is not allowable.
> + */
> +bool mwifiex_is_channel_setting_allowable(struct mwifiex_private *priv,
> +					  struct ieee80211_channel *check_chan);
> +
>  #endif /* !_MWIFIEX_UTIL_H_ */
> 
> base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

