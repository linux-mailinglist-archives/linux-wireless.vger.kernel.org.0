Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC35532F46
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiEXQzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiEXQzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 12:55:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A06D3B6
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653411351; x=1684947351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6gpi1uL5DAC6JB3mblf/EaX3MPtBaI+z6fsMFa2ISYI=;
  b=nNb9yBCYh7BYc+fFZvCKWzAKR3qZqG15ZelB8DmsZPidLxm5GNlDb3j5
   H3+dtd9El86UvhEA1z5w0B6iJc5ygDAyKkTTIHEDQEKhdkfrHJqGc8ydt
   A44C3hinJeTEvbzM7nzQ2NjbsHYUQpeECfGtrEnTI37zdM+N1nI4aaHSQ
   bygjGozPJfbPeJgf5ZN1mzpuM1so1wvvaRr9Ch/sWVL9sap2xOL+B769y
   mU+h0A89QOJyicVvmOSXSWRg1zBDRTu1i23HXIj+iIFzcsWG4zArbRY3S
   sL2t6G9JXOrk+slc/FIL92YAIuiPB4NuMTCLLEPC9gMY3f0uKy7Iy01c3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271160533"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="271160533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="608745012"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 May 2022 09:55:48 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntXox-0002H9-Vv;
        Tue, 24 May 2022 16:55:47 +0000
Date:   Wed, 25 May 2022 00:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:mld 8/8] net/mac80211/./trace.h:21:25: warning:
 format '%x' expects argument of type 'unsigned int', but argument 7 has type
 'u64' {aka 'long long unsigned int'}
Message-ID: <202205250015.t5c8iOSm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   3a74f2e20dace2e2c0cad079226b9107862271b5
commit: 3a74f2e20dace2e2c0cad079226b9107862271b5 [8/8] mac80211: split bss_info_changed method
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205250015.t5c8iOSm-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=3a74f2e20dace2e2c0cad079226b9107862271b5
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next mld
        git checkout 3a74f2e20dace2e2c0cad079226b9107862271b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from net/mac80211/trace.h:2944,
                    from net/mac80211/trace.c:11:
   net/mac80211/./trace.h: In function 'trace_raw_output_drv_vif_cfg_changed':
>> net/mac80211/./trace.h:21:25: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
      21 | #define LOCAL_PR_FMT    "%s"
         |                         ^~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   net/mac80211/./trace.h:393:1: note: in expansion of macro 'TRACE_EVENT'
     393 | TRACE_EVENT(drv_vif_cfg_changed,
         | ^~~~~~~~~~~
   net/mac80211/./trace.h:440:9: note: in expansion of macro 'TP_printk'
     440 |         TP_printk(
         |         ^~~~~~~~~
   net/mac80211/./trace.h:441:17: note: in expansion of macro 'LOCAL_PR_FMT'
     441 |                 LOCAL_PR_FMT  VIF_PR_FMT " changed:%#x",
         |                 ^~~~~~~~~~~~
   net/mac80211/./trace.h: In function 'trace_raw_output_drv_link_info_changed':
   net/mac80211/./trace.h:21:25: warning: format '%x' expects argument of type 'unsigned int', but argument 8 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]
      21 | #define LOCAL_PR_FMT    "%s"
         |                         ^~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   net/mac80211/./trace.h:446:1: note: in expansion of macro 'TRACE_EVENT'
     446 | TRACE_EVENT(drv_link_info_changed,
         | ^~~~~~~~~~~
   net/mac80211/./trace.h:514:9: note: in expansion of macro 'TP_printk'
     514 |         TP_printk(
         |         ^~~~~~~~~
   net/mac80211/./trace.h:515:17: note: in expansion of macro 'LOCAL_PR_FMT'
     515 |                 LOCAL_PR_FMT  VIF_PR_FMT " link_id:%d, changed:%#x",
         |                 ^~~~~~~~~~~~


vim +21 net/mac80211/./trace.h

0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  17  
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  18  #define MAXNAME		32
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  19  #define LOCAL_ENTRY	__array(char, wiphy_name, 32)
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  20  #define LOCAL_ASSIGN	strlcpy(__entry->wiphy_name, wiphy_name(local->hw.wiphy), MAXNAME)
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07 @21  #define LOCAL_PR_FMT	"%s"
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  22  #define LOCAL_PR_ARG	__entry->wiphy_name
0a2b8bb24d4eb67 net/mac80211/driver-trace.h Johannes Berg 2009-07-07  23  

:::::: The code at line 21 was first introduced by commit
:::::: 0a2b8bb24d4eb67788edd71d1ef8aa86c2e17e0f mac80211: driver operation debugging

:::::: TO: Johannes Berg <johannes@sipsolutions.net>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
