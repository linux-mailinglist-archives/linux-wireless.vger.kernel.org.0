Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43CE6CBA5F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC1JWC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjC1JWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 05:22:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF915252
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679995320; x=1711531320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpBwDm3bc0RVrygPOMQqxYOOiHUF9v3KqPn1PaW6G9U=;
  b=TRNDLsKYs0vMdaeSoLfsJQxNMl/nsMms6sSnYA5lKL5dhb0VP5W7bgjD
   p7n+LI6Z+koLr5oyQxzs0TDwH9O83M/mR4plkRND8CLj5QeIZ0FZ/Cn0O
   fZwm/ATKL3/KWrj+T2Jcfwu+gxFRSpxAPJzwoU+nMlb4Yy4lg/dyTJ7X9
   +X1Bnjp4Ucv3caLsbrU0pFFtn+3xSfS4G929yklLv//8/9eAxj+JG2PlK
   uWwuVq4qZnNrnVzjKGuvL0kW5AOByggY9sCs8lxFIPRKUTJZJR2+Lhw+A
   srNybyQAf4mkqZIBOmuO/5WXr3WsG/puxNSTiuzKnXtOm9s6O4pSE2zIs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320168601"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="320168601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 02:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="753067433"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="753067433"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2023 02:21:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph5Wf-000IQm-2l;
        Tue, 28 Mar 2023 09:21:57 +0000
Date:   Tue, 28 Mar 2023 17:21:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: skip status ring entry processing
Message-ID: <202303281719.CvnPkOiK-lkp@intel.com>
References: <20230328071814.13018-1-quic_tamizhr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328071814.13018-1-quic_tamizhr@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tamizh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bea046575a2e6d7d1cf63cc7ab032647a3585de5]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamizh-Chelvam-Raja/wifi-ath11k-skip-status-ring-entry-processing/20230328-151947
base:   bea046575a2e6d7d1cf63cc7ab032647a3585de5
patch link:    https://lore.kernel.org/r/20230328071814.13018-1-quic_tamizhr%40quicinc.com
patch subject: [PATCH] wifi: ath11k: skip status ring entry processing
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230328/202303281719.CvnPkOiK-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c6e8f81ccc1ac66cdf84bc9bbe71993ffd267677
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tamizh-Chelvam-Raja/wifi-ath11k-skip-status-ring-entry-processing/20230328-151947
        git checkout c6e8f81ccc1ac66cdf84bc9bbe71993ffd267677
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303281719.CvnPkOiK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/dp_rx.c:2964:1: warning: no previous prototype for 'ath11k_dp_rx_mon_handle_status_buf_done' [-Wmissing-prototypes]
    2964 | ath11k_dp_rx_mon_handle_status_buf_done(struct ath11k_base *ab, struct hal_srng *srng,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ath11k_dp_rx_mon_handle_status_buf_done +2964 drivers/net/wireless/ath/ath11k/dp_rx.c

  2962	
  2963	enum dp_mon_status_buf_state
> 2964	ath11k_dp_rx_mon_handle_status_buf_done(struct ath11k_base *ab, struct hal_srng *srng,
  2965						struct dp_rxdma_ring *rx_ring)
  2966	{
  2967		void *status_desc;
  2968		struct sk_buff *skb;
  2969		struct ath11k_skb_rxcb *rxcb;
  2970		struct hal_tlv_hdr *tlv;
  2971		dma_addr_t paddr;
  2972		u32 cookie;
  2973		int buf_id;
  2974		u8 rbm;
  2975	
  2976		status_desc = ath11k_hal_srng_src_next_peek(ab, srng);
  2977		if (!status_desc)
  2978			return DP_MON_STATUS_NO_DMA;
  2979	
  2980		ath11k_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
  2981	
  2982		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID, cookie);
  2983	
  2984		spin_lock_bh(&rx_ring->idr_lock);
  2985		skb = idr_find(&rx_ring->bufs_idr, buf_id);
  2986		spin_unlock_bh(&rx_ring->idr_lock);
  2987	
  2988		if (!skb)
  2989			return DP_MON_STATUS_NO_DMA;
  2990	
  2991		rxcb = ATH11K_SKB_RXCB(skb);
  2992		dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
  2993					skb->len + skb_tailroom(skb),
  2994					DMA_FROM_DEVICE);
  2995	
  2996		tlv = (struct hal_tlv_hdr *)skb->data;
  2997		if (FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl) != HAL_RX_STATUS_BUFFER_DONE)
  2998			return DP_MON_STATUS_NO_DMA;
  2999	
  3000		return DP_MON_STATUS_REPLINISH;
  3001	}
  3002	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
