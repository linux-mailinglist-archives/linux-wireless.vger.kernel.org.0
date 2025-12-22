Return-Path: <linux-wireless+bounces-30045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A7CD59DD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A68130341DD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601233D6D9;
	Mon, 22 Dec 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXUGH507"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1832ED23;
	Mon, 22 Dec 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399158; cv=none; b=HOp0xiApUNpKBcwzWfNthe4K4IAxCHz6d70h8EfbEKiHaRfEF0xtl7ZJc8kLtMa5N9+vngnCkSdhcrnZb6YTZ7dAjYcSixwfllEmNbexJWAry9v9gcucxZl3DMChErz7lROXazG3IB5xqU7hdfDLlxLRZkJVlOXJi1oNxXwRrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399158; c=relaxed/simple;
	bh=62taOR2EI0MqLH+HSIMWwZvEtr5H5VJiNu+vI3TqvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npIqfe68igHTQQ6ZmiTJTfoLh1F1cUVB27OxCxI9u/gYIDOXaOMqqckJKUk7MBd++mSjCMj/zB2DGOzTRbBc9e6OTW9pyL3n4gQfQ8nkNSSM11kWtE+b+MLE6DPWF/zp/QMoKzLwaloPGFQE8lAHxs3CG+ajNAKHFLiJ7yOUpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXUGH507; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766399155; x=1797935155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=62taOR2EI0MqLH+HSIMWwZvEtr5H5VJiNu+vI3TqvDE=;
  b=EXUGH507ssVqSGPykHptYrKegQItq23E6Lfz35yDRQiFdg1PnXV24++k
   bbGL7PPWNEgnQQCcW/wtVdqaNOr0m9HpgTGRqGJ+XFqy35fWoexIcjxiN
   0+xECN1xOIqO7J8LCI3Aea+FbZnXYjCHbtoC+y2Y4GZWKtbKHdYN6Z2Ut
   y1eJzJGPXIHZa7GoyViVTHsQBAnErC2XeGI2Fd/pOU4BPVadqXIIAiLYt
   d50aZv7KkCyABQCpSjr2+KPHuAhrpUIMRRhNSc4JkmkbSJ2thabP6AUKl
   Zwwg82CeR3kwtATporDY7ZsCr/5yQefXjQNMoxDuPDmCkrjsS8ycFYi1j
   A==;
X-CSE-ConnectionGUID: RW42BWYrRGKuHX5EjJH5kA==
X-CSE-MsgGUID: ULpzyhL6RvKapPtdtin1zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68297226"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="68297226"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 02:25:54 -0800
X-CSE-ConnectionGUID: fAWCdZUaR5q2u7vr4ATdJQ==
X-CSE-MsgGUID: 5u0tkOQdRAmhs1RBOjgFlQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Dec 2025 02:25:51 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXd6L-000000000Nt-051A;
	Mon, 22 Dec 2025 10:25:34 +0000
Date: Mon, 22 Dec 2025 18:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>,
	Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jeff Johnson <jjohnson@kernel.org>,
	Ripan Deuri <quic_rdeuri@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
Message-ID: <202512221824.sz1jZjhH-lkp@intel.com>
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUOw1J0TU4VgeXj6@stanley.mountain>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251217]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/wifi-ath12k-clean-up-on-error-in-ath12k_dp_setup/20251218-154554
base:   next-20251217
patch link:    https://lore.kernel.org/r/aUOw1J0TU4VgeXj6%40stanley.mountain
patch subject: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20251222/202512221824.sz1jZjhH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221824.sz1jZjhH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221824.sz1jZjhH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/dp.c:1767:8: error: use of undeclared label 'rhash_destroy'
                   goto rhash_destroy;
                        ^
   1 error generated.


vim +/rhash_destroy +1767 drivers/net/wireless/ath/ath12k/dp.c

  1734	
  1735	int ath12k_dp_alloc(struct ath12k_base *ab)
  1736	{
  1737		struct ath12k_dp *dp = &ab->dp;
  1738		struct hal_srng *srng = NULL;
  1739		size_t size = 0;
  1740		u32 n_link_desc = 0;
  1741		int ret;
  1742		int i;
  1743	
  1744		dp->ab = ab;
  1745	
  1746		INIT_LIST_HEAD(&dp->reo_cmd_list);
  1747		INIT_LIST_HEAD(&dp->reo_cmd_cache_flush_list);
  1748		INIT_LIST_HEAD(&dp->reo_cmd_update_rx_queue_list);
  1749		spin_lock_init(&dp->reo_cmd_lock);
  1750		spin_lock_init(&dp->reo_rxq_flush_lock);
  1751	
  1752		dp->reo_cmd_cache_flush_count = 0;
  1753		dp->idle_link_rbm = ath12k_dp_get_idle_link_rbm(ab);
  1754	
  1755		ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
  1756		if (ret) {
  1757			ath12k_warn(ab, "failed to setup wbm_idle_ring: %d\n", ret);
  1758			return ret;
  1759		}
  1760	
  1761		srng = &ab->hal.srng_list[dp->wbm_idle_ring.ring_id];
  1762	
  1763		ret = ath12k_dp_link_desc_setup(ab, dp->link_desc_banks,
  1764						HAL_WBM_IDLE_LINK, srng, n_link_desc);
  1765		if (ret) {
  1766			ath12k_warn(ab, "failed to setup link desc: %d\n", ret);
> 1767			goto rhash_destroy;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

