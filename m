Return-Path: <linux-wireless+bounces-8688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C69004E0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 15:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F6E1C20954
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F71953BF;
	Fri,  7 Jun 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPYHJWZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E81940B5;
	Fri,  7 Jun 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766881; cv=none; b=N/cjyc7SJ9CxIJd0UwFN7Wu9faRTBMMOlkcSQlU8K/+YXHvz2fz5QQ+ABC81KjMPkzXZgbrtYE1kTzhKNBk+7tyf++16g1JSGi+TA5HVxkgizPSWM5t4dweUw6MjvKpfBrpqFcrkecfFYzmquljhZaDvGqfVEc+jjyO9xoo00Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766881; c=relaxed/simple;
	bh=lLS9fQ8kfF3shs/Rg28crtMFJ5S+9vbd4oQ5jIQTZxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyGlBakrmf+zNbsEz9MKZaZlmJFez2iSyQYxfN6v3IjuERZD8O9ZWO+dPJ8C3/7Tvv5FkeU26domxVOOFrSTMCwob2OuNp3Jv40/+hsu0azySth/9oCI50vRuxr8Fsc6rkhX0EEI5JVDu0cYha1Lt7iuHzqmiLkiE9d0Ek49A1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPYHJWZB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717766879; x=1749302879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLS9fQ8kfF3shs/Rg28crtMFJ5S+9vbd4oQ5jIQTZxg=;
  b=RPYHJWZBV5RdiJENI/IPndy3ZTWOOYyM9cUZAAQv1hCNGjLNfeBJD+UL
   YqBaXJjICuzaOcTiBEEymroblKYshu8+qFZaA3qRlIoFEk+q/v8bS4sVg
   mz085mgre5jXmV0FdKcR0uvf4NVyjsL3evWFYoMKGph/AAnrguERNUd8L
   AKi/PyHMyGqp+xTtGQgdfUh7sKHascDoBbdUbZSxEJe3aAGcY9mXmtuBP
   FYoaTzJeP9N45X0zophadFfBMjNnqtPGHfXJ3C+UdvzZR7Qmx+ZLpFXRz
   MCjBmOTZ7uqrGTSwja0f4PUphV7O4J3bVwMY65uQLLmuNud02yEbN8pWr
   Q==;
X-CSE-ConnectionGUID: /4Lj486YS7m9GsbMTC2OvA==
X-CSE-MsgGUID: AubbwCOfTEq5ePjHlcgEWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14320996"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14320996"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 06:27:59 -0700
X-CSE-ConnectionGUID: 3xJGotWVR1+A10Jmx2cynw==
X-CSE-MsgGUID: FkvqHdazRBSdIH4lEToSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38901974"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2024 06:27:57 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFZdL-0004ps-0R;
	Fri, 07 Jun 2024 13:27:55 +0000
Date: Fri, 7 Jun 2024 21:27:00 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Message-ID: <202406072129.3ZzFDOlC-lkp@intel.com>
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
config: arc-randconfig-002-20240607 (https://download.01.org/0day-ci/archive/20240607/202406072129.3ZzFDOlC-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072129.3ZzFDOlC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072129.3ZzFDOlC-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_events.c: In function 'show_sym_list':
>> kernel/trace/trace_events.c:1586:31: error: invalid use of undefined type 'struct module'
    1586 |                 sym_defs = mod->trace_sym_defs;
         |                               ^~
   kernel/trace/trace_events.c:1587:33: error: invalid use of undefined type 'struct module'
    1587 |                 n_sym_defs = mod->num_trace_sym_defs;
         |                                 ^~


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

