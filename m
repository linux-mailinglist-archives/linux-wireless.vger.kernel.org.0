Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF07B3E72
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Sep 2023 07:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjI3FbZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Sep 2023 01:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjI3FbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Sep 2023 01:31:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ADDD
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696051882; x=1727587882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=teTXffVzdT9cN/J4m8nipz8diUW6Ko96uUtAmk9hvEU=;
  b=SypfnrpkU04A98/YNUKGOWjyOCfc52prKaMGY+TaHG47IYROUbzJe0uI
   6Xs0ad5s+Q0BD8Fzv1ozWPRgzN7HLaMD7Z4VZRX+3GZDer6A6PNEjIN9x
   EB3MdHx/YYvEliHPKaykeMC2M0/2ERj0FGKDTVnkmnl7vD54WDIukTTXJ
   1tYN741j+ikrcd9+NVY73rh3t/L7L1dl6WH7ZrDNV04D+lfi7Xie5czzA
   8trLEfbHzpvl/VNfKDJhMc3k3lsPBXFJ6LHR/W8dMwCvqfYYKff2ILpqn
   JSvMCMhYlqD3unwI1M2yksJMTcYjVT1yX4ItlBL14sxYbJAR8lwau3hsF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381304614"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="381304614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 22:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="1033650"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2023 22:30:44 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmSZR-0003kS-06;
        Sat, 30 Sep 2023 05:31:17 +0000
Date:   Sat, 30 Sep 2023 13:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, johannes@sipsolutions.net,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: Re: [PATCH v3 1/3] wifi: cfg80211: send link id in channel_switch ops
Message-ID: <202309301330.rJAFl5og-lkp@intel.com>
References: <20230926091648.17184-2-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926091648.17184-2-quic_adisi@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5482c0a28b2634e7a7d8ddaca7feac183e74b528]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Kumar-Singh/wifi-cfg80211-send-link-id-in-channel_switch-ops/20230926-171918
base:   5482c0a28b2634e7a7d8ddaca7feac183e74b528
patch link:    https://lore.kernel.org/r/20230926091648.17184-2-quic_adisi%40quicinc.com
patch subject: [PATCH v3 1/3] wifi: cfg80211: send link id in channel_switch ops
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230930/202309301330.rJAFl5og-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301330.rJAFl5og-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301330.rJAFl5og-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/quantenna/qtnfmac/cfg80211.c:1026:35: error: initialization of 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *, unsigned int)' from incompatible pointer type 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *)' [-Werror=incompatible-pointer-types]
    1026 |         .channel_switch         = qtnf_channel_switch,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/quantenna/qtnfmac/cfg80211.c:1026:35: note: (near initialization for 'qtn_cfg80211_ops.channel_switch')
   cc1: some warnings being treated as errors


vim +1026 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c

28b9188483908b2 Sergey Matyukevich 2018-08-02  1000  
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1001  static struct cfg80211_ops qtn_cfg80211_ops = {
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1002  	.add_virtual_intf	= qtnf_add_virtual_intf,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1003  	.change_virtual_intf	= qtnf_change_virtual_intf,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1004  	.del_virtual_intf	= qtnf_del_virtual_intf,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1005  	.start_ap		= qtnf_start_ap,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1006  	.change_beacon		= qtnf_change_beacon,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1007  	.stop_ap		= qtnf_stop_ap,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1008  	.set_wiphy_params	= qtnf_set_wiphy_params,
6cd536fe62ef58d Johannes Berg      2020-04-17  1009  	.update_mgmt_frame_registrations =
6cd536fe62ef58d Johannes Berg      2020-04-17  1010  		qtnf_update_mgmt_frame_registrations,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1011  	.mgmt_tx		= qtnf_mgmt_tx,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1012  	.change_station		= qtnf_change_station,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1013  	.del_station		= qtnf_del_station,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1014  	.get_station		= qtnf_get_station,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1015  	.dump_station		= qtnf_dump_station,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1016  	.add_key		= qtnf_add_key,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1017  	.del_key		= qtnf_del_key,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1018  	.set_default_key	= qtnf_set_default_key,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1019  	.set_default_mgmt_key	= qtnf_set_default_mgmt_key,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1020  	.scan			= qtnf_scan,
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1021  	.connect		= qtnf_connect,
47b08e75a669887 Sergey Matyukevich 2019-02-05  1022  	.external_auth		= qtnf_external_auth,
7c04b43984a57bd Sergey Matyukevich 2017-07-28  1023  	.disconnect		= qtnf_disconnect,
278944482b2970b Sergey Matyukevich 2017-07-28  1024  	.dump_survey		= qtnf_dump_survey,
97883695d596e29 Sergey Matyukevich 2017-07-28  1025  	.get_channel		= qtnf_get_channel,
b05ee456fd21d7b Igor Mitsyanko     2017-12-19 @1026  	.channel_switch		= qtnf_channel_switch,
b05ee456fd21d7b Igor Mitsyanko     2017-12-19  1027  	.start_radar_detection	= qtnf_start_radar_detection,
f1398fd2dd8c77b Vasily Ulyanov     2017-12-19  1028  	.set_mac_acl		= qtnf_set_mac_acl,
4775ad06b56a151 Sergei Maksimenko  2018-05-31  1029  	.set_power_mgmt		= qtnf_set_power_mgmt,
0756e913fc020ab Mikhail Karpenko   2019-11-13  1030  	.get_tx_power		= qtnf_get_tx_power,
0756e913fc020ab Mikhail Karpenko   2019-11-13  1031  	.set_tx_power		= qtnf_set_tx_power,
44d09764856f69d Sergey Matyukevich 2020-02-13  1032  	.update_owe_info	= qtnf_update_owe_info,
28b9188483908b2 Sergey Matyukevich 2018-08-02  1033  #ifdef CONFIG_PM
28b9188483908b2 Sergey Matyukevich 2018-08-02  1034  	.suspend		= qtnf_suspend,
28b9188483908b2 Sergey Matyukevich 2018-08-02  1035  	.resume			= qtnf_resume,
28b9188483908b2 Sergey Matyukevich 2018-08-02  1036  	.set_wakeup		= qtnf_set_wakeup,
28b9188483908b2 Sergey Matyukevich 2018-08-02  1037  #endif
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1038  };
98f44cb0655cbef Igor Mitsyanko     2017-05-11  1039  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
