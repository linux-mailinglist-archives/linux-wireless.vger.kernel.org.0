Return-Path: <linux-wireless+bounces-13590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E6992AEF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B4BB24031
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF51D2708;
	Mon,  7 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQxhVcmV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D091BA285
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302481; cv=none; b=AmenJN9i3Spz6hy+jjjpI/EycXj/y5jnhGJL6SjZB4dCUXLc8MAKy7WgnWX6IHtHBaaR4U3GqGH+x/UFOgtk+4LgpxF5nqP1W6rrR8rVzxj07HB3vCirDfsblTxnAAvhranpV3suvEbMyqyxL9ixzpoNDjS/5sazk1jOB2lpF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302481; c=relaxed/simple;
	bh=zOO8STbzskL7Kxv/kqp9rw/Z0gjKToQHeOhBq8JheCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgeBc3pNk8poqV4tyVZeeNPlv8/okhmLBqFvm61/790lnU5CUQpNq7/l0TDPy8rx0z3B4Ei6aksMuWrwGRGy/LJ9942dspIMcECcWVSP2Qo35ELY9BLBPR2vbpalLCJZyq/BanreFCQqF5fOisPEFyHgzaI66rqWT8E7snGbmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQxhVcmV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302480; x=1759838480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zOO8STbzskL7Kxv/kqp9rw/Z0gjKToQHeOhBq8JheCY=;
  b=eQxhVcmVBLW02E/Zobhrduq0DivZrsfWyxT3fZ0hXBVwL2KA75XMpH32
   u6JJxtAlCJfb562CSl/LDkvw/l31lq4UohHvfiOT9NOfteEcEJb5mT0sE
   vg4lNaTrGDzTk7vMCoRxKB2UXA7Sw3Qh92eR+AzNeXSvTbUmMat58CZFr
   48C9BOZY+177u0XtnrsF7jakji9Zz2s6OLsUiKpGcE+2VJLRxtO8PhJqY
   U8Dpb1dRzFYyZvfJLR8xA0KXPu2aMe8UYaCvk6ca7gymMMX1W+r2IlOoi
   FINRpFbg93hH6aPTalZoSXNblKmnFJTjtjfm/DoCY6w86uK3XVWJB0bUT
   A==;
X-CSE-ConnectionGUID: i8/A4AcYSqa89AvKexfExg==
X-CSE-MsgGUID: 79/abqqEQKmZe9x3Q+fvzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099386"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:20 -0700
X-CSE-ConnectionGUID: qmfoIljWQLClcAIBEOeBkw==
X-CSE-MsgGUID: 0GrGfw5JSNy+0YbJjlAXQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019255"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/14] wifi: mac80211: remove unneeded parameters
Date: Mon,  7 Oct 2024 15:00:49 +0300
Message-Id: <20241007144851.3ea505cd74e7.Id416127544afd80e4fe7b275b612aef511fc64ed@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

ieee80211_find_80211h_pwr_constr and ieee80211_find_cisco_dtpc don't
need the pointer to struct ieee80211_sub_if_data *sdata. Remove it and
it'll be one step closer to handle the power constraints per-link.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc8399de8e6d..e791f75a09a4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2727,8 +2727,7 @@ ieee80211_mgd_update_bss_param_ch_cnt(struct ieee80211_sub_if_data *sdata,
 }
 
 static bool
-ieee80211_find_80211h_pwr_constr(struct ieee80211_sub_if_data *sdata,
-				 struct ieee80211_channel *channel,
+ieee80211_find_80211h_pwr_constr(struct ieee80211_channel *channel,
 				 const u8 *country_ie, u8 country_ie_len,
 				 const u8 *pwr_constr_elem,
 				 int *chan_pwr, int *pwr_reduction)
@@ -2798,8 +2797,7 @@ ieee80211_find_80211h_pwr_constr(struct ieee80211_sub_if_data *sdata,
 	return have_chan_pwr;
 }
 
-static void ieee80211_find_cisco_dtpc(struct ieee80211_sub_if_data *sdata,
-				      struct ieee80211_channel *channel,
+static void ieee80211_find_cisco_dtpc(struct ieee80211_channel *channel,
 				      const u8 *cisco_dtpc_ie,
 				      int *pwr_level)
 {
@@ -2833,7 +2831,7 @@ static u64 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
 	    (capab & cpu_to_le16(WLAN_CAPABILITY_SPECTRUM_MGMT) ||
 	     capab & cpu_to_le16(WLAN_CAPABILITY_RADIO_MEASURE))) {
 		has_80211h_pwr = ieee80211_find_80211h_pwr_constr(
-			sdata, channel, country_ie, country_ie_len,
+			channel, country_ie, country_ie_len,
 			pwr_constr_ie, &chan_pwr, &pwr_reduction_80211h);
 		pwr_level_80211h =
 			max_t(int, 0, chan_pwr - pwr_reduction_80211h);
@@ -2841,7 +2839,7 @@ static u64 ieee80211_handle_pwr_constr(struct ieee80211_link_data *link,
 
 	if (cisco_dtpc_ie) {
 		ieee80211_find_cisco_dtpc(
-			sdata, channel, cisco_dtpc_ie, &pwr_level_cisco);
+			channel, cisco_dtpc_ie, &pwr_level_cisco);
 		has_cisco_pwr = true;
 	}
 
-- 
2.34.1


