Return-Path: <linux-wireless+bounces-19564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09296A488E3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4947A6149
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83F26E956;
	Thu, 27 Feb 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HywPJddl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65B26E652;
	Thu, 27 Feb 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684004; cv=none; b=mMTY6GWpsxdW9NlRpOzC+rbo3xZaS2eaCeQcqXhPCVvAjW20KdZqRdbg4j+5FgU6s0/ZZmA3uCgH9eAhu/8n1QKzBhlms5I3rRkp3eulMl8p9CmwvHK1Ge4dE2VFNZDtotiQ6xalbB95Atop59lSgflN06Mpe8ZchnnTAR+c3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684004; c=relaxed/simple;
	bh=VofQ0MMFNn/3/peulSddBz10VHBiuJCK5GWnGS+Q5H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smphBKyOhojQke2mDsVJAu//ipwrrFgzkYxexyN0RfX7MwoBzJ1uvYPJmb1TgarQdjOTuA6P+IiO1mCCuPj9ngrIO9VeHX4eg6mXZ6Hx1lESX7OthwcqgdSbGyxY+T7ExYdTz9kc0ods+0tmf8njr6UcgMNZiNVP02S88R4OhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HywPJddl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740684003; x=1772220003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VofQ0MMFNn/3/peulSddBz10VHBiuJCK5GWnGS+Q5H0=;
  b=HywPJddlA+U6nzQQ5A+inwEcbxHwNm+oHlVNdAjby5pj+HBsQZj+QcXQ
   f4N5XLy+1bqEA25KnK6qlTzYfvAg97g620bhEOvRorP4esvPX7oARwgo8
   9zGl0xB2xZnOtg+NxyslYpyu1KgzQeSPPH6ARQBPt/P2RQSxRjorV6ctf
   0mfM5WiDEdhyZa0xf928Q0qbr0XBwRpeMfPKfRfyYs9+kHY2Vm4x3eDUl
   BUq9EHK58CRmS4UOqBm1gMb4KHil9IPGGVsmj4zeg7BkToKb05eFo5dmH
   MbFxdqxF5RHZlYOpX1M8ChO3jPqJNh8YcX3tgKwtkhYzbVCuzcZlZwsf8
   A==;
X-CSE-ConnectionGUID: IdL39/tNRKeGINgot/4LZw==
X-CSE-MsgGUID: 0Lg5vQGbSsm0/iDUinJcRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52228390"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52228390"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:20:02 -0800
X-CSE-ConnectionGUID: lbJBhQv4TaKW+I2N+pzi/w==
X-CSE-MsgGUID: UG5ljOKTSPyONnpcqJOy5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118042917"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Feb 2025 11:19:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnjQK-000Dvm-2O;
	Thu, 27 Feb 2025 19:19:56 +0000
Date: Fri, 28 Feb 2025 03:19:00 +0800
From: kernel test robot <lkp@intel.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: Re: [PATCH v6 07/13] wifi: ath12k: add support for fixed QMI
 firmware memory
Message-ID: <202502280215.J3T7EWeY-lkp@intel.com>
References: <20250225064834.2002499-8-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225064834.2002499-8-quic_rajkbhag@quicinc.com>

Hi Raj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 13a84b4e7dd5d843dfaa54283adb4bbbe0adee15]

url:    https://github.com/intel-lab-lkp/linux/commits/Raj-Kumar-Bhagat/dt-bindings-net-wireless-describe-the-ath12k-AHB-module-for-IPQ5332/20250225-145536
base:   13a84b4e7dd5d843dfaa54283adb4bbbe0adee15
patch link:    https://lore.kernel.org/r/20250225064834.2002499-8-quic_rajkbhag%40quicinc.com
patch subject: [PATCH v6 07/13] wifi: ath12k: add support for fixed QMI firmware memory
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502280215.J3T7EWeY-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280215.J3T7EWeY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280215.J3T7EWeY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/qmi.c:11:
   drivers/net/wireless/ath/ath12k/qmi.c: In function 'ath12k_qmi_assign_target_mem_chunk':
>> drivers/net/wireless/ath/ath12k/qmi.c:2677:44: warning: format '%lld' expects argument of type 'long long int', but argument 6 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
    2677 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
    2680 |                                            rmem->size);
         |                                            ~~~~~~~~~~
         |                                                |
         |                                                phys_addr_t {aka unsigned int}
   drivers/net/wireless/ath/ath12k/debug.h:69:40: note: in definition of macro 'ath12k_dbg'
      69 |                 __ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);     \
         |                                        ^~~
   drivers/net/wireless/ath/ath12k/qmi.c:2677:100: note: format string is defined here
    2677 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                                                                                 ~~~^
         |                                                                                                    |
         |                                                                                                    long long int
         |                                                                                                 %d
   drivers/net/wireless/ath/ath12k/qmi.c:2707:44: warning: format '%lld' expects argument of type 'long long int', but argument 6 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
    2707 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
    2710 |                                            bdf_size);
         |                                            ~~~~~~~~
         |                                            |
         |                                            phys_addr_t {aka unsigned int}
   drivers/net/wireless/ath/ath12k/debug.h:69:40: note: in definition of macro 'ath12k_dbg'
      69 |                 __ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);     \
         |                                        ^~~
   drivers/net/wireless/ath/ath12k/qmi.c:2707:100: note: format string is defined here
    2707 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                                                                                 ~~~^
         |                                                                                                    |
         |                                                                                                    long long int
         |                                                                                                 %d
   drivers/net/wireless/ath/ath12k/qmi.c:2748:44: warning: format '%lld' expects argument of type 'long long int', but argument 6 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
    2748 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ......
    2751 |                                            rmem->size);
         |                                            ~~~~~~~~~~
         |                                                |
         |                                                phys_addr_t {aka unsigned int}
   drivers/net/wireless/ath/ath12k/debug.h:69:40: note: in definition of macro 'ath12k_dbg'
      69 |                 __ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);     \
         |                                        ^~~
   drivers/net/wireless/ath/ath12k/qmi.c:2748:100: note: format string is defined here
    2748 |                                            "failed to assign mem type %d req size %d avail size %lld\n",
         |                                                                                                 ~~~^
         |                                                                                                    |
         |                                                                                                    long long int
         |                                                                                                 %d


