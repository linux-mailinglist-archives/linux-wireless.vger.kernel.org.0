Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6B6D701D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 00:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbjDDW0y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjDDW0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 18:26:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6F2708
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680647211; x=1712183211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ags+nGyHKx682jU/pd7+kOz8QeAabrBU9h+lgji7gvY=;
  b=DXG9auuzF7zJ3jvV/UzI9nbaTFsPJAJog3XwyZLCFz4mwWFBwFU3vzo6
   sonMIqUwUkrlqdW2uZoSRXVw0+yFK/DPwNhu2dkNEjb79tPQGYbebqDhF
   q7aRCWCJKxI2bo4roW+QDJ3a6qkc4kIC5CCbhkxgstUEscTBL0qDwOxNB
   TYJJ04smt9+Ej3zOwTgwS8BLJwKAY8t0ViUTOAV0ogNBUB1gbL4t/m3Fx
   vBK2U4T8ZV7CHRs3AEmUoql388H5KKryN0IXuIBSHexRco+KXfpmzpGz+
   Ab0y+GMzcQPe8Qn+9pZuNdRTA8LocIbEgDApKsjtDymcfYaC/rGS3TDgH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428604973"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428604973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 15:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755805993"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="755805993"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 15:26:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjp72-000Q5E-04;
        Tue, 04 Apr 2023 22:26:48 +0000
Date:   Wed, 5 Apr 2023 06:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH 2/3] wifi: mt76: mt7996: add full system reset knobs into
 debugfs
Message-ID: <202304050649.OGylBZD2-lkp@intel.com>
References: <cb71efc424029e909866e1c86cce712dbf2cc9ef.1680638324.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb71efc424029e909866e1c86cce712dbf2cc9ef.1680638324.git.ryder.lee@mediatek.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ryder,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.3-rc5 next-20230404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryder-Lee/wifi-mt76-mt7996-add-full-system-reset-knobs-into-debugfs/20230405-040602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/cb71efc424029e909866e1c86cce712dbf2cc9ef.1680638324.git.ryder.lee%40mediatek.com
patch subject: [PATCH 2/3] wifi: mt76: mt7996: add full system reset knobs into debugfs
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230405/202304050649.OGylBZD2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8764f35bb4f80294bf2164552514cfd312c5feb3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ryder-Lee/wifi-mt76-mt7996-add-full-system-reset-knobs-into-debugfs/20230405-040602
        git checkout 8764f35bb4f80294bf2164552514cfd312c5feb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/mediatek/mt76/mt7996/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304050649.OGylBZD2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:3742:5: warning: no previous prototype for 'mt7996_mcu_trigger_assert' [-Wmissing-prototypes]
    3742 | int mt7996_mcu_trigger_assert(struct mt7996_dev *dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c: In function 'mt7996_sys_recovery_set':
>> drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c:114:23: error: implicit declaration of function 'mt7996_mcu_trigger_assert'; did you mean 'mt7996_mcu_set_ser'? [-Werror=implicit-function-declaration]
     114 |                 ret = mt7996_mcu_trigger_assert(dev);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                       mt7996_mcu_set_ser
   cc1: some warnings being treated as errors


vim +114 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c

    45	
    46	DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7996_implicit_txbf_get,
    47				 mt7996_implicit_txbf_set, "%lld\n");
    48	
    49	/* test knob of system error recovery */
    50	static ssize_t
    51	mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
    52				size_t count, loff_t *ppos)
    53	{
    54		struct mt7996_phy *phy = file->private_data;
    55		struct mt7996_dev *dev = phy->dev;
    56		bool band = phy->mt76->band_idx;
    57		char buf[16];
    58		int ret = 0;
    59		u16 val;
    60	
    61		if (count >= sizeof(buf))
    62			return -EINVAL;
    63	
    64		if (copy_from_user(buf, user_buf, count))
    65			return -EFAULT;
    66	
    67		if (count && buf[count - 1] == '\n')
    68			buf[count - 1] = '\0';
    69		else
    70			buf[count] = '\0';
    71	
    72		if (kstrtou16(buf, 0, &val))
    73			return -EINVAL;
    74	
    75		switch (val) {
    76		/*
    77		 * 0: grab firmware current SER state.
    78		 * 1: trigger & enable system error L1 recovery.
    79		 * 2: trigger & enable system error L2 recovery.
    80		 * 3: trigger & enable system error L3 rx abort.
    81		 * 4: trigger & enable system error L3 tx abort
    82		 * 5: trigger & enable system error L3 tx disable.
    83		 * 6: trigger & enable system error L3 bf recovery.
    84		 * 7: trigger & enable system error L4 mdp recovery.
    85		 * 8: trigger & enable system error full recovery.
    86		 * 9: trigger firmware crash.
    87		 */
    88		case UNI_CMD_SER_QUERY:
    89			ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_QUERY, 0, band);
    90			break;
    91		case UNI_CMD_SER_SET_RECOVER_L1:
    92		case UNI_CMD_SER_SET_RECOVER_L2:
    93		case UNI_CMD_SER_SET_RECOVER_L3_RX_ABORT:
    94		case UNI_CMD_SER_SET_RECOVER_L3_TX_ABORT:
    95		case UNI_CMD_SER_SET_RECOVER_L3_TX_DISABLE:
    96		case UNI_CMD_SER_SET_RECOVER_L3_BF:
    97		case UNI_CMD_SER_SET_RECOVER_L4_MDP:
    98			ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_SET, BIT(val), band);
    99			if (ret)
   100				return ret;
   101	
   102			ret = mt7996_mcu_set_ser(dev, UNI_CMD_SER_TRIGGER, val, band);
   103			break;
   104	
   105		/* enable full chip reset */
   106		case UNI_CMD_SER_SET_RECOVER_FULL:
   107			mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
   108			dev->recovery.state |= MT_MCU_CMD_WDT_MASK;
   109			mt7996_reset(dev);
   110			break;
   111	
   112		/* WARNING: trigger firmware crash */
   113		case UNI_CMD_SER_SET_SYSTEM_ASSERT:
 > 114			ret = mt7996_mcu_trigger_assert(dev);
   115			if (ret)
   116				return ret;
   117			break;
   118		default:
   119			break;
   120		}
   121	
   122		return ret ? ret : count;
   123	}
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
