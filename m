Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055AE69F086
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 09:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBVIku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 03:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBVIks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 03:40:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888A360B8
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677055247; x=1708591247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gP3sT20/P41bGg8fPMMx5wJn2xCfBdfuCU5S4XCnPfw=;
  b=WUtAytsi5SlTZnd1fQ0XZG3FybMGxMInjKNxVNmbKQOJY4TVKeMXFzBM
   3cnfVe2toVIVpgxZpTYTfrRauEbVl/vuPcbsBdjn9bUpytkXJywcj0Pps
   iVFn6LLWcytJ6CGdu+8kFwYARi1zCP8g3zPmpdyDw+ZXGUea+4P4Qax4T
   DKDkNedB8E0Ec3oyDH88NZT4RwgWnopehdofZp4KHZy0oH2EBURarhpWr
   JCdq4VYCl/yooha0S7NKH8uGA4q6061P25oqPyrvJvpL1EDUmjqXuyoD1
   FH5ANH/DZtJKUIBP9oS9142aYQ79qsHYFMSM/VIVhxInjNI1kLxD9zlzy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="316595191"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="316595191"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 00:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="760878061"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="760878061"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2023 00:39:04 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUkeV-0000Ag-2U;
        Wed, 22 Feb 2023 08:39:03 +0000
Date:   Wed, 22 Feb 2023 16:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sujuan Chen <sujuan.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7915: add dev->hif2 support for mt7916 WED
 device
Message-ID: <202302221620.bpkNoy9N-lkp@intel.com>
References: <5dcd2b1b74b7c46ba4245f96eaf3a4e2f84b37e7.1677039727.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dcd2b1b74b7c46ba4245f96eaf3a4e2f84b37e7.1677039727.git.ryder.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sujuan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.2 next-20230222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sujuan-Chen/wifi-mt76-mt7915-add-dev-hif2-support-for-mt7916-WED-device/20230222-143114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/5dcd2b1b74b7c46ba4245f96eaf3a4e2f84b37e7.1677039727.git.ryder.lee%40mediatek.com
patch subject: [PATCH] wifi: mt76: mt7915: add dev->hif2 support for mt7916 WED device
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230222/202302221620.bpkNoy9N-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b87d9f0ad8413128e108128b7f95e2b90db406cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sujuan-Chen/wifi-mt76-mt7915-add-dev-hif2-support-for-mt7916-WED-device/20230222-143114
        git checkout b87d9f0ad8413128e108128b7f95e2b90db406cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221620.bpkNoy9N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_init_firmware':
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2373:56: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
    2373 |         if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&


vim +2373 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c

  2340	
  2341	int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
  2342	{
  2343		int ret;
  2344	
  2345		/* force firmware operation mode into normal state,
  2346		 * which should be set before firmware download stage.
  2347		 */
  2348		mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
  2349	
  2350		ret = mt7915_driver_own(dev, 0);
  2351		if (ret)
  2352			return ret;
  2353		/* set driver own for band1 when two hif exist */
  2354		if (dev->hif2) {
  2355			ret = mt7915_driver_own(dev, 1);
  2356			if (ret)
  2357				return ret;
  2358		}
  2359	
  2360		ret = mt7915_load_firmware(dev);
  2361		if (ret)
  2362			return ret;
  2363	
  2364		set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
  2365		ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WM, 0);
  2366		if (ret)
  2367			return ret;
  2368	
  2369		ret = mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, 0);
  2370		if (ret)
  2371			return ret;
  2372	
> 2373		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
  2374		    is_mt7915(&dev->mt76) || !mtk_wed_get_rx_capa(&dev->mt76.mmio.wed))
  2375			mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
  2376	
  2377		ret = mt7915_mcu_set_mwds(dev, 1);
  2378		if (ret)
  2379			return ret;
  2380	
  2381		ret = mt7915_mcu_set_muru_ctrl(dev, MURU_SET_PLATFORM_TYPE,
  2382					       MURU_PLATFORM_TYPE_PERF_LEVEL_2);
  2383		if (ret)
  2384			return ret;
  2385	
  2386		ret = mt7915_mcu_init_rx_airtime(dev);
  2387		if (ret)
  2388			return ret;
  2389	
  2390		return mt7915_mcu_set_red(dev, mtk_wed_device_active(&dev->mt76.mmio.wed));
  2391	}
  2392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
