Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B4B3DB13C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 04:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhG3Cjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 22:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhG3Cja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 22:39:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6426CC0613C1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 19:39:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a20so9354987plm.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHuO3a4lOV1ak/eQfFp+AAaG2sMLeGDAKzyV4AOK0RE=;
        b=j8UqRed6HOKlyVkSoS05EJXewa+eUCRzTuOxtwGX5fDIEozj4tBUf/Pb6CHGAaLmaA
         0lvkqjJ4PTgUwIVlwmbeuhhcBcZAYaZZ7EQBi+8oHJhkCGFeyBQklkhQLoPwf8W6+nzt
         YRqHGvdjQepkZ10ZG9+WbgEXKCY3JTIc9WoQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHuO3a4lOV1ak/eQfFp+AAaG2sMLeGDAKzyV4AOK0RE=;
        b=IoyNuXhOTDVGIh45aYRS5AphSq4OGSKe4l9a/of+V7v+1+Hxgp64ZFHJMLaUJYlPko
         HyXZdO8Ezx6Gs6MRvRLv5ncujcBGIElJoSarcU8q4pt0TRkd4MZflzTLNpSuuaVmqEF/
         BN8hpNQqiyvZnqHueUyHkUbym/Hh6C3twga8mflXMJzEHFFpCi6DPb4Aun2b32AJAkdZ
         49pG1gCaCFz0Kbe8MdtlgrVdiHrRubgF0wyz1EZuWnUC0g2C0iGSvGy4Oye74KKQcEJ2
         dRrKC1gVkyS8mN8OF7n/JsXcTdBCCLYxlt4e1DONxRxwpyUsgmYrRYAUtDsLTuk4tIV8
         x9oQ==
X-Gm-Message-State: AOAM5312L5AtO3vldbbk6Ev9V95msv79N/Cd0C1+11s2jb3Wv6D/24oc
        QXvyR8bR+WD1j5oe9CdRMY5Ltw==
X-Google-Smtp-Source: ABdhPJzo5u8p9hbDXhUl8yhRH+ETwKt9UE7110pr1bIcu8dZOn97UljUZ8gMIyei6sG4Pc+UC9HyCw==
X-Received: by 2002:a17:902:c409:b029:12c:8d18:a03 with SMTP id k9-20020a170902c409b029012c8d180a03mr518065plk.81.1627612764988;
        Thu, 29 Jul 2021 19:39:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm195258pfn.70.2021.07.29.19.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 19:39:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:39:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 34/64] fortify: Detect struct member overflows in
 memcpy() at compile-time
Message-ID: <202107291938.B26E4916@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-35-keescook@chromium.org>
 <d2f9f21c-4d6e-9458-5887-ca5166d07942@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f9f21c-4d6e-9458-5887-ca5166d07942@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 28, 2021 at 01:19:59PM +0200, Rasmus Villemoes wrote:
> On 27/07/2021 22.58, Kees Cook wrote:
> 
> > At its core, FORTIFY_SOURCE uses the compiler's __builtin_object_size()
> > internal[0] to determine the available size at a target address based on
> > the compile-time known structure layout details. It operates in two
> > modes: outer bounds (0) and inner bounds (1). In mode 0, the size of the
> > enclosing structure is used. In mode 1, the size of the specific field
> > is used. For example:
> > 
> > 	struct object {
> > 		u16 scalar1;	/* 2 bytes */
> > 		char array[6];	/* 6 bytes */
> > 		u64 scalar2;	/* 8 bytes */
> > 		u32 scalar3;	/* 4 bytes */
> > 	} instance;
> > 
> >
> > __builtin_object_size(instance.array, 0) == 18, since the remaining size
> > of the enclosing structure starting from "array" is 18 bytes (6 + 8 + 4).
> 
> I think the compiler would usually end up making that struct size 24,
> with 4 bytes of trailing padding (at least when alignof(u64) is 8). In
> that case, does __builtin_object_size(instance.array, 0) actually
> evaluate to 18, or to 22? A quick test on x86-64 suggests the latter, so
> the memcpy(, , 20) would not be a violation.
> 
> Perhaps it's better to base the example on something which doesn't have
> potential trailing padding - so either add another 4 byte member, or
> also make scalar2 u32.

Yup, totally right. Thanks! I've fixed the example now for v2.

-- 
Kees Cook
