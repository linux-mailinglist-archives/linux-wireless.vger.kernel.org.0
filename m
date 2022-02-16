Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE87B4B9267
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiBPUgB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 15:36:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBPUfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A252AB522
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:35:32 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so3472666pjh.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 12:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZiuFSTUba1ATIIXLsTWrQztSTfw4EGm3xQIUgvLL4Mk=;
        b=YXjfl7xGUMOFGqUfuV8g8dqmpsyREkxR2ZgdxcoP9kPzp2YmCd3cfWw9AYwPKinBnf
         gcJwe5aFs2j51u2c3EReqPEpZ2SfOf7qXc4tnTxvI2sZZl4qjbFKLZZz/kztyyRitwg8
         YzpybCwUVrhXH9Z5tsATr5UR9Cv23DeMtqssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZiuFSTUba1ATIIXLsTWrQztSTfw4EGm3xQIUgvLL4Mk=;
        b=bLrup8pZoJ9Vgm+esPf67T9bSYFMfi9oMCNLCwa2npKpcvuU759yF1l/ndeAZuBjVz
         BAiImMytdKow22oTB08xftr6E5j++Ca6sSVSm6Mvs8R0b+33b4Bt2VnhVA3kFPHiUqgC
         wsPJSFo0QqFLa9lAOje9RD1nkkGFxFyB5Bnq0BEewfc2i2euXpCwXrcG3+4lCLL2qXEY
         /fu2dGvN/rC9zPASWaMFqiJeRS68mokaoXxWbqehh6x8PDYMm3FvLcKPYQtaWmb66432
         EQqVPm5FNkLh+nJxpLer2xZP3Pixku85j3quROKz8Tkl+U+gqzfiX4EQAxKoeQj9Y8+M
         cZ8A==
X-Gm-Message-State: AOAM530lpWSZY0s5xBDXSgBe+lQZJUzTWnPb83Vs2PORpm1uUG8TWIX1
        sGQTvzjvQom6a3KWhOwf+kqMdg==
X-Google-Smtp-Source: ABdhPJwwN7eFoWkSBD6A2li7xRKGQqNGXljyJPz1+jlWuOdkrFtGLad3asl8gm9epTBPDnceOx4M1A==
X-Received: by 2002:a17:903:281:b0:14c:f3b3:209b with SMTP id j1-20020a170903028100b0014cf3b3209bmr4129964plr.87.1645043731720;
        Wed, 16 Feb 2022 12:35:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm44055299pfu.127.2022.02.16.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:35:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:35:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tw89: core.h: Replace zero-length array with
 flexible-array member
Message-ID: <202202161235.0C91ED227@keescook>
References: <20220216195047.GA904198@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195047.GA904198@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 16, 2022 at 01:50:47PM -0600, Gustavo A. R. Silva wrote:
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
