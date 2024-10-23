Return-Path: <linux-wireless+bounces-14377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF29AC9B1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5121F216CC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969E1ABEA1;
	Wed, 23 Oct 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4TrJn14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C51AB6F7;
	Wed, 23 Oct 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685395; cv=none; b=KDwOGiM8Ue86ybLRP5QvT5rAem9OjlLXbi4pjhzyPwBBkIUPZfNFNBWG5mG1kNofVvfHRgM4priBAHvYL4Urcn2kZdqE23ftR0QPMkob701ToBiyrWWAKGh2gQ11Q/Pie0iu5pStChQfkQRumG3L4/rT+gXlqLrdgn4vPkc041o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685395; c=relaxed/simple;
	bh=6kj6BGenSC46bCxZoBZ/KzUyflxUD6U1Ai0wmuCiTQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3JzaTJ55sC7miUGkXywTqJQpSypTHe/6NVw4gdWsg+LmHqZhNDukbLhewpT3AxuB0Y+nGCjzayuiG17d6Ib+8XIh8Mv1qzQ85R3QMdBOcVNN/0Zqdsp3StBmzf4dc+zZXLY6K3rPzhB4ZkrsGLSq9ol5ggNbRKEtT2QCVDEpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4TrJn14; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729685394; x=1761221394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kj6BGenSC46bCxZoBZ/KzUyflxUD6U1Ai0wmuCiTQ4=;
  b=T4TrJn14j/NecK89FiwQmLnlUxP9aLB+xhIuB7fsx57qk7jMFDSu570/
   /QbE08+bXeRGUtrzvW/i8R1xYM/S0xrkJGiTeJUipVoQFn8npnInUs36J
   0/jz30dpAfH+GrK7502b6OY+P/HGAQKhGeb/BkotQqwV1e4SCip3Jhx+N
   y8oOAvpJco4c1Zxv4gIg+ay+Phiq1EY8uW6KpZivgNKHfmGR5J85veFyS
   GrfQZr/IEqk9pKfPWbinbfV5djmYvdC2Iq6dm7czMqYrBrdNnakXuEWzv
   nr8BmIbzZYXGphbNQW0pagqkEgho1+hDcUJqpKcZ3pPlRgjLH6iClHMHR
   A==;
X-CSE-ConnectionGUID: 6nbVpNzXRFiTENyp7fV/bA==
X-CSE-MsgGUID: 86M5DqvOSpaSNE6qbrNKrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29376755"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29376755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:09:54 -0700
X-CSE-ConnectionGUID: OS2OaXAFR1OqMcN3P32kEg==
X-CSE-MsgGUID: 9oVqrhNlQq2/IC1iIecNEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="117651569"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Oct 2024 05:09:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3aBR-000Uso-0U;
	Wed, 23 Oct 2024 12:09:49 +0000
Date: Wed, 23 Oct 2024 20:09:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH 2/2] wifi: ath12k: annotate channel of struct
 ath12k_wmi_scan_chan_list_arg with __counted_by
Message-ID: <202410231916.Wjn5HeB6-lkp@intel.com>
References: <20241021143419.587716-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021143419.587716-2-dmantipov@yandex.ru>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on ath/ath-next]
[also build test ERROR on wireless-next/main wireless/main linus/master v6.12-rc4 next-20241022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Antipov/wifi-ath12k-annotate-channel-of-struct-ath12k_wmi_scan_chan_list_arg-with-__counted_by/20241021-223544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20241021143419.587716-2-dmantipov%40yandex.ru
patch subject: [PATCH 2/2] wifi: ath12k: annotate channel of struct ath12k_wmi_scan_chan_list_arg with __counted_by
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241023/202410231916.Wjn5HeB6-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410231916.Wjn5HeB6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410231916.Wjn5HeB6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/core.c:12:
   In file included from drivers/net/wireless/ath/ath12k/core.h:20:
>> drivers/net/wireless/ath/ath12k/wmi.h:3749:55: error: use of undeclared identifier 'nallchains'; did you mean 'nallchans'?
    3749 |         struct ath12k_wmi_channel_arg channel[] __counted_by(nallchains);
         |                                                              ^~~~~~~~~~
         |                                                              nallchans
   include/linux/compiler_attributes.h:105:62: note: expanded from macro '__counted_by'
     105 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
         |                                                                       ^
   drivers/net/wireless/ath/ath12k/wmi.h:3748:6: note: 'nallchans' declared here
    3748 |         u16 nallchans;
         |             ^
   1 error generated.


vim +3749 drivers/net/wireless/ath/ath12k/wmi.h

  3745	
  3746	struct ath12k_wmi_scan_chan_list_arg {
  3747		u32 pdev_id;
  3748		u16 nallchans;
> 3749		struct ath12k_wmi_channel_arg channel[] __counted_by(nallchains);
  3750	};
  3751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

