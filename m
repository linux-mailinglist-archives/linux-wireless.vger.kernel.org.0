Return-Path: <linux-wireless+bounces-8690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FB90052B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BB41F249B7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2EF195978;
	Fri,  7 Jun 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyvSM8Tk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A345194A70;
	Fri,  7 Jun 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767482; cv=none; b=YH6kFyBvWKr4z5V6iVZTjeBt8JMBV8Xmb/hWZgwhTCC/2OzQ5lc0HZ1U5CUaMSRn3CDOHWq2stYozON5rfUdx1KivBji0+k/WCGd52quWMe1HVZzIdiGYyoO6MbyF2UMDwNPs1S10EOgoy8qEntpWaxQzTAVTK79qp2q+ftB0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767482; c=relaxed/simple;
	bh=3O1OghiGGIGnmwunwGyD+S8AwdzNTowvLS3lDkW+bfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wobox4RWxxq1n4t2yksEFUgPYcpgVV4HZbHfM8K4mx2+tAuGVHzvGZBuUPNkYBuvtI/4DCL6bVEOnnCQNWwgc/7/op3n1xf9kU1dcONzW87/ZBY9jxwysGcMYfpVvtBthHAXyBxIT8o6/9VxpDVPJvXCNOfKPcYn7XMCcweXklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyvSM8Tk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717767481; x=1749303481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3O1OghiGGIGnmwunwGyD+S8AwdzNTowvLS3lDkW+bfM=;
  b=TyvSM8TkvuxtB5fQndhPXvMdkmDkjx1AMYV8Q9/qX8gu/QijQYwtpLVq
   oVp46lsF0FIWxOfPTBAeyrM9GbQrEP3iSHApgvKNC/N9ggNljgxY412qO
   smvftrEo+UeeWIk2gb4EBxRqpvhenKqL9gXmtBxrJpQeKsUcJYuR3YT1D
   7gmIARv30GRS8z3QOnlOwDS+COw8Jnqp0pFotnkN5L8YbWQodOyjeuxyH
   iIHo/zlE5ARAlI8CTx4WLoxqwhRBrvIecjCqyLPg6fZc5I84h5HgPzj0S
   Yjm8LJZrvAA7EooAgti9nXNbta68XtmLUUr/ecxQQ5aj9kdVH3gHj3dmR
   Q==;
X-CSE-ConnectionGUID: alBrKjLMRQed6OHxMIkkNQ==
X-CSE-MsgGUID: kpVm4WaQQRWKOS5qmOP5Aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="39888372"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="39888372"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:38:00 -0700
X-CSE-ConnectionGUID: 8dBgWMkUQS21WbMT7fgfOQ==
X-CSE-MsgGUID: odaHmeo2Q0CXFVfJJ0VRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69494003"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jun 2024 06:37:58 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFZn2-0004qe-0P;
	Fri, 07 Jun 2024 13:37:56 +0000
Date: Fri, 7 Jun 2024 21:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Message-ID: <202406072141.OLmqbch3-lkp@intel.com>
References: <20240606203255.49433-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606203255.49433-7-johannes@sipsolutions.net>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on mcgrof/modules-next]
[also build test ERROR on arnd-asm-generic/master tip/timers/core net/main net-next/main linus/master horms-ipvs/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/tracing-add-__print_sym-to-replace-__print_symbolic/20240607-043503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20240606203255.49433-7-johannes%40sipsolutions.net
patch subject: [PATCH v3 1/4] tracing: add __print_sym() to replace __print_symbolic()
config: arm64-randconfig-002-20240607 (https://download.01.org/0day-ci/archive/20240607/202406072141.OLmqbch3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072141.OLmqbch3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072141.OLmqbch3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_events.c:15:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/trace/trace_events.c:1586:17: error: incomplete definition of type 'struct module'
    1586 |                 sym_defs = mod->trace_sym_defs;
         |                            ~~~^
   include/linux/printk.h:350:8: note: forward declaration of 'struct module'
     350 | struct module;
         |        ^
   kernel/trace/trace_events.c:1587:19: error: incomplete definition of type 'struct module'
    1587 |                 n_sym_defs = mod->num_trace_sym_defs;
         |                              ~~~^
   include/linux/printk.h:350:8: note: forward declaration of 'struct module'
     350 | struct module;
         |        ^
   1 warning and 2 errors generated.


vim +1586 kernel/trace/trace_events.c

  1575	
  1576	/* note: @name is not NUL-terminated */
  1577	static void show_sym_list(struct seq_file *m, struct trace_event_call *call,
  1578				  const char *name, unsigned int name_len)
  1579	{
  1580		struct trace_sym_def **sym_defs;
  1581		unsigned int n_sym_defs, i;
  1582	
  1583		if (call->module) {
  1584			struct module *mod = call->module;
  1585	
> 1586			sym_defs = mod->trace_sym_defs;
  1587			n_sym_defs = mod->num_trace_sym_defs;
  1588		} else {
  1589			sym_defs = __start_ftrace_sym_defs;
  1590			n_sym_defs = __stop_ftrace_sym_defs - __start_ftrace_sym_defs;
  1591		}
  1592	
  1593		for (i = 0; i < n_sym_defs; i++) {
  1594			unsigned int sym_len;
  1595	
  1596			if (!sym_defs[i])
  1597				continue;
  1598			if (sym_defs[i]->system != call->class->system)
  1599				continue;
  1600			sym_len = strlen(sym_defs[i]->symbol_id);
  1601			if (name_len != sym_len)
  1602				continue;
  1603			if (strncmp(sym_defs[i]->symbol_id, name, sym_len))
  1604				continue;
  1605			if (sym_defs[i]->show)
  1606				sym_defs[i]->show(m);
  1607			break;
  1608		}
  1609	}
  1610	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

