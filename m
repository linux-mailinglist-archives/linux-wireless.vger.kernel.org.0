Return-Path: <linux-wireless+bounces-7078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8648B8BF3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31791284CF5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2024 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33ED12E6A;
	Wed,  1 May 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYxZQvm+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97351DA24
	for <linux-wireless@vger.kernel.org>; Wed,  1 May 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574306; cv=none; b=lZt6DN5ESRsVFlNchDipEy1Dttk+8aTrK3wsksKV+BzI1rr0N3V9f/Hch+cU0NFwlAgWVeAjPOfwINbZCwFXr9kgb5n43Nq8VxyX16CHfOfqWqkwPFQtSHohY8oYj6ReLRYtPzlH/BkhN5p84xmoP8yleWtOEJ3tMI2Ouu3jvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574306; c=relaxed/simple;
	bh=SWLdma+jpiPY1r633JyGL5ZvVwl/diBWjEZruh4IVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhn3NOo6zvGNjGqWjhwjunquwM7JwAZzkjYFZ2ds8RiPPe6dvCtLi4WnKLw8l04YZUDgZVCIA+9bIgQq8QkWHlAfSM+RtCK2E5xOge5v+uV+88S5Z2gvbSV/gz1m+SODpVMKUpw05kRH4AZNt8GpXH6Hjl0L35IZLMv+7hjXXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYxZQvm+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714574305; x=1746110305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWLdma+jpiPY1r633JyGL5ZvVwl/diBWjEZruh4IVCE=;
  b=mYxZQvm+oz+hGMoIkT3jrQIHfmiw2p+KI5qFTeiX4nF+8zCGHo2joZsq
   vLkFWyJsMcgiZN9EFogLhy3cWRnK8XuIofWfiUiZvOcl595ISsSLtew22
   pjVAupJb19RGDXoEzSE0r5jAZIG2myNWx2BxG2ByU6Frnng/crThCMPz0
   djU5c0Ag3llmkQtZqJESHKRlZgVmenKJ2MbKDD2Kkgmhz2gscaeZHWD/H
   Nymf5Qka0YlZ47jWzfwNLmAMzs4k4jlMl/l+ZaESqDDx4Ptm6PHcBHwUA
   oaperpufo/EnKvIGQEKUJhB0bHoUAC6ZbioH0tM50u8IqpM7g6+XcrP84
   w==;
X-CSE-ConnectionGUID: wh8IGEiWSVWB71nmeAXMkA==
X-CSE-MsgGUID: HwgrhLymSaytLCZjG9n1CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10131817"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10131817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 07:38:24 -0700
X-CSE-ConnectionGUID: XdEIc8J+Q6+xvkTtpreZBA==
X-CSE-MsgGUID: oyUktwx1RWSO23ScbI8JOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="64279285"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 May 2024 07:38:23 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2B6C-0009c8-1m;
	Wed, 01 May 2024 14:38:20 +0000
Date: Wed, 1 May 2024 22:37:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gary.chang@realtek.com,
	timlee@realtek.com
Subject: Re: [PATCH 03/12] wifi: rtw89: wow: parsing Auth Key Management from
 associate request
Message-ID: <202405012221.MONGVGmf-lkp@intel.com>
References: <20240425112816.26431-4-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425112816.26431-4-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.9-rc6 next-20240501]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-wow-send-RFK-pre-nofity-H2C-command-in-WoWLAN-mode/20240425-193126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240425112816.26431-4-pkshih%40realtek.com
patch subject: [PATCH 03/12] wifi: rtw89: wow: parsing Auth Key Management from associate request
config: alpha-randconfig-r051-20240501 (https://download.01.org/0day-ci/archive/20240501/202405012221.MONGVGmf-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405012221.MONGVGmf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405012221.MONGVGmf-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/net/wireless/realtek/rtw89/core.o: in function `rtw89_traffic_stats_accu':
>> (.text+0x11e8): undefined reference to `rtw89_wow_parse_akm'
>> alpha-linux-ld: (.text+0x11f8): undefined reference to `rtw89_wow_parse_akm'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

