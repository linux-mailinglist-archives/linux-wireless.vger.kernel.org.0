Return-Path: <linux-wireless+bounces-18654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545AA2D7FC
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 19:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9AE166377
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A124111B;
	Sat,  8 Feb 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/6A/C8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E724111C
	for <linux-wireless@vger.kernel.org>; Sat,  8 Feb 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739038544; cv=none; b=lW4L1DBDXkIJYoEkhzcNDXoJt9COGi+zusHovKS3AqnigYw2pGcz7envyWUhfnndgeTN17ya4zwDKbHPtd2tPfjCATV7MRm5GylnMdNHgLOumi11wGm3zVGkU/a6B4OI1SjGpHKnPFDigPnHZRnDDkebwhVi7Oh0D5pKZNDzLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739038544; c=relaxed/simple;
	bh=JhlPtXpJUKq8YkpZhW4KEnNGOc3+W5nAxp0WPvcA3H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUOhmClBOeP4MhjTVUnDwel9fagx7B9+lJvKLQOZ0v/cguGOdl/Ww5+fl8kgUr3LTQjcQg/1c+MPIBdMSFLYuOmZomJgbWQUbLiDVlQ8AM6zbEuXNr9CSb1mgqRQ/JUXXTVASkiHFIvXv/oN6ECbUvxboEGzFbPpP1RVJ3odlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/6A/C8G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739038543; x=1770574543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JhlPtXpJUKq8YkpZhW4KEnNGOc3+W5nAxp0WPvcA3H0=;
  b=H/6A/C8G47i75kKa+H7o+ci0BL0jzmvTMuNhQxwQH3phycmdgKihtOKw
   X+uualCxw0HYATwZcWfSexXG1ie42SloOG/ODCRNuERlB1Izo9wRHgLzx
   rNg1HRZZKcRU7pNQGDDGViZ+xc2nqpUvU/grAdMDizsCHMtZpbhg84MXw
   6CTKojIFA19GnEwTUQM0aeC6oOBGRFMaR3t8ZP1b7k53tbBEg2JXOZT21
   GXyERKmLninvKTSSQvp0Akk5aH3h4nUeMO99sqQFFWa94Le2CPaIljksk
   mYA1ygTvF/DYoH0ODHdtuKLI8q7q7h0C36XR0ww1NIoLJv+GnkQO3dCQZ
   w==;
X-CSE-ConnectionGUID: quHAUrssQnSgzcEpWM59XA==
X-CSE-MsgGUID: tod4LBBXTKOK2vUGVZMImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="43325124"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="43325124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 10:15:42 -0800
X-CSE-ConnectionGUID: vdKkOMaDSp2tQafImAOQ8w==
X-CSE-MsgGUID: MpH5rHbeR56r7mrgJdw4XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="112023278"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Feb 2025 10:15:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgpMg-0010Tv-2F;
	Sat, 08 Feb 2025 18:15:38 +0000
Date: Sun, 9 Feb 2025 02:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
	ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Sriram R <quic_srirrama@quicinc.com>,
	Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Subject: Re: [PATCH v2 1/3] wifi: ath12k: Fix the enabling of REO queue
 lookup table feature
Message-ID: <202502090206.lIwUMGJF-lkp@intel.com>
References: <20250207173023.3856217-2-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207173023.3856217-2-quic_nithp@quicinc.com>

Hi Nithyanantham,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 48a62436540224f57013c27519dd2aa3ddd714c9]

url:    https://github.com/intel-lab-lkp/linux/commits/Nithyanantham-Paramasivam/wifi-ath12k-Fix-the-enabling-of-REO-queue-lookup-table-feature/20250208-013400
base:   48a62436540224f57013c27519dd2aa3ddd714c9
patch link:    https://lore.kernel.org/r/20250207173023.3856217-2-quic_nithp%40quicinc.com
patch subject: [PATCH v2 1/3] wifi: ath12k: Fix the enabling of REO queue lookup table feature
config: i386-randconfig-063-20250208 (https://download.01.org/0day-ci/archive/20250209/202502090206.lIwUMGJF-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090206.lIwUMGJF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090206.lIwUMGJF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/dp.c:1660:30: warning: shift count is negative [-Wshift-count-negative]
    1660 |                            ((dp->reoq_lut.paddr & HAL_REO_QLUT_REG_BASE_ADDR) >> 8));
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/hal.h:328:38: note: expanded from macro 'HAL_REO_QLUT_REG_BASE_ADDR'
     328 | #define HAL_REO_QLUT_REG_BASE_ADDR                      GENMASK(39, 8)
         |                                                         ^~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/dp.c:1663:33: warning: shift count is negative [-Wshift-count-negative]
    1663 |                            ((dp->ml_reoq_lut.paddr & HAL_REO_QLUT_REG_BASE_ADDR) >> 8));
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/hal.h:328:38: note: expanded from macro 'HAL_REO_QLUT_REG_BASE_ADDR'
     328 | #define HAL_REO_QLUT_REG_BASE_ADDR                      GENMASK(39, 8)
         |                                                         ^~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +1660 drivers/net/wireless/ath/ath12k/dp.c

  1628	
  1629	static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
  1630	{
  1631		struct ath12k_dp *dp = &ab->dp;
  1632		u32 val;
  1633		int ret;
  1634	
  1635		if (!ab->hw_params->reoq_lut_support)
  1636			return 0;
  1637	
  1638		ret = ath12k_dp_alloc_reoq_lut(ab, &dp->reoq_lut);
  1639		if (ret) {
  1640			ath12k_warn(ab, "failed to allocate memory for reoq table");
  1641			return ret;
  1642		}
  1643	
  1644		ret = ath12k_dp_alloc_reoq_lut(ab, &dp->ml_reoq_lut);
  1645		if (ret) {
  1646			ath12k_warn(ab, "failed to allocate memory for ML reoq table");
  1647			dma_free_coherent(ab->dev, dp->reoq_lut.size,
  1648					  dp->reoq_lut.vaddr_unaligned,
  1649					  dp->reoq_lut.paddr_unaligned);
  1650			dp->reoq_lut.vaddr_unaligned = NULL;
  1651			return ret;
  1652		}
  1653	
  1654		/* Bits in the register have address [39:8] LUT base address to be
  1655		 * allocated such that LSBs are assumed to be zero. Also, current
  1656		 * design supports paddr upto 4 GB max hence it fits in 32 bit register only
  1657		 */
  1658	
  1659		ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
> 1660				   ((dp->reoq_lut.paddr & HAL_REO_QLUT_REG_BASE_ADDR) >> 8));
  1661	
  1662		ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(ab),
  1663				   ((dp->ml_reoq_lut.paddr & HAL_REO_QLUT_REG_BASE_ADDR) >> 8));
  1664	
  1665		val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab));
  1666	
  1667		ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_ADDR(ab),
  1668				   val | HAL_REO_QDESC_ADDR_READ_LUT_ENABLE);
  1669	
  1670		ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_MAX_PEERID(ab),
  1671				   HAL_REO_QDESC_MAX_PEERID);
  1672	
  1673		return 0;
  1674	}
  1675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

