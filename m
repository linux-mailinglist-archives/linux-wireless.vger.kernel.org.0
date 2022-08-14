Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D276259259F
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Aug 2022 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbiHNQyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbiHNQyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 12:54:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E759B7EEB
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660495394; x=1692031394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+7TbpUccmtGf87TUKnwvspCrFdqBC5ID4JDqF25I7vM=;
  b=QdjiSTE3oPiZwfbjPX/tLgUe8uvrz9DxIBsYy+xBN0/PxZYoe5ypldAl
   T/Yjo+cAo2FhQf2LDXkXJraURAQ5e79Woa4FYnJV5YLqfj7D2jH9oGv5i
   egkEP51nAA5I223zxuJcKMzBK+vMNJPibcP3kxsL+PaMe0wlxJuspmN0E
   dna2YHK6tGYj8bAenBby0SyjpnoS6n880R84Y7gmTIJLFK1n3I/hAx+P7
   Q5JrWUevJib03YT1kqYJ7CVUwdb3umt/Tl4a70yUtw4KeCX5OIgs666r3
   +3U2gE9ZADD2ERjIQuJrpR5lkNByumxg6QdJWMODnfm3l7KGUs2GE4Ckh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274893043"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274893043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 09:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="582625123"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 09:43:05 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNGhc-0000JZ-1q;
        Sun, 14 Aug 2022 16:43:04 +0000
Date:   Mon, 15 Aug 2022 00:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sriram R <quic_srirrama@quicinc.com>, johannes@sipsolutions.net,
        nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v2] mac80211: Mesh Fast xmit support
Message-ID: <202208150050.GNG5Kywi-lkp@intel.com>
References: <20220801070418.5420-1-quic_srirrama@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801070418.5420-1-quic_srirrama@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sriram,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 35610745d71df567297bb40c5e4263cda38dddd5]

url:    https://github.com/intel-lab-lkp/linux/commits/Sriram-R/mac80211-Mesh-Fast-xmit-support/20220801-150754
base:   35610745d71df567297bb40c5e4263cda38dddd5
config: ia64-randconfig-s053-20220801 (https://download.01.org/0day-ci/archive/20220815/202208150050.GNG5Kywi-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/0818e073d360fa23c2a1e61f49d67a7b3e99a4e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sriram-R/mac80211-Mesh-Fast-xmit-support/20220801-150754
        git checkout 0818e073d360fa23c2a1e61f49d67a7b3e99a4e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/mac80211/tx.c:3614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sta_info *sta @@     got struct sta_info [noderef] __rcu *next_hop @@
   net/mac80211/tx.c:3614:13: sparse:     expected struct sta_info *sta
   net/mac80211/tx.c:3614:13: sparse:     got struct sta_info [noderef] __rcu *next_hop

vim +3614 net/mac80211/tx.c

  3613	
> 3614		sta = entry->mpath->next_hop;
  3615		key = entry->key;
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
