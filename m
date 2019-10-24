Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDAE2BA4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408796AbfJXIAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 04:00:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfJXIAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 04:00:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD32360FB7; Thu, 24 Oct 2019 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571904035;
        bh=uyE0du6aINZ/tgcx07shxgD8/KDBdQQYzJqjHb22QUU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cB4eRGzmIuMCtaBmu6mKAEpQ2FuvA2XoFfXc8QL814LZZfDS6J1RFl1g/VRJWlbro
         o1R/EV5zeZm7p6slE/11aNUuZZMm34Y1OdE32jHyXyROS9cskB2l/puRBUnR7AtPpw
         B8UihHGgTZ/n4BHibNRbgR4ur0YIhNpRZ7d3C2CQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DA6560F6F;
        Thu, 24 Oct 2019 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571904032;
        bh=uyE0du6aINZ/tgcx07shxgD8/KDBdQQYzJqjHb22QUU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P52mX0I+OSKr8MjczzJWFxPJe3QSxmO+2HcgZ2dW4ss2S3jk5K9X2I+HouSUlZgD1
         udelvvHDo5yxn+adAtYjv2Fd6nDAYMT4Mh4/s6znDlmEA2m7JFQASYY3hhwQE+MBsr
         QfJJMVJ6EZ8KPHsdaRO43xmgh9RN/mssd2qKClrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DA6560F6F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Tzu-En Huang <tehuang@realtek.com>, kbuild-all@lists.01.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Chris Chiu <chiu@endlessm.com>, linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 91/97] include/linux/bits.h:23:11: warning: right shift count is negative
References: <201910241518.1B6Ev5VT%lkp@intel.com>
Date:   Thu, 24 Oct 2019 11:00:27 +0300
In-Reply-To: <201910241518.1B6Ev5VT%lkp@intel.com> (kbuild test robot's
        message of "Thu, 24 Oct 2019 15:51:18 +0800")
Message-ID: <875zketvxg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Tony, can you send a followup patch to fix this warning?

Kalle

kbuild test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> head:   b298800dd8ee7250bf04b4dbd151e1a971b6df91
> commit: f39e9bd49a3d612a2489b774265107f61ffd82fa [91/97] rtw88: add set_bitrate_mask support
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f39e9bd49a3d612a2489b774265107f61ffd82fa
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=mips 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/bitops.h:5:0,
>                     from include/linux/kernel.h:12,
>                     from include/asm-generic/bug.h:19,
>                     from arch/mips/include/asm/bug.h:42,
>                     from include/linux/bug.h:5,
>                     from include/net/mac80211.h:16,
>                     from drivers/net//wireless/realtek/rtw88/main.h:8,
>                     from drivers/net//wireless/realtek/rtw88/main.c:5:
>    drivers/net//wireless/realtek/rtw88/main.c: In function 'rtw_update_rate_mask':
>>> include/linux/bits.h:23:11: warning: right shift count is negative
>>> [-Wshift-count-negative]
>       (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
>               ^
>>> drivers/net//wireless/realtek/rtw88/main.c:622:17: note: in
>>> expansion of macro 'GENMASK'
>      u64 cfg_mask = GENMASK(63, 0);
>                     ^~~~~~~
> --
>    In file included from include/linux/bitops.h:5:0,
>                     from include/linux/kernel.h:12,
>                     from include/asm-generic/bug.h:19,
>                     from arch/mips/include/asm/bug.h:42,
>                     from include/linux/bug.h:5,
>                     from include/net/mac80211.h:16,
>                     from drivers/net/wireless/realtek/rtw88/main.h:8,
>                     from drivers/net/wireless/realtek/rtw88/main.c:5:
>    drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_update_rate_mask':
>>> include/linux/bits.h:23:11: warning: right shift count is negative [-Wshift-count-negative]
>       (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
>               ^
>    drivers/net/wireless/realtek/rtw88/main.c:622:17: note: in expansion of macro 'GENMASK'
>      u64 cfg_mask = GENMASK(63, 0);
>                     ^~~~~~~
>
> vim +23 include/linux/bits.h
>
> 8bd9cb51daac89 Will Deacon     2018-06-19  15  
> 8bd9cb51daac89 Will Deacon     2018-06-19  16  /*
> 8bd9cb51daac89 Will Deacon     2018-06-19  17   * Create a contiguous bitmask starting at bit position @l and ending at
> 8bd9cb51daac89 Will Deacon     2018-06-19  18   * position @h. For example
> 8bd9cb51daac89 Will Deacon     2018-06-19  19   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> 8bd9cb51daac89 Will Deacon     2018-06-19  20   */
> 8bd9cb51daac89 Will Deacon     2018-06-19  21  #define GENMASK(h, l) \
> 95b980d62d52c4 Masahiro Yamada 2019-07-16  22  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> 95b980d62d52c4 Masahiro Yamada 2019-07-16 @23  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 8bd9cb51daac89 Will Deacon     2018-06-19  24  
>
> :::::: The code at line 23 was first introduced by commit
> :::::: 95b980d62d52c4c1768ee719e8db3efe27ef52b2 linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
>
> :::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
