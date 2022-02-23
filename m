Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1922D4C0AEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiBWETo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 23:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiBWETn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 23:19:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6F3ED3A
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645589956; x=1677125956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDx6m3Pv+VOOxTS3LLsQd2cQWwIqzDG/LTtN2bFEJns=;
  b=Q2QJPw5bnsWCSA/N86ViIRIPVbuTwuJXfcbf9Zdz6YzIOnS9sPSKF5Xk
   mwR7OyZ+8ZuOyfiWM39oVWC3sLuCKJhBIdN1JjITNH4FiNWxHzn09dGnX
   4xbUe8Hod6Vgk4sxhdZ9wnrv2ototMXp/EXsjo1tWlb5JGi7nVqE3OvA8
   7sKuRNd36kXQcPHrqyEdy6SUElPhWjaQUzuCBY+u2f4Y7to4fcb1EYo12
   WMQMWehUxobl1MLOnx/xNkqYk4Xh3T9WVwCJb+5jGW9Aw2tXSvcmBSHop
   lOPBlIXsg4f3ynuT5ozC/eD9cIJeXFH0elT6eaS+Kg4JX+nYrJ6TRaWKa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252069745"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252069745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 20:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="639165728"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 20:19:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMj7S-0000xk-3B; Wed, 23 Feb 2022 04:19:14 +0000
Date:   Wed, 23 Feb 2022 12:18:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        quic_usdutt@quicinc.com
Subject: Re: [PATCH 3/3] cfg80211: Add support for key operations on
 NL80211_IFTYPE_MLO_LINK
