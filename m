Return-Path: <linux-wireless+bounces-17756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CDA16D95
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D302C3A2987
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887451E1C36;
	Mon, 20 Jan 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXUheAY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463961E1C16
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380665; cv=none; b=XoIArw6/iLi+7Z8CzBBX4P8cZpfBO0wLZPsDLHL8xFZTh1kbiFZ+E+K12thIj7QVYIp8ubTD/x9YUtAhyuxQ/3DoE4rG2mq8ENIdSge8GSY6OyGYHKpyXQmtDDojgs6Uqf57HPbWUxlYhudfB/aTDX8GXMzUqGAmyso6O1bTjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380665; c=relaxed/simple;
	bh=DsaHPxT3RlV75KUJfkBw0FJXcFsw//d6mKtWO8gQ6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co9yWW9lCKkKpm3QE9cgS56eZV2A5A89qZfKjxix18Nvg4AMYQVeFo7G0f1YGgeV28niwFKo1IaYp/DVA0n26LDvXe4cE9/KIN26JzUmLX3c+O42OxiijIPcmoDUv7Tu+C181JZQM8YKYgTuwL0iqr9MEtDTdhQk/XPLL98icgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXUheAY7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737380663; x=1768916663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DsaHPxT3RlV75KUJfkBw0FJXcFsw//d6mKtWO8gQ6t8=;
  b=NXUheAY74TMG3vlIkePAI8sEU5aeRd3vzJDZcGzJhw8aEyophI3KTSaI
   1ElWsoQ0armqfqMroOqyPMpgT6CDVGrCtsIv+YgHz1NrYyG9w9dBj/tNs
   xVIffCnfXtDN5BEF1/62Xc12h4zXgoMZCrgBpVVjyY4qPalDk772L2iGC
   QX74ZCsGbKgHJHk8bOdnIgRSQkizlenYXAW/vcNQMAH2VAaQg6hENzbbc
   tjaSvlMxpt+LgxAgnsAfwM04e+UPfZ4r3m1lTZGLtc6JpNz1QCNTqQyOI
   X6t2OUQTy6GYiYNJgFptC25tIyh8tkpsXXEUyZ6LAlBVrqX0K+/Ykg5r6
   Q==;
X-CSE-ConnectionGUID: ZFbFf3plThKdfgRf6RtyGQ==
X-CSE-MsgGUID: 8KkNcl81Tc2x6rAm8w7FqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48267308"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="48267308"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 05:44:23 -0800
X-CSE-ConnectionGUID: kyDDcgWbTXakzqHbRFLmqg==
X-CSE-MsgGUID: 0HG9aAZaSpqIMvXMs9imeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106354552"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Jan 2025 05:44:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZs4g-000Wap-0b;
	Mon, 20 Jan 2025 13:44:18 +0000
Date: Mon, 20 Jan 2025 21:43:27 +0800
From: kernel test robot <lkp@intel.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
Subject: Re: [PATCH v3 10/10] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
Message-ID: <202501202128.ZGQrxylz-lkp@intel.com>
References: <20250119135751.2221902-11-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119135751.2221902-11-quic_periyasa@quicinc.com>

