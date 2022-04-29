Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3F51420E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 07:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353193AbiD2Fz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 01:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351567AbiD2Fz5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 01:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E88B82C9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 22:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435DC612C6
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 05:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E1CC385A4;
        Fri, 29 Apr 2022 05:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651211559;
        bh=mB/IIs1FR3is78wWaUZ21NGLi5UKaRuwp0Ad4RteFOg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O9J1cuCF7ETHRUNxwgV6+8Z7dNfdwrZmpqy56U883xXb9qTEqpOoeiESjWeLfuzIi
         gObtIFBOB6ZPe26LFVKCHtjKWoJQIGp38N0m9H+8EAjPwL2udJzQ0XMCuv8CPU8ew0
         6q9k44ksMqTABD3t7qoPP+OkEYt5x7351yAxUpKhj4Z1O0pgug+xocqsVUeSH+4Fsb
         0hSz3qv+lSmZqYBxrOs5jWeK5sY+W2yvw5+C9ISOawQFl2oHfuFAEcIIdDAOKeK6nK
         hp7p229fMm6LfHWDfDnDBGApLe+RIcUSLrNOvTPaGXP9Y9gmZEJXWbKQiIngVCZx/D
         XI/v8nGQer4Pw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     kernel test robot <lkp@intel.com>,
        "llvm\@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all\@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
References: <20220426063235.41650-16-pkshih@realtek.com>
        <202204290830.slUaIhad-lkp@intel.com>
        <ba7dddf5224746daaaa4db7e3b9637ed@realtek.com>
Date:   Fri, 29 Apr 2022 08:52:36 +0300
In-Reply-To: <ba7dddf5224746daaaa4db7e3b9637ed@realtek.com> (Pkshih's message
        of "Fri, 29 Apr 2022 05:30:31 +0000")
Message-ID: <877d78fnbv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: kernel test robot <lkp@intel.com>
>> Sent: Friday, April 29, 2022 8:46 AM
>> To: Pkshih <pkshih@realtek.com>; kvalo@kernel.org
>> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
>> 
>> Hi Ping-Ke,
>> 
>> I love your patch! Perhaps something to improve:
>> 
>> [auto build test WARNING on wireless-next/main]
>> [also build test WARNING on next-20220428]
>> [cannot apply to wireless/main v5.18-rc4]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>> 
>> url:
>> https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce
>> -in-Makefile-and-Kconfig/20220426-143456
>> base:
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
>> main
>> config: i386-allmodconfig
>> (https://download.01.org/0day-ci/archive/20220429/202204290830.slUaIhad-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project
>> c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
>> reproduce (this is a W=1 build):
>>         wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O
>> ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         #
>> https://github.com/intel-lab-lkp/linux/commit/5aaabdd4d9ac433ed14c1c02147c2609827739d2
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review
>> Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce-in-Makefile-and-Kconfig/20220426-143456
>>         git checkout 5aaabdd4d9ac433ed14c1c02147c2609827739d2
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
>> W=1 O=build_dir ARCH=i386
>> SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> 
>> All warnings (new ones prefixed by >>):
>> 
>> >> drivers/net/wireless/realtek/rtw89/rtw8852c.c:2640:2: warning:
>> > result of comparison of constant
>> 18446744073709551615 with expression of type 'typeof (_Generic((__msk), char: (unsigned char)0, unsigned
>> char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned
>> short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long:
>> (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default:
>> (__msk)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
>>            __write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
>>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/net/wireless/realtek/rtw89/rtw8852c.c:2621:13: note: expanded from macro '__write_ctrl'
>>            u32 _wrt = FIELD_PREP(__msk, _val);                     \
>>                       ^~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
>>                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
>>                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>>    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>>            __compiletime_assert(condition, msg, prefix, suffix)
>>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>>                    if (!(condition))                                       \
>>                          ^~~~~~~~~
>
> We add 'BUILD_BUG_ON((__msk & __en) != 0);' to prevent coding error during
> development. The __msk and __en in the expression are constant and expected
> no intersection of these two bit masks. Since we have verified this code,
> I think I can send a patch to remove the BUILD_BUG_ON() from this macro.

I'm dropping the patchset, please submit a new version including your
fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
