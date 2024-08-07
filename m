Return-Path: <linux-wireless+bounces-11076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23DE94A42A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748071F24DE9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD31CCB2B;
	Wed,  7 Aug 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gki+FWDk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C32811E2
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022416; cv=none; b=qA8aT41FZWsfmimYmKa3wC8ywKlEst6pqwagSwkz2aNK73HOwu+zcCEtOVwSMzznZI0jSc1rtZsMys0jN6GKiMV6YcGHIYO5MnR2Il+ACfHAS1mO4N/2//eaB5+RtBblfVohcvRa0Aw+v0P5yTU37iRe44muwqNChNRYmDc8o34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022416; c=relaxed/simple;
	bh=9EnVftXVQX8DQRImvxhrpfvL4NSOIAveu8bVaaXe7iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqtvBPRbdWppN7DTSXtqct1EikKrzkyy7X9kG8vxpDyCMuG/eUkXLg0L23f7TNvp3daVXhClCHQloM5ne3obQjYzMfKk5lFMxYBlWyepelzmP63tlpFfzRIdorYUZeKNYaFa/+2TmKeG4PlrhFH5qgkdH8imvXRqnQjM4X3q+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gki+FWDk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723022414; x=1754558414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9EnVftXVQX8DQRImvxhrpfvL4NSOIAveu8bVaaXe7iI=;
  b=gki+FWDkWU/juUyt3XOO6f4lwiU+74WZdG2IZ8W4sWVzBe/WIa27vBXM
   37AHKKlnUnKtx3jiaKyZlWLcenjYGRA9sEdCfnmTOEw/Y1XC1tiM0zA6u
   WXAK1atS4qjytsAbeKbp2jS3jIYlLrkfnp7KB7xSqkZgyKyGzW4aqVMPH
   b7YqJKTLxSORVr5aDygJ2JgyiPGOHKhDtR90jqb2RKzc1SDWIjSitdu2Y
   ZCBOqObtEqkepAYU+UuXTPBytuTnb7OwQFCp4NmCTYv1jQD/JhvXvZrAO
   SkG33cNXhvM19nF30AuTzh8TLhDMfirL8gCqQty35mcQWmMG0fMR4qlzO
   A==;
X-CSE-ConnectionGUID: wHJUXwmuTfG4LFeN9r2q0w==
X-CSE-MsgGUID: DN1ik2pnQievNoKTwzsG+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21223620"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21223620"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 02:20:13 -0700
X-CSE-ConnectionGUID: wmfEZko7Q+uOQf1HlCkJag==
X-CSE-MsgGUID: B0k27i1mTH6RZCQT47491Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56760713"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Aug 2024 02:20:09 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbcpv-0005GC-2d;
	Wed, 07 Aug 2024 09:20:05 +0000
Date: Wed, 7 Aug 2024 17:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: David Ruth <druth@chromium.org>, nbd@nbd.name, lorenzo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	timvp@chromium.org, sean.wang@mediatek.com, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, David Ruth <druth@chromium.org>
Subject: Re: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
Message-ID: <202408071657.Qkyy8VqM-lkp@intel.com>
References: <20240806222113.2689446-1-druth@chromium.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806222113.2689446-1-druth@chromium.org>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ruth/wifi-mt76-mt7921-Cancel-scan-work-on-unregister/20240807-065202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240806222113.2689446-1-druth%40chromium.org
patch subject: [PATCH] wifi: mt76: mt7921: Cancel scan work on unregister.
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240807/202408071657.Qkyy8VqM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408071657.Qkyy8VqM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408071657.Qkyy8VqM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c: In function 'mt7921s_unregister_device':
>> drivers/net/wireless/mediatek/mt76/mt7921/sdio.c:44:47: error: invalid type argument of '->' (have 'struct mt76_phy')
      44 |         struct mt792x_phy *phy = dev->mt76.phy->priv;
         |                                               ^~


vim +44 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c

    40	
    41	static void mt7921s_unregister_device(struct mt792x_dev *dev)
    42	{
    43		struct mt76_connac_pm *pm = &dev->pm;
  > 44		struct mt792x_phy *phy = dev->mt76.phy->priv;
    45	
    46		cancel_delayed_work_sync(&phy->scan_work);
    47		cancel_work_sync(&dev->init_work);
    48		mt76_unregister_device(&dev->mt76);
    49		cancel_delayed_work_sync(&pm->ps_work);
    50		cancel_work_sync(&pm->wake_work);
    51	
    52		mt76s_deinit(&dev->mt76);
    53		mt7921s_wfsys_reset(dev);
    54		skb_queue_purge(&dev->mt76.mcu.res_q);
    55	
    56		mt76_free_device(&dev->mt76);
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

