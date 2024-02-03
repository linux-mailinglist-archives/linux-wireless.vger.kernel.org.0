Return-Path: <linux-wireless+bounces-3089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E9848952
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 23:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D80280FBA
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91681642A;
	Sat,  3 Feb 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPHlLmzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B816423
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706999384; cv=none; b=ZvcpFB2eEjoCeYRByYIjyY41tYGpy3IbaYrpb8VwR4igSJ/gsqY8p5WEPfT5kcduMD6c1FX25sILsdbZxC6eOnpmsSAbgJvqVECmZWOm3NLoeR+fgvsleZmbQXnjqD/GJv6Juas+skxBFng3Fh0T0BFy20AdB78E9XbbaWwpSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706999384; c=relaxed/simple;
	bh=HJWQ+j7xiuNX9Mz654Q+3LRPBupZ7ioDeogXoqP/Qdo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DLNA/qxIFSNLqT2ZJIKU34eZ8Dr9YEMqkVTiXraMvZV+R18K3xA4RYPinRU+/4z6/lOWfNI/hPJgjASJETqEx3dTLnFJ4MM8KfPdEPYziP2lxE72Q9hYgq3gZcXjJk8at3LGk6BFQx6RtV0AyDkY3HO/UKD6lsqK7CkdtgRqR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPHlLmzJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706999383; x=1738535383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HJWQ+j7xiuNX9Mz654Q+3LRPBupZ7ioDeogXoqP/Qdo=;
  b=dPHlLmzJk1yKOsFT44TUV9pavvo3LN84e1t8D041Seee0WWvDe8Qoo7d
   nCHwnCAHFPr1omMbOPhiIGempszTSiS8rBiSpK6oOIEaCwnhfFPWPO/NZ
   W8gkbZzoBExuHy7M51rtfNj5AKlLeO3CNl9fW1bTbh1OVo3+tedCtKDlp
   HU+ZXLeDUYx/t1R9zk5/ebTwUDMnTossz6XK/ZnxjvHxTGYTRaPRNHTVU
   WHpwJxM2pNm2vsqBKkFSrCh6KLjagqLuOhoDCOyGNVjPqYYiAdkaI5huW
   Da5ZkLZ2KEUPtFr+S/787SLN4hmXCerYt6TLe4VnDbvy2t4RCZphn4ysH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="241394"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="241394"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 14:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="5007886"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Feb 2024 14:29:39 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWOW1-0005gE-03;
	Sat, 03 Feb 2024 22:29:37 +0000
Date: Sun, 4 Feb 2024 06:29:25 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [wireless-next:main 36/68]
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1476:45: error: no member named
 'phy_filters' in 'struct iwl_mvm'
Message-ID: <202402040640.lvAxs3pQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   5932ad87828b267649d750869c89c0f1a3873477
commit: 427661e4c48887ea2a226cd972e574ae7686fb95 [36/68] wifi: iwlwifi: read SAR tables from UEFI
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240204/202402040640.lvAxs3pQ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040640.lvAxs3pQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040640.lvAxs3pQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1476:45: error: no member named 'phy_filters' in 'struct iwl_mvm'
    1476 |         iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
         |                                               ~~~  ^
   1 error generated.


vim +1476 drivers/net/wireless/intel/iwlwifi/mvm/fw.c

