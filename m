Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8777EAFE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjHPUrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346282AbjHPUrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 16:47:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA720271D
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 13:47:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5212212a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218825; x=1692823625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFQfU8aEhvmJ8mwzz0baeIXueaOetJfmys9es6pphgI=;
        b=DGE1T9Sbej9zcyzxPncroG5xoKAEuMJ//ezL87vF3Oa3Bd2qLrgbqfpLpjcpD6/6tH
         8w29PWs65ltgc3x7CDqLhbMrMhNgwssMWZk7+q8ou/SFj3ICsEmLGvZc74CkhkNy5rP/
         DiBw4qqelMcXE0I9O+Y6RVA57NXXf/gEo17P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218825; x=1692823625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFQfU8aEhvmJ8mwzz0baeIXueaOetJfmys9es6pphgI=;
        b=Ejot3657SsXUPlx9Ua1N2vxs+KvIPu9O3QiBedHQT6gE+/MVJttAioadjYVUDeBj67
         fGvHujuaWKIopyOl1RjuUgU7r7t/9LOVM6ZCHm7K75i18Nrqy76V4jWPXh1YAEyC7MZd
         Qj1B+AYnlUI/uH5S1j2f0plCkZMswHjORKj5ckO0qTxPShnKeGouzliujikKYVo7IyPq
         DcqVnxO5wAXn54Qs3CP6BByHVweT3L7jLsv49CZ6kFAsPHlvK/vE8pp+jVigbmUBCK+F
         13oW6yNkiPq8FyEw8LSbgfpSXFCjKZTZhRhG/eRosoPUxGWYubwQYFEirgMdxpltQWyr
         i5tg==
X-Gm-Message-State: AOJu0Yy6O+2EfZYKmDqW14w9hh+mCBYPMECMc9zPSF+HcbK8BwG3y85t
        gqaGopSJQ3sp6SXGVCBp6T3xCw==
X-Google-Smtp-Source: AGHT+IES1w4tkDFKq5YcFhAKHa+deut5kxN8giMZyI/wU5w9EzUk6JiwbFumYG0twm1YJmzwvUs7mQ==
X-Received: by 2002:a05:6a20:160b:b0:138:1c5b:24c3 with SMTP id l11-20020a056a20160b00b001381c5b24c3mr3917200pzj.49.1692218825365;
        Wed, 16 Aug 2023 13:47:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r17-20020a62e411000000b0068874e1faf2sm2359224pfh.56.2023.08.16.13.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:47:04 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:47:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ipw2x00: refactor to use kstrtoul
Message-ID: <202308161346.23B40C1569@keescook>
References: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
 <202308040120.183400A04@keescook>
 <87wmybjhyh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmybjhyh.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 04, 2023 at 12:05:26PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Wed, Aug 02, 2023 at 01:23:06AM +0000, Justin Stitt wrote:
> >> The current implementation seems to reinvent what `kstrtoul` already does
> >> in terms of functionality and error handling. Remove uses of `simple_strtoul()`
> >> in favor of `kstrtoul()`.
> >> 
> >> There is the following note at `lib/vsprintf.c:simple_strtoull()` which
> >> further backs this change:
> >> | * This function has caveats. Please use kstrtoull (or kstrtoul) instead.
> >> 
> >> And here, simple_str* are explicitly deprecated [3].
> >> 
> >> This patch also removes an instance of the deprecated `strncpy` which helps [2].
> >> 
> >> Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
> >> Link: https://github.com/KSPP/linux/issues/90 [2]
> >> Link:
> >> https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> >> [3]
> >> Cc: linux-hardening@vger.kernel.org
> >> Suggested-by: Kees Cook <keescook@chromium.org>
> >> Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > This looks correct to me. I would be curious to hear back from the intel
> > folks if the interface continues to work correctly with real hardware.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> This is ancient hardware, not sure if anyone even have a working setup.
> And even if they would have one I doubt anyone uses this sysfs interface
> for anything.

Just a quick ping; is this patch ready to land?

-- 
Kees Cook
