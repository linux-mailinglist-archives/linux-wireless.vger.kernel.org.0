Return-Path: <linux-wireless+bounces-11590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50327955EA2
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 21:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017262814C8
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114A129E9C;
	Sun, 18 Aug 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJ4YBsEy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0438DE4;
	Sun, 18 Aug 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724008462; cv=none; b=AG2BUxC24U0aoaZEDiy813CgBpRmF2XhNHOp8+q9ts2n4Z1yQvBQ4JR5YFf5covX1IZZJEdNKCQSM4k3mrbW/RF3dIvl23jiKtMGR2bBeso4OHyHzw8avPl4FsaaLCg31xbN/2J8i5EJ7hsJed6NnOddoJHzkY1J04SPMHIWw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724008462; c=relaxed/simple;
	bh=Q+2u2HobdWkcCI2XTXljamEgmC74Gq3MFrJGBcVog04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilsL+mBL5TXpGElCMrv0pqwDxA+Sid9fQYRbxXc74/FPs0qRnvck3EB6OMb0GAg3XQY7g48qAY2SUuxZO8fdY+T6xK6pQBJnTaOjrQxk2Tnoeh2AtrhmFiZAhLwR2+M+HgpmJ0hzMxEhXUigKx+R78sY7y/hgm82fRklzoEd4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJ4YBsEy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724008459; x=1755544459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q+2u2HobdWkcCI2XTXljamEgmC74Gq3MFrJGBcVog04=;
  b=hJ4YBsEyZDQyWvO7Ebv5ls+bfr5sC+yFUCC8FIbXVU/2MTHRrWCDP326
   DoopVY+wyRvV4vnG3x9fYJMkRuShZAdwFvvRqTlRKD6VOqi2fFmkWwFlg
   Mp1mMoE0Sv1mECaF8vaPMwJ1bscWZnB+QYydGv0SV+crIDK5NzAyPxDr3
   MVS1z01j/2WUdN+ZRs1cJwH3jZJMLUM81jR/6FQ5esSgFKD17STRzRwgy
   cH2yOL297tS3qf3kYeDgu7UJ+GDpFoTvpQnDa8QbTDvivQSNfviiQvxG/
   QEqTcJcQOIHZyOnUCYbnULSTe4xc9E+bam1bvArrPq1ERQG7ERx3W5E/q
   A==;
X-CSE-ConnectionGUID: 2iJIzpIYQYij5WKrBZmp2w==
X-CSE-MsgGUID: x6XeQK3zTm6r8phWTWuqXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="25145843"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="25145843"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 12:14:18 -0700
X-CSE-ConnectionGUID: 4k2reZKwRLO0AIpfN+A/CQ==
X-CSE-MsgGUID: rekQZ1VXQeaAFC295i1n+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="83388301"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2024 12:14:16 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sflLx-0008Pm-2l;
	Sun, 18 Aug 2024 19:14:13 +0000
