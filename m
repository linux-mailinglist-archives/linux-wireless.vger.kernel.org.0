Return-Path: <linux-wireless+bounces-16700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3079FA2CA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 23:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B3F1674F6
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6951DE3A7;
	Sat, 21 Dec 2024 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqiKxUB8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CB1A3BD7
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734821878; cv=none; b=rqVNSgEO5XNh5QR9RrOOFIekQ3Z1rfNol/pSHidkUduA5dPymKO6DFtKeXTfHkjd1xvmPiCTMH7Dw1GTf9yWaMN8+WP8sZdwBwODIL/j8m0GDMsfsjLJRCAwx34p/MIQ48bZ9wTPNMxQNTwcEmg8QK9JeiAcW81Qw06btRjuhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734821878; c=relaxed/simple;
	bh=nsobIdYYKnBKr5gNA7nnnirRHkdS/46BhbK2G8cNw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/40UTC3lSU6sT0uXGYSVJPvSwIu/T25uPXRAYmnEi15u8n9N52hiS0gaWzEx3ZPkDZlOBjkrmhOFEluBFjrO7yWOVnb6dtTNA8BLiJmL/aUARz2nwWcWKg8VQzQ7OKUA5uq+VDMVwdpky1yZmZ2gTMb+UL0rd05BG2JcARazuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqiKxUB8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734821876; x=1766357876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nsobIdYYKnBKr5gNA7nnnirRHkdS/46BhbK2G8cNw3w=;
  b=WqiKxUB8xIVOSSKTwvvMgFplTPQmL21sWG6OWRvo+c1LAi4jnZer7CQO
   4fLpnzaSOJCVP6Q6JtGknKW2JjWMvta1AYixrTCQohs5Dwr9l34fDl1uV
   LlaWcqM9mUp4+wWK2iyPrY3y/5peSTr97gocV7TetS+LQWPikxWf8a+IA
   DuBrJ2Z7ZRg5xQFBktr/o83CCdIpAwt/ubiT2vhqMzDhGMrpNHMQSP0b/
   rHpYPMM8wsLfqt3Xa6zNyPwlcE2arCxUH0OeyD08vXaHYsqoTVnTINIrg
   YQC2hz6uWNq73wG/HLycFNAFi4osi6MP2yFUSyTIWxvGOoGFud5kfE5yB
   g==;
X-CSE-ConnectionGUID: alhsi/dRSnKhP7SO0NxQfg==
X-CSE-MsgGUID: 0RVkute3QMyrflpniFJNUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="35217362"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="35217362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 14:57:56 -0800
X-CSE-ConnectionGUID: 7Q2MCnAjTuKTAQM+6Hx+3Q==
X-CSE-MsgGUID: FjVqoHYZRTOwi3r4W+PB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="98910103"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Dec 2024 14:57:54 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tP8Pv-0002YJ-2T;
	Sat, 21 Dec 2024 22:57:51 +0000
Date: Sun, 22 Dec 2024 06:56:59 +0800
From: kernel test robot <lkp@intel.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
	ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
	Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
Message-ID: <202412220617.gNBV4iPi-lkp@intel.com>
References: <20241220203638.2082002-2-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220203638.2082002-2-quic_rdevanat@quicinc.com>

Hi Roopni,

kernel test robot noticed the following build errors:

[auto build test ERROR on 09fa3b6974a1245ddd0751747609431494ba5b4f]

url:    https://github.com/intel-lab-lkp/linux/commits/Roopni-Devanathan/wifi-ath12k-Add-Support-to-Parse-TPC-Event-from-Firmware/20241221-043752
base:   09fa3b6974a1245ddd0751747609431494ba5b4f
patch link:    https://lore.kernel.org/r/20241220203638.2082002-2-quic_rdevanat%40quicinc.com
patch subject: [PATCH 1/2] wifi: ath12k: Add Support to Parse TPC Event from Firmware
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20241222/202412220617.gNBV4iPi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241222/202412220617.gNBV4iPi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412220617.gNBV4iPi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_wmi_free_tpc_stats_mem':
>> drivers/net/wireless/ath/ath12k/wmi.c:7668:50: error: 'struct ath12k' has no member named 'debug'
    7668 |         struct wmi_tpc_stats_info *tpc_stats = ar->debug.tpc_stats;
         |                                                  ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7678:19: error: 'struct ath12k' has no member named 'debug'
    7678 |                 ar->debug.tpc_stats = NULL;
         |                   ^~
   drivers/net/wireless/ath/ath12k/wmi.c: In function 'ath12k_process_tpc_stats':
   drivers/net/wireless/ath/ath12k/wmi.c:7722:16: error: 'struct ath12k' has no member named 'debug'
    7722 |         if (!ar->debug.tpc_request) {
         |                ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7726:23: error: 'struct ath12k' has no member named 'debug'
    7726 |                 if (ar->debug.tpc_stats) {
         |                       ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7735:23: error: 'struct ath12k' has no member named 'debug'
    7735 |                 if (ar->debug.tpc_stats) {
         |                       ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7740:19: error: 'struct ath12k' has no member named 'debug'
    7740 |                 ar->debug.tpc_stats =
         |                   ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7743:24: error: 'struct ath12k' has no member named 'debug'
    7743 |                 if (!ar->debug.tpc_stats) {
         |                        ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7750:23: error: 'struct ath12k' has no member named 'debug'
    7750 |         tpc_stats = ar->debug.tpc_stats;
         |                       ^~
   drivers/net/wireless/ath/ath12k/wmi.c:7776:29: error: 'struct ath12k' has no member named 'debug'
    7776 |                 complete(&ar->debug.tpc_complete);
         |                             ^~


vim +7668 drivers/net/wireless/ath/ath12k/wmi.c

  7665	
  7666	void ath12k_wmi_free_tpc_stats_mem(struct ath12k *ar)
  7667	{
> 7668		struct wmi_tpc_stats_info *tpc_stats = ar->debug.tpc_stats;
  7669	
  7670		lockdep_assert_held(&ar->data_lock);
  7671		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "tpc stats mem free\n");
  7672		if (tpc_stats) {
  7673			kfree(tpc_stats->max_reg_allowed_power.reg_pwr_array);
  7674			kfree(tpc_stats->rates_array1.rate_array);
  7675			kfree(tpc_stats->rates_array2.rate_array);
  7676			kfree(tpc_stats->ctl_array.ctl_pwr_table);
  7677			kfree(tpc_stats);
  7678			ar->debug.tpc_stats = NULL;
  7679		}
  7680	}
  7681	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

