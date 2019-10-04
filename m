Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FFCBFD5
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbfJDP4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 11:56:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38630 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbfJDP4K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 11:56:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so3326738plq.5
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XuTFm7PmBnOTEXwk6HOm9tTaZO7sz0lj99hGKjmHVpY=;
        b=QxJ7VeTkadELxH/Iy/fJ4QBoLHE+jrTZuju/6HbUfQ+SsRCVL32NJjVA+NMrsu82/5
         u6GhYGfWUJcLdaCVyEV2l4bcbg6AAiojH6HJBNTvUAcravI0qPjzYMN55IFkpTawGXyQ
         9RJ/B0spq8hjtL7HcKMoa8eKFpFf5e0TdIVmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XuTFm7PmBnOTEXwk6HOm9tTaZO7sz0lj99hGKjmHVpY=;
        b=Q1ACFhRufVZ9015h9zyZ+6Ia0jiNAdlkAiUSqAmzoODYUPC3MLq4ul1zeLmICJRm+I
         KS5AcVkb+AKlipEbMFmv8fcH9VBQqMZ04siSnVKTt7OOdvBPF149ThaKgAHjazpYhJ7V
         lG1iF3ot56rQmqo7eiHqfeOYibgdhVAdiK1MpaEid5CkAWsniauazkzUtqk+2BY/sm8t
         UCDpLU0rCpdxR1zWOdEA2YVC9sYDyWeGFFSI74506k6tUMWV581Jgux7VfxAOnQx9G2x
         gTHNK7yjfq3T6oiTqr2lDjr1/N2zVlhdVnCzr2atRTwkUNdSPJU//qUqxPjpZDLeeYtm
         0Q1g==
X-Gm-Message-State: APjAAAV+tyI87KC98jVwbLPZiuIwBMCK7+dlBfdcbvzPijVpV4M+OSU2
        TSgdvzrrOoh4Gl7bUZLThZLjhQ==
X-Google-Smtp-Source: APXvYqwXwW9gr3TP/4gIxZCVkrUW1BJFdOLdlW0Xrehgp//g/KdmNeXpOWkYjeWazMIbwhgVGrTofw==
X-Received: by 2002:a17:902:a586:: with SMTP id az6mr16193131plb.12.1570204570070;
        Fri, 04 Oct 2019 08:56:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm6645699pfi.137.2019.10.04.08.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:56:09 -0700 (PDT)
Date:   Fri, 4 Oct 2019 08:56:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nico@semmle.com,
        stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2/2] cfg80211: wext: Reject malformed SSID elements
Message-ID: <201910040856.C85EDF91@keescook>
References: <20191004095132.15777-1-will@kernel.org>
 <20191004095132.15777-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004095132.15777-2-will@kernel.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 04, 2019 at 10:51:32AM +0100, Will Deacon wrote:
> Ensure the SSID element is bounds-checked prior to invoking memcpy()
> with its length field.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Kees Cook <keescook@chromium.org>
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/wireless/wext-sme.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
> index c67d7a82ab13..3fd2cc7fc36a 100644
> --- a/net/wireless/wext-sme.c
> +++ b/net/wireless/wext-sme.c
> @@ -201,6 +201,7 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
>  			       struct iw_request_info *info,
>  			       struct iw_point *data, char *ssid)
>  {
> +	int ret = 0;
>  	struct wireless_dev *wdev = dev->ieee80211_ptr;
>  
>  	/* call only for station! */
> @@ -219,7 +220,10 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
>  		if (ie) {
>  			data->flags = 1;
>  			data->length = ie[1];
> -			memcpy(ssid, ie + 2, data->length);
> +			if (data->length > IW_ESSID_MAX_SIZE)
> +				ret = -EINVAL;
> +			else
> +				memcpy(ssid, ie + 2, data->length);
>  		}
>  		rcu_read_unlock();
>  	} else if (wdev->wext.connect.ssid && wdev->wext.connect.ssid_len) {
> @@ -229,7 +233,7 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
>  	}
>  	wdev_unlock(wdev);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int cfg80211_mgd_wext_siwap(struct net_device *dev,
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
