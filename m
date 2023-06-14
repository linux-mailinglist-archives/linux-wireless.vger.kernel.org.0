Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4EF72F357
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 06:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjFNEEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 00:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjFNEEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 00:04:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC21989
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686715440; x=1718251440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9v4z+xOJMN2xrp3cgHzKRWncbNpcvkzIojQLXSttgw=;
  b=Gdurx97xEPx1SgScIb/Wb3JJ+c88+a/kzJGmyqNl1OenJWMKLwkhpFnn
   F0n1z6L7EOQWhNNgTjfFmjSygjnduZvVtKEClNlaa+yCDuA5d0RDghWqa
   jEdJy9+qMvdHJxR9CeuNx2pESr8zCwSxEND0I89kwYyYdBY82Yjz+2ZBa
   RNVN2hKOZjzR1E7ZVXVcaXNiXTTEAk8JiGvu29LIwvlmY9zN6o0URwowV
   iTXpS7lezu3f47CG3HMXdJVJRX+Q1BPBADCWRDCkoBrj1fGIJH1uenePT
   DsKNMXflK7KhLzIw8Z+woAZmj15Yo3A8IY0GqmqMpT0KV3qzF8eEUTm9Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="356007151"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="356007151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="741680271"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="741680271"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2023 21:02:28 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9HiF-0000A1-2B;
        Wed, 14 Jun 2023 04:02:27 +0000
Date:   Wed, 14 Jun 2023 12:01:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arowa Suliman <arowa@chromium.org>, ath11k@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Arowa Suliman <arowa@google.com>
Subject: Re: [PATCH] wifi: ath11k: Add crash logging
Message-ID: <202306141105.c1e82Q0y-lkp@intel.com>
References: <20230614023125.284218-1-arowa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614023125.284218-1-arowa@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arowa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvalo-ath/ath-next]
[cannot apply to wireless/main wireless-next/main linus/master v6.4-rc6 next-20230613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arowa-Suliman/wifi-ath11k-Add-crash-logging/20230614-103201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
patch link:    https://lore.kernel.org/r/20230614023125.284218-1-arowa%40google.com
patch subject: [PATCH] wifi: ath11k: Add crash logging
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230614/202306141105.c1e82Q0y-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
        git fetch kvalo-ath ath-next
        git checkout kvalo-ath/ath-next
        b4 shazam https://lore.kernel.org/r/20230614023125.284218-1-arowa@google.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306141105.c1e82Q0y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/mhi.c: In function 'ath11k_mhi_op_status_cb':
>> drivers/net/wireless/ath/ath11k/mhi.c:328:25: warning: passing argument 2 of 'ath11k_info' makes pointer from integer without a cast [-Wint-conversion]
     328 |         ath11k_info(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
         |                         ^~~~~~~~~~~~~~~
         |                         |
         |                         int
   In file included from drivers/net/wireless/ath/ath11k/mhi.c:14:
   drivers/net/wireless/ath/ath11k/debug.h:76:69: note: expected 'const char *' but argument is of type 'int'
      76 | __printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
         |                                                         ~~~~~~~~~~~~^~~


vim +/ath11k_info +328 drivers/net/wireless/ath/ath11k/mhi.c

   322	
   323	static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
   324					    enum mhi_callback cb)
   325	{
   326		struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
   327	
 > 328	        ath11k_info(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
   329			   ath11k_mhi_op_callback_to_str(cb));
   330	
   331		switch (cb) {
   332		case MHI_CB_SYS_ERROR:
   333			ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
   334			break;
   335		case MHI_CB_EE_RDDM:
   336			ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
   337	                if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
   338				queue_work(ab->workqueue_aux, &ab->reset_work);
   339			break;
   340		default:
   341			break;
   342		}
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
