Return-Path: <linux-wireless+bounces-32419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMkXOKdDp2kNgAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:25:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B841F6C2D
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87BA330F95EF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28E3C3BE1;
	Tue,  3 Mar 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+llwDmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88C390C84
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569228; cv=none; b=dJePoEd7gvYlQjq8f3kKZYFGL8f7G7XoGhMB/79H+o8Dbfpz/Qbpm5H7Gh83vngnT9lJ4Ri175PniJcApNXkdfQ7xX8GgLcWOkcpKtUt5xx6/d0NmqIQ+sDfDzKQTIrAdqNiIDuc6fC/2OUxJWQebp47B7syoB5HI7FMcyQHHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569228; c=relaxed/simple;
	bh=F1hHJ/sotoblirnB/RpEL8X1IptsHMonLkEUopXl/XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl/c7Y214OX2wF6XPVupnxJKuYtoY7SP0biZVU8nG8HZixYnIg/pGwn3U3duJo9QbstUsP9D3wMJ18tvWM+NyBhQhdrLTed9YtUtGzkhuKXLy5numsUAO7LWYQqZYsHisO9tOfH1kvmBWyNi8rR1vKLN2Xp1wJ+bvnGX+kvWhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+llwDmz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772569223; x=1804105223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1hHJ/sotoblirnB/RpEL8X1IptsHMonLkEUopXl/XY=;
  b=F+llwDmzUTjRtXnpaIO3j2aOV24dLqAD9zfqBRZvN58P4m5p3EUFRCYi
   bN2ukHMGekDYay4oIsr481VfEgyxKwt5BX0VRTdZ4s4Ac1+qBT0fRg6Cb
   tTL9306zugvwtocey3CLE2akvWSSDGgdn4OudEs+G9TzyBC1FgtYEVO+C
   pMo2txP3ObhUYgaxxfH/o2MWtvwFmlEQIoKWr4TrfNTVUq755P1lHBYZM
   KgvaIx9q8zdB/5FXT6NpLFupHUUIcR+JaSTK/U090nG/l277X0j9YNdcw
   HnuMfnt7bAUUna/H2Tf6yPcZGLaL7JjeIEWrvq1yezfoUjJOCyl9sBuFK
   g==;
X-CSE-ConnectionGUID: WpCSFyxvRPadHzu3vt8Rkw==
X-CSE-MsgGUID: FDokiICvQ7SVcdHgCllOqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="84963708"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="84963708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 12:20:22 -0800
X-CSE-ConnectionGUID: edBBUoDbRy6Y9WQ2dFzm2g==
X-CSE-MsgGUID: CSc/ZxjOReGFNVZ7Js90rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="222778211"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2026 12:20:21 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxWE6-000000001X3-2R1D;
	Tue, 03 Mar 2026 20:20:18 +0000
Date: Tue, 3 Mar 2026 21:19:55 +0100
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH wireless-next] wifi: nl80211: split out UHR operation
 information
