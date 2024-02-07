Return-Path: <linux-wireless+bounces-3262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4F84C331
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E461F2877D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D548F48;
	Wed,  7 Feb 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlte4h/J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808CFC0B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277179; cv=none; b=Zny9qmY+R11bZpRYSeGkDsSWB2WHXZ9WxP4GJOuRvdgkhUZlEiQ7EBlSuwJkMluL1K7D5VQixVSttzXxIC0uUckqSN6Vxvh0B8hEpnEsrJGdb50/3K3NH54FecPCGwl6GoP+5jOE30HsU8/G1njosDOVMBfXe9y/lt751olE5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277179; c=relaxed/simple;
	bh=99OqL91gK6hY6Hf88z8w72Yc7ojhwxsCONsc5HKl9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMDSCJKM7XVZHeLY0E2KPUx54Jsi9GsCAn29B4ewxvFOeyaLdEb0GdcFV7SohvdGeaVJWkcUirnJk2fIIKA68rg3aSXC4NHEXlXZwlqUHHFlKaLBlgEHRv/2RZ4RkHV1p4raWFXaehHhxY0OnpJMEMYv14QlksrroFWHmcaNQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlte4h/J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707277176; x=1738813176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=99OqL91gK6hY6Hf88z8w72Yc7ojhwxsCONsc5HKl9zQ=;
  b=mlte4h/Jg7Owz6O2SCJ0g4yIJThG/batFqbk4nMAkObpAolQ5tzmghsg
   oy8iQQX286ODEi0Ct6EASKwUi9qDRxQGGioeDZUumdrHGYwXAhaAcIvST
   SqIknjxavaDG2TC+nCLz89/JVa6XQu3lPmfiSPw3Mqx3RkOzlY6uvPVQ0
   EnNORWV0htGFTOEyZYXyDMutOGsrNcUGNiOT1QRZOAvOOXtetoszlULnb
   ousAx3ZSO7C8c7TdVLAdW4sAJHpzThkp97x0D/IjYjjhqG/mEaMhzJTuO
   R87CHaCKKUhrUQ3gy37QO5T6GssT56miRPoH4wFVg50vQ35nfuRTkTKfd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4682540"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="4682540"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5820973"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Feb 2024 19:39:33 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXYmY-00024E-0Y;
	Wed, 07 Feb 2024 03:39:30 +0000
Date: Wed, 7 Feb 2024 11:39:15 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: Re: [PATCH 09/11] wifi: iwlwifi: iwlmvm: handle unprotected
 deauth/disassoc in d3
Message-ID: <202402071158.kjPLRHpx-lkp@intel.com>
References: <20240206175739.fde438a22e3f.I3c8497520aaa95a22febff727b0ad08146965d47@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206175739.fde438a22e3f.I3c8497520aaa95a22febff727b0ad08146965d47@changeid>

