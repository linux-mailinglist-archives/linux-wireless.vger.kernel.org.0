Return-Path: <linux-wireless+bounces-31018-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC3mE5d6cGktYAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31018-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 08:04:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C77528DA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 08:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C82F624E62
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21B41322C;
	Tue, 20 Jan 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8340UZv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FC23F424;
	Tue, 20 Jan 2026 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909388; cv=none; b=NxWo2XqeMW7CGoIz97wyU+BVnpLCK/932a+vBkwN7OdSfdFBhNVFs1fbs1eoFKkzaXXyNzpksZlymSojFxuhG+8D07ryTy7VW8QHKmyio0UahyvsVtBuak9FWGe8gNvLiDmFu1lc8uPdrj7/fu5iMgvs4IHgOUrs3YDlrOQLxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909388; c=relaxed/simple;
	bh=2jNhiXUBMyyLdyxAs9vQmmaOOOBC6WVaq/BZF27U5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9UnllJGiJ2JJp3O1UNHrR0sewteqa/kcbxXoK48GXA447QyrUFEx6YSj0oOKQJQS7XA50NNUlSlgVq6e9Pw2QNm8TXv3c4/FqEM+X2RXXzVAgZdzVHxGxGSnCnIZYNMI/UcvsQhe4K5QJ0kcsDRxuCqJ48MpsiOrMLX0cwUftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8340UZv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768909386; x=1800445386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2jNhiXUBMyyLdyxAs9vQmmaOOOBC6WVaq/BZF27U5XY=;
  b=R8340UZveHy3MqSwQ9v59nic7l5fJgGke2iyqK30hZO0bmXA8dzqBii2
   9YjRJV/twIbH35mJadEQ3M4LFeeIhhHzgNU86QqgqMI1F8V/jz3iJSpDa
   +J06tqU6CJF3CZjevgjLQDQdRhgg3zfhAl+uumRMMfaUdhTLu5nIQkjrL
   u7RsUghNufHKKvAXnoLsBW+LbGEA+yNaeRuzz/C1LUQZczYNn/1rN8nYf
   /P1E9+6Be8gO7ImNfDSTB9P6s+2vuqv/FD80N3j9cDocaJq7vTos7U2lc
   klH3MTUf0PwuaETQ9woOVLICASl5++7Ve30CQ2ipXqFrjyxC50fIncQ3l
   g==;
X-CSE-ConnectionGUID: 1lLBOBGmQsKARYCBfFTugg==
X-CSE-MsgGUID: jAKzoHuBQVCBgNasQUJiVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69315716"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69315716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 03:43:04 -0800
X-CSE-ConnectionGUID: eseWj3+4SPiBSrByS7Tl+Q==
X-CSE-MsgGUID: bOuQi7P2T3SC8cwIMbNjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205256698"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Jan 2026 03:43:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viA8P-00000000OuH-0ZsO;
	Tue, 20 Jan 2026 11:42:57 +0000
Date: Tue, 20 Jan 2026 19:42:49 +0800
From: kernel test robot <lkp@intel.com>
To: Zac <zac@zacbowling.com>, sean.wang@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, deren.wu@mediatek.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name,
	ryder.lee@mediatek.com, sean.wang@mediatek.com,
	stable@vger.kernel.org, linux@frame.work, zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: Re: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race
 conditions
Message-ID: <202601201954.zxO1N1DS-lkp@intel.com>
References: <20260120062854.126501-12-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120062854.126501-12-zac@zacbowling.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,nbd.name,frame.work,gmail.com,zacbowling.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-31018-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: E2C77528DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zac,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zac/wifi-mt76-fix-list-corruption-in-mt76_wcid_cleanup/20260120-143842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260120062854.126501-12-zac%40zacbowling.com
patch subject: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race conditions
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260120/202601201954.zxO1N1DS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201954.zxO1N1DS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201954.zxO1N1DS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:621,
                    from include/linux/kernel.h:31,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/wireless/mediatek/mt76/mt7925/main.c:4:
   drivers/net/wireless/mediatek/mt76/mt7925/main.c: In function 'mt7925_set_roc':
>> drivers/net/wireless/mediatek/mt76/mt7925/main.c:610:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
     610 |                                 "mt7925: ROC throttled, %lu ms remaining\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:231:29: note: in definition of macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:284:9: note: in expansion of macro '_dynamic_func_call'
     284 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:609:25: note: in expansion of macro 'dev_dbg'
     609 |                         dev_dbg(phy->dev->mt76.dev,
         |                         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:610:59: note: format string is defined here
     610 |                                 "mt7925: ROC throttled, %lu ms remaining\n",
         |                                                         ~~^
         |                                                           |
         |                                                           long unsigned int
         |                                                         %u
   drivers/net/wireless/mediatek/mt76/mt7925/main.c: In function 'mt7925_set_mlo_roc':
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:661:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
     661 |                                 "mt7925: MLO ROC throttled, %lu ms remaining\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:231:29: note: in definition of macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:284:9: note: in expansion of macro '_dynamic_func_call'
     284 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:660:25: note: in expansion of macro 'dev_dbg'
     660 |                         dev_dbg(phy->dev->mt76.dev,
         |                         ^~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:661:63: note: format string is defined here
     661 |                                 "mt7925: MLO ROC throttled, %lu ms remaining\n",
         |                                                             ~~^
         |                                                               |
         |                                                               long unsigned int
         |                                                             %u


vim +610 drivers/net/wireless/mediatek/mt76/mt7925/main.c

   592	
   593	static int mt7925_set_roc(struct mt792x_phy *phy,
   594				  struct mt792x_bss_conf *mconf,
   595				  struct ieee80211_channel *chan,
   596				  int duration,
   597				  enum mt7925_roc_req type)
   598	{
   599		unsigned long throttle;
   600		int err;
   601	
   602		/* Check rate limiting - if in backoff period, wait or return busy */
   603		throttle = mt7925_roc_throttle_check(phy);
   604		if (throttle) {
   605			/* For short backoffs, wait; for longer ones, return busy */
   606			if (throttle < msecs_to_jiffies(200)) {
   607				msleep(jiffies_to_msecs(throttle));
   608			} else {
   609				dev_dbg(phy->dev->mt76.dev,
 > 610					"mt7925: ROC throttled, %lu ms remaining\n",
   611					jiffies_to_msecs(throttle));
   612				return -EBUSY;
   613			}
   614		}
   615	
   616		/* Clear stale abort flag from previous ROC */
   617		clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
   618	
   619		if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
   620			return -EBUSY;
   621	
   622		phy->roc_grant = false;
   623	
   624		err = mt7925_mcu_set_roc(phy, mconf, chan, duration, type,
   625					 ++phy->roc_token_id);
   626		if (err < 0) {
   627			clear_bit(MT76_STATE_ROC, &phy->mt76->state);
   628			goto out;
   629		}
   630	
   631		if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
   632			mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
   633			clear_bit(MT76_STATE_ROC, &phy->mt76->state);
   634			mt7925_roc_record_timeout(phy);
   635			err = -ETIMEDOUT;
   636		} else {
   637			/* Successful ROC - reset timeout tracking */
   638			mt7925_roc_clear_timeout(phy);
   639		}
   640	
   641	out:
   642		return err;
   643	}
   644	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

