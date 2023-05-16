Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAE7055E1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjEPSUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjEPSU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 14:20:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D773A5E1
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso8773495ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=ZpDWOGHhmLyAAR3xhqoNa9cHCEOfaCd0mVmq1oY9OAifiLQJPIAeDcvcIht0WKv8cy
         E4P4LnxaKMWlpehlw+14xCiOVeHMnRMwzLYGGBcC/85waa4EQvFMxrt3dhJbR8aZLMZj
         7MB+YXAb06DvCz9MejAWuoSkxao6BIe7GZygE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=OCeLqsICvIgQkgcIOjIVYlmi80mF8HhFY1jM1YKmD3SdjWDFZf14OBCofQ56Qw6xAg
         Jf9OHQkdnBWGXRW0KWuzwVlpojuIKUhT/C9kVOfZoCqoAKhnhy4Hh6hCF9T27zIVd81m
         NY4d78uaXyK6/IIELtlNgLBGjlidcOHqyXRg7B7jolLBYtB939Y9IkHSlxLI0+fv5dtL
         WCFwDr/V+TNhmLteGAOcmRfKehxD2y2sAOnh//2FZEVriIlIAWJbTRUbJ+g1nSyaf39q
         HJ/V/igqONBojV6BqtpxrvWKd0PJLJV6vDFecxOMw+CBI8SYTAkT1S6QE833XFM7360Q
         8liQ==
X-Gm-Message-State: AC+VfDz/yWpIisH7En4gbMXVJTLlCC2lfOJ3GYOfizHu5xumokcX9Xlf
        hCp1GRBiHP6b+yEs12mmR3LQbA==
X-Google-Smtp-Source: ACHHUZ4CrDdQ4iLXNCzFZanLvMVQj9bV0mnZNPCVTJTpjTHbdVtXwUPj91zfKnKk5etlpLq1vX01gA==
X-Received: by 2002:a17:902:d507:b0:1ac:310d:872d with SMTP id b7-20020a170902d50700b001ac310d872dmr50492221plg.52.1684261218846;
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001a69d1bc32csm15799763pll.238.2023.05.16.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161119.A5486474@keescook>
References: <ZGKHM+MWFsuqzTjm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKHM+MWFsuqzTjm@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 15, 2023 at 01:25:39PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated, and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/288
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
