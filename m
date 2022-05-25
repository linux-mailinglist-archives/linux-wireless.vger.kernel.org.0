Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA51533B12
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 12:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiEYK54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiEYK5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 06:57:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2488611C04
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653476273; x=1685012273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73ip+Lkv8cQZwWrziIvuc6CWNzBwDKp3sidzUO8t+1c=;
  b=ClPX1KTSw+PV6vlRibE0DZuzlI8cCQhDQeGtyHSlSo93vevtPn5Jreyv
   KxipSmqNlNY1uexM7GCeZ5RBPNvvIOX24iRwypWb7IhD8I9/I0lmw+OqH
   Gjp2viIvOY2bVr533DtaxA+I0E12DG6mo+/Ex+ZX19TDxUS7OnOsqC+rq
   DLNGodJzLxtlUgh1edxNi3JWJoF+qcExZxZf7sQdMFAv1sGEWpu2+rgEK
   AphIUfFA7860tn4/HiL0idR28fn7QBTgtqVZFYmtQ5qUBg+ct0kPkXn9u
   ONvEAIKgfEPqcnsIGaTTOE052dYPusSDyZldIi/Tic0JLr9au3v1tCz+Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273510345"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273510345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 03:57:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="703950802"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2022 03:57:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntoi6-0002xS-QC;
        Wed, 25 May 2022 10:57:50 +0000
Date:   Wed, 25 May 2022 18:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     quic_haric@quicinc.com, johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: Re: [PATCH] mac80211 : Add support to track mesh peer beacon miss
 event
Message-ID: <202205251825.nBaXpJoJ-lkp@intel.com>
References: <1653458490-6061-1-git-send-email-quic_haric@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653458490-6061-1-git-send-email-quic_haric@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wireless/main]
[also build test ERROR on v5.18]
[cannot apply to wireless-next/main next-20220525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/quic_haric-quicinc-com/mac80211-Add-support-to-track-mesh-peer-beacon-miss-event/20220525-140309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: microblaze-randconfig-r035-20220524 (https://download.01.org/0day-ci/archive/20220525/202205251825.nBaXpJoJ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/630032eda5f6d000586a70d32fdf32db9a68437f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review quic_haric-quicinc-com/mac80211-Add-support-to-track-mesh-peer-beacon-miss-event/20220525-140309
        git checkout 630032eda5f6d000586a70d32fdf32db9a68437f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/mac80211/mesh.c: In function 'ieee80211_mesh_rx_bcn_presp':
>> net/mac80211/mesh.c:1366:56: error: passing argument 3 of 'mesh_bmiss_update' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1366 |                         mesh_bmiss_update(sdata, mgmt, &elems, rx_status);
         |                                                        ^~~~~~
         |                                                        |
         |                                                        struct ieee802_11_elems **
   In file included from net/mac80211/mesh.c:12:
   net/mac80211/mesh.h:267:78: note: expected 'struct ieee802_11_elems *' but argument is of type 'struct ieee802_11_elems **'
     267 |                        struct ieee80211_mgmt *mgmt, struct ieee802_11_elems *ie,
         |                                                     ~~~~~~~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +/mesh_bmiss_update +1366 net/mac80211/mesh.c

  1306	
  1307	static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
  1308						u16 stype,
  1309						struct ieee80211_mgmt *mgmt,
  1310						size_t len,
  1311						struct ieee80211_rx_status *rx_status)
  1312	{
  1313		struct ieee80211_local *local = sdata->local;
  1314		struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
  1315		struct ieee802_11_elems *elems;
  1316		struct ieee80211_channel *channel;
  1317		size_t baselen;
  1318		int freq;
  1319		enum nl80211_band band = rx_status->band;
  1320	
  1321		/* ignore ProbeResp to foreign address */
  1322		if (stype == IEEE80211_STYPE_PROBE_RESP &&
  1323		    !ether_addr_equal(mgmt->da, sdata->vif.addr))
  1324			return;
  1325	
  1326		baselen = (u8 *) mgmt->u.probe_resp.variable - (u8 *) mgmt;
  1327		if (baselen > len)
  1328			return;
  1329	
  1330		elems = ieee802_11_parse_elems(mgmt->u.probe_resp.variable,
  1331					       len - baselen,
  1332					       false, mgmt->bssid, NULL);
  1333		if (!elems)
  1334			return;
  1335	
  1336		/* ignore non-mesh or secure / unsecure mismatch */
  1337		if ((!elems->mesh_id || !elems->mesh_config) ||
  1338		    (elems->rsn && sdata->u.mesh.security == IEEE80211_MESH_SEC_NONE) ||
  1339		    (!elems->rsn && sdata->u.mesh.security != IEEE80211_MESH_SEC_NONE))
  1340			goto free;
  1341	
  1342		if (elems->ds_params)
  1343			freq = ieee80211_channel_to_frequency(elems->ds_params[0], band);
  1344		else
  1345			freq = rx_status->freq;
  1346	
  1347		channel = ieee80211_get_channel(local->hw.wiphy, freq);
  1348	
  1349		if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
  1350			goto free;
  1351	
  1352		if (mesh_matches_local(sdata, elems)) {
  1353			mpl_dbg(sdata, "rssi_threshold=%d,rx_status->signal=%d\n",
  1354				sdata->u.mesh.mshcfg.rssi_threshold, rx_status->signal);
  1355			if (!sdata->u.mesh.user_mpm ||
  1356			    sdata->u.mesh.mshcfg.rssi_threshold == 0 ||
  1357			    sdata->u.mesh.mshcfg.rssi_threshold < rx_status->signal)
  1358				mesh_neighbour_update(sdata, mgmt->sa, elems,
  1359						      rx_status);
  1360	
  1361			if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
  1362			    !sdata->vif.csa_active)
  1363				ieee80211_mesh_process_chnswitch(sdata, elems, true);
  1364	
  1365			if (stype != IEEE80211_STYPE_PROBE_RESP)
> 1366				mesh_bmiss_update(sdata, mgmt, &elems, rx_status);
  1367		}
  1368	
  1369		if (ifmsh->sync_ops)
  1370			ifmsh->sync_ops->rx_bcn_presp(sdata, stype, mgmt, len,
  1371						      elems->mesh_config, rx_status);
  1372	free:
  1373		kfree(elems);
  1374	}
  1375	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
