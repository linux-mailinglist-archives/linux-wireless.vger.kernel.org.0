Return-Path: <linux-wireless+bounces-3366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA684EE73
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 01:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D974AB2874B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051015AF;
	Fri,  9 Feb 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoJt1guy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC31366
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707439872; cv=none; b=UpBqB65KdntXmyZ4stRyqLQ72k6gW0R7RoCaIysbFoeEAHGZuIwllY4B+jkenCI73DnG4CbugHgbqQjz549K+GZW90PqGSQcmitwO9roma3u3AJ7BfC//nFlWcZGWcLFbKvlYsVF4aEFvihFOI5ljHrZe+6o2FfoLm/eEzYIqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707439872; c=relaxed/simple;
	bh=rMoBWoQ8IQGZqC9VrNz4ZerwsCRMosmLHiRyZB+esps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szryGTIJJbY+d4nhKG93FvszA+53nb53kwPyDJO41GiLRhA6LIZUlpu190sHaYfE5amo+GZSjNxt01BtwpoSP9yrYX5AvfWVj0RO+SLF1wWD5nkmRJPjGz433VwZCz9ZFZSe14Zf6kmlUo2PUTbFZSkh4bDV0Sy9mzx3Kc6YhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoJt1guy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707439870; x=1738975870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMoBWoQ8IQGZqC9VrNz4ZerwsCRMosmLHiRyZB+esps=;
  b=DoJt1guyE/G8aKydTKzyd2Ds/NoBPYBuNoXmwBWT/gBnZQ273yjmm77E
   vE7tEwrsuZ0ib34NX2aWEKOqQTffo8vGQY4+HEp//tgsXdBDnbKFeEDOp
   DeUGTaobhBQUlnoBVGsBbOVm3RrqPIR9p6j8J7CDMaV1oSViJwAUAwIXZ
   VRVYXCSwsQbTJ65j9YiNloqSCoLo1+MgZw/LgMF4UUDfr9yGHo0VEL2uo
   TNfQ52780ZTfLD/7wY+VUSprpbeVz8zkntvNsnigcX5UOlBezf/zux1t7
   cJuWFxj60iULAS0Rl8SWC/3uuHmvyoVLV5M5Gr0Ko0fSpgF7VjwUsJKom
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5202932"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="5202932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="2035502"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Feb 2024 16:51:07 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYF6e-0004FA-1I;
	Fri, 09 Feb 2024 00:51:04 +0000
Date: Fri, 9 Feb 2024 08:50:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gary.chang@realtek.com, phhuang@realtek.com, kevin_yang@realtek.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 02/11] wifi: rtw89: load BB parameters to PHY-1
Message-ID: <202402090838.S5xcKIlg-lkp@intel.com>
References: <20240208022857.14379-3-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208022857.14379-3-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on next-20240208]
[cannot apply to wireless/main linus/master v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-correct-PHY-register-offset-for-PHY-1/20240208-103413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240208022857.14379-3-pkshih%40realtek.com
patch subject: [PATCH 02/11] wifi: rtw89: load BB parameters to PHY-1
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240209/202402090838.S5xcKIlg-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402090838.S5xcKIlg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402090838.S5xcKIlg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/phy.c:1047:7: warning: cast to smaller integer type 'enum rtw89_phy_idx' from 'void *' [-Wvoid-pointer-to-enum-cast]
    1047 |                 if ((enum rtw89_phy_idx)extra_data == RTW89_PHY_1)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1047 drivers/net/wireless/realtek/rtw89/phy.c

  1022	
  1023	static void rtw89_phy_config_bb_reg(struct rtw89_dev *rtwdev,
  1024					    const struct rtw89_reg2_def *reg,
  1025					    enum rtw89_rf_path rf_path,
  1026					    void *extra_data)
  1027	{
  1028		u32 addr;
  1029	
  1030		if (reg->addr == 0xfe) {
  1031			mdelay(50);
  1032		} else if (reg->addr == 0xfd) {
  1033			mdelay(5);
  1034		} else if (reg->addr == 0xfc) {
  1035			mdelay(1);
  1036		} else if (reg->addr == 0xfb) {
  1037			udelay(50);
  1038		} else if (reg->addr == 0xfa) {
  1039			udelay(5);
  1040		} else if (reg->addr == 0xf9) {
  1041			udelay(1);
  1042		} else if (reg->data == BYPASS_CR_DATA) {
  1043			rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK, "Bypass CR 0x%x\n", reg->addr);
  1044		} else {
  1045			addr = reg->addr;
  1046	
> 1047			if ((enum rtw89_phy_idx)extra_data == RTW89_PHY_1)
  1048				addr += rtw89_phy0_phy1_offset(rtwdev, reg->addr);
  1049	
  1050			rtw89_phy_write32(rtwdev, addr, reg->data);
  1051		}
  1052	}
  1053	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

