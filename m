Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB75A5F78
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiH3Jct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiH3Jc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A730A2A8A
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661851930; x=1693387930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gccZn9I0+N8z97syHj0uFijkRdJnRbnaf9VVahNbVog=;
  b=JNt5uZzGpnkROchWoA3R2vCHXDquNZX7r+MexfOu70jwqg0ikL5Upqib
   4GdlYlxP0m1yZe86aEi7HOKafrBljdhC+KbM+5AQcY/OlEULQQlZ9Bhif
   K4ebotmc8hQXOguCpFsaOFRbiTjExKrIOAg11OH/AySjGjL7QvKv1I7Jq
   +Skfqv/4bXQnY+Zd9PV8wMRujYWC52E8taoDblLQVUEFj6ljn/4bYKfv9
   GnjrEoJalveWWW/H7Vk9B4u5J93if68HEySFjxLwbAYheI6ApGSixqes/
   JCROq3kgA8PwAtEcNIGWnsnAGulzfIlCitk4wSkohseVJRchvl0Xd16Qs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="356846399"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="356846399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641302532"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 02:32:01 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSxbE-00008Y-1I;
        Tue, 30 Aug 2022 09:32:00 +0000
Date:   Tue, 30 Aug 2022 17:31:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: Re: [PATCH v2 01/12] cfg80211: regulatory: extend regulatory support
 for S1G
Message-ID: <202208301755.3ARl5XbS-lkp@intel.com>
References: <20220830022017.51017-2-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830022017.51017-2-kieran.frewen@morsemicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kieran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless/main]
[also build test WARNING on linus/master v6.0-rc3 next-20220830]
[cannot apply to wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kieran-Frewen/Additional-Support-for-802-11ah-S1G/20220830-102217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: arm-colibri_pxa270_defconfig (https://download.01.org/0day-ci/archive/20220830/202208301755.3ARl5XbS-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/7c0e7a45e22911c6e1b16ecdce1a4d6022fd66ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kieran-Frewen/Additional-Support-for-802-11ah-S1G/20220830-102217
        git checkout 7c0e7a45e22911c6e1b16ecdce1a4d6022fd66ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/wireless/util.c:137:5: warning: no previous prototype for function 'ieee80211_s1g_channel_to_freq_khz' [-Wmissing-prototypes]
   u32 ieee80211_s1g_channel_to_freq_khz(int chan)
       ^
   net/wireless/util.c:137:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 ieee80211_s1g_channel_to_freq_khz(int chan)
   ^
   static 
   1 warning generated.
--
>> net/wireless/reg.c:2597:33: warning: variable 'center_freq_khz' is uninitialized when used here [-Wuninitialized]
                   reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
                                                 ^~~~~~~~~~~~~~~
   net/wireless/reg.c:2586:25: note: initialize the variable 'center_freq_khz' to silence this warning
           u32 bw, center_freq_khz;
                                  ^
                                   = 0
   1 warning generated.


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
