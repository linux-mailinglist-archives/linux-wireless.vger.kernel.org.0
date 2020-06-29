Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB0720D38D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgF2TAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:00:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:65098 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgF2TAD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:00:03 -0400
IronPort-SDR: 1ogrH5UO8y5wWn5qFo6axyC5Xes/XVubLo17c8szEokVJTa7c6acIzxJMlNMMiXbSxWlijcWd5
 I1dydT7gd2FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147501318"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="147501318"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 05:30:31 -0700
IronPort-SDR: Wa/mSo/UPcKddqyhBlNdRCGnWvxQKVKPtVptpmDWzvQgPc0f4wi9E79w+Ek0i81FwXipeX7UQc
 BkweHiN0tXeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="266187065"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2020 05:30:29 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpsvc-0000y7-G8; Mon, 29 Jun 2020 12:30:28 +0000
Date:   Mon, 29 Jun 2020 20:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mathy.vanhoef@nyu.edu
Subject: Re: [PATCH] mac80211: keep non-zero sequence counter of injected
 frames
Message-ID: <202006292053.f33RVCe4%lkp@intel.com>
References: <20200628220512.28535ebc@mathy-work.localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200628220512.28535ebc@mathy-work.localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mathy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mac80211-next/master]
[also build test WARNING on mac80211/master v5.8-rc3 next-20200629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mathy-Vanhoef/mac80211-keep-non-zero-sequence-counter-of-injected-frames/20200629-021517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: riscv-randconfig-r013-20200629 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from net/mac80211/tx.c:13:
   net/mac80211/tx.c: In function 'ieee80211_tx_h_sequence':
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~
   net/mac80211/tx.c:817:21: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     817 |        (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
         |                     ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/mac80211/tx.c:816:2: note: in expansion of macro 'if'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |  ^~
   include/linux/compiler.h:48:24: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                        ^~~~~~~~~~~~~~~~
>> net/mac80211/tx.c:816:6: note: in expansion of macro 'unlikely'
     816 |  if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
         |      ^~~~~~~~

vim +/unlikely +816 net/mac80211/tx.c

   802	
   803	static ieee80211_tx_result debug_noinline
   804	ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
   805	{
   806		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
   807		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
   808		int tid;
   809	
   810		/*
   811		 * Packet injection may want to control the sequence number.
   812		 * Do not assign one ourselves, and do not ask the driver to,
   813		 * if there is no matching interface or if the injected frame
   814		 * was already assigned a non-zero sequence number.
   815		 */
 > 816		if (unlikely(info->control.vif->type == NL80211_IFTYPE_MONITOR ||
   817			     (info->flags & IEEE80211_TX_CTL_INJECTED != 0 &&
   818			      hdr->seq_ctrl != 0)))
   819			return TX_CONTINUE;
   820	
   821		if (unlikely(ieee80211_is_ctl(hdr->frame_control)))
   822			return TX_CONTINUE;
   823	
   824		if (ieee80211_hdrlen(hdr->frame_control) < 24)
   825			return TX_CONTINUE;
   826	
   827		if (ieee80211_is_qos_nullfunc(hdr->frame_control))
   828			return TX_CONTINUE;
   829	
   830		/*
   831		 * Anything but QoS data that has a sequence number field
   832		 * (is long enough) gets a sequence number from the global
   833		 * counter.  QoS data frames with a multicast destination
   834		 * also use the global counter (802.11-2012 9.3.2.10).
   835		 */
   836		if (!ieee80211_is_data_qos(hdr->frame_control) ||
   837		    is_multicast_ether_addr(hdr->addr1)) {
   838			if (tx->flags & IEEE80211_TX_NO_SEQNO)
   839				return TX_CONTINUE;
   840			/* driver should assign sequence number */
   841			info->flags |= IEEE80211_TX_CTL_ASSIGN_SEQ;
   842			/* for pure STA mode without beacons, we can do it */
   843			hdr->seq_ctrl = cpu_to_le16(tx->sdata->sequence_number);
   844			tx->sdata->sequence_number += 0x10;
   845			if (tx->sta)
   846				tx->sta->tx_stats.msdu[IEEE80211_NUM_TIDS]++;
   847			return TX_CONTINUE;
   848		}
   849	
   850		/*
   851		 * This should be true for injected/management frames only, for
   852		 * management frames we have set the IEEE80211_TX_CTL_ASSIGN_SEQ
   853		 * above since they are not QoS-data frames.
   854		 */
   855		if (!tx->sta)
   856			return TX_CONTINUE;
   857	
   858		/* include per-STA, per-TID sequence counter */
   859		tid = ieee80211_get_tid(hdr);
   860		tx->sta->tx_stats.msdu[tid]++;
   861	
   862		hdr->seq_ctrl = ieee80211_tx_next_seq(tx->sta, tid);
   863	
   864		return TX_CONTINUE;
   865	}
   866	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
i1anOsRXTpAPwT7c780YgVqh+gEA

--Nq2Wo0NMKNjxTN9z--
