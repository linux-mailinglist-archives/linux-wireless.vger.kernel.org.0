Return-Path: <linux-wireless+bounces-517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68232807C82
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 00:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EA028256F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CB2EB19;
	Wed,  6 Dec 2023 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFPRrP3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD809181
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701906250; x=1733442250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Au4NheutJTv2N9tkxCMLcTBy6zYGIHCMAyKzgq/xz0=;
  b=XFPRrP3anBDiqTF0NN7QBFsqjHT44n7lXAh8SzVT+Slq58XKjxEHcmMB
   hoyk1owlBp4sPPILIJ6HtR/5l770+K2U3YhL+1NV0CGo+C+aEiHJ0mUHJ
   YrE6xQdBnMofQMDko1WJa2zRuZxzZBvUI/5uzB2rkkiyzrqc8xy8xA8Hx
   6OeymmgrH7Uc3EI56eY8dDKvKyn+ogQD9uMvgokiZQR5NvQMqMqdifuzm
   fanPGyxzTDeSk2wanX4VtL+2dMDAx7UwsdDm4483uKw9tgk1JqKyyScvL
   wqLWH5DCpqrEx8IQeKkpitnODvWvlVf/Gg2qOC0ufVYxGZroSGiL/rvOT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="373634436"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="373634436"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018737714"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018737714"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2023 15:44:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rB1Yk-000Bb6-35;
	Wed, 06 Dec 2023 23:44:06 +0000
Date: Thu, 7 Dec 2023 07:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	quic_lingbok@quicinc.com
Subject: Re: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Message-ID: <202312070759.wWy93Ana-lkp@intel.com>
References: <20231206134654.24662-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206134654.24662-1-quic_lingbok@quicinc.com>

Hi Lingbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0dbdc9383054fd3ecbcacfeb364aace3db744314]

url:    https://github.com/intel-lab-lkp/linux/commits/Lingbo-Kong/wifi-ath12k-report-tx-bitrate-for-iw-dev-xxx-station-dump/20231206-215109
base:   0dbdc9383054fd3ecbcacfeb364aace3db744314
patch link:    https://lore.kernel.org/r/20231206134654.24662-1-quic_lingbok%40quicinc.com
patch subject: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station dump
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231207/202312070759.wWy93Ana-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070759.wWy93Ana-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070759.wWy93Ana-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/mac.c:7765:20: warning: conflicting types for 'ath12k_mac_he_gi_to_nl80211_he_gi' due to enum/integer mismatch; have 'enum nl80211_he_gi(u8)' {aka 'enum nl80211_he_gi(unsigned char)'} [-Wenum-int-mismatch]
    7765 | enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/wireless/ath/ath12k/mac.c:9:
   drivers/net/wireless/ath/ath12k/mac.h:79:5: note: previous declaration of 'ath12k_mac_he_gi_to_nl80211_he_gi' with type 'u32(u8)' {aka 'unsigned int(unsigned char)'}
      79 | u32 ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +7765 drivers/net/wireless/ath/ath12k/mac.c

  7764	
> 7765	enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

