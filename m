Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714597A96C5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 19:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjIURFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjIUREl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 13:04:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D00E44
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695315524; x=1726851524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DU0DMq1DsScjXCgr55kDME2uWAz/6g0DuU/OjoPmKoc=;
  b=TzdOjd+gK31FmshI/+uOkTqR0WLNe+6Ruyz+q/I0hVAnbmSVVWg42UDf
   5x/hPqphaKfB1Z2nLXDcl8XbNIs+a5jsCv5HTDD30bBHTPVmRj3R5nvEL
   WryumstLXsYvhG6UU06IwAz3+Byeu62IbZS0sJJDj4yIyp52XZVC/JOr+
   xvXPgE1/ngBsZ/VkmSvKGijtr/I+u+s5ivt/6Dk08iHvtx5kbOQINVP2e
   Anh0fmMvVqohY596Oyf6pet5/xzYKoKEFAXzfAbOlYs1U8SUpmXqvSA+T
   Kh15N1rlkhUUvc7CTYyrS4wI4jhlF2mQkLag2gBqThpo0qUvkCxdapSFU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466724790"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="466724790"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 21:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="750219484"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="750219484"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2023 21:39:14 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjBT6-0009Vi-11;
        Thu, 21 Sep 2023 04:39:12 +0000
Date:   Thu, 21 Sep 2023 12:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes.berg@intel.com>,
        syzbot+c12a771b218dcbba32e1@syzkaller.appspotmail.com
Subject: Re: [PATCH] wifi: mac80211: ethtool: always hold wiphy mutex
Message-ID: <202309211239.sWxQtmqe-lkp@intel.com>
References: <20230919084051.942b0bbde0ce.I7215d6cd3bcb4bb8631ddf872356408dd69477fe@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919084051.942b0bbde0ce.I7215d6cd3bcb4bb8631ddf872356408dd69477fe@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-next/master]
[also build test ERROR on linus/master v6.6-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-ethtool-always-hold-wiphy-mutex/20230919-144127
base:   linux-next/master
patch link:    https://lore.kernel.org/r/20230919084051.942b0bbde0ce.I7215d6cd3bcb4bb8631ddf872356408dd69477fe%40changeid
patch subject: [PATCH] wifi: mac80211: ethtool: always hold wiphy mutex
config: x86_64-randconfig-102-20230921 (https://download.01.org/0day-ci/archive/20230921/202309211239.sWxQtmqe-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309211239.sWxQtmqe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309211239.sWxQtmqe-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mac80211/ethtool.c: In function 'ieee80211_set_ringparam':
>> net/mac80211/ethtool.c:27:13: error: 'sdata' undeclared (first use in this function); did you mean '_sdata'?
     wiphy_lock(sdata->local->hw.wiphy);
                ^~~~~
                _sdata
   net/mac80211/ethtool.c:27:13: note: each undeclared identifier is reported only once for each function it appears in
   net/mac80211/ethtool.c: In function 'ieee80211_get_ringparam':
   net/mac80211/ethtool.c:43:13: error: 'sdata' undeclared (first use in this function); did you mean '_sdata'?
     wiphy_lock(sdata->local->hw.wiphy);
                ^~~~~
                _sdata


vim +27 net/mac80211/ethtool.c

    15	
    16	static int ieee80211_set_ringparam(struct net_device *dev,
    17					   struct ethtool_ringparam *rp,
    18					   struct kernel_ethtool_ringparam *kernel_rp,
    19					   struct netlink_ext_ack *extack)
    20	{
    21		struct ieee80211_local *local = wiphy_priv(dev->ieee80211_ptr->wiphy);
    22		int ret;
    23	
    24		if (rp->rx_mini_pending != 0 || rp->rx_jumbo_pending != 0)
    25			return -EINVAL;
    26	
  > 27		wiphy_lock(sdata->local->hw.wiphy);
    28		ret = drv_set_ringparam(local, rp->tx_pending, rp->rx_pending);
    29		wiphy_unlock(sdata->local->hw.wiphy);
    30	
    31		return ret;
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
