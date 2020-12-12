Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DE2D8614
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 11:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438797AbgLLKye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Dec 2020 05:54:34 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:56838 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLLKyS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Dec 2020 05:54:18 -0500
Received: from [192.168.178.34] (unknown [87.147.53.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 25FE058007B;
        Sat, 12 Dec 2020 11:53:27 +0100 (CET)
Subject: Re: [kbuild] Re: [PATCH] mac80211: enable QoS support for nl80211
 ctrl port
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        johannes@sipsolutions.net
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
References: <20201210110432.GM2789@kadam>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <c068641b-61e9-0969-5d76-9b3699f2afd1@tu-ilmenau.de>
Date:   Sat, 12 Dec 2020 11:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201210110432.GM2789@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/2020 12:04, Dan Carpenter wrote:
> Hi Markus,
>
> url:    https://github.com/0day-ci/linux/commits/Markus-Theil/mac80211-enable-QoS-support-for-nl80211-ctrl-port/20201210-065717 
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
> config: x86_64-randconfig-s021-20201210 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-179-ga00755aa-dirty
>         # https://github.com/0day-ci/linux/commit/514b314825e19f7075eb375b3effa93ff0f6a16e 
>         git remote add linux-review https://github.com/0day-ci/linux 
>         git fetch --no-tags linux-review Markus-Theil/mac80211-enable-QoS-support-for-nl80211-ctrl-port/20201210-065717
>         git checkout 514b314825e19f7075eb375b3effa93ff0f6a16e
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> "sparse warnings: (new ones prefixed by >>)"
>>> net/mac80211/tx.c:1206:26: sparse: sparse: dubious: !x & y
> vim +1206 net/mac80211/tx.c
>
> 9ae54c8463691b Johannes Berg    2008-01-31  1162  static ieee80211_tx_result
> 3b8d81e020f77c Johannes Berg    2009-06-17  1163  ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
> 3b8d81e020f77c Johannes Berg    2009-06-17  1164  		     struct ieee80211_tx_data *tx,
> 7c10770f995820 Johannes Berg    2015-03-20  1165  		     struct sta_info *sta, struct sk_buff *skb)
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1166  {
> 3b8d81e020f77c Johannes Berg    2009-06-17  1167  	struct ieee80211_local *local = sdata->local;
> 58d4185e36913d Johannes Berg    2007-09-26  1168  	struct ieee80211_hdr *hdr;
> e039fa4a4195ac Johannes Berg    2008-05-15  1169  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
> 68f2b517bcbd81 Johannes Berg    2011-10-07  1170  	int tid;
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1171  
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1172  	memset(tx, 0, sizeof(*tx));
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1173  	tx->skb = skb;
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1174  	tx->local = local;
> 3b8d81e020f77c Johannes Berg    2009-06-17  1175  	tx->sdata = sdata;
> 252b86c43225d0 Johannes Berg    2011-11-16  1176  	__skb_queue_head_init(&tx->skbs);
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1177  
> cd8ffc800ce18e Johannes Berg    2009-03-23  1178  	/*
> cd8ffc800ce18e Johannes Berg    2009-03-23  1179  	 * If this flag is set to true anywhere, and we get here,
> cd8ffc800ce18e Johannes Berg    2009-03-23  1180  	 * we are doing the needed processing, so remove the flag
> cd8ffc800ce18e Johannes Berg    2009-03-23  1181  	 * now.
> cd8ffc800ce18e Johannes Berg    2009-03-23  1182  	 */
> cc20ff2c6b5d3e Felix Fietkau    2020-09-08  1183  	info->control.flags &= ~IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
> cd8ffc800ce18e Johannes Berg    2009-03-23  1184  
> 58d4185e36913d Johannes Berg    2007-09-26  1185  	hdr = (struct ieee80211_hdr *) skb->data;
> 58d4185e36913d Johannes Berg    2007-09-26  1186  
> 7c10770f995820 Johannes Berg    2015-03-20  1187  	if (likely(sta)) {
> 7c10770f995820 Johannes Berg    2015-03-20  1188  		if (!IS_ERR(sta))
> 7c10770f995820 Johannes Berg    2015-03-20  1189  			tx->sta = sta;
> 7c10770f995820 Johannes Berg    2015-03-20  1190  	} else {
> 3f0e0b220f8007 Felix Fietkau    2010-01-08  1191  		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
> f14543ee4d0681 Felix Fietkau    2009-11-10  1192  			tx->sta = rcu_dereference(sdata->u.vlan.sta);
> 7c10770f995820 Johannes Berg    2015-03-20  1193  			if (!tx->sta && sdata->wdev.use_4addr)
> 3f0e0b220f8007 Felix Fietkau    2010-01-08  1194  				return TX_DROP;
> 514b314825e19f Markus Theil     2020-12-09  1195  		} else if (tx->sdata->control_port_protocol == tx->skb->protocol) {
> b4d57adb727ec7 Felix Fietkau    2010-01-31  1196  			tx->sta = sta_info_get_bss(sdata, hdr->addr1);
> 3f0e0b220f8007 Felix Fietkau    2010-01-08  1197  		}
> 9d6b106b54e02a Johannes Berg    2015-02-24  1198  		if (!tx->sta && !is_multicast_ether_addr(hdr->addr1))
> abe60632f311d5 Johannes Berg    2009-11-25  1199  			tx->sta = sta_info_get(sdata, hdr->addr1);
> 7c10770f995820 Johannes Berg    2015-03-20  1200  	}
> 58d4185e36913d Johannes Berg    2007-09-26  1201  
> cd8ffc800ce18e Johannes Berg    2009-03-23  1202  	if (tx->sta && ieee80211_is_data_qos(hdr->frame_control) &&
> 49a59543eb5a5d Johannes Berg    2011-09-29  1203  	    !ieee80211_is_qos_nullfunc(hdr->frame_control) &&
> 30686bf7f5b3c3 Johannes Berg    2015-06-02  1204  	    ieee80211_hw_check(&local->hw, AMPDU_AGGREGATION) &&
> 514b314825e19f Markus Theil     2020-12-09  1205  	    !ieee80211_hw_check(&local->hw, TX_AMPDU_SETUP_IN_HW) &&
> 514b314825e19f Markus Theil     2020-12-09 @1206  	    !info->flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) {
>
> ! has higher precedence than & so this is equivalent of
> "if (!info->flags) {"  Presumably, it should be:
>
> 		!(info->flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO)) {

After fixing my syntax mistake, I ran into connectivity issues with my
older test NIC (Intel(R) Centrino(R) Ultimate-N 6300 AGN, REV=0x74)

and therefore removed the aggregation bypass for control port frames. My
current working assumption: sending aggregated and non-aggregated
data traffic on the same TID is buggy in firmware. Please correct my
assumption, if for example the 802.11 standard already speaks a word
against doing this.
I already sent an updated v2.

Markus

> cd8ffc800ce18e Johannes Berg    2009-03-23  1207  		struct tid_ampdu_tx *tid_tx;
> cd8ffc800ce18e Johannes Berg    2009-03-23  1208  
> a1f2ba04cc9241 Sara Sharon      2018-02-19  1209  		tid = ieee80211_get_tid(hdr);
> 8b30b1fe368ab0 Sujith           2008-10-24  1210  
> a622ab72b4dcfd Johannes Berg    2010-06-10  1211  		tid_tx = rcu_dereference(tx->sta->ampdu_mlme.tid_tx[tid]);
> a622ab72b4dcfd Johannes Berg    2010-06-10  1212  		if (tid_tx) {
> a622ab72b4dcfd Johannes Berg    2010-06-10  1213  			bool queued;
> a622ab72b4dcfd Johannes Berg    2010-06-10  1214  
> a622ab72b4dcfd Johannes Berg    2010-06-10  1215  			queued = ieee80211_tx_prep_agg(tx, skb, info,
> a622ab72b4dcfd Johannes Berg    2010-06-10  1216  						       tid_tx, tid);
> cd8ffc800ce18e Johannes Berg    2009-03-23  1217  
> cd8ffc800ce18e Johannes Berg    2009-03-23  1218  			if (unlikely(queued))
> cd8ffc800ce18e Johannes Berg    2009-03-23  1219  				return TX_QUEUED;
> 8b30b1fe368ab0 Sujith           2008-10-24  1220  		}
> a622ab72b4dcfd Johannes Berg    2010-06-10  1221  	}
> 8b30b1fe368ab0 Sujith           2008-10-24  1222  
> badffb725c86cc Jiri Slaby       2007-08-28  1223  	if (is_multicast_ether_addr(hdr->addr1)) {
> 5cf121c3cdb955 Johannes Berg    2008-02-25  1224  		tx->flags &= ~IEEE80211_TX_UNICAST;
> e039fa4a4195ac Johannes Berg    2008-05-15  1225  		info->flags |= IEEE80211_TX_CTL_NO_ACK;
> 6fd67e937ece53 Simon Wunderlich 2011-11-18  1226  	} else
> 5cf121c3cdb955 Johannes Berg    2008-02-25  1227  		tx->flags |= IEEE80211_TX_UNICAST;
> 58d4185e36913d Johannes Berg    2007-09-26  1228  
> a26eb27ab43014 Johannes Berg    2011-10-07  1229  	if (!(info->flags & IEEE80211_TX_CTL_DONTFRAG)) {
> a26eb27ab43014 Johannes Berg    2011-10-07  1230  		if (!(tx->flags & IEEE80211_TX_UNICAST) ||
> a26eb27ab43014 Johannes Berg    2011-10-07  1231  		    skb->len + FCS_LEN <= local->hw.wiphy->frag_threshold ||
> a26eb27ab43014 Johannes Berg    2011-10-07  1232  		    info->flags & IEEE80211_TX_CTL_AMPDU)
> a26eb27ab43014 Johannes Berg    2011-10-07  1233  			info->flags |= IEEE80211_TX_CTL_DONTFRAG;
> 58d4185e36913d Johannes Berg    2007-09-26  1234  	}
> 58d4185e36913d Johannes Berg    2007-09-26  1235  
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1236  	if (!tx->sta)
> e039fa4a4195ac Johannes Berg    2008-05-15  1237  		info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT;
> f7418bc10d8402 Felix Fietkau    2015-09-24  1238  	else if (test_and_clear_sta_flag(tx->sta, WLAN_STA_CLEAR_PS_FILT)) {
> e039fa4a4195ac Johannes Berg    2008-05-15  1239  		info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT;
> f7418bc10d8402 Felix Fietkau    2015-09-24  1240  		ieee80211_check_fast_xmit(tx->sta);
> f7418bc10d8402 Felix Fietkau    2015-09-24  1241  	}
> 58d4185e36913d Johannes Berg    2007-09-26  1242  
> e039fa4a4195ac Johannes Berg    2008-05-15  1243  	info->flags |= IEEE80211_TX_CTL_FIRST_FRAGMENT;
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1244  
> 9ae54c8463691b Johannes Berg    2008-01-31  1245  	return TX_CONTINUE;
> e2ebc74d7e3d71 Johannes Berg    2007-07-27  1246  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
>
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
