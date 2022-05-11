Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA2523109
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiEKK4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiEKK4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 06:56:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03D737AAF
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652266605; x=1683802605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Px/eXidMBSJDu6Gc0Pt8/4rPl3QIvbZ1R7BGXYkwcBk=;
  b=XU7PA5zJodZbRVLWwj2fhE6fbygZFmFqwwo9nYAHpBu1mInrrhlEqpRV
   4x8C8jMpPWGkQFaBcjxUnWPUcengXj6pFnji1romFGClAeQXlwFGDeKhe
   vbvlJlF69Tk+2L3LDiGZtbhemqsbdrfpbWr4CZ583n+n+bm5Nuhw/Ob4p
   EWrt9fRFjH9H3NPrPcmJceflO0ct1oESXoAfIaF3UNlDzFAHw9zjbXAlr
   E/5cBcjUO52LyDC2TwccI+Br4hmCF2CaGbs9Wd91Aea0mhlLCUZyRSMpB
   0IMMAWDh7JWdGlI5Oi02SNwODmdEXQxDdsC+TD1a5QvNkS0DPiunsDN1r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269795866"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269795866"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="636368396"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2022 03:56:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nok1J-000J15-59;
        Wed, 11 May 2022 10:56:41 +0000
Date:   Wed, 11 May 2022 18:56:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:mld 9/9]
 drivers/net/wireless/rsi/rsi_91x_mac80211.c:581:36: warning: variable 'bss'
 set but not used
Message-ID: <202205111852.nKgYr0yT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   b57a04dfd045af22c8f59747e5ef4fa468d51b88
commit: b57a04dfd045af22c8f59747e5ef4fa468d51b88 [9/9] mac80211: move interface config to new struct
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220511/202205111852.nKgYr0yT-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=b57a04dfd045af22c8f59747e5ef4fa468d51b88
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next mld
        git checkout b57a04dfd045af22c8f59747e5ef4fa468d51b88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/ net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/rsi/rsi_91x_mac80211.c: In function 'rsi_channel_change':
>> drivers/net/wireless/rsi/rsi_91x_mac80211.c:581:36: warning: variable 'bss' set but not used [-Wunused-but-set-variable]
     581 |         struct ieee80211_bss_conf *bss;
         |                                    ^~~
   drivers/net/wireless/rsi/rsi_91x_mac80211.c: In function 'rsi_config_wowlan':
   drivers/net/wireless/rsi/rsi_91x_mac80211.c:1867:36: warning: variable 'bss' set but not used [-Wunused-but-set-variable]
    1867 |         struct ieee80211_bss_conf *bss = NULL;
         |                                    ^~~
--
   net/mac80211/main.c: In function 'ieee80211_ifa_changed':
>> net/mac80211/main.c:352:36: warning: variable 'bss_conf' set but not used [-Wunused-but-set-variable]
     352 |         struct ieee80211_bss_conf *bss_conf;
         |                                    ^~~~~~~~


vim +/bss +581 drivers/net/wireless/rsi/rsi_91x_mac80211.c

