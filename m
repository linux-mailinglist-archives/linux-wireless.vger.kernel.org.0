Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7034F0C93
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Apr 2022 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiDCVIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Apr 2022 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCVIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Apr 2022 17:08:38 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A139BA1
        for <linux-wireless@vger.kernel.org>; Sun,  3 Apr 2022 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649020004; x=1680556004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88MUQi+gTCRg6nJv5yFxQlLz8LkChLiayAtOzYw2zu0=;
  b=KBMy1iXJWHu8/zzMNfAtOSwwc76JVFC/YINOcEvh1s8v9CUUCfMaHLH9
   zzbsk0YRU5enggMUcgkeF1xdpptrbZR4CMwoMfuNU2z4STlTMXdhi5dkx
   F5GD3euHvnWUD08f5rppRWF0lA/CTmQfZ3rMebZPhFzqDXdp2U9pD8+aJ
   L5cQrfCwDu2GEPlj50lxsmLDmsE2qx+LGVhaCC/Clscq7Sadlkk8Ht/PX
   Tt2+nVli8b3p5QCvjB8kCzjf3qe9bTVCpEwm/bNmUsFHeti6OJe+/EAWu
   SDRRbBu+w/QF4OSYOPxU1IvhxN/9v327wCOoHvo9e0j+N6RH+O0QtjGuM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321105083"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="321105083"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 14:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="548430636"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2022 14:06:41 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb7Qm-0001Dx-Vw;
        Sun, 03 Apr 2022 21:06:40 +0000
