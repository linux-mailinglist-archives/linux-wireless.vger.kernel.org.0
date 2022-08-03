Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A758898B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Aug 2022 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiHCJlF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Aug 2022 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCJlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Aug 2022 05:41:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97517AE49
        for <linux-wireless@vger.kernel.org>; Wed,  3 Aug 2022 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659519661; x=1691055661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzLLu3BZddOgivh4lH2oi+f7xxH3lL7Xwl5FxNpQ6dg=;
  b=e+R+y4jeNB8x/hCuErrvo8kz19rlXLIxTSeGaUIsxkiKoCntilEOlgZF
   6gv6DAu3wCHSGpScoAvCR4SC0igOLE2bz3FIDbaUyPS5MLqLHR2lECqw9
   soQREgBOyvuBYIKTrmbUCj5rRmn3sTRpAouBadXeUFLCb1JAfnc2oCRtZ
   CDAS2ec/Uc7Cn3xjVOm698T1AMFSTuRoSJE2Xt0+EZc0JbV1zEAqxvjH5
   62HEOyudljB8c3vDlD6UyN0sFYvcia1LhDr1bqLCvvpLGl7HKMpijUsoJ
   UORZf5pBaqg3GYC6mbqQbzmphbcP37dnyBj4SEzP0ZBIwCKEOYLelbEOk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353633733"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="353633733"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="553260261"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 02:40:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJAs7-000H6R-0E;
        Wed, 03 Aug 2022 09:40:59 +0000
