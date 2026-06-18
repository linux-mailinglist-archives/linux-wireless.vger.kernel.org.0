Return-Path: <linux-wireless+bounces-37882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Nk3A7+JM2rhDAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:01:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524D69DC64
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YdhS6lmb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37882-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37882-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C0C3036727
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429CF32B10E;
	Thu, 18 Jun 2026 06:01:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEED2C11E1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 06:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762476; cv=none; b=L/CfwMw5jP5f4ByyciPnx6jWtqdxCk4g34y6mvhzYfoNhz0rpjn4Yab3UYGPqx79jyDAH0zQJlbIF45+uYgdOsz/Ff4ZyKh5sb7H6sKlizPHpNcPXDQhzH6+l8t7CFLong+54phewwVr7QGKyIcN8OKYmikTqdyeszXWel7dOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762476; c=relaxed/simple;
	bh=RAsd8khCYqSW4I+iICC+jiMD6xMyMVzESx49f2X+uMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyi7uR5rAcwaBJpPhAZdMZYgC5+/LyDotHGJCBVJ+9la4O4XM0jEhkoqOivycIMaxeTiJgBPeVw3/tUmDG9lLW+jKXWRBqUiBBC6/FaG7lWwu/JgQJ7ULkH5IMRw0TrlC/8YBW0PIeih/daiTi7MXSeRPUW8OijPZWScyRvvObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdhS6lmb; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781762474; x=1813298474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RAsd8khCYqSW4I+iICC+jiMD6xMyMVzESx49f2X+uMo=;
  b=YdhS6lmbW69uYFez0HeknR6os7dw1FzoqfHIHCihcIu3BgaaCHbesG4n
   Un0NwjZgiDFTv+jdQ8Jl1Q19kW85aw5sONu/JlZbTHFsfwHxAQukJxm0K
   UvSv5gMOn0+Al4LXUoYx+Rb5VNlVnGhl4fNUEp4tvgXf8hjzFmPTk0elF
   rSFqfcHzHqwophlqaTiO0jt/z53r8Mv+8vIxl7cfMwT/iMRgIfAQl8r9+
   XkTDsJwU1misenqXfgn2komgKD+25VRCfirUIgeYVqNS+Y2dHuDUiP5dG
   z8rbyqpFS36eugLv5NlySQoD/uq98vGZen0zdM3ZjACx/BnyYKgK8NiLQ
   Q==;
X-CSE-ConnectionGUID: uEINXERzTDGixRT9MaKPwQ==
X-CSE-MsgGUID: ASb0S61STj67hmySAizhKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81572388"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="81572388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:01:13 -0700
X-CSE-ConnectionGUID: 9U34h6lwQU2aVS/IHyvd2w==
X-CSE-MsgGUID: MuWYTk+9TF+BTPX/TDMaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="286389922"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Jun 2026 23:01:11 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wa5oK-00000000VHa-3FLU;
	Thu, 18 Jun 2026 06:01:08 +0000
Date: Thu, 18 Jun 2026 14:00:46 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Wang <sean.wang@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Stella Liu <yu-ching.liu@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7925: support new WoW pattern TLV
Message-ID: <202606181323.heBYmqMQ-lkp@intel.com>
References: <20260615212137.477893-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615212137.477893-1-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37882-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:oe-kbuild-all@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,m:yu-ching.liu@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1524D69DC64

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Wang/wifi-mt76-mt7925-support-new-WoW-pattern-TLV/20260616-052424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260615212137.477893-1-sean.wang%40kernel.org
patch subject: [PATCH] wifi: mt76: mt7925: support new WoW pattern TLV
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260618/202606181323.heBYmqMQ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260618/202606181323.heBYmqMQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606181323.heBYmqMQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7925/mcu.c:15:13: warning: 'mt7925_mcu_wow_pattern_old_tlv' defined but not used [-Wunused-function]
      15 | static bool mt7925_mcu_wow_pattern_old_tlv(struct mt76_dev *dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mt7925_mcu_wow_pattern_old_tlv +15 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c

    14	
  > 15	static bool mt7925_mcu_wow_pattern_old_tlv(struct mt76_dev *dev)
    16	{
    17		const char *fw_version = dev->hw->wiphy->fw_version;
    18		const char *build_date = strrchr(fw_version, '-');
    19	
    20		if (!is_mt7925(dev))
    21			return false;
    22	
    23		if (!build_date)
    24			return false;
    25	
    26		build_date++;
    27	
    28		return strncmp(build_date, MT7925_WOW_PATTERN_NEW_FW_DATE,
    29			       strlen(MT7925_WOW_PATTERN_NEW_FW_DATE)) < 0;
    30	}
    31	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

