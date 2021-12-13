Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5826B472D1E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhLMNXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 08:23:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:59917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhLMNXu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 08:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639401830; x=1670937830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NUaiRW8izVYY+jHItB+IlWmb+AOutAfJrsSjOPLwAo4=;
  b=fsl1CHqyBr6HU1VLMTWSfPUkWEqN20SO60gvbKqjY0dL0pb0L+UJXT3f
   opjapvx56mj1pB42ysMKKifZuj4ejUgpfh8AdhDpw7E1Nq64KNbpezRns
   U7UrVtDzGV1cbmdAR6RzCuyHzq/pprvstq+XUyoQ5WSsihKBfexQKz06U
   83JwM3EyXfH99uFayeXYW+j9khuhtunNuiGAI/BP0MjEL8U2CZ+ygh89c
   JBgGV+a+3wUFHschYUxHSQeeOgcyJlpDEnvqI/SV+F3Xqszgs3qrgwRcT
   5YhzmWimAjl6d3+S8CX9NpA95pl3rP8FE58uvCTLutzY5OgaPN1B/5AbM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="226006292"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="226006292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="613822560"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2021 05:23:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwlIw-0006hT-B3; Mon, 13 Dec 2021 13:23:46 +0000
Date:   Mon, 13 Dec 2021 21:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: Re: [PATCH v3] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
Message-ID: <202112132120.tRzeHzz5-lkp@intel.com>
References: <20211213060309.28323-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213060309.28323-1-MeiChia.Chiu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi MeiChia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvalo-wireless-drivers-next/master]
[also build test ERROR on kvalo-wireless-drivers/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/MeiChia-Chiu/mt76-mt7915-add-mu-mimo-and-ofdma-debugfs-knobs/20211213-140356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211213/202112132120.tRzeHzz5-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/91cb277e37dbed42e6b6aee256694204ba8d9a7f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review MeiChia-Chiu/mt76-mt7915-add-mu-mimo-and-ofdma-debugfs-knobs/20211213-140356
        git checkout 91cb277e37dbed42e6b6aee256694204ba8d9a7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x258): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/net/wireless/mediatek/mt76/mt7915/debugfs.o: in function `mt7915_muru_stat_show':
>> debugfs.c:(.text.mt7915_muru_stat_show+0x320): undefined reference to `__udivdi3'
>> mips-linux-ld: debugfs.c:(.text.mt7915_muru_stat_show+0x34c): undefined reference to `__udivdi3'
   mips-linux-ld: debugfs.c:(.text.mt7915_muru_stat_show+0x37c): undefined reference to `__udivdi3'
   mips-linux-ld: debugfs.c:(.text.mt7915_muru_stat_show+0x3ac): undefined reference to `__udivdi3'
   mips-linux-ld: debugfs.c:(.text.mt7915_muru_stat_show+0x3dc): undefined reference to `__udivdi3'
   mips-linux-ld: drivers/net/wireless/mediatek/mt76/mt7915/debugfs.o:debugfs.c:(.text.mt7915_muru_stat_show+0x4dc): more undefined references to `__udivdi3' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
