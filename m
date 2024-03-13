Return-Path: <linux-wireless+bounces-4654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63887A004
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 01:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DEFB21D15
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B962385;
	Wed, 13 Mar 2024 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHjN/IAA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8A383
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 00:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288510; cv=none; b=GB7heJy0DGDlID52wdhdd8+Ni1ljwd1pfBsaf5tHk3nT2VMwFCb37rmNZNAjsvoVfyyYClrtZyUmb5sHO+YuhkVNuEczh8buRd445+vLk/tyJ9ueQLLW1lXa1pBIusBwKunzNSVXwu2x2meck8hHnNjYUXiSRvFYv6Vbo/4dEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288510; c=relaxed/simple;
	bh=I0JK+EDHi2xDG0YYuYPBZvn/RnpkHpBlYYtfBSfbK9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rHOqZASGVbzi50cNhdtTXlVg1fZmp/GKXDxyPVtSA7JWPO2Cl/5aXoC9eWl+M0r+od8JfvNkjUDe9vWX7LbRN6zJ5zCwW+nmUXyiXDgRXcd2kA6dBDTfElcnJ3nqcNc+QPUMwFZFy7TYpQ1pvjz5uxqreEOImr/EOdWoIFqoMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHjN/IAA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710288509; x=1741824509;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I0JK+EDHi2xDG0YYuYPBZvn/RnpkHpBlYYtfBSfbK9U=;
  b=jHjN/IAAx/91L50DWUPX8c6t7shZ0EIylzWBW9VnbDaHt7UGEh8QqksL
   hwJlFT7McSZb9+dD4LUXD/NB5YBfjYmkXbryxo12eWMUn96nVCL197zmS
   Dj+DPhGKgjvAegFsUmYsC4VcG4YAQ6+P6m13TgHhiAMSkb/+qIB1O831J
   FYp5Tr0dVmJERkqGtG+GRbc82OZ3QtYOYdOgRZfRuhJK434jFDR4ZeRgd
   tnEllzjh+57CDZBBIDwseHOZkRyfc7iDEnxsrGVYX2WENO+G62yMTQvzH
   yKUmfnmzznMmxL2pdcyVom5w7sK2xAS1c/U+XrL+MHxOpjG00/IB4+xej
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16429407"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16429407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16444679"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Mar 2024 17:08:26 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkCAR-000BoT-24;
	Wed, 13 Mar 2024 00:08:23 +0000
Date: Wed, 13 Mar 2024 08:08:06 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main 6/6] drivers/ssb/main.c:1148:10: error: label at
 end of compound statement: expected statement
Message-ID: <202403130705.xI2y4Nym-lkp@intel.com>
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
config: arm-randconfig-004-20240313 (https://download.01.org/0day-ci/archive/20240313/202403130705.xI2y4Nym-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403130705.xI2y4Nym-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403130705.xI2y4Nym-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ssb/main.c:1148:10: error: label at end of compound statement: expected statement
           default:
                   ^
                    ;
   1 error generated.


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

