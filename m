Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBCB465308
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhLAQpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhLAQpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 11:45:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE1C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 08:41:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b68so25067921pfg.11
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wR5jjKLsTieAQ8C8yQzasyYIBAjy3LjmXgCG+jqKvYU=;
        b=IsTe367/uQD2PQQWH11ENZcGTkH8hxo+1dW1nykj9YEXJF16z60OuV0Iiyhu6OCK9O
         I52CUJe6xpby/mULup6QtXJnbaiZEE0/K6D0gbzzzkIVvHscfB6tzD5m9e4CnRvfmNC+
         DAuLDz4khGG83C0l0kvKTJfKE7RjbrcEopRlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wR5jjKLsTieAQ8C8yQzasyYIBAjy3LjmXgCG+jqKvYU=;
        b=5Wu+oqsalbYdQU3e1rgzP0iMipYO/GqPkau0EFMZVcL9mNfhZzH1vBAUPXitPn/+Ri
         vgnt0yxd2bHGjk403khArhz+w1dxjbRR5QpBsHCJK7AcHWTSFuTqO8c2LUq05CASYMmr
         GfT8FXvducD3gqiYi5yIq0dK5jDLHsv1kWfmO52gaYDjM0gEmXbFOQR0AZJhJeXOYD3X
         f7tU16UpDCnZdkhvOsvvhu+QksIpyV5sr+m08boi9bnr4D6YsW2FEP/HAG2Jk7a9VPoc
         gCS9/z9UN2WSZ+9iNEeuinSUS8Qe+9YddBlg1LMP4Vp2YhZDiHaH1CAxfaGng6KFIntR
         5csA==
X-Gm-Message-State: AOAM5338mPzBG5pkIi84dpphTfqHztOuGqrHemePzGt45XNeCzC437dp
        yMZoKEcQQG2c1xlsmtjxQoWVKwDc/eA/Ig==
X-Google-Smtp-Source: ABdhPJyYljkuWVQRv6cQ55aDNMtTmqmFU6iEfKXxnsDFSRMl1U5XoCenoXqnHJppbFS6DJrK1RScXw==
X-Received: by 2002:a63:34f:: with SMTP id 76mr5325125pgd.609.1638376916947;
        Wed, 01 Dec 2021 08:41:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm180735pgv.65.2021.12.01.08.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:41:56 -0800 (PST)
Date:   Wed, 1 Dec 2021 08:41:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 3615/4301]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
Message-ID: <202112010840.0AD4D41162@keescook>
References: <202111302102.apaePz2J-lkp@intel.com>
 <87pmqgsrcq.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmqgsrcq.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 01, 2021 at 09:43:01AM +0200, Kalle Valo wrote:
> + linux-wireless
> 
> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   34f255a1e91ab44ff8926cf8294ff9144e62e861
> > commit: 5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4 [3615/4301] libertas: Use struct_group() for memcpy() region
> > config: arm-randconfig-r011-20211129 (https://download.01.org/0day-ci/archive/20211130/202111302102.apaePz2J-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout 5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from <command-line>:
> >    drivers/net/wireless/marvell/libertas/tx.c: In function 'lbs_hard_start_xmit':
> >>> include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
> >      335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >          |                                             ^
> >    include/linux/compiler_types.h:316:25: note: in definition of macro '__compiletime_assert'
> >      316 |                         prefix ## suffix();                             \
> >          |                         ^~~~~~
> >    include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
> >      335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >          |         ^~~~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
> >       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >          |                                     ^~~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> >       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >          |         ^~~~~~~~~~~~~~~~
> >    drivers/net/wireless/marvell/libertas/tx.c:116:9: note: in expansion of macro 'BUILD_BUG_ON'
> >      116 |         BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
> >          |         ^~~~~~~~~~~~
> 
> Kees, can you take a look at this build error? You added the
> BUILD_BUG_ON(), right?

I will investigate! Given this doesn't happen on allmodconfig but
a randconfig trips it, this might be finding a legit issue, but I'll
report back more details.

Thanks for the heads-up!

-- 
Kees Cook
