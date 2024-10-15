Return-Path: <linux-wireless+bounces-13960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59C99E3AD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2A2846DB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5E1E3790;
	Tue, 15 Oct 2024 10:21:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35F1D14FF
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987662; cv=none; b=K4kiYEDBrWgAXTuC7hI/SACN9zweikgMbiOG2qXgmwDhVdzey2syjbL8Nv2qQ98VFcviQ5meb+4SBdpDCAxw6fEF7yOjQ/tQPXQrUASmZoQZoLU0l2dWUIDZSFx1N6fkTIfPi/umpbIfGu/eO6npT6jucTW8OKdkKgxiipbH9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987662; c=relaxed/simple;
	bh=qFw4pwxpBpttm95Yafbw1L21sbIFCKSXOR9wwNVM6uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpI96DE/+o/TdABGo/TzEFnE+nnPml2sPDZeHue/a5ty1mFBGfQhazJY5/zTpniU40Hgc5GVzE7iw+xj4rHQ6i/wAVnAvVN1ptsJ8XQZRT0juAjem0L/oYbXn3pObqiFBmf/die96YCB4UkoPdqX2N3EiOBRI6GDzy80wjgmpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1t0efi-0003Hh-A6; Tue, 15 Oct 2024 12:20:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1t0efh-0020WR-Je; Tue, 15 Oct 2024 12:20:57 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1t0efh-00CdtB-1f;
	Tue, 15 Oct 2024 12:20:57 +0200
Date: Tue, 15 Oct 2024 12:20:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v3] wifi: mwifiex: avoid AP and STA running on different
 channel
Message-ID: <Zw5CCWsvyoIR_0Bl@pengutronix.de>
References: <20241008050405.6948-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008050405.6948-1-yu-hao.lin@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Oct 08, 2024 at 01:04:05PM +0800, David Lin wrote:
> Current firmware doesn't support AP and STA running on different
> channels simultaneously if DRCS is not enabled.
> FW crash would occur in such case.
> This patch avoids the issue by disabling AP and STA to run on
> different channels if DRCS is not running.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> 
> v3:
>    - add the check for DRCS mode.
>    - add clean comment for wiphy parameters setting.
> 
> v2:
>    - clean up code.
> 
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 32 +++++++++----
>  drivers/net/wireless/marvell/mwifiex/util.c   | 47 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.h   | 13 +++++
>  3 files changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index fca3eea7ee84..ebc891d5d6c6 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -746,13 +746,18 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>  
>  	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
>  
> +	/* Because wiphy parameters are global setting, the setting for
> +	 * the first interface will apply for other interfaces too.
> +	 * If AP and STA are running at same time, these parameters must
> +	 * be the same. If the first interface is running, it means wiphy
> +	 * parameters are already set. The second setting should be dropped
> +	 * without error return, otherwise AP and STA can't run at the same
> +	 * time if wiphy parameters are setting.
> +	 */
>  	switch (priv->bss_role) {
>  	case MWIFIEX_BSS_ROLE_UAP:
> -		if (priv->bss_started) {
> -			mwifiex_dbg(adapter, ERROR,
> -				    "cannot change wiphy params when bss started");
> -			return -EINVAL;
> -		}
> +		if (priv->bss_started)
> +			break;
>  
>  		bss_cfg = kzalloc(sizeof(*bss_cfg), GFP_KERNEL);
>  		if (!bss_cfg)
> @@ -781,11 +786,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
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
> @@ -2069,6 +2072,9 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
>  	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP)
>  		return -1;
>  
> +	if (!mwifiex_is_channel_setting_allowable(priv, params->chandef.chan))
> +		return -EOPNOTSUPP;
> +
>  	bss_cfg = kzalloc(sizeof(struct mwifiex_uap_bss_param), GFP_KERNEL);
>  	if (!bss_cfg)
>  		return -ENOMEM;
> @@ -2463,6 +2469,9 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
>  		return -EFAULT;
>  	}
>  
> +	if (!mwifiex_is_channel_setting_allowable(priv, sme->channel))
> +		return -EOPNOTSUPP;
> +
>  	mwifiex_dbg(adapter, INFO,
>  		    "info: Trying to associate to bssid %pM\n", sme->bssid);
>  
> @@ -4298,6 +4307,9 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
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
> index 42c04bf858da..da5eef7b1dec 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -323,6 +323,53 @@ int mwifiex_debug_info_to_buffer(struct mwifiex_private *priv, char *buf,
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
> +	if (adapter->drcs_enabled)
> +		return true;
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
> base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