Date:   Mon, 4 Apr 2022 05:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wireless: Change Kconfig to select WEXT_PRIV
Message-ID: <202204040407.SOfx1u0m-lkp@intel.com>
References: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403181431.21811-1-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main v5.17 next-20220401]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Larry-Finger/wireless-Change-Kconfig-to-select-WEXT_PRIV/20220404-021519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: arm-randconfig-c002-20220403 (https://download.01.org/0day-ci/archive/20220404/202204040407.SOfx1u0m-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b240672cd1f8018bc9aa17c50d9e2500db397d23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Larry-Finger/wireless-Change-Kconfig-to-select-WEXT_PRIV/20220404-021519
        git checkout b240672cd1f8018bc9aa17c50d9e2500db397d23
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash net/wireless/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/wireless/wext-core.c: In function 'wireless_process_ioctl':
>> net/wireless/wext-core.c:941:38: error: 'struct net_device' has no member named 'wireless_handlers'
     941 |         if (cmd == SIOCGIWPRIV && dev->wireless_handlers)
         |                                      ^~
--
   net/wireless/wext-spy.c: In function 'get_spydata':
>> net/wireless/wext-spy.c:21:16: error: 'struct net_device' has no member named 'wireless_data'
      21 |         if (dev->wireless_data)
         |                ^~
   net/wireless/wext-spy.c:22:27: error: 'struct net_device' has no member named 'wireless_data'
      22 |                 return dev->wireless_data->spy_data;
         |                           ^~
--
   net/wireless/wext-priv.c: In function 'iw_handler_get_private':
>> net/wireless/wext-priv.c:22:17: error: 'struct net_device' has no member named 'wireless_handlers'
      22 |         if ((dev->wireless_handlers->num_private_args == 0) ||
         |                 ^~
   net/wireless/wext-priv.c:23:16: error: 'struct net_device' has no member named 'wireless_handlers'
      23 |            (dev->wireless_handlers->private_args == NULL))
         |                ^~
   net/wireless/wext-priv.c:27:36: error: 'struct net_device' has no member named 'wireless_handlers'
      27 |         if (wrqu->data.length < dev->wireless_handlers->num_private_args) {
         |                                    ^~
   net/wireless/wext-priv.c:31:40: error: 'struct net_device' has no member named 'wireless_handlers'
      31 |                 wrqu->data.length = dev->wireless_handlers->num_private_args;
         |                                        ^~
   net/wireless/wext-priv.c:36:32: error: 'struct net_device' has no member named 'wireless_handlers'
      36 |         wrqu->data.length = dev->wireless_handlers->num_private_args;
         |                                ^~
   net/wireless/wext-priv.c:39:26: error: 'struct net_device' has no member named 'wireless_handlers'
      39 |         memcpy(extra, dev->wireless_handlers->private_args,
         |                          ^~
   net/wireless/wext-priv.c: In function 'get_priv_descr_and_size':
   net/wireless/wext-priv.c:100:28: error: 'struct net_device' has no member named 'wireless_handlers'
     100 |         for (i = 0; i < dev->wireless_handlers->num_private_args; i++) {
         |                            ^~
   net/wireless/wext-priv.c:101:31: error: 'struct net_device' has no member named 'wireless_handlers'
     101 |                 if (cmd == dev->wireless_handlers->private_args[i].cmd) {
         |                               ^~
   net/wireless/wext-priv.c:102:37: error: 'struct net_device' has no member named 'wireless_handlers'
     102 |                         descr = &dev->wireless_handlers->private_args[i];
         |                                     ^~


vim +941 net/wireless/wext-core.c

^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  912  
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  913  /*
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  914   * Main IOCTl dispatcher.
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  915   * Check the type of IOCTL and call the appropriate wrapper...
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  916   */
4f39a1f5870104 net/wireless/wext-core.c Johannes Berg   2017-06-14  917  static int wireless_process_ioctl(struct net *net, struct iwreq *iwr,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  918  				  unsigned int cmd,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  919  				  struct iw_request_info *info,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  920  				  wext_ioctl_func standard,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  921  				  wext_ioctl_func private)
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  922  {
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  923  	struct net_device *dev;
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  924  	iw_handler	handler;
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  925  
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  926  	/* Permissions are already checked in dev_ioctl() before calling us.
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  927  	 * The copy_to/from_user() of ifr is also dealt with in there */
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  928  
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  929  	/* Make sure the device exist */
4f39a1f5870104 net/wireless/wext-core.c Johannes Berg   2017-06-14  930  	if ((dev = __dev_get_by_name(net, iwr->ifr_name)) == NULL)
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  931  		return -ENODEV;
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  932  
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  933  	/* A bunch of special cases, then the generic case...
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  934  	 * Note that 'cmd' is already filtered in dev_ioctl() with
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  935  	 * (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) */
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  936  	if (cmd == SIOCGIWSTATS)
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  937  		return standard(dev, iwr, cmd, info,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  938  				&iw_handler_get_iwstats);
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  939  
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  940  #ifdef CONFIG_WEXT_PRIV
dd8ceabcd10d47 net/wireless/wext.c      Johannes Berg   2007-04-26 @941  	if (cmd == SIOCGIWPRIV && dev->wireless_handlers)
0f5cabba49021d net/wireless/wext.c      David S. Miller 2008-06-03  942  		return standard(dev, iwr, cmd, info,
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  943  				iw_handler_get_private);
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  944  #endif
dd8ceabcd10d47 net/wireless/wext.c      Johannes Berg   2007-04-26  945  
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  946  	/* Basic check */
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  947  	if (!netif_device_present(dev))
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  948  		return -ENODEV;
dd8ceabcd10d47 net/wireless/wext.c      Johannes Berg   2007-04-26  949  
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  950  	/* New driver API : try to find the handler */
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  951  	handler = get_handler(dev, cmd);
dd8ceabcd10d47 net/wireless/wext.c      Johannes Berg   2007-04-26  952  	if (handler) {
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  953  		/* Standard and private are not the same */
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  954  		if (cmd < SIOCIWFIRSTPRIV)
0f5cabba49021d net/wireless/wext.c      David S. Miller 2008-06-03  955  			return standard(dev, iwr, cmd, info, handler);
3d23e349d80717 net/wireless/wext-core.c Johannes Berg   2009-09-29  956  		else if (private)
0f5cabba49021d net/wireless/wext.c      David S. Miller 2008-06-03  957  			return private(dev, iwr, cmd, info, handler);
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  958  	}
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  959  	return -EOPNOTSUPP;
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  960  }
^1da177e4c3f41 net/core/wireless.c      Linus Torvalds  2005-04-16  961  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
