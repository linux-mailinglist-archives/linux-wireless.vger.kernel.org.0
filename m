Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7D602121
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 04:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJRC0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 22:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJRC0J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 22:26:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8CE75CC9
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:26:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r18so12071313pgr.12
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KZhy//nHZxzt7N+DIXJ4f0oPILyzcXc82OGC+Wmp/k=;
        b=BNQoXVjyQzateVtvrG7WFBq7bZIutgY4fn3PO7YW7fW4F6ZKob4YvPwsZfSuxZJJ1y
         9qT6OBPYy22bDT0dfOMnEP06BZRtXWBq+hH2RCqBJNeU5TScoTKF3IZzSlopKwtV6GIc
         j7ydQqNtqK8FDU47mblyFvt4BnTs+KHl4e/Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KZhy//nHZxzt7N+DIXJ4f0oPILyzcXc82OGC+Wmp/k=;
        b=4CkBuR2DByqexSoNdScfZPvLC9jiJ17GY69bfBacJmr6PhWZa3s202vao8W21DR3/z
         kE9o5E1Iji622KRkwm5+pr2xOOaUCpUM+IDIPQyYzvjvDFiWF/6J43ugkkU14q38J7ep
         xskYTJciIwahZNC0Y/VJ8of4BupKdF0R8L28kaZbMVsE3jSO4J3iJ/I8Gnl2Qbsilxb5
         +SvtNzbZLPemmvx4IkIzDaygZ4WP+o7dICRqAvWpMwfmqj5Q7rdaRw7s5SjYyg5cAtyl
         nJzXltp1+3vde19GbTyDtOSvH7wYEMAs76loE/L1LwzXiFapioPbomJ9vr0DoQVHwB5P
         HxnA==
X-Gm-Message-State: ACrzQf0tUBqjE6N6P38LN6BftDdIdnEMs4WeiG8T5zFB4Oc5buvpfZfE
        ZO7gEColVMVZ1mHy8qt0xpCm6w==
X-Google-Smtp-Source: AMsMyM44tI9T+OrjStrhBakQHZqVAo+drzSjAJZvAYJDXZdKqjPYu8K6XRQt6u2BFVqHJsVCsEwuww==
X-Received: by 2002:a63:1f5c:0:b0:469:d0e6:dac0 with SMTP id q28-20020a631f5c000000b00469d0e6dac0mr681043pgm.427.1666059967533;
        Mon, 17 Oct 2022 19:26:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i196-20020a636dcd000000b00434abd19eeasm6778334pgc.78.2022.10.17.19.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:26:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:26:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/6][next] orinoco: Avoid clashing function prototypes
Message-ID: <202210171914.B3E5CE55@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <2387e02ae7f31388f24041cae8d02d5e12151708.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2387e02ae7f31388f24041cae8d02d5e12151708.1666038048.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 17, 2022 at 03:33:01PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 53 warnings like these:
> 
> drivers/net/wireless/intersil/orinoco/wext.c:1379:27: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_param *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         IW_HANDLER(SIOCGIWPOWER,        (iw_handler)orinoco_ioctl_getpower),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../net/wireless/wext-compat.c:1607:33: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         [IW_IOCTL_IDX(SIOCSIWGENIE)]    = (iw_handler) cfg80211_wext_siwgenie,
>                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thank you for working on these! Was this conversion done manually, via
coccinelle, or something else?

> The orinoco Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. No significant binary differences were seen
> before/after changes.

What does "significant" mean here? :P Anything related to line counts
can just be ignored. But I'd expect the .text output of
drivers/net/wireless/intersil/orinoco/wext.o before/after to be
identical.

> [...]
>  	IW_HANDLER(SIOCSIWRTS,		(iw_handler)cfg80211_wext_siwrts),
^^^ I think these are fixed explicitly later, but maybe better to just
collapse them into this patch?

> [...]
> @@ -1391,15 +1406,15 @@ static const iw_handler	orinoco_handler[] = {
>    Added typecasting since we no longer use iwreq_data -- Moustafa
>   */
>  static const iw_handler	orinoco_private_handler[] = {
> -	[0] = (iw_handler)orinoco_ioctl_reset,
> -	[1] = (iw_handler)orinoco_ioctl_reset,
> -	[2] = (iw_handler)orinoco_ioctl_setport3,
> -	[3] = (iw_handler)orinoco_ioctl_getport3,
> -	[4] = (iw_handler)orinoco_ioctl_setpreamble,
> -	[5] = (iw_handler)orinoco_ioctl_getpreamble,
> -	[6] = (iw_handler)orinoco_ioctl_setibssport,
> -	[7] = (iw_handler)orinoco_ioctl_getibssport,
> -	[9] = (iw_handler)orinoco_ioctl_getrid,
> +	[0] = orinoco_ioctl_reset,
> +	[1] = orinoco_ioctl_reset,
> +	[2] = orinoco_ioctl_setport3,
> +	[3] = orinoco_ioctl_getport3,
> +	[4] = orinoco_ioctl_setpreamble,
> +	[5] = orinoco_ioctl_getpreamble,
> +	[6] = orinoco_ioctl_setibssport,
> +	[7] = orinoco_ioctl_getibssport,
> +	[9] = orinoco_ioctl_getrid,

Oops, I broke atmel. These really are 0-indexed...

 static const iw_handler atmel_private_handler[] =
 {
-	NULL,				/* SIOCIWFIRSTPRIV */
+	IW_HANDLER(SIOCIWFIRSTPRIV,	NULL),
 };
 
I'll send a fix!

-- 
Kees Cook
