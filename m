Return-Path: <linux-wireless+bounces-15697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087C9D8DED
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 22:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1165828CE6B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468971C4A24;
	Mon, 25 Nov 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrjH2tPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516D1C4A2D
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569755; cv=none; b=VMyHwKIdusxWa0Qxx1qdUYvPM+I6oVPKgmogdzVDaiZjnEthvkWO79QSXCxQthL3UZYtFIlPLkgxHfXIxHgiIB1dUwn1nPc3ZiVv8czT3ytXVrJJhD0h3HcaxrzZndSi30DA/ps7pFDE24Xpi3uFpwRyM0qRBNX7xfe1O7UXtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569755; c=relaxed/simple;
	bh=twnL+B7JtJeYbJ1JfiZtGSamChzL0Ng6pjqhRSeR06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/BZMN1n9lWZo0XhuJ+hrroT0DpyFn3n9ijUq1qJldSWYrcNWoTdzRd6f1FM+k7MMjlzkAmimUi1vizmGD3tnIGQ/vEogwo09FM+1exdiOkgtuyvV6XWyXLKI1e5wmD+qxgjoeD05v6qi75jKw3qwAFyrmVQOnBs29+LAsXZhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrjH2tPR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732569754; x=1764105754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twnL+B7JtJeYbJ1JfiZtGSamChzL0Ng6pjqhRSeR06k=;
  b=YrjH2tPR9bQ27H9FrCPziLS2Yb459ZqkyhWpiPNAV+Zv7kP9EjkI+wCN
   P9QUb96oHOqqhh1VM0+vVGK3h+b0kTPrUbMGRjIKAVmC1cLc7eXdHdP+O
   LEgNVjbecbFDx7Z5oTDnsWoeSWQu/XdeJzN5yAs+arc/A5o+7j9HHIw5J
   tF24p5dQ34FP2cZAHhpHwxDHYuqMUoq7CdcVyVxO3WH91xbdu0zP/m/ty
   9OpGavhWGdQQp5EFE9qpkiIzIw7BaJLC5NX6vOgq1YcRKryGDborRM/yy
   +DfK1/eONBi/pi12ggOhWhglJKAZhxY88Qna7TeF6bGSQfOkvBcWsRnKa
   w==;
X-CSE-ConnectionGUID: +shG5GPCQ+iL4cBFKtvA8Q==
X-CSE-MsgGUID: wh5sn5r3QTWg8N7rnh3tPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32444469"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32444469"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 13:22:34 -0800
X-CSE-ConnectionGUID: Rgalz3ZwS/m9Kpoe3m+OBQ==
X-CSE-MsgGUID: XtYAQFmqRBykA+T/6rfnpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96449527"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2024 13:22:31 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFgXM-0006oP-39;
	Mon, 25 Nov 2024 21:22:28 +0000
Date: Tue, 26 Nov 2024 05:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	mathias.kretschmer@fit.fraunhofer.de, sw@simonwunderlich.de
Subject: Re: [PATCH v2] wifi: mac80211: fix mbss changed flags corruption on
 32 bit systems
Message-ID: <202411260443.dZKFWC4G-lkp@intel.com>
References: <20241118125640.1110502-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118125640.1110502-1-ih@simonwunderlich.de>

Hi Issam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dfc14664794a4706e0c2186a0c082386e6b14c4d]

url:    https://github.com/intel-lab-lkp/linux/commits/Issam-Hamdi/wifi-mac80211-fix-mbss-changed-flags-corruption-on-32-bit-systems/20241121-150801
base:   dfc14664794a4706e0c2186a0c082386e6b14c4d
patch link:    https://lore.kernel.org/r/20241118125640.1110502-1-ih%40simonwunderlich.de
patch subject: [PATCH v2] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20241126/202411260443.dZKFWC4G-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411260443.dZKFWC4G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260443.dZKFWC4G-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mac80211/mesh.c:11:
   In file included from net/mac80211/ieee80211_i.h:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/mac80211/mesh.c:11:
   In file included from net/mac80211/ieee80211_i.h:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/mac80211/mesh.c:11:
   In file included from net/mac80211/ieee80211_i.h:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/mac80211/mesh.c:11:
   In file included from net/mac80211/ieee80211_i.h:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/mac80211/mesh.c:1163:7: warning: address of array 'bits' will always evaluate to 'true' [-Wpointer-bool-conversion]
    1163 |         if (!bits)
         |             ~^~~~
   8 warnings generated.


vim +1163 net/mac80211/mesh.c

2b5e19677592c1 Thomas Pedersen 2013-02-14  1155  
2b5e19677592c1 Thomas Pedersen 2013-02-14  1156  void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
15ddba5f43114c Anjaneyulu      2023-06-04  1157  				       u64 changed)
2b5e19677592c1 Thomas Pedersen 2013-02-14  1158  {
f81a9dedaff434 Thomas Pedersen 2013-06-13  1159  	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
f0e1110ae72964 Issam Hamdi     2024-11-18  1160  	unsigned long bits[] = { BITMAP_FROM_U64(changed) };
f81a9dedaff434 Thomas Pedersen 2013-06-13  1161  	u32 bit;
f81a9dedaff434 Thomas Pedersen 2013-06-13  1162  
f81a9dedaff434 Thomas Pedersen 2013-06-13 @1163  	if (!bits)
2b5e19677592c1 Thomas Pedersen 2013-02-14  1164  		return;
f81a9dedaff434 Thomas Pedersen 2013-06-13  1165  
f81a9dedaff434 Thomas Pedersen 2013-06-13  1166  	/* if we race with running work, worst case this work becomes a noop */
f0e1110ae72964 Issam Hamdi     2024-11-18  1167  	for_each_set_bit(bit, bits, sizeof(changed) * BITS_PER_BYTE)
6e48ebffc2db54 Felix Fietkau   2023-09-13  1168  		set_bit(bit, ifmsh->mbss_changed);
f81a9dedaff434 Thomas Pedersen 2013-06-13  1169  	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
16114496d684a3 Johannes Berg   2023-06-06  1170  	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
2b5e19677592c1 Thomas Pedersen 2013-02-14  1171  }
2b5e19677592c1 Thomas Pedersen 2013-02-14  1172  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