vim +2677 drivers/net/wireless/ath/ath12k/qmi.c

  2659	
  2660	static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
  2661	{
  2662		struct reserved_mem *rmem;
  2663		phys_addr_t bdf_size;
  2664		int i, idx, ret;
  2665	
  2666		for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
  2667			switch (ab->qmi.target_mem[i].type) {
  2668			case HOST_DDR_REGION_TYPE:
  2669				rmem = ath12k_core_get_reserved_mem(ab, 0);
  2670				if (!rmem) {
  2671					ret = -ENODEV;
  2672					goto out;
  2673				}
  2674	
  2675				if (rmem->size < ab->qmi.target_mem[i].size) {
  2676					ath12k_dbg(ab, ATH12K_DBG_QMI,
> 2677						   "failed to assign mem type %d req size %d avail size %lld\n",
  2678						   ab->qmi.target_mem[i].type,
  2679						   ab->qmi.target_mem[i].size,
  2680						   rmem->size);
  2681					ret = -EINVAL;
  2682					goto out;
  2683				}
  2684	
  2685				ab->qmi.target_mem[idx].paddr = rmem->base;
  2686				ab->qmi.target_mem[idx].v.ioaddr =
  2687					ioremap(ab->qmi.target_mem[idx].paddr,
  2688						ab->qmi.target_mem[i].size);
  2689				if (!ab->qmi.target_mem[idx].v.ioaddr) {
  2690					ret = -EIO;
  2691					goto out;
  2692				}
  2693				ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
  2694				ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
  2695				idx++;
  2696				break;
  2697			case BDF_MEM_REGION_TYPE:
  2698				rmem = ath12k_core_get_reserved_mem(ab, 0);
  2699				if (!rmem) {
  2700					ret = -ENODEV;
  2701					goto out;
  2702				}
  2703	
  2704				bdf_size = rmem->size - ab->hw_params->bdf_addr_offset;
  2705				if (bdf_size < ab->qmi.target_mem[i].size) {
  2706					ath12k_dbg(ab, ATH12K_DBG_QMI,
  2707						   "failed to assign mem type %d req size %d avail size %lld\n",
  2708						   ab->qmi.target_mem[i].type,
  2709						   ab->qmi.target_mem[i].size,
  2710						   bdf_size);
  2711					ret = -EINVAL;
  2712					goto out;
  2713				}
  2714				ab->qmi.target_mem[idx].paddr =
  2715					rmem->base + ab->hw_params->bdf_addr_offset;
  2716				ab->qmi.target_mem[idx].v.ioaddr =
  2717					ioremap(ab->qmi.target_mem[idx].paddr,
  2718						ab->qmi.target_mem[i].size);
  2719				if (!ab->qmi.target_mem[idx].v.ioaddr) {
  2720					ret = -EIO;
  2721					goto out;
  2722				}
  2723				ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
  2724				ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
  2725				idx++;
  2726				break;
  2727			case CALDB_MEM_REGION_TYPE:
  2728				/* Cold boot calibration is not enabled in Ath12k. Hence,
  2729				 * assign paddr = 0.
  2730				 * Once cold boot calibration is enabled add support to
  2731				 * assign reserved memory from DT.
  2732				 */
  2733				ab->qmi.target_mem[idx].paddr = 0;
  2734				ab->qmi.target_mem[idx].v.ioaddr = NULL;
  2735				ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
  2736				ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
  2737				idx++;
  2738				break;
  2739			case M3_DUMP_REGION_TYPE:
  2740				rmem = ath12k_core_get_reserved_mem(ab, 1);
  2741				if (!rmem) {
  2742					ret = -EINVAL;
  2743					goto out;
  2744				}
  2745	
  2746				if (rmem->size < ab->qmi.target_mem[i].size) {
  2747					ath12k_dbg(ab, ATH12K_DBG_QMI,
  2748						   "failed to assign mem type %d req size %d avail size %lld\n",
  2749						   ab->qmi.target_mem[i].type,
  2750						   ab->qmi.target_mem[i].size,
  2751						   rmem->size);
  2752					ret = -EINVAL;
  2753					goto out;
  2754				}
  2755	
  2756				ab->qmi.target_mem[idx].paddr = rmem->base;
  2757				ab->qmi.target_mem[idx].v.ioaddr =
  2758					ioremap(ab->qmi.target_mem[idx].paddr,
  2759						ab->qmi.target_mem[i].size);
  2760				if (!ab->qmi.target_mem[idx].v.ioaddr) {
  2761					ret = -EIO;
  2762					goto out;
  2763				}
  2764				ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
  2765				ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
  2766				idx++;
  2767				break;
  2768			default:
  2769				ath12k_warn(ab, "qmi ignore invalid mem req type %d\n",
  2770					    ab->qmi.target_mem[i].type);
  2771				break;
  2772			}
  2773		}
  2774		ab->qmi.mem_seg_count = idx;
  2775	
  2776		return 0;
  2777	out:
  2778		ath12k_qmi_free_target_mem_chunk(ab);
  2779		return ret;
  2780	}
  2781	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

