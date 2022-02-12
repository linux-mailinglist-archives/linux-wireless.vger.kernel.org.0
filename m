Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40EF4B370F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiBLSSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 13:18:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBLSSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 13:18:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAE5E768
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644689893; x=1676225893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DbBWKQigkVd4E7a1OuNYzPs+0CB6gRd1vWjot3q/liA=;
  b=WOj8DZSgWCYRGnI2XbWJnRF6uHqCyKROO4Cq0eD3lFIbnYcl0CuHQ3jh
   DanxDEboF3hCt8I7KDNutyqHZmbqXiqWVZb2/mMGHTstN2to2IO/ahqen
   PzN6TyTksmu/fOE8e5LDrIrtDxoJ8RZO8IphX+r1M+bKZIvOOdvvDPxLX
   HGTs9zpxdseCo1+uHG64Typ9hnets10hWz15rYzu+COqXfHBjE2nQY6Pm
   3rWbFktgusYVmmripcBLcWkEH+1VVL/LWQl5hjKzflqDbcHa9kx+RGhyk
   N4UGVWX0LNV9zA+Vw3TYTIxRhV/dIDX9VfcjBD70olog004kWicjoCR+z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="313177327"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="313177327"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 10:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="602655568"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2022 10:18:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIwyI-0006Ub-2s; Sat, 12 Feb 2022 18:18:10 +0000
Date:   Sun, 13 Feb 2022 02:17:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCH 2/6] ath11k: CFR module initialization and
 deinitialization for IPQ8074
Message-ID: <202202122308.vnm0MdO3-lkp@intel.com>
References: <1644592075-27082-3-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644592075-27082-3-git-send-email-quic_vnaralas@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Venkateswara,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvalo-ath/ath-next]
[cannot apply to wireless-next/main wireless/main jberg-mac80211-next/master jberg-mac80211/master v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Venkateswara-Naralasetty/ath11k-add-single-shot-periodic-CFR-capture-support-for-IPQ8074/20220211-230911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220212/202202122308.vnm0MdO3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d2559d5e11b6761fa81c7b6a5dcd1f506f72ef96
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Venkateswara-Naralasetty/ath11k-add-single-shot-periodic-CFR-capture-support-for-IPQ8074/20220211-230911
        git checkout d2559d5e11b6761fa81c7b6a5dcd1f506f72ef96
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/ drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/cfr.c:29:6: warning: no previous prototype for function 'ath11k_cfr_ring_free' [-Wmissing-prototypes]
   void ath11k_cfr_ring_free(struct ath11k *ar)
        ^
   drivers/net/wireless/ath/ath11k/cfr.c:29:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ath11k_cfr_ring_free(struct ath11k *ar)
   ^
   static 
   1 warning generated.


vim +/ath11k_cfr_ring_free +29 drivers/net/wireless/ath/ath11k/cfr.c

    28	
  > 29	void ath11k_cfr_ring_free(struct ath11k *ar)
    30	{
    31		struct ath11k_cfr *cfr = &ar->cfr;
    32	
    33		ath11k_dbring_buf_cleanup(ar, &cfr->rx_ring);
    34		ath11k_dbring_srng_cleanup(ar, &cfr->rx_ring);
    35	}
    36	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
