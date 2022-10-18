Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B4602148
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 04:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJRClx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 22:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRClw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 22:41:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B898708B
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:41:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so12810448pfk.9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg4TUcI05oybhWwKK7WfEpddIyR7SKg7hJD3GVQqv+4=;
        b=fI5BizILWdXp7nlbeCT1NMtSOeJfetKwhyk2vhTnmJhdNuxvwZ5/KZIBnmOAIuPYkU
         muvJcgK82bGjwibdRIEOBeqr3ohEjKkk5fLI2Vrw6Jc+xDffe85lRmSCk5MjDvyMp11r
         MbNIzGS1Rp+hjZZEu6J5filgRNOEkTQ6jeXMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg4TUcI05oybhWwKK7WfEpddIyR7SKg7hJD3GVQqv+4=;
        b=pRhLiaj/uqtR4SXu5zBnnFI9rdgz8D+5yvOr1kJl9VDKEvUT8ni29gGtTjHZ8TyhS2
         pmewn45/qxYTJjsi6WUBAStDelRte62IbALMJ0Y6UObmYhNprf9WxoJ8FFaAhwSp4Yq3
         9LMxFZjPP6J/9ApCvZfcV+V7Dl0p7l+lqIW3+TPn+td9hOy4r+eai5h+hW0pYSW1sUlv
         uJI10b6YJaQiRILVdeRfESrCgVdDFsvUfi1qb9PviI1/QccxQ2K5xVpsxn9IcNUGWg3K
         zLm2GvYmtGNvtBykNkkPU2R1D9MComfskC0Iy6M5VgwqEGfKtB/Iu2h1ATSkZAF6hdwH
         Rz8A==
X-Gm-Message-State: ACrzQf10DjOkhFsjTRwdZJojPI4MEGgnX95cP+aQMHqnXjtI06A/Pb9C
        CJE9WQYAVnyJ+DLA53wp25vfaOIIrSLtSQ==
X-Google-Smtp-Source: AMsMyM4m5Ra8jwDfvqCT8zik/EZVj46VRT7zLYklwFkogFGxGKXj6Ms7IkYQpPnVqgz2TkZVySegMQ==
X-Received: by 2002:a63:e113:0:b0:439:e032:c879 with SMTP id z19-20020a63e113000000b00439e032c879mr745675pgh.287.1666060910313;
        Mon, 17 Oct 2022 19:41:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001806f4fbf25sm7361585plr.182.2022.10.17.19.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:41:49 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:41:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/6][next] cfg80211: Avoid clashing function prototypes
Message-ID: <202210171939.61FFBE79A7@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <291de76bc7cd5c21dc2f2471382ab0caaf625b22.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291de76bc7cd5c21dc2f2471382ab0caaf625b22.1666038048.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 17, 2022 at 03:34:22PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 10 warnings like these:
> 
> ../drivers/net/wireless/intersil/orinoco/wext.c:1390:27: error: incompatible function pointer types initializing 'const iw_handler' (aka 'int (*const)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') with an expression of type 'int (struct net_device *, struct iw_request_info *, struct iw_param *, char *)' [-Wincompatible-function-pointer-types]
>         IW_HANDLER(SIOCGIWRETRY,        cfg80211_wext_giwretry),
>                                         ^~~~~~~~~~~~~~~~~~~~~~
> ../include/uapi/linux/wireless.h:357:23: note: expanded from macro 'IW_HANDLER'
>         [IW_IOCTL_IDX(id)] = func
> 
> The cfg80211 Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. No significant binary differences were seen
> before/after changes.
> 
> Link: https://github.com/KSPP/linux/issues/234
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/intersil/orinoco/wext.c |  22 +--
>  include/net/cfg80211-wext.h                  |  20 +--
>  net/wireless/scan.c                          |   3 +-
>  net/wireless/wext-compat.c                   | 180 +++++++++----------
>  net/wireless/wext-compat.h                   |   8 +-
>  net/wireless/wext-sme.c                      |   5 +-
>  6 files changed, 112 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/net/wireless/intersil/orinoco/wext.c b/drivers/net/wireless/intersil/orinoco/wext.c
> index b8eb5d60192f..dea1ff044342 100644
> --- a/drivers/net/wireless/intersil/orinoco/wext.c
> +++ b/drivers/net/wireless/intersil/orinoco/wext.c
> @@ -1363,31 +1363,31 @@ static const struct iw_priv_args orinoco_privtab[] = {
>  
>  static const iw_handler	orinoco_handler[] = {
>  	IW_HANDLER(SIOCSIWCOMMIT,	orinoco_ioctl_commit),
> -	IW_HANDLER(SIOCGIWNAME,		(iw_handler)cfg80211_wext_giwname),
> +	IW_HANDLER(SIOCGIWNAME,		cfg80211_wext_giwname),

This hunk should be in the orinoco patch, I think?


> [...]
> +	[IW_IOCTL_IDX(SIOCGIWRETRY)]    = cfg80211_wext_giwretry,

The common practice seems to be to use IW_HANDLER instead of open-coding
it like this.

	IW_HANDLER(SIOCGIWRETRY,	cfg80211_wext_giwretry),

-- 
Kees Cook
