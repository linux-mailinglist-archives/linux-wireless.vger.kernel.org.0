Return-Path: <linux-wireless+bounces-18588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F95A2A49C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760B6168BCB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2122CBF4;
	Thu,  6 Feb 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezp08FrK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF222C355;
	Thu,  6 Feb 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834323; cv=none; b=a5c7Vttvh3LFtqejCbHobt6i1soPr8CjULFQm/M51Nwn+HL+LS1vSLYBDdC7Vg0whi7omR34Hp1wXSzZwWJsgS/IKy6JzyiH+S/lNZ5mcGD1OA/0B/OWzGF9QL+b/WL6Tv03wpHDrFOlutqpAl9K5d+GDx4s4ApTUtyHA3cwO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834323; c=relaxed/simple;
	bh=ebn36sY7VM8LnTISOZn8OjLwV8d2NBTHyEeM0+XORdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBb6lbIp9lz5daZ+pzDp+mW4+bzc+KQm8vcyBJ98ZatHcr/kUUR9y0QbJfS7ovkIrq+7BxjAnuFXqg0sLSoz3zmEk7RM436iQPRoFa3RV33k7c0oJbdYWvFe4bimkg64CJmAGVY2241n/WW+9ZLEpTLPkjWVoL9b0pge6DzwIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezp08FrK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738834321; x=1770370321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebn36sY7VM8LnTISOZn8OjLwV8d2NBTHyEeM0+XORdo=;
  b=Ezp08FrKX3ZON+A5Fq586XEFH8nqv5G3NhqXVfdtRzmskwbDY4ge3Fv5
   RlSRKMKPRXelA8vZMyQ5yyqphhNEZrbnsvTWglWgyJQg0srFZoerkWUpV
   GvQootZv68fl67EAzQPN6AW5TUQ/VGbheEuxwiv7/GdoiacNA/VDcPjf/
   oCFyF6S0wc8dBQOx5pAJ8dptn2VyJXgLpCAJ2CSHnWEYVLU9J70PHZWTr
   UpFq6Lp+xNTqvPLQkpP+E7S2F2v1TtI0CSCfHTpRegnOeQLs2pgEa99x8
   uISHSSpowshvDYIwC7o5VJdT81CPdX0477OsyOWTiyg/haBM9ychCT4aV
   Q==;
X-CSE-ConnectionGUID: 62+eE7tkSm2miI1+lp5wbg==
X-CSE-MsgGUID: tJZhJor9RHa8Bq+/6TM70A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43090439"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43090439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 01:32:00 -0800
X-CSE-ConnectionGUID: rOxyr2INRNKjy6DjPbY1vQ==
X-CSE-MsgGUID: MaJHPNCPSqiEYN89QW45yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111126000"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 06 Feb 2025 01:31:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfyEi-000wgd-0M;
	Thu, 06 Feb 2025 09:31:52 +0000
Date: Thu, 6 Feb 2025 17:31:29 +0800
From: kernel test robot <lkp@intel.com>
To: Uday Shankar <ushankar@purestorage.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH v2 1/2] net, treewide: define and use MAC_ADDR_LEN
Message-ID: <202502061751.GNyqzMGp-lkp@intel.com>
References: <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-netconsole-v2-1-5ef5eb5f6056@purestorage.com>

Hi Uday,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c2933b2befe25309f4c5cfbea0ca80909735fd76]

url:    https://github.com/intel-lab-lkp/linux/commits/Uday-Shankar/net-treewide-define-and-use-MAC_ADDR_LEN/20250205-054620
base:   c2933b2befe25309f4c5cfbea0ca80909735fd76
patch link:    https://lore.kernel.org/r/20250204-netconsole-v2-1-5ef5eb5f6056%40purestorage.com
patch subject: [PATCH v2 1/2] net, treewide: define and use MAC_ADDR_LEN
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250206/202502061751.GNyqzMGp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250206/202502061751.GNyqzMGp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502061751.GNyqzMGp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/qla4xxx/ql4_os.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/scsi/qla4xxx/ql4_os.c:15:
>> drivers/scsi/qla4xxx/ql4_def.h:148:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
     148 | #define MAC_ADDR_LEN                    6       /* in bytes */
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c:4:
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8188ee/../wifi.h:11:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c:8:
>> drivers/net/wireless/realtek/rtlwifi/rtl8188ee/reg.h:1230:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
    1230 | #define MAC_ADDR_LEN                            6
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c:4:
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8192ee/../wifi.h:11:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c:8:
>> drivers/net/wireless/realtek/rtlwifi/rtl8192ee/reg.h:1192:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
    1192 | #define MAC_ADDR_LEN                            6
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c:4:
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723ae/../wifi.h:11:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c:8:
>> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/reg.h:1194:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
    1194 | #define MAC_ADDR_LEN                            6
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c:4:
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723be/../wifi.h:11:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c:8:
>> drivers/net/wireless/realtek/rtlwifi/rtl8723be/reg.h:1245:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
    1245 | #define MAC_ADDR_LEN                            6
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:4:
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8821ae/../wifi.h:11:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c:8:
>> drivers/net/wireless/realtek/rtlwifi/rtl8821ae/reg.h:1274:9: warning: 'MAC_ADDR_LEN' macro redefined [-Wmacro-redefined]
    1274 | #define MAC_ADDR_LEN                    6
         |         ^
   include/linux/if_ether.h:23:9: note: previous definition is here
      23 | #define MAC_ADDR_LEN (3 * ETH_ALEN - 1)
         |         ^
   4 warnings generated.


vim +/MAC_ADDR_LEN +148 drivers/scsi/qla4xxx/ql4_def.h

afaf5a2d341d33 David Somayajulu 2006-09-19  144  
afaf5a2d341d33 David Somayajulu 2006-09-19  145  /*
afaf5a2d341d33 David Somayajulu 2006-09-19  146   * Misc
afaf5a2d341d33 David Somayajulu 2006-09-19  147   */
afaf5a2d341d33 David Somayajulu 2006-09-19 @148  #define MAC_ADDR_LEN			6	/* in bytes */
afaf5a2d341d33 David Somayajulu 2006-09-19  149  #define IP_ADDR_LEN			4	/* in bytes */
2a49a78ed3c8d7 Vikas Chaudhary  2010-04-28  150  #define IPv6_ADDR_LEN			16	/* IPv6 address size */
afaf5a2d341d33 David Somayajulu 2006-09-19  151  #define DRIVER_NAME			"qla4xxx"
afaf5a2d341d33 David Somayajulu 2006-09-19  152  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

