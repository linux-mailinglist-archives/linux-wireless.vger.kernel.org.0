Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657F76CADF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjHBKbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjHBKb0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 06:31:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8066EB5
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690972035; x=1722508035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RljGlw3peibrHMvrvL9Zo+t3sqqwY5SPLptaScys/SA=;
  b=gXf5T5ZicMmO0bclhmZdI/xLZo9mLIZWD9t8L7duCICEUCPN1RmRc51M
   w2J+1fqOkexzqhmHJnw9zdGRIqxlca8RYKQOyT7flOxBmQ+QJU8KVa/8w
   8uMgoUNa7A5bZNri8qytsigCbAZjUbDvqztDl/AxBfopeijHHLDjhSAOV
   oqnnUXU5OmtG4FnBbb1jufv3+RLFw5ecqZDymD26Jat/0og4GbJbRgw8o
   uIIi6+lagUXSYpIYhUVR0I8Ki/xuDDU/qwjlN3UNKZCCmgjT77tOc0QkN
   jesV8j11wdZZkl/4FFHvJIpCpHpwaaoIrT7p5wl57xYdBYrxrNH2HzPn/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400492143"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="400492143"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764171284"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="764171284"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 03:26:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR93g-00017f-1c;
        Wed, 02 Aug 2023 10:26:24 +0000
Date:   Wed, 2 Aug 2023 18:25:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: Re: [PATCH 17/17] wifi: mt76: add mt7925 to Kconfig
Message-ID: <202308021841.dVQEY7mc-lkp@intel.com>
References: <12bafb6334728c3c12cdd8ab3e7505a963d4356d.1690864199.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12bafb6334728c3c12cdd8ab3e7505a963d4356d.1690864199.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Deren,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.5-rc4 next-20230802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Deren-Wu/wifi-mt76-mt7925-add-Kconfig/20230801-223655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/12bafb6334728c3c12cdd8ab3e7505a963d4356d.1690864199.git.deren.wu%40mediatek.com
patch subject: [PATCH 17/17] wifi: mt76: add mt7925 to Kconfig
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230802/202308021841.dVQEY7mc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308021841.dVQEY7mc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308021841.dVQEY7mc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/mediatek/mt76/mt7925/mac.c:7:
>> drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h:7:10: fatal error: ../mt792x.h: No such file or directory
       7 | #include "../mt792x.h"
         |          ^~~~~~~~~~~~~
   compilation terminated.


vim +7 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h

d5f8016ffd8fd01 Deren Wu 2023-08-01  6  
d5f8016ffd8fd01 Deren Wu 2023-08-01 @7  #include "../mt792x.h"
d5f8016ffd8fd01 Deren Wu 2023-08-01  8  #include "regs.h"
d5f8016ffd8fd01 Deren Wu 2023-08-01  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
