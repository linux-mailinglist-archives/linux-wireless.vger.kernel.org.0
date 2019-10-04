Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD6CBFD3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfJDPzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 11:55:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46685 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390124AbfJDPzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 11:55:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4117747pfg.13
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKT3NphsS8aC+Hm20wz5BTowxyu8Cj2InabWiB0c0GY=;
        b=P9uryt8X7gX4iN8K3stEiJTJcM2cNtvg5fWgSYMUEnyNUbpf0ORwDeV01gZKcjRXCO
         VCwvJSIUMUzDCJGqe3vTdQ1hMWFKYBkDV4e2OYCKawfibi6tstydDPA3//MRuqJbtD4R
         z8UKcn4TKlwv5xv6uJJi8wck3MSYJwOu971ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKT3NphsS8aC+Hm20wz5BTowxyu8Cj2InabWiB0c0GY=;
        b=m5SnvcK4b4oYiQMaohn7mhNTz0LnhQS2vPiDSfF7bbLa6yLswo9DZ4Ax9eIwm2V4qB
         k8YqKZPy+r0OpJaPNI5E52Jjzz/mnAKLwkF4uh0Wt70HsSTTPYQYRsxFiYQyeBKmbSwI
         N2SOGPXQbJ8PKzm2vEmUm06aiLusRacH1XJRNkCVhLzpokaeJsvVOcFhqAA2bDqtJAXj
         6LWdbf2tfI0FoLim29/6XszP1t3SBLq53bHkmyO4ebrqzCt3Rlbtl5SDbREaEcoINX8n
         j3/2opGLX9xUj0UgjXm44lUf5D0Db3pQ7jOROEvSJTqqF0jHuhe/BylOHI7XOgEIWjir
         X2GQ==
X-Gm-Message-State: APjAAAVE0Ux/I4xcXR9fQ3Lia175X87TvLR+FrZylbnqZncmU6IYKPVD
        IfNyHKrG7ZdEd4QBBmptZEfI3wXV8Sg=
X-Google-Smtp-Source: APXvYqzseQzsIEYKPy2lca6iSmI4k9mLnTVGFyHajRsnq7Qjy0ko5OuaFD/y5oKMSoGkp+PZoeYkLQ==
X-Received: by 2002:a63:368a:: with SMTP id d132mr16009995pga.428.1570204552364;
        Fri, 04 Oct 2019 08:55:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm5730004pjt.17.2019.10.04.08.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:55:51 -0700 (PDT)
Date:   Fri, 4 Oct 2019 08:55:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nico@semmle.com,
        stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: Reject malformed SSID elements
Message-ID: <201910040855.8E8B4D7A@keescook>
References: <20191004095132.15777-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004095132.15777-1-will@kernel.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 04, 2019 at 10:51:31AM +0100, Will Deacon wrote:
> Although this shouldn't occur in practice, it's a good idea to bounds
> check the length field of the SSID element prior to using it for things
> like allocations or memcpy operations.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Kees Cook <keescook@chromium.org>
> Reported-by: Nicolas Waisman <nico@semmle.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/mac80211/mlme.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 26a2f49208b6..54dd8849d1cc 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -2633,7 +2633,8 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
>  
>  	rcu_read_lock();
>  	ssid = ieee80211_bss_get_ie(cbss, WLAN_EID_SSID);
> -	if (WARN_ON_ONCE(ssid == NULL))
> +	if (WARN_ONCE(!ssid || ssid[1] > IEEE80211_MAX_SSID_LEN,
> +		      "invalid SSID element (len=%d)", ssid ? ssid[1] : -1))
>  		ssid_len = 0;
>  	else
>  		ssid_len = ssid[1];
> @@ -5233,7 +5234,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>  
>  	rcu_read_lock();
>  	ssidie = ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
> -	if (!ssidie) {
> +	if (!ssidie || ssidie[1] > sizeof(assoc_data->ssid)) {
>  		rcu_read_unlock();
>  		kfree(assoc_data);
>  		return -EINVAL;
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
