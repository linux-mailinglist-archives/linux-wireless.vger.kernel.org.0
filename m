Return-Path: <linux-wireless+bounces-27046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C69B47919
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 06:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6243C090A
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 04:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642B19644B;
	Sun,  7 Sep 2025 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCbHE3nz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DF1B0437
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757220138; cv=none; b=UYzbYsMMfhg++F8PixhpWkxaVP64XSjfdn0fTwlBK4t1QQLovflK6Hq96wj2niDeo4Zl+CjMCHqGb2hziLjIj9bbhQW3RxVGM/lMWaGQGVMDgXpY/T8l4yuUomi2lwKkL+ZrkrSvfpN9qGEHuDS88uAnyX32e8okKz9z3X0+VP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757220138; c=relaxed/simple;
	bh=ajgu/EmLWqqRkhxrP9is6iXAwcRl6RqLR3pYXOWjI7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syoT6DhIDvtPS2m7Kfzx56AFxPSIkxc4VPJGElKdPMt2rflNajwzYdJdkwGcdHe/bCiYAFWKm4ZVpIuDMyDs1dwu4N87djbrNUD0Yfq5YWOIWoCksrWZx8vKryyV60nJTa0v18UWN6hRvhEMp7KiZjzMQVNFNo9ltkKvt+fbUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCbHE3nz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757220135; x=1788756135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ajgu/EmLWqqRkhxrP9is6iXAwcRl6RqLR3pYXOWjI7c=;
  b=WCbHE3nzWQ9jkYKFWSmt0cAnN1+cewWUu00UcTyALQlBzriUkK7XFBJU
   JOIuhcwQkzcOYY7g7GBkONhty5iEkEhmsDog6V946Qing9LoqMJ+SEd2r
   n5jwlYmlvfZDqbddllpn//qVX1JJoitKXHnkuG7mYNizaXQO2WyUT+5AL
   Tz4O+2V5cPWNXqyPEa7Obt9lJSjjSMDUEcziXXJkMdMCfUzj7fjm4+KXC
   fK15b++GpNsrOtzRORb3WMWAyfjSdRvAj1DLkEuixDWkLBTK48tFDntis
   1PZXakch8aNET4tbZMUbIgfRs6WxsOcojq066Xxm7Lz7aGAUG6/hQkiZS
   Q==;
X-CSE-ConnectionGUID: 01QGXGHpTienkthWUYTatQ==
X-CSE-MsgGUID: YB2EeWPNSMCm5KzxQiP8Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="47083137"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="47083137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 21:42:14 -0700
X-CSE-ConnectionGUID: B1x7ott1S2ioueeokamgSw==
X-CSE-MsgGUID: MjiIu9bnR96rBUXpwDNCHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="209656304"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Sep 2025 21:42:13 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv7EA-00022N-1e;
	Sun, 07 Sep 2025 04:42:10 +0000
Date: Sun, 7 Sep 2025 12:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Yufeng <chenyufeng@iie.ac.cn>, stf_xl@wp.pl
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: Re: [PATCH] iwlegacy: Sanity check for sta_id
Message-ID: <202509071251.YuF4EGpk-lkp@intel.com>
References: <20250906094232.1580-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906094232.1580-1-chenyufeng@iie.ac.cn>

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yufeng/iwlegacy-Sanity-check-for-sta_id/20250906-174354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250906094232.1580-1-chenyufeng%40iie.ac.cn
patch subject: [PATCH] iwlegacy: Sanity check for sta_id
config: x86_64-buildonly-randconfig-002-20250907 (https://download.01.org/0day-ci/archive/20250907/202509071251.YuF4EGpk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509071251.YuF4EGpk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509071251.YuF4EGpk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlegacy/common.c:1742:3: error: incompatible pointer types initializing 'const char *' with an expression of type 'struct il_priv *' [-Werror,-Wincompatible-pointer-types]
    1742 |                 IL_ERR(il, "invalid sta_id %u", sta_id);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlegacy/common.h:31:25: note: expanded from macro 'IL_ERR'
      31 | #define IL_ERR(f, a...) dev_err(&il->pci_dev->dev, f, ## a)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:154:2: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:109:3: note: expanded from macro 'dev_printk_index_wrap'
     109 |                 dev_printk_index_emit(level, fmt);                      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:105:2: note: expanded from macro 'dev_printk_index_emit'
     105 |         printk_index_subsys_emit("%s %s: ", level, fmt)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:481:2: note: expanded from macro 'printk_index_subsys_emit'
     481 |         __printk_index_emit(fmt, level, subsys_fmt_prefix)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:447:12: note: expanded from macro '__printk_index_emit'
     447 |                                 .fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlegacy/common.c:1742:10: error: incompatible pointer types passing 'struct il_priv *' to parameter of type 'const char *' [-Werror,-Wincompatible-pointer-types]
    1742 |                 IL_ERR(il, "invalid sta_id %u", sta_id);
         |                        ^~
   drivers/net/wireless/intel/iwlegacy/common.h:31:52: note: expanded from macro 'IL_ERR'
      31 | #define IL_ERR(f, a...) dev_err(&il->pci_dev->dev, f, ## a)
         |                                                    ^
   include/linux/dev_printk.h:154:57: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ^~~
   include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:50:53: note: passing argument to parameter 'fmt' here
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |                                                     ^
   2 errors generated.


vim +1742 drivers/net/wireless/intel/iwlegacy/common.c

  1736	
  1737	/* il->sta_lock must be held */
  1738	static int
  1739	il_sta_ucode_activate(struct il_priv *il, u8 sta_id)
  1740	{
  1741		if (sta_id >= IL_STATION_COUNT) {
> 1742			IL_ERR(il, "invalid sta_id %u", sta_id);
  1743			return -EINVAL;
  1744		}
  1745		if (!(il->stations[sta_id].used & IL_STA_DRIVER_ACTIVE))
  1746			IL_ERR("ACTIVATE a non DRIVER active station id %u addr %pM\n",
  1747			       sta_id, il->stations[sta_id].sta.sta.addr);
  1748	
  1749		if (il->stations[sta_id].used & IL_STA_UCODE_ACTIVE) {
  1750			D_ASSOC("STA id %u addr %pM already present"
  1751				" in uCode (according to driver)\n", sta_id,
  1752				il->stations[sta_id].sta.sta.addr);
  1753		} else {
  1754			il->stations[sta_id].used |= IL_STA_UCODE_ACTIVE;
  1755			D_ASSOC("Added STA id %u addr %pM to uCode\n", sta_id,
  1756				il->stations[sta_id].sta.sta.addr);
  1757		}
  1758		return 0;
  1759	}
  1760	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

