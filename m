Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D767A0D83
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbjINSwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbjINSv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 14:51:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31C2701
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694717313; x=1726253313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VOW6+wzY9U19900s+xswFo4gUDKK7qGm6cwQXh1atuw=;
  b=H5bjHvdMdTdNaoUSqN4qZn8tVlmihiaxYERBP5V88IUzu73uWDhhDpLX
   t09t/zj8s6YHjA9JeH9BCrC8/72PcIUFoJSoEFx7a0BkWwCSQwzAEzgmt
   tuPzSrqH5QIUdg4Ss5vbmX6EYxlXPDz6rlA/9rLSSiN4UADykoxjhUair
   HB+0z7lk2EYq1b74wwZtK7+py1op2adTyt1LmkYuYncbrir72ra7lhMt6
   VfEaAhARgVspFR1Yfw07trCkQd0h3Zi6jyRi19YSWjBDOVYbUvBpRQkWC
   utUdLrk1tgsDz275SMwpbZhbi97TzBc+cN5GpmxmvsmW1+ZJZ/+QsSIgT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358458621"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="358458621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 11:48:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918339549"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918339549"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2023 11:48:31 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgrO7-0001xF-2V;
        Thu, 14 Sep 2023 18:48:28 +0000
Date:   Fri, 15 Sep 2023 02:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] rfkill: sync before userspace visibility/changes
Message-ID: <202309150223.e6DfafFk-lkp@intel.com>
References: <20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7@changeid>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.6-rc1 next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/rfkill-sync-before-userspace-visibility-changes/20230914-221103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7%40changeid
patch subject: [PATCH v2] rfkill: sync before userspace visibility/changes
config: i386-buildonly-randconfig-003-20230915 (https://download.01.org/0day-ci/archive/20230915/202309150223.e6DfafFk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150223.e6DfafFk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150223.e6DfafFk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/rfkill/core.c: In function 'soft_show':
   net/rfkill/core.c:735:2: error: implicit declaration of function 'rfkill_sync'; did you mean 'rfkill_event'? [-Werror=implicit-function-declaration]
     735 |  rfkill_sync(rfkill);
         |  ^~~~~~~~~~~
         |  rfkill_event
   net/rfkill/core.c: At top level:
>> net/rfkill/core.c:1044:13: warning: conflicting types for 'rfkill_sync'
    1044 | static void rfkill_sync(struct rfkill *rfkill)
         |             ^~~~~~~~~~~
   net/rfkill/core.c:1044:13: error: static declaration of 'rfkill_sync' follows non-static declaration
   net/rfkill/core.c:735:2: note: previous implicit declaration of 'rfkill_sync' was here
     735 |  rfkill_sync(rfkill);
         |  ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rfkill_sync +1044 net/rfkill/core.c

  1043	
> 1044	static void rfkill_sync(struct rfkill *rfkill)
  1045	{
  1046		lockdep_assert_held(&rfkill_global_mutex);
  1047	
  1048		if (!rfkill->need_sync)
  1049			return;
  1050	
  1051		rfkill_set_block(rfkill, rfkill_global_states[rfkill->type].cur);
  1052		rfkill->need_sync = false;
  1053	}
  1054	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
