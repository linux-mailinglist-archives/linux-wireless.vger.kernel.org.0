Return-Path: <linux-wireless+bounces-8031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFBD8CDD91
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07254287F00
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6182628D;
	Thu, 23 May 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt5F5NZy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43E128365
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506397; cv=none; b=QfZWNjeqMCImahioE1VHDPpOqfsobGVDDijCCJ3GkPe0bVyKq71WEnvpDI1K7hoJl50+LRX4IrfPutsTt0XL4lq1JRFp3zqEgzbPdfRIQLrHiKmQ11KOdUTzSj+Z4diIkSgv4iDPg3VMyJypeladUMESqKc8MQSULxOlS+vzfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506397; c=relaxed/simple;
	bh=ACmX4IEn54SaAC87dL8zEWDwnaff6O+GAz1ga3siCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DcAK2hYxMjXLOJXackncWd/UY5cyigXlEbCCJjhJTtvXCQ8bZ3eYbxE5ZYPDFzfMCJF4lEVgNTh4YNRy6PhyqdQ0S9o+e/kywo3VR4GkmDumyS1OfehZkc0BhpniIV9LYA2ghki/EapAffD9/SpQ71KjlbMPE7I+nOSMSKhobuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt5F5NZy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716506395; x=1748042395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ACmX4IEn54SaAC87dL8zEWDwnaff6O+GAz1ga3siCWA=;
  b=kt5F5NZyyY8j0G8c7tgNAMnYG8tRwm9AfFvSn7hnH542l63pX8wuDUQZ
   DUALEsUxOk/56P/wi7qFADChyRU8Vao2/S0usrBam8oAWCqtnEX72uU2B
   3JD6+D3ImYge7ZUOpeIF5wTM6ErQwF2v39mjSDO5uQGgDY41NA5cia9jv
   5mGEOT1pincHrJglRhD+JmgsU4xni2NUPbG8K3mbZDMDZV5TRiAd9eNZ8
   k4nIMyszSNANPrdyXbnvlHMyDp7p/pwK+YnyD9SofNTo0HoMAlhDnM8CY
   iaoj1urkCNITkaQY1re2YvgM5t8mJGU32Tah1+FoO47/XFfYPenrCpPIB
   Q==;
X-CSE-ConnectionGUID: 40GN6DkwT4ex1KgzKUsAZw==
X-CSE-MsgGUID: IInOuIGWQNmEfs4bdUMO2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="11670610"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="11670610"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 16:19:55 -0700
X-CSE-ConnectionGUID: GQCow7FCRtCpWe3Lu51isA==
X-CSE-MsgGUID: 3AgluSv0TPSPlVJ0ktr9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33815267"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 May 2024 16:19:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAHix-0003bt-09;
	Thu, 23 May 2024 23:19:51 +0000
Date: Fri, 24 May 2024 07:19:13 +0800
From: kernel test robot <lkp@intel.com>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [wireless-next:main 45/61]
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.o: warning: objtool:
 unexpected relocation symbol type in .rela.discard.reachable
Message-ID: <202405240755.nD7VAvLn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   a92fd2d9327ba877f29753eec15b93072ac300b0
commit: 6584b9d0aa3234bd8af419e46de1a9648cd34116 [45/61] wifi: iwlwifi: move code from iwl-eeprom-parse to dvm
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240524/202405240755.nD7VAvLn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405240755.nD7VAvLn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405240755.nD7VAvLn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable
--
>> drivers/net/wireless/intel/iwlwifi/dvm/eeprom.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

