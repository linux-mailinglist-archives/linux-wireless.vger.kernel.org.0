Return-Path: <linux-wireless+bounces-10316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E887E934342
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97626283590
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE571CD3D;
	Wed, 17 Jul 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHyk9xzi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77422611
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248653; cv=none; b=CCKZpP6g7+3mlfo5gv+Xk37BLqLzVC86IaN1roMU9bBTE6v/fDwCpH0VUSxWoR3PejQGEdAnRauV5uw0StpMGElzeR7N1zjpr6waPEUFxWzMrmNsotwONTH3msgTFqYfeSA5uKxyNU+JD/3ox14OMrrSB3DM3Ra1cIKBPZEWf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248653; c=relaxed/simple;
	bh=Axa3+fJrm+kDX4tcl99tyN59zaR0l/jTZrzGSuyHfak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnPp5Ov1tBAE13BT9Ge0w/P29r8NEU0NoYdUwupRxNJqDxE4SxsSnfefFOvn+2qWiYw+IUSjkefZUl2Gx1SqPUsBpzCK90F3Xv6KAJ2cW9tnW03RLEIlgHOksZuFo8aQBv725OOurKnsAlazPJi6rF7em0eF0lsDgC587K4U/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHyk9xzi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721248651; x=1752784651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Axa3+fJrm+kDX4tcl99tyN59zaR0l/jTZrzGSuyHfak=;
  b=ZHyk9xziWcETKvAtaq0hxPseDsMQrarh9wi7Klz3pfSJWB+QZ8D6snO/
   wXq5QkkG6Mn51fhjExVbbpwK262AqxbDu3dIajILjowkIUazXOaUnMsuL
   GgsO3SI6h+5XzLG5qIQDjeO46D5fv3OcUaGZun/vQdLjkhdAJc8xbty36
   IytQm9kTU4BByiVtpV0qDBQWi+dk3dPTewyjBDvnZlOVTcJX+rVF3VZ9s
   5gcPNy1O0T156rR0iwc6esngZ5ktFDOtr+ElIMddX2vMJC78uoXb3neop
   /O7sAmBSPJeC/ZirXckdApkvhG+u04Fm+kNu4sB8zJXUJCYs3PhgXJDd3
   A==;
X-CSE-ConnectionGUID: GVSLB7wbSr6MALgZ2zE8aA==
X-CSE-MsgGUID: FJJOK2WjSC6LL2mmqnSS7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="36222488"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="36222488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 13:37:30 -0700
X-CSE-ConnectionGUID: u1mitnfkSdqdT6Tgg6RIjw==
X-CSE-MsgGUID: 8ksHjwr5SGS+JnJiQ+l+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="50607096"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jul 2024 13:37:30 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUBOx-000gek-1n;
	Wed, 17 Jul 2024 20:37:27 +0000
Date: Thu, 18 Jul 2024 04:36:30 +0800
From: kernel test robot <lkp@intel.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	quic_lingbok@quicinc.com
Subject: Re: [PATCH 2/4] wifi: ath12k: Add Support for enabling or disabling
 specific features based on ACPI bitflag
Message-ID: <202407180403.SFqsPj0v-lkp@intel.com>
References: <20240717111023.78798-3-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717111023.78798-3-quic_lingbok@quicinc.com>

Hi Lingbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on db1ce56e6e1d395dd42a3cd6332a871d9be59c45]

url:    https://github.com/intel-lab-lkp/linux/commits/Lingbo-Kong/wifi-ath12k-Add-support-for-obtaining-the-buffer-type-ACPI-function-bitmap/20240717-211701
base:   db1ce56e6e1d395dd42a3cd6332a871d9be59c45
patch link:    https://lore.kernel.org/r/20240717111023.78798-3-quic_lingbok%40quicinc.com
patch subject: [PATCH 2/4] wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240718/202407180403.SFqsPj0v-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180403.SFqsPj0v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180403.SFqsPj0v-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/core.c: In function 'ath12k_core_rfkill_config':
>> drivers/net/wireless/ath/ath12k/core.c:33:15: error: 'struct ath12k_base' has no member named 'acpi'
      33 |         if (ab->acpi.acpi_disable_rfkill)
         |               ^~
--
   drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_mac_copy_eht_cap':
>> drivers/net/wireless/ath/ath12k/mac.c:5488:19: error: 'struct ath12k_base' has no member named 'acpi'
    5488 |             ar->ab->acpi.acpi_disable_11be)
         |                   ^~


vim +33 drivers/net/wireless/ath/ath12k/core.c

    24	
    25	static int ath12k_core_rfkill_config(struct ath12k_base *ab)
    26	{
    27		struct ath12k *ar;
    28		int ret = 0, i;
    29	
    30		if (!(ab->target_caps.sys_cap_info & WMI_SYS_CAP_INFO_RFKILL))
    31			return 0;
    32	
  > 33		if (ab->acpi.acpi_disable_rfkill)
    34			return 0;
    35	
    36		for (i = 0; i < ab->num_radios; i++) {
    37			ar = ab->pdevs[i].ar;
    38	
    39			ret = ath12k_mac_rfkill_config(ar);
    40			if (ret && ret != -EOPNOTSUPP) {
    41				ath12k_warn(ab, "failed to configure rfkill: %d", ret);
    42				return ret;
    43			}
    44		}
    45	
    46		return ret;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

