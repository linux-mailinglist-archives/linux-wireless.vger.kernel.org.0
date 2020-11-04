Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A92A71CA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 00:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgKDX2H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 18:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732709AbgKDX1J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 18:27:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6CDC0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 15:27:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so188204pgr.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O3skRjIN8ixIXiEOww81qx8e5y0B4A/Dsx1AUXtDUWY=;
        b=ct4YCQ5pgewuZeo2yjj+uTFEs2zuQcoVlYzA1hCCt4K1W56rTCL2QPyrVwF6q0ko0C
         LERkC2xvLgK1C7WwqMvxHIeUXjEbJ/suNxY6kpFOK1YLZn8AT76yYnZDmcghsxhX8Twi
         OdZHDGy0dfSBcDJjI/7ma4BFcxlgwpayq9NEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O3skRjIN8ixIXiEOww81qx8e5y0B4A/Dsx1AUXtDUWY=;
        b=ZdCl5Cy7k3I/fDKpfLdQTZeI4z51PwA8dvwuutcKY8C/v+JpNRTC8ZVCJEhDHscq7Q
         +Mf4nLC0kWp7MXEhtt4CfIj5lfKBV33vDHmqi0jd1lpwlF2Z/cwVPJgoy7koX+5Orpab
         gtb9BnALjk/Da273+dGeJflmSJYUZAhb/tYrHLQhmDV6N7bMjyqPyriqnQlwNULFNlby
         /ki45J+GDwyt8KXlJq+2AaLWxaDDt4/v1sjSqZrGJJdh+wz+qGaMH3WVxU9wVth42Mlx
         4U0suQQSxmF5E6ECGSEe/CzUmvzR9USBcciXLU42IxdUqRtD5xSCdmGR2xOJAMdJEJUD
         YDSQ==
X-Gm-Message-State: AOAM533KktyXjMmLaHOPJpgtbeue3/s/LZF7MMjqr+WVsGO+2evvucAw
        Dak7l2uNhKRz/Yt+lgCA0r8LSQ==
X-Google-Smtp-Source: ABdhPJyNKNlHl0gI15DuS8zVYsuY/UBM4lI8ygYjk2RxbDF/2qLPqSaQ5RCzWIg20cQXOH2JXkF0rw==
X-Received: by 2002:a17:90a:fb90:: with SMTP id cp16mr256553pjb.232.1604532429384;
        Wed, 04 Nov 2020 15:27:09 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id 16sm3284343pjf.36.2020.11.04.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:27:08 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:27:06 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        dianders@chromium.org, kuabhs@google.com
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
Message-ID: <20201104232706.GC3212577@google.com>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Carl,

Sorry, I lied; I have a few more notes after spending another day
looking at this:

On Tue, Sep 22, 2020 at 01:49:34PM +0800, Carl Huang wrote:
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1663,6 +1663,55 @@ struct station_info {
> +/**
> + * @struct cfg80211_sar_chan_ranges - sar frequency ranges
> + * @index: the index of this range. It's used to specify
> + *	the frequency range when setting SAR power limitation
> + * @start_freq:  start channel frequency in kHZ. For example,
> + *	2.4G channel 1 is represented as 2412000
> + * @end_freq:    end channel frequency in kHZ

If you accept my comments in nl80211.h, you'll want to change this too.

> + */
> +struct cfg80211_sar_freq_ranges {
> +	u8 index;
> +	u32 start_freq;
> +	u32 end_freq;
> +};

> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h

> + * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to specify the start
> + *	frequency of this range to register SAR capability to wihpy and the unit
> + *	is kHZ
> + *
> + * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify the end frequency
> + *	of this range to register SAR capability to wiphy and the unit is kHZ

The documentation here isn't clear whether these are center frequencies
or band edges. The cfg80211 comments do though (center freq). However,
this is inconsistent with NL80211_ATTR_FREQ_RANGE_START and
NL80211_ATTR_FREQ_RANGE_END -- I'd suggest being consistent?

> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c

> @@ -15331,6 +15496,14 @@ static const struct genl_ops nl80211_ops[] = {
>  		.internal_flags = NL80211_FLAG_NEED_NETDEV |
>  				  NL80211_FLAG_NEED_RTNL,
>  	},
> +	{
> +		.cmd = NL80211_CMD_SET_SAR_SPECS,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = nl80211_set_sar_specs,
> +		.flags = GENL_UNS_ADMIN_PERM,
> +		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |

Is there a reason this needs to be UP? CMD_SET_WIPHY (which can also
configure TX power, a little differently) does not. Seems like this
could just be NL80211_FLAG_NEED_NETDEV -- or maybe not even that, if we
switch this to a WIPHY command like Johannes noted.

Brian

> +				  NL80211_FLAG_NEED_RTNL,
> +	},
>  };
