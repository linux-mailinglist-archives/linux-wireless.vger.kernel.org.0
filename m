Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22827A11DE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 01:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjINXfA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjINXe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 19:34:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247231AE
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694734495; x=1726270495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QgmmQvr2VVCjTSIRZkudFML55JEhEzRCoQKAwYZ77zY=;
  b=ev/YG5Ze9X7nUfQ4hxkPIWe4ofclHyCPg7UiAg7VJnfSvN7aisbEbdzz
   QqMKS30Ak4TmO9lMNF7NId4yvkj9xaY/nwfy5ieMf71SVl1ccBw9cQAMM
   U+6NYJGCkdi6TdAahe6357yojUXNtX8HfZgdnpvXp0pWB01+j5sElmi+l
   fTPAsHf7aj3lXk4eLjq7+PDgDxYKaRx2YpH2lDAz0j9VborPVGEvGBfsr
   xCjWa9XrSK51a7d2ttDG487fKoNcKsp0eqt+Gzn763CCkc/3vBmS1Mf3R
   j5VkzGbTCn0mImGTgK6sYQmf7+qQyZoIEdbcD3C/JYkjrwdK+4mNYB4Kv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465477139"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="465477139"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 16:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991608349"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="991608349"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 16:34:53 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgvrH-0002Aj-0O;
        Thu, 14 Sep 2023 23:34:51 +0000
Date:   Fri, 15 Sep 2023 07:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] rfkill: sync before userspace visibility/changes
Message-ID: <202309150719.OIX0u8eK-lkp@intel.com>
References: <20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7@changeid>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.6-rc1 next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/rfkill-sync-before-userspace-visibility-changes/20230914-221103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7%40changeid
patch subject: [PATCH v2] rfkill: sync before userspace visibility/changes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230915/202309150719.OIX0u8eK-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309150719.OIX0u8eK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150719.OIX0u8eK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/rfkill/core.c:735:2: error: call to undeclared function 'rfkill_sync'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           rfkill_sync(rfkill);
           ^
   net/rfkill/core.c:759:2: error: call to undeclared function 'rfkill_sync'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           rfkill_sync(rfkill);
           ^
   net/rfkill/core.c:793:2: error: call to undeclared function 'rfkill_sync'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           rfkill_sync(rfkill);
           ^
   net/rfkill/core.c:818:2: error: call to undeclared function 'rfkill_sync'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           rfkill_sync(rfkill);
           ^
   net/rfkill/core.c:1044:13: error: static declaration of 'rfkill_sync' follows non-static declaration
   static void rfkill_sync(struct rfkill *rfkill)
               ^
   net/rfkill/core.c:735:2: note: previous implicit declaration is here
           rfkill_sync(rfkill);
           ^
   5 errors generated.


vim +/rfkill_sync +735 net/rfkill/core.c

   728	
   729	static ssize_t soft_show(struct device *dev, struct device_attribute *attr,
   730				 char *buf)
   731	{
   732		struct rfkill *rfkill = to_rfkill(dev);
   733	
   734		mutex_lock(&rfkill_global_mutex);
 > 735		rfkill_sync(rfkill);
   736		mutex_unlock(&rfkill_global_mutex);
   737	
   738		return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0);
   739	}
   740	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
