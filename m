Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7E480D90
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Dec 2021 22:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhL1V6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 16:58:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:39645 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhL1V6a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 16:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640728710; x=1672264710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dk6hTbH+cv2gISEWRP1ddCUSaDmxuFj+Iz+DYoRPxOU=;
  b=m4a3OwVVog9HKDZzfRNAfeOnabnv69Hjw3+9njCxtC084f3wuaSqbtL4
   EYylrQP0b7SMry8b6HHiIA8nx57qNItwxWj1e20464SrcHXcobrFTqx6B
   CoCGv4iDKT6fywf63t0MQhSUFdyBXYlu8vyCjxJUdPKGrm0A115X8ErRy
   +m/GcxCY+aoy+0zjzjtUhozKAwjfYd/t6Z+FXVvF5vuDLNBu82jvN3mV+
   VcrBkoLeoCHuVyUb/fwOWW6GIYgCP4ZIhiCoIjmBhQk7oQ9af6w5evQIa
   VTIv60m94LISvVrUH4Qz4TW3+9DLJb2PccZIztAQSE/NWX6ZBLChJ6GyC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304785154"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="304785154"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 13:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="686695099"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2021 13:58:27 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2KUE-000857-Ih; Tue, 28 Dec 2021 21:58:26 +0000
Date:   Wed, 29 Dec 2021 05:58:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     kbuild-all@lists.01.org, andrew@lunn.ch, mustafa.ismail@intel.com,
        linux-wireless@vger.kernel.org, jiri@nvidia.com,
        pablo@netfilter.org, andrii@kernel.org,
        george.mccollister@gmail.com, ralf@linux-mips.org
Subject: Re: [Intel-wired-lan] [PATCH bpf-next] net: don't include filter.h
 from net/sock.h
Message-ID: <202112290523.IciwiUz8-lkp@intel.com>
References: <20211228192519.386913-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228192519.386913-1-kuba@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jakub,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/net-don-t-include-filter-h-from-net-sock-h/20211229-032712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-m021-20211228 (https://download.01.org/0day-ci/archive/20211229/202112290523.IciwiUz8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/655ad46a9ed1d3185292e9e8e545887d781d06d7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jakub-Kicinski/net-don-t-include-filter-h-from-net-sock-h/20211229-032712
        git checkout 655ad46a9ed1d3185292e9e8e545887d781d06d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/ipv6/ip6_fib.c: In function 'fib6_add':
   net/ipv6/ip6_fib.c:1377:25: warning: variable 'pn' set but not used [-Wunused-but-set-variable]
    1377 |  struct fib6_node *fn, *pn = NULL;
         |                         ^~
   net/ipv6/ip6_fib.c: In function 'ipv6_route_prog_seq_show':
>> net/ipv6/ip6_fib.c:2665:9: error: implicit declaration of function 'bpf_iter_run_prog' [-Werror=implicit-function-declaration]
    2665 |  return bpf_iter_run_prog(prog, &ctx);
         |         ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_fib.c: In function 'ipv6_route_seq_show':
>> net/ipv6/ip6_fib.c:2671:23: error: storage size of 'meta' isn't known
    2671 |  struct bpf_iter_meta meta;
         |                       ^~~~
>> net/ipv6/ip6_fib.c:2676:9: error: implicit declaration of function 'bpf_iter_get_info' [-Werror=implicit-function-declaration]
    2676 |  prog = bpf_iter_get_info(&meta, false);
         |         ^~~~~~~~~~~~~~~~~
   net/ipv6/ip6_fib.c:2671:23: warning: unused variable 'meta' [-Wunused-variable]
    2671 |  struct bpf_iter_meta meta;
         |                       ^~~~
   net/ipv6/ip6_fib.c: In function 'ipv6_route_seq_stop':
   net/ipv6/ip6_fib.c:2688:23: error: storage size of 'meta' isn't known
    2688 |  struct bpf_iter_meta meta;
         |                       ^~~~
   net/ipv6/ip6_fib.c:2688:23: warning: unused variable 'meta' [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +/bpf_iter_run_prog +2665 net/ipv6/ip6_fib.c

8d2ca1d7b5c3e6 Hannes Frederic Sowa 2013-09-21  2655  
138d0be35b141e Yonghong Song        2020-05-09  2656  #if IS_BUILTIN(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)
138d0be35b141e Yonghong Song        2020-05-09  2657  static int ipv6_route_prog_seq_show(struct bpf_prog *prog,
138d0be35b141e Yonghong Song        2020-05-09  2658  				    struct bpf_iter_meta *meta,
138d0be35b141e Yonghong Song        2020-05-09  2659  				    void *v)
138d0be35b141e Yonghong Song        2020-05-09  2660  {
138d0be35b141e Yonghong Song        2020-05-09  2661  	struct bpf_iter__ipv6_route ctx;
138d0be35b141e Yonghong Song        2020-05-09  2662  
138d0be35b141e Yonghong Song        2020-05-09  2663  	ctx.meta = meta;
138d0be35b141e Yonghong Song        2020-05-09  2664  	ctx.rt = v;
138d0be35b141e Yonghong Song        2020-05-09 @2665  	return bpf_iter_run_prog(prog, &ctx);
138d0be35b141e Yonghong Song        2020-05-09  2666  }
138d0be35b141e Yonghong Song        2020-05-09  2667  
138d0be35b141e Yonghong Song        2020-05-09  2668  static int ipv6_route_seq_show(struct seq_file *seq, void *v)
138d0be35b141e Yonghong Song        2020-05-09  2669  {
138d0be35b141e Yonghong Song        2020-05-09  2670  	struct ipv6_route_iter *iter = seq->private;
138d0be35b141e Yonghong Song        2020-05-09 @2671  	struct bpf_iter_meta meta;
138d0be35b141e Yonghong Song        2020-05-09  2672  	struct bpf_prog *prog;
138d0be35b141e Yonghong Song        2020-05-09  2673  	int ret;
138d0be35b141e Yonghong Song        2020-05-09  2674  
138d0be35b141e Yonghong Song        2020-05-09  2675  	meta.seq = seq;
138d0be35b141e Yonghong Song        2020-05-09 @2676  	prog = bpf_iter_get_info(&meta, false);
138d0be35b141e Yonghong Song        2020-05-09  2677  	if (!prog)
138d0be35b141e Yonghong Song        2020-05-09  2678  		return ipv6_route_native_seq_show(seq, v);
138d0be35b141e Yonghong Song        2020-05-09  2679  
138d0be35b141e Yonghong Song        2020-05-09  2680  	ret = ipv6_route_prog_seq_show(prog, &meta, v);
138d0be35b141e Yonghong Song        2020-05-09  2681  	iter->w.leaf = NULL;
138d0be35b141e Yonghong Song        2020-05-09  2682  
138d0be35b141e Yonghong Song        2020-05-09  2683  	return ret;
138d0be35b141e Yonghong Song        2020-05-09  2684  }
138d0be35b141e Yonghong Song        2020-05-09  2685  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
