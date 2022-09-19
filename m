Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06615BD29B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiISQy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISQyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 12:54:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB6BA47B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663606490; x=1695142490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3MWWzyRyQ+kTTQDmRGiPgqrzBx44u3VDLKYzByz2VM=;
  b=oFPzLKeiIuE8r7Ae1kRSMRGSBL2r9HoBen8gT0yA7ncYUNAfzOpi0XgU
   /k3Oa/yFEaL9N5/Qi46rr4DYTB00Mdu0gHGDBm/M70yNwc7Q7hGGM9xx6
   AVsBgT27PpUoHiCmEu8HuMFZblskdvJmxXAFJsTfCthlxW+eDs3ogjQKz
   YEBNPalMY6k1Up7wdErsJCmvS6IjIeW7SearPJrOMkSIxvO/dol8I5p2R
   rAHXYc8jCMtA2UIwFNDWIUFP6gIxRjIq3krQ4yoqRdjI0qYX9NjoS5ZcX
   +8HO2pdohnHG8eJv+FGysBSxWtMMAhfoDgZi0juikb27YzqluF9ioehBV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300273198"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="300273198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 09:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="596158746"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2022 09:54:47 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaK2h-00026z-0D;
        Mon, 19 Sep 2022 16:54:47 +0000
Date:   Tue, 20 Sep 2022 00:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     kbuild-all@lists.01.org, Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 10/16] rt2x00: add TX LOFT calibration for MT7620
Message-ID: <202209200029.jYBBo5kD-lkp@intel.com>
References: <dc196a577619af47eb759099e7a7cdbda9f7ce5f.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc196a577619af47eb759099e7a7cdbda9f7ce5f.1663431288.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: x86_64-randconfig-s021-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200029.jYBBo5kD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/40cb92749cf8545acfa03c180c973181abed168c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Golle/rt2x00-OpenWrt-patches-improving-MT7620/20220918-005109
        git checkout 40cb92749cf8545acfa03c180c973181abed168c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/ralink/rt2x00/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9509:6: sparse: sparse: symbol 'rt2800_loft_iq_calibration' was not declared. Should it be static?
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10765:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10765:39: sparse:     expected unsigned int [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10765:39: sparse:     got restricted __le32 [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10767:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10767:43: sparse:     expected unsigned int [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10767:43: sparse:     got restricted __le32 [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10769:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10769:43: sparse:     expected unsigned int [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10769:43: sparse:     got restricted __le32 [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10771:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10771:43: sparse:     expected unsigned int [usertype]
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10771:43: sparse:     got restricted __le32 [usertype]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
