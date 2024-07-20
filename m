Return-Path: <linux-wireless+bounces-10404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F173937E6D
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B821C21C53
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 00:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0A163;
	Sat, 20 Jul 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0nxK9TE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C3372
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434195; cv=none; b=O925T3n/ncpCr41gv2Bsou5uzAkVhlfe6UzIO5+1SbVkL2Z6vDn45xKY0LR8+N0F+9STg5ZHXT8z0e1c+TddWrhjsHwJMU9V5eaE4oJdfEQE02rqdoKurTl4prBEmMgLtUx803M0MC6X690P4zfQrBBmnQTQ/UqFis/tB5oP1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434195; c=relaxed/simple;
	bh=BW4gN2rUBhU1SaQmvAfCfTL+OCwexm9obXr29f/hAFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYbXUxJwjf3bpHgsz4kekuLRR0Tt1VGAl69AEX+b/5zFkGvNLAfk8fxYzfdA7C0p9/AOLSKfb8z22swrN3IxVDmxd8tjvOkMvioN2g2npWAXAvXZ+kIxnSQFkh2AGujeQsEF2HX6Ru6o4YmjF9k0y/FAhAdgpD16OW58Ip4GL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0nxK9TE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721434193; x=1752970193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BW4gN2rUBhU1SaQmvAfCfTL+OCwexm9obXr29f/hAFo=;
  b=H0nxK9TEHYfrsccFGFPir4XK8EpfxlqoUGbxCoT7RPOTZkDdoQTTmrIg
   RzZ9Ic4lXJVPsEzoQej8M/yJuWZPUnoCifWLW8/6zKebQCKZyXCVg172T
   jX6ysVDz0s5bPQN0iFPXLWBQJ2QJyay7DT0VaDp2znmQZgfxipMtKI+Pq
   jjxlKbB77q1fu5fj4swe/l5Mgs+ENmsgGgM7eopD+gR1A6FPvaBCkKf7c
   tjoQNwzTo6FoDskci6bspz0UpUA81xpBOL4O0mwtu1e0OjkqpQgShMAW3
   S3nA6Mx+RLHc73xCCGoY4SG+7VhbN+qIszkNysS9SlwK/CAEgtl9vvLTK
   A==;
X-CSE-ConnectionGUID: 7m97oWHsT2mE+xZrkt6viA==
X-CSE-MsgGUID: +E4Neu3fTfOd7v0tQqza4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="30462264"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="30462264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 17:09:53 -0700
X-CSE-ConnectionGUID: iwMpYaE7Ssu1/ADc/lS5RQ==
X-CSE-MsgGUID: RrE8RhBGSQeDcrDvIo1yEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="55457571"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jul 2024 17:09:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUxfZ-000ih6-0n;
	Sat, 20 Jul 2024 00:09:49 +0000
Date: Sat, 20 Jul 2024 08:09:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile
 and Kconfig
Message-ID: <202407200741.dMG9uvHU-lkp@intel.com>
References: <20240719062414.21953-7-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719062414.21953-7-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on linus/master next-20240719]
[cannot apply to wireless/main v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-8852bt-add-set_channel_rf/20240719-161236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240719062414.21953-7-pkshih%40realtek.com
patch subject: [PATCH v2 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240720/202407200741.dMG9uvHU-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407200741.dMG9uvHU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407200741.dMG9uvHU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c:1827:46: warning: operator '?:' has lower precedence than '&'; '&' will be evaluated first [-Wbitwise-conditional-parentheses]
    1827 |                     kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c:1827:46: note: place parentheses around the '&' expression to silence this warning
    1827 |                     kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
         |                                                            ^
         |                           (                               )
   drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c:1827:46: note: place parentheses around the '?:' expression to evaluate it first
    1827 |                     kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
         |                                                            ^                     
         |                                                (                                 )
   1 warning generated.


vim +1827 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c

f77c5179bc9f6f Ping-Ke Shih 2024-06-27  1807  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1808  static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool off)
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1809  {
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1810  	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1811  	u8 val, kidx = dpk->cur_idx[path];
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1812  	bool off_reverse;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1813  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1814  	val = dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1815  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1816  	if (off)
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1817  		off_reverse = false;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1818  	else
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1819  		off_reverse = true;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1820  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1821  	val = dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].path_ok;
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1822  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1823  	rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx << 2),
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1824  			       BIT(24), val);
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1825  
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1826  	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
5b8c61b82eec9e Ping-Ke Shih 2024-06-21 @1827  		    kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1828  }
5b8c61b82eec9e Ping-Ke Shih 2024-06-21  1829  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

