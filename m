Return-Path: <linux-wireless+bounces-16964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC759FF2DF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9DE3A11EE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6FEEAB;
	Wed,  1 Jan 2025 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ly726prG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7EF9F8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707976; cv=none; b=qO5JCHWp50QiH2fHX/diipMffZGnBeuMcHD+AciVbHarT2e/jmcPlsUBtKdcvD4mQeVFd3Ay8ui56b/LdDfLeQELn3VnY/R4tEjWQTd1n8D3GbyMCguqydMurWYGmjFzNyrkMwt3v2leCXGMxN9n4TjxS3be9HSv0NVw8V07HwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707976; c=relaxed/simple;
	bh=plnFdpxI3y7G8VTeBDBpvsvJu5uO7Lwher5hBDY2c4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQ9Z5w6XRco0zUPdDI7kXeQyr54Un82zCKDOrfBFAeIytA8BEZ6gs6+v/s6UsFbAdIj1uXkwBuByAk8xKKc856nV3vH/XOQgIocM5c5n85hL/9CKMbIIVb8eC0Bd5K/FaDUf5ZEiHNCyDlsD5Hsv44hYP6QDGdEJFpNinQqM3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ly726prG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707974; x=1767243974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=plnFdpxI3y7G8VTeBDBpvsvJu5uO7Lwher5hBDY2c4w=;
  b=ly726prGMyt8T+r2pXmAYQPI0TBZKum+GRbgaCnx+SkbzCp69i4TmDXR
   +7m8IoOAZz/O8DczuaehX4o9d/XjvERDtdc9MyUxMJVyIBy2foRqcEbRL
   qKGEZQc8kNpsPgRzbe0aWtSf5E9AFxZBjKhIAOG5Br8rsDfN8b0HQ5OHD
   ICaxuRvXInYRoSiPQELztrxdRgycFk4liCM9gKSkf8YdrdLeV9WhlbSym
   xGRGckOmWDnrsZ7AFipnLWkYVKRXJm6mhyhz1LkqhtkPUZUbmRfuaLEv6
   IsfIle0cTVKOZn23My6HP1pj9U6bX7lEc9CdjZrMgBxkRls73TBSnPO3t
   A==;
X-CSE-ConnectionGUID: 5NEw8AroSe+T+VYPouoVcw==
X-CSE-MsgGUID: iTFA+k0OQ3ezoCUIsPJBVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194439"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:14 -0800
X-CSE-ConnectionGUID: 9Cze3sriSdSzD1FMwlPSwQ==
X-CSE-MsgGUID: 03tJr4BsTjy7+nbwV4qgFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618935"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/19] wifi: mac80211: parse BSS selectors and unknown rates
Date: Wed,  1 Jan 2025 07:05:34 +0200
Message-Id: <20250101070249.76433fd3d69f.I94e8718de26ab32282b60ae257b8c6c334b7c528@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Doing so enables further checking whether we are implementing the
requested features. Also allow passing in NULL for more parameters as
they may not be needed by the caller.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc9bf79d631f..a1197ac68c98 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4732,6 +4732,7 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 				u8 *supp_rates, unsigned int supp_rates_len,
 				u32 *rates, u32 *basic_rates,
+				unsigned long *unknown_rates_selectors,
 				bool *have_higher_than_11mbit,
 				int *min_rate, int *min_rate_index)
 {
@@ -4741,7 +4742,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 		int rate = supp_rates[i] & 0x7f;
 		bool is_basic = !!(supp_rates[i] & 0x80);
 
-		if ((rate * 5) > 110)
+		if ((rate * 5) > 110 && have_higher_than_11mbit)
 			*have_higher_than_11mbit = true;
 
 		/*
@@ -4751,8 +4752,11 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 		 *	 rate flag share the same bit, they are not exactly
 		 *	 the same.
 		 */
-		if (supp_rates[i] >= (0x80 | BSS_MEMBERSHIP_SELECTOR_MIN))
+		if (is_basic && rate >= BSS_MEMBERSHIP_SELECTOR_MIN) {
+			if (unknown_rates_selectors)
+				set_bit(rate, unknown_rates_selectors);
 			continue;
+		}
 
 		for (j = 0; j < sband->n_bitrates; j++) {
 			struct ieee80211_rate *br;
@@ -4762,16 +4766,22 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 
 			brate = DIV_ROUND_UP(br->bitrate, 5);
 			if (brate == rate) {
-				*rates |= BIT(j);
-				if (is_basic)
+				if (rates)
+					*rates |= BIT(j);
+				if (is_basic && basic_rates)
 					*basic_rates |= BIT(j);
-				if ((rate * 5) < *min_rate) {
+				if (min_rate && (rate * 5) < *min_rate) {
 					*min_rate = rate * 5;
-					*min_rate_index = j;
+					if (min_rate_index)
+						*min_rate_index = j;
 				}
 				break;
 			}
 		}
+
+		/* Handle an unknown entry as if it is an unknown selector */
+		if (is_basic && unknown_rates_selectors && j == sband->n_bitrates)
+			set_bit(rate, unknown_rates_selectors);
 	}
 }
 
@@ -5246,7 +5256,8 @@ static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
 	ieee80211_get_rates(sband, bss->supp_rates, bss->supp_rates_len,
-			    &rates, &basic_rates, &have_higher_than_11mbit,
+			    &rates, &basic_rates, NULL,
+			    &have_higher_than_11mbit,
 			    &min_rate, &min_rate_index);
 
 	/*
-- 
2.34.1


