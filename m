Return-Path: <linux-wireless+bounces-18444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7567A278D3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8037A1E06
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0F216E1E;
	Tue,  4 Feb 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFXEP0pA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF252163B8
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691004; cv=none; b=QZXnptNN6J8yrbRCMnzijTianTMbJzC1mc6MGX6ljmbFqKZdwx1AqiflWeu9KDJV4vMqozHgj3bHpB02UlqaxLZbM9264vqo13C0PXAbKdTBcZzOOuHX3J3CBwR4SYCM807EJx0HjKWYnkXvjHCzwAaq7P9IuKziIRiYGi81+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691004; c=relaxed/simple;
	bh=8eTm20hmGpyDvugvvhZn/1PncFdpyQmulQO95uwq0lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCq+tUkFDGBSyAvDiu0kF/B9Kc6Lyruv8CwW3TL3UHP6F9KAtg105EgcF3g0p/1itWD6dBHmhtxXYAemFx3J+F1oPwbY+nlYU7C9M18kDW4NwNiCHd/b52iZw1iAvON7/n+H2LMpitcxMvKpcSwOEeSw1NdETsIKyaE08j4pYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFXEP0pA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691003; x=1770227003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8eTm20hmGpyDvugvvhZn/1PncFdpyQmulQO95uwq0lg=;
  b=hFXEP0pA2HjW/IMVjPV6R4+TUUeCkrX072vDcGgbhAOh4XbeFIs0/aHH
   Ak1qd5JkBZJxG+2wwB+AgKoyrnjC5RjO7kgyZiiknawPckka2pShmZWfI
   QQdd63K/oxJqbNbVvHJ71DvtXlBhqkKq1UDw3NCt21J1adDQTDFeMEy6T
   +SUrqheO3AsBV6utJ7i5K3Y87PyKA8HGehv4K+BJ0gnDAfiqCgSDt4NvJ
   N6kUiQqgb7ttMYQGSHCVIzywFfOdTsR970lP8yeDdJdgwJ+bgpV/MHH5K
   1CUexc3ypgTIvIA3k0Z9nGNSI6DUskLbYT+8QhOkQd+JOweffLHCLfN+I
   g==;
X-CSE-ConnectionGUID: e6+54/fVQnKFl6gEnJ0gqQ==
X-CSE-MsgGUID: sIxyceYtToSEpl++P/PyCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585404"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585404"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:46 -0800
X-CSE-ConnectionGUID: sjl5YTM5ST20kTgvIVBIhQ==
X-CSE-MsgGUID: oM4ViSgCRBqEmzAMgCy/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696740"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 07/20] wifi: mac80211: fix vendor-specific inheritance
Date: Tue,  4 Feb 2025 19:42:04 +0200
Message-Id: <20250204193721.3083f73acdf3.I9db3e6a3367e6ff38d052d07dc07005f0dd3bd5c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If there's any vendor-specific element in the subelements
then the outer element parsing must not parse any vendor
element at all. This isn't implemented correctly now due
to parsing into the pointers and then overriding them, so
explicitly skip vendor elements if any exist in the sub-
elements (non-transmitted profile or per-STA profile).

Fixes: 671042a4fb77 ("mac80211: support non-inheritance element")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/parse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 3d5d6658fe8d..6da39c864f45 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -48,6 +48,7 @@ struct ieee80211_elems_parse {
 	const struct element *ml_epcs_elem;
 
 	bool multi_link_inner;
+	bool skip_vendor;
 
 	/*
 	 * scratch buffer that can be used for various element parsing related
@@ -400,6 +401,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (elems_parse->skip_vendor)
+				break;
+
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
 				/* Microsoft OUI (00:50:F2) */
@@ -1054,12 +1058,16 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		multi_link_inner = true;
 	}
 
+	elems_parse->skip_vendor =
+		cfg80211_find_elem(WLAN_EID_VENDOR_SPECIFIC,
+				   sub.start, sub.len);
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
 	/* Override with nontransmitted/per-STA profile if found */
 	if (sub.len) {
 		elems_parse->multi_link_inner = multi_link_inner;
+		elems_parse->skip_vendor = false;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-- 
2.34.1


