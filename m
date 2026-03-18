Return-Path: <linux-wireless+bounces-33396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCZ2AP6jummyZwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 14:09:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD12BBF46
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB68730B0120
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B933D75C9;
	Wed, 18 Mar 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAoTjhRk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF03D6CD1;
	Wed, 18 Mar 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839112; cv=none; b=D6DdVdRIQLUik5zRHJAOeTJwnJDZ4VBcyIKeDHTEJAWNaz7qnO9nD1KgmOUrMp1Dy6e5vLNb1D7f8DCCeUYepYXZYM7kdKHvYKoN4hpfytxdQkSN/HP7njQS7dDvHbsUrBIpOIe2sCL+NYFds2f8I/V0PsCGGlQsHQE2OpJoojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839112; c=relaxed/simple;
	bh=XMvnWCmnbT32GB5J+aiF5VT++RUQAquxivEn94Uc44c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF6tHvrlCiJucE8d+2/f6An28OjgDGG77xkRkbf119QFGF94chsa6dVpJ24rAiG4+AG4F1+B+dcwyRQcZ68tOPVV/QwkdmCbPHDQLjmFb+dwsteonBbf7Ff/Y7uCEYKwBOth1ed72vUjbd8Tcffp444M/drgXBES4/VH7w2XyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAoTjhRk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773839110; x=1805375110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XMvnWCmnbT32GB5J+aiF5VT++RUQAquxivEn94Uc44c=;
  b=NAoTjhRknX9uMTA6DyUy7vMmuUeyFbWrHfrmgHJR8v108yIes1zoKMmr
   j/LwVFm+0len/eGu4d6TATuXzf1uettUlTkcoxqvDn7aG6xLcoj6NP0gP
   Ls0qTOgLAEnkk3T4nvlp7cWbAcI6WHx+Ta3IJwZsqb9IbQlOYEkg3r7Pm
   tZwrAm+afRIrK1RMM02o+xIDzJdHFXCEK7oH3DVfIV6PgTyvFLUJ6Wl3I
   0WtyjRUQ72TMN5kb0vR7ozIn4ua4E4nw25gdSsBvf9g/Izchx0mKiF+JA
   8BfUJJnsDN3yHn6Fdks0PZM+82ZTw3G4O0wsaS/pCSFP+GrimmsUE4gBt
   g==;
X-CSE-ConnectionGUID: cEend8QVQumolEAA6tbJog==
X-CSE-MsgGUID: tO7H3xxCTvCdSDX1Iwxhgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85521084"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85521084"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:05:02 -0700
X-CSE-ConnectionGUID: UxWjOm3VSleVi7j7C6wILQ==
X-CSE-MsgGUID: SEUTnkivQgal9ulVhY6sBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222833520"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Mar 2026 06:04:59 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2qa0-000000002vr-2pO1;
	Wed, 18 Mar 2026 13:04:56 +0000
Date: Wed, 18 Mar 2026 21:04:41 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Adri=E1n_Garc=EDa?= Casado <adriangarciacasado42@gmail.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?iso-8859-1?Q?Adri=E1n_Garc=EDa?= Casado <adriangarciacasado42@gmail.com>
Subject: Re: [PATCH v4] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
Message-ID: <202603182147.ECKLrJRf-lkp@intel.com>
References: <20260317193252.13763-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317193252.13763-1-adriangarciacasado42@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33396-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 6CCD12BBF46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adrián,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main rust/rust-next linus/master v7.0-rc4 next-20260317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adri-n-Garc-a-Casado/wifi-iwlwifi-pcie-optimize-MSI-X-interrupt-affinity/20260318-081834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260317193252.13763-1-adriangarciacasado42%40gmail.com
patch subject: [PATCH v4] wifi: iwlwifi: pcie: optimize MSI-X interrupt affinity
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260318/202603182147.ECKLrJRf-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603182147.ECKLrJRf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603182147.ECKLrJRf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c: In function 'iwl_pcie_irq_set_affinity':
>> drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c:1675:37: warning: unused variable 'offset' [-Wunused-variable]
    1675 |         int iter_rx_q, i, ret, cpu, offset, last_cpu;
         |                                     ^~~~~~


vim +/offset +1675 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c

  1670	
  1671	static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
  1672					      struct iwl_trans_info *info)
  1673	{
  1674	#if defined(CONFIG_SMP)
> 1675		int iter_rx_q, i, ret, cpu, offset, last_cpu;
  1676		struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  1677	
  1678		i = trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 0 : 1;
  1679		iter_rx_q = info->num_rxqs - 1 + i;
  1680		last_cpu = -1;
  1681		for (; i < iter_rx_q ; i++) {
  1682			/*
  1683			 * Balanced distribution: skip CPU0 for high-rate RSS queues
  1684			 * to avoid contention with system housekeeping.
  1685			 */
  1686			cpu = cpumask_next(last_cpu, cpu_online_mask);
  1687			if (cpu >= nr_cpu_ids)
  1688				cpu = cpumask_first(cpu_online_mask);
  1689	
  1690			if (cpu == 0 && num_online_cpus() > 1) {
  1691				cpu = cpumask_next(0, cpu_online_mask);
  1692				if (cpu >= nr_cpu_ids)
  1693					cpu = cpumask_first(cpu_online_mask);
  1694			}
  1695			last_cpu = cpu;
  1696	
  1697			cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
  1698			ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
  1699						    &trans_pcie->affinity_mask[i]);
  1700			if (ret)
  1701				IWL_ERR(trans_pcie->trans,
  1702					"Failed to set affinity mask for IRQ %d\n",
  1703					trans_pcie->msix_entries[i].vector);
  1704		}
  1705	#endif
  1706	}
  1707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

