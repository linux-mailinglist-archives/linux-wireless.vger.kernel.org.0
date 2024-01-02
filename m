Return-Path: <linux-wireless+bounces-1383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECA821627
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 02:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E23B21127
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D56EC0;
	Tue,  2 Jan 2024 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAHx2qxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7DA4A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704159490; x=1735695490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KlGvooNu8nsoWWXf5Afr0W4LS7sH862QcK/m9aUUPsE=;
  b=gAHx2qxLhj1t9rktUoktWjDKx0W89+s4AJ2SbAKcn1LBAk9Uemr2G/HO
   Y0+wgy5A52iIgniIANF6pRd9E7kuPaeUjzJ+q2wUW1EhJfDTl45YkW0EX
   xpOtatKV60/RpuVfDLW0Dmob+ZDU5YeGHgBXgnaN0YdWIagcnB4eQTq7T
   FzMpwI1H1gzDrYp9ZZwFElbU/nJkQ0CuqWjwa+Mikj5PRQJz8goaT2QHD
   4+Y6GUxDt56eReoh5E/nuFgXBrqEJsOQ/MvV/iCW9p4aPYt7IZ9Kqwntw
   oSSZz3gOQgSUaasP9Om5Tv2nfJ3TaTLnJZALGnQkaKj+86FgsY+pbczpY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="10438975"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="10438975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 17:38:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="845425998"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="845425998"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2024 17:38:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKTjI-000Kfe-2u;
	Tue, 02 Jan 2024 01:38:04 +0000
Date: Tue, 2 Jan 2024 09:37:28 +0800
From: kernel test robot <lkp@intel.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 1/4] wifi: brcmfmac: export firmware interface functions
Message-ID: <202401020903.F2PfPAdw-lkp@intel.com>
References: <20240101084430.161821-2-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101084430.161821-2-arend.vanspriel@broadcom.com>

Hi Arend,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.7-rc8 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arend-van-Spriel/wifi-brcmfmac-export-firmware-interface-functions/20240101-164717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240101084430.161821-2-arend.vanspriel%40broadcom.com
patch subject: [PATCH 1/4] wifi: brcmfmac: export firmware interface functions
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240102/202401020903.F2PfPAdw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240102/202401020903.F2PfPAdw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401020903.F2PfPAdw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/swab.h:8,
                    from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:14,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/m68k/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/m68k/include/asm/bitops.h:566,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8:
   In function '__arch_swab32',
       inlined from '__fswab32' at include/uapi/linux/swab.h:60:9,
       inlined from 'brcmf_fil_cmd_int_get' at drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:99:19,
       inlined from 'brcmf_cfg80211_get_station_ibss' at drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3088:8:
>> arch/m68k/include/uapi/asm/swab.h:22:9: warning: 'rate' is used uninitialized [-Wuninitialized]
      22 |         __asm__("rolw #8,%0; swap %0; rolw #8,%0" : "=d" (val) : "0" (val));
         |         ^~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_cfg80211_get_station_ibss':
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3084:13: note: 'rate' was declared here
    3084 |         u32 rate;
         |             ^~~~


vim +/rate +22 arch/m68k/include/uapi/asm/swab.h

9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  19  
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  20  static inline __attribute_const__ __u32 __arch_swab32(__u32 val)
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  21  {
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16 @22  	__asm__("rolw #8,%0; swap %0; rolw #8,%0" : "=d" (val) : "0" (val));
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  23  	return val;
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  24  }
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  25  #define __arch_swab32 __arch_swab32
6aeea60aee9454 arch/m68k/include/asm/swab.h Harvey Harrison 2009-01-20  26  #endif
9863a0babc2f0d arch/m68k/include/asm/swab.h Greg Ungerer    2009-03-16  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

