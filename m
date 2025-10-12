Return-Path: <linux-wireless+bounces-27947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 940DBBD07CA
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D3E1897215
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F42D6E43;
	Sun, 12 Oct 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="GWd29rGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF628DF0B;
	Sun, 12 Oct 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287228; cv=none; b=MyDz9LrvX1IDiaSJf5YHEwav42r+5WqmmcyGmxRa6mdObJLN+tPzzu7BLT0Sjgl0VKs7Fq+nODNyols95N1bD39DyfwKQkozqCB64R4RRkyJW3gksIOJ0WXD7rxs/YkG1xSUGf/FaR8FxpMtNP3CbXn4lof5d3h9sLoyveEcXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287228; c=relaxed/simple;
	bh=jWCc18PpdJfGMKi+sdi7sqDK+rRMDn7pLGWGjIeo37w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDyNgqw+ZdFYnY85+9ZZ980dSl15mv6cGmbIWAN4zAdgtDJk4qrjML5LQDKYXMgGJtVytyoBan8noxDa9RfdMg/Z2QCS4Ps3qUfEkqRropMZWIadrcK8AFXVR5jJycXnTdg7PuWcxoVVyzEw3XJQimCbzCapBjqbyHbxnyImCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=GWd29rGa; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=dKcY5QMuB4ui9FZBXGralraAi/Id1gyrnGStgEz8INg=; b=GWd29rGaML08LkDM
	segaT8sJ6fdzVERpv7ftMrSu37HYqJ9XyouPGfYylAvMgCMU3JE5KmOoFYN3muXHy1gE6i6hb9mPg
	AjwEZYu4wm7bzs1rtN2Gj1n6AflFjolK+A8gkx2Ckv+8nrSZ1v7X88VScNedGKwX4U1+Vxggla8fR
	z/cDc/8Q5TMy/krdnNYll39E1taV/NkgnpvuHqc9+/IjOS4MaLyYafHds1I4QX8bDzP/zVPGxsa2x
	GKO8IL3uUDKjU/X6Ulrjwe2Wi7rS+0chhXNjWXYqlr7EsH4P0MQarenVkYc+gjCdnOQ1vq1LT0sfU
	Ji0AyDmwPBebRA+xUg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1v7z7I-00FwA9-0O;
	Sun, 12 Oct 2025 16:40:16 +0000
Date: Sun, 12 Oct 2025 16:40:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Remove unused wdev_to_ieee80211_vif
Message-ID: <aOvZ8FHp7-tliei2@gallifrey>
References: <20250619005229.291961-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250619005229.291961-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 16:39:51 up 168 days, 53 min,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> wdev_to_ieee80211_vif() was added in 2013 by
> commit ad7e718c9b4f ("nl80211: vendor command support")
> but has remained unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi,
  Gentle ping on this one please.

Dave

> ---
>  include/net/mac80211.h | 13 -------------
>  net/mac80211/util.c    | 11 -----------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 286c944d90ad..544a28336b93 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -2112,19 +2112,6 @@ static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
>  	return false;
>  }
>  
> -/**
> - * wdev_to_ieee80211_vif - return a vif struct from a wdev
> - * @wdev: the wdev to get the vif for
> - *
> - * This can be used by mac80211 drivers with direct cfg80211 APIs
> - * (like the vendor commands) that get a wdev.
> - *
> - * Return: pointer to the wdev, or %NULL if the given wdev isn't
> - * associated with a vif that the driver knows about (e.g. monitor
> - * or AP_VLAN interfaces.)
> - */
> -struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
> -
>  /**
>   * ieee80211_vif_to_wdev - return a wdev struct from a vif
>   * @vif: the vif to get the wdev for
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 27d414efa3fd..39a25fe20959 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -857,17 +857,6 @@ void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
>  }
>  EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_mtx);
>  
> -struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
> -{
> -	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
> -
> -	if (!ieee80211_sdata_running(sdata) ||
> -	    !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
> -		return NULL;
> -	return &sdata->vif;
> -}
> -EXPORT_SYMBOL_GPL(wdev_to_ieee80211_vif);
> -
>  struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif)
>  {
>  	if (!vif)
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

