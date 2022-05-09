Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9D52082D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 01:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiEIXPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 19:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiEIXPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 19:15:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549D185CB2
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652137862; x=1683673862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GpyiiA3RoJxNTwWlJhPfMCUE4hqw+HxAyGb1rXGiog=;
  b=RDp6OsVOdEID+kotz1XNza/JIg8h2/DK/ShfIx3SYDGLneEvnLrZLMnc
   g7v3l4sbkgTMNtZ6wN9hqAyn8ZQU9wRRzz8YdEYHfbiXY4kyyKgkywdSO
   52fPjY73jEwQ1M1mm1kPzO3Fw3OUOqvNyY2AeBhNXOB5NcI7uUVXgfVgd
   7BK73k18/Io7NAnTk2CQGr/im032N9+bwW72qvo0uzB3l3wHjfZ5hvnfY
   qSBuO9s3S03mqmySnPXD0iKEctopGVdfI+8GLvRhiSqb/WaNmGNHZW84E
   v6jJx47pbq5ryCWkEZ0IFzCngJgppoE5fbABg2qknc082CGYCEoqJbgrH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294422470"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="294422470"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 16:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="657353291"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 16:11:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noCWq-000Gzg-FQ;
        Mon, 09 May 2022 23:11:00 +0000
Date:   Tue, 10 May 2022 07:10:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>, johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: Re: [PATCH v3 1/2] nl80211: process additional attributes in
 NL80211_CMD_SET_BEACON
Message-ID: <202205100703.8aYeYjJx-lkp@intel.com>
References: <20220509173354.2482-2-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509173354.2482-2-quic_alokad@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: mips-randconfig-r011-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100703.8aYeYjJx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3abb68a626160e019c30a4860e569d7bc75e486a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4b2583148641664d3a44d750efff98707ea07b23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aloka-Dixit/Additional-processing-in-NL80211_CMD_SET_BEACON/20220510-013948
        git checkout 4b2583148641664d3a44d750efff98707ea07b23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath6kl/cfg80211.c:3457:19: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_ap_settings *)' with an expression of type 'int (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .change_beacon = ath6kl_change_beacon,
                            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/net/wireless/marvell/mwifiex/cfg80211.c:4239:19: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_ap_settings *)' with an expression of type 'int (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .change_beacon = mwifiex_cfg80211_change_beacon,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/net/wireless/quantenna/qtnfmac/cfg80211.c:1004:20: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_ap_settings *)' with an expression of type 'int (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .change_beacon          = qtnf_change_beacon,
                                     ^~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/net/wireless/ath/wil6210/cfg80211.c:2656:19: error: incompatible function pointer types initializing 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_ap_settings *)' with an expression of type 'int (struct wiphy *, struct net_device *, struct cfg80211_beacon_data *)' [-Werror,-Wincompatible-function-pointer-types]
           .change_beacon = wil_cfg80211_change_beacon,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +3457 drivers/net/wireless/ath/ath6kl/cfg80211.c

