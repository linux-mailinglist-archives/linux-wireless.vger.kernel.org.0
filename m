Return-Path: <linux-wireless+bounces-28760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F6C4687F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E8B3B3FCC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012B3128AC;
	Mon, 10 Nov 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIv7rPV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C63128A7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776639; cv=none; b=o3aHeV72AH9Eo1vbF2q7nEA75ol81RvdKl5jHNqrbkMv7amjws1vk6m5qg/LtrSpsghRhIDcuHiW2u/57Sdhce7DC7iA15wQjMPgI3dCLmDd786/NGLAa1PLs2jLJls+tL78++Q4CcdvxyQVX+kMw+1oODdGKzgn+fgIgQ++bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776639; c=relaxed/simple;
	bh=SS+6dwlzqjnfTgu+rLgE35578AP+QkyqVb5857z97kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ib7LPeomzQBviDvP1HMSY9RwzAENq2TDy6cQHzQauRWNWW6yylAQJCZwouTr2vCJ40erRFBMhAEPK5m5AdIuhlsMp3g75MD8SWmjluakv9diIpQq6H/tBFMHkB8RTvp73v0NpHJ/jhd1tdX0x7vmyTFrQ7B8aS31/kUs/iw3VUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIv7rPV2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776639; x=1794312639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SS+6dwlzqjnfTgu+rLgE35578AP+QkyqVb5857z97kA=;
  b=bIv7rPV2WM81YksU9UpKJsJW5sG/9+APM2oaqesRzcKSvAq208ua4krz
   NnRXio4JyTOs1WwgEo3h3mlTjwDuPiIObKsvojmme1ifu48v3gcsz2Bvk
   auvqO0kNL6t5iQDJr/VzOrSFLL6FEaoHoX+d8qY0KpeVmvBagcXBd+hH9
   Lh7P2buQUbX8HwVhxiKsPh1sVPbpknKxZG6GfheWNDM2uvlYHgxed9Waz
   iM69oSekDhT6gjANRE42BKLlmEYXOSdnjzRfJnjYRSSjuX0W+svvvnbnP
   AdDVC9CCCUK/HSKIoX15Kv2+5xuPCD2eJmb2G4r1rzN3T23x4SkrwwZir
   Q==;
X-CSE-ConnectionGUID: 3sg5/8gART6gdZrFBvIc3A==
X-CSE-MsgGUID: gO5f0kC5TLu9tOHs11JFxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64865006"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64865006"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:38 -0800
X-CSE-ConnectionGUID: tUlmEQHSRWKgPXYp3XPhCA==
X-CSE-MsgGUID: GAfOYBahRK+yPO56j4NuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192918059"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:10:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: fallback to to INDOOR_SP
Date: Mon, 10 Nov 2025 14:10:28 +0200
Message-Id: <20251110121030.61765-1-miriam.rachel.korenblit@intel.com>
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
This series contains two commits that are adding a fallback to INDOOR_SP
ap type when SP is not permitted.

Pagadala Yesu Anjaneyulu (2):
  wifi: cfg80211/mac80211: clean up duplicate ap_power handling
  wifi: cfg80211/mac80211: Add fallback mechanism for INDOOR_SP
    connection

 include/net/cfg80211.h | 29 +++++++++++++++++++++++++++++
 net/mac80211/mlme.c    | 21 ++-------------------
 net/wireless/core.h    |  3 ++-
 net/wireless/nl80211.c |  4 ++--
 net/wireless/scan.c    | 20 ++++----------------
 5 files changed, 39 insertions(+), 38 deletions(-)

-- 
2.34.1


