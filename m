Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0063346F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 05:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiKVEbN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 23:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKVEbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 23:31:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560022516
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 20:31:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p12so12500954plq.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 20:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQoC9G5+F/Ju5PfRIYOxwBoO5pKbuPnwuuzZSSIVqIQ=;
        b=ntrjaMOFF4KcRMcRuI/OMTJHDkMcLlQDmb7qkvWl5ufL8qnIt/QiKo/0DNXErjHsKc
         wLl4+tEhemj4Y3R1gD8fzR79SACereQARlyK6w5E7RfsZLLi0RHIAGaKtewUfFKMIuDE
         gHBud7EL1xGOaQLwlHrahzz22C7CUPLRocEg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQoC9G5+F/Ju5PfRIYOxwBoO5pKbuPnwuuzZSSIVqIQ=;
        b=r5JExNOyN/28QpOxhGNQztdBHVMGseqXY91ZkpHRXxGXy85CDPpgoap4rqss8HrHbQ
         2EwRlqptfOdwNYTT+4gUIUlno9oZfk7dAI/nnC3eWd/C2KLctdIMIuVKCs/TV/OGR2Yo
         RnK7gXR3cFoDAbuB4EAIyF3lpYJtWb2drez/VqxwHFAYQjO9KXMUqWTEhPPLhvNs9Mkh
         69yeDhUGw6dPr4+79XJIRFAFMyIAxoWy5UnzsAJtjkbNmG1nN8GNB6C6eRLaI04A+TWZ
         u/bW3vzJyJHYQFdtMbMnny6q+7VBTrb4ZNDe1O52CkIz0c0x3Net6lJ/MIu5xzGUtJ+6
         obOA==
X-Gm-Message-State: ANoB5pmTagBMpEm6ZLsNJ6MZyiYJGGwCod6jeRbkQDvYIqkOsplTnjC8
        TO9DEAES0qW46jJAwfkIOYerb2hLJZeLsd4K
X-Google-Smtp-Source: AA0mqf4y3DsoXAZGKeEvsgxTtGZ+Mei0TjiZb4L/folehYpc7k3YX2pDOB7u1A/toObKXGGiEvyIqw==
X-Received: by 2002:a17:90b:3c4c:b0:218:a8a1:933a with SMTP id pm12-20020a17090b3c4c00b00218a8a1933amr10071443pjb.14.1669091469608;
        Mon, 21 Nov 2022 20:31:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020aa796cb000000b0056c3a0dc65fsm9507750pfq.71.2022.11.21.20.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:31:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:31:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: warning upon association with latest kernel
Message-ID: <202211212026.6959A4CBBC@keescook>
References: <f6cb6803-602f-91e3-8bd3-3bbbd924731d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6cb6803-602f-91e3-8bd3-3bbbd924731d@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 09, 2022 at 04:26:39PM +0100, Oliver Neukum wrote:
> I am getting this warning when I connect to my home
> wifi upon boot:
> 
> [...]
> [ 1321.321889] memcpy: detected field-spanning write (size 16) of single field "&compat_event->pointer" at net/wireless/wext-core.c:624 (size 4)

This should be fixed by commit e3e6e1d16a4c ("wifi: wext: use flex array
destination for memcpy()").

> [...]
> Head commit is:
> 
> commit f141df371335645ce29a87d9683a3f79fba7fd67 (origin/master, origin/HEAD)
> Merge: f49b2d89fb10 986d93f55bde
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Nov 8 12:30:29 2022 -0800
> 
>     Merge tag 'audit-pr-20221107' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit

Are you sure that's the same kernel? The stated commit no longer has
"&compat_event->pointer" as a memcpy argument...

-- 
Kees Cook
