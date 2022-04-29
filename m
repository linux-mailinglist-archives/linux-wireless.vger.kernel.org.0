Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9A5141C4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbiD2Fec convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 01:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344891AbiD2Feb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 01:34:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B997B5716B
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 22:31:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T5UV0R0003909, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T5UV0R0003909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 13:30:31 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 13:30:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 13:30:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6]) by
 RTEXMBS04.realtek.com.tw ([fe80::34e7:ab63:3da4:27c6%5]) with mapi id
 15.01.2308.021; Fri, 29 Apr 2022 13:30:31 +0800
From:   Pkshih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Thread-Topic: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Thread-Index: AQHYWTevDaEDmvkQB06rbly2/np5Fa0FjE4AgADUjrA=
Date:   Fri, 29 Apr 2022 05:30:31 +0000
Message-ID: <ba7dddf5224746daaaa4db7e3b9637ed@realtek.com>
References: <20220426063235.41650-16-pkshih@realtek.com>
 <202204290830.slUaIhad-lkp@intel.com>
In-Reply-To: <202204290830.slUaIhad-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/4/29_=3F=3F_01:55:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Friday, April 29, 2022 8:46 AM
> To: Pkshih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
> 
> Hi Ping-Ke,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on wireless-next/main]
> [also build test WARNING on next-20220428]
> [cannot apply to wireless/main v5.18-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce
> -in-Makefile-and-Kconfig/20220426-143456
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> config: i386-allmodconfig
> (https://download.01.org/0day-ci/archive/20220429/202204290830.slUaIhad-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project
> c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/5aaabdd4d9ac433ed14c1c02147c2609827739d2
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review
> Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce-in-Makefile-and-Kconfig/20220426-143456
>         git checkout 5aaabdd4d9ac433ed14c1c02147c2609827739d2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386
> SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/wireless/realtek/rtw89/rtw8852c.c:2640:2: warning: result of comparison of constant
> 18446744073709551615 with expression of type 'typeof (_Generic((__msk), char: (unsigned char)0, unsigned
> char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned
> short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long:
> (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default:
> (__msk)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
>            __write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/realtek/rtw89/rtw8852c.c:2621:13: note: expanded from macro '__write_ctrl'
>            u32 _wrt = FIELD_PREP(__msk, _val);                     \
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
>                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
>                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
>                    if (!(condition))                                       \
>                          ^~~~~~~~~

We add 'BUILD_BUG_ON((__msk & __en) != 0);' to prevent coding error during
development. The __msk and __en in the expression are constant and expected
no intersection of these two bit masks. Since we have verified this code,
I think I can send a patch to remove the BUILD_BUG_ON() from this macro.

Thank you
Ping-Ke

