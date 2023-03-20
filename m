Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF06C23AB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 22:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCTV3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTV3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 17:29:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4A2F05E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679347737; x=1710883737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWvGcJxfxezaK4N0yLtrCjGJPC+PMOQwCjGBYdSrhh4=;
  b=Q8yWrFOYSzQZOkppg25ihgW3fDsd+L3KDfOT8s32BmVFVgY2xNK8HPQu
   meKdq7XC2Fe0UVcAR1tH6SQLfmI5jF8mjFG1N8i3czxMd2pe3w8CgUqMG
   LGKDkweNlcniLBqhxgQQ8UymmVdfJJhY0EZdcpZvfssHL1E4xZZbMV0us
   f+1vxEZEK8lOlrJGrq8WB3iR1aPQowU+km4p7FHrVX4+G5WPqQvNmrvpJ
   5y3eGMNCdUf7IUcFCIYwFITIJdCGaJfsVlX8uxeKpSpZYmj1ELo71imau
   fIxLhU8Ks7ykcDOzFGQGA6ESLgsOoefNkQ/e3DR+Av8NBpyPdxkweecCR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336286437"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="336286437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824648586"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="824648586"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 14:27:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peN2r-000BKk-2D;
        Mon, 20 Mar 2023 21:27:57 +0000
Date:   Tue, 21 Mar 2023 05:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        johannes@sipsolutions.net
Subject: Re: [PATCH] wifi: mac80211: add support for letting drivers register
 tc offload support
Message-ID: <202303210554.s6YrvLdj-lkp@intel.com>
References: <20230320133103.40724-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320133103.40724-1-nbd@nbd.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20230320]
[cannot apply to wireless/main linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/wifi-mac80211-add-support-for-letting-drivers-register-tc-offload-support/20230320-213243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230320133103.40724-1-nbd%40nbd.name
patch subject: [PATCH] wifi: mac80211: add support for letting drivers register tc offload support
config: x86_64-buildonly-randconfig-r005-20230320 (https://download.01.org/0day-ci/archive/20230321/202303210554.s6YrvLdj-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/462e7ebc43a4631d478861a9027e7940462c2e4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Felix-Fietkau/wifi-mac80211-add-support-for-letting-drivers-register-tc-offload-support/20230320-213243
        git checkout 462e7ebc43a4631d478861a9027e7940462c2e4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210554.s6YrvLdj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mac80211/trace.c:11:
   In file included from net/mac80211/./trace.h:3060:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> net/mac80211/./trace.h:2502:53: error: no member named 'new_links' in 'struct trace_event_raw_drv_net_setup_tc'
                   LOCAL_PR_ARG, VIF_PR_ARG, __entry->type, __entry->new_links
                                                            ~~~~~~~  ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
   #define TP_printk(fmt, args...) fmt "\n", args
                                             ^~~~
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(print));                   \
                                       ^~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
           trace_event_printf(iter, print);                                \
                                    ^~~~~
   1 error generated.


vim +2502 net/mac80211/./trace.h

  2480	
  2481	TRACE_EVENT(drv_net_setup_tc,
  2482		TP_PROTO(struct ieee80211_local *local,
  2483			 struct ieee80211_sub_if_data *sdata,
  2484			 u8 type),
  2485	
  2486		TP_ARGS(local, sdata, type),
  2487	
  2488		TP_STRUCT__entry(
  2489			LOCAL_ENTRY
  2490			VIF_ENTRY
  2491			__field(u8, type)
  2492		),
  2493	
  2494		TP_fast_assign(
  2495			LOCAL_ASSIGN;
  2496			VIF_ASSIGN;
  2497			__entry->type = type;
  2498		),
  2499	
  2500		TP_printk(
  2501			LOCAL_PR_FMT VIF_PR_FMT " type:%d\n",
> 2502			LOCAL_PR_ARG, VIF_PR_ARG, __entry->type, __entry->new_links
  2503		)
  2504	);
  2505	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
