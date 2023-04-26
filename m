Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CB6EFA33
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjDZSoy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjDZSox (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 14:44:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8FF7D9C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682534692; x=1714070692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CzIEC/oN0tHaOwXU+WwM48YunR1KsxbE2FbltY+Fuo=;
  b=R80ppMR7KFMEJFLSMVnvk8zrEd2LKczz04Hlx9jkhY9CWbxO5NLbGSaT
   4zn++zv+rXABz5Wmx2D1rIRD4GU8SN1CZRt0XrKeMv9vUZcQqnMs6Ws0R
   jFdFs2IoQq6cVdF4/mwU9AqMkICnjeO8XJU/3S8EPO3+Aztx2x55kdstS
   T2LymrTIvufyoqJ52zaZ32l/wK4lZRoXOsCgbt50vPFMZLr9Ak+S7XwA4
   Syg3pD1oy8GVpMP3z2SP+CTE0JCiwxDJZU6r0Y52tEkarjiKMPuBzzmzX
   +L3IASWsFXrkeKENxCYKg7jgZtMRn7NykxCUUN8am3xhSxEaRsOJACh6x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="349144705"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="349144705"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="696737549"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="696737549"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2023 11:44:50 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prk8H-0000Ru-1h;
        Wed, 26 Apr 2023 18:44:49 +0000
Date:   Thu, 27 Apr 2023 02:44:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muna Sinada <quic_msinada@quicinc.com>, johannes@sipsolutions.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: Re: [PATCH v4 3/3] cfg80211: Handle driver updated MU-EDCA params
Message-ID: <202304270204.JgVVdj2h-lkp@intel.com>
References: <1682471052-3452-3-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682471052-3452-3-git-send-email-quic_msinada@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Muna,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20230426]
[cannot apply to wireless/main linus/master v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muna-Sinada/wifi-mac80211-allow-userspace-to-enable-driver-control-of-MU-EDCA/20230426-090616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/1682471052-3452-3-git-send-email-quic_msinada%40quicinc.com
patch subject: [PATCH v4 3/3] cfg80211: Handle driver updated MU-EDCA params
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230427/202304270204.JgVVdj2h-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c9d6aeb60bf675df0acddaa0a54159955e761861
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muna-Sinada/wifi-mac80211-allow-userspace-to-enable-driver-control-of-MU-EDCA/20230426-090616
        git checkout c9d6aeb60bf675df0acddaa0a54159955e761861
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270204.JgVVdj2h-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from net/wireless/trace.h:3995,
                    from net/wireless/trace.c:5:
   net/wireless/./trace.h: In function 'trace_event_raw_event_cfg80211_update_muedca_params_event':
>> include/trace/stages/stage6_event_callback.h:9:17: error: expected ';' before 'entry'
       9 | #define __entry entry
         |                 ^~~~~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   net/wireless/./trace.h:3788:1: note: in expansion of macro 'TRACE_EVENT'
    3788 | TRACE_EVENT(cfg80211_update_muedca_params_event,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:3808:9: note: in expansion of macro 'TP_fast_assign'
    3808 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   net/wireless/./trace.h:3811:17: note: in expansion of macro '__entry'
    3811 |                 __entry->be_aifsn = params->ac_be.aifsn
         |                 ^~~~~~~
   In file included from include/trace/define_trace.h:103:
   net/wireless/./trace.h: In function 'perf_trace_cfg80211_update_muedca_params_event':
>> include/trace/stages/stage6_event_callback.h:9:17: error: expected ';' before 'entry'
       9 | #define __entry entry
         |                 ^~~~~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   net/wireless/./trace.h:3788:1: note: in expansion of macro 'TRACE_EVENT'
    3788 | TRACE_EVENT(cfg80211_update_muedca_params_event,
         | ^~~~~~~~~~~
   net/wireless/./trace.h:3808:9: note: in expansion of macro 'TP_fast_assign'
    3808 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   net/wireless/./trace.h:3811:17: note: in expansion of macro '__entry'
    3811 |                 __entry->be_aifsn = params->ac_be.aifsn
         |                 ^~~~~~~


vim +9 include/trace/stages/stage6_event_callback.h

92a22cea4c847b include/trace/stages/stage6_event_callback.h Steven Rostedt (Google  2023-01-24   7) 
af6b9668e85ffd include/trace/stages/stage6_defines.h        Steven Rostedt (Google  2022-03-03   8) #undef __entry
af6b9668e85ffd include/trace/stages/stage6_defines.h        Steven Rostedt (Google  2022-03-03  @9) #define __entry entry
af6b9668e85ffd include/trace/stages/stage6_defines.h        Steven Rostedt (Google  2022-03-03  10) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
