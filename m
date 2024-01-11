Return-Path: <linux-wireless+bounces-1726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D663682B2B9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86075282730
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C933080;
	Thu, 11 Jan 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdpWVDMd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871642066
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989902; x=1736525902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j72tzNFBXb1Jf/FH0rMuyeKs5XP27pnqUyTos2wUsKc=;
  b=FdpWVDMdo+kKoIFQgBrNfOcBA2uf6BDZaTc5dcwWersk4r/91rCtUhfg
   Tu9OCYeqLpZgOmaaxfBOCMPRAeEzOLqWNacRMtUQ5E2tPlGftTvH36Q3H
   ncIiIoYvXAxfTYqtWVtCK+FNLOqzfYEzI9PMbLwel9Hyr1UKPMDTxEJfs
   znwk6yEF6lms5E3yY9a18wMtuH4UyMk//voKFSdCa8xeYnYfZ201GY6Q8
   e1XVPuYMu9QS7x+WjgeT2tpDOVGEH59f8gbp/tk7kUS521K779f77TZm2
   xo/NZ6cYSjJmABFkYk8f/p6Z2bICdk24jGMFWwVRdAE1c1HXtVb/k4Cw0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182469"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182469"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606417"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606417"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] cfg80211/mac80211 patches from our internal tree 2024-01-11
Date: Thu, 11 Jan 2024 18:17:38 +0200
Message-Id: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement:
features, cleanups and bugfixes.

Thanks,
Miri

Benjamin Berg (1):
  wifi: mac80211: use deflink and fix typo in link ID check

Johannes Berg (7):
  wifi: mac80211_hwsim: advertise 15 simultaneous links
  wifi: mac80211: simplify ieee80211_config_bw() prototype
  wifi: mac80211: remove extra element parsing
  wifi: mac80211: simplify HE capability access
  wifi: mac80211: disallow drivers with HT wider than HE
  wifi: mac80211: fix potential sta-link leak
  wifi: mac80211: don't set bss_conf in parsing

 drivers/net/wireless/virtual/mac80211_hwsim.c |   8 +-
 net/mac80211/main.c                           |  18 +++
 net/mac80211/mlme.c                           | 107 +++++++-----------
 net/mac80211/sta_info.c                       |   5 +-
 net/mac80211/util.c                           |  21 +---
 5 files changed, 72 insertions(+), 87 deletions(-)

-- 
2.34.1


