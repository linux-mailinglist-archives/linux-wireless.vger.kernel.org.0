Return-Path: <linux-wireless+bounces-37407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zC04CY+BImr/ZAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 09:58:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED8646348
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 09:58:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hhgfn5Dc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37407-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37407-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FC2F310BF12
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2A48034C;
	Fri,  5 Jun 2026 07:47:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D77480971;
	Fri,  5 Jun 2026 07:47:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645637; cv=none; b=qT/KWQXzOWlPrBXxrz26RJzyrCJ2cRvQMWX4KjJxcrGZUEW2mG5NPav7YYITtvorQOQ8850mJ2UkmfCVxDEBUJuw+1Ctz7haeOK3DTva1NRM8B0NcVI35iBjFffo5xFmGvmyMPWc0JJe8zpZfrjfeqcPpLRaF1DnrGaQLlo4oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645637; c=relaxed/simple;
	bh=Wn98R73MKuK/CXc5dxg1gkgRsYK30s4bF8Ae0WCOqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9BjMR1PuSjHy0Neb04qDHCARn/7/xxZVHajth1PxMEBSsUcXiFPN51zDh7w68AMAQe6QPaJkGBhbS55TRZ0+uh+39DKiXT6ug59Z6F98qYW0qNArJ2t2fjFrfcZbptwFFvLxcJjZpeNvwyVeQiJfYrXbtp0bdvpQznD7Pae60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhgfn5Dc; arc=none smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780645634; x=1812181634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wn98R73MKuK/CXc5dxg1gkgRsYK30s4bF8Ae0WCOqiE=;
  b=hhgfn5Dc1ZABSX5i0izkpbpVAb5lP4D9c5A5mZwdX94dFspiYakEjkPj
   kUGZnupNPBfZko/kEKC/2kxRdGjIlrjXItAJa+P8oYSbnt4ypobexoNKE
   Itugi8pKrSmR/qR7JAPDzRR95cu/CUGrbtQCFOUhTllNl1Ot9rc8wmsqU
   1cQ9U/WSerCeGmN6iaqsO8xDUItMOt4/g9421r6WykjuDazLUw9++FVft
   HETfk83FGLBbAo0ojfKVbuiqxgsIr6DYSstURwUHxRVcSLKa8+SyPLkWs
   Bkg4MFNKo6o6HIpOQIrCHcgQ9M/SlLCg6vGCdbUq2+z3DvyXo0a/bgRWK
   g==;
X-CSE-ConnectionGUID: erRtydj/QcWFYHJZY86DBA==
X-CSE-MsgGUID: GZ5bC7Y0RGS9gdpiF92gkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92964578"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92964578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:47:13 -0700
X-CSE-ConnectionGUID: JUUvT2GAQZ6jnnX37DTVrQ==
X-CSE-MsgGUID: ybmTpm7ISO+30Gh4mNOETA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="282862897"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2026 00:47:11 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVPGm-000000002Vh-3ihl;
	Fri, 05 Jun 2026 07:47:08 +0000
Date: Fri, 5 Jun 2026 09:46:11 +0200
From: kernel test robot <lkp@intel.com>
To: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>,
	johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
Subject: Re: [PATCH] wifi: nl80211: Increase ie_len size to prevent truncated
 IEs in new peer notifications
Message-ID: <202606050936.McGTSygg-lkp@intel.com>
References: <20260604203027.406815-1-thiyagarajan@aerlync.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604203027.406815-1-thiyagarajan@aerlync.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37407-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thiyagarajan@aerlync.com,m:johannes@sipsolutions.net,m:oe-kbuild-all@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0ED8646348

