Return-Path: <linux-wireless+bounces-10385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B79093741D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C53282765
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502663EA6C;
	Fri, 19 Jul 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUsUqSKj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893D3D984
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721371693; cv=none; b=SEcbKiqbD99u71nkZXGdXy+kbadztisssuhhbabNERrbQO8pi9l3+WHPg1qi70ud34t8ICaF4FN+O4eRsXvDulHTy8Gm7o+9vYxxTLIpjM/KNBMwLOkAnmRVfp57Gl986tLG9RSwQMjJ+BjehzaiIch+UvNzMdeI26LGdqe2lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721371693; c=relaxed/simple;
	bh=1J+TbzgOGOue2PICHcbZ/lJ1gks4zEPS4UOBxrC0vEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFu/+xVSnj4d/Kb6yrYnlfvZeqedBpRoELM6KXWAxy37hWfV6JL5HoPWHyq8exKoIeaNU/exBWe/8qMrUae2biIpT06hIrh58mQ2zVlUvP6mMPLxAvc/07VklWdXW+hVd5mhi7ohkwtM9hx1QRnQJO1eG+VUxyeQKrJF42Lq9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUsUqSKj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721371690; x=1752907690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1J+TbzgOGOue2PICHcbZ/lJ1gks4zEPS4UOBxrC0vEk=;
  b=jUsUqSKj/NdsT0eUZZcqTuWN9dOLjV2jyo8denu7ra4T/nw4dDvKcu/n
   MSy5Aq9K9CPnwVyPj8VK7jtpToiOjBFEVYlnhNxBrqPNZBPCoikyCuwVg
   pc2QMKsLCpLoASOZWXB9QvoWUIq2dfrbXVzNUkdsZPSfbt9UV8E9QI3YE
   N0QGVNI13nZl0g9BZG13PlORygtU5HDMLJ08eW9aXoUSMOJmZFdS+O41z
   /89Oy7B0DO+4UUaq0NN2XSr1QOxLIeZVWiKton4rk+0Vy3W3E9+0CzRoq
   61vGu46D5TJ2w7AQZkFFWXxa2a/aBZg655GW7lxladC5ylX3LsAfT9fsY
   A==;
X-CSE-ConnectionGUID: PUtJlqjuR9+wwMd0ykIISw==
X-CSE-MsgGUID: Rb0bWwmvSOWmHQS9+rXJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18843583"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="18843583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 23:48:09 -0700
X-CSE-ConnectionGUID: zyE0tJpuT8+sZVNn8slXZg==
X-CSE-MsgGUID: 5cOYAFhETAGbAOh9UcHeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="50888002"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2024 23:48:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUhPS-000hwP-0U;
	Fri, 19 Jul 2024 06:48:06 +0000
Date: Fri, 19 Jul 2024 14:47:39 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and
 Kconfig
Message-ID: <202407191402.diNZbCgq-lkp@intel.com>
References: <20240718025138.18777-7-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718025138.18777-7-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on linus/master next-20240718]
[cannot apply to wireless/main v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-8852bt-add-set_channel_rf/20240718-105447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240718025138.18777-7-pkshih%40realtek.com
patch subject: [PATCH 6/6] wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240719/202407191402.diNZbCgq-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407191402.diNZbCgq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407191402.diNZbCgq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> hppa-linux-ld: drivers/net/wireless/realtek/rtw89/rtw8852bte.o:(.rodata+0x40): undefined reference to `rtw8852bt_chip_info'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

