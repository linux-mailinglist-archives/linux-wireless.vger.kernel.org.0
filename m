Return-Path: <linux-wireless+bounces-18818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DBA31EAA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5508418854CD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F31FBCAA;
	Wed, 12 Feb 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4v3EuTO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA41DF751
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341391; cv=none; b=YQe1Ywibui8gz5mewjn28+SZwu5hRkrjfZU/yMAAwWmqvOgrenNNJoI3jQi3UoHlNvsdh4N/71CCSy+pooyEB5exxuRtMKV+FB7TAIWJ4iGZuP8ZMndr8xrqnoF/Ogl7PoS6+k6bPm4cd6K90wSdIULAarnyppk6JXO49ztjRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341391; c=relaxed/simple;
	bh=htbD4UDHftxshWk9tlRKRVrgoQJiLtXeKxcw35JN03s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gUJRASxsD8eSCzveEaeJHEh6BA6uBvB9NCYL9L2JTaTzDQtAnfvfnP8fCN2VEvlOovebQCCPCD2LJAHyoo+dl8kOuxsgNTYE3c9fEQyvkLTgzF1Mfb8AHaBSxG2sFptmewiBIPccY4FrCdsJuso3Bb4QZyBIA8tlTnXPQjv8WXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4v3EuTO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341389; x=1770877389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=htbD4UDHftxshWk9tlRKRVrgoQJiLtXeKxcw35JN03s=;
  b=L4v3EuTOw/LovnCpQ/0C+l0oH0SAcSEy3GjAIoqF5HsJdviKMtcPYMyi
   Ql8QveqR3a0WJPTqMs9So6nv7rcCN2sWwSn8EBJpCA9eO+7dfzG4d4MRL
   wfUf70Z8bBAYJiMTwdQJQkJRo7+I+3jOHEY6lG/8SiVHlpyY+6f/5ceeT
   C0yly4BJbrmJIpM/syb7DW6j+88yfqkvnUiCVVUlTvdi+vEURSrha05WY
   4OIVtveJWySYIoa9xWEDbasBoTfEq5scy4dQ6CDsWcsxYqhnmIiwzwnhX
   Dx6STcuvFjuIWE/L2AuXs1JIWLSwolOuazUojWb88EBcNmiOseqcQlYpz
   Q==;
X-CSE-ConnectionGUID: 3HXEJgu+Q3SmtBLDxaz6rw==
X-CSE-MsgGUID: peKKLh5lQT2t2MLhfSuFxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43637625"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43637625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:09 -0800
X-CSE-ConnectionGUID: ywhM0+jCQ/yZSpOevielkw==
X-CSE-MsgGUID: 1fCAtgmkS2aD6AzSM7uV3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112944130"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:23:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] [WIRELESS] wifi: mac80211/cfg80211: updates-2025-02-12
Date: Wed, 12 Feb 2025 08:22:56 +0200
Message-Id: <20250212062258.454981-1-miriam.rachel.korenblit@intel.com>
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

A small series of features from our internal tree.

Thanks,
Miri
---

Benjamin Berg (1):
  wifi: cfg80211: expose update timestamp to drivers

Miri Korenblit (1):
  wifi: mac80211: add ieee80211_iter_chan_contexts_mtx

 include/net/cfg80211.h |  3 +++
 include/net/mac80211.h | 25 +++++++++++++++++++++++++
 net/mac80211/chan.c    | 20 +++++++++++++++++++-
 net/wireless/core.h    |  1 -
 net/wireless/nl80211.c |  4 ++--
 net/wireless/scan.c    |  6 +++---
 6 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.34.1


