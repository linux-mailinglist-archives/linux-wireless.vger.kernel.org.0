Return-Path: <linux-wireless+bounces-37845-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gd/aCls4MmrowwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37845-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:02:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E2696B99
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RGmHNT7Q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37845-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37845-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53654309EC77
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 06:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483C3B14DE;
	Wed, 17 Jun 2026 06:01:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2624E4A1;
	Wed, 17 Jun 2026 06:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676090; cv=none; b=pXd5pVknZj/uVtQaDuLGIKRNZEUN+BqtIOXoGZriNj350+GjPIgN9MXcOmugC+wo9OBpGmzPoXl347vBQTRSHrl6Sct22iT3k8ndRm/aqqZgWgUtMXhmv5mEipUZ2R7Habe74LbuE5Tl8vijV4Ks+jSGs+DjK0ZOcgJHopurpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676090; c=relaxed/simple;
	bh=pMBWIR0F6P1YR7l6eX9JDBSPYtmJb5pwcu6s7Z3CBvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOSRMhRdSd3EfJyKvumYYoSNj7Pi5nnmD85JOJtmR2HS/CzCsme2GRMNg5tDHqNsU3YVq8YLPkJEnK2zSaIJnKCeKYjbko1efj3o0ubDY0BYiLa4Wbc9I/4pfoARDRg+wQ4cUnKW0+H1KQhFN8knFCQYHmP5mNMfeYQ4UdXJRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGmHNT7Q; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781676089; x=1813212089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMBWIR0F6P1YR7l6eX9JDBSPYtmJb5pwcu6s7Z3CBvQ=;
  b=RGmHNT7QgUeErys4v57q0inNiO+uy21RZJ3bAHv726PTXrnw3ZTBhZIA
   j01oQNCezNaW34m+Z8Wg0vDLhqbe4rdh2GqvRaKjVdWYa2TZCACeA8Chf
   MffNQH2TDedbTa71WO0xY0JHnGWkb68UIER04c7zDUgBg5lkvmp8ddV2F
   /YH5o+PjSmIax9MsJYiQANToqeXcTKNYs8qm68braghL5RbSdb7cIkKCc
   BQ4FCXBpoWhmMjaa+yTqBQUR5w5P41MhnGmgR8CNsc6/Vuv1qkek2jguz
   KT5hRDs7BLI3TNp9GQe1wrH2bo9GwNe9b2hyc0AXRqvLJScvZjz9HEp+H
   g==;
X-CSE-ConnectionGUID: HCavKeUGQF6aX0KyX8Sy1A==
X-CSE-MsgGUID: mfS0SyfnTHuHIaXfMuSq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82337147"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82337147"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:01:28 -0700
X-CSE-ConnectionGUID: aiKY6Vn8R1yOGWbtRlBrjw==
X-CSE-MsgGUID: vaFKjJF4T5O9xdjezvhi3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272042474"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jun 2026 23:01:27 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZjL2-00000000UA6-1S9v;
	Wed, 17 Jun 2026 06:01:24 +0000
Date: Wed, 17 Jun 2026 14:00:38 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH ath-next] wifi: ath9k: drop static from local pdadc and
 vpdTable arrays
Message-ID: <202606171341.zUckYxVR-lkp@intel.com>
References: <20260616030828.655310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616030828.655310-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37845-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5E2696B99

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ath/ath-next]
[also build test WARNING on wireless/main wireless-next/main linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/wifi-ath9k-drop-static-from-local-pdadc-and-vpdTable-arrays/20260616-114515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20260616030828.655310-1-rosenp%40gmail.com
patch subject: [PATCH ath-next] wifi: ath9k: drop static from local pdadc and vpdTable arrays
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260617/202606171341.zUckYxVR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260617/202606171341.zUckYxVR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606171341.zUckYxVR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath9k/eeprom.c: In function 'ath9k_hw_get_gain_boundaries_pdadcs':
>> drivers/net/wireless/ath/ath9k/eeprom.c:657:1: warning: the frame size of 1360 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     657 | }
         | ^


vim +657 drivers/net/wireless/ath/ath9k/eeprom.c

