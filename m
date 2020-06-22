Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A43203B26
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgFVPig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 11:38:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:51657 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbgFVPif (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 11:38:35 -0400
IronPort-SDR: 4qy13mna7A4leDlace+Nq+AhW9kd20aL1dyL3pDLTAbA+L1QzRs9ZZrIj7fdCQO2Zu2ov6W0hD
 QGiBrh+huNGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="205270237"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="205270237"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 08:38:07 -0700
IronPort-SDR: RY/HyDOoYVV+hUG+088kkIFko4NBmX1YwoZ8NtrysIU+fTRXzn7utiiWVWLNKkQWr6YaYh9+z6
 tDXsHQNKnFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="478424095"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 08:38:04 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnOWJ-0000Mc-US; Mon, 22 Jun 2020 15:38:03 +0000
Date:   Mon, 22 Jun 2020 23:37:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        johannes@sipsolutions.net
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org, j@w1.fi,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH v3] mac80211: fix control port tx status check
Message-ID: <202006222310.52eoxs6F%lkp@intel.com>
References: <20200622123542.173695-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20200622123542.173695-1-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Markus,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mac80211-next/master]
[also build test WARNING on mac80211/master v5.8-rc2 next-20200622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Markus-Theil/mac80211-fix-control-port-tx-status-check/20200622-203641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: c6x-randconfig-s032-20200622 (attached as .config)
compiler: c6x-elf-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=c6x CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/mac80211/status.c:642:36: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be16 [usertype] ethertype @@     got int @@
>> net/mac80211/status.c:642:36: sparse:     expected restricted __be16 [usertype] ethertype
>> net/mac80211/status.c:642:36: sparse:     got int

vim +642 net/mac80211/status.c

   623	
   624	static void ieee80211_report_ack_skb(struct ieee80211_local *local,
   625					     struct ieee80211_tx_info *info,
   626					     bool acked, bool dropped)
   627	{
   628		struct sk_buff *skb;
   629		unsigned long flags;
   630	
   631		spin_lock_irqsave(&local->ack_status_lock, flags);
   632		skb = idr_remove(&local->ack_status_frames, info->ack_frame_id);
   633		spin_unlock_irqrestore(&local->ack_status_lock, flags);
   634	
   635		if (!skb)
   636			return;
   637	
   638		if (info->flags & IEEE80211_TX_INTFL_NL80211_FRAME_TX) {
   639			u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
   640			struct ieee80211_sub_if_data *sdata;
   641			struct ieee80211_hdr *hdr = (void *)skb->data;
 > 642			__be16 ethertype = 0xffff;
   643	
   644			if (skb->len >= ETH_HLEN && skb->protocol == cpu_to_be16(ETH_P_802_3))
   645				skb_copy_bits(skb, 2 * ETH_ALEN, &ethertype, ETH_TLEN);
   646	
   647			rcu_read_lock();
   648			sdata = ieee80211_sdata_from_skb(local, skb);
   649			if (sdata) {
   650				if (ethertype == sdata->control_port_protocol ||
   651				    ethertype == cpu_to_be16(ETH_P_PREAUTH))
   652					cfg80211_control_port_tx_status(&sdata->wdev,
   653									cookie,
   654									skb->data,
   655									skb->len,
   656									acked,
   657									GFP_ATOMIC);
   658				else if (ieee80211_is_any_nullfunc(hdr->frame_control))
   659					cfg80211_probe_status(sdata->dev, hdr->addr1,
   660							      cookie, acked,
   661							      info->status.ack_signal,
   662							      info->status.is_valid_ack_signal,
   663							      GFP_ATOMIC);
   664				else if (ieee80211_is_mgmt(hdr->frame_control))
   665					cfg80211_mgmt_tx_status(&sdata->wdev, cookie,
   666								skb->data, skb->len,
   667								acked, GFP_ATOMIC);
   668				else
   669					pr_warn("Unknown status report in ack skb\n");
   670	
   671			}
   672			rcu_read_unlock();
   673	
   674			dev_kfree_skb_any(skb);
   675		} else if (dropped) {
   676			dev_kfree_skb_any(skb);
   677		} else {
   678			/* consumes skb */
   679			skb_complete_wifi_ack(skb, acked);
   680		}
   681	}
   682	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2/sfgZ6L++JDAQA=

--vtzGhvizbBRQ85DL--
