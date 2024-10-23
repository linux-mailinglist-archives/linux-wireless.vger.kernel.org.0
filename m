Return-Path: <linux-wireless+bounces-14341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C945C9ABB2A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACFB1C22578
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBCD335D3;
	Wed, 23 Oct 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An7Tbou/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF9381BA;
	Wed, 23 Oct 2024 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648404; cv=none; b=EYlv1nPUKm1uo+DXdQFCQgBy4ZmlyKOr9cVIJyb3YyW+iDeLrPV8V5F4xIiu8AvuCk/VwrjjornsIUgZnvQ34MILSN1uGwInA3ApbthM7DUWVAjoKcRQRzmj4iB9HehrpvtIE37X0SdMXQdCWfGJTPtlDBP1eKWtHMA2asS8IBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648404; c=relaxed/simple;
	bh=etsXsaSJkfi6ykKki7PupjthMRYjma2o0HVhuLjg5gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiRuwZwln4x3SJGOmLW1DVkwf5lt0RBNkibVHv2qzsNOdrV+cGHJoiQg8eg1coIlKYNy79GyGskWYKd4+SSyQKSGyOzv0OzbfpyZuhpvmI4rqVyoGXKP7eo+NSlXPXEJ5Cnokh4rvDPjDPTM0I0t38JHzo7a4emabqcuDLnWArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An7Tbou/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729648403; x=1761184403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etsXsaSJkfi6ykKki7PupjthMRYjma2o0HVhuLjg5gs=;
  b=An7Tbou/t/P+IDjU+f00L+UOdJJUgfv4OfndOXV0gcd0hR8kIJ7ynpZ8
   PT3AQksCYDM3Wpox/rNV48S+uqFgmj5VtNzyOY1V8ZD5hD7I89T0TB2eo
   wPVi3HkzUrU1Nz0wQCnHdZg2o4S2WVwGPxvwZgVbo5Uhix1DMUV3AdFcZ
   9q1lSrWJOU3syomqJVHsVcid8DP7YkfyEmkQXX2Uml2wiUk/VXbuxHQte
   j/Pv3z8720KO+2YBhYXnPVPDkNm+qUeLtFU1W5tSMBpMxTTX2xYDb+v3x
   YmIxkPGhXV92QteSW5BZu9Zjkxr+e0h01urqpOXulK8oUJIZU/lWL6Zwb
   g==;
X-CSE-ConnectionGUID: XCQJEvM+Q6yGwVwNXl/rjw==
X-CSE-MsgGUID: 1Gg+AnucRMqfqw17xTZ2uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29443994"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29443994"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:53:22 -0700
X-CSE-ConnectionGUID: 1rUas4VXTvCndk6pYVkyDQ==
X-CSE-MsgGUID: kJjo80jtRDidq+9fhhITJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80460390"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2024 18:53:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3QYl-000UL8-1V;
	Wed, 23 Oct 2024 01:53:15 +0000
Date: Wed, 23 Oct 2024 09:53:14 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Marek Vasut <marex@denx.de>,
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
Message-ID: <202410230937.zWSJkSuE-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241023/202410230937.zWSJkSuE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230937.zWSJkSuE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230937.zWSJkSuE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from drivers/net/wireless/microchip/wilc1000/spi.c:7:
   drivers/net/wireless/microchip/wilc1000/spi.c: In function 'wilc_spi_claim':
>> drivers/net/wireless/microchip/wilc1000/spi.c:1113:25: error: 'struct wilc' has no member named 'hif_cs'
    1113 |         mutex_lock(&wilc->hif_cs);
         |                         ^~
   include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
   drivers/net/wireless/microchip/wilc1000/spi.c: In function 'wilc_spi_release':
   drivers/net/wireless/microchip/wilc1000/spi.c:1118:27: error: 'struct wilc' has no member named 'hif_cs'
    1118 |         mutex_unlock(&wilc->hif_cs);
         |                           ^~
   drivers/net/wireless/microchip/wilc1000/spi.c: In function 'wilc_spi_deinit':
   drivers/net/wireless/microchip/wilc1000/spi.c:1147:28: error: 'struct wilc' has no member named 'hif_cs'
    1147 |         mutex_destroy(&wilc->hif_cs);
         |                            ^~
   drivers/net/wireless/microchip/wilc1000/spi.c: In function 'wilc_spi_init':
>> drivers/net/wireless/microchip/wilc1000/spi.c:1156:21: error: 'spi' undeclared (first use in this function)
    1156 |         mutex_init(&spi->hif_cs);
         |                     ^~~
   include/linux/mutex.h:64:23: note: in definition of macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^~~~~
   drivers/net/wireless/microchip/wilc1000/spi.c:1156:21: note: each undeclared identifier is reported only once for each function it appears in
    1156 |         mutex_init(&spi->hif_cs);
         |                     ^~~
   include/linux/mutex.h:64:23: note: in definition of macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^~~~~
   drivers/net/wireless/microchip/wilc1000/spi.c: At top level:
>> drivers/net/wireless/microchip/wilc1000/spi.c:1116:13: warning: 'wilc_spi_release' defined but not used [-Wunused-function]
    1116 | static void wilc_spi_release(struct wilc *wilc)
         |             ^~~~~~~~~~~~~~~~
>> drivers/net/wireless/microchip/wilc1000/spi.c:1111:13: warning: 'wilc_spi_claim' defined but not used [-Wunused-function]
    1111 | static void wilc_spi_claim(struct wilc *wilc)
         |             ^~~~~~~~~~~~~~


vim +1113 drivers/net/wireless/microchip/wilc1000/spi.c

  1105	
  1106	/********************************************
  1107	 *
  1108	 *      Bus interfaces
  1109	 *
  1110	 ********************************************/
> 1111	static void wilc_spi_claim(struct wilc *wilc)
  1112	{
> 1113		mutex_lock(&wilc->hif_cs);
  1114	}
  1115	
> 1116	static void wilc_spi_release(struct wilc *wilc)
  1117	{
  1118		mutex_unlock(&wilc->hif_cs);
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

