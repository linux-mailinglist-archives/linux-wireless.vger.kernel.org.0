Return-Path: <linux-wireless+bounces-1989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEE82F345
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 18:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77B51C236FA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684D1CAAC;
	Tue, 16 Jan 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx67+mxA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC81CABA
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426467; cv=none; b=V5wovgSgFn1RNPiKL0tHMs6eDF+mzQvYWdo4+TxTMePOlPTLCFWrrjVAQ1EENZmWfd4RrVBX7X+E7EMFSG1hJz2oup2Ux+K0zIM5w8RHlfTxZHTGI6zlB5nNyXEviYnQ2hx0GalI+DmnDhT0CYknfuKceh/VlNm6Eum+a7Xg6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426467; c=relaxed/simple;
	bh=kN4tXKxMcqWmj5n0iAp3DXXMvRuBtkCGEFI+G4GUgJQ=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	b=GqtlE1AsPWEyuG3yEZcQ4tIP5IJ8Wt5iHIuiPRXFEVY9mDbCnRrGm0OG80dQV2hqXGSdY2tgy31Rdw6/Lr3wpTqRjm6ISEDhZp7h+08S9Fka2UYjT9q+Y+S7IRpW6OiaWhQKDZKkFM8YwuXBnY2YtMh2/9Db/NdpVeFac/zJ+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx67+mxA; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705426466; x=1736962466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kN4tXKxMcqWmj5n0iAp3DXXMvRuBtkCGEFI+G4GUgJQ=;
  b=Hx67+mxAizPMOuEOCv2lnqoMqIcAfymEx0V6tB/tJpCfwcNfeB/fab4o
   fqbOqJnEMo1MGO+AD+moEj3OxcadaOp1i+BtEplIWy9CY7W9wez9YNbrp
   ETvHDSeJRq7/gRoxRu70EOJtwYcpavMowlpR3Dmzd3Sok4frLZ7LgxQE9
   g4/Cu9Z6FOAYA54GVoKNozg7xEBENvPcghrcif9gGVvH2CH35vZh6Mi4Z
   0zgbeNFd3pAkZF/omXAJMjaoKXwfInb+iXcPVbSyeEAc4gnYlgSZ+wozf
   tDvjyNyRvyxqTnTAdWkCAaU1w/dcEBqw7CPtQHuHcHsEJ4n/rpNRKUOPM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13286356"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="13286356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="787520639"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="787520639"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2024 09:34:21 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPnKN-00010w-26;
	Tue, 16 Jan 2024 17:34:19 +0000
Date: Wed, 17 Jan 2024 01:33:33 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [wireless-next:main 34/56]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7668:30: sparse:
 sparse: symbol 'rtl8xxxu_limits' was not declared. Should it be static?
Message-ID: <202401170132.Yz1gBFOg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   ece90a8622320bf5a24d3326da1f8e109891573c
commit: 1cd165adf314f6bf25cde58f02f4ff51d01730b0 [34/56] wifi: rtl8xxxu: declare concurrent mode support for 8188f
config: riscv-randconfig-r132-20240116 (https://download.01.org/0day-ci/archive/20240117/202401170132.Yz1gBFOg-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170132.Yz1gBFOg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170132.Yz1gBFOg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse: sparse: invalid assignment: |=
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    left side has type restricted __le32
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    right side has type unsigned long
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7668:30: sparse: sparse: symbol 'rtl8xxxu_limits' was not declared. Should it be static?
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7673:36: sparse: sparse: symbol 'rtl8xxxu_combinations' was not declared. Should it be static?
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/rtl8xxxu_limits +7668 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c

  7667	
> 7668	struct ieee80211_iface_limit rtl8xxxu_limits[] = {
  7669		{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
  7670		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
  7671	};
  7672	
> 7673	struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
  7674		{
  7675			.limits = rtl8xxxu_limits,
  7676			.n_limits = ARRAY_SIZE(rtl8xxxu_limits),
  7677			.max_interfaces = 2,
  7678			.num_different_channels = 1,
  7679		},
  7680	};
  7681	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

