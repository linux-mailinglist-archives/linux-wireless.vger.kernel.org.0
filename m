Return-Path: <linux-wireless+bounces-12620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3019700A5
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF99328467B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E11494AF;
	Sat,  7 Sep 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzfCHF1S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF013C81B;
	Sat,  7 Sep 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725695337; cv=none; b=SkCXEVw2o7vbDLpkqtV2l8pnDvvXFwfrgOiDgiKpnY3HTtjzR/W6TGRmGGrbisRTDU1G2cCwRYgT6MgIgwY/48O+HzZh2hQ01+BWwwpuiZDhspdS505RY1BsX1RkNoVrk5vfIRFNQ5uuSY51S/rfhB3uk/GGY7zpTh63LAL8qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725695337; c=relaxed/simple;
	bh=3FnuhTd4tctA2VAFnygx80jYcOLe/RkLw+DxvUF3sig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF3vk8tEpyZ255UNfrFqOAUN+k9R/T9InxQ9SVsVekPFe1wEFUruBGXDubSECVN4p3/S5j4GIbz31JNuJu6mc23h1E/593ZFefxhxAVMJwHN2ZUG6d6PSDko9sgM9dFmGH8uWV6pxoqEGEI2IAqNhGqTp8nJN8fkgsp3V1HZIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzfCHF1S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725695335; x=1757231335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3FnuhTd4tctA2VAFnygx80jYcOLe/RkLw+DxvUF3sig=;
  b=SzfCHF1SveKTTYTV6IZN4NMTRuIxs1dRFtHr2vozRydyqJ50SRt1rj0S
   VusaIhJ/dl9kARG5t8ooPrpVOcpdIlVE79HplHr5r5bVvnCcJAYdz8+3i
   QY74nxk5NVuAjNQprE103bYNnMaqwaL9DEBM2/ZLzhXPW4QOmFZZK5cXt
   KlQR91qcD8scmFmwPoM4JNk6TCdEg87PPeeMUXM8W3Ez2b66JCwF+Gob5
   U/qJHToLjRrRWQl8y3kTmVDFVIc7aPUnuDSimA5oFIPfgzVgfMCjZN/qA
   977bZYF1dfjO8F0wJHzjIexc9KT0alCRvN7kIp8FDq2fLbqaGKZYO9qSp
   Q==;
X-CSE-ConnectionGUID: 3Ug7rSFgQVWmnnkmGbVVhQ==
X-CSE-MsgGUID: 8hu+HVRZTxW3RkVtSqFwag==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030415"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="35030415"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 00:48:55 -0700
X-CSE-ConnectionGUID: xN4Q0pCiSOq9ZCtaxa4LbA==
X-CSE-MsgGUID: XWC9soK2TXajDjbAtHM8Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="89442270"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Sep 2024 00:48:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smqBe-000CIf-17;
	Sat, 07 Sep 2024 07:48:50 +0000
Date: Sat, 7 Sep 2024 15:47:58 +0800
From: kernel test robot <lkp@intel.com>
To: Rohit Chavan <roheetchavan@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Rohit Chavan <roheetchavan@gmail.com>
Subject: Re: [PATCH] lib80211: Use ERR_CAST() to return
Message-ID: <202409071509.vfmUeHx0-lkp@intel.com>
References: <20240906114455.730559-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906114455.730559-1-roheetchavan@gmail.com>

Hi Rohit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Chavan/lib80211-Use-ERR_CAST-to-return/20240906-194721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240906114455.730559-1-roheetchavan%40gmail.com
patch subject: [PATCH] lib80211: Use ERR_CAST() to return
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240907/202409071509.vfmUeHx0-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071509.vfmUeHx0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071509.vfmUeHx0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/wireless/lib80211.c: In function 'lib80211_crypt_null_init':
>> net/wireless/lib80211.c:230:25: warning: passing argument 1 of 'ERR_CAST' makes pointer from integer without a cast [-Wint-conversion]
     230 |         return ERR_CAST(1);
         |                         ^
         |                         |
         |                         int
   In file included from include/linux/string.h:10,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from net/wireless/lib80211.c:19:
   include/linux/err.h:82:64: note: expected 'const void *' but argument is of type 'int'
      82 | static inline void * __must_check ERR_CAST(__force const void *ptr)
         |                                                    ~~~~~~~~~~~~^~~


vim +/ERR_CAST +230 net/wireless/lib80211.c

   227	
   228	static void *lib80211_crypt_null_init(int keyidx)
   229	{
 > 230		return ERR_CAST(1);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

