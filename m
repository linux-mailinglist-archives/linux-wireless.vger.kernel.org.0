Return-Path: <linux-wireless+bounces-4642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA20879EC7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705D21C2093D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9371C3D;
	Tue, 12 Mar 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9NdAIEe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4953FE46
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282748; cv=none; b=M4JqrmR8GmMsH1WEOvL3E+DtG56rSEtnjP2hjS+wnuJxOOkF8TH/fyfBIcydAzyz1sWBVyN9mpqDPebT8BqAN7lMg05D8e01qjyIIfMs798NbBzJvALXUQ81vYJbD2OFKSR+vaM77rcRKVlLFluI4I3SeWF/YMwwbb3H5yxUXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282748; c=relaxed/simple;
	bh=yy6CrV/ltgpCr7krPvApgacgSUlnOgGyW+PsB7Y3Lys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPj0g2bMxN7O+wppSJtEWoOzKSgPq4iwcNx9rh/KNqtcxwajys09jt+dznfDf1FvnJ5tSedl56xVes+ghCRcqHm1SbVvOIyGuoOvJOzz7IBOf5xGuz3fAebaWoU5O1wFnNqQki2vOhSssBVQNOZq3NZTjh/Y1K1vK40YkMNF0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9NdAIEe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282746; x=1741818746;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yy6CrV/ltgpCr7krPvApgacgSUlnOgGyW+PsB7Y3Lys=;
  b=N9NdAIEeb5h9IyOL4FNkt1XOZz5Qwzpo04cbi5XFPgXqo/HrHdij10RQ
   6BX3OfyqkitSga3TkaRr5Qk8Za3b46Ag6ysRQsjx/bSeEH2pbkkjhV8n2
   jUziI3PHSBOHyfqABBrKRD15F8qR3uR9FlrXtqtLwr50u2Ot6Jo/tgpPX
   6INkMytClYM521ZptNmQoXuJgi4TOLUcNZxcTmRMP99hYnxWSVj/XZJTv
   Ad4cBkrZG1GFmbvOyWZtWQyg1XnzrrZdvGqm7fmOrU6R+iIkb1HxDtO5A
   KLhsC04cpXjZxZbH+D3XSq78YfWTSqG4ermT/vhnqLg5ts6N1lKLd2jKo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="30460771"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30460771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16339579"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Mar 2024 15:32:23 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkAfU-000Bjd-1z;
	Tue, 12 Mar 2024 22:32:20 +0000
Date: Wed, 13 Mar 2024 06:31:52 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main 6/6] drivers/ssb/main.c:1149:2: warning: label
 at end of compound statement is a C23 extension
Message-ID: <202403130633.muvbu9ev-lkp@intel.com>
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
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240313/202403130633.muvbu9ev-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403130633.muvbu9ev-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403130633.muvbu9ev-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/ssb/main.c:11:
   In file included from drivers/ssb/ssb_private.h:8:
   In file included from include/linux/ssb/ssb.h:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ssb/main.c:11:
   In file included from drivers/ssb/ssb_private.h:8:
   In file included from include/linux/ssb/ssb.h:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ssb/main.c:11:
   In file included from drivers/ssb/ssb_private.h:8:
   In file included from include/linux/ssb/ssb.h:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/ssb/main.c:11:
   In file included from drivers/ssb/ssb_private.h:8:
   In file included from include/linux/ssb/ssb.h:9:
   In file included from include/linux/pci.h:2688:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
    1149 |         }
         |         ^
   8 warnings generated.


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

