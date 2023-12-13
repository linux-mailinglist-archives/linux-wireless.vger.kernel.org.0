Return-Path: <linux-wireless+bounces-457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B380663C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 05:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCE1B212CD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73040E576;
	Wed,  6 Dec 2023 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAk8XbSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE81BF;
	Tue,  5 Dec 2023 20:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701837281; x=1733373281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sq4PJPq6VrkCmDvgjz4GTxFgQOfpDStAzoJv/e5p5AQ=;
  b=RAk8XbSWbFO2prS0S9EByQNG3FZ8EMi6HhlSS5Y0AF/Ec4XM2h7Rwf3f
   tmt8PMi1zFB0BqF1O26CPyq9QlWAvsHtQpUVYoflvhQLgwxrwpZwKC0Ge
   b0jn/UHMy3XWV9UI+tD5oAq7BahdIEV4lPaJ8j2NWGSAKBYHdbx/bMwpq
   srmBTd8Ti3g+DTLwRIKPtOijXi0bQK3uiaze/K+ZHwbnT45A+bobU0iU0
   GfXSC0OF42py7T/nZw4mYen8S1awFyedNiF0kXVvX5XbxZF41v0ReUzT3
   Rion1s8gPEXewObUWQxow8tQC66tHSlFepi5IOVbvcKaLDO6L1tIg+Mty
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="379023583"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="379023583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 20:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944514523"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944514523"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 20:34:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAjcH-000AGM-22;
	Wed, 06 Dec 2023 04:34:33 +0000
Date: Wed, 6 Dec 2023 12:34:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
	lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
	mario.limonciello@amd.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, majun@amd.com,
	Evan Quan <quanliangl@hotmail.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v14 4/9] wifi: mac80211: Add support for WBRF features
Message-ID: <202312061213.9yUe2RGP-lkp@intel.com>
References: <20231129091348.3972539-5-Jun.Ma2@amd.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129091348.3972539-5-Jun.Ma2@amd.com>

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc1]
[also build test ERROR on next-20231205]
[cannot apply to drm-misc/drm-misc-next wireless-next/main wireless/main linus/master v6.7-rc3 v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Jun/Documentation-driver-api-Add-document-about-WBRF-mechanism/20231129-181516
base:   v6.7-rc1
patch link:    https://lore.kernel.org/r/20231129091348.3972539-5-Jun.Ma2%40amd.com
patch subject: [PATCH v14 4/9] wifi: mac80211: Add support for WBRF features
config: arm-randconfig-004-20231201 (https://download.01.org/0day-ci/archive/20231206/202312061213.9yUe2RGP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061213.9yUe2RGP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061213.9yUe2RGP-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/mac80211/wbrf.c: In function 'ieee80211_add_wbrf':
>> net/mac80211/wbrf.c:79:9: error: implicit declaration of function 'acpi_amd_wbrf_add_remove'; did you mean 'acpi_amd_wbrf_add_exclusion'? [-Werror=implicit-function-declaration]
      79 |         acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         acpi_amd_wbrf_add_exclusion
   cc1: some warnings being treated as errors


vim +79 net/mac80211/wbrf.c

    66	
    67	void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
    68	{
    69		struct wbrf_ranges_in_out ranges_in = {0};
    70		struct device *dev;
    71	
    72		if (!local->wbrf_supported)
    73			return;
    74	
    75		dev = local->hw.wiphy->dev.parent;
    76	
    77		get_ranges_from_chandef(chandef, &ranges_in);
    78	
  > 79		acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

