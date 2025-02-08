Return-Path: <linux-wireless+bounces-18651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A381CA2D3DD
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 05:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590647A5852
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2025 04:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C9199921;
	Sat,  8 Feb 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFcFNB8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8A195B37
	for <linux-wireless@vger.kernel.org>; Sat,  8 Feb 2025 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738989903; cv=none; b=ckdkqdrUbGJ5zDzH7i4X5lnkwlWYqi4OdS3RJYd2DtQ7nTXNEJu+QkthH35zhesiSrI/WEAJPG724igTs/dWng66DCEs0HUsrqy3SR2j0dfzqC89tsIuYYIEvJmxrVUi2EivATH7IbKJYCL7HdsEzjppVk9Ox1QON0Mt0a2CAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738989903; c=relaxed/simple;
	bh=GvYQaLiDW/yeR5mK5o7wYWIt7Bg9kP22YSV3dyDsULc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn6G+UC/8zCRarrncrpl9f3ZQ1OBTwC1hvHDXEwuhJB4wwjJQpaudCGNrI/EensUdJ/9RiHyMBdd00qkWi/wzvHfJlc8g+tp0AN0S5SyzZqZzl+ZXuG8u0qO/nyCPv98HnzyJXBT9ulmocY7pd+nEA4MI2SyY6g9FvFK3rb7UZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFcFNB8c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738989902; x=1770525902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvYQaLiDW/yeR5mK5o7wYWIt7Bg9kP22YSV3dyDsULc=;
  b=VFcFNB8csiBVHyQ7J0pQiKsvU5lpYpxKE3EcnuIxQgJYNYmn6fTejj/F
   9gLjO9patiFsSdSE695h4SsJEjuUw3EsumIiqplBKzTEmmm63j76SW/sw
   omZGPEQuOF6pHXNkt4cvwoHgcu8AMlCUHsc6ZBJGXbicDI7A4RPgZC9RX
   ZyQ4eaYdeB1S+3XyOku0QE3H1z5ljsAFQ0TEed9aZf+ALr1NyNww3VV8S
   28NdLO6yswp6Xd0kzUBVjXdhAYeBY0iD0/TmT3NHysPT5m7IFGzCCPANr
   +j9Yd5MiVkPU8ORtYZDCOIRLVMT8Lb+s+ffzpMQhwO/+hrZTimBhfHNiP
   Q==;
X-CSE-ConnectionGUID: /OQDiXk6SMq8ptl/oMA3FA==
X-CSE-MsgGUID: 1EzuL2/PQIyeNohYdxRkAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43401131"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="43401131"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 20:45:02 -0800
X-CSE-ConnectionGUID: WgkKndJ3Qt+uoB/ZP1d8IA==
X-CSE-MsgGUID: ZlKvYrhsSNuso87MzZFjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116646881"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 20:45:00 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgci9-000zXH-34;
	Sat, 08 Feb 2025 04:44:57 +0000
Date: Sat, 8 Feb 2025 12:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, quic_lingbok@quicinc.com
Subject: Re: [PATCH] wifi: ath12k: report station mode per-chain signal
 strength
Message-ID: <202502081250.6rZZ2s6H-lkp@intel.com>
References: <20250207071003.162576-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207071003.162576-1-quic_lingbok@quicinc.com>

Hi Lingbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d132a72d768bae74d10e6539fcf6522dfdbd1115]

url:    https://github.com/intel-lab-lkp/linux/commits/Lingbo-Kong/wifi-ath12k-report-station-mode-per-chain-signal-strength/20250207-151239
base:   d132a72d768bae74d10e6539fcf6522dfdbd1115
patch link:    https://lore.kernel.org/r/20250207071003.162576-1-quic_lingbok%40quicinc.com
patch subject: [PATCH] wifi: ath12k: report station mode per-chain signal strength
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250208/202502081250.6rZZ2s6H-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502081250.6rZZ2s6H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081250.6rZZ2s6H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/wmi.c:6:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/wmi.c:7550:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    7550 |         default:
         |         ^
   drivers/net/wireless/ath/ath12k/wmi.c:7550:2: note: insert 'break;' to avoid fall-through
    7550 |         default:
         |         ^
         |         break; 
   4 warnings generated.


