Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9B52422D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 03:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiELBkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiELBkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 21:40:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B761C0F1D
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652319604; x=1683855604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVYaXrAAHMYyaHbYg9lV4pghViddmRt0tii19dfk9ZU=;
  b=NJ6YGuk5xLYcouyOhiY5zeRyWEYJHUbbTc4ufKfJDI7n7hojs4L0IzgT
   9rV94D75BTxPjV+AXdaGhoZTKlS5tBdUz4buEMvDQAYU/04GKL0S9a5sR
   50TAuTyAG02hi1EeYyF22HLGhg/TdsKd/CSXhcs47NwFX/H70y7pDiYRR
   pTW3Jg6YJzkM+iEdYFhMjYFbyB5pz8+t6mKN9Q4pFi6NKZHpVZ+R01vex
   DcV/qoktK9hZAKO6DNOCYhmOLc77xGKYshBr+y4U1msfgX+lTgnqHXHJM
   DUc6jdh5q59eQsByO44dheIreajcZc/z+y4xdVt6PW5JsHauK8RYy58sm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268693802"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="268693802"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 18:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="520749072"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2022 18:40:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noxo9-000Jo0-8B;
        Thu, 12 May 2022 01:40:01 +0000
Date:   Thu, 12 May 2022 09:39:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:mld 9/9]
 drivers/net/wireless/rsi/rsi_91x_mac80211.c:1865:29: warning: variable 'bss'
 set but not used
Message-ID: <202205120932.HujSW47D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   ca62bbbb01a04d8d9750b2b3ac0b61f57c037abe
commit: ca62bbbb01a04d8d9750b2b3ac0b61f57c037abe [9/9] mac80211: move interface config to new struct
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220512/202205120932.HujSW47D-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=ca62bbbb01a04d8d9750b2b3ac0b61f57c037abe
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next mld
        git checkout ca62bbbb01a04d8d9750b2b3ac0b61f57c037abe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/ath/ath10k/ drivers/net/wireless/rsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/rsi/rsi_91x_mac80211.c:1865:29: warning: variable 'bss' set but not used [-Wunused-but-set-variable]
           struct ieee80211_bss_conf *bss = NULL;
                                      ^
   1 warning generated.
--
>> drivers/net/wireless/ath/ath10k/mac.c:1828:29: warning: unused variable 'info' [-Wunused-variable]
           struct ieee80211_bss_conf *info = &vif->bss_conf;
                                      ^
>> drivers/net/wireless/ath/ath10k/mac.c:1829:12: warning: unused variable 'self_peer' [-Wunused-variable]
           const u8 *self_peer = vif->addr;
                     ^
   drivers/net/wireless/ath/ath10k/mac.c:5983:22: warning: parameter 'changed_flags' set but not used [-Wunused-but-set-parameter]
                                       unsigned int changed_flags,
                                                    ^
   3 warnings generated.


vim +/bss +1865 drivers/net/wireless/rsi/rsi_91x_mac80211.c

f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1858  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1859  int rsi_config_wowlan(struct rsi_hw *adapter, struct cfg80211_wowlan *wowlan)
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1860  {
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1861  	struct rsi_common *common = adapter->priv;
ca62bbbb01a04d Johannes Berg        2022-05-10  1862  	struct ieee80211_vif *vif = adapter->vifs[0];
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1863  	u16 triggers = 0;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1864  	u16 rx_filter_word = 0;
54b5172087aeae Sanjay Kumar Konduri 2018-05-11 @1865  	struct ieee80211_bss_conf *bss = NULL;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1866  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1867  	rsi_dbg(INFO_ZONE, "Config WoWLAN to device\n");
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1868  
ca62bbbb01a04d Johannes Berg        2022-05-10  1869  	if (!vif)
54b5172087aeae Sanjay Kumar Konduri 2018-05-11  1870  		return -EINVAL;
54b5172087aeae Sanjay Kumar Konduri 2018-05-11  1871  
ca62bbbb01a04d Johannes Berg        2022-05-10  1872  	bss = &vif->bss_conf;
54b5172087aeae Sanjay Kumar Konduri 2018-05-11  1873  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1874  	if (WARN_ON(!wowlan)) {
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1875  		rsi_dbg(ERR_ZONE, "WoW triggers not enabled\n");
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1876  		return -EINVAL;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1877  	}
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1878  
1d18c5584c05bb Siva Rebbagondla     2018-05-11  1879  	common->wow_flags |= RSI_WOW_ENABLED;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1880  	triggers = rsi_wow_map_triggers(common, wowlan);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1881  	if (!triggers) {
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1882  		rsi_dbg(ERR_ZONE, "%s:No valid WoW triggers\n", __func__);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1883  		return -EINVAL;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1884  	}
ca62bbbb01a04d Johannes Berg        2022-05-10  1885  	if (!vif->cfg.assoc) {
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1886  		rsi_dbg(ERR_ZONE,
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1887  			"Cannot configure WoWLAN (Station not connected)\n");
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1888  		common->wow_flags |= RSI_WOW_NO_CONNECTION;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1889  		return 0;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1890  	}
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1891  	rsi_dbg(INFO_ZONE, "TRIGGERS %x\n", triggers);
38ef8d9016da9d Siva Rebbagondla     2019-02-04  1892  
38ef8d9016da9d Siva Rebbagondla     2019-02-04  1893  	if (common->coex_mode > 1)
38ef8d9016da9d Siva Rebbagondla     2019-02-04  1894  		rsi_disable_ps(adapter, adapter->vifs[0]);
38ef8d9016da9d Siva Rebbagondla     2019-02-04  1895  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1896  	rsi_send_wowlan_request(common, triggers, 1);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1897  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1898  	/**
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1899  	 * Increase the beacon_miss threshold & keep-alive timers in
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1900  	 * vap_update frame
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1901  	 */
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1902  	rsi_send_vap_dynamic_update(common);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1903  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1904  	rx_filter_word = (ALLOW_DATA_ASSOC_PEER | DISALLOW_BEACONS);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1905  	rsi_send_rx_filter_frame(common, rx_filter_word);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1906  
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1907  	return 0;
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1908  }
063848c3e1558e Karun Eagalapati     2017-10-27  1909  EXPORT_SYMBOL(rsi_config_wowlan);
f3ac4e7394a1aa Karun Eagalapati     2017-10-27  1910  

:::::: The code at line 1865 was first introduced by commit
:::::: 54b5172087aeae61150835c91e68f084a9644f1c rsi: Add null check for virtual interfaces in wowlan config

:::::: TO: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