dad0d04fa7ba41 Fariya Fatima           2014-03-16  564  
dad0d04fa7ba41 Fariya Fatima           2014-03-16  565  /**
686a254177929c Jahnavi Meher           2014-06-16  566   * rsi_channel_change() - This function is a performs the checks
686a254177929c Jahnavi Meher           2014-06-16  567   *			  required for changing a channel and sets
686a254177929c Jahnavi Meher           2014-06-16  568   *			  the channel accordingly.
dad0d04fa7ba41 Fariya Fatima           2014-03-16  569   * @hw: Pointer to the ieee80211_hw structure.
dad0d04fa7ba41 Fariya Fatima           2014-03-16  570   *
dad0d04fa7ba41 Fariya Fatima           2014-03-16  571   * Return: 0 on success, negative error code on failure.
dad0d04fa7ba41 Fariya Fatima           2014-03-16  572   */
686a254177929c Jahnavi Meher           2014-06-16  573  static int rsi_channel_change(struct ieee80211_hw *hw)
dad0d04fa7ba41 Fariya Fatima           2014-03-16  574  {
dad0d04fa7ba41 Fariya Fatima           2014-03-16  575  	struct rsi_hw *adapter = hw->priv;
dad0d04fa7ba41 Fariya Fatima           2014-03-16  576  	struct rsi_common *common = adapter->priv;
dad0d04fa7ba41 Fariya Fatima           2014-03-16  577  	int status = -EOPNOTSUPP;
dad0d04fa7ba41 Fariya Fatima           2014-03-16  578  	struct ieee80211_channel *curchan = hw->conf.chandef.chan;
dad0d04fa7ba41 Fariya Fatima           2014-03-16  579  	u16 channel = curchan->hw_value;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  580  	struct ieee80211_vif *vif;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30 @581  	struct ieee80211_bss_conf *bss;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  582  	bool assoc = false;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  583  	int i;
dad0d04fa7ba41 Fariya Fatima           2014-03-16  584  
dad0d04fa7ba41 Fariya Fatima           2014-03-16  585  	rsi_dbg(INFO_ZONE,
dad0d04fa7ba41 Fariya Fatima           2014-03-16  586  		"%s: Set channel: %d MHz type: %d channel_no %d\n",
dad0d04fa7ba41 Fariya Fatima           2014-03-16  587  		__func__, curchan->center_freq,
dad0d04fa7ba41 Fariya Fatima           2014-03-16  588  		curchan->flags, channel);
686a254177929c Jahnavi Meher           2014-06-16  589  
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  590  	for (i = 0; i < RSI_MAX_VIFS; i++) {
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  591  		vif = adapter->vifs[i];
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  592  		if (!vif)
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  593  			continue;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  594  		if (vif->type == NL80211_IFTYPE_STATION) {
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  595  			bss = &vif->bss_conf;
b57a04dfd045af Johannes Berg           2022-05-10  596  			if (vif->cfg.assoc) {
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  597  				assoc = true;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  598  				break;
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  599  			}
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  600  		}
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  601  	}
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  602  	if (assoc) {
686a254177929c Jahnavi Meher           2014-06-16  603  		if (!common->hw_data_qs_blocked &&
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  604  		    (rsi_get_connected_channel(vif) != channel)) {
686a254177929c Jahnavi Meher           2014-06-16  605  			rsi_dbg(INFO_ZONE, "blk data q %d\n", channel);
686a254177929c Jahnavi Meher           2014-06-16  606  			if (!rsi_send_block_unblock_frame(common, true))
686a254177929c Jahnavi Meher           2014-06-16  607  				common->hw_data_qs_blocked = true;
686a254177929c Jahnavi Meher           2014-06-16  608  		}
686a254177929c Jahnavi Meher           2014-06-16  609  	}
686a254177929c Jahnavi Meher           2014-06-16  610  
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  611  	status = rsi_band_check(common, curchan);
686a254177929c Jahnavi Meher           2014-06-16  612  	if (!status)
61d1084214228b Prameela Rani Garnepudi 2016-11-18  613  		status = rsi_set_channel(adapter->priv, curchan);
686a254177929c Jahnavi Meher           2014-06-16  614  
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  615  	if (assoc) {
686a254177929c Jahnavi Meher           2014-06-16  616  		if (common->hw_data_qs_blocked &&
df771911914ab9 Prameela Rani Garnepudi 2017-08-30  617  		    (rsi_get_connected_channel(vif) == channel)) {
686a254177929c Jahnavi Meher           2014-06-16  618  			rsi_dbg(INFO_ZONE, "unblk data q %d\n", channel);
686a254177929c Jahnavi Meher           2014-06-16  619  			if (!rsi_send_block_unblock_frame(common, false))
686a254177929c Jahnavi Meher           2014-06-16  620  				common->hw_data_qs_blocked = false;
686a254177929c Jahnavi Meher           2014-06-16  621  		}
686a254177929c Jahnavi Meher           2014-06-16  622  	}
686a254177929c Jahnavi Meher           2014-06-16  623  
686a254177929c Jahnavi Meher           2014-06-16  624  	return status;
686a254177929c Jahnavi Meher           2014-06-16  625  }
686a254177929c Jahnavi Meher           2014-06-16  626  

:::::: The code at line 581 was first introduced by commit
:::::: df771911914ab9f80dd38a2710e50c5a418200ba rsi: add support for p2p listen

:::::: TO: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
