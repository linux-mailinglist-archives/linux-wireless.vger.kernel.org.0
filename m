Return-Path: <linux-wireless+bounces-29644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A8CB49DC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 04:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3709E300B298
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC41E00B4;
	Thu, 11 Dec 2025 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RipdgCOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5003433A6;
	Thu, 11 Dec 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423114; cv=none; b=mCFHR4+66cSQ3aRFUimhenltphqSPyUy2h3FUz7g8aaHXmFrjqdU9oemezm7hzrMmhVX8q2UHMnMwIQSpMz64/k2FJFwpkKVZPT/hmyMC9ZumQswAvwGm/tu95gjkGi6nG4Q9NGWyy3Q9v3XtIF5l1loCyt7d8NkXgo2WmAYfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423114; c=relaxed/simple;
	bh=ZCJsSyKpFDGI4enSrr3CZY9EUTvp8kqs7B1Bpl9BdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9SDzg05zQsffgkh/p79esNZeC21R8vOPCTppn5ujj8SH2KGDu7lgraZB3qvS00qGeYrSJT0V7bfpoSEHXiLTjz/8we9Jm+wjVO2D7YhvC988WpBU/OepRTivYpbBMBBA9coSfmoiOtbF8iz9bIRb+WgflADjhKhfNz2e8u9kFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RipdgCOh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765423113; x=1796959113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZCJsSyKpFDGI4enSrr3CZY9EUTvp8kqs7B1Bpl9BdAM=;
  b=RipdgCOhjctGMvz/5VM/DDnpUuE1MFfV6CJUhE0RqeRLuvxV7/GxASFM
   9wUoZ4jPyfqxcphHYUzknkyWdANYv7rJd3afVmkofXygYZqKx3ssSIj3F
   TiFdz/iOy9xNai/X2tLm/nPgkM0UbjqzfR8fkmQi1KxX8u+PECz92zXgj
   Q9i+S8c4HOzbU8MZJbs136Xyf9HNjhWa4lhyjiEE3qAkOi8bNRhNTGDp2
   UP8ldJ0a7EdYYmBEJWly+pR8x5WhuVeyVznESbQq0oHqeERGtuWW85a+F
   IS68k0bWmKiRSYNK8lFQ6RpcFE6K+3oSVzJzjYeosiy2mgDmU4i33gaLw
   w==;
X-CSE-ConnectionGUID: eKfbgLSwQP2q1P3v9Jl++A==
X-CSE-MsgGUID: 52lxU+39TTe51Yrz0UrRXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78104552"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="78104552"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 19:18:32 -0800
X-CSE-ConnectionGUID: dbsS4O/OSVOimLjRfVIMRQ==
X-CSE-MsgGUID: cKn7PKfGT1WYgz/AmLdxnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="220033324"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Dec 2025 19:18:30 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTXCF-00000000461-33tO;
	Thu, 11 Dec 2025 03:18:27 +0000
Date: Thu, 11 Dec 2025 11:17:52 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, ath11k@lists.infradead.org,
	Jeff Johnson <jjohnson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
Message-ID: <202512111054.OwS5ClW9-lkp@intel.com>
References: <20251210024036.3965135-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210024036.3965135-1-mr.nuke.me@gmail.com>

Hi Alexandru,

kernel test robot noticed the following build errors:

