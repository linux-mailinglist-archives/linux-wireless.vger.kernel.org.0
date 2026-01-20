Return-Path: <linux-wireless+bounces-31021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM89BtNIcGnXXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 04:32:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A0506EF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 04:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34B208E0D0E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698D42849D;
	Tue, 20 Jan 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFZYvcnc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B618428494;
	Tue, 20 Jan 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915636; cv=none; b=MnkM3BbxOW/unfuNzq2/yo8HDoucVffOvzUWTcZ01gA+mn+v3B7Gw0GQeDVRX4SC+V1roReS1Xn+MCNxQgZbP514D1LhRrd5Whjs6HIfH36R/Ud+48WpgI9Pv60qga5IoDMJfFijWPdjyV82P5UNbgQro7dzeFDq1ychiv1BHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915636; c=relaxed/simple;
	bh=zliMfnqN7+4qWXkakteLMnL1rqDZXpRuUMDYk9dV31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khgUPl59rtwOT2lsWXL2Tc/2hrC3IB9MLFgG58c/gtayT8MEKsqRhB1uKmGjRz9Vg5disJKF4MniTat+OVAwaPgpFbqa0Ih94JGWU1CypbjLLE91zV7+ShVsgpQ2wECyr9YLqeJmBXOrtawAujkTPGPufvWixgMGqH/Zod37/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFZYvcnc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768915632; x=1800451632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zliMfnqN7+4qWXkakteLMnL1rqDZXpRuUMDYk9dV31A=;
  b=RFZYvcncd4tQ24uOoRFKKMoEZgTn7Z1L8DFAypWkOadhEgAU4BZMeO4R
   mcdYIaHMwqBsF4n7eW48IAYULs2/5zvqPlOjmq4Lx2VdRV/YWWaCj+RVE
   EIJtW048BB/g28S1ZkaLVptDzKZIYiq52oA+RXa/0nJnBAnblACurqJwU
   zi9Ro4mfYs9jlCvO8dj7Y9U4aq5vqowMIR2mEXenYHuqGbMCm9MOl4ixr
   5sZk2B0klI5Q60igLEHMRkfjthEUgTfzmUK7rMst/i9kj8FDu2EdUBilg
   zsT4U7ScCN3fTRQ20WnAodZX1TaXSKBeW5MtUqSLf3EfRCLvLdO57aK0G
   g==;
X-CSE-ConnectionGUID: xHrWpkmCSMOvtWpsnE8z7w==
X-CSE-MsgGUID: FGBg6SD/RxSa/WIrcOBRuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="81232151"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="81232151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:27:12 -0800
X-CSE-ConnectionGUID: qs6DvTcrSlGaTFKGlwR8NQ==
X-CSE-MsgGUID: dy0vDc1tSN2LQyhVI9nNbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205362466"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Jan 2026 05:27:09 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viBlB-00000000P1B-45b7;
	Tue, 20 Jan 2026 13:27:05 +0000
Date: Tue, 20 Jan 2026 21:26:40 +0800
From: kernel test robot <lkp@intel.com>
To: Zac <zac@zacbowling.com>, sean.wang@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	deren.wu@mediatek.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name,
	ryder.lee@mediatek.com, sean.wang@mediatek.com,
	stable@vger.kernel.org, linux@frame.work, zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: Re: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race
 conditions
Message-ID: <202601202144.ee4DM9Pz-lkp@intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-31021-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 994A0506EF
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
config: i386-randconfig-015-20260120 (https://download.01.org/0day-ci/archive/20260120/202601202144.ee4DM9Pz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601202144.ee4DM9Pz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601202144.ee4DM9Pz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7925/main.c:611:5: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     610 |                                 "mt7925: ROC throttled, %lu ms remaining\n",
         |                                                         ~~~
         |                                                         %u
     611 |                                 jiffies_to_msecs(throttle));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/net/wireless/mediatek/mt76/mt7925/main.c:662:5: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
     661 |                                 "mt7925: MLO ROC throttled, %lu ms remaining\n",
         |                                                             ~~~
         |                                                             %u
     662 |                                 jiffies_to_msecs(throttle));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:285:19: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   2 warnings generated.


vim +611 drivers/net/wireless/mediatek/mt76/mt7925/main.c

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
   610					"mt7925: ROC throttled, %lu ms remaining\n",
 > 611					jiffies_to_msecs(throttle));
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

