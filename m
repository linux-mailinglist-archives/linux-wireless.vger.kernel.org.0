Return-Path: <linux-wireless+bounces-3076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A1C84840D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 07:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690C51F247EB
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3D134AE;
	Sat,  3 Feb 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7oW+Pkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201912E70
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706940979; cv=none; b=NcTH3k52Q1n2TsXj9vc57vyGZA36rHOPtMutNbhLc0pDkYqE2cTG/Ryn1dDuLYdhVPmu679m8T5Gs1oAKeDCbd1wiQJnS3SgGT6SGAPPcKbHaypeT8fAqXCl7+JyxhEPqapyODfjDBpSq3ATD7gMDqqVYq5270s2CswRp7XssI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706940979; c=relaxed/simple;
	bh=RidlOSqi2CYLEakxkwfxmPYFO7B/a8huV3f7gYbpYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=guSj52LCxCwxdUv0ifvbzmZjrMVW7jUyH2iw7ro/d+KwSeAta8pq/8YX/pIhcvBhktc7sps934fm/8RGrwK9VU/hbeC8LIAjKXEVIIhRm+Xzf/mqCBU/xjt07NrY/QF8SLLxh/5m2el5i96qF1dwIbEeKBk1IN+NqWJ5tlnx4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7oW+Pkg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706940978; x=1738476978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RidlOSqi2CYLEakxkwfxmPYFO7B/a8huV3f7gYbpYbE=;
  b=c7oW+PkgNDWSjXggZ7Vwz1EM9X5mw3snEeTAtLUhwIzqtV/Za/KwipMc
   zwuLjr8l17/5ohGThUPlNrteNZwCHZGMse+zPzAKpG67DBS1UEVXWZYJr
   k6q+AxX3upsiR+dUGTtBHfzE7Mr6ZZPYjEcdCjQ2BMULq+5y05EUAfOQy
   D5XyV33PPOMFWkMjGw0sOdUJfoXQjltG1naYOIVsB+5OyOnrQcztC1PwJ
   nBaZt4VLKR2BSitYFEb0zHVx/Rr6bTQwapRU3CQ2LoAuDF8bjrF0cywoL
   r82wdI3LHGobhii9F/Kba8WW7220Onucnr5mdHir0Aq3CyjHmGoHAkygx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17817359"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17817359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 22:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="266869"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Feb 2024 22:16:16 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW9Jz-0004hb-1C;
	Sat, 03 Feb 2024 06:16:11 +0000
Date: Sat, 3 Feb 2024 14:15:19 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [wireless-next:main 36/68]
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1476:50: error: 'struct iwl_mvm'
 has no member named 'phy_filters'
Message-ID: <202402031454.syX4cSGN-lkp@intel.com>
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
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402031454.syX4cSGN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402031454.syX4cSGN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031454.syX4cSGN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_get_bios_tables':
>> drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1476:50: error: 'struct iwl_mvm' has no member named 'phy_filters'
    1476 |         iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
         |                                                  ^~


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

