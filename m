Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7926E0501
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDMDDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 23:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDMDDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 23:03:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6632694
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681355016; x=1712891016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z0UNzeJ1Sjtro1S5OH3iNmoeTLZclN9Vh/bmGudCp+g=;
  b=XBNolx0tTXr0M0lZz0tthhe5Gg8tMrMsDYJx5+gRbKqAvL/qhr4woPom
   Xe/O3A6goF2UOkWfoRMMlN9f1Bg1FhMMsyTBQrdQTWca8x2YFrFHCOd8E
   DmpY1GpXHU6V8bCK+kfo1rJbvvRDby2WXUSmA3otknZLw3x5yghwd2EMp
   L5p15/iCHfpiYTc3IV6bGeW1ULOkGXLk94xShChJd0Zlz4sBl6m8zWxBE
   YT7Ncs6Qs5OT2g+i2R+OCZDEl5lqp6RiziBaJavzWXEmaaJY4tsv9WWM+
   v/Mu8rT1SMB35iOlwPvTnWzxSSq+Dcxhn3g27rcrDr01CfSKWu92uVdSy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324431953"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324431953"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778526667"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778526667"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 20:03:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmnFE-000YHp-0V;
        Thu, 13 Apr 2023 03:03:32 +0000
Date:   Thu, 13 Apr 2023 11:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>,
        johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: Re: [PATCH v4 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
Message-ID: <202304131044.Y2mHsqp7-lkp@intel.com>
References: <20230412231241.1587517-1-gilad.itzkovitch@virscient.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412231241.1587517-1-gilad.itzkovitch@virscient.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Gilad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa2aa818cd1198cfa2498116d57cd9f13fea80e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Gilad-Itzkovitch/wifi-mac80211-S1G-beacon-short-beacon-support/20230413-071340
base:   aa2aa818cd1198cfa2498116d57cd9f13fea80e4
patch link:    https://lore.kernel.org/r/20230412231241.1587517-1-gilad.itzkovitch%40virscient.com
patch subject: [PATCH v4 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
config: i386-randconfig-a005-20230410 (https://download.01.org/0day-ci/archive/20230413/202304131044.Y2mHsqp7-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0559af4e4729ccb2c2f378b51d5ccc1e35bb18f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gilad-Itzkovitch/wifi-mac80211-S1G-beacon-short-beacon-support/20230413-071340
        git checkout 0559af4e4729ccb2c2f378b51d5ccc1e35bb18f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304131044.Y2mHsqp7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/wireless/nl80211.c:236:6: warning: variable 's1g_short_bcn' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (len < offsetofend(typeof(*mgmt), frame_control))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/wireless/nl80211.c:272:6: note: uninitialized use occurs here
           if (s1g_short_bcn)
               ^~~~~~~~~~~~~
   net/wireless/nl80211.c:236:2: note: remove the 'if' if its condition is always false
           if (len < offsetofend(typeof(*mgmt), frame_control))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/wireless/nl80211.c:234:20: note: initialize the variable 's1g_short_bcn' to silence this warning
           bool s1g_short_bcn;
                             ^
                              = 0
   1 warning generated.


vim +236 net/wireless/nl80211.c

a9455408b09395 Johannes Berg   2012-06-15  224  
f88eb7c0d002a6 Johannes Berg   2019-09-20  225  static int validate_beacon_head(const struct nlattr *attr,
f88eb7c0d002a6 Johannes Berg   2019-09-20  226  				struct netlink_ext_ack *extack)
f88eb7c0d002a6 Johannes Berg   2019-09-20  227  {
f88eb7c0d002a6 Johannes Berg   2019-09-20  228  	const u8 *data = nla_data(attr);
f88eb7c0d002a6 Johannes Berg   2019-09-20  229  	unsigned int len = nla_len(attr);
f88eb7c0d002a6 Johannes Berg   2019-09-20  230  	const struct element *elem;
f88eb7c0d002a6 Johannes Berg   2019-09-20  231  	const struct ieee80211_mgmt *mgmt = (void *)data;
1d47f1198d5811 Thomas Pedersen 2020-09-08  232  	unsigned int fixedlen, hdrlen;
9a6847ba174785 Johannes Berg   2021-04-08  233  	bool s1g_bcn;
0559af4e4729cc Kieran Frewen   2023-04-13  234  	bool s1g_short_bcn;
1d47f1198d5811 Thomas Pedersen 2020-09-08  235  
9a6847ba174785 Johannes Berg   2021-04-08 @236  	if (len < offsetofend(typeof(*mgmt), frame_control))
9a6847ba174785 Johannes Berg   2021-04-08  237  		goto err;
9a6847ba174785 Johannes Berg   2021-04-08  238  
9a6847ba174785 Johannes Berg   2021-04-08  239  	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
0559af4e4729cc Kieran Frewen   2023-04-13  240  	s1g_short_bcn = ieee80211_is_s1g_short_beacon(mgmt->frame_control);
0559af4e4729cc Kieran Frewen   2023-04-13  241  	if (s1g_short_bcn) {
0559af4e4729cc Kieran Frewen   2023-04-13  242  		fixedlen = offsetof(struct ieee80211_ext,
0559af4e4729cc Kieran Frewen   2023-04-13  243  				    u.s1g_short_beacon.variable);
0559af4e4729cc Kieran Frewen   2023-04-13  244  		hdrlen = offsetof(struct ieee80211_ext, u.s1g_short_beacon);
0559af4e4729cc Kieran Frewen   2023-04-13  245  	} else if (s1g_bcn) {
1d47f1198d5811 Thomas Pedersen 2020-09-08  246  		fixedlen = offsetof(struct ieee80211_ext,
1d47f1198d5811 Thomas Pedersen 2020-09-08  247  				    u.s1g_beacon.variable);
1d47f1198d5811 Thomas Pedersen 2020-09-08  248  		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
1d47f1198d5811 Thomas Pedersen 2020-09-08  249  	} else {
1d47f1198d5811 Thomas Pedersen 2020-09-08  250  		fixedlen = offsetof(struct ieee80211_mgmt,
f88eb7c0d002a6 Johannes Berg   2019-09-20  251  				    u.beacon.variable);
1d47f1198d5811 Thomas Pedersen 2020-09-08  252  		hdrlen = offsetof(struct ieee80211_mgmt, u.beacon);
1d47f1198d5811 Thomas Pedersen 2020-09-08  253  	}
f88eb7c0d002a6 Johannes Berg   2019-09-20  254  
f88eb7c0d002a6 Johannes Berg   2019-09-20  255  	if (len < fixedlen)
f88eb7c0d002a6 Johannes Berg   2019-09-20  256  		goto err;
f88eb7c0d002a6 Johannes Berg   2019-09-20  257  
1d47f1198d5811 Thomas Pedersen 2020-09-08  258  	if (ieee80211_hdrlen(mgmt->frame_control) != hdrlen)
f88eb7c0d002a6 Johannes Berg   2019-09-20  259  		goto err;
f88eb7c0d002a6 Johannes Berg   2019-09-20  260  
f88eb7c0d002a6 Johannes Berg   2019-09-20  261  	data += fixedlen;
f88eb7c0d002a6 Johannes Berg   2019-09-20  262  	len -= fixedlen;
f88eb7c0d002a6 Johannes Berg   2019-09-20  263  
f88eb7c0d002a6 Johannes Berg   2019-09-20  264  	for_each_element(elem, data, len) {
f88eb7c0d002a6 Johannes Berg   2019-09-20  265  		/* nothing */
f88eb7c0d002a6 Johannes Berg   2019-09-20  266  	}
f88eb7c0d002a6 Johannes Berg   2019-09-20  267  
f88eb7c0d002a6 Johannes Berg   2019-09-20  268  	if (for_each_element_completed(elem, data, len))
f88eb7c0d002a6 Johannes Berg   2019-09-20  269  		return 0;
f88eb7c0d002a6 Johannes Berg   2019-09-20  270  
f88eb7c0d002a6 Johannes Berg   2019-09-20  271  err:
0559af4e4729cc Kieran Frewen   2023-04-13  272  	if (s1g_short_bcn)
0559af4e4729cc Kieran Frewen   2023-04-13  273  		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed S1G short beacon head");
0559af4e4729cc Kieran Frewen   2023-04-13  274  	else if (s1g_bcn)
0559af4e4729cc Kieran Frewen   2023-04-13  275  		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed S1G beacon head");
0559af4e4729cc Kieran Frewen   2023-04-13  276  	else
f88eb7c0d002a6 Johannes Berg   2019-09-20  277  		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed beacon head");
f88eb7c0d002a6 Johannes Berg   2019-09-20  278  	return -EINVAL;
f88eb7c0d002a6 Johannes Berg   2019-09-20  279  }
f88eb7c0d002a6 Johannes Berg   2019-09-20  280  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
