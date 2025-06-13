Return-Path: <linux-wireless+bounces-24089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2F7AD8974
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 12:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB61E03E6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E12D1F5F;
	Fri, 13 Jun 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNnTdce/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B72C159E;
	Fri, 13 Jun 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810256; cv=none; b=kfAyfa2RDg3DaDo1EUhIkkXxH5gGres/Ci4MAzNkA8joEAMofj+Q1UzpSypxGp62/zJ5yJLFg/Id5pdaNHHGhkIS2Wio5lY9ALOAaTyyXubIW2WBzcBkkEIFuuLZAUGmYqaGusazapjBtpRYL0Mq80UitHUEz+EmzPdlOb0DWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810256; c=relaxed/simple;
	bh=2iDnlk7mOj+Ad67u+b0dCHsd+knvG74VXJc2zK3m1i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSUhYOqDa3EwBCWRkit3jTGczWFYWFQKOGxsLwTAOXPbH7Vx5LXxBTqhwWVRsYXGlmrj2NUKlD4Tl35gUzezTklLUuiIzAmT/nieibsb/t48oMxSL6XXE7Z0qEZgIzDvcn72b0DZ5Njb3N+wIJ8tRTN0mXf56h93Vf4BS1Agdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNnTdce/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749810255; x=1781346255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2iDnlk7mOj+Ad67u+b0dCHsd+knvG74VXJc2zK3m1i0=;
  b=fNnTdce/ogVHRpSnX1k7NPyfxeAhxv0iefamZjt5lSiYdjPU5zwZc+oL
   BH2XXUa32qTSyr1+YSB0oMXdklr5izQx4hdMJbpGpp8GroZnl/QNGYult
   nipgYBBTTVC0buh82fTjGaZdlHbbVMqS+yh862ghSzpEx6ZvM0qSZqmbf
   LDpX6NL68evUqDgJRWQZ947oE/xpOPDomaZV+nvgeTBxD/ZNuHAJGlttv
   COVfvpEuy6m8NwLbK8V7bSEhIRCw6/MN8XUaMN87LAbmML1NF/3amH1gD
   wfSJdtwBlxPYtTE7GBCpHW2pwcEnEXWhehHuLYEVaZZciMKd4iA0m9o8c
   g==;
X-CSE-ConnectionGUID: SFfHZUGSSV+bT3fg6dUe2Q==
X-CSE-MsgGUID: j8C3/pJ6SHiZuxCMQp3S5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69597033"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69597033"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:24:14 -0700
X-CSE-ConnectionGUID: 2+hRSAiYT5S5y7w8WfQKRw==
X-CSE-MsgGUID: hxr4Xq7JRRi3aanGHmuyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152688791"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jun 2025 03:24:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ1Zx-000CSo-33;
	Fri, 13 Jun 2025 10:24:09 +0000
Date: Fri, 13 Jun 2025 18:23:52 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: handle regulatory hints during
 mac registration
Message-ID: <202506131836.KoxnhWuQ-lkp@intel.com>
References: <20250612-handle_user_regd_update_hints_during_insmod-v1-1-576bd0f6dbe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-handle_user_regd_update_hints_during_insmod-v1-1-576bd0f6dbe0@oss.qualcomm.com>

