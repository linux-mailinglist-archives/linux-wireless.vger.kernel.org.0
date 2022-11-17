Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25A62E967
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 00:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiKQXQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiKQXQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 18:16:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C370D73431
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 15:16:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 4so3069893pli.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBaTUoDsXALrUVQtij25WDMU7eXVKHt6J9ZXCE39/vs=;
        b=mPx7GfLKwl5PN26MoaT6nRGqXps4iNeaIV3mZJ2OrRc+k8ZGxjmrhLJ5GKKMgle1Vt
         VZoTFVV72Da8WA67ax23QGqZckaZpge9lfoa35250ISwHoqYy1Rq4+5hyuKdOUb5oFKE
         7Nkj5fpNRne7ObCD/w9tabX/9KfFNvUUIoP/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBaTUoDsXALrUVQtij25WDMU7eXVKHt6J9ZXCE39/vs=;
        b=qC2NdrUqcR+C0u5XmPQP0NtpfFyOoAj2qDNJt+WMyZc80ZbQG3PtyvK/RoIVWdvLEZ
         tysUZPhvHpk2kr2tV32hUIUooTsOV/WEzzDogPB6/UR8oz0uKPbQYFszedn7ET0vmnKC
         zs7FpEmjgskaVf+b7hjEeUwnXI7fvReKcsxFAVQa0ODouyoSJo0JrcFuJSX10ciBLY+N
         0fF2DTqImIoxDZ0HxEBxdol8EJDkXsBE5uqrVQSr2XiDhlGGpOpXlXiaL+mGDZ2DysVe
         8reZbrg/5Q+4kLmeCrtiIqhm6D1lu/KBLeIYsa/IJemNCiXxuPJ18G3eUoPe1sJwkrbH
         gddw==
X-Gm-Message-State: ANoB5pnpwBC+h0Y1r+kdIaa2GXXSWobhqKAQX8wdC0IPNDEwYXd2fF5o
        SwMVZgoDNGpfiLqMFrndW6yPAQ==
X-Google-Smtp-Source: AA0mqf4Dk5voBB082r8Rrpwvcj3grSiIUC5dxPvucpmLRslxiH0tXg3k9C9HsKhUo4r5XO/MYhuZEA==
X-Received: by 2002:a17:90a:b285:b0:216:ab1b:98d0 with SMTP id c5-20020a17090ab28500b00216ab1b98d0mr10943008pjr.67.1668726994206;
        Thu, 17 Nov 2022 15:16:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b00188fc6766d6sm334840plh.219.2022.11.17.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:16:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:16:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] wifi: brcmfmac: Replace one-element array with
 flexible-array member
Message-ID: <202211171516.4BDCE17@keescook>
References: <cover.1668466470.git.gustavoars@kernel.org>
 <7694550aa9a2753a73a687f61af9441c8cf52fd7.1668466470.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7694550aa9a2753a73a687f61af9441c8cf52fd7.1668466470.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 14, 2022 at 05:01:11PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct brcmf_gscan_config.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/241
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
