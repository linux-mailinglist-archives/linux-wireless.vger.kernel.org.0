Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227D4B2CFD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351978AbiBKSbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 13:31:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiBKSbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 13:31:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E91184
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 10:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644604264; x=1676140264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQyxWsPv1BNMrPsxnp08a5RWi5luBTZOV6PLZkuqVL8=;
  b=GqhlcNxeYGaBcRbPnGI0q5z5FWQIhUAmUHSYup2UentG+gixinpsM/vy
   4f4Cg1Z5yW62QQFy5bkhI8iHfGsDUgB1kEZVll4ZXW5vcxr9mJK814xRk
   jOUSu/0cPSRnLk5DDlxBR2UUJwAvwo1tYCXnD5LVlNsjCEFby6rdnbGpw
   QX5Y98VLrIjK3i0YxDWd9mB6wWUMZlHTIDq/2m3G3QY44bkYo/QCEE25J
   0uzaVXO/jawP1O1ldZ6kmC+E/an6xBzDF//iXdwZQdC5qN8BaalwcIs13
   qrBeu6bzq4WijUxfKgrV0C5JVDmDO3guoKRSGlqCwDN7LFY20eTqOIlZ6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="274344813"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="274344813"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="569114788"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2022 10:31:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIahC-0004zY-K7; Fri, 11 Feb 2022 18:31:02 +0000
Date:   Sat, 12 Feb 2022 02:30:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCH 2/6] ath11k: CFR module initialization and
 deinitialization for IPQ8074
Message-ID: <202202120243.5HtnZNDg-lkp@intel.com>
References: <1644592075-27082-3-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644592075-27082-3-git-send-email-quic_vnaralas@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220212/202202120243.5HtnZNDg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d2559d5e11b6761fa81c7b6a5dcd1f506f72ef96
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Venkateswara-Naralasetty/ath11k-add-single-shot-periodic-CFR-capture-support-for-IPQ8074/20220211-230911
        git checkout d2559d5e11b6761fa81c7b6a5dcd1f506f72ef96
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/cfr.c:29:6: warning: no previous prototype for 'ath11k_cfr_ring_free' [-Wmissing-prototypes]
      29 | void ath11k_cfr_ring_free(struct ath11k *ar)
         |      ^~~~~~~~~~~~~~~~~~~~


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
