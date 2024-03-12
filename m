Return-Path: <linux-wireless+bounces-4652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A75879FA7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592991C20FD6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317014293;
	Tue, 12 Mar 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoQrbI9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0146551
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285868; cv=none; b=qBCvkiB3heQ7tjWbtm+ZBvDG0JQ4VjiUa21MvQcvPe/SH+XV0fQlM2QR5wbw5G5+Ziw590j1XxNCh37kcCAAixm3xqWv8kzGzpPelMgmfTBAdkZeCDSdxY7rFV/ZL0Wr/iucBan2ooY81XUwIngwItopzao22rNBNElcg+M6evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285868; c=relaxed/simple;
	bh=bVz6/tW2fQOIBFFrv5Bm2bT3SqRIIUyQ5B9R5ZlCGRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZOn7YbIs/JQxnAWay8ncEWyXDVyEi9koG2cyk6B+Q/mREn+HRSVSCK3ImaDHjWVPeIKCrPxuEER7aqMFx6u+opBV0gklz/7+4SJIOF32WThmeSqOr9Q3I8i6qu/4P1ivjaVgJXRu0K9qc0sypcwRYt5qXDVGBogmHjMr7HWeXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoQrbI9k; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710285867; x=1741821867;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bVz6/tW2fQOIBFFrv5Bm2bT3SqRIIUyQ5B9R5ZlCGRg=;
  b=ZoQrbI9kA8U6Y5Stc7T0xPHDTxAiD8bd2QYulqKU45nP8kdhUAlZZv5X
   ZEkVAjbiddFIIIb1NWJox+LpyDqU8qn1A2tW8FHgfZ4EbvtW/XHDm8vnB
   KkoHc/TZ0/qKStd0cOVWLg3MU8uGgymtzF0ayq79IN8OFGaokEn2NbtCZ
   kHbq/hWzYLTUF5rbmIWvK0kYgDTrpHuU3tME0d4/1tjMEwNQ1fD1rsa7I
   uyEGiXeUKLIkTnFSupm0QprvQHb7q65iEnTb1ep7+/BBSBKOfZVe7WDPL
   Qpelj5VWRqR4WUjchBKL/iS2UJv/Wgsmy964RdapRJJDcSvyK2uAHvdOL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4893652"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4893652"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11599129"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2024 16:24:24 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkBTq-000Bml-2J;
	Tue, 12 Mar 2024 23:24:22 +0000
Date: Wed, 13 Mar 2024 07:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main 6/6] drivers/ssb/main.c:1149:2: warning: label
 at end of compound statement is a C2x extension
Message-ID: <202403130717.TWm17FiD-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240313 (https://download.01.org/0day-ci/archive/20240313/202403130717.TWm17FiD-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403130717.TWm17FiD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403130717.TWm17FiD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
    1149 |         }
         |         ^
   1 warning generated.


vim +1149 drivers/ssb/main.c

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
f225763a7d6c92 Michael Buesch 2008-06-20  1148  	default:
61e115a56d1aaf Michael Buesch 2007-09-18 @1149  	}
61e115a56d1aaf Michael Buesch 2007-09-18  1150  	return 0;
61e115a56d1aaf Michael Buesch 2007-09-18  1151  }
61e115a56d1aaf Michael Buesch 2007-09-18  1152  EXPORT_SYMBOL(ssb_dma_translation);
61e115a56d1aaf Michael Buesch 2007-09-18  1153  

:::::: The code at line 1149 was first introduced by commit
:::::: 61e115a56d1aafd6e6a8a9fee8ac099a6128ac7b [SSB]: add Sonics Silicon Backplane bus support

:::::: TO: Michael Buesch <mb@bu3sch.de>
:::::: CC: David S. Miller <davem@sunset.davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