Hi Karthikeyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on e7ef944b3e2c31b608800925e784f67596375770]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthikeyan-Periyasamy/wifi-ath12k-Add-HAL_PHYRX_GENERIC_U_SIG-TLV-parsing-support/20250119-220042
base:   e7ef944b3e2c31b608800925e784f67596375770
patch link:    https://lore.kernel.org/r/20250119135751.2221902-11-quic_periyasa%40quicinc.com
patch subject: [PATCH v3 10/10] wifi: ath12k: Add peer extended Rx statistics debugfs support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250120/202501202128.ZGQrxylz-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250120/202501202128.ZGQrxylz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501202128.ZGQrxylz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath12k/debugfs_sta.c:8:
   In file included from drivers/net/wireless/ath/ath12k/debugfs_sta.h:9:
   In file included from include/net/mac80211.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/debugfs_sta.c:80:32: warning: arithmetic between different enumeration types ('enum hal_rx_bw' and 'enum hal_rx_gi') [-Wenum-enum-conversion]
      80 |         for (i = 0; i < HAL_RX_BW_MAX * HAL_RX_GI_MAX * HAL_RX_MAX_NSS; i++) {
         |                         ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath12k/debugfs_sta.c:162:3: error: cannot jump from this goto statement to its label
     162 |                 goto out;
         |                 ^
   drivers/net/wireless/ath/ath12k/debugfs_sta.c:167:6: note: jump bypasses initialization of variable with __attribute__((cleanup))
     167 |         u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
         |             ^
   drivers/net/wireless/ath/ath12k/debugfs_sta.c:156:3: error: cannot jump from this goto statement to its label
     156 |                 goto out;
         |                 ^
   drivers/net/wireless/ath/ath12k/debugfs_sta.c:167:6: note: jump bypasses initialization of variable with __attribute__((cleanup))
     167 |         u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
         |             ^
   4 warnings and 2 errors generated.


vim +162 drivers/net/wireless/ath/ath12k/debugfs_sta.c

    14	
    15	static
    16	u32 ath12k_dbg_sta_dump_rate_stats(u8 *buf, u32 offset, const int size,
    17					   bool he_rates_avail,
    18					   const struct ath12k_rx_peer_rate_stats *stats)
    19	{
    20		static const char *legacy_rate_str[HAL_RX_MAX_NUM_LEGACY_RATES] = {
    21						"1 Mbps", "2 Mbps", "5.5 Mbps", "6 Mbps",
    22						"9 Mbps", "11 Mbps", "12 Mbps", "18 Mbps",
    23						"24 Mbps", "36 Mbps", "48 Mbps", "54 Mbps"};
    24		int mcs = 0, bw = 0, nss = 0, gi = 0, bw_num = 0;
    25		u32 i, len = offset;
    26		bool found;
    27	
    28		len += scnprintf(buf + len, size - len, "\nEHT stats:\n");
    29		for (i = 0; i <= HAL_RX_MAX_MCS_BE; i++)
    30			len += scnprintf(buf + len, size - len,
    31					   "MCS %d: %llu%s", i, stats->be_mcs_count[i],
    32					   (i + 1) % 8 ? "\t" : "\n");
    33	
    34		len += scnprintf(buf + len, size - len, "\nHE stats:\n");
    35		for (i = 0; i <= HAL_RX_MAX_MCS_HE; i++)
    36			len += scnprintf(buf + len, size - len,
    37					   "MCS %d: %llu%s", i, stats->he_mcs_count[i],
    38					   (i + 1) % 6 ? "\t" : "\n");
    39	
    40		len += scnprintf(buf + len, size - len, "\nVHT stats:\n");
    41		for (i = 0; i <= HAL_RX_MAX_MCS_VHT; i++)
    42			len += scnprintf(buf + len, size - len,
    43					   "MCS %d: %llu%s", i, stats->vht_mcs_count[i],
    44					   (i + 1) % 5 ? "\t" : "\n");
    45	
    46		len += scnprintf(buf + len, size - len, "\nHT stats:\n");
    47		for (i = 0; i <= HAL_RX_MAX_MCS_HT; i++)
    48			len += scnprintf(buf + len, size - len,
    49					   "MCS %d: %llu%s", i, stats->ht_mcs_count[i],
    50					   (i + 1) % 8 ? "\t" : "\n");
    51	
    52		len += scnprintf(buf + len, size - len, "\nLegacy stats:\n");
    53		for (i = 0; i < HAL_RX_MAX_NUM_LEGACY_RATES; i++)
    54			len += scnprintf(buf + len, size - len,
    55					   "%s: %llu%s", legacy_rate_str[i],
    56					   stats->legacy_count[i],
    57					   (i + 1) % 4 ? "\t" : "\n");
    58	
    59		len += scnprintf(buf + len, size - len, "\nNSS stats:\n");
    60		for (i = 0; i < HAL_RX_MAX_NSS; i++)
    61			len += scnprintf(buf + len, size - len,
    62					   "%dx%d: %llu ", i + 1, i + 1,
    63					   stats->nss_count[i]);
    64	
    65		len += scnprintf(buf + len, size - len,
    66				  "\n\nGI: 0.8 us %llu 0.4 us %llu 1.6 us %llu 3.2 us %llu\n",
    67				  stats->gi_count[0],
    68				  stats->gi_count[1],
    69				  stats->gi_count[2],
    70				  stats->gi_count[3]);
    71	
    72		len += scnprintf(buf + len, size - len,
    73				   "BW: 20 MHz %llu 40 MHz %llu 80 MHz %llu 160 MHz %llu 320 MHz %llu\n",
    74				   stats->bw_count[0],
    75				   stats->bw_count[1],
    76				   stats->bw_count[2],
    77				   stats->bw_count[3],
    78				   stats->bw_count[4]);
    79	
  > 80		for (i = 0; i < HAL_RX_BW_MAX * HAL_RX_GI_MAX * HAL_RX_MAX_NSS; i++) {
    81			found = false;
    82	
    83			for (mcs = 0; mcs <= HAL_RX_MAX_MCS_HT; mcs++) {
    84				if (stats->rx_rate[bw][gi][nss][mcs]) {
    85					found = true;
    86					break;
    87				}
    88			}
    89	
    90			if (!found)
    91				goto skip_report;
    92	
    93			switch (bw) {
    94			case HAL_RX_BW_20MHZ:
    95				bw_num = 20;
    96				break;
    97			case HAL_RX_BW_40MHZ:
    98				bw_num = 40;
    99				break;
   100			case HAL_RX_BW_80MHZ:
   101				bw_num = 80;
   102				break;
   103			case HAL_RX_BW_160MHZ:
   104				bw_num = 160;
   105				break;
   106			case HAL_RX_BW_320MHZ:
   107				bw_num = 320;
   108				break;
   109			}
   110	
   111			len += scnprintf(buf + len, size - len, "\n%d Mhz gi %d us %dx%d : ",
   112					 bw_num, gi, nss + 1, nss + 1);
   113	
   114			for (mcs = 0; mcs <= HAL_RX_MAX_MCS_HT; mcs++) {
   115				if (stats->rx_rate[bw][gi][nss][mcs])
   116					len += scnprintf(buf + len, size - len,
   117							 " %d:%llu", mcs,
   118							 stats->rx_rate[bw][gi][nss][mcs]);
   119			}
   120	
   121	skip_report:
   122			if (nss++ >= HAL_RX_MAX_NSS - 1) {
   123				nss = 0;
   124				if (gi++ >= HAL_RX_GI_MAX - 1) {
   125					gi = 0;
   126					if (bw < HAL_RX_BW_MAX - 1)
   127						bw++;
   128				}
   129			}
   130		}
   131	
   132		len += scnprintf(buf + len, size - len, "\n");
   133	
   134		return len - offset;
   135	}
   136	
   137	static ssize_t ath12k_dbg_sta_dump_rx_stats(struct file *file,
   138						    char __user *user_buf,
   139						    size_t count, loff_t *ppos)
   140	{
   141		struct ieee80211_link_sta *link_sta = file->private_data;
   142		struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
   143		const int size = ATH12K_STA_RX_STATS_BUF_SIZE;
   144		struct ath12k_hw *ah = ahsta->ahvif->ah;
   145		struct ath12k_rx_peer_stats *rx_stats;
   146		struct ath12k_link_sta *arsta;
   147		u8 link_id = link_sta->link_id;
   148		int len = 0, i, ret = 0;
   149		bool he_rates_avail;
   150		struct ath12k *ar;
   151	
   152		wiphy_lock(ah->hw->wiphy);
   153	
   154		if (!(BIT(link_id) & ahsta->links_map)) {
   155			ret = -ENOENT;
   156			goto out;
   157		}
   158	
   159		arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
   160		if (!arsta || !arsta->arvif->ar) {
   161			ret = -ENOENT;
 > 162			goto out;
   163		}
   164	
   165		ar = arsta->arvif->ar;
   166	
   167		u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
   168		if (!buf) {
   169			ret = -ENOENT;
   170			goto out;
   171		}
   172	
   173		spin_lock_bh(&ar->ab->base_lock);
   174	
   175		rx_stats = arsta->rx_stats;
   176		if (!rx_stats) {
   177			ret = -ENOENT;
   178			goto unlock;
   179		}
   180	
   181		len += scnprintf(buf + len, size - len, "RX peer stats:\n\n");
   182		len += scnprintf(buf + len, size - len, "Num of MSDUs: %llu\n",
   183				 rx_stats->num_msdu);
   184		len += scnprintf(buf + len, size - len, "Num of MSDUs with TCP L4: %llu\n",
   185				 rx_stats->tcp_msdu_count);
   186		len += scnprintf(buf + len, size - len, "Num of MSDUs with UDP L4: %llu\n",
   187				 rx_stats->udp_msdu_count);
   188		len += scnprintf(buf + len, size - len, "Num of other MSDUs: %llu\n",
   189				 rx_stats->other_msdu_count);
   190		len += scnprintf(buf + len, size - len, "Num of MSDUs part of AMPDU: %llu\n",
   191				 rx_stats->ampdu_msdu_count);
   192		len += scnprintf(buf + len, size - len, "Num of MSDUs not part of AMPDU: %llu\n",
   193				 rx_stats->non_ampdu_msdu_count);
   194		len += scnprintf(buf + len, size - len, "Num of MSDUs using STBC: %llu\n",
   195				 rx_stats->stbc_count);
   196		len += scnprintf(buf + len, size - len, "Num of MSDUs beamformed: %llu\n",
   197				 rx_stats->beamformed_count);
   198		len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS ok: %llu\n",
   199				 rx_stats->num_mpdu_fcs_ok);
   200		len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS error: %llu\n",
   201				 rx_stats->num_mpdu_fcs_err);
   202	
   203		he_rates_avail = (rx_stats->pream_cnt[HAL_RX_PREAMBLE_11AX] > 1) ? true : false;
   204	
   205		len += scnprintf(buf + len, size - len,
   206				 "preamble: 11A %llu 11B %llu 11N %llu 11AC %llu 11AX %llu 11BE %llu\n",
   207				 rx_stats->pream_cnt[0], rx_stats->pream_cnt[1],
   208				 rx_stats->pream_cnt[2], rx_stats->pream_cnt[3],
   209				 rx_stats->pream_cnt[4], rx_stats->pream_cnt[6]);
   210		len += scnprintf(buf + len, size - len,
   211				 "reception type: SU %llu MU_MIMO %llu MU_OFDMA %llu MU_OFDMA_MIMO %llu\n",
   212				 rx_stats->reception_type[0], rx_stats->reception_type[1],
   213				 rx_stats->reception_type[2], rx_stats->reception_type[3]);
   214	
   215		len += scnprintf(buf + len, size - len, "TID(0-15) Legacy TID(16):");
   216		for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
   217			len += scnprintf(buf + len, size - len, "%llu ", rx_stats->tid_count[i]);
   218	
   219		len += scnprintf(buf + len, size - len, "\nRX Duration:%llu\n",
   220				 rx_stats->rx_duration);
   221	
   222		len += scnprintf(buf + len, size - len,
   223				 "\nDCM: %llu\nRU26:  %llu\nRU52:  %llu\nRU106: %llu\nRU242: %llu\nRU484: %llu\nRU996: %llu\n",
   224				 rx_stats->dcm_count, rx_stats->ru_alloc_cnt[0],
   225				 rx_stats->ru_alloc_cnt[1], rx_stats->ru_alloc_cnt[2],
   226				 rx_stats->ru_alloc_cnt[3], rx_stats->ru_alloc_cnt[4],
   227				 rx_stats->ru_alloc_cnt[5]);
   228	
   229		len += scnprintf(buf + len, size - len, "\nRX success packet stats:\n");
   230		len += ath12k_dbg_sta_dump_rate_stats(buf, len, size, he_rates_avail,
   231						      &rx_stats->pkt_stats);
   232	
   233		len += scnprintf(buf + len, size - len, "\n");
   234	
   235		len += scnprintf(buf + len, size - len, "\nRX success byte stats:\n");
   236		len += ath12k_dbg_sta_dump_rate_stats(buf, len, size, he_rates_avail,
   237						      &rx_stats->byte_stats);
   238	
   239	unlock:
   240		spin_unlock_bh(&ar->ab->base_lock);
   241	
   242		if (len)
   243			ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
   244	out:
   245		wiphy_unlock(ah->hw->wiphy);
   246		return ret;
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