a55f858852e4345 Sujith        2010-06-01  451  
115277a3bc0683d Felix Fietkau 2010-12-12  452  void ath9k_hw_get_gain_boundaries_pdadcs(struct ath_hw *ah,
115277a3bc0683d Felix Fietkau 2010-12-12  453  				struct ath9k_channel *chan,
115277a3bc0683d Felix Fietkau 2010-12-12  454  				void *pRawDataSet,
115277a3bc0683d Felix Fietkau 2010-12-12  455  				u8 *bChans, u16 availPiers,
115277a3bc0683d Felix Fietkau 2010-12-12  456  				u16 tPdGainOverlap,
115277a3bc0683d Felix Fietkau 2010-12-12  457  				u16 *pPdGainBoundaries, u8 *pPDADCValues,
115277a3bc0683d Felix Fietkau 2010-12-12  458  				u16 numXpdGains)
115277a3bc0683d Felix Fietkau 2010-12-12  459  {
115277a3bc0683d Felix Fietkau 2010-12-12  460  	int i, j, k;
115277a3bc0683d Felix Fietkau 2010-12-12  461  	int16_t ss;
115277a3bc0683d Felix Fietkau 2010-12-12  462  	u16 idxL = 0, idxR = 0, numPiers;
8e792d8755eaf1a Rosen Penev   2026-06-15  463  	u8 vpdTableL[AR5416_NUM_PD_GAINS]
115277a3bc0683d Felix Fietkau 2010-12-12  464  		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
8e792d8755eaf1a Rosen Penev   2026-06-15  465  	u8 vpdTableR[AR5416_NUM_PD_GAINS]
115277a3bc0683d Felix Fietkau 2010-12-12  466  		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
8e792d8755eaf1a Rosen Penev   2026-06-15  467  	u8 vpdTableI[AR5416_NUM_PD_GAINS]
115277a3bc0683d Felix Fietkau 2010-12-12  468  		[AR5416_MAX_PWR_RANGE_IN_HALF_DB];
115277a3bc0683d Felix Fietkau 2010-12-12  469  
115277a3bc0683d Felix Fietkau 2010-12-12  470  	u8 *pVpdL, *pVpdR, *pPwrL, *pPwrR;
115277a3bc0683d Felix Fietkau 2010-12-12  471  	u8 minPwrT4[AR5416_NUM_PD_GAINS];
115277a3bc0683d Felix Fietkau 2010-12-12  472  	u8 maxPwrT4[AR5416_NUM_PD_GAINS];
115277a3bc0683d Felix Fietkau 2010-12-12  473  	int16_t vpdStep;
115277a3bc0683d Felix Fietkau 2010-12-12  474  	int16_t tmpVal;
115277a3bc0683d Felix Fietkau 2010-12-12  475  	u16 sizeCurrVpdTable, maxIndex, tgtIndex;
115277a3bc0683d Felix Fietkau 2010-12-12  476  	bool match;
115277a3bc0683d Felix Fietkau 2010-12-12  477  	int16_t minDelta = 0;
115277a3bc0683d Felix Fietkau 2010-12-12  478  	struct chan_centers centers;
115277a3bc0683d Felix Fietkau 2010-12-12  479  	int pdgain_boundary_default;
115277a3bc0683d Felix Fietkau 2010-12-12  480  	struct cal_data_per_freq *data_def = pRawDataSet;
115277a3bc0683d Felix Fietkau 2010-12-12  481  	struct cal_data_per_freq_4k *data_4k = pRawDataSet;
940cd2c12ebff68 Felix Fietkau 2010-12-12  482  	struct cal_data_per_freq_ar9287 *data_9287 = pRawDataSet;
115277a3bc0683d Felix Fietkau 2010-12-12  483  	bool eeprom_4k = AR_SREV_9285(ah) || AR_SREV_9271(ah);
940cd2c12ebff68 Felix Fietkau 2010-12-12  484  	int intercepts;
940cd2c12ebff68 Felix Fietkau 2010-12-12  485  
940cd2c12ebff68 Felix Fietkau 2010-12-12  486  	if (AR_SREV_9287(ah))
940cd2c12ebff68 Felix Fietkau 2010-12-12  487  		intercepts = AR9287_PD_GAIN_ICEPTS;
940cd2c12ebff68 Felix Fietkau 2010-12-12  488  	else
940cd2c12ebff68 Felix Fietkau 2010-12-12  489  		intercepts = AR5416_PD_GAIN_ICEPTS;
115277a3bc0683d Felix Fietkau 2010-12-12  490  
115277a3bc0683d Felix Fietkau 2010-12-12  491  	memset(&minPwrT4, 0, AR5416_NUM_PD_GAINS);
115277a3bc0683d Felix Fietkau 2010-12-12  492  	ath9k_hw_get_channel_centers(ah, chan, &centers);
115277a3bc0683d Felix Fietkau 2010-12-12  493  
115277a3bc0683d Felix Fietkau 2010-12-12  494  	for (numPiers = 0; numPiers < availPiers; numPiers++) {
115277a3bc0683d Felix Fietkau 2010-12-12  495  		if (bChans[numPiers] == AR5416_BCHAN_UNUSED)
115277a3bc0683d Felix Fietkau 2010-12-12  496  			break;
115277a3bc0683d Felix Fietkau 2010-12-12  497  	}
115277a3bc0683d Felix Fietkau 2010-12-12  498  
115277a3bc0683d Felix Fietkau 2010-12-12  499  	match = ath9k_hw_get_lower_upper_index((u8)FREQ2FBIN(centers.synth_center,
115277a3bc0683d Felix Fietkau 2010-12-12  500  							     IS_CHAN_2GHZ(chan)),
115277a3bc0683d Felix Fietkau 2010-12-12  501  					       bChans, numPiers, &idxL, &idxR);
115277a3bc0683d Felix Fietkau 2010-12-12  502  
115277a3bc0683d Felix Fietkau 2010-12-12  503  	if (match) {
940cd2c12ebff68 Felix Fietkau 2010-12-12  504  		if (AR_SREV_9287(ah)) {
940cd2c12ebff68 Felix Fietkau 2010-12-12  505  			for (i = 0; i < numXpdGains; i++) {
940cd2c12ebff68 Felix Fietkau 2010-12-12  506  				minPwrT4[i] = data_9287[idxL].pwrPdg[i][0];
83d6f1f15f8cce8 Arnd Bergmann 2016-03-14  507  				maxPwrT4[i] = data_9287[idxL].pwrPdg[i][intercepts - 1];
940cd2c12ebff68 Felix Fietkau 2010-12-12  508  				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
940cd2c12ebff68 Felix Fietkau 2010-12-12  509  						data_9287[idxL].pwrPdg[i],
940cd2c12ebff68 Felix Fietkau 2010-12-12  510  						data_9287[idxL].vpdPdg[i],
940cd2c12ebff68 Felix Fietkau 2010-12-12  511  						intercepts,
940cd2c12ebff68 Felix Fietkau 2010-12-12  512  						vpdTableI[i]);
940cd2c12ebff68 Felix Fietkau 2010-12-12  513  			}
940cd2c12ebff68 Felix Fietkau 2010-12-12  514  		} else if (eeprom_4k) {
115277a3bc0683d Felix Fietkau 2010-12-12  515  			for (i = 0; i < numXpdGains; i++) {
115277a3bc0683d Felix Fietkau 2010-12-12  516  				minPwrT4[i] = data_4k[idxL].pwrPdg[i][0];
83d6f1f15f8cce8 Arnd Bergmann 2016-03-14  517  				maxPwrT4[i] = data_4k[idxL].pwrPdg[i][intercepts - 1];
115277a3bc0683d Felix Fietkau 2010-12-12  518  				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
115277a3bc0683d Felix Fietkau 2010-12-12  519  						data_4k[idxL].pwrPdg[i],
115277a3bc0683d Felix Fietkau 2010-12-12  520  						data_4k[idxL].vpdPdg[i],
940cd2c12ebff68 Felix Fietkau 2010-12-12  521  						intercepts,
115277a3bc0683d Felix Fietkau 2010-12-12  522  						vpdTableI[i]);
115277a3bc0683d Felix Fietkau 2010-12-12  523  			}
115277a3bc0683d Felix Fietkau 2010-12-12  524  		} else {
115277a3bc0683d Felix Fietkau 2010-12-12  525  			for (i = 0; i < numXpdGains; i++) {
115277a3bc0683d Felix Fietkau 2010-12-12  526  				minPwrT4[i] = data_def[idxL].pwrPdg[i][0];
83d6f1f15f8cce8 Arnd Bergmann 2016-03-14  527  				maxPwrT4[i] = data_def[idxL].pwrPdg[i][intercepts - 1];
115277a3bc0683d Felix Fietkau 2010-12-12  528  				ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
115277a3bc0683d Felix Fietkau 2010-12-12  529  						data_def[idxL].pwrPdg[i],
115277a3bc0683d Felix Fietkau 2010-12-12  530  						data_def[idxL].vpdPdg[i],
940cd2c12ebff68 Felix Fietkau 2010-12-12  531  						intercepts,
115277a3bc0683d Felix Fietkau 2010-12-12  532  						vpdTableI[i]);
115277a3bc0683d Felix Fietkau 2010-12-12  533  			}
115277a3bc0683d Felix Fietkau 2010-12-12  534  		}
115277a3bc0683d Felix Fietkau 2010-12-12  535  	} else {
115277a3bc0683d Felix Fietkau 2010-12-12  536  		for (i = 0; i < numXpdGains; i++) {
940cd2c12ebff68 Felix Fietkau 2010-12-12  537  			if (AR_SREV_9287(ah)) {
940cd2c12ebff68 Felix Fietkau 2010-12-12  538  				pVpdL = data_9287[idxL].vpdPdg[i];
940cd2c12ebff68 Felix Fietkau 2010-12-12  539  				pPwrL = data_9287[idxL].pwrPdg[i];
940cd2c12ebff68 Felix Fietkau 2010-12-12  540  				pVpdR = data_9287[idxR].vpdPdg[i];
940cd2c12ebff68 Felix Fietkau 2010-12-12  541  				pPwrR = data_9287[idxR].pwrPdg[i];
940cd2c12ebff68 Felix Fietkau 2010-12-12  542  			} else if (eeprom_4k) {
115277a3bc0683d Felix Fietkau 2010-12-12  543  				pVpdL = data_4k[idxL].vpdPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  544  				pPwrL = data_4k[idxL].pwrPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  545  				pVpdR = data_4k[idxR].vpdPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  546  				pPwrR = data_4k[idxR].pwrPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  547  			} else {
115277a3bc0683d Felix Fietkau 2010-12-12  548  				pVpdL = data_def[idxL].vpdPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  549  				pPwrL = data_def[idxL].pwrPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  550  				pVpdR = data_def[idxR].vpdPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  551  				pPwrR = data_def[idxR].pwrPdg[i];
115277a3bc0683d Felix Fietkau 2010-12-12  552  			}
115277a3bc0683d Felix Fietkau 2010-12-12  553  
115277a3bc0683d Felix Fietkau 2010-12-12  554  			minPwrT4[i] = max(pPwrL[0], pPwrR[0]);
115277a3bc0683d Felix Fietkau 2010-12-12  555  
115277a3bc0683d Felix Fietkau 2010-12-12  556  			maxPwrT4[i] =
940cd2c12ebff68 Felix Fietkau 2010-12-12  557  				min(pPwrL[intercepts - 1],
940cd2c12ebff68 Felix Fietkau 2010-12-12  558  				    pPwrR[intercepts - 1]);
115277a3bc0683d Felix Fietkau 2010-12-12  559  
115277a3bc0683d Felix Fietkau 2010-12-12  560  
115277a3bc0683d Felix Fietkau 2010-12-12  561  			ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
115277a3bc0683d Felix Fietkau 2010-12-12  562  						pPwrL, pVpdL,
940cd2c12ebff68 Felix Fietkau 2010-12-12  563  						intercepts,
115277a3bc0683d Felix Fietkau 2010-12-12  564  						vpdTableL[i]);
115277a3bc0683d Felix Fietkau 2010-12-12  565  			ath9k_hw_fill_vpd_table(minPwrT4[i], maxPwrT4[i],
115277a3bc0683d Felix Fietkau 2010-12-12  566  						pPwrR, pVpdR,
940cd2c12ebff68 Felix Fietkau 2010-12-12  567  						intercepts,
115277a3bc0683d Felix Fietkau 2010-12-12  568  						vpdTableR[i]);
115277a3bc0683d Felix Fietkau 2010-12-12  569  
115277a3bc0683d Felix Fietkau 2010-12-12  570  			for (j = 0; j <= (maxPwrT4[i] - minPwrT4[i]) / 2; j++) {
115277a3bc0683d Felix Fietkau 2010-12-12  571  				vpdTableI[i][j] =
115277a3bc0683d Felix Fietkau 2010-12-12  572  					(u8)(ath9k_hw_interpolate((u16)
115277a3bc0683d Felix Fietkau 2010-12-12  573  					     FREQ2FBIN(centers.
115277a3bc0683d Felix Fietkau 2010-12-12  574  						       synth_center,
115277a3bc0683d Felix Fietkau 2010-12-12  575  						       IS_CHAN_2GHZ
115277a3bc0683d Felix Fietkau 2010-12-12  576  						       (chan)),
115277a3bc0683d Felix Fietkau 2010-12-12  577  					     bChans[idxL], bChans[idxR],
115277a3bc0683d Felix Fietkau 2010-12-12  578  					     vpdTableL[i][j], vpdTableR[i][j]));
115277a3bc0683d Felix Fietkau 2010-12-12  579  			}
115277a3bc0683d Felix Fietkau 2010-12-12  580  		}
115277a3bc0683d Felix Fietkau 2010-12-12  581  	}
115277a3bc0683d Felix Fietkau 2010-12-12  582  
115277a3bc0683d Felix Fietkau 2010-12-12  583  	k = 0;
115277a3bc0683d Felix Fietkau 2010-12-12  584  
115277a3bc0683d Felix Fietkau 2010-12-12  585  	for (i = 0; i < numXpdGains; i++) {
115277a3bc0683d Felix Fietkau 2010-12-12  586  		if (i == (numXpdGains - 1))
115277a3bc0683d Felix Fietkau 2010-12-12  587  			pPdGainBoundaries[i] =
115277a3bc0683d Felix Fietkau 2010-12-12  588  				(u16)(maxPwrT4[i] / 2);
115277a3bc0683d Felix Fietkau 2010-12-12  589  		else
115277a3bc0683d Felix Fietkau 2010-12-12  590  			pPdGainBoundaries[i] =
115277a3bc0683d Felix Fietkau 2010-12-12  591  				(u16)((maxPwrT4[i] + minPwrT4[i + 1]) / 4);
115277a3bc0683d Felix Fietkau 2010-12-12  592  
115277a3bc0683d Felix Fietkau 2010-12-12  593  		pPdGainBoundaries[i] =
115277a3bc0683d Felix Fietkau 2010-12-12  594  			min((u16)MAX_RATE_POWER, pPdGainBoundaries[i]);
115277a3bc0683d Felix Fietkau 2010-12-12  595  
115277a3bc0683d Felix Fietkau 2010-12-12  596  		minDelta = 0;
115277a3bc0683d Felix Fietkau 2010-12-12  597  
115277a3bc0683d Felix Fietkau 2010-12-12  598  		if (i == 0) {
115277a3bc0683d Felix Fietkau 2010-12-12  599  			if (AR_SREV_9280_20_OR_LATER(ah))
115277a3bc0683d Felix Fietkau 2010-12-12  600  				ss = (int16_t)(0 - (minPwrT4[i] / 2));
115277a3bc0683d Felix Fietkau 2010-12-12  601  			else
115277a3bc0683d Felix Fietkau 2010-12-12  602  				ss = 0;
115277a3bc0683d Felix Fietkau 2010-12-12  603  		} else {
115277a3bc0683d Felix Fietkau 2010-12-12  604  			ss = (int16_t)((pPdGainBoundaries[i - 1] -
115277a3bc0683d Felix Fietkau 2010-12-12  605  					(minPwrT4[i] / 2)) -
115277a3bc0683d Felix Fietkau 2010-12-12  606  				       tPdGainOverlap + 1 + minDelta);
115277a3bc0683d Felix Fietkau 2010-12-12  607  		}
115277a3bc0683d Felix Fietkau 2010-12-12  608  		vpdStep = (int16_t)(vpdTableI[i][1] - vpdTableI[i][0]);
115277a3bc0683d Felix Fietkau 2010-12-12  609  		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
115277a3bc0683d Felix Fietkau 2010-12-12  610  
115277a3bc0683d Felix Fietkau 2010-12-12  611  		while ((ss < 0) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
115277a3bc0683d Felix Fietkau 2010-12-12  612  			tmpVal = (int16_t)(vpdTableI[i][0] + ss * vpdStep);
115277a3bc0683d Felix Fietkau 2010-12-12  613  			pPDADCValues[k++] = (u8)((tmpVal < 0) ? 0 : tmpVal);
115277a3bc0683d Felix Fietkau 2010-12-12  614  			ss++;
115277a3bc0683d Felix Fietkau 2010-12-12  615  		}
115277a3bc0683d Felix Fietkau 2010-12-12  616  
115277a3bc0683d Felix Fietkau 2010-12-12  617  		sizeCurrVpdTable = (u8) ((maxPwrT4[i] - minPwrT4[i]) / 2 + 1);
115277a3bc0683d Felix Fietkau 2010-12-12  618  		tgtIndex = (u8)(pPdGainBoundaries[i] + tPdGainOverlap -
115277a3bc0683d Felix Fietkau 2010-12-12  619  				(minPwrT4[i] / 2));
115277a3bc0683d Felix Fietkau 2010-12-12  620  		maxIndex = (tgtIndex < sizeCurrVpdTable) ?
115277a3bc0683d Felix Fietkau 2010-12-12  621  			tgtIndex : sizeCurrVpdTable;
115277a3bc0683d Felix Fietkau 2010-12-12  622  
115277a3bc0683d Felix Fietkau 2010-12-12  623  		while ((ss < maxIndex) && (k < (AR5416_NUM_PDADC_VALUES - 1))) {
115277a3bc0683d Felix Fietkau 2010-12-12  624  			pPDADCValues[k++] = vpdTableI[i][ss++];
115277a3bc0683d Felix Fietkau 2010-12-12  625  		}
115277a3bc0683d Felix Fietkau 2010-12-12  626  
115277a3bc0683d Felix Fietkau 2010-12-12  627  		vpdStep = (int16_t)(vpdTableI[i][sizeCurrVpdTable - 1] -
115277a3bc0683d Felix Fietkau 2010-12-12  628  				    vpdTableI[i][sizeCurrVpdTable - 2]);
115277a3bc0683d Felix Fietkau 2010-12-12  629  		vpdStep = (int16_t)((vpdStep < 1) ? 1 : vpdStep);
115277a3bc0683d Felix Fietkau 2010-12-12  630  
115277a3bc0683d Felix Fietkau 2010-12-12  631  		if (tgtIndex >= maxIndex) {
115277a3bc0683d Felix Fietkau 2010-12-12  632  			while ((ss <= tgtIndex) &&
115277a3bc0683d Felix Fietkau 2010-12-12  633  			       (k < (AR5416_NUM_PDADC_VALUES - 1))) {
115277a3bc0683d Felix Fietkau 2010-12-12  634  				tmpVal = (int16_t)((vpdTableI[i][sizeCurrVpdTable - 1] +
115277a3bc0683d Felix Fietkau 2010-12-12  635  						    (ss - maxIndex + 1) * vpdStep));
115277a3bc0683d Felix Fietkau 2010-12-12  636  				pPDADCValues[k++] = (u8)((tmpVal > 255) ?
115277a3bc0683d Felix Fietkau 2010-12-12  637  							 255 : tmpVal);
115277a3bc0683d Felix Fietkau 2010-12-12  638  				ss++;
115277a3bc0683d Felix Fietkau 2010-12-12  639  			}
115277a3bc0683d Felix Fietkau 2010-12-12  640  		}
115277a3bc0683d Felix Fietkau 2010-12-12  641  	}
115277a3bc0683d Felix Fietkau 2010-12-12  642  
115277a3bc0683d Felix Fietkau 2010-12-12  643  	if (eeprom_4k)
115277a3bc0683d Felix Fietkau 2010-12-12  644  		pdgain_boundary_default = 58;
115277a3bc0683d Felix Fietkau 2010-12-12  645  	else
115277a3bc0683d Felix Fietkau 2010-12-12  646  		pdgain_boundary_default = pPdGainBoundaries[i - 1];
115277a3bc0683d Felix Fietkau 2010-12-12  647  
115277a3bc0683d Felix Fietkau 2010-12-12  648  	while (i < AR5416_PD_GAINS_IN_MASK) {
115277a3bc0683d Felix Fietkau 2010-12-12  649  		pPdGainBoundaries[i] = pdgain_boundary_default;
115277a3bc0683d Felix Fietkau 2010-12-12  650  		i++;
115277a3bc0683d Felix Fietkau 2010-12-12  651  	}
115277a3bc0683d Felix Fietkau 2010-12-12  652  
115277a3bc0683d Felix Fietkau 2010-12-12  653  	while (k < AR5416_NUM_PDADC_VALUES) {
115277a3bc0683d Felix Fietkau 2010-12-12  654  		pPDADCValues[k] = pPDADCValues[k - 1];
115277a3bc0683d Felix Fietkau 2010-12-12  655  		k++;
115277a3bc0683d Felix Fietkau 2010-12-12  656  	}
115277a3bc0683d Felix Fietkau 2010-12-12 @657  }
115277a3bc0683d Felix Fietkau 2010-12-12  658  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