Date: Mon, 19 Aug 2024 03:13:28 +0800
From: kernel test robot <lkp@intel.com>
To: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
	Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Subject: Re: [PATCH 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do
 while
Message-ID: <202408190201.maHKSVvI-lkp@intel.com>
References: <959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol@gmail.com>

Hi Juan,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juan-Jos-Arboleda/iwlwifi-mvm-Improve-code-style-in-pointer-declarations/20240818-145152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/959e76da152811a723415545a3cf6ab1d8e17fbc.1723963126.git.soyjuanarbol%40gmail.com
patch subject: [PATCH 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do while
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240819/202408190201.maHKSVvI-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190201.maHKSVvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190201.maHKSVvI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:7:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1053:2: error: expected ';' after do/while statement
    1053 |         CHECK_BW(20);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:2: note: expanded from macro 'CHECK_BW'
    1051 |         while (0);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1054:2: error: expected ';' after do/while statement
    1054 |         CHECK_BW(40);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:2: note: expanded from macro 'CHECK_BW'
    1051 |         while (0);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1055:2: error: expected ';' after do/while statement
    1055 |         CHECK_BW(80);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:2: note: expanded from macro 'CHECK_BW'
    1051 |         while (0);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1056:2: error: expected ';' after do/while statement
    1056 |         CHECK_BW(160);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1051:2: note: expanded from macro 'CHECK_BW'
    1051 |         while (0);
         |         ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1071:1: error: expected 'while' in do/while loop
    1071 | static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1056:2: note: to match this 'do'
    1056 |         CHECK_BW(160);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:2: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |         ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1902:1: error: function definition is not allowed here
    1902 | {
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1921:1: error: function definition is not allowed here
    1921 | {
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2040:1: error: function definition is not allowed here
    2040 | {
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2372:1: error: function definition is not allowed here
    2372 | {
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2505:1: error: function definition is not allowed here
    2505 | {
         | ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2519:1: error: function definition is not allowed here
    2519 | {
         | ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected '}'
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1055:2: note: to match this '{'
    1055 |         CHECK_BW(80);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:5: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |            ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected 'while' in do/while loop
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1055:2: note: to match this 'do'
    1055 |         CHECK_BW(80);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:2: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |         ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected '}'
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1054:2: note: to match this '{'
    1054 |         CHECK_BW(40);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:5: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |            ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected 'while' in do/while loop
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1054:2: note: to match this 'do'
    1054 |         CHECK_BW(40);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:2: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |         ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected '}'
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1053:2: note: to match this '{'
    1053 |         CHECK_BW(20);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:5: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |            ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected 'while' in do/while loop
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1053:2: note: to match this 'do'
    1053 |         CHECK_BW(20);
         |         ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1046:2: note: expanded from macro 'CHECK_BW'
    1046 |         do { \
         |         ^
>> drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:2561:2: error: expected '}'
    2561 | }
         |  ^
   drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:991:1: note: to match this '{'
     991 | {
         | ^
   13 warnings and 18 errors generated.


vim +1053 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c

dabf9844385885 Johannes Berg       2018-04-26   985  
ffe9d734b8b556 Johannes Berg       2018-06-14   986  static void
bdf180c8d375ee Shaul Triebitz      2018-07-02   987  iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
ffe9d734b8b556 Johannes Berg       2018-06-14   988  			       struct ieee80211_radiotap_he *he,
ffe9d734b8b556 Johannes Berg       2018-06-14   989  			       struct ieee80211_radiotap_he_mu *he_mu,
ffe9d734b8b556 Johannes Berg       2018-06-14   990  			       struct ieee80211_rx_status *rx_status)
ffe9d734b8b556 Johannes Berg       2018-06-14   991  {
ffe9d734b8b556 Johannes Berg       2018-06-14   992  	/*
ffe9d734b8b556 Johannes Berg       2018-06-14   993  	 * Unfortunately, we have to leave the mac80211 data
ffe9d734b8b556 Johannes Berg       2018-06-14   994  	 * incorrect for the case that we receive an HE-MU
ffe9d734b8b556 Johannes Berg       2018-06-14   995  	 * transmission and *don't* have the HE phy data (due
ffe9d734b8b556 Johannes Berg       2018-06-14   996  	 * to the bits being used for TSF). This shouldn't
ffe9d734b8b556 Johannes Berg       2018-06-14   997  	 * happen though as management frames where we need
ffe9d734b8b556 Johannes Berg       2018-06-14   998  	 * the TSF/timers are not be transmitted in HE-MU.
ffe9d734b8b556 Johannes Berg       2018-06-14   999  	 */
bdf180c8d375ee Shaul Triebitz      2018-07-02  1000  	u8 ru = le32_get_bits(phy_data->d1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
f1490546bec933 Johannes Berg       2022-09-06  1001  	u32 rate_n_flags = phy_data->rate_n_flags;
48c6ebc13c1ce1 Miri Korenblit      2021-10-17  1002  	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK_V1;
ffe9d734b8b556 Johannes Berg       2018-06-14  1003  	u8 offs = 0;
ffe9d734b8b556 Johannes Berg       2018-06-14  1004  
ffe9d734b8b556 Johannes Berg       2018-06-14  1005  	rx_status->bw = RATE_INFO_BW_HE_RU;
ffe9d734b8b556 Johannes Berg       2018-06-14  1006  
ffe9d734b8b556 Johannes Berg       2018-06-14  1007  	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
ffe9d734b8b556 Johannes Berg       2018-06-14  1008  
ffe9d734b8b556 Johannes Berg       2018-06-14  1009  	switch (ru) {
ffe9d734b8b556 Johannes Berg       2018-06-14  1010  	case 0 ... 36:
ffe9d734b8b556 Johannes Berg       2018-06-14  1011  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
ffe9d734b8b556 Johannes Berg       2018-06-14  1012  		offs = ru;
ffe9d734b8b556 Johannes Berg       2018-06-14  1013  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1014  	case 37 ... 52:
ffe9d734b8b556 Johannes Berg       2018-06-14  1015  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
ffe9d734b8b556 Johannes Berg       2018-06-14  1016  		offs = ru - 37;
ffe9d734b8b556 Johannes Berg       2018-06-14  1017  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1018  	case 53 ... 60:
ffe9d734b8b556 Johannes Berg       2018-06-14  1019  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
ffe9d734b8b556 Johannes Berg       2018-06-14  1020  		offs = ru - 53;
ffe9d734b8b556 Johannes Berg       2018-06-14  1021  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1022  	case 61 ... 64:
ffe9d734b8b556 Johannes Berg       2018-06-14  1023  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
ffe9d734b8b556 Johannes Berg       2018-06-14  1024  		offs = ru - 61;
ffe9d734b8b556 Johannes Berg       2018-06-14  1025  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1026  	case 65 ... 66:
ffe9d734b8b556 Johannes Berg       2018-06-14  1027  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
ffe9d734b8b556 Johannes Berg       2018-06-14  1028  		offs = ru - 65;
ffe9d734b8b556 Johannes Berg       2018-06-14  1029  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1030  	case 67:
ffe9d734b8b556 Johannes Berg       2018-06-14  1031  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
ffe9d734b8b556 Johannes Berg       2018-06-14  1032  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1033  	case 68:
ffe9d734b8b556 Johannes Berg       2018-06-14  1034  		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
ffe9d734b8b556 Johannes Berg       2018-06-14  1035  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1036  	}
ffe9d734b8b556 Johannes Berg       2018-06-14  1037  	he->data2 |= le16_encode_bits(offs,
ffe9d734b8b556 Johannes Berg       2018-06-14  1038  				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
ffe9d734b8b556 Johannes Berg       2018-06-14  1039  	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_KNOWN |
ffe9d734b8b556 Johannes Berg       2018-06-14  1040  				 IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET_KNOWN);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1041  	if (phy_data->d1 & cpu_to_le32(IWL_RX_PHY_DATA1_HE_RU_ALLOC_SEC80))
ffe9d734b8b556 Johannes Berg       2018-06-14  1042  		he->data2 |=
ffe9d734b8b556 Johannes Berg       2018-06-14  1043  			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
ffe9d734b8b556 Johannes Berg       2018-06-14  1044  
ffe9d734b8b556 Johannes Berg       2018-06-14  1045  #define CHECK_BW(bw) \
ff8cfabb6d457b Juan José Arboleda  2024-08-18  1046  	do { \
ffe9d734b8b556 Johannes Berg       2018-06-14  1047  		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
74cf15cb69c0be Johannes Berg       2018-12-03  1048  			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
74cf15cb69c0be Johannes Berg       2018-12-03  1049  		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
ff8cfabb6d457b Juan José Arboleda  2024-08-18  1050  			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS) \
ff8cfabb6d457b Juan José Arboleda  2024-08-18  1051  	while (0);
ff8cfabb6d457b Juan José Arboleda  2024-08-18  1052  
ffe9d734b8b556 Johannes Berg       2018-06-14 @1053  	CHECK_BW(20);
ffe9d734b8b556 Johannes Berg       2018-06-14  1054  	CHECK_BW(40);
ffe9d734b8b556 Johannes Berg       2018-06-14  1055  	CHECK_BW(80);
ffe9d734b8b556 Johannes Berg       2018-06-14  1056  	CHECK_BW(160);
74cf15cb69c0be Johannes Berg       2018-12-03  1057  
74cf15cb69c0be Johannes Berg       2018-12-03  1058  	if (he_mu)
ffe9d734b8b556 Johannes Berg       2018-06-14  1059  		he_mu->flags2 |=
48c6ebc13c1ce1 Miri Korenblit      2021-10-17  1060  			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
ffe9d734b8b556 Johannes Berg       2018-06-14  1061  						   rate_n_flags),
ffe9d734b8b556 Johannes Berg       2018-06-14  1062  					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
48c6ebc13c1ce1 Miri Korenblit      2021-10-17  1063  	else if (he_type == RATE_MCS_HE_TYPE_TRIG_V1)
74cf15cb69c0be Johannes Berg       2018-12-03  1064  		he->data6 |=
74cf15cb69c0be Johannes Berg       2018-12-03  1065  			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
48c6ebc13c1ce1 Miri Korenblit      2021-10-17  1066  			le16_encode_bits(FIELD_GET(RATE_MCS_CHAN_WIDTH_MSK_V1,
74cf15cb69c0be Johannes Berg       2018-12-03  1067  						   rate_n_flags),
74cf15cb69c0be Johannes Berg       2018-12-03  1068  					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
ffe9d734b8b556 Johannes Berg       2018-06-14  1069  }
ffe9d734b8b556 Johannes Berg       2018-06-14  1070  
59b8cf0cfb5ac5 Johannes Berg       2018-06-14 @1071  static void iwl_mvm_decode_he_phy_data(struct iwl_mvm *mvm,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1072  				       struct iwl_mvm_rx_phy_data *phy_data,
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1073  				       struct ieee80211_radiotap_he *he,
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1074  				       struct ieee80211_radiotap_he_mu *he_mu,
ffe9d734b8b556 Johannes Berg       2018-06-14  1075  				       struct ieee80211_rx_status *rx_status,
f1490546bec933 Johannes Berg       2022-09-06  1076  				       int queue)
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1077  {
6721039d5b8adf Shaul Triebitz      2018-07-02  1078  	switch (phy_data->info_type) {
bdf180c8d375ee Shaul Triebitz      2018-07-02  1079  	case IWL_RX_PHY_INFO_TYPE_NONE:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1080  	case IWL_RX_PHY_INFO_TYPE_CCK:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1081  	case IWL_RX_PHY_INFO_TYPE_OFDM_LGCY:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1082  	case IWL_RX_PHY_INFO_TYPE_HT:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1083  	case IWL_RX_PHY_INFO_TYPE_VHT_SU:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1084  	case IWL_RX_PHY_INFO_TYPE_VHT_MU:
0ac93c06dca70f Mordechay Goodstein 2023-01-27  1085  	case IWL_RX_PHY_INFO_TYPE_EHT_MU:
0ac93c06dca70f Mordechay Goodstein 2023-01-27  1086  	case IWL_RX_PHY_INFO_TYPE_EHT_TB:
0ac93c06dca70f Mordechay Goodstein 2023-01-27  1087  	case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
0ac93c06dca70f Mordechay Goodstein 2023-01-27  1088  	case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1089  		return;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1090  	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1091  		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1092  					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1093  					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1094  					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN);
a197e6d10ce26b Emmanuel Grumbach   2019-01-16  1095  		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1096  							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE1),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1097  					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1);
a197e6d10ce26b Emmanuel Grumbach   2019-01-16  1098  		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1099  							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE2),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1100  					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2);
a197e6d10ce26b Emmanuel Grumbach   2019-01-16  1101  		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1102  							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE3),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1103  					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3);
a197e6d10ce26b Emmanuel Grumbach   2019-01-16  1104  		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d2,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1105  							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE4),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1106  					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4);
5a2abdcadc3bd7 Gustavo A. R. Silva 2020-11-17  1107  		fallthrough;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1108  	case IWL_RX_PHY_INFO_TYPE_HE_SU:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1109  	case IWL_RX_PHY_INFO_TYPE_HE_MU:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1110  	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1111  	case IWL_RX_PHY_INFO_TYPE_HE_TB:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1112  		/* HE common */
bdf180c8d375ee Shaul Triebitz      2018-07-02  1113  		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1114  					 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1115  					 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1116  		he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1117  					 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1118  					 IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
bdf180c8d375ee Shaul Triebitz      2018-07-02  1119  					 IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1120  		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1121  							    IWL_RX_PHY_DATA0_HE_BSS_COLOR_MASK),
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1122  					      IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
7969454b37f25d Shaul Triebitz      2018-07-25  1123  		if (phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB &&
7969454b37f25d Shaul Triebitz      2018-07-25  1124  		    phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB_EXT) {
7969454b37f25d Shaul Triebitz      2018-07-25  1125  			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1126  			he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1127  							    IWL_RX_PHY_DATA0_HE_UPLINK),
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1128  						      IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
7969454b37f25d Shaul Triebitz      2018-07-25  1129  		}
bdf180c8d375ee Shaul Triebitz      2018-07-02  1130  		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1131  							    IWL_RX_PHY_DATA0_HE_LDPC_EXT_SYM),
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1132  					      IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1133  		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1134  							    IWL_RX_PHY_DATA0_HE_PRE_FEC_PAD_MASK),
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1135  					      IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1136  		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1137  							    IWL_RX_PHY_DATA0_HE_PE_DISAMBIG),
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1138  					      IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1139  		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->d1,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1140  							    IWL_RX_PHY_DATA1_HE_LTF_NUM_MASK),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1141  					      IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1142  		he->data6 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1143  							    IWL_RX_PHY_DATA0_HE_TXOP_DUR_MASK),
2b1476345fb6c8 Johannes Berg       2018-06-14  1144  					      IEEE80211_RADIOTAP_HE_DATA6_TXOP);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1145  		he->data6 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1146  							    IWL_RX_PHY_DATA0_HE_DOPPLER),
69f3ca8ed33dd3 Johannes Berg       2018-06-19  1147  					      IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1148  		break;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1149  	}
2b1476345fb6c8 Johannes Berg       2018-06-14  1150  
2286a99c32344c Johannes Berg       2019-01-11  1151  	switch (phy_data->info_type) {
2286a99c32344c Johannes Berg       2019-01-11  1152  	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
2286a99c32344c Johannes Berg       2019-01-11  1153  	case IWL_RX_PHY_INFO_TYPE_HE_MU:
2286a99c32344c Johannes Berg       2019-01-11  1154  	case IWL_RX_PHY_INFO_TYPE_HE_SU:
2286a99c32344c Johannes Berg       2019-01-11  1155  		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN);
2286a99c32344c Johannes Berg       2019-01-11  1156  		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->d0,
2286a99c32344c Johannes Berg       2019-01-11  1157  							    IWL_RX_PHY_DATA0_HE_SPATIAL_REUSE_MASK),
2286a99c32344c Johannes Berg       2019-01-11  1158  					      IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
2286a99c32344c Johannes Berg       2019-01-11  1159  		break;
2286a99c32344c Johannes Berg       2019-01-11  1160  	default:
2286a99c32344c Johannes Berg       2019-01-11  1161  		/* nothing here */
2286a99c32344c Johannes Berg       2019-01-11  1162  		break;
2286a99c32344c Johannes Berg       2019-01-11  1163  	}
2286a99c32344c Johannes Berg       2019-01-11  1164  
6721039d5b8adf Shaul Triebitz      2018-07-02  1165  	switch (phy_data->info_type) {
bdf180c8d375ee Shaul Triebitz      2018-07-02  1166  	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1167  		he_mu->flags1 |=
bdf180c8d375ee Shaul Triebitz      2018-07-02  1168  			le16_encode_bits(le16_get_bits(phy_data->d4,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1169  						       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_DCM),
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1170  					 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1171  		he_mu->flags1 |=
bdf180c8d375ee Shaul Triebitz      2018-07-02  1172  			le16_encode_bits(le16_get_bits(phy_data->d4,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1173  						       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_MCS_MASK),
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1174  					 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1175  		he_mu->flags2 |=
bdf180c8d375ee Shaul Triebitz      2018-07-02  1176  			le16_encode_bits(le16_get_bits(phy_data->d4,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1177  						       IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK),
bdf180c8d375ee Shaul Triebitz      2018-07-02  1178  					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
f1490546bec933 Johannes Berg       2022-09-06  1179  		iwl_mvm_decode_he_mu_ext(mvm, phy_data, he_mu);
5a2abdcadc3bd7 Gustavo A. R. Silva 2020-11-17  1180  		fallthrough;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1181  	case IWL_RX_PHY_INFO_TYPE_HE_MU:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1182  		he_mu->flags2 |=
bdf180c8d375ee Shaul Triebitz      2018-07-02  1183  			le16_encode_bits(le32_get_bits(phy_data->d1,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1184  						       IWL_RX_PHY_DATA1_HE_MU_SIBG_SYM_OR_USER_NUM_MASK),
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1185  					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1186  		he_mu->flags2 |=
bdf180c8d375ee Shaul Triebitz      2018-07-02  1187  			le16_encode_bits(le32_get_bits(phy_data->d1,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1188  						       IWL_RX_PHY_DATA1_HE_MU_SIGB_COMPRESSION),
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1189  					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
5a2abdcadc3bd7 Gustavo A. R. Silva 2020-11-17  1190  		fallthrough;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1191  	case IWL_RX_PHY_INFO_TYPE_HE_TB:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1192  	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
f1490546bec933 Johannes Berg       2022-09-06  1193  		iwl_mvm_decode_he_phy_ru_alloc(phy_data, he, he_mu, rx_status);
fed3c4ea6f8f12 Johannes Berg       2018-06-14  1194  		break;
bdf180c8d375ee Shaul Triebitz      2018-07-02  1195  	case IWL_RX_PHY_INFO_TYPE_HE_SU:
bdf180c8d375ee Shaul Triebitz      2018-07-02  1196  		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN);
bdf180c8d375ee Shaul Triebitz      2018-07-02  1197  		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->d0,
bdf180c8d375ee Shaul Triebitz      2018-07-02  1198  							    IWL_RX_PHY_DATA0_HE_BEAM_CHNG),
fed3c4ea6f8f12 Johannes Berg       2018-06-14  1199  					      IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE);
fed3c4ea6f8f12 Johannes Berg       2018-06-14  1200  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1201  	default:
ffe9d734b8b556 Johannes Berg       2018-06-14  1202  		/* nothing */
ffe9d734b8b556 Johannes Berg       2018-06-14  1203  		break;
ffe9d734b8b556 Johannes Berg       2018-06-14  1204  	}
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1205  }
59b8cf0cfb5ac5 Johannes Berg       2018-06-14  1206  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

