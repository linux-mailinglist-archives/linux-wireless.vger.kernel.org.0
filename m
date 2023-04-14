Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4496E2433
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDNNXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 09:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNNXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 09:23:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C649CB
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681478613; x=1713014613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JAZW5ATCnn7F5zZI8Jg4WMsIQ7Qb6hYI5RMM1N9r7sI=;
  b=UCZ3O2io4MZwBl1u6birSUTcWeoeJIPJEZvj9BhoHK3OmndXJPK8BHpw
   X4g4oj/UVa/v5E3XP19jPnoRWfw6AOk3EV7Qft3ya7w2KeY2vI+i9PROS
   Xe6h0WrkZV5ovdPP2t0X964goGJQ456LRZI2KYjbNVXnJqULsYXgkKgGU
   RnbimYC89D0Qft5lsGkUS1oL5NjdtZGLCwoaiY0d0cVjLb8sLIFb08Lhw
   0jKznJZShtOtlr+jw2a06XZLhgI/ovm1vyOkQfmfMGCS2nPH/yR/BC7vg
   tzmocTBGTb00+x0fpUFmGfVEo0cpEcqtbNKUERlWvFqAul4oFnXhV9szY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="341959231"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="341959231"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 06:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="936009109"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="936009109"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2023 06:23:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnJOk-000ZYl-0W;
        Fri, 14 Apr 2023 13:23:30 +0000
Date:   Fri, 14 Apr 2023 21:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath11k: Add rx histogram stats
Message-ID: <202304142106.PaDYMwe0-lkp@intel.com>
References: <20230414112603.601199-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414112603.601199-1-quic_mkenna@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Maharaja,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvalo-ath/ath-next]
[cannot apply to wireless/main wireless-next/main linus/master v6.3-rc6 next-20230413]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maharaja-Kennadyrajan/wifi-ath11k-Add-rx-histogram-stats/20230414-192912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
patch link:    https://lore.kernel.org/r/20230414112603.601199-1-quic_mkenna%40quicinc.com
patch subject: [PATCH v2] wifi: ath11k: Add rx histogram stats
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230414/202304142106.PaDYMwe0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8612657f6ce3fd8bd47a5c1b4ca0177e95a647f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maharaja-Kennadyrajan/wifi-ath11k-Add-rx-histogram-stats/20230414-192912
        git checkout 8612657f6ce3fd8bd47a5c1b4ca0177e95a647f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304142106.PaDYMwe0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/debugfs_sta.c:242:13: warning: no previous prototype for 'legacy_rate_str' [-Wmissing-prototypes]
     242 | const char *legacy_rate_str(int legacy_rate_idx)
         |             ^~~~~~~~~~~~~~~


vim +/legacy_rate_str +242 drivers/net/wireless/ath/ath11k/debugfs_sta.c

   241	
 > 242	const char *legacy_rate_str(int legacy_rate_idx)
   243	{
   244		switch (legacy_rate_idx) {
   245		case 0:
   246			return "1Mbps";
   247		case 1:
   248			return "2Mbps";
   249		case 2:
   250			return "5.5Mbps";
   251		case 3:
   252			return "6Mbps";
   253		case 4:
   254			return "9Mbps";
   255		case 5:
   256			return "11Mbps";
   257		case 6:
   258			return "12Mbps";
   259		case 7:
   260			return "18Mbps";
   261		case 8:
   262			return "18Mbps";
   263		case 9:
   264			return "24Mbps";
   265		case 10:
   266			return "36Mbps";
   267		case 11:
   268			return "48Mbps";
   269		case 12:
   270			return "54Mbps";
   271		default:
   272			return "invalid legacy rate index";
   273		}
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
