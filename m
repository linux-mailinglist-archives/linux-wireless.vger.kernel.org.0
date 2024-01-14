Return-Path: <linux-wireless+bounces-1884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BD82CF65
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CA81F21F9A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B8652;
	Sun, 14 Jan 2024 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sjq0zdzT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05EB7E
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705192017; x=1736728017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I2mL3c3ERQHPa3sjMYvumkTu7KOXnWLKiyk7o7BzM2k=;
  b=Sjq0zdzTc4uBDG2+XYic/o3cxEutT5CMUMT3sXts2ibaRQTP2Fgt9GOe
   DQLCcPeyCGQK58IxxrLsA7CZVT7drsUFit+l2r+LG4oG5eyEUzAb1WPKV
   JwFuWVLIRvQjYb8vZsZTv0ySOFkNW4TSEr7v3fg0TBxM9drZBTAKKddVC
   4+QiEK7FYFmpvFUg6/WcewdXjEDBAeHFxHrS2FcIPanKVghJK1hDCh3h2
   b1tC+Xr+mFoDfyqrO0HlXWxmYeXx5h/C2lFqTZlIs+mlK0UHwrkPSklM7
   KLO65vaH70HU46Qkmznu4YBXbwPqFSvQvkJZgg1S3bJNZ//dH1OaeL/wT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6174185"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="6174185"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 16:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="873736301"
X-IronPort-AV: E=Sophos;i="6.04,193,1695711600"; 
   d="scan'208";a="873736301"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2024 16:26:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOoKy-000B2W-1Z;
	Sun, 14 Jan 2024 00:26:52 +0000
Date: Sun, 14 Jan 2024 08:25:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtlwifi: Speed up firmware loading for USB
Message-ID: <202401140857.MXysoKVh-lkp@intel.com>
References: <0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com>

Hi Bitterblue,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[cannot apply to wireless/main linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitterblue-Smith/wifi-rtlwifi-Speed-up-firmware-loading-for-USB/20240113-035326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/0d262acd-4f94-41c2-8d15-83486aeb976b%40gmail.com
patch subject: [PATCH] wifi: rtlwifi: Speed up firmware loading for USB
config: csky-randconfig-r113-20240114 (https://download.01.org/0day-ci/archive/20240114/202401140857.MXysoKVh-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240114/202401140857.MXysoKVh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140857.MXysoKVh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/realtek/rtlwifi/efuse.c:1329:41: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] val32 @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/realtek/rtlwifi/efuse.c:1329:41: sparse:     expected unsigned int [usertype] val32
   drivers/net/wireless/realtek/rtlwifi/efuse.c:1329:41: sparse:     got restricted __le32 [usertype]

vim +1329 drivers/net/wireless/realtek/rtlwifi/efuse.c

  1289	
  1290	static void _rtl_fw_block_write_usb(struct ieee80211_hw *hw, u8 *buffer, u32 size)
  1291	{
  1292		struct rtl_priv *rtlpriv = rtl_priv(hw);
  1293		u32 blockcount, blockcount8, blockcount4;
  1294		u32 remain8 = 0, remain4 = 0, remain = 0;
  1295		const u32 blocksize = 64;
  1296		const u32 blocksize8 = 8;
  1297		const u32 blocksize4 = 4;
  1298		u32 i, offset;
  1299	
  1300		blockcount = size / blocksize;
  1301		remain8 = size % blocksize;
  1302		for (i = 0; i < blockcount; i++) {
  1303			offset = i * blocksize;
  1304			rtl_write_chunk(rtlpriv,
  1305					START_ADDRESS + offset,
  1306					blocksize, buffer + offset);
  1307		}
  1308	
  1309		if (remain8) {
  1310			offset = blockcount * blocksize;
  1311			blockcount8 = remain8 / blocksize8;
  1312			remain4 = remain8 % blocksize8;
  1313	
  1314			for (i = 0; i < blockcount8; i++)
  1315				rtl_write_chunk(rtlpriv,
  1316						START_ADDRESS + offset + i * blocksize8,
  1317						blocksize8,
  1318						buffer + offset + i * blocksize8);
  1319		}
  1320	
  1321		if (remain4) {
  1322			offset += blockcount8 * blocksize8;
  1323			blockcount4 = remain4 / blocksize4;
  1324			remain = remain8 % blocksize4;
  1325	
  1326			for (i = 0; i < blockcount4; i++)
  1327				rtl_write_dword(rtlpriv,
  1328						START_ADDRESS + offset + i * blocksize4,
> 1329						cpu_to_le32(*(u32 *)(buffer + offset + i)));
  1330		}
  1331	
  1332		if (remain) {
  1333			offset += blockcount4 * blocksize4;
  1334	
  1335			for (i = 0; i < remain; i++)
  1336				rtl_write_byte(rtlpriv, START_ADDRESS + offset + i,
  1337					       *(buffer + offset + i));
  1338		}
  1339	}
  1340	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