427661e4c48887 Miri Korenblit 2024-01-31  1421  
427661e4c48887 Miri Korenblit 2024-01-31  1422  void iwl_mvm_get_bios_tables(struct iwl_mvm *mvm)
78a19d5285d93e Miri Korenblit 2021-08-05  1423  {
78a19d5285d93e Miri Korenblit 2021-08-05  1424  	int ret;
78a19d5285d93e Miri Korenblit 2021-08-05  1425  
ebe8f41319fabe Miri Korenblit 2024-01-28  1426  	iwl_acpi_get_guid_lock_status(&mvm->fwrt);
ebe8f41319fabe Miri Korenblit 2024-01-28  1427  
78a19d5285d93e Miri Korenblit 2021-08-05  1428  	/* read PPAG table */
e8e10a37c51c08 Matt Chen      2022-03-04  1429  	ret = iwl_acpi_get_ppag_table(&mvm->fwrt);
78a19d5285d93e Miri Korenblit 2021-08-05  1430  	if (ret < 0) {
78a19d5285d93e Miri Korenblit 2021-08-05  1431  		IWL_DEBUG_RADIO(mvm,
78a19d5285d93e Miri Korenblit 2021-08-05  1432  				"PPAG BIOS table invalid or unavailable. (%d)\n",
78a19d5285d93e Miri Korenblit 2021-08-05  1433  				ret);
78a19d5285d93e Miri Korenblit 2021-08-05  1434  	}
78a19d5285d93e Miri Korenblit 2021-08-05  1435  
78a19d5285d93e Miri Korenblit 2021-08-05  1436  	/* read SAR tables */
427661e4c48887 Miri Korenblit 2024-01-31  1437  	ret = iwl_bios_get_wrds_table(&mvm->fwrt);
78a19d5285d93e Miri Korenblit 2021-08-05  1438  	if (ret < 0) {
78a19d5285d93e Miri Korenblit 2021-08-05  1439  		IWL_DEBUG_RADIO(mvm,
78a19d5285d93e Miri Korenblit 2021-08-05  1440  				"WRDS SAR BIOS table invalid or unavailable. (%d)\n",
78a19d5285d93e Miri Korenblit 2021-08-05  1441  				ret);
78a19d5285d93e Miri Korenblit 2021-08-05  1442  		/*
78a19d5285d93e Miri Korenblit 2021-08-05  1443  		 * If not available, don't fail and don't bother with EWRD and
78a19d5285d93e Miri Korenblit 2021-08-05  1444  		 * WGDS */
78a19d5285d93e Miri Korenblit 2021-08-05  1445  
427661e4c48887 Miri Korenblit 2024-01-31  1446  		if (!iwl_bios_get_wgds_table(&mvm->fwrt)) {
78a19d5285d93e Miri Korenblit 2021-08-05  1447  			/*
78a19d5285d93e Miri Korenblit 2021-08-05  1448  			 * If basic SAR is not available, we check for WGDS,
78a19d5285d93e Miri Korenblit 2021-08-05  1449  			 * which should *not* be available either.  If it is
78a19d5285d93e Miri Korenblit 2021-08-05  1450  			 * available, issue an error, because we can't use SAR
78a19d5285d93e Miri Korenblit 2021-08-05  1451  			 * Geo without basic SAR.
78a19d5285d93e Miri Korenblit 2021-08-05  1452  			 */
78a19d5285d93e Miri Korenblit 2021-08-05  1453  			IWL_ERR(mvm, "BIOS contains WGDS but no WRDS\n");
78a19d5285d93e Miri Korenblit 2021-08-05  1454  		}
78a19d5285d93e Miri Korenblit 2021-08-05  1455  
78a19d5285d93e Miri Korenblit 2021-08-05  1456  	} else {
427661e4c48887 Miri Korenblit 2024-01-31  1457  		ret = iwl_bios_get_ewrd_table(&mvm->fwrt);
78a19d5285d93e Miri Korenblit 2021-08-05  1458  		/* if EWRD is not available, we can still use
78a19d5285d93e Miri Korenblit 2021-08-05  1459  		* WRDS, so don't fail */
78a19d5285d93e Miri Korenblit 2021-08-05  1460  		if (ret < 0)
78a19d5285d93e Miri Korenblit 2021-08-05  1461  			IWL_DEBUG_RADIO(mvm,
78a19d5285d93e Miri Korenblit 2021-08-05  1462  					"EWRD SAR BIOS table invalid or unavailable. (%d)\n",
78a19d5285d93e Miri Korenblit 2021-08-05  1463  					ret);
78a19d5285d93e Miri Korenblit 2021-08-05  1464  
78a19d5285d93e Miri Korenblit 2021-08-05  1465  		/* read geo SAR table */
78a19d5285d93e Miri Korenblit 2021-08-05  1466  		if (iwl_sar_geo_support(&mvm->fwrt)) {
427661e4c48887 Miri Korenblit 2024-01-31  1467  			ret = iwl_bios_get_wgds_table(&mvm->fwrt);
78a19d5285d93e Miri Korenblit 2021-08-05  1468  			if (ret < 0)
78a19d5285d93e Miri Korenblit 2021-08-05  1469  				IWL_DEBUG_RADIO(mvm,
78a19d5285d93e Miri Korenblit 2021-08-05  1470  						"Geo SAR BIOS table invalid or unavailable. (%d)\n",
78a19d5285d93e Miri Korenblit 2021-08-05  1471  						ret);
78a19d5285d93e Miri Korenblit 2021-08-05  1472  				/* we don't fail if the table is not available */
78a19d5285d93e Miri Korenblit 2021-08-05  1473  		}
78a19d5285d93e Miri Korenblit 2021-08-05  1474  	}
c4c95454775592 Johannes Berg  2023-06-14  1475  
c4c95454775592 Johannes Berg  2023-06-14 @1476  	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
78a19d5285d93e Miri Korenblit 2021-08-05  1477  }
6996490501ed80 Luca Coelho    2017-01-12  1478  

:::::: The code at line 1476 was first introduced by commit
:::::: c4c954547755927807aaca981025847821dd2d0c wifi: iwlwifi: implement WPFC ACPI table loading

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

