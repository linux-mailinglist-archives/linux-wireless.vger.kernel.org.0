Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AF5B8EE3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiINS30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiINS3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 14:29:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9307F12F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663180164; x=1694716164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHJxKOnUXOjW53z6a9Bw9neqqOT6QXA+H/D4I7wrl3A=;
  b=B2UoOnS+jYasGZgo1fNwkx21Ya6bq4bwWrqyPaftrtQIH2Uj9hpns4dF
   lirMR2MXyZaHl4jKrrdkWdtsQC55fvg63jZF8WSsDFDm4GOCtGZw7OjfL
   tUudauAaDeetZR658jJEz0UUjv+qotiApsq1o7BMncFt752LI6y4q7+8x
   Kq9t97iGnOjPqY9xt9ysKnyFx59mZl3NYwsR1uHvwYLGOvUQK6PQpGLhU
   MjB86dImoVQ11EGv8kv4JrJGSdawK267IeGpykLkPaqk1JJsrz+LqyBVD
   UMjTm6IUOMCqML9WJsX/RXziQSOD7p+ensdkdfcYY5kbRqcK9XKp7jMbo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299869119"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299869119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 11:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="685410548"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2022 11:29:22 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYX8T-0000Tc-1h;
        Wed, 14 Sep 2022 18:29:21 +0000
Date:   Thu, 15 Sep 2022 02:29:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     venkatch@gmail.com, johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        victorg@ti.com, Venkat Chimata <venkata@shasta.cloud>
Subject: Re: [PATCH] wifi: mac80211: Fix performance issue with mutex_lock
Message-ID: <202209150235.Rz3KTMbf-lkp@intel.com>
References: <20220914110934.617430-1-venkatch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914110934.617430-1-venkatch@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/venkatch-gmail-com/wifi-mac80211-Fix-performance-issue-with-mutex_lock/20220914-191154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209150235.Rz3KTMbf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1d98b164c14462b445f932d0183b56ee716e1c41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review venkatch-gmail-com/wifi-mac80211-Fix-performance-issue-with-mutex_lock/20220914-191154
        git checkout 1d98b164c14462b445f932d0183b56ee716e1c41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/mac80211/cfg.c: In function 'ieee80211_dump_station':
>> net/mac80211/cfg.c:858:33: warning: unused variable 'local' [-Wunused-variable]
     858 |         struct ieee80211_local *local = sdata->local;
         |                                 ^~~~~


vim +/local +858 net/mac80211/cfg.c

6b62bf326393de Thomas Pedersen     2012-03-05  853  
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  854  static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  855  				  int idx, u8 *mac, struct station_info *sinfo)
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  856  {
3b53fde8ac40c4 Johannes Berg       2009-11-16  857  	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
66572cfc30a4b7 Victor Goldenshtein 2012-06-21 @858  	struct ieee80211_local *local = sdata->local;
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  859  	struct sta_info *sta;
d0709a65181beb Johannes Berg       2008-02-25  860  	int ret = -ENOENT;
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  861  
1d98b164c14462 Venkat Chimata      2022-09-14  862  	rcu_read_lock();
3b53fde8ac40c4 Johannes Berg       2009-11-16  863  	sta = sta_info_get_by_idx(sdata, idx);
d0709a65181beb Johannes Berg       2008-02-25  864  	if (sta) {
d0709a65181beb Johannes Berg       2008-02-25  865  		ret = 0;
17741cdc264e4d Johannes Berg       2008-09-11  866  		memcpy(mac, sta->sta.addr, ETH_ALEN);
0fdf1493b41eb6 Johannes Berg       2018-05-18  867  		sta_set_sinfo(sta, sinfo, true);
d0709a65181beb Johannes Berg       2008-02-25  868  	}
1d98b164c14462 Venkat Chimata      2022-09-14  869  	rcu_read_unlock();
d0709a65181beb Johannes Berg       2008-02-25  870  
d0709a65181beb Johannes Berg       2008-02-25  871  	return ret;
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  872  }
c5dd9c2bd0b242 Luis Carlos Cobo    2008-02-23  873  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
