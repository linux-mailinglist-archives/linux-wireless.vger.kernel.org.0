Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8D5A5AED
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiH3ExF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 00:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3ExD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 00:53:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A45B08B8
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661835182; x=1693371182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crYztj4udccKCQz388/BT/G/jshc6rBDwJIEDviDRPc=;
  b=IxXBATPN68BTJAmzRPaO8uZDpii57fKEoiAOX5az3l8qZnGeu050PgnB
   /zQp/mknZPdFe3LF05wRgxH8olnMCrC/85Kiamp/eNUmDNNsbUXEvfmTq
   e+0Ke8j76a/KClwRjy/UTLpyaJ197bZt3PXN0MKWDbiLk0eJTt8dtHFgb
   sCg2QZZZGfNGsPPtX74XDbFX94XWnrPiyo8JF8Mf4edFR/3ipQxiYcrG7
   PqNsZPvQ1u4Mwi0+9G9ol7qS4v1XRneisulYVtp4mwIu0fQyIdE1Wd7kL
   Dm2TMReqlz+7cYfMdNvfe9OXnOMzJ6g+HR1a2CQGc/WTzIoyoCA9qFGOV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="274826598"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="274826598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 21:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588440926"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 21:53:00 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oStFD-0000Y5-37;
        Tue, 30 Aug 2022 04:52:59 +0000
Date:   Tue, 30 Aug 2022 12:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: Re: [PATCH v2 01/12] cfg80211: regulatory: extend regulatory support
 for S1G
Message-ID: <202208301259.DiwKm3rQ-lkp@intel.com>
References: <20220830022017.51017-2-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830022017.51017-2-kieran.frewen@morsemicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kieran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless/main]
[also build test WARNING on linus/master v6.0-rc3 next-20220829]
[cannot apply to wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kieran-Frewen/Additional-Support-for-802-11ah-S1G/20220830-102217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220830/202208301259.DiwKm3rQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7c0e7a45e22911c6e1b16ecdce1a4d6022fd66ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kieran-Frewen/Additional-Support-for-802-11ah-S1G/20220830-102217
        git checkout 7c0e7a45e22911c6e1b16ecdce1a4d6022fd66ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/wireless/util.c:137:5: warning: no previous prototype for 'ieee80211_s1g_channel_to_freq_khz' [-Wmissing-prototypes]
     137 | u32 ieee80211_s1g_channel_to_freq_khz(int chan)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   net/wireless/reg.c: In function 'handle_channel_custom.constprop':
>> net/wireless/reg.c:2597:28: warning: 'center_freq_khz' is used uninitialized [-Wuninitialized]
    2597 |                 reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/wireless/reg.c:2586:17: note: 'center_freq_khz' was declared here
    2586 |         u32 bw, center_freq_khz;
         |                 ^~~~~~~~~~~~~~~


vim +/ieee80211_s1g_channel_to_freq_khz +137 net/wireless/util.c

   136	
 > 137	u32 ieee80211_s1g_channel_to_freq_khz(int chan)
   138	{
   139		u32 base = ieee80211_s1g_base_freq(chan);
   140	
   141		if (!base)
   142			return 0;
   143	
   144		return (base + chan * 500);
   145	}
   146	EXPORT_SYMBOL(ieee80211_s1g_channel_to_freq_khz);
   147	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
