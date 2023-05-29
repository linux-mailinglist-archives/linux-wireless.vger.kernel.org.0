Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246927149EA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjE2NMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE2NML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 09:12:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D89C91
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685365930; x=1716901930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yINEuTUEhppXRJht9CiVr9zhLj0BWl4LWAB2REOQaB8=;
  b=B0J0mgf7pudcMU60rnGvBkN4Bcjr6tIyGA7AngV/fDvhm2g1NXbQe2e7
   P87fZbJ6mVEi/qPdFTnTcQABiUA2Qsxn4rpNwsXQWZHz/qiYundU/tK/5
   uRcTP7pTY+iUTEzmLBAcZ6eNt+e57NM3k5v+ZvaU1Bqk/jVLG4hA1Zu7l
   rC1fnIKxZwu4D7O4dwDltFx5gQgwtHtGH2ZIYpItSYciVKeusRGoNVFQV
   R8OLlYCnZe17VDn7F5gKpfBIynD8TLm6MS/1CoZZ98FJXYTNS2iZmrjSa
   sKzx2eKICoLwjRsDlvl7suyUUmvwTmI11iP+cpXZCuv597uZrpKp2J1ZA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420459049"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="420459049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 06:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="1036219802"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="1036219802"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 May 2023 06:12:07 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3cfP-000L06-14;
        Mon, 29 May 2023 13:12:07 +0000
Date:   Mon, 29 May 2023 21:11:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 13/13] mt76: connac: move more mt7921/mt7915 mac shared
 code in connac lib
Message-ID: <202305292052.VjIsyGIv-lkp@intel.com>
References: <bede71605cbf2d62a1af6474f9fa1e37b302f7bc.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bede71605cbf2d62a1af6474f9fa1e37b302f7bc.1685356673.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on linus/master v6.4-rc4 next-20230525]
[cannot apply to wireless/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/wifi-mt76-mt7921-make-mt7921_mac_sta_poll-static/20230529-184437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/bede71605cbf2d62a1af6474f9fa1e37b302f7bc.1685356673.git.lorenzo%40kernel.org
patch subject: [PATCH 13/13] mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230529/202305292052.VjIsyGIv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9b6f7373c4696853d7051a6dbe8f6ed4236537e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lorenzo-Bianconi/wifi-mt76-mt7921-make-mt7921_mac_sta_poll-static/20230529-184437
        git checkout 9b6f7373c4696853d7051a6dbe8f6ed4236537e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305292052.VjIsyGIv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/mac.c: In function 'mt7921_mac_tx_free':
>> drivers/net/wireless/mediatek/mt76/mt7921/mac.c:578:20: warning: variable 'stat' set but not used [-Wunused-but-set-variable]
     578 |                 u8 stat;
         |                    ^~~~


vim +/stat +578 drivers/net/wireless/mediatek/mt76/mt7921/mac.c

0af1ad955919a7 Lorenzo Bianconi 2022-07-21  554  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  555  static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  556  {
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  557  	struct mt76_connac_tx_free *free = data;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  558  	__le32 *tx_info = (__le32 *)(data + sizeof(*free));
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  559  	struct mt76_dev *mdev = &dev->mt76;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  560  	struct mt76_txwi_cache *txwi;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  561  	struct ieee80211_sta *sta = NULL;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  562  	struct sk_buff *skb, *tmp;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  563  	void *end = data + len;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  564  	LIST_HEAD(free_list);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  565  	bool wake = false;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  566  	u8 i, count;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  567  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  568  	/* clean DMA queues and unmap buffers first */
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  569  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  570  	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  571  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  572  	count = le16_get_bits(free->ctrl, MT_TX_FREE_MSDU_CNT);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  573  	if (WARN_ON_ONCE((void *)&tx_info[count] > end))
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  574  		return;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  575  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  576  	for (i = 0; i < count; i++) {
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  577  		u32 msdu, info = le32_to_cpu(tx_info[i]);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21 @578  		u8 stat;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  579  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  580  		/* 1'b1: new wcid pair.
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  581  		 * 1'b0: msdu_id with the same 'wcid pair' as above.
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  582  		 */
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  583  		if (info & MT_TX_FREE_PAIR) {
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  584  			struct mt7921_sta *msta;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  585  			struct mt76_wcid *wcid;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  586  			u16 idx;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  587  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  588  			count++;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  589  			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  590  			wcid = rcu_dereference(dev->mt76.wcid[idx]);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  591  			sta = wcid_to_sta(wcid);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  592  			if (!sta)
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  593  				continue;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  594  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  595  			msta = container_of(wcid, struct mt7921_sta, wcid);
490de0b91a76e9 Lorenzo Bianconi 2023-05-29  596  			spin_lock_bh(&mdev->sta_poll_lock);
a3b4f9505c59d1 Lorenzo Bianconi 2023-05-29  597  			if (list_empty(&msta->wcid.poll_list))
a3b4f9505c59d1 Lorenzo Bianconi 2023-05-29  598  				list_add_tail(&msta->wcid.poll_list,
490de0b91a76e9 Lorenzo Bianconi 2023-05-29  599  					      &mdev->sta_poll_list);
490de0b91a76e9 Lorenzo Bianconi 2023-05-29  600  			spin_unlock_bh(&mdev->sta_poll_lock);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  601  			continue;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  602  		}
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  603  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  604  		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  605  		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  606  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  607  		txwi = mt76_token_release(mdev, msdu, &wake);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  608  		if (!txwi)
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  609  			continue;
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  610  
9b6f7373c46968 Lorenzo Bianconi 2023-05-29  611  		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  612  	}
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  613  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  614  	if (wake)
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  615  		mt76_set_tx_blocked(&dev->mt76, false);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  616  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  617  	list_for_each_entry_safe(skb, tmp, &free_list, list) {
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  618  		skb_list_del_init(skb);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  619  		napi_consume_skb(skb, 1);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  620  	}
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  621  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  622  	rcu_read_lock();
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  623  	mt7921_mac_sta_poll(dev);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  624  	rcu_read_unlock();
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  625  
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  626  	mt76_worker_schedule(&dev->mt76.tx_worker);
0af1ad955919a7 Lorenzo Bianconi 2022-07-21  627  }
273910ac437523 Lorenzo Bianconi 2021-09-04  628  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
