Return-Path: <linux-wireless+bounces-4656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4D587A01A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 01:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180DE282F87
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A92F35;
	Wed, 13 Mar 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlcKseUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC132F3B
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289171; cv=none; b=seX7YAhE9CUYgS9R280b+tI+yrJbDQoq5FkWiG/TE3P/2l+rqkCFGLgS/OIqDXhrAfDyRNWgqGdmRr9qGk71l4hQB333Jc/i5JV4DLtpCaOEIHs8k5OSos6PPxu/vfYduqrEMobsKyfJVCJ2xYzlwfsOndzdwirGP2kgaICSjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289171; c=relaxed/simple;
	bh=DJpWZ1vlGdy0NJA2FqiyUz2X2xIpFjkMC95MRL1g8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y7+t3jL6HwG5Ul48BSTzAYQzvYqDUHShcrUdvH96vlZWqwjlZFqG0z1bG4kPAZc4B3EC+pR0B1MYGdUo5rKKR16Z0E5OTjGeYYgcG0GYIC4uwj6ETn1QKEeGaMvVX3ug1cr20wlEMqrW9D0DplA3Qd4KstLn5h6H3pd1HeLzUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlcKseUT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710289169; x=1741825169;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DJpWZ1vlGdy0NJA2FqiyUz2X2xIpFjkMC95MRL1g8wY=;
  b=XlcKseUTQo6AHa3cLIn9axvmH2JHhI00SP4uW+SF095UITG2C1MQg/al
   SWtAN9NxHXXR2rrvSBaWWy5qdwZMcZpD+ZP8CXuwadQbmWvRC6jqRiRwT
   BWsY8Gbu8f8lBln1DVqlLBzE2moEO3iRZj8o9KrWAwu/q7r3SfyxNtYVx
   V/57xj6yBrqG3CWROWGFqT2QGfsjU/UvKb9pkl9ibUKntiZGq7cj5sIq/
   YjkENfu/rUavCBso+LtD6Dk1yPcnxwZc0hQsnYzFz0lnK/6KOkPGMggP6
   HECM/p0s2REkFYV6d62OlpfRC4K5qLkhpL0C/33IrZG6tP9WkSJuS5lkH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4899300"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4899300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11652238"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Mar 2024 17:19:26 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkCL6-000Bpb-1n;
	Wed, 13 Mar 2024 00:19:24 +0000
Date: Wed, 13 Mar 2024 08:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main 6/6] drivers/ssb/main.c:1148:2: error: label at
 end of compound statement
Message-ID: <202403130813.Dz0M53DR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   e27b02e23a701e5761f1d6028643e1203a1c56de
commit: e27b02e23a701e5761f1d6028643e1203a1c56de [6/6] ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
config: i386-buildonly-randconfig-006-20240313 (https://download.01.org/0day-ci/archive/20240313/202403130813.Dz0M53DR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403130813.Dz0M53DR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403130813.Dz0M53DR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ssb/main.c: In function 'ssb_dma_translation':
>> drivers/ssb/main.c:1148:2: error: label at end of compound statement
    1148 |  default:
         |  ^~~~~~~


vim +1148 drivers/ssb/main.c

04023afcce2eaf Rafał Miłecki  2011-08-14  1132  
61e115a56d1aaf Michael Buesch 2007-09-18  1133  u32 ssb_dma_translation(struct ssb_device *dev)
61e115a56d1aaf Michael Buesch 2007-09-18  1134  {
61e115a56d1aaf Michael Buesch 2007-09-18  1135  	switch (dev->bus->bustype) {
61e115a56d1aaf Michael Buesch 2007-09-18  1136  	case SSB_BUSTYPE_SSB:
61e115a56d1aaf Michael Buesch 2007-09-18  1137  		return 0;
61e115a56d1aaf Michael Buesch 2007-09-18  1138  	case SSB_BUSTYPE_PCI:
04023afcce2eaf Rafał Miłecki  2011-08-14  1139  		if (pci_is_pcie(dev->bus->host_pci) &&
04023afcce2eaf Rafał Miłecki  2011-08-14  1140  		    ssb_read32(dev, SSB_TMSHIGH) & SSB_TMSHIGH_DMA64) {
04023afcce2eaf Rafał Miłecki  2011-08-14  1141  			return SSB_PCIE_DMA_H32;
04023afcce2eaf Rafał Miłecki  2011-08-14  1142  		} else {
04023afcce2eaf Rafał Miłecki  2011-08-14  1143  			if (ssb_dma_translation_special_bit(dev))
a9770a815d280d Rafał Miłecki  2011-07-20  1144  				return SSB_PCIE_DMA_H32;
a9770a815d280d Rafał Miłecki  2011-07-20  1145  			else
61e115a56d1aaf Michael Buesch 2007-09-18  1146  				return SSB_PCI_DMA;
04023afcce2eaf Rafał Miłecki  2011-08-14  1147  		}
f225763a7d6c92 Michael Buesch 2008-06-20 @1148  	default:
61e115a56d1aaf Michael Buesch 2007-09-18  1149  	}
61e115a56d1aaf Michael Buesch 2007-09-18  1150  	return 0;
61e115a56d1aaf Michael Buesch 2007-09-18  1151  }
61e115a56d1aaf Michael Buesch 2007-09-18  1152  EXPORT_SYMBOL(ssb_dma_translation);
61e115a56d1aaf Michael Buesch 2007-09-18  1153  

:::::: The code at line 1148 was first introduced by commit
:::::: f225763a7d6c92c4932dbd528437997078496fcc ssb, b43, b43legacy, b44: Rewrite SSB DMA API

:::::: TO: Michael Buesch <mb@bu3sch.de>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

