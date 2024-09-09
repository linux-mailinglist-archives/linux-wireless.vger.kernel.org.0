Return-Path: <linux-wireless+bounces-12684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBF972006
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DB62884DD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80614D6FE;
	Mon,  9 Sep 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BGn1XHNc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98128DCC;
	Mon,  9 Sep 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901764; cv=none; b=Kpwvfpi4X1+8ljRCVFnPS9MJauCQzqDWBeu/W2rVikt0Civ4iDFP9fZkzWnounRaKF/cd9gi/+CIf+bufi+xbpMENvDR9YnNJxAyPW2S2q/nx8bPTl5MUrwk1ZgPEffi1lWSMdhwkNBcDQjoQtHEe0ePGvFXpb0+7r4fHaR8y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901764; c=relaxed/simple;
	bh=GeYdtGmtuupdKlXGnYcI3TrQjSqMMfue7WxCA9SbBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYJyutMiGR0XYCs552PQ+OoR4LDgRVPrRCh1Pg7HDhyXbJGba1Wj9yGvGEgw3hx6O71bpwkkODxzQ11nIVfOq1MeIv/OdLQ0ndHPamnU4LVhgx/lHcN8RyVqurxdJBR1Q90nMAvNsNGk1f4TgRMVgh82AtWnkiZC2a7KYmBdy2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BGn1XHNc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 427921F920;
	Mon,  9 Sep 2024 19:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725901760;
	bh=Iw4k1tFhUrrwCXvcI5EjjTTYC8kHB6xyuuK5DqJmF8g=;
	h=Received:From:To:Subject;
	b=BGn1XHNcU2BKKG6U7Q+dMe1qtNxYHZw1nRHneXyPU/QwFBRd8Ztol3mRm8qt8jGIc
	 mtkjL6Un4n9DRa7bGlYY7Au5AT+bpuTjJdmtb/2Q0NZP9QDMgMuv9Upl6iI11w8k+Z
	 qK/MFo8rFu6YkC7dkRP0siNyN0WvabmplYz+6ltaRwbZoy63WIPUKE+Vt5eODoeSzM
	 fP5X4fPuHf++N+QNcuvmyXPiC2DrR82i8tj38mwlExX0MABo0Z1nLvpyFSCAgLbqMp
	 Z+ELRtZOt/8Qd91CB49klMAjjY9n6bVDkgiKzgxTF63PCrJkhE/RWiU18BqyWtA4z6
	 s7DyMVhV16B/g==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id D78167F971; Mon,  9 Sep 2024 19:09:19 +0200 (CEST)
Date: Mon, 9 Sep 2024 19:09:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] wifi: mwifiex: move common settings out of
 switch/case
Message-ID: <Zt8rv-nOERIac4T9@gaggiata.pivistrello.it>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-11-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-11-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:32PM +0200, Sascha Hauer wrote:
> In mwifiex_add_virtual_intf() several settings done in a switch/case
> are the same in all cases. Move them out of the switch/case to
> deduplicate the code.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 8746943c17788..2ce54a3fc32f8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -3005,7 +3005,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EFAULT);
>  		}
>  
> -		priv->wdev.wiphy = wiphy;
>  		priv->wdev.iftype = NL80211_IFTYPE_STATION;
>  
>  		if (type == NL80211_IFTYPE_UNSPECIFIED)
> @@ -3014,8 +3013,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			priv->bss_mode = type;
>  
>  		priv->bss_type = MWIFIEX_BSS_TYPE_STA;
> -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> -		priv->bss_priority = 0;
>  		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
>  
>  		break;
> @@ -3035,14 +3032,10 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EFAULT);
>  		}
>  
> -		priv->wdev.wiphy = wiphy;
>  		priv->wdev.iftype = NL80211_IFTYPE_AP;
>  
>  		priv->bss_type = MWIFIEX_BSS_TYPE_UAP;
> -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> -		priv->bss_priority = 0;
>  		priv->bss_role = MWIFIEX_BSS_ROLE_UAP;
> -		priv->bss_started = 0;
>  		priv->bss_mode = type;
>  
>  		break;
> @@ -3062,7 +3055,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  			return ERR_PTR(-EFAULT);
>  		}
>  
> -		priv->wdev.wiphy = wiphy;
>  		/* At start-up, wpa_supplicant tries to change the interface
>  		 * to NL80211_IFTYPE_STATION if it is not managed mode.
>  		 */
> @@ -3075,10 +3067,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  		 */
>  		priv->bss_type = MWIFIEX_BSS_TYPE_P2P;
>  
> -		priv->frame_type = MWIFIEX_DATA_FRAME_TYPE_ETH_II;
> -		priv->bss_priority = 0;
>  		priv->bss_role = MWIFIEX_BSS_ROLE_STA;
> -		priv->bss_started = 0;
>  
>  		if (mwifiex_cfg80211_init_p2p_client(priv)) {
>  			memset(&priv->wdev, 0, sizeof(priv->wdev));
> @@ -3092,6 +3081,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	priv->wdev.wiphy = wiphy;
> +	priv->bss_priority = 0;
> +	priv->bss_started = 0;

This was not set before in all the 3 cases. Irrelevant? Worth checking and/or
mentioning in the commit message?



