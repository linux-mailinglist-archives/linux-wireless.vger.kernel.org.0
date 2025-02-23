Return-Path: <linux-wireless+bounces-19339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E97A40C8E
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Feb 2025 03:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46511189F528
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Feb 2025 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E51FDA;
	Sun, 23 Feb 2025 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beNW+QTp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1313FC08
	for <linux-wireless@vger.kernel.org>; Sun, 23 Feb 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740277709; cv=none; b=PEyPW3xlvOvm8+Qz6+M3V3ElP6G2/HKKtPSZOVYYAapv7pQO4SyNOCJO44u/9/QLwUHnE47d49Njoak0mMtk3CSP44AyqQE2Pb9CA0q/R0oVe8pM9S18COFpPvOS3Upge7Bz57EsXCOFSpJQ20WafuSDi1gQNg7HQBBadTU/Bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740277709; c=relaxed/simple;
	bh=u6oSsqRbLvRGRbt/R4ec7n7Himb8x7z/KiYZxAR9YTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpnGteliNQpj5LRSoFCnzCbguqQ9C3QcP4VETRpWuiK75g/kbJCOcq34MhF3ECLEcJ4szv8M/0iTLKFfloLFfk+U7hYjzyk8OpFacavmAlShiLwSr4iMazLWd3Gq77kpU08jfXRDIxL2nCz8DcZOBzorA/WQi/dJ7Fy3AWReodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beNW+QTp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740277708; x=1771813708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6oSsqRbLvRGRbt/R4ec7n7Himb8x7z/KiYZxAR9YTM=;
  b=beNW+QTpeb3uOJzUXlHPZ3GHVSwjfTqQxEl4vrESkD1PPuOgf8nlmBTR
   4As5bCKVExuZ3DP5JmTwn9pRcJTNPZKi8lsvAV8bv5w44ashxTa+akX71
   mGltpiMp4gcUrdMuR1wmo11MRwGblpNvMQaL1Pf+2QmsZgaST4em+EShM
   2iLIh3A2TChvASMe1i5VHcAcZAuldwy8mOpLEn8Vij3Qytw31KcTzDRka
   q+/BuZAQ2vf5vi+g9x/I+acXBEYL6JMIufwcUmu9arzivyIS1GPGyIV9C
   CN4gnPMTym/fyECbAMcopS1UauB48BXzbYwUeWPr8nhGT8WxNLr57B86q
   g==;
X-CSE-ConnectionGUID: M/fakUMFReGBThTI9+Uvzw==
X-CSE-MsgGUID: Qiv1apiSSRmnI7C9sb5jig==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52490046"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52490046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 18:28:26 -0800
X-CSE-ConnectionGUID: AfV/qSZVTwCJVa6AY56LJQ==
X-CSE-MsgGUID: fT7Eu9vBTOKc4WWQjtWDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119842392"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Feb 2025 18:28:25 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm1jB-000747-2j;
	Sun, 23 Feb 2025 02:28:21 +0000
Date: Sun, 23 Feb 2025 10:27:48 +0800
From: kernel test robot <lkp@intel.com>
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
	Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH v2 3/5] wifi: ath12k: add EHT support for TX rate
Message-ID: <202502231023.vzEGxJWz-lkp@intel.com>
References: <20250213173206.1665731-4-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213173206.1665731-4-quic_sarishar@quicinc.com>

Hi Sarika,

kernel test robot noticed the following build errors:

[auto build test ERROR on 704a2d7237043317ed1b0f8a08203e9ddde70097]

url:    https://github.com/intel-lab-lkp/linux/commits/Sarika-Sharma/wifi-mac80211-correct-RX-stats-packet-increment-for-multi-link/20250214-014020
base:   704a2d7237043317ed1b0f8a08203e9ddde70097
patch link:    https://lore.kernel.org/r/20250213173206.1665731-4-quic_sarishar%40quicinc.com
patch subject: [PATCH v2 3/5] wifi: ath12k: add EHT support for TX rate
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250223/202502231023.vzEGxJWz-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231023.vzEGxJWz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231023.vzEGxJWz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/dp_rx.c:1488:26: error: call to undeclared function 'ath12k_eht_gi_to_nl80211_eht_gi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   arsta->txrate.eht_gi = ath12k_eht_gi_to_nl80211_eht_gi(sgi);
                                          ^
   drivers/net/wireless/ath/ath12k/dp_rx.c:1364:24: warning: variable 'sta' set but not used [-Wunused-but-set-variable]
           struct ieee80211_sta *sta;
                                 ^
   1 warning and 1 error generated.


