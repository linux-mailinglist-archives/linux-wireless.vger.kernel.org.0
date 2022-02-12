Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5585E4B370E
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiBLSSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 13:18:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBLSSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 13:18:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B85E766
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644689892; x=1676225892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAbkx48AifVA1ZnnX3RL43UQ+rIj32/RL2V/hYG14FE=;
  b=DoZzBgd9kfLuJq71zv8NLteiyiXAKf7Qda41R8Cr0SuEC4g4H6B2325M
   qwNO0sC7YEIHM4cQW0HC/Da34DSZC+xG5zvIuYogtQlpXvV/+3A/deX0a
   gRAxcK0UDbdYPukWoRpMwAxn5dm3SZ/WypUT5hP1sbwhBrXwwb/3sLW58
   AsyxGvNHIMZAF0D7AalQzybUPTgVbscaAhuDwBZ2G+GGVoAxR5KVgNXh4
   YzYqODVWmbh9ELXM6UeWHkC8sD+SMqYhD/fE7oV2cvhofnZJdIFjBEUjD
   rOOMkjLeKqXQ0fJbBmBr3BaWHKSrDE0+ZMkHlyDR8f1CiJs5W0jTKQr6F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="250103115"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="250103115"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 10:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="623510180"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2022 10:18:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIwyI-0006UY-2J; Sat, 12 Feb 2022 18:18:10 +0000
Date:   Sun, 13 Feb 2022 02:17:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCH 5/6] ath11k: Register DBR event handler for CFR data
Message-ID: <202202130103.qvrDOuTL-lkp@intel.com>
References: <1644592075-27082-6-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644592075-27082-6-git-send-email-quic_vnaralas@quicinc.com>
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

Hi Venkateswara,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvalo-ath/ath-next]
[cannot apply to wireless-next/main wireless/main jberg-mac80211-next/master jberg-mac80211/master v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Venkateswara-Naralasetty/ath11k-add-single-shot-periodic-CFR-capture-support-for-IPQ8074/20220211-230911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220213/202202130103.qvrDOuTL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/14cd77b4e3109da2eb6b33501640153852c5d2a7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Venkateswara-Naralasetty/ath11k-add-single-shot-periodic-CFR-capture-support-for-IPQ8074/20220211-230911
        git checkout 14cd77b4e3109da2eb6b33501640153852c5d2a7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/ drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/cfr.c:40:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           case ATH11K_CFR_PREAMBLE_TYPE_HT:
           ^
   drivers/net/wireless/ath/ath11k/cfr.c:40:2: note: insert '__attribute__((fallthrough));' to silence this warning
           case ATH11K_CFR_PREAMBLE_TYPE_HT:
           ^
           __attribute__((fallthrough)); 
   drivers/net/wireless/ath/ath11k/cfr.c:40:2: note: insert 'break;' to avoid fall-through
           case ATH11K_CFR_PREAMBLE_TYPE_HT:
           ^
           break; 
   drivers/net/wireless/ath/ath11k/cfr.c:515:6: warning: no previous prototype for function 'ath11k_cfr_ring_free' [-Wmissing-prototypes]
   void ath11k_cfr_ring_free(struct ath11k *ar)
        ^
   drivers/net/wireless/ath/ath11k/cfr.c:515:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void ath11k_cfr_ring_free(struct ath11k *ar)
   ^
   static 
   2 warnings generated.


vim +40 drivers/net/wireless/ath/ath11k/cfr.c

    18	
    19	static int cfr_calculate_tones_from_dma_hdr(struct ath11k_cfir_dma_hdr *hdr)
    20	{
    21		u8 bw = FIELD_GET(CFIR_DMA_HDR_INFO1_UPLOAD_PKT_BW, hdr->info1);
    22		u8 preamble = FIELD_GET(CFIR_DMA_HDR_INFO1_PREAMBLE_TYPE, hdr->info1);
    23	
    24		switch (preamble) {
    25		case ATH11K_CFR_PREAMBLE_TYPE_LEGACY:
    26		case ATH11K_CFR_PREAMBLE_TYPE_VHT:
    27			switch (bw) {
    28			case 0:
    29				return TONES_IN_20MHZ;
    30			case 1: /* DUP40/VHT40 */
    31				return TONES_IN_40MHZ;
    32			case 2: /* DUP80/VHT80 */
    33				return TONES_IN_80MHZ;
    34			case 3: /* DUP160/VHT160 */
    35				return TONES_IN_160MHZ;
    36			default:
    37				break;
    38			}
    39	
  > 40		case ATH11K_CFR_PREAMBLE_TYPE_HT:
    41			switch (bw) {
    42			case 0:
    43				return TONES_IN_20MHZ;
    44			case 1:
    45				return TONES_IN_40MHZ;
    46			}
    47		}
    48	
    49		return TONES_INVALID;
    50	}
    51	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
