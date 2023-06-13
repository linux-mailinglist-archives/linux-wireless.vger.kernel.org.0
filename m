Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD83472EBE8
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbjFMTYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMTYE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 15:24:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B991BFB
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 12:24:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3c4c1fbd7so18516465ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684241; x=1689276241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTjIPDpkQa3VuoP57lMJ7BntaNSVpd5s/6n5Z5BophI=;
        b=BFk+KLo8AyFTwl75dvJrkMUiU5O0zBWVIuH3k1X/cMgHY+owCkN+GbwZQm98xJlt6d
         Eg6pHt468GyNfzv2T3adVh2PhUhofAjkRdB2N2I1Nz2lYJwZtNtROyN6Whx4xrMUTxaE
         bnPQigDrbnYNXENBT6muXhyfb6bwSDjoEZGWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684241; x=1689276241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTjIPDpkQa3VuoP57lMJ7BntaNSVpd5s/6n5Z5BophI=;
        b=GT79alFHSL3PnVuZWakyVUf0Fyzbk/QolieNztbIasvqO9u+2tb9bfrpshrL7Aqj8D
         Xo/4SEpMy34RwuTrQnsPGRw8YYyzwpW8GtDbaB3DmW5OjmzzXYpLhopVS1Z/eTIT35Fu
         mV1IzhJftiWrbdlaIAowXPiNhWsnD+ZbtjGn0R38nFNRx0oQOOOYDj7LrfevbL0gYaf4
         dH3/xTDNWj1ED4RzMSgbbZCNwFxpVQd+MoI2+kflvOXLDoZjPEaauZvBGQkQfhWgZGdU
         FxB7gaQK54ueXX2T/nzbe+Wurph2wO6umM5TIgCIRm+0vSmn36cHtqIpIesa6SK4GtyQ
         71aA==
X-Gm-Message-State: AC+VfDw8PRb71xL69IKhT4cGOUYr7rgyukOBYroLsHKAjqejwVOrw8PE
        d0vBJtsuoAI4Iw2M05vHXFNBDg==
X-Google-Smtp-Source: ACHHUZ5Xio21b+oMrhdUH1aEbO1e1KiOm+5dj7FNMCh/97l936Jqv0lrNd7Ra4B1IM3emNt/o72jiw==
X-Received: by 2002:a17:902:e74c:b0:1b0:e0a:b7ab with SMTP id p12-20020a170902e74c00b001b00e0ab7abmr9998246plf.31.1686684241406;
        Tue, 13 Jun 2023 12:24:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001ab09f5ca61sm10631831plg.55.2023.06.13.12.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:24:00 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net/mediatek: strlcpy withreturn
Message-ID: <202306131223.F8F403D386@keescook>
References: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613003458.3538812-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 13, 2023 at 12:34:57AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since DEV_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Yup double-checked the users of the macros. Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
