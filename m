Return-Path: <linux-wireless+bounces-16954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15D9FF2D5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5638B3A0125
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97431EEAB;
	Wed,  1 Jan 2025 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOP0143O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04011799F
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707960; cv=none; b=qUUwJNz5nforukfYOG0ITZwyJ9GPileKXOTJ/r/EUfIox+5/sseoKTQZTNQ5WQhXxHBqFJbMximWhIlo1IhLm5K1z/MKhcKWL2+0WZg+4uHCReYOtXlHLFbCS4sYCn+/dkwoPfb2CoTZherLhAfeVrLjtIJZ7zkvdgxA8hBvjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707960; c=relaxed/simple;
	bh=svEIVfxwLoYVMmVs55FX65H/bNtF1p/CDXdPlQIvrMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+SsEArUPhvdbZK8BleWZ7gHd5E0FHLI8RNHUov3SnnqQ9hbF/BFShdF19c/7UwWafW6Picq8bctKHz22eJ1AMbpMfmBM+XBZSEJwePY9LvE2zhFBKiHn513g5KsgGdW7QA8VI59Cb9cm+Rkl2kGiRemAPqBnqwLoEAhyQeDHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOP0143O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707959; x=1767243959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svEIVfxwLoYVMmVs55FX65H/bNtF1p/CDXdPlQIvrMw=;
  b=WOP0143OgtQ5+7TAe7XTVampcXfZbeWK+YrafTDVIRGRx9kjCJ7mVzOG
   TUHA/Yeafe06hK3QCDIcc9l2M4HufEAvU0oRyd8aPaA6/vZ+rKU6gl7aS
   lHAIttd6b630zOqV3SOiD3qYpns62F60aKy1IeRHzvyoI8sOJrRbh9uSI
   hEq9Vjxtjdj+cXkhIxl+49MKBEFkpYCzj8ZFngveILdw5BfqKoZk/yrYf
   m9hRDNtrQX5MUmMVhduGq5kQJYQZcf4IpLgLtxzuRspP1qwDGbyTxeHAn
   6HAgTWJxstm/s6CDKDQRan5BqcgU+aonlTRRKjafYcFUJuGumw0JCl5xs
   w==;
X-CSE-ConnectionGUID: qRJ4L/sURWCNs0HMCMANyQ==
X-CSE-MsgGUID: PdKvJtYlTdGAP7UXYo0NwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194403"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194403"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:59 -0800
X-CSE-ConnectionGUID: g+PM1m2bSymgrx0pa/YmnA==
X-CSE-MsgGUID: uwN38CqhSwKd/jbLc6abFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618879"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/19] wifi: mac80211: reject per-band vendor elements with MLO
Date: Wed,  1 Jan 2025 07:05:24 +0200
Message-Id: <20250101070249.bb82d3aaf6ef.Ib30573d0666430a3d7a905e513dfc661edf0bf65@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The MLME code doesn't currently handle adding vendor elements
correctly with multi-link due to element inheritance. Simply
prevent that for now completely, if someone needs it we can
fix this later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f13c14fa82e8..53e5aee46885 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1310,6 +1310,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
 				return -EINVAL;
+
+			/* no support for per-band vendor elems with MLO */
+			if (WARN_ON(iftd->vendor_elems.len &&
+				    hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO))
+				return -EINVAL;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
-- 
2.34.1


