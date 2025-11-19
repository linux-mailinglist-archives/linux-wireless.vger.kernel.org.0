Return-Path: <linux-wireless+bounces-29134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD84C6F710
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 9248E29826
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4823563EC;
	Wed, 19 Nov 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZ2yOJgO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA527CB0A;
	Wed, 19 Nov 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563865; cv=none; b=qB+jXsp7gGotOjhKCN8phBRZQkSD017s/e0mxovVI3z5K/U8L/mBreEfzF39bUmRI7RZe8908uXWv5cO63S8EvcTwTOVHPNElaUjawn4MTM0npmvnm7pdwnVFKNTESbAMtKohHawxKuoRkXi5+I8SYzA58hOrW3R439XgYheye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563865; c=relaxed/simple;
	bh=vNuGV1rCQ/E6w1UWnBC6lGDkKXCj/KwyDtwthK+GYqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb8bvuXGn8aSg1IjAnH2P+JPogOyqDUV7D16Y0+9W/BWNsCIuqyFXpe+qfCSUPy2KvrBcWV+L611b1IUEeHrzdzdg2v+XvLIXuBuD2Afud7kUm38f1d1oakvFvMROLW59aXHMNgCoGeVXGSYnEb9p5zN82YSIQJj2+pKlc9mwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZ2yOJgO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763563863; x=1795099863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vNuGV1rCQ/E6w1UWnBC6lGDkKXCj/KwyDtwthK+GYqk=;
  b=eZ2yOJgODvH7zjgLFoc7w3/A5SCNBNMZ9Elol2G+/C2HYSGwn+dP/SNk
   yLrZrBwJw6WMsfY79nAjwCpzDl3aqkl7o6zfh/8eXYFDwOTnp8MG4DSaO
   na6+zU7mAOiNvjRAkqxfWAvvS+7nsMvg6iaxHJxAJOhtceH6ekOfMJ99u
   twYloHaPuuUW3o3uad1rFHrOcbb9hdKzPx6avq113eff97BwV5WFOUw1D
   2HBVi8EOL/26MpW8R0E7q7FGu11JCfMIeGKs3Fa0eTie3JkTUq2DjRVKy
   Mu1XH+CR5RwY7Las7+INrx7ZeuQDhaJtnKzx/DS6UTbaHbIaUa7avNe/2
   A==;
X-CSE-ConnectionGUID: zpGKqGOjTRCWcUEc8ux34Q==
X-CSE-MsgGUID: zJPmO/K5QHm0hM4LBLQIpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76962094"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76962094"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 06:51:02 -0800
X-CSE-ConnectionGUID: 9Hmy5UWvSKqiR9zW89wbWQ==
X-CSE-MsgGUID: 47kEs49lTGmU5H1vCDzTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190741746"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Nov 2025 06:50:59 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLjWL-00030N-2E;
	Wed, 19 Nov 2025 14:50:57 +0000
Date: Wed, 19 Nov 2025 22:49:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>, johannes@sipsolutions.net,
	dave.taht@bufferbloat.net, linville@tuxdriver.com
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	Ranganath V N <vnranganath.20@gmail.com>,
	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
Message-ID: <202511192205.7ZRQgwZI-lkp@intel.com>
References: <20251118150524.7973-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118150524.7973-1-vnranganath.20@gmail.com>

