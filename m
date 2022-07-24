Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3857F725
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jul 2022 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiGXVRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jul 2022 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGXVRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jul 2022 17:17:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDD10FC0
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658697449; x=1690233449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slVzZ4lTxH/9XymiBgNHyxCLis6oKGDr4b8+06cytac=;
  b=kKErWRpXehf5xQjMyVBnaWshUB25YZaUCQxcek/QmdLQfN+f2UmamVXn
   isTAAfMRO8hsQscV8k3JrDeBOMJNr+3DV0d+Z0RZQtHaYpRDJO+7gUKTv
   AcKOEcfrKOEQPq6gqpmx5AFCVIT/ZLZvVsN2X18IbspnhTovSPYMf2EqV
   mnrZBhGPQHEX8P5iGkKIm8ZzZNFdq5HHT8i94q7nx9c2eoeHQLGmPdea0
   mqPK7GfOajmYL5E5y8A7NjFHHnGZDF9mOijOeyAUUvaiUeT9m+NnkOQBW
   KQSAXfCwOfD8g0uP3QScEordz6XVHNZHMIKwZmL5k26EJyxiuHDi/tGAE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274432526"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="274432526"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 14:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="549757433"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2022 14:17:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFiyc-0004IX-12;
        Sun, 24 Jul 2022 21:17:26 +0000
Date:   Mon, 25 Jul 2022 05:16:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: sdio: add rx_check callback for sdio devices
Message-ID: <202207250528.8cxL1kpm-lkp@intel.com>
References: <2902205ffea3f07349db8c1466e81a8a5f24dc86.1658474979.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2902205ffea3f07349db8c1466e81a8a5f24dc86.1658474979.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on linus/master v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/mt76-sdio-add-rx_check-callback-for-sdio-devices/20220722-153400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220725/202207250528.8cxL1kpm-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/202e740929b81d6752f7f4586d5383c252ed8057
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lorenzo-Bianconi/mt76-sdio-add-rx_check-callback-for-sdio-devices/20220722-153400
        git checkout 202e740929b81d6752f7f4586d5383c252ed8057
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/amd/display/amdgpu_dm/ drivers/net/wireless/mediatek/mt76/mt7921/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c: In function 'mt7921s_probe':
>> drivers/net/wireless/mediatek/mt76/mt7921/sdio.c:99:29: error: 'mt7921_rx_check' undeclared (first use in this function); did you mean 'mt7921e_rx_check'?
      99 |                 .rx_check = mt7921_rx_check,
         |                             ^~~~~~~~~~~~~~~
         |                             mt7921e_rx_check
   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c:99:29: note: each undeclared identifier is reported only once for each function it appears in


vim +99 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c

    86	
    87	static int mt7921s_probe(struct sdio_func *func,
    88				 const struct sdio_device_id *id)
    89	{
    90		static const struct mt76_driver_ops drv_ops = {
    91			.txwi_size = MT_SDIO_TXD_SIZE,
    92			.survey_flags = SURVEY_INFO_TIME_TX |
    93					SURVEY_INFO_TIME_RX |
    94					SURVEY_INFO_TIME_BSS_RX,
    95			.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
    96			.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
    97			.tx_status_data = mt7921_usb_sdio_tx_status_data,
    98			.rx_skb = mt7921_queue_rx_skb,
  > 99			.rx_check = mt7921_rx_check,
   100			.sta_ps = mt7921_sta_ps,
   101			.sta_add = mt7921_mac_sta_add,
   102			.sta_assoc = mt7921_mac_sta_assoc,
   103			.sta_remove = mt7921_mac_sta_remove,
   104			.update_survey = mt7921_update_channel,
   105		};
   106		static const struct mt76_bus_ops mt7921s_ops = {
   107			.rr = mt76s_rr,
   108			.rmw = mt76s_rmw,
   109			.wr = mt76s_wr,
   110			.write_copy = mt76s_write_copy,
   111			.read_copy = mt76s_read_copy,
   112			.wr_rp = mt76s_wr_rp,
   113			.rd_rp = mt76s_rd_rp,
   114			.type = MT76_BUS_SDIO,
   115		};
   116		static const struct mt7921_hif_ops mt7921_sdio_ops = {
   117			.init_reset = mt7921s_init_reset,
   118			.reset = mt7921s_mac_reset,
   119			.mcu_init = mt7921s_mcu_init,
   120			.drv_own = mt7921s_mcu_drv_pmctrl,
   121			.fw_own = mt7921s_mcu_fw_pmctrl,
   122		};
   123	
   124		struct mt7921_dev *dev;
   125		struct mt76_dev *mdev;
   126		int ret;
   127	
   128		mdev = mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
   129					 &drv_ops);
   130		if (!mdev)
   131			return -ENOMEM;
   132	
   133		dev = container_of(mdev, struct mt7921_dev, mt76);
   134		dev->hif_ops = &mt7921_sdio_ops;
   135	
   136		sdio_set_drvdata(func, dev);
   137	
   138		ret = mt76s_init(mdev, func, &mt7921s_ops);
   139		if (ret < 0)
   140			goto error;
   141	
   142		ret = mt76s_hw_init(mdev, func, MT76_CONNAC2_SDIO);
   143		if (ret)
   144			goto error;
   145	
   146		mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
   147			    (mt76_rr(dev, MT_HW_REV) & 0xff);
   148		dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
   149	
   150		mdev->sdio.parse_irq = mt7921s_parse_intr;
   151		mdev->sdio.intr_data = devm_kmalloc(mdev->dev,
   152						    sizeof(struct mt7921_sdio_intr),
   153						    GFP_KERNEL);
   154		if (!mdev->sdio.intr_data) {
   155			ret = -ENOMEM;
   156			goto error;
   157		}
   158	
   159		ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
   160		if (ret)
   161			goto error;
   162	
   163		ret = mt76s_alloc_rx_queue(mdev, MT_RXQ_MCU);
   164		if (ret)
   165			goto error;
   166	
   167		ret = mt76s_alloc_tx(mdev);
   168		if (ret)
   169			goto error;
   170	
   171		ret = mt76_worker_setup(mt76_hw(dev), &mdev->sdio.txrx_worker,
   172					mt7921s_txrx_worker, "sdio-txrx");
   173		if (ret)
   174			goto error;
   175	
   176		sched_set_fifo_low(mdev->sdio.txrx_worker.task);
   177	
   178		ret = mt7921_register_device(dev);
   179		if (ret)
   180			goto error;
   181	
   182		return 0;
   183	
   184	error:
   185		mt76s_deinit(&dev->mt76);
   186		mt76_free_device(&dev->mt76);
   187	
   188		return ret;
   189	}
   190	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