Hi Miri,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20240206]
[cannot apply to wireless/main linus/master v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-iwlwifi-mvm-fix-a-crash-when-we-run-out-of-stations/20240207-000459
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240206175739.fde438a22e3f.I3c8497520aaa95a22febff727b0ad08146965d47%40changeid
patch subject: [PATCH 09/11] wifi: iwlwifi: iwlmvm: handle unprotected deauth/disassoc in d3
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240207/202402071158.kjPLRHpx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071158.kjPLRHpx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071158.kjPLRHpx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/mvm/d3.c: In function 'iwl_mvm_report_wakeup_reasons':
>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:1518:23: error: 'struct cfg80211_wowlan_wakeup' has no member named 'unprot_deauth_disassoc'
    1518 |                 wakeup.unprot_deauth_disassoc = true;
         |                       ^


vim +1518 drivers/net/wireless/intel/iwlwifi/mvm/d3.c

  1465	
  1466	static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
  1467						  struct ieee80211_vif *vif,
  1468						  struct iwl_wowlan_status_data *status)
  1469	{
  1470		struct sk_buff *pkt = NULL;
  1471		struct cfg80211_wowlan_wakeup wakeup = {
  1472			.pattern_idx = -1,
  1473		};
  1474		struct cfg80211_wowlan_wakeup *wakeup_report = &wakeup;
  1475		u32 reasons = status->wakeup_reasons;
  1476	
  1477		if (reasons == IWL_WOWLAN_WAKEUP_BY_NON_WIRELESS) {
  1478			wakeup_report = NULL;
  1479			goto report;
  1480		}
  1481	
  1482		pm_wakeup_event(mvm->dev, 0);
  1483	
  1484		if (reasons & IWL_WOWLAN_WAKEUP_BY_MAGIC_PACKET)
  1485			wakeup.magic_pkt = true;
  1486	
  1487		if (reasons & IWL_WOWLAN_WAKEUP_BY_PATTERN)
  1488			wakeup.pattern_idx =
  1489				status->pattern_number;
  1490	
  1491		if (reasons & (IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_MISSED_BEACON |
  1492			       IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH |
  1493			       IWL_WOWLAN_WAKEUP_BY_GTK_REKEY_FAILURE))
  1494			wakeup.disconnect = true;
  1495	
  1496		if (reasons & IWL_WOWLAN_WAKEUP_BY_GTK_REKEY_FAILURE)
  1497			wakeup.gtk_rekey_failure = true;
  1498	
  1499		if (reasons & IWL_WOWLAN_WAKEUP_BY_RFKILL_DEASSERTED)
  1500			wakeup.rfkill_release = true;
  1501	
  1502		if (reasons & IWL_WOWLAN_WAKEUP_BY_EAPOL_REQUEST)
  1503			wakeup.eap_identity_req = true;
  1504	
  1505		if (reasons & IWL_WOWLAN_WAKEUP_BY_FOUR_WAY_HANDSHAKE)
  1506			wakeup.four_way_handshake = true;
  1507	
  1508		if (reasons & IWL_WOWLAN_WAKEUP_BY_REM_WAKE_LINK_LOSS)
  1509			wakeup.tcp_connlost = true;
  1510	
  1511		if (reasons & IWL_WOWLAN_WAKEUP_BY_REM_WAKE_SIGNATURE_TABLE)
  1512			wakeup.tcp_nomoretokens = true;
  1513	
  1514		if (reasons & IWL_WOWLAN_WAKEUP_BY_REM_WAKE_WAKEUP_PACKET)
  1515			wakeup.tcp_match = true;
  1516	
  1517		if (reasons & IWL_WAKEUP_BY_11W_UNPROTECTED_DEAUTH_OR_DISASSOC)
> 1518			wakeup.unprot_deauth_disassoc = true;
  1519	
  1520		if (status->wake_packet) {
  1521			int pktsize = status->wake_packet_bufsize;
  1522			int pktlen = status->wake_packet_length;
  1523			const u8 *pktdata = status->wake_packet;
  1524			const struct ieee80211_hdr *hdr = (const void *)pktdata;
  1525			int truncated = pktlen - pktsize;
  1526	
  1527			/* this would be a firmware bug */
  1528			if (WARN_ON_ONCE(truncated < 0))
  1529				truncated = 0;
  1530	
  1531			if (ieee80211_is_data(hdr->frame_control)) {
  1532				int hdrlen = ieee80211_hdrlen(hdr->frame_control);
  1533				int ivlen = 0, icvlen = 4; /* also FCS */
  1534	
  1535				pkt = alloc_skb(pktsize, GFP_KERNEL);
  1536				if (!pkt)
  1537					goto report;
  1538	
  1539				skb_put_data(pkt, pktdata, hdrlen);
  1540				pktdata += hdrlen;
  1541				pktsize -= hdrlen;
  1542	
  1543				if (ieee80211_has_protected(hdr->frame_control)) {
  1544					/*
  1545					 * This is unlocked and using gtk_i(c)vlen,
  1546					 * but since everything is under RTNL still
  1547					 * that's not really a problem - changing
  1548					 * it would be difficult.
  1549					 */
  1550					if (is_multicast_ether_addr(hdr->addr1)) {
  1551						ivlen = mvm->gtk_ivlen;
  1552						icvlen += mvm->gtk_icvlen;
  1553					} else {
  1554						ivlen = mvm->ptk_ivlen;
  1555						icvlen += mvm->ptk_icvlen;
  1556					}
  1557				}
  1558	
  1559				/* if truncated, FCS/ICV is (partially) gone */
  1560				if (truncated >= icvlen) {
  1561					icvlen = 0;
  1562					truncated -= icvlen;
  1563				} else {
  1564					icvlen -= truncated;
  1565					truncated = 0;
  1566				}
  1567	
  1568				pktsize -= ivlen + icvlen;
  1569				pktdata += ivlen;
  1570	
  1571				skb_put_data(pkt, pktdata, pktsize);
  1572	
  1573				if (ieee80211_data_to_8023(pkt, vif->addr, vif->type))
  1574					goto report;
  1575				wakeup.packet = pkt->data;
  1576				wakeup.packet_present_len = pkt->len;
  1577				wakeup.packet_len = pkt->len - truncated;
  1578				wakeup.packet_80211 = false;
  1579			} else {
  1580				int fcslen = 4;
  1581	
  1582				if (truncated >= 4) {
  1583					truncated -= 4;
  1584					fcslen = 0;
  1585				} else {
  1586					fcslen -= truncated;
  1587					truncated = 0;
  1588				}
  1589				pktsize -= fcslen;
  1590				wakeup.packet = status->wake_packet;
  1591				wakeup.packet_present_len = pktsize;
  1592				wakeup.packet_len = pktlen - truncated;
  1593				wakeup.packet_80211 = true;
  1594			}
  1595		}
  1596	
  1597	 report:
  1598		ieee80211_report_wowlan_wakeup(vif, wakeup_report, GFP_KERNEL);
  1599		kfree_skb(pkt);
  1600	}
  1601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

