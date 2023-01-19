Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58209673184
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASGIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjASGIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:08:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6A4DBEE
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674108519; x=1705644519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lUq9iNvMmqy/WCDoSncz49qRc0gAeU4Olc+uiZi/SlU=;
  b=HMimXUxZ0KOAOQZNpuLab5dVPr2e5QLA7/Lhul4UC/qvtnmxxOvtBRPH
   NycN6bPOuedDwxnGfCIvHcHRysvP6oR0IZ21EFm7AWf2tLWv9LVZBwigG
   sIvLCJTMu9UH3Ugm+J0MRmExynAFCVWs7MYzCrJf9yDw/HTEv+o7sdRvw
   +cnl7MWNXNnEnmZOxrzBhXBhe2GQlyy/A+xrR343dFR1GoVybM8Fr0Kge
   i9udAiU8ZctwbVsJ/2UxPfjTBlkJ8F7tH3ARBJnWz7fLCymdg5LLt/VNr
   yA+uS8qxSnVokYrMkKk4fMEaZM3M59cNYPj2VOryD6gXs9qUyWXlR6PJv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352460959"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="352460959"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 22:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="660078429"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="660078429"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2023 22:08:36 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIO6G-0001BY-0T;
        Thu, 19 Jan 2023 06:08:36 +0000
Date:   Thu, 19 Jan 2023 14:07:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        johannes@sipsolutions.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: cfg80211/mac80211: add support for channel
 switch with MLO
Message-ID: <202301191402.DoEMde4N-lkp@intel.com>
References: <20230118151604.1278-2-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118151604.1278-2-quic_adisi@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aditya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on d0e99511834b6828c960e978d9a8cb6e5731250d]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Kumar-Singh/wifi-cfg80211-mac80211-add-support-for-channel-switch-with-MLO/20230118-232151
base:   d0e99511834b6828c960e978d9a8cb6e5731250d
patch link:    https://lore.kernel.org/r/20230118151604.1278-2-quic_adisi%40quicinc.com
patch subject: [PATCH 1/2] wifi: cfg80211/mac80211: add support for channel switch with MLO
config: loongarch-randconfig-r034-20230118 (https://download.01.org/0day-ci/archive/20230119/202301191402.DoEMde4N-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae87dbc7e6dd83018015e1e624984fd844704159
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aditya-Kumar-Singh/wifi-cfg80211-mac80211-add-support-for-channel-switch-with-MLO/20230118-232151
        git checkout ae87dbc7e6dd83018015e1e624984fd844704159
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/quantenna/qtnfmac/cfg80211.c:1026:35: error: initialization of 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *, unsigned int)' from incompatible pointer type 'int (*)(struct wiphy *, struct net_device *, struct cfg80211_csa_settings *)' [-Werror=incompatible-pointer-types]
    1026 |         .channel_switch         = qtnf_channel_switch,
         |                                   ^~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/quantenna/qtnfmac/cfg80211.c:1026:35: note: (near initialization for 'qtn_cfg80211_ops.channel_switch')
   cc1: some warnings being treated as errors


vim +1026 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c

28b9188483908b Sergey Matyukevich 2018-08-02  1000  
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1001  static struct cfg80211_ops qtn_cfg80211_ops = {
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1002  	.add_virtual_intf	= qtnf_add_virtual_intf,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1003  	.change_virtual_intf	= qtnf_change_virtual_intf,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1004  	.del_virtual_intf	= qtnf_del_virtual_intf,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1005  	.start_ap		= qtnf_start_ap,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1006  	.change_beacon		= qtnf_change_beacon,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1007  	.stop_ap		= qtnf_stop_ap,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1008  	.set_wiphy_params	= qtnf_set_wiphy_params,
6cd536fe62ef58 Johannes Berg      2020-04-17  1009  	.update_mgmt_frame_registrations =
6cd536fe62ef58 Johannes Berg      2020-04-17  1010  		qtnf_update_mgmt_frame_registrations,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1011  	.mgmt_tx		= qtnf_mgmt_tx,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1012  	.change_station		= qtnf_change_station,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1013  	.del_station		= qtnf_del_station,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1014  	.get_station		= qtnf_get_station,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1015  	.dump_station		= qtnf_dump_station,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1016  	.add_key		= qtnf_add_key,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1017  	.del_key		= qtnf_del_key,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1018  	.set_default_key	= qtnf_set_default_key,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1019  	.set_default_mgmt_key	= qtnf_set_default_mgmt_key,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1020  	.scan			= qtnf_scan,
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1021  	.connect		= qtnf_connect,
47b08e75a66988 Sergey Matyukevich 2019-02-05  1022  	.external_auth		= qtnf_external_auth,
7c04b43984a57b Sergey Matyukevich 2017-07-28  1023  	.disconnect		= qtnf_disconnect,
278944482b2970 Sergey Matyukevich 2017-07-28  1024  	.dump_survey		= qtnf_dump_survey,
97883695d596e2 Sergey Matyukevich 2017-07-28  1025  	.get_channel		= qtnf_get_channel,
b05ee456fd21d7 Igor Mitsyanko     2017-12-19 @1026  	.channel_switch		= qtnf_channel_switch,
b05ee456fd21d7 Igor Mitsyanko     2017-12-19  1027  	.start_radar_detection	= qtnf_start_radar_detection,
f1398fd2dd8c77 Vasily Ulyanov     2017-12-19  1028  	.set_mac_acl		= qtnf_set_mac_acl,
4775ad06b56a15 Sergei Maksimenko  2018-05-31  1029  	.set_power_mgmt		= qtnf_set_power_mgmt,
0756e913fc020a Mikhail Karpenko   2019-11-13  1030  	.get_tx_power		= qtnf_get_tx_power,
0756e913fc020a Mikhail Karpenko   2019-11-13  1031  	.set_tx_power		= qtnf_set_tx_power,
44d09764856f69 Sergey Matyukevich 2020-02-13  1032  	.update_owe_info	= qtnf_update_owe_info,
28b9188483908b Sergey Matyukevich 2018-08-02  1033  #ifdef CONFIG_PM
28b9188483908b Sergey Matyukevich 2018-08-02  1034  	.suspend		= qtnf_suspend,
28b9188483908b Sergey Matyukevich 2018-08-02  1035  	.resume			= qtnf_resume,
28b9188483908b Sergey Matyukevich 2018-08-02  1036  	.set_wakeup		= qtnf_set_wakeup,
28b9188483908b Sergey Matyukevich 2018-08-02  1037  #endif
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1038  };
98f44cb0655cbe Igor Mitsyanko     2017-05-11  1039  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
