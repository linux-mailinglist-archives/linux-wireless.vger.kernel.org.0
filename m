Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B153D64C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jun 2022 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiFDJtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jun 2022 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiFDJto (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jun 2022 05:49:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CEA1208F
        for <linux-wireless@vger.kernel.org>; Sat,  4 Jun 2022 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654336183; x=1685872183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V8AhQRyZO8uEH3sL7tBEK3WDhOVfolgh+pAOZ7lV4xY=;
  b=nJNtv/l7hk6JVrmPZppYfvypMe0Cr/7SCCEoNw3ZERuTIErVU6QNjSOU
   WcrlL5sjG/RFAf0OABixtG1FsCwoQ/VumUQ75tbaIubq9KqwIlEpPsT21
   ypiPlwh7RgNIHWy1Jynq8SdG6uvnXcAigDyaqbnrxjqEOXZxccaQ+SLHT
   2B8TEfRYkYqJwuO2oEJ3fdjT1myhQQTxEu3B90hV6p1yGk+3ol5SLdhlO
   DSeihPbWCY+lKXpwKBUH0M6dfHSrHkC/cLfDSIkMi6G2ytgRYQZx7QA0E
   YBNl3SaQq/10r1/5KQP+tFhkzjZQUyJZVlaIN5lGJKAF6S85fmYLErEwI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="264094978"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="264094978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 02:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="708381288"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2022 02:49:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxQPQ-000Ac5-Gf;
        Sat, 04 Jun 2022 09:49:28 +0000
Date:   Sat, 4 Jun 2022 17:49:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     quic_haric@quicinc.com, johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: Re: [PATCH] mac80211 : Add support to track mesh peer beacon miss
 event
Message-ID: <202206041752.4zr7FmwF-lkp@intel.com>
References: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.18]
[cannot apply to wireless-next/main wireless/main next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/quic_haric-quicinc-com/mac80211-Add-support-to-track-mesh-peer-beacon-miss-event/20220530-145016
base:    4b0986a3613c92f4ec1bdc7f60ec66fea135991f
config: h8300-randconfig-s031-20220603 (https://download.01.org/0day-ci/archive/20220604/202206041752.4zr7FmwF-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e7cd136811bad4e11720ee71054c97d225848dd4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review quic_haric-quicinc-com/mac80211-Add-support-to-track-mesh-peer-beacon-miss-event/20220530-145016
        git checkout e7cd136811bad4e11720ee71054c97d225848dd4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/mac80211/mesh_plink.c:626:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] beacon_int @@     got restricted __le16 [usertype] beacon_int @@
   net/mac80211/mesh_plink.c:626:31: sparse:     expected unsigned int [usertype] beacon_int
   net/mac80211/mesh_plink.c:626:31: sparse:     got restricted __le16 [usertype] beacon_int

vim +626 net/mac80211/mesh_plink.c

   595	
   596	/*
   597	 * mesh_bmiss_update - update beacon miss parameters such as
   598	 * beacon count, beacon interval and timeout of beacon miss
   599	 * timer
   600	 *
   601	 * @sdata: local meshif
   602	 * @mgmt: mgmt frame info
   603	 * @elems: IEs from beacon or mesh peering frame.
   604	 * @rx_status: rx status for the frame for signal reporting
   605	 *
   606	 */
   607	
   608	void mesh_bmiss_update(struct ieee80211_sub_if_data *sdata,
   609			       struct ieee80211_mgmt *mgmt,
   610			       struct ieee802_11_elems *elems,
   611			       struct ieee80211_rx_status *rx_status)
   612	{
   613		struct sta_info *sta;
   614		u32 timeout;
   615	
   616		/* mesh_sta_info_get api returns with rcu_read_lock */
   617		sta = mesh_sta_info_get(sdata, mgmt->sa, elems, rx_status);
   618		if (!sta)
   619			goto unlock_rcu;
   620	
   621		if (!(sta->local->hw.dbg_mask & IEEE80211_HW_DBG_BMISS_LOG) ||
   622		    !sta->sdata->vif.bmiss_threshold)
   623			goto unlock_rcu;
   624	
   625		sta->mesh->bmiss_count = 0;
 > 626		sta->mesh->beacon_int = mgmt->u.beacon.beacon_int;
   627		timeout = sta->mesh->beacon_int * sta->sdata->vif.bmiss_threshold;
   628	
   629		mod_timer(&sta->mesh->bmiss_timer, (jiffies + msecs_to_jiffies(timeout)));
   630	
   631	unlock_rcu:
   632		rcu_read_unlock();
   633	}
   634	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
