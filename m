Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9545E838
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 08:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359164AbhKZHLX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 02:11:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:50230 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhKZHJT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 02:09:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216329849"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="216329849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 23:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="475825212"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 23:05:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqVIL-0007ja-LQ; Fri, 26 Nov 2021 07:05:17 +0000
Date:   Fri, 26 Nov 2021 15:04:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH] mt76: mt7915: update station's airtime and gi from event
Message-ID: <202111261430.O1AAGfiL-lkp@intel.com>
References: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi MeiChia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvalo-wireless-drivers-next/master]
[also build test WARNING on kvalo-wireless-drivers/master v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/MeiChia-Chiu/mt76-mt7915-update-station-s-airtime-and-gi-from-event/20211125-171608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111261430.O1AAGfiL-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/446d4941b6395463c374c2281241769ca0abaad9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review MeiChia-Chiu/mt76-mt7915-update-station-s-airtime-and-gi-from-event/20211125-171608
        git checkout 446d4941b6395463c374c2281241769ca0abaad9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/mediatek/mt76/mt7915/main.c:9:
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:234:1: warning: no semicolon at end of struct or union
     234 | };
         | ^
--
   In file included from drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:7:
>> drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:234:1: warning: no semicolon at end of struct or union
     234 | };
         | ^
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:2516:5: warning: no previous prototype for 'mt7915_mcu_set_fixed_rate' [-Wmissing-prototypes]
    2516 | int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +234 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h

   217	
   218	struct mt7915_mcu_sta_stat {
   219		u8 event_id;
   220		u8 more_event;
   221		__le16 sta_num;
   222		union {
   223			struct {
   224				__le16 wlan_id;
   225				__le32 tx_time[4];
   226				__le32 rx_time[4];
   227			} airtime[0];
   228			struct {
   229				__le16 wlan_id;
   230				u8 gimode;
   231				u8 rsv;
   232			} gi[0];
   233		}
 > 234	};
   235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
