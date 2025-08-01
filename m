Return-Path: <linux-wireless+bounces-26075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCDB17B6D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0650C16EFB5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2EE158520;
	Fri,  1 Aug 2025 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew5zeEih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F026130E58;
	Fri,  1 Aug 2025 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019153; cv=none; b=feJLKW6QeZvnH+NOilmHn6tX+rzwgMWPKsI5dh68PNI5ulQK3tEQc8vAPnoENrrox/UD286u4FLtVHCy8Y5W2PHOPw0JpYAG0GFFwKdkxEPuMGQ6jv6f7EFQqep0NrglhlFvAmZDvEgjBPIi1w38H4F9syGAuzvkw7gr4K2DnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019153; c=relaxed/simple;
	bh=jYfcOJqAuO0i33bt9vqtlgulefjYaY1STntvoeHlzt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIBIKlhNsPNe6+OkxKBbYQBG0IAvfiPMTkgNnUXxyRA3F7FLvXT/hrwyZw0xGwDHfdHHpKeQF629TNURBTwIDg7/sRAfT37n4nqs7UQ/QQ+W3MD8TM1qkKm2tGMB9Bd051nJ0tKrZ4bzyuKFLnXrjfpMkHweNvgAUNaVNa1jQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew5zeEih; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754019152; x=1785555152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYfcOJqAuO0i33bt9vqtlgulefjYaY1STntvoeHlzt8=;
  b=Ew5zeEihhXIx32eHiFMhoR9UK5Cg3NSvMweOrKwACp+a+l7VHemkawTb
   fCuDGn+39h+/9hUoOaTEI8kDTLtZx+Rq/FDuMJTz1F2y8hIFUG8Rte9lD
   gFajohmDV5oHba2hZMT/W37oQaCYTjBgTNIhowx89fWaNzosr5jcNlRYd
   4fak07ZTPIWSGiN33W+Rige9pYbtiYwfgm25awJWe+0uPNY0l19T8d45O
   xJqKmNd4BswJGJ07oEBEly0ME6kMz8tZjODm4xVYGBZZbbt++8+Qe6BXf
   vJIlMCTkaSpYYyj51Sq/9Q0QnmlQPlQ1VWAl1Fsc7oXoaSCNdh2zwESTm
   A==;
X-CSE-ConnectionGUID: +yMgehHWR0ywQl4A+pwArA==
X-CSE-MsgGUID: vxdt+niXTYquZp1HfCspYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56296057"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56296057"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 20:32:19 -0700
X-CSE-ConnectionGUID: McsSIpXMS7OMV6CVFiHKIQ==
X-CSE-MsgGUID: 6q0hKUuiRNeeIjE5DROETQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163009834"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 31 Jul 2025 20:32:17 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhgVD-0004KO-16;
	Fri, 01 Aug 2025 03:32:15 +0000
Date: Fri, 1 Aug 2025 11:32:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mande Imran Ahmed <immu.ahmed1905@gmail.com>, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mande Imran Ahmed <immu.ahmed1905@gmail.com>
Subject: Re: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for
 sysfs output
Message-ID: <202508011121.dDTSwRyY-lkp@intel.com>
References: <20250730095634.3754-1-immu.ahmed1905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730095634.3754-1-immu.ahmed1905@gmail.com>

Hi Mande,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.16 next-20250731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mande-Imran-Ahmed/net-mac80211-replace-scnprintf-with-sysfs_emit-for-sysfs-output/20250730-180128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250730095634.3754-1-immu.ahmed1905%40gmail.com
patch subject: [PATCH] net/mac80211: replace scnprintf() with sysfs_emit() for sysfs output
config: powerpc-randconfig-001-20250801 (https://download.01.org/0day-ci/archive/20250801/202508011121.dDTSwRyY-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508011121.dDTSwRyY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508011121.dDTSwRyY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mac80211/debugfs_sta.c: In function 'sta_flags_read':
>> net/mac80211/debugfs_sta.c:99:16: warning: 'buf' is used uninitialized [-Wuninitialized]
      99 |         return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:65,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:7,
                    from include/linux/debugfs.h:15,
                    from net/mac80211/debugfs_sta.c:11:
   arch/powerpc/include/asm/string.h:22:24: note: by argument 1 of type 'const char *' to 'strlen' declared here
      22 | extern __kernel_size_t strlen(const char *);
         |                        ^~~~~~
   net/mac80211/debugfs_sta.c:87:14: note: 'buf' declared here
      87 |         char buf[16 * NUM_WLAN_STA_FLAGS], *pos = buf;
         |              ^~~


vim +/buf +99 net/mac80211/debugfs_sta.c

c84387d2f2c83d Johannes Berg     2016-03-17   83  
e9f207f0ff90bf Jiri Benc         2007-05-05   84  static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
e9f207f0ff90bf Jiri Benc         2007-05-05   85  			      size_t count, loff_t *ppos)
e9f207f0ff90bf Jiri Benc         2007-05-05   86  {
c84387d2f2c83d Johannes Berg     2016-03-17   87  	char buf[16 * NUM_WLAN_STA_FLAGS], *pos = buf;
e9f207f0ff90bf Jiri Benc         2007-05-05   88  	struct sta_info *sta = file->private_data;
c84387d2f2c83d Johannes Berg     2016-03-17   89  	unsigned int flg;
c84387d2f2c83d Johannes Berg     2016-03-17   90  
c84387d2f2c83d Johannes Berg     2016-03-17   91  	BUILD_BUG_ON(ARRAY_SIZE(sta_flag_names) != NUM_WLAN_STA_FLAGS);
c2c98fdeb5c897 Johannes Berg     2011-09-29   92  
c84387d2f2c83d Johannes Berg     2016-03-17   93  	for (flg = 0; flg < NUM_WLAN_STA_FLAGS; flg++) {
c84387d2f2c83d Johannes Berg     2016-03-17   94  		if (test_sta_flag(sta, flg))
ec95570844b7a6 Mande Imran Ahmed 2025-07-30   95  			pos += sysfs_emit(pos, "%s\n",
c84387d2f2c83d Johannes Berg     2016-03-17   96  					 sta_flag_names[flg]);
c84387d2f2c83d Johannes Berg     2016-03-17   97  	}
5bade101eceedb Johannes Berg     2011-09-29   98  
c84387d2f2c83d Johannes Berg     2016-03-17  @99  	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
e9f207f0ff90bf Jiri Benc         2007-05-05  100  }
e9f207f0ff90bf Jiri Benc         2007-05-05  101  STA_OPS(flags);
e9f207f0ff90bf Jiri Benc         2007-05-05  102  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

