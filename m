Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69C04B9278
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiBPUee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 15:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiBPUec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:32 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE62A39E8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:34:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c10so3104634pfv.8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dUD1O3o1ifOwlrT9wCiI69FVgZyS7G64yh4bIznkTt8=;
        b=cToYCa4Q9YzpuQ8hWjqhI9GAV7hdMX5zFfA045ME9Esgzb7iXXOnP66rLDTpXnUrsH
         ZXAOBQjk3+lTbLD8wwG/XQjRIHof/WW7ZnfXUIQbSGmHV1myOfuF1iJY07seXS5BUgSt
         UWRna5Sk/M3/2NaZ6zLnXSYBj4DI3P+O7+ly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dUD1O3o1ifOwlrT9wCiI69FVgZyS7G64yh4bIznkTt8=;
        b=IjJyV/q9ko2r9wAj8KrHm7Fo+zc0O0UG216IyxbfY1N4mAqTZSMMDVbckPvxaGdPpE
         yKun7YXaRNmvFl0Uo/IiYSj+AmuBLOuzlD+5e4qUBv4Gtya0JxIQHytJvp3JiiM1Jonj
         akLtbZnYady/gAgBa3I4UUc+mMB6KVKhSGGJ4AMYRj0fn3Hrc/48ClHhoy+2ONNlQ8Nu
         kY3I7k5NQJm6WqVQB5jrvA9LKWUUy9C5XO7XotRkCpA9QSlt++HDBzH6jrYXNwHnE8FS
         p8nqPz04IM0Aq70Bep44l+IbZVFa60vXGlrwlNZXFw18O9dMCbR2fxZvM09Pm/ec/5HJ
         Y4mQ==
X-Gm-Message-State: AOAM532bd6+VP4aR0bSlLr5aYYJJuDmyz77PZHstt9rsKxODPvOY/c0f
        Ja6yZuQ5PL8gtz/Y7fZ2KvDTTQ==
X-Google-Smtp-Source: ABdhPJxQlIx/zpkn6DzwhHmBHxoQ/aVVFwDrNfFlAwdVpmL8Xx2laM6IKnYH6S9ktvf3oiVfYtmAgA==
X-Received: by 2002:aa7:8d08:0:b0:4e1:5fb5:b15 with SMTP id j8-20020aa78d08000000b004e15fb50b15mr4799283pfe.70.1645043657895;
        Wed, 16 Feb 2022 12:34:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm44157008pfj.211.2022.02.16.12.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath11k: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.7DBAE56797@keescook>
References: <20220216194836.GA904035@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194836.GA904035@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:36PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
