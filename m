Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61924513FBA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 02:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbiD2AtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353238AbiD2As5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 20:48:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0D887AD
        for <linux-wireless@vger.kernel.org>; Thu, 28 Apr 2022 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651193140; x=1682729140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1KTEg3E2fLwyJhjp59+GD2mzYup5rJkjawtWtHfXEQ=;
  b=DetFJo6w+do9saYgORtS4P+czmN8S3zz0Cnk0VfuYp/EQLC08ZJPLYE4
   Ciw65oR+ioEeyaBHCd7oaAVHJrmTz9kCEciSutbE8aH5sKsBc19KKUWsp
   Qo8m+jTRd2xRvlgeTRBK+BQ0cfS/szE8YgRg7pufeqwvwK6gxVGWuYva2
   U2WUT0DQbIHBxwBMsKesIXjKx6LfCebk1dQ3a/NRPrpSBqSgR9Azntf+6
   su3qMqoZSlSyof/8bORbfC+m6EhjghIkF6RCXqOSOcNYmJKbC6goacOCe
   GQE7QlZ1p1bp34cRv4lbtXBfMjrCSbM03OFOjSrvGK9S4u7FWUQvlJ7Z1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="253861982"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="253861982"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 17:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="541852469"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 17:45:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkElM-0005o7-NN;
        Fri, 29 Apr 2022 00:45:36 +0000
Date:   Fri, 29 Apr 2022 08:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/15] rtw89: 8852c: add 8852ce to Makefile and Kconfig
Message-ID: <202204290830.slUaIhad-lkp@intel.com>
References: <20220426063235.41650-16-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426063235.41650-16-pkshih@realtek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ping-Ke,

I love your patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on next-20220428]
[cannot apply to wireless/main v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce-in-Makefile-and-Kconfig/20220426-143456
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220429/202204290830.slUaIhad-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5aaabdd4d9ac433ed14c1c02147c2609827739d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ping-Ke-Shih/rtw89-8852c-add-RFK-and-then-enable-8852ce-in-Makefile-and-Kconfig/20220426-143456
        git checkout 5aaabdd4d9ac433ed14c1c02147c2609827739d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/realtek/rtw89/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/rtw8852c.c:2640:2: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((__msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (__msk)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
           __write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw89/rtw8852c.c:2621:13: note: expanded from macro '__write_ctrl'
           u32 _wrt = FIELD_PREP(__msk, _val);                     \
                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/net/wireless/realtek/rtw89/rtw8852c.c:2653:2: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((__msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (__msk)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
           __write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw89/rtw8852c.c:2621:13: note: expanded from macro '__write_ctrl'
           u32 _wrt = FIELD_PREP(__msk, _val);                     \
                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   2 warnings generated.


vim +2640 drivers/net/wireless/realtek/rtw89/rtw8852c.c

2fb822f82a59db Ping-Ke Shih 2022-04-21  2630  
2fb822f82a59db Ping-Ke Shih 2022-04-21  2631  	switch (arg.ctrl_all_time) {
2fb822f82a59db Ping-Ke Shih 2022-04-21  2632  	case 0xffff:
2fb822f82a59db Ping-Ke Shih 2022-04-21  2633  		val = 0;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2634  		break;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2635  	default:
2fb822f82a59db Ping-Ke Shih 2022-04-21  2636  		val = arg.all_time.data;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2637  		break;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2638  	}
2fb822f82a59db Ping-Ke Shih 2022-04-21  2639  
2fb822f82a59db Ping-Ke Shih 2022-04-21 @2640  	__write_ctrl(R_AX_PWR_RATE_CTRL, B_AX_FORCE_PWR_BY_RATE_VALUE_MASK,
2fb822f82a59db Ping-Ke Shih 2022-04-21  2641  		     val, B_AX_FORCE_PWR_BY_RATE_EN,
2fb822f82a59db Ping-Ke Shih 2022-04-21  2642  		     arg.ctrl_all_time != 0xffff);
2fb822f82a59db Ping-Ke Shih 2022-04-21  2643  
2fb822f82a59db Ping-Ke Shih 2022-04-21  2644  	switch (arg.ctrl_gnt_bt) {
2fb822f82a59db Ping-Ke Shih 2022-04-21  2645  	case 0xffff:
2fb822f82a59db Ping-Ke Shih 2022-04-21  2646  		val = 0;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2647  		break;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2648  	default:
2fb822f82a59db Ping-Ke Shih 2022-04-21  2649  		val = arg.gnt_bt.data;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2650  		break;
2fb822f82a59db Ping-Ke Shih 2022-04-21  2651  	};
2fb822f82a59db Ping-Ke Shih 2022-04-21  2652  
2fb822f82a59db Ping-Ke Shih 2022-04-21  2653  	__write_ctrl(R_AX_PWR_COEXT_CTRL, B_AX_TXAGC_BT_MASK, val,
2fb822f82a59db Ping-Ke Shih 2022-04-21  2654  		     B_AX_TXAGC_BT_EN, arg.ctrl_gnt_bt != 0xffff);
2fb822f82a59db Ping-Ke Shih 2022-04-21  2655  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