vim +7550 drivers/net/wireless/ath/ath12k/wmi.c

1715fcabad1648 Lingbo Kong 2025-02-07  7520  
79e7b04b5388c1 Lingbo Kong 2025-01-15  7521  static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
79e7b04b5388c1 Lingbo Kong 2025-01-15  7522  					 u16 tag, u16 len,
79e7b04b5388c1 Lingbo Kong 2025-01-15  7523  					 const void *ptr, void *data)
79e7b04b5388c1 Lingbo Kong 2025-01-15  7524  {
79e7b04b5388c1 Lingbo Kong 2025-01-15  7525  	struct wmi_tlv_fw_stats_parse *parse = data;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7526  	int ret = 0;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7527  
79e7b04b5388c1 Lingbo Kong 2025-01-15  7528  	switch (tag) {
79e7b04b5388c1 Lingbo Kong 2025-01-15  7529  	case WMI_TAG_STATS_EVENT:
79e7b04b5388c1 Lingbo Kong 2025-01-15  7530  		parse->ev = ptr;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7531  		break;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7532  	case WMI_TAG_ARRAY_BYTE:
79e7b04b5388c1 Lingbo Kong 2025-01-15  7533  		ret = ath12k_wmi_tlv_fw_stats_data_parse(ab, parse, ptr, len);
79e7b04b5388c1 Lingbo Kong 2025-01-15  7534  		break;
1715fcabad1648 Lingbo Kong 2025-02-07  7535  	case WMI_TAG_PER_CHAIN_RSSI_STATS:
1715fcabad1648 Lingbo Kong 2025-02-07  7536  		parse->rssi = ptr;
1715fcabad1648 Lingbo Kong 2025-02-07  7537  		if (le32_to_cpu(parse->ev->stats_id) & WMI_REQUEST_RSSI_PER_CHAIN_STAT)
1715fcabad1648 Lingbo Kong 2025-02-07  7538  			parse->rssi_num = le32_to_cpu(parse->rssi->num_per_chain_rssi);
1715fcabad1648 Lingbo Kong 2025-02-07  7539  		break;
1715fcabad1648 Lingbo Kong 2025-02-07  7540  	case WMI_TAG_ARRAY_STRUCT:
1715fcabad1648 Lingbo Kong 2025-02-07  7541  		if (parse->rssi_num && !parse->chain_rssi_done) {
1715fcabad1648 Lingbo Kong 2025-02-07  7542  			ret = ath12k_wmi_tlv_iter(ab, ptr, len,
1715fcabad1648 Lingbo Kong 2025-02-07  7543  						  ath12k_wmi_tlv_rssi_chain_parse,
1715fcabad1648 Lingbo Kong 2025-02-07  7544  						  parse);
1715fcabad1648 Lingbo Kong 2025-02-07  7545  			if (ret)
1715fcabad1648 Lingbo Kong 2025-02-07  7546  				return ret;
1715fcabad1648 Lingbo Kong 2025-02-07  7547  
1715fcabad1648 Lingbo Kong 2025-02-07  7548  			parse->chain_rssi_done = true;
1715fcabad1648 Lingbo Kong 2025-02-07  7549  		}
79e7b04b5388c1 Lingbo Kong 2025-01-15 @7550  	default:
79e7b04b5388c1 Lingbo Kong 2025-01-15  7551  		break;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7552  	}
79e7b04b5388c1 Lingbo Kong 2025-01-15  7553  	return ret;
79e7b04b5388c1 Lingbo Kong 2025-01-15  7554  }
79e7b04b5388c1 Lingbo Kong 2025-01-15  7555  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

