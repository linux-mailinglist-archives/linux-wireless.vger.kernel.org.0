Return-Path: <linux-wireless+bounces-3097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F10848CF5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 11:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF77D1F22063
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134B219E0;
	Sun,  4 Feb 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5tLSkNI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB92137A
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043711; cv=none; b=VMHgrNxaBJWWbAZiHLrcanUpsP90c5VArPD4+JFsSGYHTD1u+afwGa135KPVz9Mj7NCAY56YotSt3ijhonPaGDgCTpeFkd4uwFhUkW0EjvQ66winsNEatsED0xr9e8WueHFEYVDzG7Wl2ft6O71ScGrGfVhe8ZYpt+Vrgdn1L8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043711; c=relaxed/simple;
	bh=m0UKWlOKYZcqm4JvgzpiFa8bLkFvDr+cxVmXwmtg/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mIJq2xzsTq3UXXZH990+lwQem1iE8iJ7a+g01FeX3IZ1wyYMgxbPh9zoNJw+CGzZNGV35WiRdcrGoiTSEuxVCNzbKKlb1uvdoYetT0lIgiPgFlIdbHhA6laopuVmLuUEvq3V//+vrMSmMsUTs/OEB4aUbWj090W1fBWfcJnx0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5tLSkNI; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707043709; x=1738579709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m0UKWlOKYZcqm4JvgzpiFa8bLkFvDr+cxVmXwmtg/sY=;
  b=A5tLSkNIm5/FiZQkCHV0BigfmbZX0rS/M1QnJkgX9sw0qhFd+urDot8F
   dD6ts34ydvJEVsS91LikMBPpgux7vHRYfusJs/RSMTYeZcr50E4r2oFNr
   fA+k+rMrhPSkPX6yCUjx2pCelUOpH5exMhLnsGJOoEYXIzg5pn7iMr7fq
   ht773QTI6dr1k/jCquQc2fdWlnZHmAn8jGVmvzQNP5s1AGKwHPyvKxR2m
   DdexCNBJR8XxQ/GhqkqIoEMJfsxk3rQO+ubAvsqqQZq0usyYxVq0y99n/
   cuP+0cPjrRJHA8ySh+RUX845c0pA888bhq2vthiR2CKQyyR3sUxXK2KxU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="394807974"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="394807974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 02:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5097347"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Feb 2024 02:48:24 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWa2v-0006GO-2z;
	Sun, 04 Feb 2024 10:48:21 +0000
Date: Sun, 4 Feb 2024 18:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [wireless-next:main 29/68] ERROR: modpost: vmlinux: local symbol
 'cfg80211_free_coloc_ap_list' was exported
Message-ID: <202402041855.pihpkv00-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   5932ad87828b267649d750869c89c0f1a3873477
commit: 45d43937a44c806b8649323b8f5d9f42ae838b0e [29/68] wifi: cfg80211: add a kunit test for 6 GHz colocated AP parsing
config: i386-randconfig-016-20240204 (https://download.01.org/0day-ci/archive/20240204/202402041855.pihpkv00-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041855.pihpkv00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041855.pihpkv00-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> ERROR: modpost: vmlinux: local symbol 'cfg80211_free_coloc_ap_list' was exported
>> ERROR: modpost: vmlinux: local symbol 'cfg80211_parse_colocated_ap' was exported
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/crypto/crc32-pclmul.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/time_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp864.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp869.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp874.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp936.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp950.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-7.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp1255.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-13.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-15.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-gaelic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-roman.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/minix/minix.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/fat/fat_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ufs/ufs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx4/qnx4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/btrfs/btrfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/apparmor/apparmor_policy_unpack_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/xor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/kunit/kunit-example-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_deflate/zlib_deflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/backlight/platform_lcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/vfb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/acpi_tad.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/custom_method.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/clk_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/lp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ppdev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/tlclk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi-avmm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/rt4831.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/firewire-uapi-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/storage/uas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/libcomposite.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_acm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ss_lb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_serial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_obex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/u_ether.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_phonet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_eem.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_ecm_subset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_rndis.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_mass_storage.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_fs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_tcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/legacy/g_zero.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/legacy/g_dbgp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/watchdog/twl4030_wdt.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/chrome/cros_kunit_proto_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/video/fbdev.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

