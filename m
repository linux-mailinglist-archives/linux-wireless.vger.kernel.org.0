Return-Path: <linux-wireless+bounces-29430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73892C94671
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17FAF4E028C
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Nov 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB523EABC;
	Sat, 29 Nov 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiLPhsT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7051F4C8E
	for <linux-wireless@vger.kernel.org>; Sat, 29 Nov 2025 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440487; cv=none; b=He2ii8MQz/mxsz+KBmOCM5sYCui9CG75+/TPMbr1x7yHsRAiklvvlBZb6zYvQHUDh5sFyBTErIIvW2JsfSi64zqnO88aT62aFuRx0aQcPJEb4MymPwRa9tK3KlVE1vfhwGFS9JOX0VO3U3FgLoqurDnsNNiOZrCdGMTIq33yWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440487; c=relaxed/simple;
	bh=4LgWEqhh4x/QjDiw2M5AJx+AzDH1JxuNzoKnubPyyoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD1ny+ANzUWdQGnjcnaU82X/EWR3pttE1bZcm5mM2y9jmsQrCdL04pExF0ySlCXOdxtgU5rGXvsvQC2TAUWbhH4jBqlNqhxNwV1a/jFM1BvEnsqW/AzY2a3zgkv3lVp46sWhOyMjNT7nVV09e3My5ymaZI6bvPsZNSWYrqH9AAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiLPhsT3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764440484; x=1795976484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4LgWEqhh4x/QjDiw2M5AJx+AzDH1JxuNzoKnubPyyoQ=;
  b=LiLPhsT321jj5aH1EpB8c7P8+AC6+b8qoxz6YvbXd+ivLEW437M+RzYj
   K06NuMZQcAMcGikGmstGkF7SHUKtMH0oi4GRXJ6AzBReIpASki3GcjwfH
   PR8MySu/LjvO6JKekfapAdxDYXu8ac6gQeWK3RiB88KBBYJLFTKwp4Tsu
   Z+uU+OybcmXXJEn8N45415OKottiKK8VGHsLJAupe6Bvc3cPazOvfaRM1
   TH3NStZLk8vCyGG178L0LjedrXHfH8v5zPluN8J/Zm0LzAxaOo0haPbvk
   RoLk26wUwO14S6t43rNTYXojb+xgdUHdwrxAvBfqx0/RlboS7SzSJKgnz
   w==;
X-CSE-ConnectionGUID: Op0DYx1dSO2ymUueisPuig==
X-CSE-MsgGUID: bZImHwPHTwun4gz9Hx9dcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="66501012"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="66501012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 10:21:23 -0800
X-CSE-ConnectionGUID: 75NGRgwaSpu8xCyMjH8gYA==
X-CSE-MsgGUID: hEcGZ+1dQ/+UWOrJZTZ/5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="193484683"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Nov 2025 10:21:23 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPPZR-000000007S9-1xCN;
	Sat, 29 Nov 2025 18:21:21 +0000
Date: Sun, 30 Nov 2025 02:21:20 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH wireless-next 08/18] wifi: mac80211_hwsim: register
 beacon timer by calculating TBTT
Message-ID: <202511300113.51AU1w5w-lkp@intel.com>
References: <20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.18-rc7 next-20251128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/wifi-mac80211_hwsim-fix-typo-in-frequency-notification/20251128-222914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae%40changeid
patch subject: [PATCH wireless-next 08/18] wifi: mac80211_hwsim: register beacon timer by calculating TBTT
config: i386-randconfig-004-20251129 (https://download.01.org/0day-ci/archive/20251130/202511300113.51AU1w5w-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251130/202511300113.51AU1w5w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511300113.51AU1w5w-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/net/wireless/virtual/mac80211_hwsim.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

