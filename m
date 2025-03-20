Return-Path: <linux-wireless+bounces-20621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA9A6B12C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 23:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B97480B9B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 22:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4620A5C4;
	Thu, 20 Mar 2025 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcsmhJUo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF49B664
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510639; cv=none; b=r+/nI3RnZkIqSdtk93pJBi9mxjcbeJW24RTWu/unC26uOMyLc94v9883PgWWMZ/LA+fSU4zQ6n4ADFqUYvzvdawDUyb2ZXYwviXoqWgoatQ7EN2GBpmelyrU6Y+g+JZhqUdZMw6Og+p/DR0LuWqkb2FQw11/8b9ghNExn76jOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510639; c=relaxed/simple;
	bh=auxEEuY+xDpirUEPyxYSNf0pr+NS+Jjo/6xqZzmpriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgttTB+aULUXM/h7MInRSs0JIruIVgcY6tCknbfhDqqTMONsfRV00u1pkGbhFg5kyZIS4WSkRPRoId5ZxgSS+BN9+Pd1JRjcEspsqpH2XBj5acjX/xDVQ5FAMEcZnLIOfTMVPPay1rAhXfXlKNVGVH11xl97AVW1wg/fShHiwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcsmhJUo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742510638; x=1774046638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=auxEEuY+xDpirUEPyxYSNf0pr+NS+Jjo/6xqZzmpriI=;
  b=NcsmhJUolzkoEPAOwUPHowmcneTYiJwlOWrXXe/jVgLnfDfyLZMNZ7x7
   oaYLhETVZvQMWrgJGhONyYct1LSDhdwMuHjYxr1ktfNDFbLGEvtmYTFr4
   +IQXXraI+uveGBVGpsITo51pxEyUjxKsZOdzytWWpZArZ/hZwkYO8l4/T
   1CFf1yavXTDag0SMUNv2wqdB1ud5jceIbdM/yo8CewEPh1zSC1JbNhZGP
   OoXXC0z4YsOjyT34vlpMw1vzkdlCAsdQZYBj+5Pqpf6NGBGNg8dAtj/+O
   Qurm40hFoa2m5bUOV4osoKXGntWlVWjm02MqlfKTrWFmHWJthuU+TR2zl
   A==;
X-CSE-ConnectionGUID: W8kR1nWGQ8aGw1IlHWHkvA==
X-CSE-MsgGUID: mfDK68rbQE2ycIVuCtSrUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47543831"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="47543831"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:43:57 -0700
X-CSE-ConnectionGUID: VJgZY0yFScicTmekw+cYPw==
X-CSE-MsgGUID: SVQIDu9UQeWEHUtds+YQZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="154124462"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Mar 2025 15:43:55 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvOc7-0000q7-1O;
	Thu, 20 Mar 2025 22:43:49 +0000
Date: Fri, 21 Mar 2025 06:43:31 +0800
From: kernel test robot <lkp@intel.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, quic_bqiang@quicinc.com
Subject: Re: [PATCH ath-next 1/5] wifi: ath11k: determine PM policy based on
 machine model
Message-ID: <202503210624.I3zealnl-lkp@intel.com>
References: <20250320023003.65028-2-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320023003.65028-2-quic_bqiang@quicinc.com>

Hi Baochen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b6f473c96421b8b451a8df8ccb620bcd71d4b3f4]

url:    https://github.com/intel-lab-lkp/linux/commits/Baochen-Qiang/wifi-ath11k-determine-PM-policy-based-on-machine-model/20250320-103536
base:   b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
patch link:    https://lore.kernel.org/r/20250320023003.65028-2-quic_bqiang%40quicinc.com
patch subject: [PATCH ath-next 1/5] wifi: ath11k: determine PM policy based on machine model
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250321/202503210624.I3zealnl-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250321/202503210624.I3zealnl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503210624.I3zealnl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/core.c:2381:19: warning: cast to smaller integer type 'enum ath11k_pm_policy' from 'void *' [-Wvoid-pointer-to-enum-cast]
    2381 |                 ab->pm_policy = (enum ath11k_pm_policy)dmi_id->driver_data;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +2381 drivers/net/wireless/ath/ath11k/core.c

  2373	
  2374	int ath11k_core_init(struct ath11k_base *ab)
  2375	{
  2376		const struct dmi_system_id *dmi_id;
  2377		int ret;
  2378	
  2379		dmi_id = dmi_first_match(ath11k_pm_quirk_table);
  2380		if (dmi_id)
> 2381			ab->pm_policy = (enum ath11k_pm_policy)dmi_id->driver_data;
  2382		else
  2383			ab->pm_policy = ATH11K_PM_DEFAULT;
  2384	
  2385		ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
  2386	
  2387		ret = ath11k_core_soc_create(ab);
  2388		if (ret) {
  2389			ath11k_err(ab, "failed to create soc core: %d\n", ret);
  2390			return ret;
  2391		}
  2392	
  2393		return 0;
  2394	}
  2395	EXPORT_SYMBOL(ath11k_core_init);
  2396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

