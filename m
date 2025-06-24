Return-Path: <linux-wireless+bounces-24447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AEAE720E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 00:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405F2179318
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67D25A337;
	Tue, 24 Jun 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMYWXc8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1965248880
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802658; cv=none; b=ha/famn+7GtYNGM6fIO5gUo4Cb21J+uXNs8bSrCe3k4al780HUj7JdV2/NWxqgmGYSEX8zV1QJyOf5+PgBQnSoH5q2VSgjMewIlUSajTLUrF79dQsDZJd67RwyJ0wWyYPaa2b9eUI2AvHbwNjnnUJTPg1p8/DL491KU/cf4e9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802658; c=relaxed/simple;
	bh=Zu3c4TEciOFpYKhtQCdJJWXJ3340BlRL7VaZjg54aAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmv1v/DlFDqujTFz7vrW9TO5aqn/9RhyiJITVbGJ5IHoVwPRxQcoDXRl0qgcK0Zs/TqlgTgTSgh/Kyh8o041iBoei5lZHm+MzljEiJXa9HAg+XyUAyPkWDU929w4i1cA4IqsDvvbdQL3SqqSvtJmj3GRgFiyY7pZfrWtbGtXDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMYWXc8l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750802657; x=1782338657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zu3c4TEciOFpYKhtQCdJJWXJ3340BlRL7VaZjg54aAQ=;
  b=SMYWXc8lEm+9W0e4dYz6JB50FGwEdudr7yzAJw96lnhroRef4NdAYuDN
   Sbs4L/QyArLk7glwo8aXQG6WpVOdjJyaIILEMCg0VwUdmRb6YmVUdgO6t
   2TUOYnutSfs1aeFAbfUEq4/0TCGZEIM3JrLTzzFpVplMUNhbgT0kQ4zdW
   CTKmKDeV2Bvr9hLd4Lvri0mbxTwffYLASqoUfd/boUcNGUD+XNX0bdJtx
   aueJIvFnKpAUGpHVv7a+gHRr9Ur3r7T3iKH8Kt5gNxQB7tBAGhNPFoSY0
   HassO2JsxS0BlfZjG2EyWQNA/QMZq7z3ansTptuL6/PxxJsezk6bpBndk
   A==;
X-CSE-ConnectionGUID: pnbrHTBnSymRhSDcrMS6Uw==
X-CSE-MsgGUID: rRFd6JOFQEWWO5TSraUwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56844356"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="56844356"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:04:16 -0700
X-CSE-ConnectionGUID: 5Ozi9P3WTIOAKzMKDUEs1g==
X-CSE-MsgGUID: qqIAdIHAT9aizBTGHjWQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="183076432"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Jun 2025 15:04:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUBkP-000SYU-2w;
	Tue, 24 Jun 2025 22:04:09 +0000
Date: Wed, 25 Jun 2025 06:04:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, nbd@nbd.name,
	lorenzo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	deren.wu@mediatek.com, Sean.Wang@mediatek.com,
	Leon.Yen@mediatek.com, Michael.Lo@mediatek.com,
	allan.wang@mediatek.com, Eric-SY.Chang@mediatek.com,
	km.lin@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: Limit the concurrent STA and SoftAP to
 operate on the same channel
Message-ID: <202506250512.Q0I4znsF-lkp@intel.com>
References: <20250619112005.2071110-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619112005.2071110-1-mingyen.hsieh@mediatek.com>

Hi Mingyen,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc3 next-20250624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mingyen-Hsieh/wifi-mt76-Limit-the-concurrent-STA-and-SoftAP-to-operate-on-the-same-channel/20250619-192503
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250619112005.2071110-1-mingyen.hsieh%40mediatek.com
patch subject: [PATCH] wifi: mt76: Limit the concurrent STA and SoftAP to operate on the same channel
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250625/202506250512.Q0I4znsF-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506250512.Q0I4znsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506250512.Q0I4znsF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt792x_core.c:84:3: error: initializer element is not a compile-time constant
                   if_comb_chanctx_mcc[0],
                   ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +84 drivers/net/wireless/mediatek/mt76/mt792x_core.c

    82	
    83	static const struct ieee80211_iface_combination if_comb_chanctx[] = {
  > 84			if_comb_chanctx_mcc[0],
    85			if_comb_chanctx_scc[0],
    86	};
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

