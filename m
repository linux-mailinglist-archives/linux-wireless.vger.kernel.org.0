Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD15EB415
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIZWDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIZWCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 18:02:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387EEBD66
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 15:02:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8313854pjk.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=U3wnme3rYduyoVtIGUlTO8+VEkNnq6ssvexioDxXiO0=;
        b=m7A9wPP+UVXaKk5udgflsFMHhHQwhc4ksTnYsMbqMfDG+zGudxILZCBMPvDouo6CdU
         OYBbw1JYGR6PGl6yZEGs2tGERHcfDFJ6TvruMNhy75dUg2xdl101snMyzJHp/rPxtPbn
         pJCMR6qMtcCD/8rP213URMXb+s6hjzbt1RY/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U3wnme3rYduyoVtIGUlTO8+VEkNnq6ssvexioDxXiO0=;
        b=UWvpk1om3MTuBxOYdsT2MYO8GZqjYVXuwZGQTGZdRgsICcZX2b2CoR6LerRl+Z1Oxr
         i5PLRCf1qeRSxSApHuT9ll2+SBEEvrc1aUBo6BEFWuY7CGd9Hmf6JW/+BoOSaGW/TaET
         6ycAlwkNiOMvGAFdKAPHQtemUANAHoEJdf+leZonvD/h6yitjLpjNZVK0LrZXidzPhu5
         ljLAA75QNvjdoxYTy9hOljuPBKZbE3KobnLBngykNwwGXa4W6mqMFkp0nRmNXscnJ0tg
         7nxs6y4DiicJHibF43a0XcUuvJCaRtJA8a4HwRGwC+GOooIXg3GoU/OX+uIYxeDKVkrG
         2K7Q==
X-Gm-Message-State: ACrzQf2eGzM5wwr3xj0armp6vCPWibKT1pJXliU0OcPabCTo9le7vuCu
        YwjWYH2QEW+mwO9QExb1NMHIuw==
X-Google-Smtp-Source: AMsMyM6CvAcNqkfH+luPZWoDW5EO95r3BSMZ19DrskXhps5m5gllCO8uEBnH0R9tyeEajnQjAOWoaA==
X-Received: by 2002:a17:90a:fc98:b0:202:52cf:c117 with SMTP id ci24-20020a17090afc9800b0020252cfc117mr917381pjb.26.1664229740742;
        Mon, 26 Sep 2022 15:02:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b00540d75197f2sm13197405pfq.143.2022.09.26.15.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:02:20 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:02:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ipw2x00: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261502.5E16542AB@keescook>
References: <YzIeULWc17XSIglv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIeULWc17XSIglv@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 26, 2022 at 04:49:04PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/220
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
