Return-Path: <linux-wireless+bounces-28088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 744FFBEEAF4
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9706A4E1A43
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408D1946C8;
	Sun, 19 Oct 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSKNgFr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB8CA6F;
	Sun, 19 Oct 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895942; cv=none; b=fQpkmF0SaHJZjlFW6MaRri+2u8ODm6hwNi5JeQiFDjj4JFLBpQNOdPhcz1iJI6yvLsAr82DK/fWrp/eXd2FVQu/kyITntDJg4DhxPpYcf0WBLQg+9x8BbTXmhkKBGFCCQ6XcVNIUY6F0Et2mwZ1tErb0AEAECFqf9AtiE0cVicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895942; c=relaxed/simple;
	bh=PT5edAvGs2FKCeBZ2dl7OCjjziNGJmQxLTxQAcMOLvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu/Fjj0C18e/6epRWwXTCPW0e3f3n20ANn9yAloxisPUAXbFvr1PDgJScn/AZbB1uB5q8Q8tnf6wewraWppXEFqSfLeSTZW+nBySEyhcpE4TyxAGIkCT5TO85wTOK98z+9xPhBblN/hsGlfb4Q+Kj1LcXGLR7a0B6w1GzoG2sA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSKNgFr8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760895940; x=1792431940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PT5edAvGs2FKCeBZ2dl7OCjjziNGJmQxLTxQAcMOLvs=;
  b=JSKNgFr8ohKPknjgTQ9KPC/vgp66gFg/bLeRN4NAolf5s+eaKwOeqA6r
   eF9ukp2RdMDsBaykjvJIYLaHBjamLDJNtLx6Q2IAEMvqQFUR6VmKVko3v
   ITyR/T4uQjk25EEFL9vrsp4VKjopfK0eVJrXDM2bm+TvxL8r9gb/IAqrl
   BviaZY4MHvcSs7markaEg1r7pBjRvIt7RqgzqC1P5xLUzZ35xH6qUKUNX
   AUvAJ5C9uih1wtiIpHUhddLnpakwkabNT+b9mQAGq4CxqS9u03LtUXlLa
   4h3nbaf7qGTU04LE4tyHEBGqC2sBLWsyAeSeVAeMM5UPtzF4R2vc3H+Hs
   A==;
X-CSE-ConnectionGUID: BVR8ciLEQFmzyoLRBxTTPw==
X-CSE-MsgGUID: TXMa7HZRQvWTnrliZfuAOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="73705967"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="73705967"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 10:45:39 -0700
X-CSE-ConnectionGUID: 0JZCniWVT4KAkMJjgpid2Q==
X-CSE-MsgGUID: /WMS/oibQKCeZobeH9y1bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="183177175"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Oct 2025 10:45:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAXSx-0009F7-0G;
	Sun, 19 Oct 2025 17:45:32 +0000
Date: Mon, 20 Oct 2025 01:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, nbd@nbd.name,
	lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com,
	rosenp@gmail.com, luoxueqin@kylinos.cn, chad@monroe.io,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
Message-ID: <202510200105.T000lujD-lkp@intel.com>
References: <20251019155316.3537185-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251019155316.3537185-1-olek2@wp.pl>

Hi Aleksander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksander-Jan-Bajkowski/wifi-mt76-add-tx-checksum-offload-for-mt7915-mt7921-mt7981-and-mt7986/20251019-235515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251019155316.3537185-1-olek2%40wp.pl
patch subject: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921, mt7981 and mt7986
config: i386-buildonly-randconfig-003-20251019 (https://download.01.org/0day-ci/archive/20251020/202510200105.T000lujD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251020/202510200105.T000lujD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510200105.T000lujD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:29,
                    from drivers/net/wireless/mediatek/mt76/mt76.h:12,
                    from drivers/net/wireless/mediatek/mt76/mt76_connac.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt792x.h:10,
                    from drivers/net/wireless/mediatek/mt76/mt792x_core.c:7:
   drivers/net/wireless/mediatek/mt76/mt792x_core.c: In function 'mt792x_init_wiphy':
>> include/linux/netdev_features.h:104:33: warning: statement with no effect [-Wunused-value]
     104 | #define __NETIF_F_BIT(bit)      ((netdev_features_t)1 << (bit))
         |                                 ^
   include/linux/netdev_features.h:105:33: note: in expansion of macro '__NETIF_F_BIT'
     105 | #define __NETIF_F(name)         __NETIF_F_BIT(NETIF_F_##name##_BIT)
         |                                 ^~~~~~~~~~~~~
   include/linux/netdev_features.h:119:33: note: in expansion of macro '__NETIF_F'
     119 | #define NETIF_F_IP_CSUM         __NETIF_F(IP_CSUM)
         |                                 ^~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt792x_core.c:636:17: note: in expansion of macro 'NETIF_F_IP_CSUM'
     636 |                 NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
         |                 ^~~~~~~~~~~~~~~


vim +104 include/linux/netdev_features.h

a19f2a6df28e0c Michał Mirosław 2011-11-15  102  
a19f2a6df28e0c Michał Mirosław 2011-11-15  103  /* copy'n'paste compression ;) */
a19f2a6df28e0c Michał Mirosław 2011-11-15 @104  #define __NETIF_F_BIT(bit)	((netdev_features_t)1 << (bit))
a19f2a6df28e0c Michał Mirosław 2011-11-15  105  #define __NETIF_F(name)		__NETIF_F_BIT(NETIF_F_##name##_BIT)
a19f2a6df28e0c Michał Mirosław 2011-11-15  106  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

