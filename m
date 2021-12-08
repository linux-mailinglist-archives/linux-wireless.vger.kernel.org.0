Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26046CDDA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 07:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhLHGmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 01:42:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57092 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbhLHGmc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 01:42:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6043ECE19BA
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 06:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A22C00446;
        Wed,  8 Dec 2021 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638945537;
        bh=CQRZytf4mb67LQGv+pnIu08CGYCF8we8c4EYo9tUGIo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BXbsmGJTCk6trTIZJhn/KYbdUZ8TJUjCN9LrcKDzzIgj42XMkwKPKLa8+/HBlyXQv
         LdGDGEB+akMCxePlM1Dkz1jJQUQJGLTj1ZZaAd2DnDDsMYRP6+9cH7sfEVb7odhfR4
         tpZgiaYuBLl9yY4Snxv3wdWU1jNXn14ZZMNh5+bxDPDR67i68f0FPecoxs4eHWw1ZC
         ps2doLPeTuR6RDntvLN4ILVTHUwLC74wh1fFtGdsuV0l2ka2jgzhx9F4mX1oTT4baA
         uoqTHJ/MTGSBPrYdnCj635D3yF9eMDNsBiv/AJ79Nbc4rwCCezw39wWQdJrCFkihym
         vQm7P6ENxnMIg==
From:   Kalle Valo <kvalo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Loic Poulain <loic.poulain@linaro.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [linux-next:master 3307/5418] drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28: sparse: sparse: incorrect type in assignment (different base types)
References: <202112080339.rKLd0aDI-lkp@intel.com>
Date:   Wed, 08 Dec 2021 08:38:50 +0200
In-Reply-To: <202112080339.rKLd0aDI-lkp@intel.com> (kernel test robot's
        message of "Wed, 8 Dec 2021 03:24:25 +0800")
Message-ID: <87y24vfvnp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   04fe99a8d936d46a310ca61b8b63dc270962bf01
> commit: 7a6cfe28ae3ef6a78774fd1e21e3b76c90937112 [3307/5418] brcmfmac:
> Configure keep-alive packet on suspend
> config: microblaze-randconfig-s031-20211207
> (https://download.01.org/0day-ci/archive/20211208/202112080339.rKLd0aDI-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7a6cfe28ae3ef6a78774fd1e21e3b76c90937112
>         git remote add linux-next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout 7a6cfe28ae3ef6a78774fd1e21e3b76c90937112
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0
> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir
> ARCH=microblaze SHELL=/bin/bash
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
>>> sparse: sparse: incorrect type in assignment (different base types)
>>> @@ expected restricted __le32 [assigned] [usertype] period_msec @@
>>> got restricted __le16 [usertype] @@
>    drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
> sparse: expected restricted __le32 [assigned] [usertype] period_msec
>    drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3911:28:
> sparse: got restricted __le16 [usertype]
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30:
>>> sparse: sparse: incorrect type in assignment (different base types)
>>> @@ expected unsigned char [assigned] [usertype] keep_alive_id @@
>>> got restricted __le16 [usertype] @@
>    drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30: sparse:     expected unsigned char [assigned] [usertype] keep_alive_id
>    drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3913:30: sparse:     got restricted __le16 [usertype]

Loic, please send a fix for this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
