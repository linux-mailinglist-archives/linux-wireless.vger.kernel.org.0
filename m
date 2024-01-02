Return-Path: <linux-wireless+bounces-1386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E288216A1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 04:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F7F1F2185F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473020F5;
	Tue,  2 Jan 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVi+NwFT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AA20F8
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704166306; x=1735702306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjfuIF7hEAlelloD3Ph34092M5FbskOnA3IotO4S9Vs=;
  b=NVi+NwFTSFIKihXCIevaHYV4RuLo0WrtqFBoeSxcENVgoIzsvoSOKjgy
   Rqpy85L9meqJmKLTEPSL4uGk1F4DwbcgOGStySmcp5VKVL6IrJiPxETns
   5jaFvgxEEam0ZJZ//+F69moo+1I3FR0awRiiTNy9HceUB0w98MLmM8Pf0
   BqJ7HqVOe+EvZHxABo9KXMz+4yc7XUi5fDM7CJdPXNXFHqvT0s//V8scG
   l1LSnHd2zTdoExDFL69qSr+Irfh5iTdimVhYldQ3fhRsUAwJ78QfxRtYw
   R0jmWNui+qWxRt452ecIlUDfBTciKEx9csls6k5amR/SP+ukgIG5XmHqe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="3669876"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="3669876"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 19:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="898391777"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="898391777"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2024 19:31:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKVVF-000Kse-0P;
	Tue, 02 Jan 2024 03:31:41 +0000
Date: Tue, 2 Jan 2024 11:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 1/4] wifi: brcmfmac: export firmware interface functions
Message-ID: <202401021103.U0Y8xoJK-lkp@intel.com>
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
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240102/202401021103.U0Y8xoJK-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240102/202401021103.U0Y8xoJK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401021103.U0Y8xoJK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:14,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/sparc/include/uapi/asm/byteorder.h:5,
                    from arch/sparc/include/asm/bitops_64.h:16,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8:
   In function '__fswab32',
       inlined from 'brcmf_fil_cmd_int_get' at drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:99:19,
       inlined from 'brcmf_cfg80211_get_station_ibss' at drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3088:8:
>> include/uapi/linux/swab.h:19:45: warning: 'rate' is used uninitialized [-Wuninitialized]
      19 |         (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/uapi/linux/swab.h:62:16: note: in expansion of macro '___constant_swab32'
      62 |         return ___constant_swab32(val);
         |                ^~~~~~~~~~~~~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_cfg80211_get_station_ibss':
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3084:13: note: 'rate' was declared here
    3084 |         u32 rate;
         |             ^~~~


vim +/rate +19 include/uapi/linux/swab.h

607ca46e97a1b6 David Howells 2012-10-13   9  
607ca46e97a1b6 David Howells 2012-10-13  10  /*
607ca46e97a1b6 David Howells 2012-10-13  11   * casts are necessary for constants, because we never know how for sure
607ca46e97a1b6 David Howells 2012-10-13  12   * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
607ca46e97a1b6 David Howells 2012-10-13  13   */
607ca46e97a1b6 David Howells 2012-10-13  14  #define ___constant_swab16(x) ((__u16)(				\
607ca46e97a1b6 David Howells 2012-10-13  15  	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
607ca46e97a1b6 David Howells 2012-10-13  16  	(((__u16)(x) & (__u16)0xff00U) >> 8)))
607ca46e97a1b6 David Howells 2012-10-13  17  
607ca46e97a1b6 David Howells 2012-10-13  18  #define ___constant_swab32(x) ((__u32)(				\
607ca46e97a1b6 David Howells 2012-10-13 @19  	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
607ca46e97a1b6 David Howells 2012-10-13  20  	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
607ca46e97a1b6 David Howells 2012-10-13  21  	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
607ca46e97a1b6 David Howells 2012-10-13  22  	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
607ca46e97a1b6 David Howells 2012-10-13  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

