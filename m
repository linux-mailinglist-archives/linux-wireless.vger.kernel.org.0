Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2396DCD3E
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDJWDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDJWDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 18:03:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22501BCA
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681164226; x=1712700226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4W4Pk2ES5/ySuHySu5gOKD4o31qkgpk+oubIxxD38hs=;
  b=f8mJOZ29MqKYIBtZ87zVSoHayXJcCSBMWOs5tPqE5eejG2Vxw0LrFFmE
   b+RrPXBaezxyJKCodG2ZM3bIR4p7EBTzYztNyzDtBuTECoFF+Qgxh8wFd
   +fjGxwX5EFpEAYog5tFW5ZZjVT+BQWe3yDjlWaxi24geBkw8KUOqvO9Ue
   JQf9QoSgh+JLOx8larCSa7SWEkyFKAcnXdGYGrLn3Glx6f5xppJq8mmm5
   S8X1IK3SlQPde9+KdDgh3TyLJopBNiE+xejbLndpcS2dhEKQGGePCsMTW
   4/K6wcO+MWEHaHtSjGxSxtpDvyYMl2cHa1TDt4uEWCrjKMV7bvKl50kM1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371307978"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="371307978"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 15:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="681854260"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="681854260"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Apr 2023 15:03:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plzbv-000Vgj-1i;
        Mon, 10 Apr 2023 22:03:39 +0000
Date:   Tue, 11 Apr 2023 06:03:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, sean.wang@mediatek.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, arowa@google.org,
        frankgor@google.com, kuabhs@google.com, druth@google.com,
        abhishekpandit@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: fix kernel panic by accessing unallocated
 eeprom.data
Message-ID: <202304110556.xbu5H3ka-lkp@intel.com>
References: <c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.3-rc6 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-mediatek-com/mt76-mt7921-fix-kernel-panic-by-accessing-unallocated-eeprom-data/20230411-043801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf%40gmail.com
patch subject: [PATCH] mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230411/202304110556.xbu5H3ka-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9825ad75cf770d2a15f7008eca476121b9b3d794
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review sean-wang-mediatek-com/mt76-mt7921-fix-kernel-panic-by-accessing-unallocated-eeprom-data/20230411-043801
        git checkout 9825ad75cf770d2a15f7008eca476121b9b3d794
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304110556.xbu5H3ka-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c: In function 'mt7921_mcu_parse_eeprom':
>> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:22:40: warning: variable 'res' set but not used [-Wunused-but-set-variable]
      22 |         struct mt7921_mcu_eeprom_info *res;
         |                                        ^~~


vim +/res +22 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c

23bdc5d8cadfc9 Ming Yen Hsieh   2022-09-07  18  
1c099ab44727c8 Sean Wang        2021-01-28  19  static int
1c099ab44727c8 Sean Wang        2021-01-28  20  mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
1c099ab44727c8 Sean Wang        2021-01-28  21  {
1c099ab44727c8 Sean Wang        2021-01-28 @22  	struct mt7921_mcu_eeprom_info *res;
1c099ab44727c8 Sean Wang        2021-01-28  23  
1c099ab44727c8 Sean Wang        2021-01-28  24  	if (!skb)
1c099ab44727c8 Sean Wang        2021-01-28  25  		return -EINVAL;
1c099ab44727c8 Sean Wang        2021-01-28  26  
fc6ee71a2a8f2d Lorenzo Bianconi 2022-06-20  27  	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
1c099ab44727c8 Sean Wang        2021-01-28  28  
1c099ab44727c8 Sean Wang        2021-01-28  29  	res = (struct mt7921_mcu_eeprom_info *)skb->data;
1c099ab44727c8 Sean Wang        2021-01-28  30  
1c099ab44727c8 Sean Wang        2021-01-28  31  	return 0;
1c099ab44727c8 Sean Wang        2021-01-28  32  }
1c099ab44727c8 Sean Wang        2021-01-28  33  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
