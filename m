Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34D9612104
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Oct 2022 09:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJ2H0M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Oct 2022 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJ2H0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Oct 2022 03:26:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29712C8941
        for <linux-wireless@vger.kernel.org>; Sat, 29 Oct 2022 00:26:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g62so6578920pfb.10
        for <linux-wireless@vger.kernel.org>; Sat, 29 Oct 2022 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yyu0gP5Bb5qvocG8rpAWZtvXtV2KdF5OgX3sx6HcHQ=;
        b=eKyt9tfG9gweAqhcqLfGjGcVfvk3YhEwQzY5C7ht52aRbjB8RAyYvIT7/RvXrXSPYQ
         5VQK1mjBMumwUFTjZ8euzvgxSKvtb+xTEDKedZ8JROWflZ1Buz0MpCqbnnixWWrLGvn3
         +nkZv93pI/RsG4cHaEecJJn0JGUH7/LrgXLJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Yyu0gP5Bb5qvocG8rpAWZtvXtV2KdF5OgX3sx6HcHQ=;
        b=q5zjWcepUf3jIxmnN2z4+W6JWMnjKdoluNT91sak97P7bfgKuxjmixe7LTZJXSco1p
         X7GdnoQEXX31M1CCKcsJO7tO18FxoeimLboebTk+vZq7lKjTdGeGWPSOqMJ/uXFWCHL5
         E63Sg56vZIBUXbf+J9Vwju4q27B/TQnuazCZX+9fEk5hSJe7oqOEjySDRjiJuHjX4rUS
         KlF0wO3zCIvPDeXTDKVZCl8JUG7jGf9eDPiB1uLKc8VETqjbIucA0LUBXxB9pi84j/A6
         nE650dQWd6uzX7XV65TpbXYTYwC0g1hx1DH5Ksk3Bw6Xtr1tBVkkVFkiu/7+KodFCrnQ
         DL1w==
X-Gm-Message-State: ACrzQf0FL9BD4W3OYZmt+ksa5Er/nGbNj0MdG+1sFLZM7Cn1uN7VFESb
        4ex+lO9xfFHSoNu6nIi5baBHjg==
X-Google-Smtp-Source: AMsMyM5H5GaoRCI8ygD2fvAGRfIBNhhHRuNei1zA0uK+T3MYurTYRxSwNAcok7DZJjgMdO4V3gy2Pw==
X-Received: by 2002:a63:4651:0:b0:43c:1cb7:5c09 with SMTP id v17-20020a634651000000b0043c1cb75c09mr3100964pgk.259.1667028367680;
        Sat, 29 Oct 2022 00:26:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a560100b00212e60c7d9csm499779pjf.41.2022.10.29.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:26:07 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:26:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hostap: Avoid clashing function prototypes
Message-ID: <202210290025.15F3F949B9@keescook>
References: <cover.1666894751.git.gustavoars@kernel.org>
 <8388b5ed9e729eb9dadec875a7576219e6d61223.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8388b5ed9e729eb9dadec875a7576219e6d61223.1666894751.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 27, 2022 at 03:18:37PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 42 warnings like these:
> 
> ../drivers/net/wireless/intersil/hostap/hostap_ioctl.c:3868:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, char *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         (iw_handler) prism2_get_name,                   /* SIOCGIWNAME */
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The hostap Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> Link: https://github.com/KSPP/linux/issues/235
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks like prism2_private_handler contents could be uncast? Otherwise,
yeah, looks good.

-- 
Kees Cook
