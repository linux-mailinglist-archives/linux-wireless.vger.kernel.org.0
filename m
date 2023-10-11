Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBE7C589D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJKPyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjJKPyE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 11:54:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FF8F
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:54:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5859b06509cso4600597a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697039641; x=1697644441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Htu9vRDdlh1lnBGpIo/5HQ3QU1xFZzou/eTtTBx6bY=;
        b=LvTrZn4zOjR2OcMq0Vf1sNPvUdrZNPV4V8kRu/6wEUvYerkNa0i/+RpBJ0010aINwy
         2ETS9qKXO39GfP6IcBsiPYOlTQmajdV3dFivIhw4rq6StFL78LSdXOkD3y+4TlafBoy/
         sr3jKUp0S/oJRR/mIH20bnxGdtO3DdQrhZW30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039641; x=1697644441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Htu9vRDdlh1lnBGpIo/5HQ3QU1xFZzou/eTtTBx6bY=;
        b=hhwSBUXbms/6U/iray1mGAXVekyUfeECc2XGEufpw+Hk4y4Xbpce3tlIE5dy8aZzgd
         aqxrEEeYm8eSk6kFK1bDdz6QyEGgU/3Cr0nMN0Bqdx6yuzv0MO6YS5AUHZ5z5P9781M6
         AYEsnsCE7SnJ8fM/LZgxrhyFGaeNL+XPn34XAxqijkzFlbVxIMcZGJEa+213OS8Vbv9g
         6yk0g0vSvZbatpm/7BkzoUO0kog7PfOdEmFwNM0MWs1AKRJDMc4vMGhBI2Y6G78NKXHj
         rL8+RYucX+JdL5TXwpIVbL9nfUoCC2LDJqQEO1CdT1h1afNp8tOvZP2GOabhh6mj5ePl
         xh1g==
X-Gm-Message-State: AOJu0YyUXiQl2jb9mMv5b7bcUH9MXBl7r8gR+xKEw9aFMwNf9wlJkWg3
        ZmPEtcpgN/mGsdM30yDroOZZeQ==
X-Google-Smtp-Source: AGHT+IHx5cuQ9DPy4dgHNwWJwoobslE1vm/fFfHwU9kZjrf7+ywmWASe1zIplRnqRA/lPhDk5NYPNQ==
X-Received: by 2002:a05:6a20:3948:b0:174:4df:e445 with SMTP id r8-20020a056a20394800b0017404dfe445mr1384340pzg.50.1697039641577;
        Wed, 11 Oct 2023 08:54:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b8baa83639sm14092344plo.200.2023.10.11.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:54:01 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:54:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: rtw89: coex: add annotation __counted_by() to
 struct rtw89_btc_btf_set_mon_reg
Message-ID: <202310110853.681C3AB65C@keescook>
References: <20231011063725.25276-1-pkshih@realtek.com>
 <20231011063725.25276-2-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011063725.25276-2-pkshih@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 11, 2023 at 02:37:25PM +0800, Ping-Ke Shih wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Use struct_size() and flex_array_size() helpers to calculate proper sizes
> for allocation and memcpy().
> 
> Don't change logic at all, and result is identical as before.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Looks good too. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
