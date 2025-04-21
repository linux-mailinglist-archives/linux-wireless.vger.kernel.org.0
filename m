Return-Path: <linux-wireless+bounces-21795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E89A95517
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A033AF561
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F7171CD;
	Mon, 21 Apr 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecYvkpwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317D12F399
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255810; cv=none; b=m26iMF4pyoN7yrR2b/WwQd05AcW8YbAfNO2jTD44C7BJPTHGVdGUD2ryGW1SWnqXwxNiALYndNAeAmbiQXRbpWSH88V1I/OyJ5WRk0v/GZ98AEA3fpFvGW2+4htDzb5p76zoIc5iD7WvK5yduA7oP3HrlwGTQMAGR5ZIjebjQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255810; c=relaxed/simple;
	bh=odhzicsI6KC60d7dd4UaLdO+P9vRgJvPrU6d7Be9wQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQm1Do/RDDqlvKaHFdqcXRF7mouc86Motmo7+jsM2jv+QJDZKfoxw5ztjFKUEVE4kx/IYYQbhTDKgtGEVllZzO2ik3tf66q3HV+3nwxSlc4ZZCSLu/GAsW18wTq3Uef4GXs+C1rftmH31t0JxfK738z5JLo0dHOtv+QF1NFlHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecYvkpwR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745255808; x=1776791808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odhzicsI6KC60d7dd4UaLdO+P9vRgJvPrU6d7Be9wQc=;
  b=ecYvkpwRh7PVroF2578goP2wZxGo4/qYLxMhQuYoBCT+/O19Br6uQ0kh
   WXKnm6KbF+zcjSy+xG4rp6DmotIrTUDQKI/sW+BFu4VtWS5vYhqZuvCpg
   3jkQ2qw78sw9Z5uzqxXLE1w/YwN9GYPAMvL2ZhdHfLMQ74V6wyQQj5omB
   cb+LMSNHSrJuLPjJkgZ2sQvcC/CZJkzQw/n+4OmrCyMs5m8k/csZ93Hsi
   HMD6JvEch5QB0wZbPFtIyrvwUd8ut+FEYZm++f5Y3JonIBD25wDCHD3Uc
   nMb55SmHT5IxrJS6qO+Iaj52U7Rhz1TQQ3O3tVFL8fOZH6uYuR+ViS7yF
   w==;
X-CSE-ConnectionGUID: 59raKzq/Q+aUBn5o6unw7Q==
X-CSE-MsgGUID: 15xKmEkXQ9i6MzNWixWQjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46925968"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="46925968"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:16:48 -0700
X-CSE-ConnectionGUID: 8+T6siWbRjeCc+9DvhVKmQ==
X-CSE-MsgGUID: KrK9i8KXRFiE13unw1fITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136869440"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Apr 2025 10:16:45 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6ul9-0000G7-1k;
	Mon, 21 Apr 2025 17:16:43 +0000
Date: Tue, 22 Apr 2025 01:16:13 +0800
From: kernel test robot <lkp@intel.com>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
	ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to
 be installed in hardware
Message-ID: <202504220128.2KvxCzaG-lkp@intel.com>
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>

Hi Karthikeyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on d33705bb41ff786b537f8ed50a187a474db111c1]

url:    https://github.com/intel-lab-lkp/linux/commits/Karthikeyan-Kathirvel/wifi-ath12k-allow-beacon-protection-keys-to-be-installed-in-hardware/20250421-194813
base:   d33705bb41ff786b537f8ed50a187a474db111c1
patch link:    https://lore.kernel.org/r/20250421114711.3660911-1-karthikeyan.kathirvel%40oss.qualcomm.com
patch subject: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be installed in hardware
config: powerpc-randconfig-003-20250421 (https://download.01.org/0day-ci/archive/20250422/202504220128.2KvxCzaG-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250422/202504220128.2KvxCzaG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504220128.2KvxCzaG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/mac.c:1474:30: error: use of undeclared identifier 'WLAN_EXT_CAPA11_BCN_PROTECT'
    1474 |             (ext_cap_ie->data[10] & WLAN_EXT_CAPA11_BCN_PROTECT))
         |                                     ^
   drivers/net/wireless/ath/ath12k/mac.c:1528:11: error: use of undeclared identifier 'WLAN_EXT_CAPA11_BCN_PROTECT'
    1528 |                                              WLAN_EXT_CAPA11_BCN_PROTECT))
         |                                              ^
   2 errors generated.