vim +/ath12k_eht_gi_to_nl80211_eht_gi +1488 drivers/net/wireless/ath/ath12k/dp_rx.c

  1357	
  1358	static void
  1359	ath12k_update_per_peer_tx_stats(struct ath12k *ar,
  1360					struct htt_ppdu_stats *ppdu_stats, u8 user)
  1361	{
  1362		struct ath12k_base *ab = ar->ab;
  1363		struct ath12k_peer *peer;
  1364		struct ieee80211_sta *sta;
  1365		struct ath12k_link_sta *arsta;
  1366		struct htt_ppdu_stats_user_rate *user_rate;
  1367		struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
  1368		struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
  1369		struct htt_ppdu_stats_common *common = &ppdu_stats->common;
  1370		int ret;
  1371		u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
  1372		u32 v, succ_bytes = 0;
  1373		u16 tones, rate = 0, succ_pkts = 0;
  1374		u32 tx_duration = 0;
  1375		u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
  1376		bool is_ampdu = false;
  1377	
  1378		if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
  1379			return;
  1380	
  1381		if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON))
  1382			is_ampdu =
  1383				HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
  1384	
  1385		if (usr_stats->tlv_flags &
  1386		    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
  1387			succ_bytes = le32_to_cpu(usr_stats->ack_ba.success_bytes);
  1388			succ_pkts = le32_get_bits(usr_stats->ack_ba.info,
  1389						  HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M);
  1390			tid = le32_get_bits(usr_stats->ack_ba.info,
  1391					    HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM);
  1392		}
  1393	
  1394		if (common->fes_duration_us)
  1395			tx_duration = le32_to_cpu(common->fes_duration_us);
  1396	
  1397		user_rate = &usr_stats->rate;
  1398		flags = HTT_USR_RATE_PREAMBLE(user_rate->rate_flags);
  1399		bw = HTT_USR_RATE_BW(user_rate->rate_flags) - 2;
  1400		nss = HTT_USR_RATE_NSS(user_rate->rate_flags) + 1;
  1401		mcs = HTT_USR_RATE_MCS(user_rate->rate_flags);
  1402		sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
  1403		dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
  1404	
  1405		/* Note: If host configured fixed rates and in some other special
  1406		 * cases, the broadcast/management frames are sent in different rates.
  1407		 * Firmware rate's control to be skipped for this?
  1408		 */
  1409	
  1410		if (flags == WMI_RATE_PREAMBLE_HE && mcs > ATH12K_HE_MCS_MAX) {
  1411			ath12k_warn(ab, "Invalid HE mcs %d peer stats",  mcs);
  1412			return;
  1413		}
  1414	
  1415		if (flags == WMI_RATE_PREAMBLE_VHT && mcs > ATH12K_VHT_MCS_MAX) {
  1416			ath12k_warn(ab, "Invalid VHT mcs %d peer stats",  mcs);
  1417			return;
  1418		}
  1419	
  1420		if (flags == WMI_RATE_PREAMBLE_HT && (mcs > ATH12K_HT_MCS_MAX || nss < 1)) {
  1421			ath12k_warn(ab, "Invalid HT mcs %d nss %d peer stats",
  1422				    mcs, nss);
  1423			return;
  1424		}
  1425	
  1426		if (flags == WMI_RATE_PREAMBLE_CCK || flags == WMI_RATE_PREAMBLE_OFDM) {
  1427			ret = ath12k_mac_hw_ratecode_to_legacy_rate(mcs,
  1428								    flags,
  1429								    &rate_idx,
  1430								    &rate);
  1431			if (ret < 0)
  1432				return;
  1433		}
  1434	
  1435		rcu_read_lock();
  1436		spin_lock_bh(&ab->base_lock);
  1437		peer = ath12k_peer_find_by_id(ab, usr_stats->peer_id);
  1438	
  1439		if (!peer || !peer->sta) {
  1440			spin_unlock_bh(&ab->base_lock);
  1441			rcu_read_unlock();
  1442			return;
  1443		}
  1444	
  1445		sta = peer->sta;
  1446		arsta = ath12k_peer_get_link_sta(ab, peer);
  1447		if (!arsta) {
  1448			spin_unlock_bh(&ab->base_lock);
  1449			rcu_read_unlock();
  1450			return;
  1451		}
  1452	
  1453		memset(&arsta->txrate, 0, sizeof(arsta->txrate));
  1454	
  1455		switch (flags) {
  1456		case WMI_RATE_PREAMBLE_OFDM:
  1457			arsta->txrate.legacy = rate;
  1458			break;
  1459		case WMI_RATE_PREAMBLE_CCK:
  1460			arsta->txrate.legacy = rate;
  1461			break;
  1462		case WMI_RATE_PREAMBLE_HT:
  1463			arsta->txrate.mcs = mcs + 8 * (nss - 1);
  1464			arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
  1465			if (sgi)
  1466				arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
  1467			break;
  1468		case WMI_RATE_PREAMBLE_VHT:
  1469			arsta->txrate.mcs = mcs;
  1470			arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
  1471			if (sgi)
  1472				arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
  1473			break;
  1474		case WMI_RATE_PREAMBLE_HE:
  1475			arsta->txrate.mcs = mcs;
  1476			arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
  1477			arsta->txrate.he_dcm = dcm;
  1478			arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
  1479			tones = le16_to_cpu(user_rate->ru_end) -
  1480				le16_to_cpu(user_rate->ru_start) + 1;
  1481			v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
  1482			arsta->txrate.he_ru_alloc = v;
  1483			break;
  1484		case WMI_RATE_PREAMBLE_EHT:
  1485			arsta->txrate.mcs = mcs;
  1486			arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
  1487			arsta->txrate.he_dcm = dcm;
> 1488			arsta->txrate.eht_gi = ath12k_eht_gi_to_nl80211_eht_gi(sgi);
  1489			tones = le16_to_cpu(user_rate->ru_end) -
  1490				le16_to_cpu(user_rate->ru_start) + 1;
  1491			v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
  1492			arsta->txrate.eht_ru_alloc = v;
  1493			break;
  1494		}
  1495	
  1496		arsta->txrate.nss = nss;
  1497		arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
  1498		arsta->tx_duration += tx_duration;
  1499		memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
  1500	
  1501		/* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
  1502		 * So skip peer stats update for mgmt packets.
  1503		 */
  1504		if (tid < HTT_PPDU_STATS_NON_QOS_TID) {
  1505			memset(peer_stats, 0, sizeof(*peer_stats));
  1506			peer_stats->succ_pkts = succ_pkts;
  1507			peer_stats->succ_bytes = succ_bytes;
  1508			peer_stats->is_ampdu = is_ampdu;
  1509			peer_stats->duration = tx_duration;
  1510			peer_stats->ba_fails =
  1511				HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
  1512				HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
  1513		}
  1514	
  1515		spin_unlock_bh(&ab->base_lock);
  1516		rcu_read_unlock();
  1517	}
  1518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