Message-ID: <202202231233.yxA9uZON-lkp@intel.com>
References: <1645543393-22448-4-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645543393-22448-4-git-send-email-quic_vjakkam@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Veerendranath,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20220222]
[cannot apply to wireless/main jberg-mac80211-next/master jberg-mac80211/master v5.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Veerendranath-Jakkam/cfg80211-Add-MLO-Link-Device-abstraction/20220222-232453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202231233.yxA9uZON-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/01fd3272c5cf2f778a16c217e6c0dbe7064fc9f5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Veerendranath-Jakkam/cfg80211-Add-MLO-Link-Device-abstraction/20220222-232453
        git checkout 01fd3272c5cf2f778a16c217e6c0dbe7064fc9f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/marvell/mwifiex/cfg80211.c:4250:28: error: initialization of 'int (*)(struct wiphy *, struct wireless_dev *, u8,  bool,  bool)' {aka 'int (*)(struct wiphy *, struct wireless_dev *, unsigned char,  _Bool,  _Bool)'} from incompatible pointer type 'int (*)(struct wiphy *, struct net_device *, u8,  bool,  bool)' {aka 'int (*)(struct wiphy *, struct net_device *, unsigned char,  _Bool,  _Bool)'} [-Werror=incompatible-pointer-types]
    4250 |         .set_default_key = mwifiex_cfg80211_set_default_key,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/marvell/mwifiex/cfg80211.c:4250:28: note: (near initialization for 'mwifiex_cfg80211_ops.set_default_key')
   cc1: some warnings being treated as errors


vim +4250 drivers/net/wireless/marvell/mwifiex/cfg80211.c

1f4dfd8a1e911c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4227  
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4228  /* station cfg80211 operations */
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4229  static struct cfg80211_ops mwifiex_cfg80211_ops = {
93a1df48d22429 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-09-26  4230  	.add_virtual_intf = mwifiex_add_virtual_intf,
93a1df48d22429 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-09-26  4231  	.del_virtual_intf = mwifiex_del_virtual_intf,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4232  	.change_virtual_intf = mwifiex_cfg80211_change_virtual_intf,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4233  	.scan = mwifiex_cfg80211_scan,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4234  	.connect = mwifiex_cfg80211_connect,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4235  	.disconnect = mwifiex_cfg80211_disconnect,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4236  	.get_station = mwifiex_cfg80211_get_station,
f85aae6bec6707 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-03-15  4237  	.dump_station = mwifiex_cfg80211_dump_station,
6bc6c49f1e2f3a drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2014-10-31  4238  	.dump_survey = mwifiex_cfg80211_dump_survey,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4239  	.set_wiphy_params = mwifiex_cfg80211_set_wiphy_params,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4240  	.join_ibss = mwifiex_cfg80211_join_ibss,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4241  	.leave_ibss = mwifiex_cfg80211_leave_ibss,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4242  	.add_key = mwifiex_cfg80211_add_key,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4243  	.del_key = mwifiex_cfg80211_del_key,
89951db2be5310 drivers/net/wireless/marvell/mwifiex/cfg80211.c Ganapathi Bhat           2016-09-20  4244  	.set_default_mgmt_key = mwifiex_cfg80211_set_default_mgmt_key,
e39faa73ef14f6 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4245  	.mgmt_tx = mwifiex_cfg80211_mgmt_tx,
6cd536fe62ef58 drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg            2020-04-17  4246  	.update_mgmt_frame_registrations =
6cd536fe62ef58 drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg            2020-04-17  4247  		mwifiex_cfg80211_update_mgmt_frame_registrations,
7feb4c48313d58 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4248  	.remain_on_channel = mwifiex_cfg80211_remain_on_channel,
7feb4c48313d58 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao               2012-09-25  4249  	.cancel_remain_on_channel = mwifiex_cfg80211_cancel_remain_on_channel,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21 @4250  	.set_default_key = mwifiex_cfg80211_set_default_key,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4251  	.set_power_mgmt = mwifiex_cfg80211_set_power_mgmt,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4252  	.set_tx_power = mwifiex_cfg80211_set_tx_power,
7d54bacadce17f drivers/net/wireless/marvell/mwifiex/cfg80211.c Javier Martinez Canillas 2016-06-06  4253  	.get_tx_power = mwifiex_cfg80211_get_tx_power,
5d82c53a380ca9 drivers/net/wireless/mwifiex/cfg80211.c         Yogesh Ashok Powar       2011-07-11  4254  	.set_bitrate_mask = mwifiex_cfg80211_set_bitrate_mask,
12190c5d80bd3c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-05-08  4255  	.start_ap = mwifiex_cfg80211_start_ap,
12190c5d80bd3c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-05-08  4256  	.stop_ap = mwifiex_cfg80211_stop_ap,
5370c83684d9e7 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2012-06-28  4257  	.change_beacon = mwifiex_cfg80211_change_beacon,
fa444bf88ce2ba drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-03-15  4258  	.set_cqm_rssi_config = mwifiex_cfg80211_set_cqm_rssi_config,
8a279d5b4dc128 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2012-07-02  4259  	.set_antenna = mwifiex_cfg80211_set_antenna,
3ee712857958c2 drivers/net/wireless/marvell/mwifiex/cfg80211.c Shengzhen Li             2016-06-06  4260  	.get_antenna = mwifiex_cfg80211_get_antenna,
0f9e9b8ba72bc7 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2013-05-17  4261  	.del_station = mwifiex_cfg80211_del_station,
0c9b7f22e8e1f3 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-01-13  4262  	.sched_scan_start = mwifiex_cfg80211_sched_scan_start,
0c9b7f22e8e1f3 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-01-13  4263  	.sched_scan_stop = mwifiex_cfg80211_sched_scan_stop,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4264  #ifdef CONFIG_PM
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4265  	.suspend = mwifiex_cfg80211_suspend,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4266  	.resume = mwifiex_cfg80211_resume,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4267  	.set_wakeup = mwifiex_cfg80211_set_wakeup,
f6b1cbe029f682 drivers/net/wireless/marvell/mwifiex/cfg80211.c Ganapathi Bhat           2016-04-05  4268  	.set_rekey_data = mwifiex_set_rekey_data,
7da060c1c01b10 drivers/net/wireless/mwifiex/cfg80211.c         Amitkumar Karwar         2013-03-04  4269  #endif
d1e2586f484dfc drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2013-08-09  4270  	.set_coalesce = mwifiex_cfg80211_set_coalesce,
b23bce29656801 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4271  	.tdls_mgmt = mwifiex_cfg80211_tdls_mgmt,
429d90d2212b56 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4272  	.tdls_oper = mwifiex_cfg80211_tdls_oper,
b04975970676d7 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-22  4273  	.tdls_channel_switch = mwifiex_cfg80211_tdls_chan_switch,
b04975970676d7 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-22  4274  	.tdls_cancel_channel_switch = mwifiex_cfg80211_tdls_cancel_chan_switch,
e48e0de0053f07 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4275  	.add_station = mwifiex_cfg80211_add_station,
1f4dfd8a1e911c drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2014-02-07  4276  	.change_station = mwifiex_cfg80211_change_station,
3935ccc14d2c68 drivers/net/wireless/marvell/mwifiex/cfg80211.c Xinming Hu               2016-09-02  4277  	CFG80211_TESTMODE_CMD(mwifiex_tm_cmd)
7ee38bf4edeac8 drivers/net/wireless/mwifiex/cfg80211.c         Xinming Hu               2015-06-03  4278  	.get_channel = mwifiex_cfg80211_get_channel,
85afb18621be39 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2015-01-28  4279  	.start_radar_detection = mwifiex_cfg80211_start_radar_detection,
7d652034d1a08b drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil            2015-01-28  4280  	.channel_switch = mwifiex_cfg80211_channel_switch,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4281  };
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao                2011-03-21  4282  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