vim +/WLAN_EXT_CAPA11_BCN_PROTECT +1474 drivers/net/wireless/ath/ath12k/mac.c

  1447	
  1448	static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif,
  1449					     struct ath12k_link_vif *tx_arvif,
  1450						 struct sk_buff *bcn,
  1451					     u8 bssid_index, bool *nontx_profile_found)
  1452	{
  1453		struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)bcn->data;
  1454		const struct element *elem, *nontx, *index, *nie, *ext_cap_ie;
  1455		const u8 *start, *tail;
  1456		u16 rem_len;
  1457		u8 i;
  1458	
  1459		start = bcn->data + ieee80211_get_hdrlen_from_skb(bcn) + sizeof(mgmt->u.beacon);
  1460		tail = skb_tail_pointer(bcn);
  1461		rem_len = tail - start;
  1462	
  1463		arvif->rsnie_present = false;
  1464		arvif->wpaie_present = false;
  1465	
  1466		if (cfg80211_find_ie(WLAN_EID_RSN, start, rem_len))
  1467			arvif->rsnie_present = true;
  1468		if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT, WLAN_OUI_TYPE_MICROSOFT_WPA,
  1469					    start, rem_len))
  1470			arvif->wpaie_present = true;
  1471	
  1472		ext_cap_ie = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY, start, rem_len);
  1473		if (ext_cap_ie && ext_cap_ie->datalen >= 11 &&
> 1474		    (ext_cap_ie->data[10] & WLAN_EXT_CAPA11_BCN_PROTECT))
  1475			tx_arvif->beacon_prot = true;
  1476	
  1477		/* Return from here for the transmitted profile */
  1478		if (!bssid_index)
  1479			return;
  1480	
  1481		/* Initial rsnie_present for the nontransmitted profile is set to be same as that
  1482		 * of the transmitted profile. It will be changed if security configurations are
  1483		 * different.
  1484		 */
  1485		*nontx_profile_found = false;
  1486		for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID, start, rem_len) {
  1487			/* Fixed minimum MBSSID element length with at least one
  1488			 * nontransmitted BSSID profile is 12 bytes as given below;
  1489			 * 1 (max BSSID indicator) +
  1490			 * 2 (Nontransmitted BSSID profile: Subelement ID + length) +
  1491			 * 4 (Nontransmitted BSSID Capabilities: tag + length + info)
  1492			 * 2 (Nontransmitted BSSID SSID: tag + length)
  1493			 * 3 (Nontransmitted BSSID Index: tag + length + BSSID index
  1494			 */
  1495			if (elem->datalen < 12 || elem->data[0] < 1)
  1496				continue; /* Max BSSID indicator must be >=1 */
  1497	
  1498			for_each_element(nontx, elem->data + 1, elem->datalen - 1) {
  1499				start = nontx->data;
  1500	
  1501				if (nontx->id != 0 || nontx->datalen < 4)
  1502					continue; /* Invalid nontransmitted profile */
  1503	
  1504				if (nontx->data[0] != WLAN_EID_NON_TX_BSSID_CAP ||
  1505				    nontx->data[1] != 2) {
  1506					continue; /* Missing nontransmitted BSS capabilities */
  1507				}
  1508	
  1509				if (nontx->data[4] != WLAN_EID_SSID)
  1510					continue; /* Missing SSID for nontransmitted BSS */
  1511	
  1512				index = cfg80211_find_elem(WLAN_EID_MULTI_BSSID_IDX,
  1513							   start, nontx->datalen);
  1514				if (!index || index->datalen < 1 || index->data[0] == 0)
  1515					continue; /* Invalid MBSSID Index element */
  1516	
  1517				if (index->data[0] == bssid_index) {
  1518					*nontx_profile_found = true;
  1519	
  1520					/* Check if nontx BSS has beacon protection enabled */
  1521					if (!tx_arvif->beacon_prot) {
  1522						ext_cap_ie =
  1523						    cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
  1524								       nontx->data,
  1525								       nontx->datalen);
  1526						if (ext_cap_ie && ext_cap_ie->datalen >= 11 &&
  1527						    (ext_cap_ie->data[10] &
  1528						     WLAN_EXT_CAPA11_BCN_PROTECT))
  1529							tx_arvif->beacon_prot = true;
  1530					}
  1531	
  1532					if (cfg80211_find_ie(WLAN_EID_RSN,
  1533							     nontx->data,
  1534							     nontx->datalen)) {
  1535						arvif->rsnie_present = true;
  1536						return;
  1537					} else if (!arvif->rsnie_present) {
  1538						return; /* Both tx and nontx BSS are open */
  1539					}
  1540	
  1541					nie = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
  1542								     nontx->data,
  1543								     nontx->datalen);
  1544					if (!nie || nie->datalen < 2)
  1545						return; /* Invalid non-inheritance element */
  1546	
  1547					for (i = 1; i < nie->datalen - 1; i++) {
  1548						if (nie->data[i] == WLAN_EID_RSN) {
  1549							arvif->rsnie_present = false;
  1550							break;
  1551						}
  1552					}
  1553	
  1554					return;
  1555				}
  1556			}
  1557		}
  1558	}
  1559	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

