Return-Path: <linux-wireless+bounces-3066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95849847C1C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 23:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C33B21741
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785483A1D;
	Fri,  2 Feb 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgodMNrL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC883A07
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912016; cv=none; b=uOipS6n8g0tFBP9fv+WNDs4Wi/ZoR/JpIslPIznSBTkcxJ6wl3VC7NF/JeLF8nyXhS+HJxx225U1nlnSAjXtgjySqedzX7zWfkUxbCuyY0i0Lz4Kb/UYopz9dchAr7vs0J+GfV2999Sr7vRL6T+EdFGWFGTzZlj6eHZIcwrAHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912016; c=relaxed/simple;
	bh=DnwemEYa0bYIhnNeOAt+zcYgMIjBxVZYj5TuEh6aFZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B7tIvYS+N+SzugXsD6ixnquSU8NhxEAK/sLe9NqMJnmdT8opWIh5RWb9eQuKPl8VaiQIQgoNyo54nDgWRuz9HyY8+z0tb9i8vcIIPxOkJAsKqeNj21eW2NoJ6KVaM5CvTAYrk3DA4dfGNf+9Hxj+u2O5SMMRngDhIKCNCWnD0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgodMNrL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706912014; x=1738448014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DnwemEYa0bYIhnNeOAt+zcYgMIjBxVZYj5TuEh6aFZk=;
  b=YgodMNrLflvd4HG7kyh0ahZkM1xcx7FpAD+G0FpO/8+S9Q/GtApRBvmw
   A9SM554vLKMLNElJWRCPaMS1kVYK5OAX82kpYxDkcbunNQypuphATDUKB
   /6UvsukZ3XF6o24cB8KRLvDvdyO+Ci8FIrD5+MAjMv0rVfl8evhu2P2S0
   BqHdpJRzO+C8Abg0yx5d/GcYo+j2nRKUioAR+Yf+0LW2tXJzj4CT4NO4I
   IeRpKzA4Uh9LZ0dFg6cChe90fN/F7wukZZFWGBmuMuaiJFQM5KE0BUEZ8
   zO9ecSK1mvlk/Z0yHaAIOFu/G6g8pQucukQ0d2VZalDzZKXvVh+7KnKxr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11617342"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11617342"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 14:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="195163"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 14:13:31 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW1mq-0004J6-39;
	Fri, 02 Feb 2024 22:13:28 +0000
Date: Sat, 3 Feb 2024 06:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [wireless-next:main 44/68]
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c:395:33: warning: '%s'
 directive argument is null
Message-ID: <202402030641.zUTuACYV-lkp@intel.com>
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
commit: 084e0452a42b1d4ccde601cc1873a4ee9d8a4cbb [44/68] wifi: iwlwifi: read WTAS table from UEFI
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402030641.zUTuACYV-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030641.zUTuACYV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030641.zUTuACYV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/fw/regulatory.c:7:
   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c: In function 'iwl_is_ppag_approved':
>> drivers/net/wireless/intel/iwlwifi/fw/regulatory.c:395:33: warning: '%s' directive argument is null [-Wformat-overflow=]
     395 |                                 "System vendor '%s' is not in the approved list, disabling PPAG.\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
      91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
         |                                                        ^~~
   drivers/net/wireless/intel/iwlwifi/iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
     209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
         |                                         ^~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c:394:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
     394 |                 IWL_DEBUG_RADIO(fwrt,
         |                 ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/fw/regulatory.c:395:49: note: format string is defined here
     395 |                                 "System vendor '%s' is not in the approved list, disabling PPAG.\n",
         |                                                 ^~


vim +395 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c

09059c6764a887 Miri Korenblit 2024-01-31  390  
09059c6764a887 Miri Korenblit 2024-01-31  391  bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt)
09059c6764a887 Miri Korenblit 2024-01-31  392  {
09059c6764a887 Miri Korenblit 2024-01-31  393  	if (!dmi_check_system(dmi_ppag_approved_list)) {
09059c6764a887 Miri Korenblit 2024-01-31  394  		IWL_DEBUG_RADIO(fwrt,
09059c6764a887 Miri Korenblit 2024-01-31 @395  				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
09059c6764a887 Miri Korenblit 2024-01-31  396  				dmi_get_system_info(DMI_SYS_VENDOR));
09059c6764a887 Miri Korenblit 2024-01-31  397  				fwrt->ppag_flags = 0;
09059c6764a887 Miri Korenblit 2024-01-31  398  				return false;
09059c6764a887 Miri Korenblit 2024-01-31  399  	}
09059c6764a887 Miri Korenblit 2024-01-31  400  
09059c6764a887 Miri Korenblit 2024-01-31  401  	return true;
09059c6764a887 Miri Korenblit 2024-01-31  402  }
09059c6764a887 Miri Korenblit 2024-01-31  403  IWL_EXPORT_SYMBOL(iwl_is_ppag_approved);
ad5a85d8fdd346 Miri Korenblit 2024-01-31  404  

:::::: The code at line 395 was first introduced by commit
:::::: 09059c6764a8870ff7515c2d78ecbea7fbcffc23 wifi: iwlwifi: prepare for reading PPAG table from UEFI

:::::: TO: Miri Korenblit <miriam.rachel.korenblit@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

