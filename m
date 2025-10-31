Return-Path: <linux-wireless+bounces-28425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B0C22DA8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 02:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A751895624
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DA1DE3DC;
	Fri, 31 Oct 2025 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxWgkhib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35364C81;
	Fri, 31 Oct 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873569; cv=none; b=Y8ZSEbq7HvhKM3VOscNRGg8AkPhfekjkJJqG0p7jXHCIFxWsghdeYNviYThh836dxoEY9cg5oa0sjq62plJRaorApuz4qvAZfpJcJvIJBJj3GYf///2oFaPz8VI0eGBNA9nc6HQtVnU7IhnCXhFioNFzXGxx0BrGpB0nKO6IvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873569; c=relaxed/simple;
	bh=s3KxTLvxykwuQMgwYymSDxBhPd0V8H4sWyAgWwULAKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r91kqQUNBpp7su1mpmwLLptkq3qAwmQdxYgpVhQX9JOrlNLeEuLilQRNpfmiA6EY4YBQMnCQqnOAEBATGF+/XP28TZCTUBv+Vp6DvLivDNOFERO2/7otwZcNf14e68AwWVilnFy+aiV3DwRlV26maWvo+2ErswaxqjaH7q+Z3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxWgkhib; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761873568; x=1793409568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3KxTLvxykwuQMgwYymSDxBhPd0V8H4sWyAgWwULAKI=;
  b=KxWgkhibFNk2OBR338daFTnQuyNBMUavEjdbyx5wclbp2wQh85cs99ZP
   ay0whbO4SrVi73cMCmS/Nnj14H/2/9A8D2AdpN0PnAdM1K+DCMtfvb6PE
   luu+UiDUzWapY3c/1t3xWTXhM+uzHJOIgJpURYsX7YF+wOBcwm4w5tvSk
   KXtzajBxdOAtWlZZorLhi0kGWnEnkzq+YB/kncBDyOcmPOFtGOZoxkUjS
   covSCGdo74xSzf0D9eUUyPtrVeK9u0PQsT4crAkWPYhpz21/4jt5a4YPs
   xKnRdjXAArG46v0FD6yDiHY+cGA9LW4PqowpcynKeb0sl0AYtj/soPdqs
   A==;
X-CSE-ConnectionGUID: nwklheNoS4GfMfhjjv+Kzg==
X-CSE-MsgGUID: +EpFke1ZQH6yAjCg9qy2zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64069214"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64069214"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 18:19:28 -0700
X-CSE-ConnectionGUID: mCjhLEe6QCKcT9fN0jidcg==
X-CSE-MsgGUID: jQINaZDsRf6rcrtZb6y02w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185979707"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2025 18:19:24 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEdnS-000Mem-0M;
	Fri, 31 Oct 2025 01:19:20 +0000
Date: Fri, 31 Oct 2025 09:18:22 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>, nbd@nbd.name, lorenzo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big
 Endian
Message-ID: <202510310816.kyDHJNiS-lkp@intel.com>
References: <20251027171759.1484844-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027171759.1484844-1-cjd@cjdns.fr>

Hi Caleb,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-James-DeLisle/wifi-mt76-mmio_-read-write-_copy-byte-swap-when-on-Big-Endian/20251028-012349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251027171759.1484844-1-cjd%40cjdns.fr
patch subject: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
config: i386-randconfig-061-20251031 (https://download.01.org/0day-ci/archive/20251031/202510310816.kyDHJNiS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310816.kyDHJNiS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310816.kyDHJNiS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse: sparse: cast from restricted __le32
>> drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse:     expected unsigned int val
   drivers/net/wireless/mediatek/mt76/mmio.c:41:24: sparse:     got restricted __le32 [usertype]
>> drivers/net/wireless/mediatek/mt76/mmio.c:63:23: sparse: sparse: cast to restricted __le32

vim +41 drivers/net/wireless/mediatek/mt76/mmio.c

    32	
    33	static void mt76_mmio_write_copy_portable(void __iomem *dst,
    34						  const u8 *src, int len)
    35	{
    36		__le32 val;
    37		int i = 0;
    38	
    39		for (i = 0; i < ALIGN(len, 4); i += 4) {
    40			memcpy(&val, src + i, sizeof(val));
  > 41			writel(cpu_to_le32(val), dst + i);
    42		}
    43	}
    44	
    45	static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
    46					 const void *data, int len)
    47	{
    48		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
    49			mt76_mmio_write_copy_portable(dev->mmio.regs + offset, data,
    50						      len);
    51			return;
    52		}
    53		__iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(len, 4));
    54	}
    55	
    56	static void mt76_mmio_read_copy_portable(u8 *dst,
    57						 const void __iomem *src, int len)
    58	{
    59		u32 val;
    60		int i;
    61	
    62		for (i = 0; i < ALIGN(len, 4); i += 4) {
  > 63			val = le32_to_cpu(readl(src + i));
    64			memcpy(dst + i, &val, sizeof(val));
    65		}
    66	}
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