Date:   Wed, 3 Aug 2022 17:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sriram R <quic_srirrama@quicinc.com>, johannes@sipsolutions.net,
        nbd@nbd.name
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v2] mac80211: Mesh Fast xmit support
Message-ID: <202208031727.gD3OOS6X-lkp@intel.com>
References: <20220801070418.5420-1-quic_srirrama@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801070418.5420-1-quic_srirrama@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: microblaze-randconfig-s033-20220803 (https://download.01.org/0day-ci/archive/20220803/202208031727.gD3OOS6X-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/mac80211/mesh_pathtbl.c:464:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> net/mac80211/mesh_pathtbl.c:464:17: sparse:    struct mesh_path [noderef] __rcu *
>> net/mac80211/mesh_pathtbl.c:464:17: sparse:    struct mesh_path *
   net/mac80211/mesh_pathtbl.c:471:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/mac80211/mesh_pathtbl.c:471:18: sparse:    struct mesh_path [noderef] __rcu *
   net/mac80211/mesh_pathtbl.c:471:18: sparse:    struct mesh_path *
   net/mac80211/mesh_pathtbl.c:509:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> net/mac80211/mesh_pathtbl.c:509:25: sparse:    struct ieee80211_key [noderef] __rcu *
>> net/mac80211/mesh_pathtbl.c:509:25: sparse:    struct ieee80211_key *
   net/mac80211/mesh_pathtbl.c:656:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/mac80211/mesh_pathtbl.c:656:9: sparse:    struct mesh_path [noderef] __rcu *
   net/mac80211/mesh_pathtbl.c:656:9: sparse:    struct mesh_path *
   net/mac80211/mesh_pathtbl.c:657:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/mac80211/mesh_pathtbl.c:657:9: sparse:    struct mesh_path [noderef] __rcu *
   net/mac80211/mesh_pathtbl.c:657:9: sparse:    struct mesh_path *
   net/mac80211/mesh_pathtbl.c:658:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/mac80211/mesh_pathtbl.c:658:9: sparse:    struct ieee80211_key [noderef] __rcu *
   net/mac80211/mesh_pathtbl.c:658:9: sparse:    struct ieee80211_key *
   net/mac80211/mesh_pathtbl.c:757:31: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/mac80211/mesh_pathtbl.c:757:31: sparse:    struct mesh_path [noderef] __rcu *
   net/mac80211/mesh_pathtbl.c:757:31: sparse:    struct mesh_path *

vim +464 net/mac80211/mesh_pathtbl.c

   434	
   435	struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_data *sdata,
   436						      struct sk_buff *skb)
   437	{
   438		struct mesh_hdr_cache *cache;
   439		struct mhdr_cache_entry *entry;
   440		struct mesh_path *mpath, *mppath;
   441		struct ieee80211s_hdr *meshhdr;
   442		struct ieee80211_hdr *hdr;
   443		struct sta_info *new_nhop;
   444		struct ieee80211_key *key;
   445		struct ethhdr *eth;
   446		u8 sa[ETH_ALEN];
   447	
   448		u8 tid;
   449	
   450		cache = &sdata->u.mesh.hdr_cache;
   451	
   452		if (!cache->enabled)
   453			return NULL;
   454	
   455		entry = rhashtable_lookup(&cache->rhead, skb->data,
   456					  mesh_hdr_rht_params);
   457		if (!entry)
   458			return NULL;
   459	
   460		/* Avoid extra work in this path */
   461		if (skb_headroom(skb) < (entry->hdrlen - ETH_HLEN + 2))
   462			return NULL;
   463	
 > 464		mpath = rcu_dereference(entry->mpath);
   465		if (!mpath)
   466			return NULL;
   467	
   468		/* This check is with assumption that only 6addr frames are
   469		 * supported currently for caching
   470		 */
   471		mppath = rcu_dereference(entry->mppath);
   472		if (!mppath)
   473			return NULL;
   474	
   475		if (!(mpath->flags & MESH_PATH_ACTIVE))
   476			return NULL;
   477	
   478		if (mpath_expired(mpath))
   479			return NULL;
   480	
   481		/* If the skb is shared we need to obtain our own copy */
   482		if (skb_shared(skb)) {
   483			struct sk_buff *tmp_skb = skb;
   484	
   485			skb = skb_clone(skb, GFP_ATOMIC);
   486			kfree_skb(tmp_skb);
   487	
   488			if (!skb)
   489				return NULL;
   490		}
   491	
   492		/* In case there was a path refresh and update after we last used
   493		 * update the next hop addr.
   494		 */
   495		spin_lock_bh(&mpath->state_lock);
   496		if (entry->path_change_count != mpath->path_change_count) {
   497			new_nhop = rcu_dereference(mpath->next_hop);
   498			if (!new_nhop) {
   499				spin_unlock_bh(&mpath->state_lock);
   500				return NULL;
   501			}
   502			memcpy(&entry->hdr[4], new_nhop->sta.addr, ETH_ALEN);
   503	
   504			/* update key. pn_offs will be same */
   505			if (entry->key)	{
   506				key = rcu_access_pointer(new_nhop->ptk[new_nhop->ptk_idx]);
   507				if (!key)
   508					key = rcu_access_pointer(sdata->default_unicast_key);
 > 509				rcu_assign_pointer(entry->key, key);
   510			}
   511			entry->path_change_count = mpath->path_change_count;
   512		}
   513		spin_unlock_bh(&mpath->state_lock);
   514	
   515		/* backup eth SA to copy as eaddr2/SA in the mesh header */
   516		eth = (struct ethhdr *)skb->data;
   517		ether_addr_copy(sa, eth->h_source);
   518	
   519		/* Pull DA:SA */
   520		skb_pull(skb, ETH_ALEN * 2);
   521	
   522		memcpy(skb_push(skb, entry->hdrlen), entry->hdr, entry->hdrlen);
   523	
   524		meshhdr = (struct ieee80211s_hdr *)(skb->data + entry->machdr_len);
   525		hdr = (struct ieee80211_hdr *)skb->data;
   526	
   527		/* Update mutables */
   528		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
   529		*ieee80211_get_qos_ctl(hdr) = tid;
   530	
   531		put_unaligned(cpu_to_le32(sdata->u.mesh.mesh_seqnum), &meshhdr->seqnum);
   532		sdata->u.mesh.mesh_seqnum++;
   533	
   534		memcpy(meshhdr->eaddr2, sa, ETH_ALEN);
   535		meshhdr->ttl = sdata->u.mesh.mshcfg.dot11MeshTTL;
   536	
   537		if (mpath->flags & (MESH_PATH_REQ_QUEUED | MESH_PATH_FIXED))
   538			goto out;
   539	
   540		/* Refresh the path, in case there is a change in nexthop after refresh
   541		 * hdr will be updated on next lookup
   542		 */
   543		if (time_after(jiffies,
   544			       mpath->exp_time -
   545			       msecs_to_jiffies(sdata->u.mesh.mshcfg.path_refresh_time)) &&
   546		    !(mpath->flags & MESH_PATH_RESOLVING) &&
   547		    !(mpath->flags & MESH_PATH_FIXED)) {
   548			mesh_queue_preq(mpath, PREQ_Q_F_START | PREQ_Q_F_REFRESH);
   549		}
   550	
   551	out:
   552		mppath->exp_time = jiffies;
   553		entry->timestamp = jiffies;
   554	
   555		return entry;
   556	}
   557	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
