Return-Path: <linux-wireless+bounces-12785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDC974E94
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FC3B278FF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185A13C8F9;
	Wed, 11 Sep 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LZ2kboV8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188F42056;
	Wed, 11 Sep 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047171; cv=none; b=LgcoM8AcTVMr5yxrteNtt9SwL3Y9KTZgI/m9oqEnyHWk6Al4+C73KvxasfCNfkQhH8X/7YAtHrThTFLuDKrgi+VpIgvZTbzer4bhYbk0hZEj0mjRzU9HrzGSz8vdD46/i1jVoGmJVtUUJpv+1BPPcLtylNRR27kL9CpbFgYSybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047171; c=relaxed/simple;
	bh=UCWIcT1hicw3QKAr268MAqhOpZGRQBG4qEvdkbj8Ntw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7rODuo88XnEpX+jsqRuhkOci5vtNV7VoyvddwqS6vswrspSoq3mV17+e+F7eawGSs5q2H9ZnnM1ev9jT4nPrTGYuqWVP46MYjtVO7Vx1fE+de4rIdJhQ7/+kHAXYmW1wVSYqmzCQ3wexEPu9yLJcqdblUdO3hkW9Co4gHGKlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LZ2kboV8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EEDDE1F9ED;
	Wed, 11 Sep 2024 11:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1726047158;
	bh=WD/CfXAsNipf8GFvUMfBefQPXJHaGOD1RCoYpzcJRgI=;
	h=Received:From:To:Subject;
	b=LZ2kboV8K52uCcCi1w0wkCP7VL+tcUeHmxIcb/8R3w4s5AgunVTu60MMziss2hlOS
	 MDrjjoGc4SUfrI8X4w3FDGLVwmVq7sdcemGBA480wvCTiqCVhiHMpKq72RUBp3OFiv
	 AkEXcz2cVA2sxFJY9S42aEKPjTk2BADg6ewKmnoHu/yD0TLVlYldfDkAqq6U+udCye
	 EMQtAS4YzbU/2yUHi15DVwvQYDYm1COx9Ky3gpkJxEk9oQxaY3lRXoFKgUkW4pZhDG
	 8F1UE1lHYyFvG2TEyzmGLL3UK4oIszJAeMXQl20NxmnfKSdIdWuz5hjdLzY8HjPm2y
	 ypuzWZfcA0u2A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 8FFE97F96B; Wed, 11 Sep 2024 11:32:37 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:32:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>, l.stach@pengutronix.de
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS mode
Message-ID: <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830080719.826142-1-yu-hao.lin@nxp.com>

+Lucas (in case he missed this patch)

On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
> Firmware crashes when AP works on a DFS channel and radar detection occurs.
> This patch fixes the issue, also add "fake_radar_detect" entry to mimic
> radar detection for testing purpose.

Do we want such kind of "fake" code in the driver?

I do not agree that we mix an actual bug fix with additional testing code,
and if I understand correctly the commit message this is what we are doing
here.

BTW, I think you should elaborate more in the commit message
"This patch fixes the issue" to allow this patch to be reviewed.

With that said I had a quick look at the patch, I think that those points need
to be clarified before I can look more into it.

> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/11h.c    | 56 +++++++++++++++----
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 50 ++++++++---------
>  .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
>  .../net/wireless/marvell/mwifiex/debugfs.c    | 42 ++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
>  drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
>  6 files changed, 115 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
> index b90f922f1cdc..e7e7a154831f 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11h.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11h.c
> @@ -7,7 +7,7 @@
>  
>  #include "main.h"
>  #include "fw.h"
> -
> +#include "cfg80211.h"
>  
>  void mwifiex_init_11h_params(struct mwifiex_private *priv)
>  {
> @@ -220,8 +220,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
>  				cancel_delayed_work_sync(&priv->dfs_cac_work);
>  				cfg80211_cac_event(priv->netdev,
>  						   &priv->dfs_chandef,
> -						   NL80211_RADAR_DETECTED,
> +						   NL80211_RADAR_CAC_ABORTED,
>  						   GFP_KERNEL);
> +				cfg80211_radar_event(priv->adapter->wiphy,
> +						     &priv->dfs_chandef,
> +						     GFP_KERNEL);
>  			}
>  			break;
>  		default:
> @@ -244,9 +247,16 @@ int mwifiex_11h_handle_radar_detected(struct mwifiex_private *priv,
>  
>  	mwifiex_dbg(priv->adapter, MSG,
>  		    "radar detected; indicating kernel\n");
> -	if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> -		mwifiex_dbg(priv->adapter, ERROR,
> -			    "Failed to stop CAC in FW\n");
> +
> +	if (priv->wdev.cac_started) {
> +		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
> +			mwifiex_dbg(priv->adapter, ERROR,
> +				    "Failed to stop CAC in FW\n");
> +		cancel_delayed_work_sync(&priv->dfs_cac_work);
> +		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
> +				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
> +	}
> +
>  	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
>  			     GFP_KERNEL);
>  	mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n",
> @@ -267,27 +277,53 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
>  	struct mwifiex_uap_bss_param *bss_cfg;
>  	struct delayed_work *delayed_work = to_delayed_work(work);
>  	struct mwifiex_private *priv =
> -			container_of(delayed_work, struct mwifiex_private,
> -				     dfs_chan_sw_work);
> +		container_of(delayed_work, struct mwifiex_private,
> +			     dfs_chan_sw_work);
> +	struct mwifiex_adapter *adapter = priv->adapter;
> +
> +	if (mwifiex_del_mgmt_ies(priv))
> +		mwifiex_dbg(adapter, ERROR,
> +			    "Failed to delete mgmt IEs!\n");
>  
>  	bss_cfg = &priv->bss_cfg;
>  	if (!bss_cfg->beacon_period) {
> -		mwifiex_dbg(priv->adapter, ERROR,
> +		mwifiex_dbg(adapter, ERROR,
>  			    "channel switch: AP already stopped\n");
This change of adding `struct mwifiex_adapter *adapter` and refactoring the
related code is 100% fine, but mixing it here is just making the review work
more complex.

> +
> +	if (priv->uap_stop_tx) {
> +		if (!netif_carrier_ok(priv->netdev))

is this if needed? why? can't you just call netif_carrier_on() in every case?

> +			netif_carrier_on(priv->netdev);


> +		mwifiex_wake_up_net_dev_queue(priv->netdev, adapter);
> +		priv->uap_stop_tx = false;
> +	}
>  }
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 722ead51e912..c5e8f12da0ae 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -1892,6 +1882,20 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
>  	return 0;
>  }
>  
> +/* cfg80211 operation handler for change_beacon.
> + * Function retrieves and sets modified management IEs to FW.
> + */
> +static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
> +					  struct net_device *dev,
> +					  struct cfg80211_ap_update *params)
> +{
> +	int ret;
> +
> +	ret = mwifiex_cfg80211_change_beacon_data(wiphy, dev, &params->beacon);
> +
> +	return ret;

just return mwifiex_cfg80211_change_beacon_data(wiphy, dev, &params->beacon);


