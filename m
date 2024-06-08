Return-Path: <linux-wireless+bounces-8717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53751900F76
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 06:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38241F21A6E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2024 04:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621EAFC0E;
	Sat,  8 Jun 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9rl2B8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E9B64E;
	Sat,  8 Jun 2024 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820651; cv=none; b=hY91xNNTFm232tLUkiSzi1xKZgoseKY3nQmiTLIPMo6sepZ2fOCth9esHBvvScBgBbouDrxq2y7tlbeZBXaKlfr2t7Wwwa/WU/QdD6qeDxX3yA4O1v8a7LqSONm/HB7abqSbFYmRbWO74nLzyDO1qVkE9j5xBkHbClSN2uwxQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820651; c=relaxed/simple;
	bh=HoIBiSVlyaYUy4do0V2wz4HWBYTIE8ZePp7n/kH8yGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIWaqfaVkSXlcOYzQKct/dnr9jRqIky+kbPKAqYQL4cmoeUmNXJSXKg4IR5UbeOa3PSe9C4XkeWTmli4N9dGaNf8mnUUbpCnf/3WQ4qGUHvcMN1/0WrE7NnA/IWgK0KY1R1ZGDmxCAjyv39tpL+QTW3exUBYj9kZ26oHU+1Wm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9rl2B8X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717820648; x=1749356648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HoIBiSVlyaYUy4do0V2wz4HWBYTIE8ZePp7n/kH8yGk=;
  b=Y9rl2B8XPB/cD5MmPfvY5hYC5eHgOC1xG4fBoKADQcUDRjNludnQsPkZ
   RNRDGNj4gH3UWZ/V/rL+79FNuH66etFOG5MuBuAb/2MGnpbdg7Lnr4hVD
   mvt7/im9MA6Z54vfiEqfJg+lBXGoDsgHV6PuAVaCxRaG9vc/6n+8km9h2
   jlbQIVgtFQKo0RwbJ6Kg0tbvUh1BV1PPHzpR023IF7g1lx+FbsngHsDbT
   IoVUcBnnvx9x/d2se8vUnzDCFOvHIDhcns+rHObdR3Hi0npl5SUDZsBCs
   Y6jWbvjShUT9Pw3reGyNTjeko86QP1brq1NryTEuTp7pjBpggvnUrPRyS
   Q==;
X-CSE-ConnectionGUID: FhZlvdiKQY2xDHs7+avgKw==
X-CSE-MsgGUID: xgnCSMy9SvCk8HNrc5XH4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25970566"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="25970566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 21:24:08 -0700
X-CSE-ConnectionGUID: laP+KoQJQsOb6kbwAYEetA==
X-CSE-MsgGUID: vKjSdE7hRku0mbO9S69tvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="43456632"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Jun 2024 21:24:06 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFncZ-0000yj-0N;
	Sat, 08 Jun 2024 04:24:03 +0000
Date: Sat, 8 Jun 2024 12:23:36 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v4 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Message-ID: <202406081255.2FEQDvBK-lkp@intel.com>
References: <20240607160527.23624-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607160527.23624-7-johannes@sipsolutions.net>

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mcgrof/modules-next]
[also build test WARNING on arnd-asm-generic/master tip/timers/core net/main net-next/main linus/master horms-ipvs/master v6.10-rc2 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/tracing-add-__print_sym-to-replace-__print_symbolic/20240608-000918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20240607160527.23624-7-johannes%40sipsolutions.net
patch subject: [PATCH v4 1/4] tracing: add __print_sym() to replace __print_symbolic()
config: i386-buildonly-randconfig-005-20240608 (https://download.01.org/0day-ci/archive/20240608/202406081255.2FEQDvBK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081255.2FEQDvBK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081255.2FEQDvBK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events.c:1583:6: warning: variable 'n_sym_defs' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1583 |         if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events.c:1595:18: note: uninitialized use occurs here
    1595 |         for (i = 0; i < n_sym_defs; i++) {
         |                         ^~~~~~~~~~
   kernel/trace/trace_events.c:1583:2: note: remove the 'if' if its condition is always true
    1583 |         if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events.c:1581:25: note: initialize the variable 'n_sym_defs' to silence this warning
    1581 |         unsigned int n_sym_defs, i;
         |                                ^
         |                                 = 0
   1 warning generated.


vim +1583 kernel/trace/trace_events.c

  1575	
  1576	/* note: @name is not NUL-terminated */
  1577	static void show_sym_list(struct seq_file *m, struct trace_event_call *call,
  1578				  const char *name, unsigned int name_len)
  1579	{
  1580		struct trace_sym_def **sym_defs;
  1581		unsigned int n_sym_defs, i;
  1582	
> 1583		if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module) {
  1584			sym_defs = __start_ftrace_sym_defs;
  1585			n_sym_defs = __stop_ftrace_sym_defs - __start_ftrace_sym_defs;
  1586	#ifdef CONFIG_MODULES
  1587		} else {
  1588			struct module *mod = call->module;
  1589	
  1590			sym_defs = mod->trace_sym_defs;
  1591			n_sym_defs = mod->num_trace_sym_defs;
  1592	#endif /* CONFIG_MODULES */
  1593		}
  1594	
  1595		for (i = 0; i < n_sym_defs; i++) {
  1596			unsigned int sym_len;
  1597	
  1598			if (!sym_defs[i])
  1599				continue;
  1600			if (sym_defs[i]->system != call->class->system)
  1601				continue;
  1602			sym_len = strlen(sym_defs[i]->symbol_id);
  1603			if (name_len != sym_len)
  1604				continue;
  1605			if (strncmp(sym_defs[i]->symbol_id, name, sym_len))
  1606				continue;
  1607			if (sym_defs[i]->show)
  1608				sym_defs[i]->show(m);
  1609			break;
  1610		}
  1611	}
  1612	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