Hi Ranganath,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.18-rc6 next-20251119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ranganath-V-N/wifi-cfg80211-Fix-uninitialized-header-access-in-cfg80211_classify8021d/20251118-231316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251118150524.7973-1-vnranganath.20%40gmail.com
patch subject: [PATCH v3] wifi: cfg80211: Fix uninitialized header access in cfg80211_classify8021d
config: arm64-randconfig-r132-20251119 (https://download.01.org/0day-ci/archive/20251119/202511192205.7ZRQgwZI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511192205.7ZRQgwZI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511192205.7ZRQgwZI-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/wireless/util.c: In function 'cfg80211_classify8021d':
>> net/wireless/util.c:966:3: error: a label can only be part of a statement and a declaration is not a statement
      struct iphdr iph, *ip;
      ^~~~~~
   net/wireless/util.c:976:3: error: a label can only be part of a statement and a declaration is not a statement
      struct ipv6hdr ip6h, *ip6;
      ^~~~~~


vim +966 net/wireless/util.c

   936	
   937	/* Given a data frame determine the 802.1p/1d tag to use. */
   938	unsigned int cfg80211_classify8021d(struct sk_buff *skb,
   939					    struct cfg80211_qos_map *qos_map)
   940	{
   941		unsigned int dscp;
   942		unsigned char vlan_priority;
   943		unsigned int ret;
   944	
   945		/* skb->priority values from 256->263 are magic values to
   946		 * directly indicate a specific 802.1d priority.  This is used
   947		 * to allow 802.1d priority to be passed directly in from VLAN
   948		 * tags, etc.
   949		 */
   950		if (skb->priority >= 256 && skb->priority <= 263) {
   951			ret = skb->priority - 256;
   952			goto out;
   953		}
   954	
   955		if (skb_vlan_tag_present(skb)) {
   956			vlan_priority = (skb_vlan_tag_get(skb) & VLAN_PRIO_MASK)
   957				>> VLAN_PRIO_SHIFT;
   958			if (vlan_priority > 0) {
   959				ret = vlan_priority;
   960				goto out;
   961			}
   962		}
   963	
   964		switch (skb->protocol) {
   965		case htons(ETH_P_IP):
 > 966			struct iphdr iph, *ip;
   967	
   968			ip = skb_header_pointer(skb, sizeof(struct ethhdr),
   969						sizeof(*ip), &iph);
   970			if (!ip)
   971				return 0;
   972	
   973			dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
   974			break;
   975		case htons(ETH_P_IPV6):
   976			struct ipv6hdr ip6h, *ip6;
   977	
   978			ip6 = skb_header_pointer(skb, sizeof(struct ethhdr),
   979						 sizeof(*ip6), &ip6h);
   980			if (!ip6)
   981				return 0;
   982	
   983			dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
   984			break;
   985		case htons(ETH_P_MPLS_UC):
   986		case htons(ETH_P_MPLS_MC): {
   987			struct mpls_label mpls_tmp, *mpls;
   988	
   989			mpls = skb_header_pointer(skb, sizeof(struct ethhdr),
   990						  sizeof(*mpls), &mpls_tmp);
   991			if (!mpls)
   992				return 0;
   993	
   994			ret = (ntohl(mpls->entry) & MPLS_LS_TC_MASK)
   995				>> MPLS_LS_TC_SHIFT;
   996			goto out;
   997		}
   998		case htons(ETH_P_80221):
   999			/* 802.21 is always network control traffic */
  1000			return 7;
  1001		default:
  1002			return 0;
  1003		}
  1004	
  1005		if (qos_map) {
  1006			unsigned int i, tmp_dscp = dscp >> 2;
  1007	
  1008			for (i = 0; i < qos_map->num_des; i++) {
  1009				if (tmp_dscp == qos_map->dscp_exception[i].dscp) {
  1010					ret = qos_map->dscp_exception[i].up;
  1011					goto out;
  1012				}
  1013			}
  1014	
  1015			for (i = 0; i < 8; i++) {
  1016				if (tmp_dscp >= qos_map->up[i].low &&
  1017				    tmp_dscp <= qos_map->up[i].high) {
  1018					ret = i;
  1019					goto out;
  1020				}
  1021			}
  1022		}
  1023	
  1024		/* The default mapping as defined Section 2.3 in RFC8325: The three
  1025		 * Most Significant Bits (MSBs) of the DSCP are used as the
  1026		 * corresponding L2 markings.
  1027		 */
  1028		ret = dscp >> 5;
  1029	
  1030		/* Handle specific DSCP values for which the default mapping (as
  1031		 * described above) doesn't adhere to the intended usage of the DSCP
  1032		 * value. See section 4 in RFC8325. Specifically, for the following
  1033		 * Diffserv Service Classes no update is needed:
  1034		 * - Standard: DF
  1035		 * - Low Priority Data: CS1
  1036		 * - Multimedia Conferencing: AF41, AF42, AF43
  1037		 * - Network Control Traffic: CS7
  1038		 * - Real-Time Interactive: CS4
  1039		 * - Signaling: CS5
  1040		 */
  1041		switch (dscp >> 2) {
  1042		case 10:
  1043		case 12:
  1044		case 14:
  1045			/* High throughput data: AF11, AF12, AF13 */
  1046			ret = 0;
  1047			break;
  1048		case 16:
  1049			/* Operations, Administration, and Maintenance and Provisioning:
  1050			 * CS2
  1051			 */
  1052			ret = 0;
  1053			break;
  1054		case 18:
  1055		case 20:
  1056		case 22:
  1057			/* Low latency data: AF21, AF22, AF23 */
  1058			ret = 3;
  1059			break;
  1060		case 24:
  1061			/* Broadcasting video: CS3 */
  1062			ret = 4;
  1063			break;
  1064		case 26:
  1065		case 28:
  1066		case 30:
  1067			/* Multimedia Streaming: AF31, AF32, AF33 */
  1068			ret = 4;
  1069			break;
  1070		case 44:
  1071			/* Voice Admit: VA */
  1072			ret = 6;
  1073			break;
  1074		case 46:
  1075			/* Telephony traffic: EF */
  1076			ret = 6;
  1077			break;
  1078		case 48:
  1079			/* Network Control Traffic: CS6 */
  1080			ret = 7;
  1081			break;
  1082		}
  1083	out:
  1084		return array_index_nospec(ret, IEEE80211_NUM_TIDS);
  1085	}
  1086	EXPORT_SYMBOL(cfg80211_classify8021d);
  1087	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

