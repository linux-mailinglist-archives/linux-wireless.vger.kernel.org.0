Return-Path: <linux-wireless+bounces-12628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5368970434
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9070728309C
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0F168483;
	Sat,  7 Sep 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqm+HT4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07E15C137;
	Sat,  7 Sep 2024 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725745772; cv=none; b=SWFGh74rLHYeM8HoYkrOqqaSnvXnTCdGpVEgvCT4mJ4TVdYFuHkyVoExETzYOEe6yHgugtVuKQNSIbvVSgC2M0HfzpOTWxsjvGDhh9bWRgBBouP7nT70CMaEZ1nEcXs7BFEmHWlAcMgwHQfzVarzeEKqRouYntSOG1xx7rjEkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725745772; c=relaxed/simple;
	bh=kGaVm3ajfEzbqOzJXpCQSZ0xPnHjlIg/FyJWIUkrZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3vEseJiJdByBCoTnSZTl18DH6pqVXiP40fDYPsnZKJVBJ29QxMCPW6NGGXYJtUYSxmse051RJ4jUOipe+cBD10fQzi2keqg/JXeIkn4u2x7OvkDqKvyGgUxk/wsJe3oTa1vVbO1GhAxxaAzPx8yhgcWjrDVSRW9uxmqnFnByf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqm+HT4y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725745771; x=1757281771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kGaVm3ajfEzbqOzJXpCQSZ0xPnHjlIg/FyJWIUkrZgI=;
  b=lqm+HT4yLseil/MVXz+aY4aW3odEhIFy8XHnn83fstH9FfOeaw9+/AKA
   87BlS9xPNglOu7r8ED2v3WF/cmi627ZBhPI9EvjLYvYKgtMq8sk8Zr2TK
   o/QTHzTdviWiBxGfPSKOSc0YBlBvW/Wx6Iq0LuTwMR+q5SZ3/jU3CfJnj
   j0evnV5mXW//SnELBT9rjo65g8V3Z2gjzHsyvK3nfknb2vVYRXA5gdcKA
   oSLI9302lD4P+PHKRnr21yD9n4raum34+b0+NF4dV+fihys/Hrmdbgo8j
   Bl6nkuNP4TrzPgICXDOnYXOJfIsFbC9KSmyeFfkISttztGgFZqd6QLOkA
   g==;
X-CSE-ConnectionGUID: sbmqYL7nS9S0gWLtQPbi+g==
X-CSE-MsgGUID: Na1iVRP3RI+aSvDU+ybvZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="49887699"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="49887699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 14:49:31 -0700
X-CSE-ConnectionGUID: owogG1gmQQqW1koiWTIJUQ==
X-CSE-MsgGUID: h8xLWRGPTOqAG0/Losp03w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="66276962"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Sep 2024 14:49:28 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn3J7-000D2G-2z;
	Sat, 07 Sep 2024 21:49:25 +0000
Date: Sun, 8 Sep 2024 05:49:12 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
Message-ID: <202409080536.stm6x1AU-lkp@intel.com>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>

Hi Rohit,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/lib80211-Use-ERR_CAST-to-return/20240906-194721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240906114455.730559-1-roheetchavan%40gmail.com
patch subject: [PATCH] lib80211: Use ERR_CAST() to return
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240908/202409080536.stm6x1AU-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080536.stm6x1AU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080536.stm6x1AU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/wireless/lib80211.c:21:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/wireless/lib80211.c:21:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/wireless/lib80211.c:21:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/wireless/lib80211.c:21:
   In file included from include/linux/ieee80211.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/wireless/lib80211.c:230:18: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const void *' [-Wint-conversion]
     230 |         return ERR_CAST(1);
         |                         ^
   include/linux/err.h:82:64: note: passing argument to parameter 'ptr' here
      82 | static inline void * __must_check ERR_CAST(__force const void *ptr)
         |                                                                ^
   7 warnings and 1 error generated.


vim +230 net/wireless/lib80211.c

   227	
   228	static void *lib80211_crypt_null_init(int keyidx)
   229	{
 > 230		return ERR_CAST(1);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

