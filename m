Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497266C23A8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCTV3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTV26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 17:28:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E70301BE
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679347707; x=1710883707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCGGVMRXm+djfMb2xvwVJZVaSsKth2QD7XxJ1ow4SLo=;
  b=hYHAId0nBuGoRukKkLorc+saYracgzMZVLc1emgsaUwfDk3ZeDiNfEkt
   MNx13lCP3fzVBwo1Cjf4wsqRYvPV65wDd1JnqgE5b42PVagH7MmNlHGH8
   HoJr+vF9jaf368UHo7+LJIZjXmn4MBFTAeCx8dgCQixUSRZUAODHpfbfY
   cqcMElnhHs4Gu0vVxeAhbed3VyJt3YhviMKCvupqiAsztGvgX55yJNw1k
   47Ghgj2Ovs2JIKwbja59Tno2/Y6MRd8lQ0e0UCXfV44FJ0ERI6atDABck
   1VIE50wCPZIe5E377hsjaooETLIczHF2Fx8GF88gaJcfP/G4Q9w4vPwfZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336286224"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="336286224"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824647920"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="824647920"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 14:26:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peN1t-000BKc-23;
        Mon, 20 Mar 2023 21:26:57 +0000
Date:   Tue, 21 Mar 2023 05:26:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, johannes@sipsolutions.net
Subject: Re: [PATCH] wifi: mac80211: add support for letting drivers register
 tc offload support
Message-ID: <202303210534.j0wuDWkS-lkp@intel.com>
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
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230321/202303210534.j0wuDWkS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/462e7ebc43a4631d478861a9027e7940462c2e4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Felix-Fietkau/wifi-mac80211-add-support-for-letting-drivers-register-tc-offload-support/20230320-213243
        git checkout 462e7ebc43a4631d478861a9027e7940462c2e4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210534.j0wuDWkS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from net/mac80211/trace.h:3060,
                    from net/mac80211/trace.c:11:
   net/mac80211/./trace.h: In function 'trace_raw_output_drv_net_setup_tc':
>> net/mac80211/./trace.h:2502:65: error: 'struct trace_event_raw_drv_net_setup_tc' has no member named 'new_links'
    2502 |                 LOCAL_PR_ARG, VIF_PR_ARG, __entry->type, __entry->new_links
         |                                                                 ^~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   net/mac80211/./trace.h:2481:1: note: in expansion of macro 'TRACE_EVENT'
    2481 | TRACE_EVENT(drv_net_setup_tc,
         | ^~~~~~~~~~~
   net/mac80211/./trace.h:2500:9: note: in expansion of macro 'TP_printk'
    2500 |         TP_printk(
         |         ^~~~~~~~~


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
