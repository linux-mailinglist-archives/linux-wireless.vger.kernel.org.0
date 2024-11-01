Return-Path: <linux-wireless+bounces-14836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD39B9754
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D171F21219
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E571CEAA0;
	Fri,  1 Nov 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI8bqEmL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57771AB523;
	Fri,  1 Nov 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485378; cv=none; b=Uj9QuQ23RwOIkqbSfIAmw57PHx8HlP4dmQne3UOOdcJESGdb1L22L56Sh0pH0PicRHd7IcE2BAd/SGezd8FlD+hveWQsVEUVw9p41a0ODw7q64E4QjFaMHQjGNy1lc4gBhfyrOwoKH6mwGrWGuCFmEaHlTJmQGhOm+O9YEKHNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485378; c=relaxed/simple;
	bh=2u420hLBt+iAZWsevacsMaooa6yJ5dkWq6pbYF7QYJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H49vBSGw3Wlepq5KQfWVvXYTF8QvDBHAw4KngwgwLTv857six88zoabNIEnLNuvFUkDIbBavBES0xEKIsypX07TQN+wBq97Db7aeu9g9q/DoCeFlcFKag0IsBUu2I9CXiWw1XNquBmYKYQTuJeb8Oj1dVnqUMLckzXVq0g5SJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI8bqEmL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730485376; x=1762021376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2u420hLBt+iAZWsevacsMaooa6yJ5dkWq6pbYF7QYJI=;
  b=LI8bqEmLwFr0lSOxiD9CVsiT+wFWsqEb4ZmY4JKx1RabgSsBVQyFsiVZ
   gzej6cfy9ateey50ToNINHl6HfrE9G5q3fehBuYmFnBQbvrMksz0PW5yC
   IAyaDdahoaukDrvRNslpy1r9mdJpjFRSD1bfT302xyFdpjK8MQPYWPAkS
   tnJbMNMZmMmZE1fNTrWTiaSQxaqIbpVcEEIWEPYvjs3i3c1BIgMMMwvpa
   RPdhRqOpX5ACxjlII5rBZTSrj0EXUoqzpAqchFjTLTFng7uYfjfLM0I7n
   650rZH0tBLm4NXa7Uc0iabRcOHL6fQpVTSdaWB+w7SYDX25DRKP8g2sLV
   A==;
X-CSE-ConnectionGUID: t1e6XNHGRuO6LdmnfKuAyQ==
X-CSE-MsgGUID: gDR0GSjKTLeV4EdXjMmZww==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="41621051"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="41621051"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 11:22:55 -0700
X-CSE-ConnectionGUID: MgzT1atKTHuzxXyZpL2S5g==
X-CSE-MsgGUID: NnO6t/eaTL+P0ldpDzL7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83141278"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Nov 2024 11:22:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6wIN-000hsP-0D;
	Fri, 01 Nov 2024 18:22:51 +0000
Date: Sat, 2 Nov 2024 02:22:06 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtw89: 8852a: remove redundant else statement
Message-ID: <202411020209.qamp5h6r-lkp@intel.com>
References: <20241030131416.3091954-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030131416.3091954-1-colin.i.king@gmail.com>

Hi Colin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/wifi-rtw89-8852a-remove-redundant-else-statement/20241030-211507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241030131416.3091954-1-colin.i.king%40gmail.com
patch subject: [PATCH][next] wifi: rtw89: 8852a: remove redundant else statement
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241102/202411020209.qamp5h6r-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020209.qamp5h6r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020209.qamp5h6r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:5:
   In file included from drivers/net/wireless/realtek/rtw89/coex.h:8:
   In file included from drivers/net/wireless/realtek/rtw89/core.h:12:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:5:
   In file included from drivers/net/wireless/realtek/rtw89/coex.h:8:
   In file included from drivers/net/wireless/realtek/rtw89/core.h:12:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:5:
   In file included from drivers/net/wireless/realtek/rtw89/coex.h:8:
   In file included from drivers/net/wireless/realtek/rtw89/core.h:12:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:5:
   In file included from drivers/net/wireless/realtek/rtw89/coex.h:8:
   In file included from drivers/net/wireless/realtek/rtw89/core.h:14:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:2249:11: warning: variable 'offset' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    2249 |         else if (dgain <= 0x155)
         |                  ^~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:2252:9: note: uninitialized use occurs here
    2252 |         return offset;
         |                ^~~~~~
   drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:2249:7: note: remove the 'if' if its condition is always true
    2249 |         else if (dgain <= 0x155)
         |              ^~~~~~~~~~~~~~~~~~~
    2250 |                 offset = -12;
   drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c:2235:11: note: initialize the variable 'offset' to silence this warning
    2235 |         s8 offset;
         |                  ^
         |                   = '\0'
   14 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +2249 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c

e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2232  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2233  static s8 _dpk_dgain_mapping(struct rtw89_dev *rtwdev, u16 dgain)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2234  {
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2235  	s8 offset;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2236  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2237  	if (dgain >= 0x783)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2238  		offset = 0x6;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2239  	else if (dgain <= 0x782 && dgain >= 0x551)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2240  		offset = 0x3;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2241  	else if (dgain <= 0x550 && dgain >= 0x3c4)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2242  		offset = 0x0;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2243  	else if (dgain <= 0x3c3 && dgain >= 0x2aa)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2244  		offset = -3;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2245  	else if (dgain <= 0x2a9 && dgain >= 0x1e3)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2246  		offset = -6;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2247  	else if (dgain <= 0x1e2 && dgain >= 0x156)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2248  		offset = -9;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11 @2249  	else if (dgain <= 0x155)
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2250  		offset = -12;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2251  
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2252  	return offset;
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2253  }
e3ec7017f6a20d Ping-Ke Shih 2021-10-11  2254  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

