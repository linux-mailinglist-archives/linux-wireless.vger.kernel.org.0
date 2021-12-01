Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB86464905
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 08:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhLAHqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 02:46:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhLAHq3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 02:46:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0C9CB81691
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 07:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0D0C53FCC;
        Wed,  1 Dec 2021 07:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638344584;
        bh=jCYZN6tqdr2d7Mcsu93aXr40QkUGF3bj18VwIlxOtgo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=lQe1ADjXYT0/MQRkw9yz++Q4WLW6f8VpkpNqWj7vbJrk9KSG/vc7N3P/CWktvRWZC
         dkTbsLNwNoORDhVlq9zJkgDP7w6x6pM3QWt4dCy5JFG0iahDW5JLpXJ6J7vYEXuhBn
         tTmtdlhaxu0PAAlfD0/6mycBdu9HuPjBW0VqJZVcz+oa2oF30MxUIXFDKoS0vTOZD2
         BPpX3zipBRu/vC7xY0kuWLLTxoDzokLLGZDn8DRRq/39UfyiREQhyMqaKBi1v1vOgQ
         0TiyxINHYZdmWhcxiFARblaglNknW2upLlhSlaBOWcix2YUtMnmS8rDUIpCS2ZPJbp
         9wPL4wDoQVsqQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 3615/4301] include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
References: <202111302102.apaePz2J-lkp@intel.com>
Date:   Wed, 01 Dec 2021 09:43:01 +0200
In-Reply-To: <202111302102.apaePz2J-lkp@intel.com> (kernel test robot's
        message of "Tue, 30 Nov 2021 21:21:01 +0800")
Message-ID: <87pmqgsrcq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   34f255a1e91ab44ff8926cf8294ff9144e62e861
> commit: 5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4 [3615/4301] libertas: Use struct_group() for memcpy() region
> config: arm-randconfig-r011-20211129 (https://download.01.org/0day-ci/archive/20211130/202111302102.apaePz2J-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 5fd32ae0433a7af37eac27ace3aabae8cb7c2fc4
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from <command-line>:
>    drivers/net/wireless/marvell/libertas/tx.c: In function 'lbs_hard_start_xmit':
>>> include/linux/compiler_types.h:335:45: error: call to '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
>      335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:316:25: note: in definition of macro '__compiletime_assert'
>      316 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
>      335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    drivers/net/wireless/marvell/libertas/tx.c:116:9: note: in expansion of macro 'BUILD_BUG_ON'
>      116 |         BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
>          |         ^~~~~~~~~~~~

Kees, can you take a look at this build error? You added the
BUILD_BUG_ON(), right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
