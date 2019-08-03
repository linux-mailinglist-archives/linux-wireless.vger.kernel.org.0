Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA47803A0
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Aug 2019 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfHCBGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 21:06:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37694 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHCBGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 21:06:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so36823581pfa.4
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2019 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Ztt+0LH1C0C+imT9nDiN3JF0EJqsLNGZKnYTWoc4aE=;
        b=lraF67Emsayr4DCaT/+QqRGFmU+ZyzldRD8G3f5CyEQco0E9gPpuUltAdRRBofElEe
         WZsh6XSHgWXr5qGdxPXSnsqQFzFqlsoT1twzTFj2Du5pxNxavuY2PaYw+/dvjmcDcoR7
         9Lu6HqtmTBP12D0vWhOzRf4RmVkpSjTPE12aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Ztt+0LH1C0C+imT9nDiN3JF0EJqsLNGZKnYTWoc4aE=;
        b=AAplFFFJA4SI7O3uiz1nGgVCdWUVRzmln+p8Px76gRUOVEkcvML1aNCRAzjgyfvnVK
         O/I89d6LRgFgszr4BvU4x34iaJfyqu+5vjMM8z9LCaFaR7ZzqLtrb7WQusypEF3VH/ex
         6dX64rVHIeXMJLDuFQE395ZdBLfa8UKoOsIJKwhihAjYwdFWFZZCjB9nVdAw+CaTq5Rh
         DAqmxSbxb9GQQbVtrV9uZP/ZqwFPna3vkioZ2BIgLhaRSP9QiOUUthaSrhu8i9lnwMCZ
         ZD4UFl79n1H/b0E6sqZ8eESSxRX5id6icPfF9NZVCjLTekuWVDGyIiP83Qf4m7hR5+Ac
         V7Ig==
X-Gm-Message-State: APjAAAVz5MzHiTtEFj0QuRMp+KQs9nmN+2/wbKbwB098X4XTrMlXZWFz
        RpouUxc5i17oz9L/WDTJljpmqA==
X-Google-Smtp-Source: APXvYqzXhzi0GU6L69WI8i34F+64PwisUdJAQr7EWY77ROnxVBW2rou1YmcdGlyMbyzWipwLbSi/Xg==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr60107762pfh.56.1564794406182;
        Fri, 02 Aug 2019 18:06:46 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k5sm8312942pjl.32.2019.08.02.18.06.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 18:06:44 -0700 (PDT)
Date:   Fri, 2 Aug 2019 18:06:42 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [RFC PATCH] Revert "mwifiex: fix system hang problem after
 resume"
Message-ID: <20190803010641.GA22848@google.com>
References: <20170331202136.100342-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331202136.100342-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Doug, Matthias, who are seeing problems (or, failure to try to
recover, as predicted below)
+ Amit's new email
+ new maintainers

Perhaps it's my fault for marking this RFC. But I changed the status
back to "New" in Patchwork, in case that helps:

On Fri, Mar 31, 2017 at 01:21:36PM -0700, Brian Norris wrote:
> This reverts commit 437322ea2a36d112e20aa7282c869bf924b3a836.
> 
> This above-mentioned "fix" does not actually do anything to prevent a
> race condition. It simply papers over it so that the issue doesn't
> appear.
> 
> If this is a real problem, it should be explained better than the above
> commit does, and an alternative, non-racy solution should be found.
> 
> For further reason to revert this: there's ot reason we can't try

s/ot/no/

...oops.

> resetting the card when it's *actually* stuck in host-sleep mode. So
> instead, this is unnecessarily creating scenarios where we can't recover
> Wifi.
> 
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Amit, please take a look. AIUI, your "fix" is wrong, and quite racy. If you
> still think it's needed, can you please propose an alternative? Or at least
> explain more why this is needed? Thanks.

FWIW, I got an Acked-by from Amit when he was still at Marvell. And
another Reviewed-by from Dmitry. This still applies. Should I resend?
(I'll do that if I don't hear a response within a few days.)

Thanks,
Brian

>  drivers/net/wireless/marvell/mwifiex/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
> index 756948385b60..0dab77b526de 100644
> --- a/drivers/net/wireless/marvell/mwifiex/init.c
> +++ b/drivers/net/wireless/marvell/mwifiex/init.c
> @@ -60,7 +60,7 @@ static void wakeup_timer_fn(unsigned long data)
>  	adapter->hw_status = MWIFIEX_HW_STATUS_RESET;
>  	mwifiex_cancel_all_pending_cmd(adapter);
>  
> -	if (adapter->if_ops.card_reset && !adapter->hs_activated)
> +	if (adapter->if_ops.card_reset)
>  		adapter->if_ops.card_reset(adapter);
>  }
>  
> -- 
> 2.12.2.564.g063fe858b8-goog
> 
