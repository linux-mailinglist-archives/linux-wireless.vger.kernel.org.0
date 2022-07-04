Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602E565782
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiGDNhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 09:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiGDNgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 09:36:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F64B27D
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656941795; x=1688477795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6b+4cmk4nDahK8tyk8317KXMU1TmTo0grTbzLdOw8s=;
  b=kxSL0bwt+kYOMzi93g2R7D+X2Oh7Q5iNQGPGZPYQywDILOpy7UKU0Ssc
   u6UhdQl1t6+z3nK7YGcnWQFTpGPjJ49jaGcthD1q/XTa3sUqUvefuf6Iu
   moTvXc5g1QLZZO03ngbOEGenIu5onQmzJ7aYYQp6P70SBYIlqb4GHaJPj
   YImbh5jPbdV6oS6uLU4UPuTHoXpXKqHzXrOPXdlFyWDF7Xnk0VWvyuvvY
   W9soMZRwo9e4dKGtEa6+ESup09YQ8MVAY7C/IwYcycQmv1yfbAMnHgXqo
   ETRTHk+vhTRtXS2mFOpPE5n6QZlJUjouCpZeLjoR+5MPbTM0j4BUXGjJa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="369455836"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="369455836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 06:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="567230943"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2022 06:36:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8MFc-000Hut-Li;
        Mon, 04 Jul 2022 13:36:32 +0000
Date:   Mon, 4 Jul 2022 21:35:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] mt76: remove q->qid
Message-ID: <202207042158.O7hTDMKY-lkp@intel.com>
References: <20220704074336.28043-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704074336.28043-1-nbd@nbd.name>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v5.19-rc5 next-20220704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/mt76-remove-q-qid/20220704-154431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207042158.O7hTDMKY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7cef83a2b5a0f3c5ca3612e34ca2649ac9cf75f4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Felix-Fietkau/mt76-remove-q-qid/20220704-154431
        git checkout 7cef83a2b5a0f3c5ca3612e34ca2649ac9cf75f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/usb.c: In function 'mt76u_tx_queue_skb':
>> drivers/net/wireless/mediatek/mt76/usb.c:861:52: error: 'struct mt76_queue' has no member named 'qid'
     861 |         err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
         |                                                    ^~
--
   drivers/net/wireless/mediatek/mt76/sdio.c: In function 'mt76s_tx_queue_skb':
>> drivers/net/wireless/mediatek/mt76/sdio.c:531:52: error: 'struct mt76_queue' has no member named 'qid'
     531 |         err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
         |                                                    ^~
--
   drivers/net/wireless/mediatek/mt76/dma.c: In function 'mt76_dma_tx_queue_skb':
>> drivers/net/wireless/mediatek/mt76/dma.c:409:52: error: 'struct mt76_queue' has no member named 'qid'
     409 |         ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
         |                                                    ^~


vim +861 drivers/net/wireless/mediatek/mt76/usb.c

b40b15e1521f77 Lorenzo Bianconi 2018-07-31  845  
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  846  static int
8987059475f503 Lorenzo Bianconi 2020-11-11  847  mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  848  		   struct sk_buff *skb, struct mt76_wcid *wcid,
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  849  		   struct ieee80211_sta *sta)
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  850  {
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  851  	struct mt76_tx_info tx_info = {
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  852  		.skb = skb,
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  853  	};
95f61e17eff3d9 Felix Fietkau    2020-08-23  854  	u16 idx = q->head;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  855  	int err;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  856  
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  857  	if (q->queued == q->ndesc)
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  858  		return -ENOSPC;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  859  
88046b2c9f6d8b Felix Fietkau    2018-10-25  860  	skb->prev = skb->next = NULL;
8987059475f503 Lorenzo Bianconi 2020-11-11 @861  	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  862  	if (err < 0)
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  863  		return err;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  864  
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  865  	err = mt76u_tx_setup_buffers(dev, tx_info.skb, q->entry[idx].urb);
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  866  	if (err < 0)
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  867  		return err;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  868  
4de92bf10c6df6 Lorenzo Bianconi 2019-02-20  869  	mt76u_fill_bulk_urb(dev, USB_DIR_OUT, q2ep(q->hw_idx),
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  870  			    q->entry[idx].urb, mt76u_complete_tx,
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  871  			    &q->entry[idx]);
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  872  
95f61e17eff3d9 Felix Fietkau    2020-08-23  873  	q->head = (q->head + 1) % q->ndesc;
cfaae9e67cf130 Lorenzo Bianconi 2019-04-02  874  	q->entry[idx].skb = tx_info.skb;
6d51cae28c8de9 Felix Fietkau    2021-05-09  875  	q->entry[idx].wcid = 0xffff;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  876  	q->queued++;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  877  
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  878  	return idx;
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  879  }
b40b15e1521f77 Lorenzo Bianconi 2018-07-31  880  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
