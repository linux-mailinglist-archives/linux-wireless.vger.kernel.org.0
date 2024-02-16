Return-Path: <linux-wireless+bounces-3667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF4857C21
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028E21C211E7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69877F2A;
	Fri, 16 Feb 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5g2V1kR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893B1BC57
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084486; cv=none; b=qi3Kpg46i3Ph3mA9NX+/rOhp94ZbSC+ZUk6IDGIHsaL14x5Wvsa0BYOJTqmCOKKXDLlk9fDuPRePyJjj9V700Tl7x09JUa+q5fWc7Wn7qf1SBcBpY0qWWNpcGAIuA3H+D5yhRJOdMTefOGN1ujn7y0TiRykmAonNSly/QGUcjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084486; c=relaxed/simple;
	bh=sQ6HYpECoCd36K5v/ImzXvCNOz4dvC8Xo6a9p+bZVvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ok7bn1yIfXP75nM7vn6Z1QVrxfvUqoXmVuDOsYl7YIFpKebe1CdLY1x7ZPDTT51af9TvpME1Q68BP87WHu99PZHOJfD44cgVdLDEpNra8J7jCr8aYMftHohJHcd4+VhDvmnmONenxM9UZ9d4H+QYc6kkTCy8oHpVfiS/6l63gTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5g2V1kR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084485; x=1739620485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQ6HYpECoCd36K5v/ImzXvCNOz4dvC8Xo6a9p+bZVvA=;
  b=L5g2V1kRWHG9nZ+G76W+ZaIiN+v0pw3PHQR0AK91RcAxGZdpIlsgKqyl
   A8lO/KumtUvnVCNv6kzyMziut+FmaQltDsKfwpRCq4alHpcnCbhW0hTrx
   Wep9Jt9die+c/kmtnTHmk4LQllYf+Pxjt9Rno7CoRBTnrLTUJEaIRdsCZ
   CeJtMSwtb1AWcSZT30iQ/mHS6dgnt/Dn/ZcEZREVn0kNzV/3yq8oWam7K
   cMBrE2WXZTMhIHgpaKkp2KEtLQzNxE/5odV2prk2pG5LvDi6pqpNQtsEZ
   MaUSnjY+TUl8beebadvm/0BUoUD18RYmpQqD7gWbINILh3BITvoVnZYws
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321903"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795583"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/7] cfg80211/mac80211 patches from our internal tree 2024-02-16
Date: Fri, 16 Feb 2024 13:54:26 +0200
Message-Id: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
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
  wifi: cfg80211: set correct param change count in ML element

Johannes Berg (5):
  wifi: cfg80211: remove cfg80211_inform_single_bss_frame_data()
  wifi: cfg80211: clean up cfg80211_inform_bss_frame_data()
  wifi: cfg80211: refactor RNR parsing
  wifi: mac80211: align ieee80211_mle_get_bss_param_ch_cnt()
  wifi: cfg80211: use ML element parsing helpers

Miri Korenblit (1):
  wifi: mac80211: parse the BSS Load element

 include/linux/ieee80211.h  |  67 +++-
 include/net/cfg80211.h     |   2 +
 include/net/mac80211.h     |   7 +
 net/mac80211/ieee80211_i.h |   1 +
 net/mac80211/mlme.c        |  14 +-
 net/mac80211/parse.c       |   8 +
 net/wireless/scan.c        | 615 ++++++++++++++++---------------------
 7 files changed, 358 insertions(+), 356 deletions(-)

-- 
2.34.1


