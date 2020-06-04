Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6B1EE9EB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgFDR6D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbgFDR6C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 13:58:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44099C08C5C2
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 10:58:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so6975547qkf.9
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2020 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ylFM7xcrRPttXnSFsxxMsniM496bjo9TahOp0BQ4KWQ=;
        b=dp1MW0oLsIVpf8P1GqlJ7ywKbTALgi380UyzwJhLZxxjLZbExXSS3+DNraBRJx+RxA
         2YNRIqPWKCJwUAt2Ionyk91M424aXFCth771TTbwhKuAi/5z09C6/Wr39Wytw6IFYat4
         ROGMU+gTfjKOfKx/KnMfK4lHl61/+H90NG+NU9ft1Ad329Ugd8oNWQRmnDyTDrH84VcG
         NHqJ/pa7Z8WtA7tv5ssR9OBolcmhh/Z0Chu/DqhjQRZD68jbMjVitMLn9/18eeVfDBtl
         W6iFo32dBc0/Xz9TBC1xS9lWFSwriSPTsiMKkjJI2/Fy1v0kJA0h8NiDLZa3m0zxOiRF
         iMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylFM7xcrRPttXnSFsxxMsniM496bjo9TahOp0BQ4KWQ=;
        b=TF1MWCC0PcF9lbvmpc/893YjiIyGbsuYkrBOcmtgvfB93qUZDBp5ac7fDKXq2f2G77
         sDEuoncUUFxjLwOmgU0OBwdbKT69ehI7QezPs0hDJ6oR8QJiLCOsAJZTjSUrSaGvE71E
         xzCfME55EnqrJcZFad216jnSc9l4Z0JTeYEHdnfbarEor2PyZ6YDJ+69hJ3Pr+0ux+/i
         Waa0hK4FvqwqckV8SIpRkTDKiiNkI0rBRfjb5BEqRt0LLb4jxt6kDxPk0/PaK0d3ITtA
         2mLCBrmHrmA4pa2nA/jM1YDZ8HLtZOFC+vBv4JYMgh+lX4sSkwEzskJY4V81/25lsDhH
         FIZg==
X-Gm-Message-State: AOAM532zvqMEPf6vreu6XXi0c4lxqxjuWoDq68YcA9Hzt4oRUx0hUmR9
        qv9MHJYBzgPg146MLt62Vxlblg==
X-Google-Smtp-Source: ABdhPJzYt2lslt13YiEsonKEZ+jBx4HFt1d65mCYXH6vxqHPQIS81ppOdKBUfUx77lLK8R8poNgzug==
X-Received: by 2002:ae9:ebd2:: with SMTP id b201mr5788109qkg.409.1591293480332;
        Thu, 04 Jun 2020 10:58:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t43sm5788444qtj.85.2020.06.04.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:57:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgu7r-001H95-GE; Thu, 04 Jun 2020 14:57:59 -0300
Date:   Thu, 4 Jun 2020 14:57:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 09/10] treewide: Remove uninitialized_var() usage
Message-ID: <20200604175759.GQ6578@ziepe.ca>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-10-keescook@chromium.org>
 <20200604132306.GO6578@ziepe.ca>
 <202006040757.0DFC3F28E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006040757.0DFC3F28E@keescook>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 04, 2020 at 07:59:40AM -0700, Kees Cook wrote:
> On Thu, Jun 04, 2020 at 10:23:06AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 03, 2020 at 04:32:02PM -0700, Kees Cook wrote:
> > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > (or can in the future), and suppresses unrelated compiler warnings
> > > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > > either simply initialize the variable or make compiler changes.
> > > 
> > > I preparation for removing[2] the[3] macro[4], remove all remaining
> > > needless uses with the following script:
> > > 
> > > git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
> > > 	xargs perl -pi -e \
> > > 		's/\buninitialized_var\(([^\)]+)\)/\1/g;
> > > 		 s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'
> > > 
> > > drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
> > > pathological white-space.
> > > 
> > > No outstanding warnings were found building allmodconfig with GCC 9.3.0
> > > for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
> > > alpha, and m68k.
> > 
> > At least in the infiniband part I'm confident that old gcc versions
> > will print warnings after this patch.
> > 
> > As the warnings are wrong, do we care? Should old gcc maybe just -Wno-
> > the warning?
> 
> I *think* a lot of those are from -Wmaybe-uninitialized, but Linus just
> turned that off unconditionally in v5.7:
> 78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")

Yah, that alone is justification enough to do this purge.

Jason