Hi Thiyagarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v7.1-rc6 next-20260604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thiyagarajan-Pandiyan/wifi-nl80211-Increase-ie_len-size-to-prevent-truncated-IEs-in-new-peer-notifications/20260605-043726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260604203027.406815-1-thiyagarajan%40aerlync.com
patch subject: [PATCH] wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260605/202606050936.McGTSygg-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606050936.McGTSygg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606050936.McGTSygg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/wireless/nl80211.c:21357:6: error: conflicting types for 'cfg80211_notify_new_peer_candidate'; have 'void(struct net_device *, const u8 *, const u8 *, size_t,  int,  gfp_t)' {aka 'void(struct net_device *, const unsigned char *, const unsigned char *, long unsigned int,  int,  unsigned int)'}
   21357 | void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/wireless/nl80211.c:27:
   include/net/cfg80211.h:8687:6: note: previous declaration of 'cfg80211_notify_new_peer_candidate' with type 'void(struct net_device *, const u8 *, const u8 *, u8,  int,  gfp_t)' {aka 'void(struct net_device *, const unsigned char *, const unsigned char *, unsigned char,  int,  unsigned int)'}
    8687 | void cfg80211_notify_new_peer_candidate(struct net_device *dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from include/uapi/linux/if.h:25,
                    from net/wireless/nl80211.c:11:
   net/wireless/nl80211.c:21399:15: error: conflicting types for 'cfg80211_notify_new_peer_candidate'; have 'void(struct net_device *, const u8 *, const u8 *, size_t,  int,  gfp_t)' {aka 'void(struct net_device *, const unsigned char *, const unsigned char *, long unsigned int,  int,  unsigned int)'}
   21399 | EXPORT_SYMBOL(cfg80211_notify_new_peer_candidate);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:89:41: note: in expansion of macro '_EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   net/wireless/nl80211.c:21399:1: note: in expansion of macro 'EXPORT_SYMBOL'
   21399 | EXPORT_SYMBOL(cfg80211_notify_new_peer_candidate);
         | ^~~~~~~~~~~~~
   include/net/cfg80211.h:8687:6: note: previous declaration of 'cfg80211_notify_new_peer_candidate' with type 'void(struct net_device *, const u8 *, const u8 *, u8,  int,  gfp_t)' {aka 'void(struct net_device *, const unsigned char *, const unsigned char *, unsigned char,  int,  unsigned int)'}
    8687 | void cfg80211_notify_new_peer_candidate(struct net_device *dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +21357 net/wireless/nl80211.c

04a773ade0680d Johannes Berg         2009-04-19  21356  
947add36ca2dcd Johannes Berg         2013-02-22 @21357  void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
a63204d4bff16d Thiyagarajan Pandiyan 2026-06-05  21358  					const u8 *ie, size_t ie_len,
ecbc12ad6b6826 Bob Copeland          2018-10-26  21359  					int sig_dbm, gfp_t gfp)
c93b5e717ec47b Javier Cardona        2011-04-07  21360  {
947add36ca2dcd Johannes Berg         2013-02-22  21361  	struct wireless_dev *wdev = dev->ieee80211_ptr;
f26cbf401be935 Zhao, Gang            2014-04-21  21362  	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
c93b5e717ec47b Javier Cardona        2011-04-07  21363  	struct sk_buff *msg;
c93b5e717ec47b Javier Cardona        2011-04-07  21364  	void *hdr;
c93b5e717ec47b Javier Cardona        2011-04-07  21365  
947add36ca2dcd Johannes Berg         2013-02-22  21366  	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_MESH_POINT))
947add36ca2dcd Johannes Berg         2013-02-22  21367  		return;
947add36ca2dcd Johannes Berg         2013-02-22  21368  
947add36ca2dcd Johannes Berg         2013-02-22  21369  	trace_cfg80211_notify_new_peer_candidate(dev, addr);
947add36ca2dcd Johannes Berg         2013-02-22  21370  
4ef8c1c93f848e Johannes Berg         2017-01-09  21371  	msg = nlmsg_new(100 + ie_len, gfp);
c93b5e717ec47b Javier Cardona        2011-04-07  21372  	if (!msg)
c93b5e717ec47b Javier Cardona        2011-04-07  21373  		return;
c93b5e717ec47b Javier Cardona        2011-04-07  21374  
c93b5e717ec47b Javier Cardona        2011-04-07  21375  	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_NEW_PEER_CANDIDATE);
c93b5e717ec47b Javier Cardona        2011-04-07  21376  	if (!hdr) {
c93b5e717ec47b Javier Cardona        2011-04-07  21377  		nlmsg_free(msg);
c93b5e717ec47b Javier Cardona        2011-04-07  21378  		return;
c93b5e717ec47b Javier Cardona        2011-04-07  21379  	}
c93b5e717ec47b Javier Cardona        2011-04-07  21380  
9360ffd1859720 David S. Miller       2012-03-29  21381  	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
947add36ca2dcd Johannes Berg         2013-02-22  21382  	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
947add36ca2dcd Johannes Berg         2013-02-22  21383  	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
9360ffd1859720 David S. Miller       2012-03-29  21384  	    (ie_len && ie &&
ecbc12ad6b6826 Bob Copeland          2018-10-26  21385  	     nla_put(msg, NL80211_ATTR_IE, ie_len, ie)) ||
ecbc12ad6b6826 Bob Copeland          2018-10-26  21386  	    (sig_dbm &&
ecbc12ad6b6826 Bob Copeland          2018-10-26  21387  	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)))
9360ffd1859720 David S. Miller       2012-03-29  21388  		goto nla_put_failure;
c93b5e717ec47b Javier Cardona        2011-04-07  21389  
3b7b72eed19684 Johannes Berg         2011-10-22  21390  	genlmsg_end(msg, hdr);
c93b5e717ec47b Javier Cardona        2011-04-07  21391  
68eb55031da7c9 Johannes Berg         2013-11-19  21392  	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
2a94fe48f32ccf Johannes Berg         2013-11-19  21393  				NL80211_MCGRP_MLME, gfp);
c93b5e717ec47b Javier Cardona        2011-04-07  21394  	return;
c93b5e717ec47b Javier Cardona        2011-04-07  21395  
c93b5e717ec47b Javier Cardona        2011-04-07  21396   nla_put_failure:
c93b5e717ec47b Javier Cardona        2011-04-07  21397  	nlmsg_free(msg);
c93b5e717ec47b Javier Cardona        2011-04-07  21398  }
947add36ca2dcd Johannes Berg         2013-02-22  21399  EXPORT_SYMBOL(cfg80211_notify_new_peer_candidate);
c93b5e717ec47b Javier Cardona        2011-04-07  21400  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

