Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9761916E2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgCXQvK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 12:51:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33360 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXQvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 12:51:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so7638225plq.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FL2gUscckleBQc8Oif5ooNEfON5qV0Clsxb3YNLaHK0=;
        b=PuryU/YFgjweiis4mYgSdmU/b0uLl3/yY5O57J7++Tk8vCf1L9VlgI1D5wXqThzvY0
         krT97hoqhflBS/uDvvGgOYY+Y0G14efjOML+WkImMpcEfcCRk1+mPyrQipXp+Hd8F3Bp
         cC9gi1Mwmn02mjBeurHf1MqWcg8SO4ChxBHh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FL2gUscckleBQc8Oif5ooNEfON5qV0Clsxb3YNLaHK0=;
        b=nt+jwhNA22RmQCuWC0Wt5lwwTj5wdsAw7195+f3OU+QPweGz2/lrOM6wCkP4iiIDTv
         ooTwOe2ViUcrV6rs25WIJ6bjqyFgEm6jXj0IqE15+u/S4jZNbsZ+z1bihizTY5BeHSf2
         E1mzOV1y0LHDF2NxnN0W7gm+RsRooclJwtox/t3Plm07CtaXeo+nSR4u/tOPCsne0MjK
         rjX8Y8odf5cfTZwiSxLHf0ysJWKqpkkCNbXz4CiVSGAXA6Y4lnebmWmXlGqr062qFLqN
         1v6/VNqTCbxoEx56nqEwH2S7fLE9jDRYvYI7RSYVNwuxg/eOvU3unfqhbPIb112Z617g
         hZyg==
X-Gm-Message-State: ANhLgQ17rp8Q8zlQH8BlBNib+ubVNj497O8Tloxvs2T/OBdAO9G50VFh
        6D7sdGybU9hpR9xweW3sAtS/lQ==
X-Google-Smtp-Source: ADFU+vvmOP9218KBbrw7uiNMnOo7rV63RtsiBH7UG7X9XQwqXjmje6MDHMRThDXbXveGC41jTr7T6g==
X-Received: by 2002:a17:90b:4c81:: with SMTP id my1mr6591832pjb.30.1585068668955;
        Tue, 24 Mar 2020 09:51:08 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id d14sm16756270pfq.29.2020.03.24.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:51:07 -0700 (PDT)
Date:   Tue, 24 Mar 2020 09:51:05 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v6 1/2] rtw88: add regulatory process strategy for
 different chipset
Message-ID: <20200324165105.GA99185@google.com>
References: <20200324075216.22553-1-yhchuang@realtek.com>
 <20200324075216.22553-2-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324075216.22553-2-yhchuang@realtek.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Mar 24, 2020 at 03:52:15PM +0800, yhchuang@realtek.com wrote:
> --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> +++ b/drivers/net/wireless/realtek/rtw88/Kconfig
> @@ -52,4 +52,14 @@ config RTW88_DEBUGFS
>  
>  	  If unsure, say Y to simplify debug problems
>  
> +config RTW88_REGD_USER_REG_HINTS
> +	bool "Realtek rtw88 user regulatory hints"
> +	depends on RTW88_CORE
> +	default n
> +	help
> +	  Enable regulatoy user hints
> +
> +	  If unsure, say N. This should only be allowed on distributions
> +	  that need this to correct the regulatory.
> +

I'm still not sure why rtw88 needs this, and nobody else does. I read
your commit message, but that doesn't sound like something that belongs
in a single driver still.

>  endif
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index 7640e97706f5..5d43bef91a3c 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1501,8 +1501,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
>  		return ret;
>  	}
>  
> -	if (regulatory_hint(hw->wiphy, rtwdev->regd.alpha2))
> -		rtw_err(rtwdev, "regulatory_hint fail\n");
> +	ret = regulatory_hint(hw->wiphy, rtwdev->efuse.country_code);
> +	if (ret)
> +		rtw_warn(rtwdev, "failed to hint regulatory: %d\n", ret);

I don't think this is what you want; you had it right in previous
revisions:

	if (!rtwdev->efuse.country_worldwide) {
		if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
			rtw_err( ... );
	}

Without the 'country_worlwide' check, you start "hinting" (even on
worldwide chips) that you really wanted "country" 00 only, and so we
*never* adapt to more strict country settings. That's not how world-wide
settings are supposed to work.

>  
>  	rtw_debugfs_init(rtwdev);
>  
> diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
> index 69744dd65968..4cc1234bfb9a 100644
> --- a/drivers/net/wireless/realtek/rtw88/regd.c
> +++ b/drivers/net/wireless/realtek/rtw88/regd.c
>  static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
>  				   struct wiphy *wiphy,
>  				   struct regulatory_request *request)
>  {
> -	if (request->initiator == NL80211_REGDOM_SET_BY_USER)
> +	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER)

Why are you ignoring SET_BY_DRIVER? That's what happens when (a few
lines up) you call regulatory_hint(). At a minimum, that doesn't deserve
a loud error print when we "fail" this function -- you should handle it
properly.

Brian

> +		return -ENOTSUPP;
> +
> +	if (request->initiator == NL80211_REGDOM_SET_BY_USER &&
> +	    !IS_ENABLED(CONFIG_RTW88_REGD_USER_REG_HINTS))
> +		return -EPERM;
> +
> +	if (request->initiator == NL80211_REGDOM_SET_BY_CORE) {
> +		char *country_code;
> +
> +		/* return to the efuse setting */
> +		country_code = rtwdev->efuse.country_code;
> +		rtwdev->regd = rtw_regd_find_reg_by_name(country_code);
>  		return 0;
> +	}
> +
>  	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
>  	rtw_regd_apply_world_flags(wiphy, request->initiator);
>  
