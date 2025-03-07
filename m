Return-Path: <linux-wireless+bounces-20017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC0A57309
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 21:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA764173E9D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434621D932F;
	Fri,  7 Mar 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXD7TEUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DD19DF53
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380333; cv=none; b=cTWP7MdsAh/UeAKV4ncN7KIjKOOtd7bxnjP9uV1zwyi+KceCBOZU+OhLiSjhwEhWwojZ7RXGJTjpJ/aNxmSoX98eNVilRu5wnbI/83tp6dP+a/u+TvBc1Lof8Z6krnPpKaWwHQdETgSckW9fZivbt1+2xaVXeh6G0tXvMPtBXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380333; c=relaxed/simple;
	bh=OnF+c6iKgvROwnmlkSqLY//ObvyD+gGbs+74/GiIpgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTctpcO9sCg4tEDPSA34/q0/U2Pm4ueEr2fBnH4qWwR1GU8p3sCQsPFVQDyge00kBaagEyTA9ugXyogcM7ElDXoOzzPLA4aYgzVZdXq/wKEJGbTpa1Rel0+u9yYYQo6W3URWDtFZacrjfoHuXSTUSrSeDjVEo88cPU7pZVaL170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXD7TEUl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741380331; x=1772916331;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OnF+c6iKgvROwnmlkSqLY//ObvyD+gGbs+74/GiIpgE=;
  b=LXD7TEUlkiaCuBUwDX4ajsKUt9xWy9UmxdJDGni2vXMSUQc7Tx6y+cMz
   N63I2w7c1FSmZx1UcRCcOa+aYhwWKio7954jrXKYYBUT8WWyQFAq2fGx7
   FHsCUFnRr/KCdQAml5Odro399ACzqQN925rgWUjNPRzqZbTdCAx7Zf9/o
   A0M7TnftSRGvC7sQdXSB3pNV/e9l8XspoTYGhHlTuoRr0WTqpfxt3XCii
   T5DNTxz4Dsh7JFM80iXmpbOCZOvGiiIzzxzKCZU6mSDDS+6S685QsBuRu
   8iawJjIkap+U+i7ijKXbWdtnoXI0XtZC2uRlzVI1MYJbw362MhSt1CKSr
   w==;
X-CSE-ConnectionGUID: acoM+ZoJQZOe9fx2G7Bc0w==
X-CSE-MsgGUID: LOhdi4AwSc2arUmFTWFIxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="41696545"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="41696545"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:45:31 -0800
X-CSE-ConnectionGUID: wswzeBE2STSS0MPxzunhWA==
X-CSE-MsgGUID: l/YLXj/3Qk6qkzSzyNknPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119912389"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2025 12:45:27 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqeZR-00012D-2D;
	Fri, 07 Mar 2025 20:45:25 +0000
Date: Sat, 8 Mar 2025 04:45:14 +0800
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
Subject: [wireless-next:main 1/8]
 drivers/net/wireless/intel/iwlwifi/mld/mld.h:299:23: error: 'struct
 <anonymous>' has no member named 'in_d3'
Message-ID: <202503080456.h4DC9aDg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   fc56639937ce95a73c9876e39f8d18d1a8dd6a95
commit: d1e879ec600f9b3bdd253167533959facfefb17b [1/8] wifi: iwlwifi: add iwlmld sub-driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20250308/202503080456.h4DC9aDg-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503080456.h4DC9aDg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503080456.h4DC9aDg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mld/mld.c:16:
   drivers/net/wireless/intel/iwlwifi/mld/mld.h: In function 'iwl_cleanup_mld':
>> drivers/net/wireless/intel/iwlwifi/mld/mld.h:299:23: error: 'struct <anonymous>' has no member named 'in_d3'
     299 |         mld->fw_status.in_d3 = false;
         |                       ^
   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/net/mac80211.h:16,
                    from drivers/net/wireless/intel/iwlwifi/mld/mld.c:6:
   drivers/net/wireless/intel/iwlwifi/mld/hcmd.h: In function 'iwl_mld_send_cmd':
