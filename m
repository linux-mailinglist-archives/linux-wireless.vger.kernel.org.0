Return-Path: <linux-wireless+bounces-13662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E48993DA6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87D62845C7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 03:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D341A8E;
	Tue,  8 Oct 2024 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJVwAZqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720020326
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359075; cv=none; b=umvtck1sVA6Z6SjL13v1k9HZFNuXzuBy+fJtnvK6yAkftgxzsaIbnHorhyDBGsoHAoc610B/FZ4AfV4QzDjKS7+Ea6a2+H6rDan3gEB84ULMyxQX2sKNeA2J/xmjfszWYwxq3V4oKlXSNgsZiK6P1hpAXE7b71necomAw1g+FUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359075; c=relaxed/simple;
	bh=t38oO43m1md2e4pDjiGPrrk7SDGe4ACd9jC451zTc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8wAS68fRIFqmaZwXTclELnY8r8i3mWNg8+ZKZsMwawsfVw0roAqVCBjd8MHZTaEC3JipIrdAZinhLnRidXrzsT0qmpZjNFvD6kOspySEvGRcd8hg3waoNl48QJZmZZGavXDd9LdLnFM1oQGpmd1BxOx8Nf2BHIFdxYgni7H3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJVwAZqr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728359074; x=1759895074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t38oO43m1md2e4pDjiGPrrk7SDGe4ACd9jC451zTc7A=;
  b=EJVwAZqrSzwHhG7ym0fCSSkzyZoE68Xt0nkSw7QzFhQdiCt+36Yq0BaD
   ieQ8DQ2Vdjg6qRz0K5jfg/VbBHj32g9v5IjDsqOoNfqkvdOn7RDMmFaNL
   UeDtM5CyZ5Vy9ig6qHhAeuMQq7DS4oadINtiBptgcKNoRrkl6WxDcAXkt
   gtMoNzj3BrRJkNxr0sca8dgTV11SCbtZiFOLKgGZ9pYGj2Yfv2mFMP0it
   49k4NsSbG3+awKzZXemNn2P0lH9/985oHocaFYld11x2iV5m4V/20zXQM
   lOX+DsAKPguV9spnDHNRqXdC7kIrj7gOLaGcGPTm4+zoOSESkovIgMJR8
   g==;
X-CSE-ConnectionGUID: /hID6o4IT7O7GHmx1ufPTQ==
X-CSE-MsgGUID: YObE2+FAR9+0rvbqpkUCRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="26990130"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="26990130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 20:44:33 -0700
X-CSE-ConnectionGUID: x4junqR4THe27dpS2PwkTA==
X-CSE-MsgGUID: aN/yyEqeTNKJeoWMsfVR9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75254969"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Oct 2024 20:44:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy19B-0005rw-36;
	Tue, 08 Oct 2024 03:44:29 +0000
Date: Tue, 8 Oct 2024 11:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	johannes@sipsolutions.net
Subject: Re: [PATCH v3 06/11] wifi: cfg80211: pass net_device to
 .set_monitor_channel
Message-ID: <202410081114.ZC1D90Ua-lkp@intel.com>
References: <567010510413a90f26e8f045b60243624d97a225.1728063865.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567010510413a90f26e8f045b60243624d97a225.1728063865.git-series.nbd@nbd.name>

Hi Felix,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/wifi-cfg80211-add-option-for-vif-allowed-radios/20241005-043111
base:   5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
patch link:    https://lore.kernel.org/r/567010510413a90f26e8f045b60243624d97a225.1728063865.git-series.nbd%40nbd.name
patch subject: [PATCH v3 06/11] wifi: cfg80211: pass net_device to .set_monitor_channel
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241008/202410081114.ZC1D90Ua-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081114.ZC1D90Ua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081114.ZC1D90Ua-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/wireless/trace.c:5:
   In file included from net/wireless/trace.h:4113:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> net/wireless/trace.h:1335:34: error: no member named 'center_freq' in 'struct trace_event_raw_rdev_set_monitor_channel'
    1335 |                   WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_PR_ARG)
         |                                                ^~~~~~~~~~~
   net/wireless/trace.h:135:45: note: expanded from macro 'CHAN_PR_ARG'
     135 | #define CHAN_PR_ARG __entry->band, __entry->center_freq, __entry->freq_offset
         |                                    ~~~~~~~  ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
       9 | #define TP_printk(fmt, args...) fmt "\n", args
         |                                           ^~~~
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
      45 |                              PARAMS(print));                   \
         |                                     ^~~~~
   include/linux/tracepoint.h:106:25: note: expanded from macro 'PARAMS'
     106 | #define PARAMS(args...) args
         |                         ^~~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   1 error generated.


vim +1335 net/wireless/trace.h

  1319	
  1320	TRACE_EVENT(rdev_set_monitor_channel,
  1321		TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
  1322			 struct cfg80211_chan_def *chandef),
  1323		TP_ARGS(wiphy, netdev, chandef),
  1324		TP_STRUCT__entry(
  1325			WIPHY_ENTRY
  1326			NETDEV_ENTRY
  1327			CHAN_DEF_ENTRY
  1328		),
  1329		TP_fast_assign(
  1330			WIPHY_ASSIGN;
  1331			NETDEV_ASSIGN;
  1332			CHAN_DEF_ASSIGN(chandef);
  1333		),
  1334		TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_PR_FMT,
> 1335			  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_PR_ARG)
  1336	);
  1337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

