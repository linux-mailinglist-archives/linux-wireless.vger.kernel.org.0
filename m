Return-Path: <linux-wireless+bounces-14339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B5F9AB7AA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC68A282B67
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750781CBEAF;
	Tue, 22 Oct 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq+HCdt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974371CBE96;
	Tue, 22 Oct 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629250; cv=none; b=FLFibGdjeaGUYYaHzXr2ZbCTCyKXQTThV34MzTugngXzb7h60N6/xqt43aVtqOIXRAWzIArQmme4lLHYf7pI1ZhGPvWnYCLsqEJ9AZo3f09CvFBc6zngEFep2s9iMHMh/V1XCejTi+nRul9phpH1knp9m9lv5D7/ziX+wQu3yeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629250; c=relaxed/simple;
	bh=WgzrqH7Ou+v7onWU0ZHkjotFVPe78dy1lzEo/B5qjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBa+e09CLQoXN7jFtdmtqnhjcf5g07rFmXxZOO866ErK5FoaB2EQmKNxPKooR2fOMZjeiSsWHE8DpaOIwl79uZGJC5vjLW11gLO7cEx6zQm6AuECAm7+R6h4RXljcxThHB4FBJ4DJOHWh9PZBH61m/tQzHD1ykr/ulM/hVqkh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq+HCdt6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729629247; x=1761165247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WgzrqH7Ou+v7onWU0ZHkjotFVPe78dy1lzEo/B5qjhI=;
  b=dq+HCdt630lFbrF60EFMsWIMfIS9Erzdhu0K0XZAfqZ6RQ8WjBbVLXOg
   Jcx1Qahof4BPnZS/EfKzwTuFYV245HVE71ZnJ6ZcQqDm9i0vwxtAop4vf
   4M7Tudqjqbqsdxr2sSdMh6nxJbNDmk5ivk7wJHp6GSltfq2RaWoZRRQZQ
   u5yzHDO08djNh56Oed0mw5uRHHsdUvhOr/sNY9D7mBe39PJl/NbtUzYRN
   ka/yIabDvnkoE786k3X4fDfx3v8ouPo14Dd/722z2qeqtJtZtPTq00QrF
   FsFMW0M+WK3QX3jqTMPzin65GLXahOyYphjsAXxX3iFRSKHMTMIZSbb1T
   g==;
X-CSE-ConnectionGUID: G0Z8SYUDT0mIt7nVdoVYaA==
X-CSE-MsgGUID: gl6e6zwGQFCL4VnAr7kTCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32047521"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="32047521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 13:34:06 -0700
X-CSE-ConnectionGUID: BBP0oiVFQrWYxbZ7Qe6U2A==
X-CSE-MsgGUID: iJAnuQEMRZy6YCDBld6ITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84801727"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Oct 2024 13:34:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3LZo-000U4K-1B;
	Tue, 22 Oct 2024 20:34:00 +0000
Date: Wed, 23 Oct 2024 04:33:00 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: wilc1000: Rework bus locking
Message-ID: <202410230402.Cgu8obYR-lkp@intel.com>
References: <20241022013855.284783-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022013855.284783-1-marex@denx.de>

Hi Marek,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20241022]
[cannot apply to wireless/main linus/master v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Vasut/wifi-wilc1000-Rework-bus-locking/20241022-093954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241022013855.284783-1-marex%40denx.de
patch subject: [PATCH] wifi: wilc1000: Rework bus locking
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241023/202410230402.Cgu8obYR-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230402.Cgu8obYR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230402.Cgu8obYR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/microchip/wilc1000/spi.c:1113:20: error: no member named 'hif_cs' in 'struct wilc'
    1113 |         mutex_lock(&wilc->hif_cs);
         |                     ~~~~  ^
   include/linux/mutex.h:166:44: note: expanded from macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
   drivers/net/wireless/microchip/wilc1000/spi.c:1118:22: error: no member named 'hif_cs' in 'struct wilc'
    1118 |         mutex_unlock(&wilc->hif_cs);
         |                       ~~~~  ^
   drivers/net/wireless/microchip/wilc1000/spi.c:1147:23: error: no member named 'hif_cs' in 'struct wilc'
    1147 |         mutex_destroy(&wilc->hif_cs);
         |                        ~~~~  ^
>> drivers/net/wireless/microchip/wilc1000/spi.c:1156:14: error: use of undeclared identifier 'spi'
    1156 |         mutex_init(&spi->hif_cs);
         |                     ^
>> drivers/net/wireless/microchip/wilc1000/spi.c:1156:14: error: use of undeclared identifier 'spi'
   5 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +1113 drivers/net/wireless/microchip/wilc1000/spi.c

  1105	
  1106	/********************************************
  1107	 *
  1108	 *      Bus interfaces
  1109	 *
  1110	 ********************************************/
  1111	static void wilc_spi_claim(struct wilc *wilc)
  1112	{
> 1113		mutex_lock(&wilc->hif_cs);
  1114	}
  1115	
  1116	static void wilc_spi_release(struct wilc *wilc)
  1117	{
> 1118		mutex_unlock(&wilc->hif_cs);
  1119	}
  1120	
  1121	static int wilc_spi_reset(struct wilc *wilc)
  1122	{
  1123		struct spi_device *spi = to_spi_device(wilc->dev);
  1124		struct wilc_spi *spi_priv = wilc->bus_data;
  1125		int result;
  1126	
  1127		result = wilc_spi_special_cmd(wilc, CMD_RESET);
  1128		if (result && !spi_priv->probing_crc)
  1129			dev_err(&spi->dev, "Failed cmd reset\n");
  1130	
  1131		return result;
  1132	}
  1133	
  1134	static bool wilc_spi_is_init(struct wilc *wilc)
  1135	{
  1136		struct wilc_spi *spi_priv = wilc->bus_data;
  1137	
  1138		return spi_priv->isinit;
  1139	}
  1140	
  1141	static int wilc_spi_deinit(struct wilc *wilc)
  1142	{
  1143		struct wilc_spi *spi_priv = wilc->bus_data;
  1144	
  1145		spi_priv->isinit = false;
  1146		wilc_wlan_power(wilc, false);
  1147		mutex_destroy(&wilc->hif_cs);
  1148		return 0;
  1149	}
  1150	
  1151	static int wilc_spi_init(struct wilc *wilc, bool resume)
  1152	{
  1153		struct wilc_spi *spi_priv = wilc->bus_data;
  1154		int ret;
  1155	
> 1156		mutex_init(&spi->hif_cs);
  1157	
  1158		if (spi_priv->isinit) {
  1159			/* Confirm we can read chipid register without error: */
  1160			if (wilc_validate_chipid(wilc) == 0)
  1161				return 0;
  1162		}
  1163	
  1164		wilc_wlan_power(wilc, true);
  1165	
  1166		ret = wilc_spi_configure_bus_protocol(wilc);
  1167		if (ret) {
  1168			wilc_wlan_power(wilc, false);
  1169			return ret;
  1170		}
  1171	
  1172		spi_priv->isinit = true;
  1173	
  1174		return 0;
  1175	}
  1176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

