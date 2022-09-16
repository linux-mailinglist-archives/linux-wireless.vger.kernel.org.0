Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0775BB2ED
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIPTmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiIPTmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 15:42:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED199B14E8
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663357343; x=1694893343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zt7Jubm60tCWy/mnWh0gWMiuVSSQkR9yoOZigwu8hCg=;
  b=hrfFe5agsVe1IKxqHPXhefRMtWNhtOz9+0wn/01p8PiAUUtFsB9yAwAo
   E2U3KSsobgC9b1l3nrO3ACToYR89sAXyhlZHzOcrt/VQcLeNu/bCII2S9
   Vt2JM+5F/RNStm2vFx7pX6EXXu7LpcHKQyjt5nP/3O/kRARHRXrlsss+l
   k1YCmtUi9pgYPz/xwcQ7UU467/wW96UshIAKyDyAFBRQ0po7Mql/NOyro
   UnUe+gPGGV/DZ8dEiT5PlCCjd4RwHZOUxdJn029YNy3hPvcrZaNU2D1h5
   SFAhc4IqsL9lJda9OBUu+e0mFykMadhI4thr5w1cfekKpYzb0B3sofGZr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325342820"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="325342820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 12:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="595363880"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 12:42:20 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZHEB-00026E-2B;
        Fri, 16 Sep 2022 19:42:19 +0000
Date:   Sat, 17 Sep 2022 03:41:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jun Yu <junyuu@chromium.org>, ath11k@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Jun Yu <junyuu@chromium.org>
Subject: Re: [PATCH] wifi: ath11k: retrieve MAC address from system firmware
 if provided
Message-ID: <202209170307.720C1Sx4-lkp@intel.com>
References: <20220914215408.372520-1-junyuu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914215408.372520-1-junyuu@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kvalo-ath/ath-next]
[also build test ERROR on wireless/main wireless-next/main linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Yu/wifi-ath11k-retrieve-MAC-address-from-system-firmware-if-provided/20220915-055714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220917/202209170307.720C1Sx4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7a1539aed9ed31bd3b93c177abda0a2f4fea3945
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jun-Yu/wifi-ath11k-retrieve-MAC-address-from-system-firmware-if-provided/20220915-055714
        git checkout 7a1539aed9ed31bd3b93c177abda0a2f4fea3945
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_register':
>> drivers/net/wireless/ath/ath11k/mac.c:8999:9: error: too many arguments to function 'device_get_mac_address'
    8999 |         device_get_mac_address(ab->dev, mac_addr, sizeof(ab->mac_addr));
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ieee80211.h:20,
                    from include/net/mac80211.h:20,
                    from drivers/net/wireless/ath/ath11k/mac.c:7:
   include/linux/etherdevice.h:35:5: note: declared here
      35 | int device_get_mac_address(struct device *dev, char *addr);
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/device_get_mac_address +8999 drivers/net/wireless/ath/ath11k/mac.c

  8979	
  8980	int ath11k_mac_register(struct ath11k_base *ab)
  8981	{
  8982		struct ath11k *ar;
  8983		struct ath11k_pdev *pdev;
  8984		int i;
  8985		int ret;
  8986		u8 mac_addr[ETH_ALEN] = {0};
  8987	
  8988		if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
  8989			return 0;
  8990	
  8991		/* Initialize channel counters frequency value in hertz */
  8992		ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
  8993		ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
  8994	
  8995		ret = ath11k_peer_rhash_tbl_init(ab);
  8996		if (ret)
  8997			return ret;
  8998	
> 8999		device_get_mac_address(ab->dev, mac_addr, sizeof(ab->mac_addr));
  9000	
  9001		for (i = 0; i < ab->num_radios; i++) {
  9002			pdev = &ab->pdevs[i];
  9003			ar = pdev->ar;
  9004			if (ab->pdevs_macaddr_valid) {
  9005				ether_addr_copy(ar->mac_addr, pdev->mac_addr);
  9006			} else {
  9007				if (is_zero_ether_addr(mac_addr))
  9008					ether_addr_copy(ar->mac_addr, ab->mac_addr);
  9009				else
  9010					ether_addr_copy(ar->mac_addr, mac_addr);
  9011				ar->mac_addr[4] += i;
  9012			}
  9013	
  9014			idr_init(&ar->txmgmt_idr);
  9015			spin_lock_init(&ar->txmgmt_idr_lock);
  9016	
  9017			ret = __ath11k_mac_register(ar);
  9018			if (ret)
  9019				goto err_cleanup;
  9020	
  9021			init_waitqueue_head(&ar->txmgmt_empty_waitq);
  9022		}
  9023	
  9024		return 0;
  9025	
  9026	err_cleanup:
  9027		for (i = i - 1; i >= 0; i--) {
  9028			pdev = &ab->pdevs[i];
  9029			ar = pdev->ar;
  9030			__ath11k_mac_unregister(ar);
  9031		}
  9032	
  9033		ath11k_peer_rhash_tbl_destroy(ab);
  9034	
  9035		return ret;
  9036	}
  9037	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
