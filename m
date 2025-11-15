Return-Path: <linux-wireless+bounces-28992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA6C602CA
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF3DD3457C0
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E808283FCF;
	Sat, 15 Nov 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIIiBesh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002A2836A0;
	Sat, 15 Nov 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200311; cv=none; b=hV4hD3cVObF9fHx1uG0nILZPP8v/pcyKV4v3Vr51kFEZzFJK5Wl7pGfRjd8wWt1wp608O8cgKT0br19fFbXGC+OV5BNkPRWVl1DUUKAMOVshV68OFygRs0HNnobgg9ibGtupFpyJAxQUPHkFczF+Fi/9jkNfZxdjkezITz53cPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200311; c=relaxed/simple;
	bh=TNO/pWSCuytWRdiYa0o5CX+QYwHxTJhHAX8l7vDVP4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZKC6YTfFfQAFRIJW0ciXtNPH7AcjMzqWQc74mkcf050lY3qOots2tQ1emUIoj8ZHLqqnxYTjc3noEr4b5la/vw/BJgqxvBscTmR5PAcsdsvtoY7WwYOGFDMvGF2sBn2QY5nEXhtJ2rxl03qRJm/EvlAJV/FgDm8j7ISgPfqv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIIiBesh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763200310; x=1794736310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNO/pWSCuytWRdiYa0o5CX+QYwHxTJhHAX8l7vDVP4A=;
  b=MIIiBeshl+oLtYh4QW+c9+4Ekpop5dVsjoUVe5M67pMIdouRfcUUZfOF
   jCI7kPrYL/+PrrbBhKLMfw8Vep3Qn1yuvF2QDK63gvIKKga2iDtF2H9ut
   KF8boEaKU+Bwc+JfTarEyhKyf8QON92mfotA1XqV0scahHjH115Hkpu71
   qbo1QJnI0Nn/P132OlbkinHoS50j8E0j+Q+/zAnppxV8eypoorG+0m335
   djCwWzq/A9kqkS1JO4xA9DGj4ULTQ2N91R9+nWEG0Ym5daC6145JPaej3
   MEl24rZRepeavh447YdXmKcQpxKzLolWUNmDba1EE8RpAWzpQrFZ1ACrI
   Q==;
X-CSE-ConnectionGUID: FR6zKAWJRsm4cJQBw/QX0Q==
X-CSE-MsgGUID: 3sn0fuNXQ/m8ADX3NH9Y2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65375975"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="65375975"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 01:51:49 -0800
X-CSE-ConnectionGUID: uG+q97uVRgSsI6liqwQZeQ==
X-CSE-MsgGUID: YObL3VYdSOSw5BYe6PTfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="194443766"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Nov 2025 01:51:46 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKCwZ-0007rX-1a;
	Sat, 15 Nov 2025 09:51:43 +0000
Date: Sat, 15 Nov 2025 17:51:28 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	ath11k@lists.infradead.org, devicetree@vger.kernel.org,
	ath12k@lists.infradead.org,
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
Message-ID: <202511151754.ggEBSIV4-lkp@intel.com>
References: <20251114-ath-variant-tbl-v1-1-a9adfc49e3f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114-ath-variant-tbl-v1-1-a9adfc49e3f3@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/wifi-ath-Use-static-calibration-variant-table-for-devicetree-platforms/20251114-183506
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251114-ath-variant-tbl-v1-1-a9adfc49e3f3%40oss.qualcomm.com
patch subject: [PATCH 1/2] wifi: ath: Use static calibration variant table for devicetree platforms
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251115/202511151754.ggEBSIV4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511151754.ggEBSIV4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511151754.ggEBSIV4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath10k/core.h:26,
                    from drivers/net/wireless/ath/ath10k/core.c:21:
   In function 'ath_get_calib_variant',
       inlined from 'ath10k_core_check_dt' at drivers/net/wireless/ath/ath10k/core.c:1164:12:
>> drivers/net/wireless/ath/ath10k/../ath.h:431:36: warning: argument 2 null where non-null expected [-Wnonnull]
     431 |         while ((entry->machine) && strcmp(entry->machine, model))
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:11,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/wireless/ath/ath10k/core.c:11:
   include/linux/string.h: In function 'ath10k_core_check_dt':
   include/linux/string.h:161:12: note: in a call to function 'strcmp' declared 'nonnull'
     161 | extern int strcmp(const char *,const char *);
         |            ^~~~~~
--
   In file included from drivers/net/wireless/ath/ath11k/core.c:23:
   In function 'ath_get_calib_variant',
       inlined from 'ath11k_core_check_dt' at drivers/net/wireless/ath/ath11k/core.c:1367:12:
>> drivers/net/wireless/ath/ath11k/../ath.h:431:36: warning: argument 2 null where non-null expected [-Wnonnull]
     431 |         while ((entry->machine) && strcmp(entry->machine, model))
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/tsc.h:11,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/net/wireless/ath/ath11k/core.c:9:
   include/linux/string.h: In function 'ath11k_core_check_dt':
   include/linux/string.h:161:12: note: in a call to function 'strcmp' declared 'nonnull'
     161 | extern int strcmp(const char *,const char *);
         |            ^~~~~~


vim +431 drivers/net/wireless/ath/ath10k/../ath.h

   424	
   425	static inline const char *ath_get_calib_variant(void)
   426	{
   427		const struct __ath_calib_variant_table *entry = ath_calib_variant_table;
   428		struct device_node *root __free(device_node) = of_find_node_by_path("/");
   429		const char *model = of_get_property(root, "model", NULL);
   430	
 > 431		while ((entry->machine) && strcmp(entry->machine, model))
   432			entry++;
   433	
   434		return entry->machine ? entry->variant : NULL;
   435	}
   436	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

