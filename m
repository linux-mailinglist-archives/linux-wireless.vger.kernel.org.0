Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE87D7A4A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjJZBnc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 21:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 21:43:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEFBD
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 18:43:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b7c234a7so2778405ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698284610; x=1698889410; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGwXVTB04ZGJJLn87Invv5qM2NqT5JzT/f4oJ1gbXb4=;
        b=jBok9ibgA6HnfHf+lpB/4Q29k1e7+ogTflHSgDkAlzUmgT7gaQGrQxrjQcTV1q16xk
         Vbl+vxSjEywsJfcxovkkmxzA7ORR+tOT4OjyrSdgBSSxhxNH9kxLY70EjgLrerVNIvZt
         +bcyVApSyoNkpmS2y6cZqG7UxSOhYBtU8MSfDWUQksJeKmtl/FNJRRLfyl++4Dx8xEZl
         0I4KjB0eGTl1Ey/y+rIwch1ZPyhZIYWssHqlUqZ3eATZg+o4QW5egc9VLaugXzGDsK3w
         NTE06FVD4Ymv70nEh69uyiZd5LH3D3DB3IdrIkeAsNpVe0LV5hKth67Ag1R4bJ+XhsV/
         /JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698284610; x=1698889410;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGwXVTB04ZGJJLn87Invv5qM2NqT5JzT/f4oJ1gbXb4=;
        b=bggCipywhpvvtxoh03M71MBI43dOgO8SUjtRIYSwl1KSZJokgSj3nssgPC4GUv57Im
         Fdm+sflLzVMkSPhdAdJAItO0x4+xNmlFHJNBHeLrXA2gJQmi+sZYfE7QKtYdeO+P5Cyf
         Ds8tuyPi4OwcbZFPr9vLQLUuQqdp4s4ZGtiSt79loonNdB7PxgqtI9rUZljOCKnurJik
         IzhRdkzfPUPNMeAwlu8aFcqo3UtbFMUeeMYeWqlkDG8PSYbfyZhTomwQfwEtloSS7NZT
         +7WUjEzU28D4CAHCFTrDUZVoRuC0SlFhHAnuYuZQ+MSt5kud8fPN6tmkvBCbKHcnw5yX
         f7/w==
X-Gm-Message-State: AOJu0YyxEBYgT01I+1dn7/heEfHUk6LI2Hnv0389w13mSRb/SWFbb5Cw
        qt+dobzuphTP8efVuPTfa98=
X-Google-Smtp-Source: AGHT+IFc6kcS+8cs9veTthYuML3rqPWwbB+nGCx7gM5rJt2Ukz+a4h3Nigf90/mZSU00g0TlyeHnKA==
X-Received: by 2002:a17:90a:d80e:b0:27d:568b:a741 with SMTP id a14-20020a17090ad80e00b0027d568ba741mr16721475pjv.41.1698284609679;
        Wed, 25 Oct 2023 18:43:29 -0700 (PDT)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id y92-20020a17090a53e500b00274e3e5f334sm2910699pjh.0.2023.10.25.18.43.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Oct 2023 18:43:29 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:43:27 +0800
From:   Jiazi Li <jqqlijiazi@gmail.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jiazi Li <jiazi.li@transsion.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
Message-ID: <20231026014327.GA24345@Jiazi.Li>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
 <97bfc661-132c-48c1-a6c0-c662c1b37db1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97bfc661-132c-48c1-a6c0-c662c1b37db1@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 25, 2023 at 09:04:48AM -0700, Jeff Johnson wrote:
> On 10/25/2023 3:33 AM, Jiazi Li wrote:
> > If cfg80211_update_assoc_bss_entry call rb_insert_bss re-insert bss
> > failed because cmp_bss return 0, this bss->rbn will continue to hold
> > expired data, such as __rd_parent_color.
> > And this bss still in rdev->bss_list, maybe double erase in
> > __cfg80211_bss_expire later.
> > Double erase a rbtree node(with expired parent and color data) maybe
> > corrupt rbtree, so add a in_rbtree flag to fix this issue.
> > 
> > Signed-off-by: Jiazi Li <jiazi.li@transsion.com>
> 
> Note your Signed-off-by doesn't match your e-mail address in your e-mail
> header. From the actual e-mail source it seems Google is trashing your
> headers:
> From: Jiazi Li <jqqlijiazi@gmail.com>
> X-Google-Original-From: Jiazi Li <jiazi.li@transsion.com>
> 
> That needs to be resolved
Thanks for your reminder, I will use the same e-mail address in the
feature.
> 
> 
