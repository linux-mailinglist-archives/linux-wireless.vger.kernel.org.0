Return-Path: <linux-wireless+bounces-24671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A5AEE6ED
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536201BC2317
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3A528C2D4;
	Mon, 30 Jun 2025 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tj8/MWoB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C081EBA0D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309003; cv=none; b=qjUeSBBr58McGGF6wYgukiU3je0lpnSJSYDme7L+Ls4pz69gTpBJOyFRxZIe7e/DYvJamV6daHZti6YfbyT6vV42jpHiuuW0fIFgXTf/yrc6vwyfe55k9gicBSyCzk/hqA+HrItTjRTH3Ab9Y3ZmWsERplTIpNjYfQ+5glmsFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309003; c=relaxed/simple;
	bh=e9L2Or2Z+AWl0PzpMP/E7A3kcDY9LygJW2AF7pQN8bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8yCeAAYGsV5cMquVPXZz/HZ8zBNTE+TZZHJimNunmmqzam/98wnuWfp3u52CNjRh+xuwxhS9MLLtostyJvQZ9q7++UEVxnfXQMRMeZyi6mEvLckSvmVLk2kxNUrdLJmUTEDGjcKgIZR0fE+rt+3EcuyprgOMFTuK9EOJtebB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tj8/MWoB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751309002; x=1782845002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9L2Or2Z+AWl0PzpMP/E7A3kcDY9LygJW2AF7pQN8bw=;
  b=Tj8/MWoBFWYigL7uF1io4IyRiNJ3vD/KaKqVRGwbRcbrhhDtL0Dpj0l4
   Bm5j4Uz5f71y3dc0znehlzeGYxJ/pPB3Pot1msGIE42NoInwvbOS7Mysf
   HSV5hkWpOSMGhJTSgeVl4ZGMWbXfms+CM6RHBal0nVvypthpjYEKJcwLE
   EvvjpBkGUGjiM07OiQ7YHHaXCWt+s7HDkmlGAYzzpfEb/cpQxDqMxW0x2
   F3l+KkxJ9epD1eWIJNbQpkq81v/aEy08hu8pkVCIHb8vQgNcg/4uDd9q5
   aGNH26dupOLwueT2nBNMUYkPbodLaIOuNS8YC9KT43Aw05yKflfoOgwig
   w==;
X-CSE-ConnectionGUID: jZo1trgjSqOKVoaIP7EpDw==
X-CSE-MsgGUID: MEgjP8PKRgqDoRWLANclFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71112255"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="71112255"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:43:21 -0700
X-CSE-ConnectionGUID: 8zfLGR6RQj2x1iOIOjPbCg==
X-CSE-MsgGUID: tQ+X3+5WTM6pCoOTWO29LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153016837"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 30 Jun 2025 11:43:20 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWJTJ-000ZGo-0G;
	Mon, 30 Jun 2025 18:43:17 +0000
Date: Tue, 1 Jul 2025 02:43:07 +0800
From: kernel test robot <lkp@intel.com>
To: Govind Singh <govind.sk85@gmail.com>, ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Govind Singh <govind.sk85@gmail.com>
Subject: Re: [PATCH] ath12k: add module param to control MSI mode and address
 width
Message-ID: <202507010226.p5NvqJE6-lkp@intel.com>
References: <20250624165031.58616-1-govind.sk85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624165031.58616-1-govind.sk85@gmail.com>

Hi Govind,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on wireless/main wireless-next/main linus/master v6.16-rc4 next-20250630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Govind-Singh/ath12k-add-module-param-to-control-MSI-mode-and-address-width/20250625-005348
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20250624165031.58616-1-govind.sk85%40gmail.com
patch subject: [PATCH] ath12k: add module param to control MSI mode and address width
config: sparc-randconfig-r112-20250630 (https://download.01.org/0day-ci/archive/20250701/202507010226.p5NvqJE6-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250701/202507010226.p5NvqJE6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507010226.p5NvqJE6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath12k/pci.c:52:6: sparse: sparse: symbol 'ath12k_32bit_msi' was not declared. Should it be static?

vim +/ath12k_32bit_msi +52 drivers/net/wireless/ath/ath12k/pci.c

    51	
  > 52	bool ath12k_32bit_msi;
    53	module_param(ath12k_32bit_msi, bool, 0644);
    54	MODULE_PARM_DESC(ath12k_32bit_msi, "Force 32-bit MSI addressing");
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

