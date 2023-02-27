Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41946A4895
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjB0Ru5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 12:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0Ru4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 12:50:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB223121
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677520254; x=1709056254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCP1moy5NiRdRpheFbYxh1JqhXqdAQE2d+Zm/3UFYCo=;
  b=WTbBrOTqw8HNe7H3erMSdeDSGuwlgp0T29FSHMZsGvXMBetIs8Sm3K7Z
   5Og5t1CkJWYv9K1hmv1+qO8Ds1aCZT827ga3M7++gJA4UoGdyJ/OZKd5e
   bRDGcPSMOlq4KCVd0TEn5RC7OC2CgbDB7UPRZxqXnjowEKZ6upGdtE7Lu
   sctQjEZNE7mn6zdvzYaxkKly6ZhRAQnVzQk6t6PksgRYckRl9jrKb06Gd
   zY6p/Z7JHomQUO6fLQFfuA2LjaiYuwtfG6vV97wWNxmJxLhl4Q8iRu2Vl
   2h6wxb/sdxRgkFxLJq/DAF/FlxkXZoT5uP7ipV5yf5ItdKHTAkptQHbCr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="333967137"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="333967137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="762815884"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="762815884"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 09:50:53 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWheG-0004eL-25;
        Mon, 27 Feb 2023 17:50:52 +0000
Date:   Tue, 28 Feb 2023 01:50:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy
 directory
Message-ID: <202302280135.b1uG3bwe-lkp@intel.com>
References: <20230227121732.8967-3-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227121732.8967-3-kvalo@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ec52d77d077529f198fd874c550a26b9cc86a331]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalle-Valo/wifi-move-mac80211_hwsim-and-virt_wifi-to-virtual-directory/20230227-201848
base:   ec52d77d077529f198fd874c550a26b9cc86a331
patch link:    https://lore.kernel.org/r/20230227121732.8967-3-kvalo%40kernel.org
patch subject: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy directory
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230228/202302280135.b1uG3bwe-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b3643ed46f437156c43b21bfc61dd622a6d53191
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kalle-Valo/wifi-move-mac80211_hwsim-and-virt_wifi-to-virtual-directory/20230227-201848
        git checkout b3643ed46f437156c43b21bfc61dd622a6d53191
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302280135.b1uG3bwe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'init_startup_params',
       inlined from 'ray_init' at drivers/net/wireless/legacy/ray_cs.c:506:2:
>> drivers/net/wireless/legacy/ray_cs.c:628:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
     628 |                 strncpy(local->sparm.b4.a_current_ess_id, essid, ESSID_SIZE);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +628 drivers/net/wireless/legacy/ray_cs.c

141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  568  
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  569  /*===========================================================================*/
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  570  static void init_startup_params(ray_dev_t *local)
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  571  {
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  572  	int i;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  573  
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  574  	if (country > JAPAN_TEST)
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  575  		country = USA;
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  576  	else if (country < USA)
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  577  		country = USA;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  578  	/* structure for hop time and beacon period is defined here using
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  579  	 * New 802.11D6.1 format.  Card firmware is still using old format
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  580  	 * until version 6.
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  581  	 *    Before                    After
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  582  	 *    a_hop_time ms byte        a_hop_time ms byte
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  583  	 *    a_hop_time 2s byte        a_hop_time ls byte
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  584  	 *    a_hop_time ls byte        a_beacon_period ms byte
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  585  	 *    a_beacon_period           a_beacon_period ls byte
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  586  	 *
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  587  	 *    a_hop_time = uS           a_hop_time = KuS
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  588  	 *    a_beacon_period = hops    a_beacon_period = KuS
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  589  	 *//* 64ms = 010000 */
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  590  	if (local->fw_ver == 0x55) {
e48d661eb13f2f8 drivers/net/wireless/ray_cs.c Kees Cook      2017-05-05  591  		memcpy(&local->sparm.b4, b4_default_startup_parms,
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  592  		       sizeof(struct b4_startup_params));
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  593  		/* Translate sane kus input values to old build 4/5 format */
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  594  		/* i = hop time in uS truncated to 3 bytes */
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  595  		i = (hop_dwell * 1024) & 0xffffff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  596  		local->sparm.b4.a_hop_time[0] = (i >> 16) & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  597  		local->sparm.b4.a_hop_time[1] = (i >> 8) & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  598  		local->sparm.b4.a_beacon_period[0] = 0;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  599  		local->sparm.b4.a_beacon_period[1] =
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  600  		    ((beacon_period / hop_dwell) - 1) & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  601  		local->sparm.b4.a_curr_country_code = country;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  602  		local->sparm.b4.a_hop_pattern_length =
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  603  		    hop_pattern_length[(int)country] - 1;
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  604  		if (bc) {
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  605  			local->sparm.b4.a_ack_timeout = 0x50;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  606  			local->sparm.b4.a_sifs = 0x3f;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  607  		}
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  608  	} else { /* Version 5 uses real kus values */
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  609  		memcpy((UCHAR *) &local->sparm.b5, b5_default_startup_parms,
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  610  		       sizeof(struct b5_startup_params));
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  611  
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  612  		local->sparm.b5.a_hop_time[0] = (hop_dwell >> 8) & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  613  		local->sparm.b5.a_hop_time[1] = hop_dwell & 0xff;
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  614  		local->sparm.b5.a_beacon_period[0] =
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  615  		    (beacon_period >> 8) & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  616  		local->sparm.b5.a_beacon_period[1] = beacon_period & 0xff;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  617  		if (psm)
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  618  			local->sparm.b5.a_power_mgt_state = 1;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  619  		local->sparm.b5.a_curr_country_code = country;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  620  		local->sparm.b5.a_hop_pattern_length =
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  621  		    hop_pattern_length[(int)country];
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  622  	}
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  623  
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  624  	local->sparm.b4.a_network_type = net_type & 0x01;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  625  	local->sparm.b4.a_acting_as_ap_status = TYPE_STA;
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  626  
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  627  	if (essid != NULL)
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16 @628  		strncpy(local->sparm.b4.a_current_ess_id, essid, ESSID_SIZE);
^1da177e4c3f415 drivers/net/wireless/ray_cs.c Linus Torvalds 2005-04-16  629  } /* init_startup_params */
141fa61f10c419c drivers/net/wireless/ray_cs.c John Daiker    2009-03-10  630  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
