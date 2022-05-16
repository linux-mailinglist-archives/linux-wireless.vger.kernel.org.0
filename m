Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F264B528D9A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiEPTBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiEPTBv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 15:01:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6819C28
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652727710; x=1684263710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2X+Df4hT2xGO64amHMxSb64hnVNhguvoISoNt2tSTU4=;
  b=hGZefdfWmJG13zKt5vYcsaatYJxQLIdu4ymCgehdEXUP/Hl+rriw1+S4
   HEPTfAy/PAC+LStSaRaE0Ry/8T9ApTGCQW3En5cidlYyyJQuMZAFD+po8
   pgMMZvbBtWe4zhPo2NMf9hMMh/8Q9VhFdnvzgMAMEPcHNfwnqA2+VqD9Z
   eHOiEi162/ABtjmZsqABgbeuYYUX5PQtVSzdzrwx28r+5o6bwssLV+10g
   4SArmhnEQREqOSmLst++1sF+1OhI0EMCZVlY+3OlhlrRdnG6YsXmhYLtS
   1xowxRRx3lBC+jtZ3Qt8Q+1RTjl+FLwv/XSeHBljX8iC/cAcW+jTl3Xfw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="333979141"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="333979141"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 12:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="626082084"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2022 12:01:47 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqfyU-0000Hb-Jt;
        Mon, 16 May 2022 19:01:46 +0000
Date:   Tue, 17 May 2022 03:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:mld 23/23] net/mac80211/tx.c:5367:38: warning:
 variable 'ifmgd' set but not used
Message-ID: <202205170246.inGN6Zt9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   d7de9813d17ee0522e30489f3228f2e3a456ff0a
commit: d7de9813d17ee0522e30489f3228f2e3a456ff0a [23/23] mac80211: reorg some iface data structs for MLD
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220517/202205170246.inGN6Zt9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=d7de9813d17ee0522e30489f3228f2e3a456ff0a
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next mld
        git checkout d7de9813d17ee0522e30489f3228f2e3a456ff0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/mac80211/tx.c: In function 'ieee80211_pspoll_get':
>> net/mac80211/tx.c:5367:38: warning: variable 'ifmgd' set but not used [-Wunused-but-set-variable]
    5367 |         struct ieee80211_if_managed *ifmgd;
         |                                      ^~~~~
   net/mac80211/tx.c: In function 'ieee80211_nullfunc_get':
   net/mac80211/tx.c:5406:38: warning: variable 'ifmgd' set but not used [-Wunused-but-set-variable]
    5406 |         struct ieee80211_if_managed *ifmgd;
         |                                      ^~~~~


vim +/ifmgd +5367 net/mac80211/tx.c

632189a0180fda Aloka Dixit   2020-09-11  5362  
7044cc565b45a8 Kalle Valo    2010-01-05  5363  struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
7044cc565b45a8 Kalle Valo    2010-01-05  5364  				     struct ieee80211_vif *vif)
7044cc565b45a8 Kalle Valo    2010-01-05  5365  {
7044cc565b45a8 Kalle Valo    2010-01-05  5366  	struct ieee80211_sub_if_data *sdata;
7044cc565b45a8 Kalle Valo    2010-01-05 @5367  	struct ieee80211_if_managed *ifmgd;
7044cc565b45a8 Kalle Valo    2010-01-05  5368  	struct ieee80211_pspoll *pspoll;
7044cc565b45a8 Kalle Valo    2010-01-05  5369  	struct ieee80211_local *local;
7044cc565b45a8 Kalle Valo    2010-01-05  5370  	struct sk_buff *skb;
7044cc565b45a8 Kalle Valo    2010-01-05  5371  
7044cc565b45a8 Kalle Valo    2010-01-05  5372  	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
7044cc565b45a8 Kalle Valo    2010-01-05  5373  		return NULL;
7044cc565b45a8 Kalle Valo    2010-01-05  5374  
7044cc565b45a8 Kalle Valo    2010-01-05  5375  	sdata = vif_to_sdata(vif);
7044cc565b45a8 Kalle Valo    2010-01-05  5376  	ifmgd = &sdata->u.mgd;
7044cc565b45a8 Kalle Valo    2010-01-05  5377  	local = sdata->local;
7044cc565b45a8 Kalle Valo    2010-01-05  5378  
7044cc565b45a8 Kalle Valo    2010-01-05  5379  	skb = dev_alloc_skb(local->hw.extra_tx_headroom + sizeof(*pspoll));
d15b84590a1d2e Joe Perches   2011-08-29  5380  	if (!skb)
7044cc565b45a8 Kalle Valo    2010-01-05  5381  		return NULL;
d15b84590a1d2e Joe Perches   2011-08-29  5382  
7044cc565b45a8 Kalle Valo    2010-01-05  5383  	skb_reserve(skb, local->hw.extra_tx_headroom);
7044cc565b45a8 Kalle Valo    2010-01-05  5384  
b080db585384b9 Johannes Berg 2017-06-16  5385  	pspoll = skb_put_zero(skb, sizeof(*pspoll));
7044cc565b45a8 Kalle Valo    2010-01-05  5386  	pspoll->frame_control = cpu_to_le16(IEEE80211_FTYPE_CTL |
7044cc565b45a8 Kalle Valo    2010-01-05  5387  					    IEEE80211_STYPE_PSPOLL);
cb8723de122ee2 Johannes Berg 2022-05-10  5388  	pspoll->aid = cpu_to_le16(sdata->vif.cfg.aid);
7044cc565b45a8 Kalle Valo    2010-01-05  5389  
7044cc565b45a8 Kalle Valo    2010-01-05  5390  	/* aid in PS-Poll has its two MSBs each set to 1 */
7044cc565b45a8 Kalle Valo    2010-01-05  5391  	pspoll->aid |= cpu_to_le16(1 << 15 | 1 << 14);
7044cc565b45a8 Kalle Valo    2010-01-05  5392  
d7de9813d17ee0 Johannes Berg 2022-05-16  5393  	memcpy(pspoll->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
7044cc565b45a8 Kalle Valo    2010-01-05  5394  	memcpy(pspoll->ta, vif->addr, ETH_ALEN);
7044cc565b45a8 Kalle Valo    2010-01-05  5395  
7044cc565b45a8 Kalle Valo    2010-01-05  5396  	return skb;
7044cc565b45a8 Kalle Valo    2010-01-05  5397  }
7044cc565b45a8 Kalle Valo    2010-01-05  5398  EXPORT_SYMBOL(ieee80211_pspoll_get);
7044cc565b45a8 Kalle Valo    2010-01-05  5399  

:::::: The code at line 5367 was first introduced by commit
:::::: 7044cc565b45a898c140fb185174a66f2d68a163 mac80211: add functions to create PS Poll and Nullfunc templates

:::::: TO: Kalle Valo <kalle.valo@nokia.com>
:::::: CC: John W. Linville <linville@tuxdriver.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
