Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF018DC6B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2020 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCUAQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 20:16:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35481 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCUAQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 20:16:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so3200347plt.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2020 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nt+Cb+20tzlJ36Dzwio8Duw1621fjyhdZ5q1j1EjwUo=;
        b=WoXygVRzYcqYiERjo+cSScwOBDozyUZI7ci16vGdkkF5wxYi7svkRIHe6c2nc/q+J+
         ohpwTjBvsUf471WMabtWEomxsjSPCCHqVNPQ0F4oGM//XABsCloi2lMwN8umrCewjYAr
         f7+ha6KozTRxhSBBMjANFjXArQ1iLQoRwfjfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nt+Cb+20tzlJ36Dzwio8Duw1621fjyhdZ5q1j1EjwUo=;
        b=bNhYnLHwGNgf2iMQ+cQwWrLnNgaqwUSVr7WdDQ5BACpQ9Yosysa+GPX4MPjWTQYvja
         Ru/kSMI3u3rKUo6HdVzJ6ABRevItfcQOBLYfn/Z9biv61G8Gu626LNTIFqdUSlbCcQKM
         0MCHWV6x0QiudfpyoCb8BRXahzCv8R6rFw6sx4cvHKBzN+qxbY2ihzOPWFQO9P7SwTkM
         WcH8z4+5vm/ZznDRenB6bXnnoBbMOfCdKMW8fDftmWaVnZ9t/ONZiWGwuSVyJguVnGqa
         kJNityAGQ9ePIsOUQoWw6dfswN218xkeeALWq4Vc5TN20WlzjzQ2bV2eV69hqejm8Cni
         iF/A==
X-Gm-Message-State: ANhLgQ3OKnsXp39wAARtFSCo+C6CwRLuFfg6nbDANX8NlV9/AfhOSUgv
        cWvXSweJO0FbU+XpGHjAlMJnudc1CWU=
X-Google-Smtp-Source: ADFU+vuPbQ/6MyWTbueAJKgW9kJuvyzbw9evYabJCdzzAmhNb+K6K8vKLdDeNg39bNX3vwbjcc3+QQ==
X-Received: by 2002:a17:902:b901:: with SMTP id bf1mr10866754plb.133.1584749809381;
        Fri, 20 Mar 2020 17:16:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id u1sm2707424pfn.214.2020.03.20.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 17:16:47 -0700 (PDT)
Date:   Fri, 20 Mar 2020 17:16:45 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v5 1/2] rtw88: add regulatory process strategy for
 different chipset
Message-ID: <20200321001645.GA16851@google.com>
References: <20200313034918.22222-1-yhchuang@realtek.com>
 <20200313034918.22222-2-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313034918.22222-2-yhchuang@realtek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Mar 13, 2020 at 11:49:17AM +0800, yhchuang@realtek.com wrote:
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 2f73820cd9ba..635d9964beaa 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1510,8 +1510,10 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
>  		return ret;
>  	}
>  
> -	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
> -		rtw_err(rtwdev, "regulatory_hint fail\n");
> +	if (!rtwdev->efuse.country_worldwide) {
> +		if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
> +			rtw_err(rtwdev, "regulatory_hint fail\n");
 Might as well log the error code, whlie you're at it?

> +	}
>  
>  	rtw_debugfs_init(rtwdev);
>  

> diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
> index 69744dd65968..500a02b97a9c 100644
> --- a/drivers/net/wireless/realtek/rtw88/regd.c
> +++ b/drivers/net/wireless/realtek/rtw88/regd.c
> @@ -7,6 +7,18 @@
>  #include "debug.h"
>  #include "phy.h"
>  
> +static const struct ieee80211_regdomain rtw88_world_regdom = {
> +	.n_reg_rules = 5,
> +	.alpha2 =  "99",
> +	.reg_rules = {
> +		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
> +		REG_RULE(2467 - 10, 2484 + 10, 40, 0, 20, NL80211_RRF_NO_IR),
> +		REG_RULE(5180 - 10, 5240 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
> +		REG_RULE(5260 - 10, 5700 + 10, 80, 0, 20,
> +			 NL80211_RRF_NO_IR | NL80211_RRF_DFS),
> +		REG_RULE(5745 - 10, 5825 + 10, 80, 0, 20, NL80211_RRF_NO_IR),
> +	}
> +};

These rules look substantially identical to the default world rules
specified in the standard regdb, except for the fact that you're missing
the NO-ODFM part of this band:

        # Channel 14. Only JP enables this and for 802.11b only
        (2474 - 2494 @ 20), (20), NO-IR, NO-OFDM

So, why do you need to specify a custom one?

...

>  static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
>  				   struct wiphy *wiphy,
>  				   struct regulatory_request *request)
>  {
> -	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
> +	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)
> +		return -EINVAL;
> +	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
> +	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
> +		return -EINVAL;
> +	if (request->initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
> +	    !rtw_regd_is_ww(&rtwdev->regd))
> +		return -EINVAL;
> +	if (request->initiator == NL80211_REGDOM_SET_BY_CORE &&
> +	    !rtwdev->efuse.country_worldwide) {
> +		rtwdev->regd =
> +			rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
>  		return 0;
> +	}

None of these errors actually go anywhere; if you were planning to
ignore these, shouldn't they be surfaced somewhere? Or can't these be
encoded in your regulatory policy instead? Like
REGULATORY_COUNTRY_IE_IGNORE, for one.

And as with your WOWLAN implementation: if there's no way to surface
errors, you should at least log something.

Brian

>  	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
>  	rtw_regd_apply_world_flags(wiphy, request->initiator);
>  
 
