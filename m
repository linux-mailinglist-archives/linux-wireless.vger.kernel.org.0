Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC445CD97
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhKXUCO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 15:02:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:7536 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236387AbhKXUCN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 15:02:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="296168193"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="296168193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 11:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="674983695"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 11:59:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpyPz-0005GQ-SZ; Wed, 24 Nov 2021 19:58:59 +0000
Date:   Thu, 25 Nov 2021 03:58:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: introduce SAR support
Message-ID: <202111250358.9Q5qPltH-lkp@intel.com>
References: <ed704f40d9681041d330b1c55dcaf4b10f50c331.1637684612.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed704f40d9681041d330b1c55dcaf4b10f50c331.1637684612.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

I love your patch! Yet something to improve:

[auto build test ERROR on kvalo-wireless-drivers-next/master]
[also build test ERROR on kvalo-wireless-drivers/master v5.16-rc2 next-20211124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/mt76-mt7915-introduce-SAR-support/20211124-002511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111250358.9Q5qPltH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8f018463c8934b4706320982f195e3779ef4b25a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lorenzo-Bianconi/mt76-mt7915-introduce-SAR-support/20211124-002511
        git checkout 8f018463c8934b4706320982f195e3779ef4b25a
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7915/main.c: In function 'mt7915_set_sar_specs':
>> drivers/net/wireless/mediatek/mt76/mt7915/main.c:439:8: error: implicit declaration of function 'mt76_init_sar_power'; did you mean 'mt76_get_txpower'? [-Werror=implicit-function-declaration]
     439 |  err = mt76_init_sar_power(hw, sar);
         |        ^~~~~~~~~~~~~~~~~~~
         |        mt76_get_txpower
   cc1: some warnings being treated as errors
--
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2392:5: warning: no previous prototype for 'mt7915_mcu_set_fixed_rate' [-Wmissing-prototypes]
    2392 | int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c: In function 'mt7915_mcu_set_txpower_sku':
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3859:13: error: implicit declaration of function 'mt76_get_sar_power'; did you mean 'mt76_get_txpower'? [-Werror=implicit-function-declaration]
    3859 |  tx_power = mt76_get_sar_power(mphy, mphy->chandef.chan,
         |             ^~~~~~~~~~~~~~~~~~
         |             mt76_get_txpower
   cc1: some warnings being treated as errors


vim +439 drivers/net/wireless/mediatek/mt76/mt7915/main.c

   427	
   428	static int mt7915_set_sar_specs(struct ieee80211_hw *hw,
   429					const struct cfg80211_sar_specs *sar)
   430	{
   431		struct mt7915_phy *phy = mt7915_hw_phy(hw);
   432		struct mt7915_dev *dev = mt7915_hw_dev(hw);
   433		int err = -EINVAL;
   434	
   435		mutex_lock(&dev->mt76.mutex);
   436		if (!cfg80211_chandef_valid(&phy->mt76->chandef))
   437			goto out;
   438	
 > 439		err = mt76_init_sar_power(hw, sar);
   440		if (err)
   441			goto out;
   442	
   443		err = mt7915_mcu_set_txpower_sku(phy);
   444	out:
   445		mutex_unlock(&dev->mt76.mutex);
   446	
   447		return err;
   448	}
   449	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
