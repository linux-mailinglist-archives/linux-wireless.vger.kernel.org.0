Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331B14D7601
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 16:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiCMPIL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPIK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 11:08:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F65158E4E
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647184022; x=1678720022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmvI+t9c7JC+R20YEUrxGV58zTdAMt/4tplAzgcpDE8=;
  b=ZMP76/rFJdJbUA4JRlNG9NePuXnYYY0xEvOOKErScN2AfRjwGjfleyG3
   yUqN+9P+WIRfqfxlFJ7pZW1vDezePWrOruqH1MRnIwz7tQNtQlv9lJMdy
   XLE3bKaPD2YCcV9R3/f/2tDjPpmFCC1SAaAWlf7GnLzJVu4FRwl8312Vj
   JjT4ydRuvNT94apvUufokXPK6d/mYq9p4fHm5fimxqoeWhhPRQBDvMzc8
   vWVwxz05CH4U0raXLp57n9ayS52q2RAJNhGpEKNBqCAXtB7viz7ehVmjP
   u7EZcij+/zbKx1VJ1d8/m1yjqPva5ZktUF853AFVQ6pMjDJb1r+uFULpT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342302635"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="342302635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713437404"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 08:06:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPoA-00093C-Ix; Sun, 13 Mar 2022 15:06:58 +0000
Date:   Sun, 13 Mar 2022 23:06:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        deren.wu@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 9/9] mt76: mt7921: add mt7921u driver
Message-ID: <202203132225.CbMappWu-lkp@intel.com>
References: <af6cc4770cfed30a3baba5897c737008e0584719.1647175554.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6cc4770cfed30a3baba5897c737008e0584719.1647175554.git.lorenzo@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20220310]
[cannot apply to wireless/main v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/introduce-mt7921u-driver/20220313-205210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220313/202203132225.CbMappWu-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/63a67380659a7ab972a09206bc2b581fdb6766b6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lorenzo-Bianconi/introduce-mt7921u-driver/20220313-205210
        git checkout 63a67380659a7ab972a09206bc2b581fdb6766b6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c: In function 'mt7921u_mac_reset':
>> drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c:224:8: error: too many arguments to function 'mt7921u_dma_init'
     224 |  err = mt7921u_dma_init(dev, false);
         |        ^~~~~~~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c:124:5: note: declared here
     124 | int mt7921u_dma_init(struct mt7921_dev *dev)
         |     ^~~~~~~~~~~~~~~~


vim +/mt7921u_dma_init +224 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c

   196	
   197	int mt7921u_mac_reset(struct mt7921_dev *dev)
   198	{
   199		int err;
   200	
   201		mt76_txq_schedule_all(&dev->mphy);
   202		mt76_worker_disable(&dev->mt76.tx_worker);
   203	
   204		set_bit(MT76_RESET, &dev->mphy.state);
   205		set_bit(MT76_MCU_RESET, &dev->mphy.state);
   206	
   207		wake_up(&dev->mt76.mcu.wait);
   208		mt7921_mcu_exit(dev);
   209	
   210		mt76u_stop_rx(&dev->mt76);
   211		mt76u_stop_tx(&dev->mt76);
   212	
   213		mt7921u_wfsys_reset(dev);
   214	
   215		clear_bit(MT76_MCU_RESET, &dev->mphy.state);
   216		err = mt76u_resume_rx(&dev->mt76);
   217		if (err)
   218			goto out;
   219	
   220		err = mt7921u_mcu_power_on(dev);
   221		if (err)
   222			goto out;
   223	
 > 224		err = mt7921u_dma_init(dev, false);

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