>> drivers/net/wireless/intel/iwlwifi/mld/hcmd.h:13:35: error: 'struct <anonymous>' has no member named 'in_d3'
      13 |         if (WARN_ON(mld->fw_status.in_d3))
         |                                   ^
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mlo.h:13,
                    from drivers/net/wireless/intel/iwlwifi/mld/mld.c:17:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h: At top level:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h:170:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
     170 | #if CONFIG_PM_SLEEP
         |     ^~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:9:
   drivers/net/wireless/intel/iwlwifi/mld/mld.h: In function 'iwl_cleanup_mld':
>> drivers/net/wireless/intel/iwlwifi/mld/mld.h:299:23: error: 'struct <anonymous>' has no member named 'in_d3'
     299 |         mld->fw_status.in_d3 = false;
         |                       ^
   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/net/mac80211.h:16,
                    from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:6:
   drivers/net/wireless/intel/iwlwifi/mld/hcmd.h: In function 'iwl_mld_send_cmd':
>> drivers/net/wireless/intel/iwlwifi/mld/hcmd.h:13:35: error: 'struct <anonymous>' has no member named 'in_d3'
      13 |         if (WARN_ON(mld->fw_status.in_d3))
         |                                   ^
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:12:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h: At top level:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h:170:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
     170 | #if CONFIG_PM_SLEEP
         |     ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1978:12: warning: 'iwl_mld_resume' defined but not used [-Wunused-function]
    1978 | static int iwl_mld_resume(struct ieee80211_hw *hw)
         |            ^~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1956:1: warning: 'iwl_mld_suspend' defined but not used [-Wunused-function]
    1956 | iwl_mld_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
         | ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1942:13: warning: 'iwl_mld_set_wakeup' defined but not used [-Wunused-function]
    1942 | static void iwl_mld_set_wakeup(struct ieee80211_hw *hw, bool enabled)
         |             ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/intel/iwlwifi/mld/fw.c:6:
   drivers/net/wireless/intel/iwlwifi/mld/mld.h: In function 'iwl_cleanup_mld':
>> drivers/net/wireless/intel/iwlwifi/mld/mld.h:299:23: error: 'struct <anonymous>' has no member named 'in_d3'
     299 |         mld->fw_status.in_d3 = false;
         |                       ^
   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/leds.h:12,
                    from drivers/net/wireless/intel/iwlwifi/mld/mld.h:8:
   drivers/net/wireless/intel/iwlwifi/mld/hcmd.h: In function 'iwl_mld_send_cmd':
>> drivers/net/wireless/intel/iwlwifi/mld/hcmd.h:13:35: error: 'struct <anonymous>' has no member named 'in_d3'
      13 |         if (WARN_ON(mld->fw_status.in_d3))
         |                                   ^
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~


vim +299 drivers/net/wireless/intel/iwlwifi/mld/mld.h

   286	
   287	/* memset the part of the struct that requires cleanup on restart */
   288	#define CLEANUP_STRUCT(_ptr)                             \
   289		memset((void *)&(_ptr)->zeroed_on_hw_restart, 0, \
   290		       sizeof((_ptr)->zeroed_on_hw_restart))
   291	
   292	/* Cleanup function for struct iwl_mld_vif, will be called in restart */
   293	static inline void
   294	iwl_cleanup_mld(struct iwl_mld *mld)
   295	{
   296		CLEANUP_STRUCT(mld);
   297		CLEANUP_STRUCT(&mld->scan);
   298	
 > 299		mld->fw_status.in_d3 = false;
   300	
   301		iwl_mld_low_latency_restart_cleanup(mld);
   302	
   303		/* Empty the list of async notification handlers so we won't process
   304		 * notifications from the dead fw after the reconfig flow.
   305		 */
   306		iwl_mld_purge_async_handlers_list(mld);
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

