Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3590358B9AE
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Aug 2022 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiHGFW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Aug 2022 01:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHGFWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Aug 2022 01:22:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B0101E3
        for <linux-wireless@vger.kernel.org>; Sat,  6 Aug 2022 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659849744; x=1691385744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NmoKyIvwUQABe1qTHuc4SHoiTugC4Qo3OrTL1IR1NLY=;
  b=Rq1IXepb/4uwbDOz59EBgAEyO/DN93vnsO9PFe2D4g0LOwCvHqMbXg18
   QSvVHRcMFR86lghL6tNVIaiZCt/GwO9nZJEhK+Fpp9ZEGL4pj9xWPo5NF
   oU8AOOKFCzDQiz42NNwLSzQh6vAHF6/CkZpf0MQ21c3dBzMjUOVsq7QcV
   yop8L3jXi0xXZTS7ub9FrJJ6eUbD8QLy23ghNsOK0sXbb29AjnPmngeIY
   IP+CpXXMRn5qUKB7KSsaP2lJonyikLnDPm1uS1z9R/LjCnFEatuqtr/N7
   G9qXu61zg9Y/X2jPXgI80JrzS7tqnbxZqGIvsTigBbvbi43o7AG/VkRfV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="287975600"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="287975600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 22:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="604012787"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Aug 2022 22:22:22 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKYk1-000L0g-21;
        Sun, 07 Aug 2022 05:22:21 +0000
Date:   Sun, 7 Aug 2022 13:22:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sriram R <quic_srirrama@quicinc.com>, johannes@sipsolutions.net,
        nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v3] wifi: mac80211: Mesh Fast xmit support
Message-ID: <202208071332.oT3t8RiR-lkp@intel.com>
References: <20220806173805.32743-1-quic_srirrama@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806173805.32743-1-quic_srirrama@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sriram,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriram-R/wifi-mac80211-Mesh-Fast-xmit-support/20220807-014055
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: m68k-randconfig-s043-20220807 (https://download.01.org/0day-ci/archive/20220807/202208071332.oT3t8RiR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ba549e3891af7b7e0a64c522618035d995483d54
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sriram-R/wifi-mac80211-Mesh-Fast-xmit-support/20220807-014055
        git checkout ba549e3891af7b7e0a64c522618035d995483d54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/mac80211/tx.c:3614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sta_info *sta @@     got struct sta_info [noderef] __rcu *[noderef] __rcu next_hop @@
   net/mac80211/tx.c:3614:13: sparse:     expected struct sta_info *sta
   net/mac80211/tx.c:3614:13: sparse:     got struct sta_info [noderef] __rcu *[noderef] __rcu next_hop
>> net/mac80211/tx.c:3615:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ieee80211_key *key @@     got struct ieee80211_key [noderef] __rcu *key @@
   net/mac80211/tx.c:3615:13: sparse:     expected struct ieee80211_key *key
   net/mac80211/tx.c:3615:13: sparse:     got struct ieee80211_key [noderef] __rcu *key
   net/mac80211/tx.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h):
   arch/m68k/include/asm/bitops.h:491:27: sparse: sparse: not addressable
   arch/m68k/include/asm/bitops.h:491:27: sparse: sparse: not addressable

vim +3614 net/mac80211/tx.c

  3613	
> 3614		sta = entry->mpath->next_hop;
> 3615		key = entry->key;
  3616	
  3617		__skb_queue_head_init(&tx.skbs);
  3618	
  3619		tx.flags = IEEE80211_TX_UNICAST;
  3620		tx.local = local;
  3621		tx.sdata = sdata;
  3622		tx.sta = sta;
  3623		tx.key = key;
  3624		tx.skb = skb;
  3625	
  3626		ieee80211_xmit_fast_finish(sdata, sta, entry->pn_offs,
  3627					   key, &tx);
  3628	
  3629		__skb_queue_tail(&tx.skbs, skb);
  3630		ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
  3631		return true;
  3632	}
  3633	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
