Return-Path: <linux-wireless+bounces-19781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD06A4F17C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C683A4E14
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA027934D;
	Tue,  4 Mar 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT6dp6B3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81B18FDA5
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130967; cv=none; b=BtfjlbT/zqHmxsqukPaJcgW913XHwNF1iisF5glwVLoMZlqtQx6ES04arZhIz3luqoL+9tZOWghAN8zmMkJY9kKvI337pP6vWnoA9yFeqV9WKyt3DVEq2OMGqSeTJGLOFv740OaMD+mJ/Qz2+DCSCWN1omKUw5D303uCwc07e0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130967; c=relaxed/simple;
	bh=+xcGyemarhaFJEi5a+n/1qESofQ5YN6k0bSGIgrVLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FiMMfOAfWE7PmJMziVBmGdXECVEdhYeUeQ2Quyjco95Q3SkiHxqK2pIAwJIhZmGI9wlB1SbvYJH7AAKXJaTRVeQBawgoBE6kuJe2KAhJf8QIyn/jcBbDGqpgiZMvJk5I84yiQ8n1anIVpxop5KJJRViNTA5eo/xGzvlLZUE35pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT6dp6B3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741130965; x=1772666965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+xcGyemarhaFJEi5a+n/1qESofQ5YN6k0bSGIgrVLhU=;
  b=HT6dp6B31gpfjw5huN1yHcsTWanePjH/quD2cGskwbALmQZXd7mo3We9
   fAkU5hds/vcOtGdcgrf0ZmvGOBTbToHAcqFgTJG9OS/f6hz8MIpiE6tVr
   6FGHUUQP1b83fv0d1B+pZr2rjjrfEdXbwMO60K/I7o853EfyoO1WHrL1W
   QBpSTv1cKdxjCL1Z6tS/XkNzDYR5MDJdn4G8bc1za1Am4pRNc/XGXGCkp
   JdAAuWKSUYW+OLy8mcU9Dipv9u2689OPrYKtjU0KCJHZm5fH3A0guy2Pw
   r5x1o+hF/99Zw8dB39YQ6+0smOzr5tgOvUB/Vo8QqiZJd8T/g9/BRsbGR
   Q==;
X-CSE-ConnectionGUID: VQBzCXa5SAOHe3xaDTPoiA==
X-CSE-MsgGUID: 3my+cDxvRXy/O/y74MhaYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53062483"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53062483"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 15:29:24 -0800
X-CSE-ConnectionGUID: oSZlTaZlTWuAAX35ywJnfA==
X-CSE-MsgGUID: BF4T24SQT/ypXFEknpJA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="119006440"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Mar 2025 15:29:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpbhP-000KMm-1Q;
	Tue, 04 Mar 2025 23:29:19 +0000
Date: Wed, 5 Mar 2025 07:28:23 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [wireless-next:iwlmld 75/75]
 drivers/net/wireless/intel/iwlwifi/mld/stats.c: mlo.h is included more than
 once.
Message-ID: <202503050720.J3sVu7Vc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git iwlmld
head:   6bfe801dadbb60d187dd0de6dc7da2c39db4f272
commit: 6bfe801dadbb60d187dd0de6dc7da2c39db4f272 [75/75] wifi: iwlwifi: add iwlmld sub-driver
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503050720.J3sVu7Vc-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/wireless/intel/iwlwifi/mld/stats.c: mlo.h is included more than once.
--
>> drivers/net/wireless/intel/iwlwifi/mld/mld.h: net/mac80211.h is included more than once.
--
>> drivers/net/wireless/intel/iwlwifi/mld/mac80211.c: iface.h is included more than once.

vim +9 drivers/net/wireless/intel/iwlwifi/mld/stats.c

   > 9	#include "mlo.h"
    10	#include "hcmd.h"
    11	#include "iface.h"
  > 12	#include "mlo.h"
    13	#include "scan.h"
    14	#include "phy.h"
    15	#include "fw/api/stats.h"
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

