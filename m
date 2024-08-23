Return-Path: <linux-wireless+bounces-11868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6C95D4CC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A0428453D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522E19069B;
	Fri, 23 Aug 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K96QQ8l5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588518BC3A;
	Fri, 23 Aug 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436042; cv=none; b=JX0s7cGWOLbD5t2/6OzxGM4+kSSl9mOnHBPWF6+2889zD1SsPzx3wBlZ7dXLHIQlSp3NJPxnL+ok5uX6JQr1il7kOlu1nGRpBSuiWURTlS7orgZ52bCjFoR98j0W5supznIMlYyQ4hgRP2fCtyDUmXm4+FsMFOxmXhK8ajo34Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436042; c=relaxed/simple;
	bh=v9b8ku+jaIyD4fFRQI5X0MarrR1Ax2rFNTA+C2B5iK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLTRhvwZ2AkP4zXdIN1i4lr9ZnY1qlt94eHCHdMV7K5hAQfrVFigI9G5e+Yic9iE4kS6Y183wye+y1yIMZFG2Qzw5Uffcrwc7ow6OgV1ONiZqhKBXt4UciHF83J58mTq4j469Mc5AAvfQT2GwLUfWNJWMxx1HnYK818roXZUI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K96QQ8l5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724436041; x=1755972041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9b8ku+jaIyD4fFRQI5X0MarrR1Ax2rFNTA+C2B5iK0=;
  b=K96QQ8l5w6ERK2lJDaNwREnHIC9MfUGu1WjVwzegYq7Cs7Ls9mogbOmH
   cw4/WUuBjOv1wpuTOwkoDk2tG99X78wp6a5PYF8nq6pFyqBW+oefLQhcZ
   SJFT3CMP/EXZA3TtYKaG9G4t4yxUPPfaYR+j8H6Edwz920x0urdK1y7ii
   J2oX6g8uM7SdWtYU45QfP6cQazr+qSlcg6YJ95AbhGlVSU6pTCkb2ddOg
   gnwfOTjbbarj2laF7NaqcWeApDYscHrvgaybemeCsayGDHSOVQJ+hIKFz
   sy2OpHcPYl+EDGQvI75jQewdJUp0OekNFef3rGchEyaCI9Yap20jNxjFF
   w==;
X-CSE-ConnectionGUID: vQ3s6ha6T7GmFTma09aUyg==
X-CSE-MsgGUID: ML4ql6Q1QsW3om6t2HIYrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22442057"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="22442057"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 11:00:40 -0700
X-CSE-ConnectionGUID: Krn4UcabSkKYPMgYk8oWRA==
X-CSE-MsgGUID: 85gS8c3wRYCX4KpbpuU53A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61885197"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Aug 2024 11:00:36 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shYaQ-000Dvo-01;
	Fri, 23 Aug 2024 18:00:34 +0000
Date: Sat, 24 Aug 2024 02:00:08 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ajay Singh <ajay.kathat@microchip.com>,
	Marek Vasut <marex@denx.de>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
Message-ID: <202408240116.5VwA6jhI-lkp@intel.com>
References: <20240821184356.163816-2-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821184356.163816-2-marex@denx.de>

Hi Marek,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main net-next/main net/main linus/master v6.11-rc4 next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Vasut/wifi-wilc1000-Add-WILC3000-support/20240822-024553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240821184356.163816-2-marex%40denx.de
patch subject: [PATCH 2/2] wifi: wilc1000: Add WILC3000 support
config: i386-randconfig-054-20240823 (https://download.01.org/0day-ci/archive/20240824/202408240116.5VwA6jhI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408240116.5VwA6jhI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408240116.5VwA6jhI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
>> ERROR: modpost: "wilc_get_chipid" [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
ERROR: modpost: "usb_alloc_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_free_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_anchor_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_submit_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_unanchor_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_kill_anchored_urbs" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_control_msg" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_set_interface" [drivers/bluetooth/btmtk.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

