Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986F6237F0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiKJAHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 19:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiKJAHB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 19:07:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C1167C1
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 16:07:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q9so261972pfg.5
        for <linux-wireless@vger.kernel.org>; Wed, 09 Nov 2022 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJAIIa6Vlk97dPijdSTZusAFpsZaMTIG9iYNeY6hYbE=;
        b=dw9lyZglZzeUd+urH8dtKjOlHQwRFXKLx97i3NHd7iqX9uUOEzDD5aAvYo2HiURERK
         POXwlnCH+QQ4c2p55Oynmg8UxSk44H/ucl7OOwn3R23jMQg4Y4duMrUu9MjZADTXXvJq
         qw/02W31vwKHRoLIiBydme/bvngW2M31K0mww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJAIIa6Vlk97dPijdSTZusAFpsZaMTIG9iYNeY6hYbE=;
        b=626NYVASfMztpAZSJQZT3F6npz4v0yzkySGo9MXfer8eTucBd0Za3VhgmUYI6L/JxJ
         C3SMuYdHAHKK4GqKA/+QNMlHIEQIT8fvXDFqHtUaGzmkjUCyfosSVas8JxNLiA8Gmwxm
         geG1Oo22wxIGwZssXLmI4/h4+jcqYrTK2MPIl9D8utngbb/HNe9PwHW8P22KnToG9PWm
         3ZsxhW+07Ai4Adkhy6lyJ7Vyz7Z6C+ig5NIdDZdZKV4hvwijXygQg+zVk2MHaTO+X+4P
         0iKwI0NTmqQF4Ht/t1eL2vX6Ani5QjgdhD3Ze124UbZT1CVj51gFrUOb0YHkRqn8iFWf
         iElw==
X-Gm-Message-State: ACrzQf092yrYjoJk+twtgQdYcYYdEYRcWzXLpSAwDyRz5/EwpvjhTLiO
        8vmogW0CDrU6glQIh0Rvd1x1PQ==
X-Google-Smtp-Source: AMsMyM7xgxlYavVGj8CSCMRAUq/ab8Tyu6hn/NiZE9Jp09ZmsKSMmadPxe6XXoVnMxlP0KfQKNxupA==
X-Received: by 2002:a63:35c6:0:b0:470:d38:7c63 with SMTP id c189-20020a6335c6000000b004700d387c63mr33856158pga.249.1668038819565;
        Wed, 09 Nov 2022 16:06:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b0016c9e5f291bsm9659662pln.111.2022.11.09.16.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:06:59 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:06:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/7] cfg80211: Avoid clashing function prototypes
Message-ID: <202211091606.11D47EF676@keescook>
References: <cover.1667934775.git.gustavoars@kernel.org>
 <a68822bf8dd587988131bb6a295280cb4293f05d.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68822bf8dd587988131bb6a295280cb4293f05d.1667934775.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 08, 2022 at 02:23:55PM -0600, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 73 warnings like these:
> 
> drivers/net/wireless/intersil/orinoco/wext.c:1379:27: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_param *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         IW_HANDLER(SIOCGIWPOWER,        (iw_handler)orinoco_ioctl_getpower),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../net/wireless/wext-compat.c:1607:33: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         [IW_IOCTL_IDX(SIOCSIWGENIE)]    = (iw_handler) cfg80211_wext_siwgenie,
>                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../drivers/net/wireless/intersil/orinoco/wext.c:1390:27: error: incompatible function pointer types initializing 'const iw_handler' (aka 'int (*const)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') with an expression of type 'int (struct net_device *, struct iw_request_info *, struct iw_param *, char *)' [-Wincompatible-function-pointer-types]
>         IW_HANDLER(SIOCGIWRETRY,        cfg80211_wext_giwretry),
>                                         ^~~~~~~~~~~~~~~~~~~~~~
> 
> The cfg80211 Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> These changes were made partly manually and partly with the help of
> Coccinelle.
> 
> Link: https://github.com/KSPP/linux/issues/234
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