f80574ae1538f6 Jouni Malinen             2011-08-30  3429  
bdcd81707973cf Kalle Valo                2011-07-18  3430  static struct cfg80211_ops ath6kl_cfg80211_ops = {
55055976fe15f4 Vasanthakumar Thiagarajan 2011-10-25  3431  	.add_virtual_intf = ath6kl_cfg80211_add_iface,
55055976fe15f4 Vasanthakumar Thiagarajan 2011-10-25  3432  	.del_virtual_intf = ath6kl_cfg80211_del_iface,
bdcd81707973cf Kalle Valo                2011-07-18  3433  	.change_virtual_intf = ath6kl_cfg80211_change_iface,
bdcd81707973cf Kalle Valo                2011-07-18  3434  	.scan = ath6kl_cfg80211_scan,
bdcd81707973cf Kalle Valo                2011-07-18  3435  	.connect = ath6kl_cfg80211_connect,
bdcd81707973cf Kalle Valo                2011-07-18  3436  	.disconnect = ath6kl_cfg80211_disconnect,
bdcd81707973cf Kalle Valo                2011-07-18  3437  	.add_key = ath6kl_cfg80211_add_key,
bdcd81707973cf Kalle Valo                2011-07-18  3438  	.get_key = ath6kl_cfg80211_get_key,
bdcd81707973cf Kalle Valo                2011-07-18  3439  	.del_key = ath6kl_cfg80211_del_key,
bdcd81707973cf Kalle Valo                2011-07-18  3440  	.set_default_key = ath6kl_cfg80211_set_default_key,
bdcd81707973cf Kalle Valo                2011-07-18  3441  	.set_wiphy_params = ath6kl_cfg80211_set_wiphy_params,
bdcd81707973cf Kalle Valo                2011-07-18  3442  	.set_tx_power = ath6kl_cfg80211_set_txpower,
bdcd81707973cf Kalle Valo                2011-07-18  3443  	.get_tx_power = ath6kl_cfg80211_get_txpower,
bdcd81707973cf Kalle Valo                2011-07-18  3444  	.set_power_mgmt = ath6kl_cfg80211_set_power_mgmt,
bdcd81707973cf Kalle Valo                2011-07-18  3445  	.join_ibss = ath6kl_cfg80211_join_ibss,
bdcd81707973cf Kalle Valo                2011-07-18  3446  	.leave_ibss = ath6kl_cfg80211_leave_ibss,
bdcd81707973cf Kalle Valo                2011-07-18  3447  	.get_station = ath6kl_get_station,
bdcd81707973cf Kalle Valo                2011-07-18  3448  	.set_pmksa = ath6kl_set_pmksa,
bdcd81707973cf Kalle Valo                2011-07-18  3449  	.del_pmksa = ath6kl_del_pmksa,
bdcd81707973cf Kalle Valo                2011-07-18  3450  	.flush_pmksa = ath6kl_flush_pmksa,
003353b0d27489 Kalle Valo                2011-09-01  3451  	CFG80211_TESTMODE_CMD(ath6kl_tm_cmd)
abcb344b3b823c Kalle Valo                2011-07-22  3452  #ifdef CONFIG_PM
52d81a6883fb36 Kalle Valo                2011-11-01  3453  	.suspend = __ath6kl_cfg80211_suspend,
52d81a6883fb36 Kalle Valo                2011-11-01  3454  	.resume = __ath6kl_cfg80211_resume,
abcb344b3b823c Kalle Valo                2011-07-22  3455  #endif
8860020e0be1f0 Johannes Berg             2012-02-13  3456  	.start_ap = ath6kl_start_ap,
8860020e0be1f0 Johannes Berg             2012-02-13 @3457  	.change_beacon = ath6kl_change_beacon,
8860020e0be1f0 Johannes Berg             2012-02-13  3458  	.stop_ap = ath6kl_stop_ap,
33e5308d8a0fb8 Jouni Malinen             2011-12-27  3459  	.del_station = ath6kl_del_station,
238751365a1c42 Jouni Malinen             2011-08-30  3460  	.change_station = ath6kl_change_station,
63fa1e0ca7a2c1 Jouni Malinen             2011-08-30  3461  	.remain_on_channel = ath6kl_remain_on_channel,
63fa1e0ca7a2c1 Jouni Malinen             2011-08-30  3462  	.cancel_remain_on_channel = ath6kl_cancel_remain_on_channel,
8a6c8060c0b166 Jouni Malinen             2011-08-30  3463  	.mgmt_tx = ath6kl_mgmt_tx,
6cd536fe62ef58 Johannes Berg             2020-04-17  3464  	.update_mgmt_frame_registrations =
6cd536fe62ef58 Johannes Berg             2020-04-17  3465  		ath6kl_update_mgmt_frame_registrations,
9c2e90ffc97a8f Ben Greear                2015-10-21  3466  	.get_antenna = ath6kl_get_antenna,
10509f903ebb7d Kalle Valo                2011-12-13  3467  	.sched_scan_start = ath6kl_cfg80211_sscan_start,
10509f903ebb7d Kalle Valo                2011-12-13  3468  	.sched_scan_stop = ath6kl_cfg80211_sscan_stop,
06e360ace9434b Bala Shanmugam            2012-05-22  3469  	.set_bitrate_mask = ath6kl_cfg80211_set_bitrate,
279b2862ee6ba9 Thomas Pedersen           2012-07-17  3470  	.set_cqm_txe_config = ath6kl_cfg80211_set_txe_config,
bdcd81707973cf Kalle Valo                2011-07-18  3471  };
bdcd81707973cf Kalle Valo                2011-07-18  3472  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
