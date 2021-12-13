Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D07472CF3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 14:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhLMNNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 08:13:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:55324 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237237AbhLMNNt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 08:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639401229; x=1670937229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fDvQIWLWTaRgRRLXSmGWq+oFnO4IwlflBxoU/HMSINU=;
  b=DIrh19SaINptr+n8R+XQBkfxC4kmuXXIS3FBgNn6dyelz+yAyktfymzg
   tVhr/uvYZJGGjFtJYqsCp9mkSh+KoZa5jeCTtTAiJdL0uRJIt+4sd7o3+
   53DAtAe9aRNCd8WSImvKu/+cyFrhnReKrV1XCVo/IYLK+BYp7QgBFCoPM
   OpookfTYy4qtqV5FHtKfOfNu2AG19A0+qGZukkXyRTcOT+zDyYrGUSlir
   8l2n+aRQLX2gjLRi8cQby0KZmlCGeEdac1LmhAPHCYa76PMXPyfGx65ry
   YsrbrNso+hfgFDZm3J/WWfbojBk3Gux/9pRqHpquUMmp2NcGb/gMqttz+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="236256930"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="236256930"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="582910182"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2021 05:13:46 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwl9F-0006gS-Tj; Mon, 13 Dec 2021 13:13:45 +0000
Date:   Mon, 13 Dec 2021 21:12:53 +0800
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
Message-ID: <202112132138.0tsPYnSZ-lkp@intel.com>
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
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20211213/202112132138.0tsPYnSZ-lkp@intel.com/config)
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

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>> ERROR: modpost: "__udivdi3" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] undefined!
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