[auto build test ERROR on ath/ath-next]
[also build test ERROR on linus/master v6.18 next-20251210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Gagniuc/wifi-ath11k-move-max_tx_ring-to-struct-ath11k_hw_hal_params/20251210-104321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20251210024036.3965135-1-mr.nuke.me%40gmail.com
patch subject: [PATCH] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20251211/202512111054.OwS5ClW9-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6ec8c4351cfc1d0627d1633b02ea787bd29c77d8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512111054.OwS5ClW9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512111054.OwS5ClW9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/debugfs.c:710:32: error: no member named 'max_tx_ring' in 'struct ath11k_hw_params'
     710 |         for (i = 0; i < ab->hw_params.max_tx_ring; i++)
         |                         ~~~~~~~~~~~~~ ^
   1 error generated.


vim +710 drivers/net/wireless/ath/ath11k/debugfs.c

da3a9d3c15769b Kalle Valo    2020-09-16  657  
cb4e57db2ff0c8 Kalle Valo    2020-09-16  658  static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
da3a9d3c15769b Kalle Valo    2020-09-16  659  						char __user *user_buf,
da3a9d3c15769b Kalle Valo    2020-09-16  660  						size_t count, loff_t *ppos)
da3a9d3c15769b Kalle Valo    2020-09-16  661  {
da3a9d3c15769b Kalle Valo    2020-09-16  662  	struct ath11k_base *ab = file->private_data;
da3a9d3c15769b Kalle Valo    2020-09-16  663  	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
da3a9d3c15769b Kalle Valo    2020-09-16  664  	int len = 0, i, retval;
da3a9d3c15769b Kalle Valo    2020-09-16  665  	const int size = 4096;
da3a9d3c15769b Kalle Valo    2020-09-16  666  	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
da3a9d3c15769b Kalle Valo    2020-09-16  667  			"Overflow", "MPDU len", "FCS", "Decrypt", "TKIP MIC",
da3a9d3c15769b Kalle Valo    2020-09-16  668  			"Unencrypt", "MSDU len", "MSDU limit", "WiFi parse",
da3a9d3c15769b Kalle Valo    2020-09-16  669  			"AMSDU parse", "SA timeout", "DA timeout",
da3a9d3c15769b Kalle Valo    2020-09-16  670  			"Flow timeout", "Flush req"};
da3a9d3c15769b Kalle Valo    2020-09-16  671  	static const char *reo_err[HAL_REO_DEST_RING_ERROR_CODE_MAX] = {
da3a9d3c15769b Kalle Valo    2020-09-16  672  			"Desc addr zero", "Desc inval", "AMPDU in non BA",
da3a9d3c15769b Kalle Valo    2020-09-16  673  			"Non BA dup", "BA dup", "Frame 2k jump", "BAR 2k jump",
da3a9d3c15769b Kalle Valo    2020-09-16  674  			"Frame OOR", "BAR OOR", "No BA session",
da3a9d3c15769b Kalle Valo    2020-09-16  675  			"Frame SN equal SSN", "PN check fail", "2k err",
da3a9d3c15769b Kalle Valo    2020-09-16  676  			"PN err", "Desc blocked"};
da3a9d3c15769b Kalle Valo    2020-09-16  677  
da3a9d3c15769b Kalle Valo    2020-09-16  678  	char *buf;
da3a9d3c15769b Kalle Valo    2020-09-16  679  
da3a9d3c15769b Kalle Valo    2020-09-16  680  	buf = kzalloc(size, GFP_KERNEL);
da3a9d3c15769b Kalle Valo    2020-09-16  681  	if (!buf)
da3a9d3c15769b Kalle Valo    2020-09-16  682  		return -ENOMEM;
da3a9d3c15769b Kalle Valo    2020-09-16  683  
da3a9d3c15769b Kalle Valo    2020-09-16  684  	len += scnprintf(buf + len, size - len, "SOC RX STATS:\n\n");
da3a9d3c15769b Kalle Valo    2020-09-16  685  	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
da3a9d3c15769b Kalle Valo    2020-09-16  686  			 soc_stats->err_ring_pkts);
da3a9d3c15769b Kalle Valo    2020-09-16  687  	len += scnprintf(buf + len, size - len, "Invalid RBM: %u\n\n",
da3a9d3c15769b Kalle Valo    2020-09-16  688  			 soc_stats->invalid_rbm);
da3a9d3c15769b Kalle Valo    2020-09-16  689  	len += scnprintf(buf + len, size - len, "RXDMA errors:\n");
da3a9d3c15769b Kalle Valo    2020-09-16  690  	for (i = 0; i < HAL_REO_ENTR_RING_RXDMA_ECODE_MAX; i++)
da3a9d3c15769b Kalle Valo    2020-09-16  691  		len += scnprintf(buf + len, size - len, "%s: %u\n",
da3a9d3c15769b Kalle Valo    2020-09-16  692  				 rxdma_err[i], soc_stats->rxdma_error[i]);
da3a9d3c15769b Kalle Valo    2020-09-16  693  
da3a9d3c15769b Kalle Valo    2020-09-16  694  	len += scnprintf(buf + len, size - len, "\nREO errors:\n");
da3a9d3c15769b Kalle Valo    2020-09-16  695  	for (i = 0; i < HAL_REO_DEST_RING_ERROR_CODE_MAX; i++)
da3a9d3c15769b Kalle Valo    2020-09-16  696  		len += scnprintf(buf + len, size - len, "%s: %u\n",
da3a9d3c15769b Kalle Valo    2020-09-16  697  				 reo_err[i], soc_stats->reo_error[i]);
da3a9d3c15769b Kalle Valo    2020-09-16  698  
da3a9d3c15769b Kalle Valo    2020-09-16  699  	len += scnprintf(buf + len, size - len, "\nHAL REO errors:\n");
da3a9d3c15769b Kalle Valo    2020-09-16  700  	len += scnprintf(buf + len, size - len,
da3a9d3c15769b Kalle Valo    2020-09-16  701  			 "ring0: %u\nring1: %u\nring2: %u\nring3: %u\n",
da3a9d3c15769b Kalle Valo    2020-09-16  702  			 soc_stats->hal_reo_error[0],
da3a9d3c15769b Kalle Valo    2020-09-16  703  			 soc_stats->hal_reo_error[1],
da3a9d3c15769b Kalle Valo    2020-09-16  704  			 soc_stats->hal_reo_error[2],
da3a9d3c15769b Kalle Valo    2020-09-16  705  			 soc_stats->hal_reo_error[3]);
da3a9d3c15769b Kalle Valo    2020-09-16  706  
da3a9d3c15769b Kalle Valo    2020-09-16  707  	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
da3a9d3c15769b Kalle Valo    2020-09-16  708  	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
da3a9d3c15769b Kalle Valo    2020-09-16  709  
31582373a4a8e8 Baochen Qiang 2021-10-11 @710  	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
da3a9d3c15769b Kalle Valo    2020-09-16  711  		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
da3a9d3c15769b Kalle Valo    2020-09-16  712  				 i, soc_stats->tx_err.desc_na[i]);
da3a9d3c15769b Kalle Valo    2020-09-16  713  
da3a9d3c15769b Kalle Valo    2020-09-16  714  	len += scnprintf(buf + len, size - len,
da3a9d3c15769b Kalle Valo    2020-09-16  715  			 "\nMisc Transmit Failures: %d\n",
da3a9d3c15769b Kalle Valo    2020-09-16  716  			 atomic_read(&soc_stats->tx_err.misc_fail));
da3a9d3c15769b Kalle Valo    2020-09-16  717  
cb4e57db2ff0c8 Kalle Valo    2020-09-16  718  	len += ath11k_debugfs_dump_soc_ring_bp_stats(ab, buf + len, size - len);
da3a9d3c15769b Kalle Valo    2020-09-16  719  
da3a9d3c15769b Kalle Valo    2020-09-16  720  	if (len > size)
da3a9d3c15769b Kalle Valo    2020-09-16  721  		len = size;
da3a9d3c15769b Kalle Valo    2020-09-16  722  	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
da3a9d3c15769b Kalle Valo    2020-09-16  723  	kfree(buf);
da3a9d3c15769b Kalle Valo    2020-09-16  724  
da3a9d3c15769b Kalle Valo    2020-09-16  725  	return retval;
da3a9d3c15769b Kalle Valo    2020-09-16  726  }
da3a9d3c15769b Kalle Valo    2020-09-16  727  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