Message-ID: <202603032131.yShfv7Yn-lkp@intel.com>
References: <20260303152558.00e7bc8e9f4b.Iafdf37fb0f4304bdcdb824977d61e17b38c47685@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303152558.00e7bc8e9f4b.Iafdf37fb0f4304bdcdb824977d61e17b38c47685@changeid>
X-Rspamd-Queue-Id: 47B841F6C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32419-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on next-20260303]
[cannot apply to wireless/main linus/master v7.0-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-nl80211-split-out-UHR-operation-information/20260303-223359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260303152558.00e7bc8e9f4b.Iafdf37fb0f4304bdcdb824977d61e17b38c47685%40changeid
patch subject: [PATCH wireless-next] wifi: nl80211: split out UHR operation information
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260303/202603032131.yShfv7Yn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260303/202603032131.yShfv7Yn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603032131.yShfv7Yn-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/wireless/nl80211.c:961:10: error: expected expression before '[' token
     961 |         [[NL80211_ATTR_UHR_OPERATION] =
         |          ^
   net/wireless/nl80211.c:963:1: error: expected expression before '}' token
     963 | };
         | ^
   net/wireless/nl80211.c: In function 'nl80211_parse_key_new':
>> net/wireless/nl80211.c:1454:47: error: 'nl80211_key_policy' undeclared (first use in this function); did you mean 'nl80211_rekey_policy'?
    1454 |                                               nl80211_key_policy,
         |                                               ^~~~~~~~~~~~~~~~~~
         |                                               nl80211_rekey_policy
   net/wireless/nl80211.c:1454:47: note: each undeclared identifier is reported only once for each function it appears in
   net/wireless/nl80211.c: At top level:
>> net/wireless/nl80211.c:345:12: warning: 'validate_uhr_operation' defined but not used [-Wunused-function]
     345 | static int validate_uhr_operation(const struct nlattr *attr,
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +961 net/wireless/nl80211.c

   583	
   584	static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
   585		[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
   586		[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
   587		[NL80211_ATTR_WIPHY_NAME] = { .type = NLA_NUL_STRING,
   588					      .len = 20-1 },
   589		[NL80211_ATTR_WIPHY_TXQ_PARAMS] = { .type = NLA_NESTED },
   590	
   591		[NL80211_ATTR_WIPHY_FREQ] = { .type = NLA_U32 },
   592		[NL80211_ATTR_WIPHY_CHANNEL_TYPE] = { .type = NLA_U32 },
   593		[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = NLA_POLICY_RANGE(NLA_U8,
   594							NL80211_EDMG_CHANNELS_MIN,
   595							NL80211_EDMG_CHANNELS_MAX),
   596		[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG] = NLA_POLICY_RANGE(NLA_U8,
   597							NL80211_EDMG_BW_CONFIG_MIN,
   598							NL80211_EDMG_BW_CONFIG_MAX),
   599	
   600		[NL80211_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
   601		[NL80211_ATTR_CENTER_FREQ1] = { .type = NLA_U32 },
   602		[NL80211_ATTR_CENTER_FREQ1_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
   603		[NL80211_ATTR_CENTER_FREQ2] = { .type = NLA_U32 },
   604	
   605		[NL80211_ATTR_WIPHY_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 1),
   606		[NL80211_ATTR_WIPHY_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 1),
   607		[NL80211_ATTR_WIPHY_FRAG_THRESHOLD] = { .type = NLA_U32 },
   608		[NL80211_ATTR_WIPHY_RTS_THRESHOLD] = { .type = NLA_U32 },
   609		[NL80211_ATTR_WIPHY_COVERAGE_CLASS] = { .type = NLA_U8 },
   610		[NL80211_ATTR_WIPHY_DYN_ACK] = { .type = NLA_FLAG },
   611	
   612		[NL80211_ATTR_IFTYPE] = NLA_POLICY_MAX(NLA_U32, NL80211_IFTYPE_MAX),
   613		[NL80211_ATTR_IFINDEX] = { .type = NLA_U32 },
   614		[NL80211_ATTR_IFNAME] = { .type = NLA_NUL_STRING, .len = IFNAMSIZ-1 },
   615	
   616		[NL80211_ATTR_MAC] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   617		[NL80211_ATTR_PREV_BSSID] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   618	
   619		[NL80211_ATTR_KEY] = { .type = NLA_NESTED, },
   620		[NL80211_ATTR_KEY_DATA] = { .type = NLA_BINARY,
   621					    .len = WLAN_MAX_KEY_LEN },
   622		[NL80211_ATTR_KEY_IDX] = NLA_POLICY_MAX(NLA_U8, 7),
   623		[NL80211_ATTR_KEY_CIPHER] = { .type = NLA_U32 },
   624		[NL80211_ATTR_KEY_DEFAULT] = { .type = NLA_FLAG },
   625		[NL80211_ATTR_KEY_SEQ] = { .type = NLA_BINARY, .len = 16 },
   626		[NL80211_ATTR_KEY_TYPE] =
   627			NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES),
   628	
   629		[NL80211_ATTR_BEACON_INTERVAL] = { .type = NLA_U32 },
   630		[NL80211_ATTR_DTIM_PERIOD] = { .type = NLA_U32 },
   631		[NL80211_ATTR_BEACON_HEAD] =
   632			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head,
   633					       IEEE80211_MAX_DATA_LEN),
   634		[NL80211_ATTR_BEACON_TAIL] =
   635			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
   636					       IEEE80211_MAX_DATA_LEN),
   637		[NL80211_ATTR_STA_AID] =
   638			NLA_POLICY_RANGE(NLA_U16, 1, IEEE80211_MAX_AID),
   639		[NL80211_ATTR_STA_FLAGS] = { .type = NLA_NESTED },
   640		[NL80211_ATTR_STA_LISTEN_INTERVAL] = { .type = NLA_U16 },
   641		[NL80211_ATTR_STA_SUPPORTED_RATES] = { .type = NLA_BINARY,
   642						       .len = NL80211_MAX_SUPP_RATES },
   643		[NL80211_ATTR_STA_PLINK_ACTION] =
   644			NLA_POLICY_MAX(NLA_U8, NUM_NL80211_PLINK_ACTIONS - 1),
   645		[NL80211_ATTR_STA_TX_POWER_SETTING] =
   646			NLA_POLICY_RANGE(NLA_U8,
   647					 NL80211_TX_POWER_AUTOMATIC,
   648					 NL80211_TX_POWER_FIXED),
   649		[NL80211_ATTR_STA_TX_POWER] = { .type = NLA_S16 },
   650		[NL80211_ATTR_STA_VLAN] = { .type = NLA_U32 },
   651		[NL80211_ATTR_MNTR_FLAGS] = { /* NLA_NESTED can't be empty */ },
   652		[NL80211_ATTR_MESH_ID] = { .type = NLA_BINARY,
   653					   .len = IEEE80211_MAX_MESH_ID_LEN },
   654		[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
   655	
   656		/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
   657		[NL80211_ATTR_REG_ALPHA2] = NLA_POLICY_RANGE(NLA_BINARY, 2, 3),
   658		[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
   659	
   660		[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
   661		[NL80211_ATTR_BSS_SHORT_PREAMBLE] = { .type = NLA_U8 },
   662		[NL80211_ATTR_BSS_SHORT_SLOT_TIME] = { .type = NLA_U8 },
   663		[NL80211_ATTR_BSS_BASIC_RATES] = { .type = NLA_BINARY,
   664						   .len = NL80211_MAX_SUPP_RATES },
   665		[NL80211_ATTR_BSS_HT_OPMODE] = { .type = NLA_U16 },
   666	
   667		[NL80211_ATTR_MESH_CONFIG] = { .type = NLA_NESTED },
   668		[NL80211_ATTR_SUPPORT_MESH_AUTH] = { .type = NLA_FLAG },
   669	
   670		[NL80211_ATTR_HT_CAPABILITY] = NLA_POLICY_EXACT_LEN_WARN(NL80211_HT_CAPABILITY_LEN),
   671	
   672		[NL80211_ATTR_MGMT_SUBTYPE] = { .type = NLA_U8 },
   673		[NL80211_ATTR_IE] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
   674							   validate_ie_attr,
   675							   IEEE80211_MAX_DATA_LEN),
   676		[NL80211_ATTR_SCAN_FREQUENCIES] = { .type = NLA_NESTED },
   677		[NL80211_ATTR_SCAN_SSIDS] = { .type = NLA_NESTED },
   678	
   679		[NL80211_ATTR_SSID] = { .type = NLA_BINARY,
   680					.len = IEEE80211_MAX_SSID_LEN },
   681		[NL80211_ATTR_AUTH_TYPE] = { .type = NLA_U32 },
   682		[NL80211_ATTR_REASON_CODE] = { .type = NLA_U16 },
   683		[NL80211_ATTR_FREQ_FIXED] = { .type = NLA_FLAG },
   684		[NL80211_ATTR_TIMED_OUT] = { .type = NLA_FLAG },
   685		[NL80211_ATTR_USE_MFP] = NLA_POLICY_RANGE(NLA_U32,
   686							  NL80211_MFP_NO,
   687							  NL80211_MFP_OPTIONAL),
   688		[NL80211_ATTR_STA_FLAGS2] =
   689			NLA_POLICY_EXACT_LEN_WARN(sizeof(struct nl80211_sta_flag_update)),
   690		[NL80211_ATTR_CONTROL_PORT] = { .type = NLA_FLAG },
   691		[NL80211_ATTR_CONTROL_PORT_ETHERTYPE] = { .type = NLA_U16 },
   692		[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT] = { .type = NLA_FLAG },
   693		[NL80211_ATTR_CONTROL_PORT_OVER_NL80211] = { .type = NLA_FLAG },
   694		[NL80211_ATTR_PRIVACY] = { .type = NLA_FLAG },
   695		[NL80211_ATTR_STATUS_CODE] = { .type = NLA_U16 },
   696		[NL80211_ATTR_CIPHER_SUITE_GROUP] = { .type = NLA_U32 },
   697		[NL80211_ATTR_WPA_VERSIONS] =
   698			NLA_POLICY_RANGE(NLA_U32, 0,
   699					 NL80211_WPA_VERSION_1 |
   700					 NL80211_WPA_VERSION_2 |
   701					 NL80211_WPA_VERSION_3),
   702		[NL80211_ATTR_PID] = { .type = NLA_U32 },
   703		[NL80211_ATTR_4ADDR] = { .type = NLA_U8 },
   704		[NL80211_ATTR_PMKID] = NLA_POLICY_EXACT_LEN_WARN(WLAN_PMKID_LEN),
   705		[NL80211_ATTR_DURATION] = { .type = NLA_U32 },
   706		[NL80211_ATTR_COOKIE] = { .type = NLA_U64 },
   707		[NL80211_ATTR_TX_RATES] = { .type = NLA_NESTED },
   708		[NL80211_ATTR_FRAME] = { .type = NLA_BINARY,
   709					 .len = IEEE80211_MAX_DATA_LEN },
   710		[NL80211_ATTR_FRAME_MATCH] = { .type = NLA_BINARY, },
   711		[NL80211_ATTR_PS_STATE] = NLA_POLICY_RANGE(NLA_U32,
   712							   NL80211_PS_DISABLED,
   713							   NL80211_PS_ENABLED),
   714		[NL80211_ATTR_CQM] = { .type = NLA_NESTED, },
   715		[NL80211_ATTR_LOCAL_STATE_CHANGE] = { .type = NLA_FLAG },
   716		[NL80211_ATTR_AP_ISOLATE] = { .type = NLA_U8 },
   717		[NL80211_ATTR_WIPHY_TX_POWER_SETTING] = { .type = NLA_U32 },
   718		[NL80211_ATTR_WIPHY_TX_POWER_LEVEL] = { .type = NLA_U32 },
   719		[NL80211_ATTR_FRAME_TYPE] = { .type = NLA_U16 },
   720		[NL80211_ATTR_WIPHY_ANTENNA_TX] = { .type = NLA_U32 },
   721		[NL80211_ATTR_WIPHY_ANTENNA_RX] = { .type = NLA_U32 },
   722		[NL80211_ATTR_MCAST_RATE] = { .type = NLA_U32 },
   723		[NL80211_ATTR_OFFCHANNEL_TX_OK] = { .type = NLA_FLAG },
   724		[NL80211_ATTR_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
   725		[NL80211_ATTR_WOWLAN_TRIGGERS] = { .type = NLA_NESTED },
   726		[NL80211_ATTR_STA_PLINK_STATE] =
   727			NLA_POLICY_MAX(NLA_U8, NUM_NL80211_PLINK_STATES - 1),
   728		[NL80211_ATTR_MEASUREMENT_DURATION] = { .type = NLA_U16 },
   729		[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY] = { .type = NLA_FLAG },
   730		[NL80211_ATTR_MESH_PEER_AID] =
   731			NLA_POLICY_RANGE(NLA_U16, 1, IEEE80211_MAX_AID),
   732		[NL80211_ATTR_SCHED_SCAN_INTERVAL] = { .type = NLA_U32 },
   733		[NL80211_ATTR_REKEY_DATA] = { .type = NLA_NESTED },
   734		[NL80211_ATTR_SCAN_SUPP_RATES] = { .type = NLA_NESTED },
   735		[NL80211_ATTR_HIDDEN_SSID] =
   736			NLA_POLICY_RANGE(NLA_U32,
   737					 NL80211_HIDDEN_SSID_NOT_IN_USE,
   738					 NL80211_HIDDEN_SSID_ZERO_CONTENTS),
   739		[NL80211_ATTR_IE_PROBE_RESP] =
   740			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
   741					       IEEE80211_MAX_DATA_LEN),
   742		[NL80211_ATTR_IE_ASSOC_RESP] =
   743			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
   744					       IEEE80211_MAX_DATA_LEN),
   745		[NL80211_ATTR_ROAM_SUPPORT] = { .type = NLA_FLAG },
   746		[NL80211_ATTR_STA_WME] = NLA_POLICY_NESTED(nl80211_sta_wme_policy),
   747		[NL80211_ATTR_SCHED_SCAN_MATCH] = { .type = NLA_NESTED },
   748		[NL80211_ATTR_TX_NO_CCK_RATE] = { .type = NLA_FLAG },
   749		[NL80211_ATTR_TDLS_ACTION] = { .type = NLA_U8 },
   750		[NL80211_ATTR_TDLS_DIALOG_TOKEN] = { .type = NLA_U8 },
   751		[NL80211_ATTR_TDLS_OPERATION] = { .type = NLA_U8 },
   752		[NL80211_ATTR_TDLS_SUPPORT] = { .type = NLA_FLAG },
   753		[NL80211_ATTR_TDLS_EXTERNAL_SETUP] = { .type = NLA_FLAG },
   754		[NL80211_ATTR_TDLS_INITIATOR] = { .type = NLA_FLAG },
   755		[NL80211_ATTR_DONT_WAIT_FOR_ACK] = { .type = NLA_FLAG },
   756		[NL80211_ATTR_PROBE_RESP] = { .type = NLA_BINARY,
   757					      .len = IEEE80211_MAX_DATA_LEN },
   758		[NL80211_ATTR_DFS_REGION] = { .type = NLA_U8 },
   759		[NL80211_ATTR_DISABLE_HT] = { .type = NLA_FLAG },
   760		[NL80211_ATTR_HT_CAPABILITY_MASK] = {
   761			.len = NL80211_HT_CAPABILITY_LEN
   762		},
   763		[NL80211_ATTR_NOACK_MAP] = { .type = NLA_U16 },
   764		[NL80211_ATTR_INACTIVITY_TIMEOUT] = { .type = NLA_U16 },
   765		[NL80211_ATTR_BG_SCAN_PERIOD] = { .type = NLA_U16 },
   766		[NL80211_ATTR_WDEV] = { .type = NLA_U64 },
   767		[NL80211_ATTR_USER_REG_HINT_TYPE] = { .type = NLA_U32 },
   768	
   769		/* need to include at least Auth Transaction and Status Code */
   770		[NL80211_ATTR_AUTH_DATA] = NLA_POLICY_MIN_LEN(4),
   771	
   772		[NL80211_ATTR_VHT_CAPABILITY] = NLA_POLICY_EXACT_LEN_WARN(NL80211_VHT_CAPABILITY_LEN),
   773		[NL80211_ATTR_SCAN_FLAGS] = { .type = NLA_U32 },
   774		[NL80211_ATTR_P2P_CTWINDOW] = NLA_POLICY_MAX(NLA_U8, 127),
   775		[NL80211_ATTR_P2P_OPPPS] = NLA_POLICY_MAX(NLA_U8, 1),
   776		[NL80211_ATTR_LOCAL_MESH_POWER_MODE] =
   777			NLA_POLICY_RANGE(NLA_U32,
   778					 NL80211_MESH_POWER_UNKNOWN + 1,
   779					 NL80211_MESH_POWER_MAX),
   780		[NL80211_ATTR_ACL_POLICY] = {. type = NLA_U32 },
   781		[NL80211_ATTR_MAC_ADDRS] = { .type = NLA_NESTED },
   782		[NL80211_ATTR_STA_CAPABILITY] = { .type = NLA_U16 },
   783		[NL80211_ATTR_STA_EXT_CAPABILITY] = { .type = NLA_BINARY, },
   784		[NL80211_ATTR_SPLIT_WIPHY_DUMP] = { .type = NLA_FLAG, },
   785		[NL80211_ATTR_DISABLE_VHT] = { .type = NLA_FLAG },
   786		[NL80211_ATTR_VHT_CAPABILITY_MASK] = {
   787			.len = NL80211_VHT_CAPABILITY_LEN,
   788		},
   789		[NL80211_ATTR_MDID] = { .type = NLA_U16 },
   790		[NL80211_ATTR_IE_RIC] = { .type = NLA_BINARY,
   791					  .len = IEEE80211_MAX_DATA_LEN },
   792		[NL80211_ATTR_CRIT_PROT_ID] = { .type = NLA_U16 },
   793		[NL80211_ATTR_MAX_CRIT_PROT_DURATION] =
   794			NLA_POLICY_MAX(NLA_U16, NL80211_CRIT_PROTO_MAX_DURATION),
   795		[NL80211_ATTR_PEER_AID] =
   796			NLA_POLICY_RANGE(NLA_U16, 1, IEEE80211_MAX_AID),
   797		[NL80211_ATTR_CH_SWITCH_COUNT] = { .type = NLA_U32 },
   798		[NL80211_ATTR_CH_SWITCH_BLOCK_TX] = { .type = NLA_FLAG },
   799		[NL80211_ATTR_CSA_IES] = { .type = NLA_NESTED },
   800		[NL80211_ATTR_CNTDWN_OFFS_BEACON] = { .type = NLA_BINARY },
   801		[NL80211_ATTR_CNTDWN_OFFS_PRESP] = { .type = NLA_BINARY },
   802		[NL80211_ATTR_STA_SUPPORTED_CHANNELS] = NLA_POLICY_MIN_LEN(2),
   803		/*
   804		 * The value of the Length field of the Supported Operating
   805		 * Classes element is between 2 and 253.
   806		 */
   807		[NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES] =
   808			NLA_POLICY_RANGE(NLA_BINARY, 2, 253),
   809		[NL80211_ATTR_HANDLE_DFS] = { .type = NLA_FLAG },
   810		[NL80211_ATTR_OPMODE_NOTIF] = { .type = NLA_U8 },
   811		[NL80211_ATTR_VENDOR_ID] = { .type = NLA_U32 },
   812		[NL80211_ATTR_VENDOR_SUBCMD] = { .type = NLA_U32 },
   813		[NL80211_ATTR_VENDOR_DATA] = { .type = NLA_BINARY },
   814		[NL80211_ATTR_QOS_MAP] = NLA_POLICY_RANGE(NLA_BINARY,
   815							  IEEE80211_QOS_MAP_LEN_MIN,
   816							  IEEE80211_QOS_MAP_LEN_MAX),
   817		[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   818		[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
   819		[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
   820		[NL80211_ATTR_SOCKET_OWNER] = { .type = NLA_FLAG },
   821		[NL80211_ATTR_CSA_C_OFFSETS_TX] = { .type = NLA_BINARY },
   822		[NL80211_ATTR_USE_RRM] = { .type = NLA_FLAG },
   823		[NL80211_ATTR_TSID] = NLA_POLICY_MAX(NLA_U8, IEEE80211_NUM_TIDS - 1),
   824		[NL80211_ATTR_USER_PRIO] =
   825			NLA_POLICY_MAX(NLA_U8, IEEE80211_NUM_UPS - 1),
   826		[NL80211_ATTR_ADMITTED_TIME] = { .type = NLA_U16 },
   827		[NL80211_ATTR_SMPS_MODE] = { .type = NLA_U8 },
   828		[NL80211_ATTR_OPER_CLASS] = { .type = NLA_U8 },
   829		[NL80211_ATTR_MAC_MASK] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   830		[NL80211_ATTR_WIPHY_SELF_MANAGED_REG] = { .type = NLA_FLAG },
   831		[NL80211_ATTR_NETNS_FD] = { .type = NLA_U32 },
   832		[NL80211_ATTR_SCHED_SCAN_DELAY] = { .type = NLA_U32 },
   833		[NL80211_ATTR_REG_INDOOR] = { .type = NLA_FLAG },
   834		[NL80211_ATTR_PBSS] = { .type = NLA_FLAG },
   835		[NL80211_ATTR_BSS_SELECT] = { .type = NLA_NESTED },
   836		[NL80211_ATTR_STA_SUPPORT_P2P_PS] =
   837			NLA_POLICY_MAX(NLA_U8, NUM_NL80211_P2P_PS_STATUS - 1),
   838		[NL80211_ATTR_MU_MIMO_GROUP_DATA] = {
   839			.len = VHT_MUMIMO_GROUPS_DATA_LEN
   840		},
   841		[NL80211_ATTR_MU_MIMO_FOLLOW_MAC_ADDR] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   842		[NL80211_ATTR_NAN_MASTER_PREF] = NLA_POLICY_MIN(NLA_U8, 1),
   843		[NL80211_ATTR_BANDS] = { .type = NLA_U32 },
   844		[NL80211_ATTR_NAN_CONFIG] = NLA_POLICY_NESTED(nl80211_nan_conf_policy),
   845		[NL80211_ATTR_NAN_FUNC] = { .type = NLA_NESTED },
   846		[NL80211_ATTR_FILS_KEK] = { .type = NLA_BINARY,
   847					    .len = FILS_MAX_KEK_LEN },
   848		[NL80211_ATTR_FILS_NONCES] = NLA_POLICY_EXACT_LEN_WARN(2 * FILS_NONCE_LEN),
   849		[NL80211_ATTR_MULTICAST_TO_UNICAST_ENABLED] = { .type = NLA_FLAG, },
   850		[NL80211_ATTR_BSSID] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
   851		[NL80211_ATTR_SCHED_SCAN_RELATIVE_RSSI] = { .type = NLA_S8 },
   852		[NL80211_ATTR_SCHED_SCAN_RSSI_ADJUST] = {
   853			.len = sizeof(struct nl80211_bss_select_rssi_adjust)
   854		},
   855		[NL80211_ATTR_TIMEOUT_REASON] = { .type = NLA_U32 },
   856		[NL80211_ATTR_FILS_ERP_USERNAME] = { .type = NLA_BINARY,
   857						     .len = FILS_ERP_MAX_USERNAME_LEN },
   858		[NL80211_ATTR_FILS_ERP_REALM] = { .type = NLA_BINARY,
   859						  .len = FILS_ERP_MAX_REALM_LEN },
   860		[NL80211_ATTR_FILS_ERP_NEXT_SEQ_NUM] = { .type = NLA_U16 },
   861		[NL80211_ATTR_FILS_ERP_RRK] = { .type = NLA_BINARY,
   862						.len = FILS_ERP_MAX_RRK_LEN },
   863		[NL80211_ATTR_FILS_CACHE_ID] = NLA_POLICY_EXACT_LEN_WARN(2),
   864		[NL80211_ATTR_PMK] = { .type = NLA_BINARY, .len = PMK_MAX_LEN },
   865		[NL80211_ATTR_PMKR0_NAME] = NLA_POLICY_EXACT_LEN(WLAN_PMK_NAME_LEN),
   866		[NL80211_ATTR_SCHED_SCAN_MULTI] = { .type = NLA_FLAG },
   867		[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT] = { .type = NLA_FLAG },
   868	
   869		[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
   870		[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
   871		[NL80211_ATTR_TXQ_QUANTUM] = NLA_POLICY_FULL_RANGE(NLA_U32, &q_range),
   872		[NL80211_ATTR_HE_CAPABILITY] =
   873			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
   874					       NL80211_HE_MAX_CAPABILITY_LEN),
   875		[NL80211_ATTR_FTM_RESPONDER] =
   876			NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
   877		[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
   878		[NL80211_ATTR_PEER_MEASUREMENTS] =
   879			NLA_POLICY_NESTED(nl80211_pmsr_attr_policy),
   880		[NL80211_ATTR_AIRTIME_WEIGHT] = NLA_POLICY_MIN(NLA_U16, 1),
   881		[NL80211_ATTR_SAE_PASSWORD] = { .type = NLA_BINARY,
   882						.len = SAE_PASSWORD_MAX_LEN },
   883		[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
   884		[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
   885		[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
   886		[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
   887		[NL80211_ATTR_TID_CONFIG] =
   888			NLA_POLICY_NESTED_ARRAY(nl80211_tid_config_attr_policy),
   889		[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
   890		[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
   891		[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
   892		[NL80211_ATTR_RECEIVE_MULTICAST] = { .type = NLA_FLAG },
   893		[NL80211_ATTR_WIPHY_FREQ_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
   894		[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
   895		[NL80211_ATTR_HE_6GHZ_CAPABILITY] =
   896			NLA_POLICY_EXACT_LEN(sizeof(struct ieee80211_he_6ghz_capa)),
   897		[NL80211_ATTR_FILS_DISCOVERY] =
   898			NLA_POLICY_NESTED(nl80211_fils_discovery_policy),
   899		[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP] =
   900			NLA_POLICY_NESTED(nl80211_unsol_bcast_probe_resp_policy),
   901		[NL80211_ATTR_S1G_CAPABILITY] =
   902			NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
   903		[NL80211_ATTR_S1G_CAPABILITY_MASK] =
   904			NLA_POLICY_EXACT_LEN(IEEE80211_S1G_CAPABILITY_LEN),
   905		[NL80211_ATTR_SAE_PWE] =
   906			NLA_POLICY_RANGE(NLA_U8, NL80211_SAE_PWE_HUNT_AND_PECK,
   907					 NL80211_SAE_PWE_BOTH),
   908		[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
   909		[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
   910		[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
   911		[NL80211_ATTR_OBSS_COLOR_BITMAP] = { .type = NLA_U64 },
   912		[NL80211_ATTR_COLOR_CHANGE_COUNT] = { .type = NLA_U8 },
   913		[NL80211_ATTR_COLOR_CHANGE_COLOR] = { .type = NLA_U8 },
   914		[NL80211_ATTR_COLOR_CHANGE_ELEMS] = NLA_POLICY_NESTED(nl80211_policy),
   915		[NL80211_ATTR_MBSSID_CONFIG] =
   916				NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
   917		[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
   918		[NL80211_ATTR_RADAR_BACKGROUND] = { .type = NLA_FLAG },
   919		[NL80211_ATTR_AP_SETTINGS_FLAGS] = { .type = NLA_U32 },
   920		[NL80211_ATTR_EHT_CAPABILITY] =
   921			NLA_POLICY_RANGE(NLA_BINARY,
   922					 NL80211_EHT_MIN_CAPABILITY_LEN,
   923					 NL80211_EHT_MAX_CAPABILITY_LEN),
   924		[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
   925		[NL80211_ATTR_MLO_LINKS] =
   926			NLA_POLICY_NESTED_ARRAY(nl80211_policy),
   927		[NL80211_ATTR_MLO_LINK_ID] =
   928			NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS - 1),
   929		[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
   930		[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
   931		[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
   932		[NL80211_ATTR_EML_CAPABILITY] = { .type = NLA_U16 },
   933		[NL80211_ATTR_PUNCT_BITMAP] =
   934			NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
   935	
   936		[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
   937		[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
   938		[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
   939		[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
   940		[NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA] = { .type = NLA_FLAG },
   941		[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
   942		[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
   943		[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
   944		[NL80211_ATTR_VIF_RADIO_MASK] = { .type = NLA_U32 },
   945		[NL80211_ATTR_SUPPORTED_SELECTORS] =
   946			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_supported_selectors,
   947					       NL80211_MAX_SUPP_SELECTORS),
   948		[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
   949		[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
   950		[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
   951		[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
   952		[NL80211_ATTR_S1G_LONG_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U8, 2),
   953		[NL80211_ATTR_S1G_SHORT_BEACON] =
   954			NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
   955		[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
   956		[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
   957		[NL80211_ATTR_EPP_PEER] = { .type = NLA_FLAG },
   958		[NL80211_ATTR_UHR_CAPABILITY] =
   959			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
   960		[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
 > 961		[[NL80211_ATTR_UHR_OPERATION] =
   962			NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_operation),
   963	};
   964	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

