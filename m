Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E79520677
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiEIVLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiEIVKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 17:10:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477B2764CE
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652130420; x=1683666420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VKvqRsEht8WO9u19u7rR3KhtPWXPpAb/houKG04Ee2k=;
  b=bSgIwYWer5xAQl61yfW2QH7YESKA+D3Wab7qdTiQtHayRDZy1FEQ0jZi
   gL0BTNiAJkrqiJgA1710mXRJkYebylEV7idWhz6AaUNT8xOXOTq1ZkUIC
   RilX0fFQJGivXdTku6RBbjIXboqlrfefg2DZwCDd9eVnViZSMxo/mVGZs
   ivUhVmrBsgk4Nlpp5VY32zdavk3SVaV53tJHM3bDE0O3FMN7bfMGfDwOh
   cQiXh197ltOjdH7/Ozhcl2rM2mOGM5Sp5ymueh9fSLPWb9k8Wc1QASicf
   2kpjyLQ6wjJX/juge333/mr4Irmbc4RkKBt48ym8iSnVQnYbaitfT1EPb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249072473"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="249072473"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="710709223"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2022 14:06:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noAan-000Guq-QT;
        Mon, 09 May 2022 21:06:57 +0000
Date:   Tue, 10 May 2022 05:05:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>, johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: Re: [PATCH v3 1/2] nl80211: process additional attributes in
 NL80211_CMD_SET_BEACON
Message-ID: <202205100426.MpSAZv4b-lkp@intel.com>
References: <20220509173354.2482-2-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509173354.2482-2-quic_alokad@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aloka,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on fc20106d6e2086dd37bf286605c28b28b4f2492c]

url:    https://github.com/intel-lab-lkp/linux/commits/Aloka-Dixit/Additional-processing-in-NL80211_CMD_SET_BEACON/20220510-013948
base:   fc20106d6e2086dd37bf286605c28b28b4f2492c
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220510/202205100426.MpSAZv4b-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3abb68a626160e019c30a4860e569d7bc75e486a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/4b2583148641664d3a44d750efff98707ea07b23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aloka-Dixit/Additional-processing-in-NL80211_CMD_SET_BEACON/20220510-013948
        git checkout 4b2583148641664d3a44d750efff98707ea07b23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/broadcom/brcm80211/brcmfmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:5577:19: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_ap_settings *)' with an expression of type 's32 (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)' (aka 'int (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)') [-Werror,-Wincompatible-function-pointer-types]
           .change_beacon = brcmf_cfg80211_change_beacon,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +5577 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

2526ff21aa77c2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Arend van Spriel 2017-06-09  5549  
5c22fb85102a75 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Hante Meuleman   2016-02-17  5550  static struct cfg80211_ops brcmf_cfg80211_ops = {
9f440b7bc78688 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2013-02-08  5551  	.add_virtual_intf = brcmf_cfg80211_add_iface,
9f440b7bc78688 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2013-02-08  5552  	.del_virtual_intf = brcmf_cfg80211_del_iface,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5553  	.change_virtual_intf = brcmf_cfg80211_change_iface,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5554  	.scan = brcmf_cfg80211_scan,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5555  	.set_wiphy_params = brcmf_cfg80211_set_wiphy_params,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5556  	.join_ibss = brcmf_cfg80211_join_ibss,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5557  	.leave_ibss = brcmf_cfg80211_leave_ibss,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5558  	.get_station = brcmf_cfg80211_get_station,
bf2a7e0499b922 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Hante Meuleman   2015-10-08  5559  	.dump_station = brcmf_cfg80211_dump_station,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5560  	.set_tx_power = brcmf_cfg80211_set_tx_power,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5561  	.get_tx_power = brcmf_cfg80211_get_tx_power,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5562  	.add_key = brcmf_cfg80211_add_key,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5563  	.del_key = brcmf_cfg80211_del_key,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5564  	.get_key = brcmf_cfg80211_get_key,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5565  	.set_default_key = brcmf_cfg80211_config_default_key,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5566  	.set_default_mgmt_key = brcmf_cfg80211_config_default_mgmt_key,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5567  	.set_power_mgmt = brcmf_cfg80211_set_power_mgmt,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5568  	.connect = brcmf_cfg80211_connect,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5569  	.disconnect = brcmf_cfg80211_disconnect,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5570  	.suspend = brcmf_cfg80211_suspend,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5571  	.resume = brcmf_cfg80211_resume,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5572  	.set_pmksa = brcmf_cfg80211_set_pmksa,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5573  	.del_pmksa = brcmf_cfg80211_del_pmksa,
cbaa177d2b2f93 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2012-08-30  5574  	.flush_pmksa = brcmf_cfg80211_flush_pmksa,
1a87334239757b drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  5575  	.start_ap = brcmf_cfg80211_start_ap,
1a87334239757b drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  5576  	.stop_ap = brcmf_cfg80211_stop_ap,
a0f07959ee6e7f drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-08 @5577  	.change_beacon = brcmf_cfg80211_change_beacon,
1a87334239757b drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  5578  	.del_station = brcmf_cfg80211_del_station,
6b89dcb35bfc78 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Hante Meuleman   2014-12-21  5579  	.change_station = brcmf_cfg80211_change_station,
e58060723c91a2 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2012-09-19  5580  	.sched_scan_start = brcmf_cfg80211_sched_scan_start,
e58060723c91a2 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2012-09-19  5581  	.sched_scan_stop = brcmf_cfg80211_sched_scan_stop,
6cd536fe62ef58 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Johannes Berg    2020-04-17  5582  	.update_mgmt_frame_registrations =
6cd536fe62ef58 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Johannes Berg    2020-04-17  5583  		brcmf_cfg80211_update_mgmt_frame_registrations,
0de8aace0ff499 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-08  5584  	.mgmt_tx = brcmf_cfg80211_mgmt_tx,
7dd56ea45a6686 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Alvin Šipraga    2021-02-08  5585  	.set_cqm_rssi_range_config = brcmf_cfg80211_set_cqm_rssi_range_config,
0de8aace0ff499 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-08  5586  	.remain_on_channel = brcmf_p2p_remain_on_channel,
0de8aace0ff499 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-08  5587  	.cancel_remain_on_channel = brcmf_cfg80211_cancel_remain_on_channel,
ee6e7aa383944c drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Rafał Miłecki    2016-05-20  5588  	.get_channel = brcmf_cfg80211_get_channel,
27f10e380ad912 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2013-04-05  5589  	.start_p2p_device = brcmf_p2p_start_device,
27f10e380ad912 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2013-04-05  5590  	.stop_p2p_device = brcmf_p2p_stop_device,
61730d4dfffc2c drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Piotr Haber      2013-04-23  5591  	.crit_proto_start = brcmf_cfg80211_crit_proto_start,
61730d4dfffc2c drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Piotr Haber      2013-04-23  5592  	.crit_proto_stop = brcmf_cfg80211_crit_proto_stop,
89c2f382fff4ec drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2013-08-10  5593  	.tdls_oper = brcmf_cfg80211_tdls_oper,
2a2a5d1835b6f0 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Arend Van Spriel 2017-01-27  5594  	.update_connect_params = brcmf_cfg80211_update_conn_params,
2526ff21aa77c2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Arend van Spriel 2017-06-09  5595  	.set_pmk = brcmf_cfg80211_set_pmk,
2526ff21aa77c2 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Arend van Spriel 2017-06-09  5596  	.del_pmk = brcmf_cfg80211_del_pmk,
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5597  };
5b435de0d78686 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2011-10-05  5598  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