Hi Aditya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8270f43193a0d097659eca55e701fd6818708945]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Kumar-Singh/wifi-ath12k-handle-regulatory-hints-during-mac-registration/20250613-012106
base:   8270f43193a0d097659eca55e701fd6818708945
patch link:    https://lore.kernel.org/r/20250612-handle_user_regd_update_hints_during_insmod-v1-1-576bd0f6dbe0%40oss.qualcomm.com
patch subject: [PATCH ath-next] wifi: ath12k: handle regulatory hints during mac registration
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250613/202506131836.KoxnhWuQ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250613/202506131836.KoxnhWuQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506131836.KoxnhWuQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/wmi.c:6:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/net/wireless/ath/ath12k/wmi.c:6169:13: warning: variable 'pdev_idx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    6169 |         } else if (ret == ATH12K_REG_STATUS_DROP) {
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6216:17: note: uninitialized use occurs here
    6216 |         ar = ab->pdevs[pdev_idx].ar;
         |                        ^~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6169:9: note: remove the 'if' if its condition is always false
    6169 |         } else if (ret == ATH12K_REG_STATUS_DROP) {
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6170 |                 /* reg info is valid but we will not store it and
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6171 |                  * not going to create new regd for it
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6172 |                  */
         |                  ~~
    6173 |                 ret = ATH12K_REG_STATUS_VALID;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6174 |                 goto mem_free;
         |                 ~~~~~~~~~~~~~~
    6175 |         }
         |         ~
   drivers/net/wireless/ath/ath12k/wmi.c:6163:6: warning: variable 'pdev_idx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    6163 |         if (ret == ATH12K_REG_STATUS_FALLBACK) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6216:17: note: uninitialized use occurs here
    6216 |         ar = ab->pdevs[pdev_idx].ar;
         |                        ^~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6163:2: note: remove the 'if' if its condition is always false
    6163 |         if (ret == ATH12K_REG_STATUS_FALLBACK) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6164 |                 ath12k_warn(ab, "failed to validate reg info %d\n", ret);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6165 |                 /* firmware has successfully switches to new regd but host can not
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6166 |                  * continue, so free reginfo and fallback to old regd
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6167 |                  */
         |                  ~~
    6168 |                 goto mem_free;
         |                 ~~~~~~~~~~~~~~
    6169 |         } else if (ret == ATH12K_REG_STATUS_DROP) {
         |         ~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6157:6: warning: variable 'pdev_idx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    6157 |         if (ret) {
         |             ^~~
   drivers/net/wireless/ath/ath12k/wmi.c:6216:17: note: uninitialized use occurs here
    6216 |         ar = ab->pdevs[pdev_idx].ar;
         |                        ^~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6157:2: note: remove the 'if' if its condition is always false
    6157 |         if (ret) {
         |         ^~~~~~~~~~
    6158 |                 ath12k_warn(ab, "failed to extract regulatory info from received event\n");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6159 |                 goto mem_free;
         |                 ~~~~~~~~~~~~~~
    6160 |         }
         |         ~
   drivers/net/wireless/ath/ath12k/wmi.c:6151:6: warning: variable 'pdev_idx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    6151 |         if (!reg_info) {
         |             ^~~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6216:17: note: uninitialized use occurs here
    6216 |         ar = ab->pdevs[pdev_idx].ar;
         |                        ^~~~~~~~
   drivers/net/wireless/ath/ath12k/wmi.c:6151:2: note: remove the 'if' if its condition is always false
    6151 |         if (!reg_info) {
         |         ^~~~~~~~~~~~~~~~
    6152 |                 ret = -ENOMEM;
         |                 ~~~~~~~~~~~~~~
    6153 |                 goto fallback;
         |                 ~~~~~~~~~~~~~~
    6154 |         }
         |         ~
   drivers/net/wireless/ath/ath12k/wmi.c:6147:13: note: initialize the variable 'pdev_idx' to silence this warning
    6147 |         u8 pdev_idx;
         |                    ^
         |                     = '\0'
   5 warnings generated.


vim +6169 drivers/net/wireless/ath/ath12k/wmi.c

d889913205cf7e Kalle Valo         2022-11-28  6142  
d889913205cf7e Kalle Valo         2022-11-28  6143  static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
d889913205cf7e Kalle Valo         2022-11-28  6144  {
9e8e55c5832d4f Baochen Qiang      2025-04-18  6145  	struct ath12k_reg_info *reg_info;
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6146  	struct ath12k *ar;
eaa027a1d83f87 Baochen Qiang      2025-04-18  6147  	u8 pdev_idx;
9e8e55c5832d4f Baochen Qiang      2025-04-18  6148  	int ret;
d889913205cf7e Kalle Valo         2022-11-28  6149  
d889913205cf7e Kalle Valo         2022-11-28  6150  	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
d889913205cf7e Kalle Valo         2022-11-28  6151  	if (!reg_info) {
d889913205cf7e Kalle Valo         2022-11-28  6152  		ret = -ENOMEM;
d889913205cf7e Kalle Valo         2022-11-28  6153  		goto fallback;
d889913205cf7e Kalle Valo         2022-11-28  6154  	}
d889913205cf7e Kalle Valo         2022-11-28  6155  
d889913205cf7e Kalle Valo         2022-11-28  6156  	ret = ath12k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
d889913205cf7e Kalle Valo         2022-11-28  6157  	if (ret) {
d889913205cf7e Kalle Valo         2022-11-28  6158  		ath12k_warn(ab, "failed to extract regulatory info from received event\n");
75639b74351553 Baochen Qiang      2025-04-18  6159  		goto mem_free;
75639b74351553 Baochen Qiang      2025-04-18  6160  	}
75639b74351553 Baochen Qiang      2025-04-18  6161  
75639b74351553 Baochen Qiang      2025-04-18  6162  	ret = ath12k_reg_validate_reg_info(ab, reg_info);
75639b74351553 Baochen Qiang      2025-04-18  6163  	if (ret == ATH12K_REG_STATUS_FALLBACK) {
75639b74351553 Baochen Qiang      2025-04-18  6164  		ath12k_warn(ab, "failed to validate reg info %d\n", ret);
75639b74351553 Baochen Qiang      2025-04-18  6165  		/* firmware has successfully switches to new regd but host can not
75639b74351553 Baochen Qiang      2025-04-18  6166  		 * continue, so free reginfo and fallback to old regd
75639b74351553 Baochen Qiang      2025-04-18  6167  		 */
75639b74351553 Baochen Qiang      2025-04-18  6168  		goto mem_free;
75639b74351553 Baochen Qiang      2025-04-18 @6169  	} else if (ret == ATH12K_REG_STATUS_DROP) {
75639b74351553 Baochen Qiang      2025-04-18  6170  		/* reg info is valid but we will not store it and
75639b74351553 Baochen Qiang      2025-04-18  6171  		 * not going to create new regd for it
75639b74351553 Baochen Qiang      2025-04-18  6172  		 */
75639b74351553 Baochen Qiang      2025-04-18  6173  		ret = ATH12K_REG_STATUS_VALID;
75639b74351553 Baochen Qiang      2025-04-18  6174  		goto mem_free;
d889913205cf7e Kalle Valo         2022-11-28  6175  	}
d889913205cf7e Kalle Valo         2022-11-28  6176  
eaa027a1d83f87 Baochen Qiang      2025-04-18  6177  	/* free old reg_info if it exist */
eaa027a1d83f87 Baochen Qiang      2025-04-18  6178  	pdev_idx = reg_info->phy_id;
eaa027a1d83f87 Baochen Qiang      2025-04-18  6179  	if (ab->reg_info[pdev_idx]) {
eaa027a1d83f87 Baochen Qiang      2025-04-18  6180  		ath12k_reg_reset_reg_info(ab->reg_info[pdev_idx]);
eaa027a1d83f87 Baochen Qiang      2025-04-18  6181  		kfree(ab->reg_info[pdev_idx]);
eaa027a1d83f87 Baochen Qiang      2025-04-18  6182  	}
eaa027a1d83f87 Baochen Qiang      2025-04-18  6183  	/* reg_info is valid, we store it for later use
eaa027a1d83f87 Baochen Qiang      2025-04-18  6184  	 * even below regd build failed
eaa027a1d83f87 Baochen Qiang      2025-04-18  6185  	 */
eaa027a1d83f87 Baochen Qiang      2025-04-18  6186  	ab->reg_info[pdev_idx] = reg_info;
eaa027a1d83f87 Baochen Qiang      2025-04-18  6187  
fafa6ff0823b79 Baochen Qiang      2025-04-18  6188  	ret = ath12k_reg_handle_chan_list(ab, reg_info, WMI_VDEV_TYPE_UNSPEC,
fafa6ff0823b79 Baochen Qiang      2025-04-18  6189  					  IEEE80211_REG_UNSET_AP);
9e8e55c5832d4f Baochen Qiang      2025-04-18  6190  	if (ret) {
9e8e55c5832d4f Baochen Qiang      2025-04-18  6191  		ath12k_warn(ab, "failed to handle chan list %d\n", ret);
d889913205cf7e Kalle Valo         2022-11-28  6192  		goto fallback;
d889913205cf7e Kalle Valo         2022-11-28  6193  	}
d889913205cf7e Kalle Valo         2022-11-28  6194  
75639b74351553 Baochen Qiang      2025-04-18  6195  	goto out;
75639b74351553 Baochen Qiang      2025-04-18  6196  
75639b74351553 Baochen Qiang      2025-04-18  6197  mem_free:
75639b74351553 Baochen Qiang      2025-04-18  6198  	ath12k_reg_reset_reg_info(reg_info);
75639b74351553 Baochen Qiang      2025-04-18  6199  	kfree(reg_info);
75639b74351553 Baochen Qiang      2025-04-18  6200  
75639b74351553 Baochen Qiang      2025-04-18  6201  	if (ret == ATH12K_REG_STATUS_VALID)
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6202  		goto out;
d889913205cf7e Kalle Valo         2022-11-28  6203  
d889913205cf7e Kalle Valo         2022-11-28  6204  fallback:
d889913205cf7e Kalle Valo         2022-11-28  6205  	/* Fallback to older reg (by sending previous country setting
d889913205cf7e Kalle Valo         2022-11-28  6206  	 * again if fw has succeeded and we failed to process here.
d889913205cf7e Kalle Valo         2022-11-28  6207  	 * The Regdomain should be uniform across driver and fw. Since the
d889913205cf7e Kalle Valo         2022-11-28  6208  	 * FW has processed the command and sent a success status, we expect
d889913205cf7e Kalle Valo         2022-11-28  6209  	 * this function to succeed as well. If it doesn't, CTRY needs to be
d889913205cf7e Kalle Valo         2022-11-28  6210  	 * reverted at the fw and the old SCAN_CHAN_LIST cmd needs to be sent.
d889913205cf7e Kalle Valo         2022-11-28  6211  	 */
d889913205cf7e Kalle Valo         2022-11-28  6212  	/* TODO: This is rare, but still should also be handled */
d889913205cf7e Kalle Valo         2022-11-28  6213  	WARN_ON(1);
9e8e55c5832d4f Baochen Qiang      2025-04-18  6214  
75639b74351553 Baochen Qiang      2025-04-18  6215  out:
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6216  	ar = ab->pdevs[pdev_idx].ar;
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6217  
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6218  	/* During the boot-time update, 'ar' might not be allocated,
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6219  	 * so the completion cannot be marked at that point.
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6220  	 * This boot-time update is handled in ath12k_mac_hw_register()
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6221  	 * before registering the hardware.
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6222  	 */
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6223  	if (ar)
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6224  		complete(&ar->regd_update_completed);
e05f9e5c56466b Aditya Kumar Singh 2025-06-12  6225  
d889913205cf7e Kalle Valo         2022-11-28  6226  	return ret;
d889913205cf7e Kalle Valo         2022-11-28  6227  }
d889913205cf7e Kalle Valo         2022-11-28  6228  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

