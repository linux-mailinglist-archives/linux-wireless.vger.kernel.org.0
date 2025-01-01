Return-Path: <linux-wireless+bounces-16967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CC9FF2E2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FE3A1A7F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD376026;
	Wed,  1 Jan 2025 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmeEniov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86554199B8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707980; cv=none; b=P7wkhQC/0BhRRpu8niE6gBZIUuVavFqgHJuIxPAMdo9SLcxktG3pjIAZIVYdnfTgqGWFz8CJ3r5Hsr4Y/qW8EzoEpLbUOrmveazEHehpMkRUjsSgDKiD8qCgNLeOZPzdhOxNG+hK+lp7LHiVMYyzm73TSD05oLu1bUtkFhSFP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707980; c=relaxed/simple;
	bh=QeoWlQXjvNU7dq0jKQvPpid73pY0C6L3L0/Cyzq+qn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xcsmaq+1D0LuDGE1zoPnB0qZqdnnA1xpiN0J4tkFyVFCwbRtEyp+2S1TE2afDC2iwA05q7WumFL+TPqxFjncgIBitiJYe3k6wtGaq8DWDC7gjoWJVm8dwpyeViUrYrAEV6HKCWV6P/K+tDLRFejBnrxAaX4Lj2GBYjJeM5HZb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmeEniov; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707979; x=1767243979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QeoWlQXjvNU7dq0jKQvPpid73pY0C6L3L0/Cyzq+qn0=;
  b=dmeEniovsQ9ox7lM2guTEFOAUbczxypAV9mj8XW5dm9jlIrdAnGPCiJm
   QoMIoPA3UZCljQNvU8UpmvFKJmoCpfwYeZ1cGTLzj2uCygE7zycukXLm2
   Df4tOyYaRgC/4krMpFkt47+v39DATRi5Xz+pGs5ObEDAtEWe3aODrh9hN
   oc++ycnow0+1/bRwDX1sf60JZzTnctByOqungPTiGGYIGRagTQCQrFjjU
   pn5vGhQDHfnAHy63s3Iwr8YvRYAGcsxD6q9SMx6AhP8h+DxHksXu9bwe7
   Xop5fT3XDJKkVfyR1BeqpmG7VDMt1zIHDQ/kf4frqcbQ+eoQb42jNNalp
   w==;
X-CSE-ConnectionGUID: 8XMyy0wxTTOe5Kx0FOrcmA==
X-CSE-MsgGUID: wGj4Pw8DTtOk7jYuuA984A==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194446"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194446"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:18 -0800
X-CSE-ConnectionGUID: usmr4n2FQXGlY6B8UBgmvw==
X-CSE-MsgGUID: ni4YEIYKT0mCmd6N8hi+rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618945"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/19] wifi: mac80211: also verify requirements in EXT_SUPP_RATES
Date: Wed,  1 Jan 2025 07:05:37 +0200
Message-Id: <20250101070249.f1840f19afa7.I12e3a0e634ce7014f5067256d9a6215fec6bf165@changeid>
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

Parse both the Supported Rates and BSS Membership Selectors as well as
the extended version of the tag when verifying whether we support all
features.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9735ce4adffe..d2ce5264923e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -697,6 +697,8 @@ ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 				const u8 *supp_rates,
 				unsigned int supp_rates_len,
+				const u8 *ext_supp_rates,
+				unsigned int ext_supp_rates_len,
 				u32 *rates, u32 *basic_rates,
 				unsigned long *unknown_rates_selectors,
 				bool *have_higher_than_11mbit,
@@ -704,9 +706,12 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 {
 	int i, j;
 
-	for (i = 0; i < supp_rates_len; i++) {
-		int rate = supp_rates[i] & 0x7f;
-		bool is_basic = !!(supp_rates[i] & 0x80);
+	for (i = 0; i < supp_rates_len + ext_supp_rates_len; i++) {
+		u8 supp_rate = i < supp_rates_len ?
+				supp_rates[i] :
+				ext_supp_rates[i - supp_rates_len];
+		int rate = supp_rate & 0x7f;
+		bool is_basic = !!(supp_rate & 0x80);
 
 		if ((rate * 5) > 110 && have_higher_than_11mbit)
 			*have_higher_than_11mbit = true;
@@ -1027,6 +1032,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	sband = sdata->local->hw.wiphy->bands[channel->band];
 
 	ieee80211_get_rates(sband, elems->supp_rates, elems->supp_rates_len,
+			    elems->ext_supp_rates, elems->ext_supp_rates_len,
 			    NULL, NULL, unknown_rates_selectors, NULL, NULL,
 			    NULL);
 
@@ -5287,6 +5293,7 @@ static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
 	ieee80211_get_rates(sband, bss->supp_rates, bss->supp_rates_len,
+			    NULL, 0,
 			    &rates, &basic_rates, NULL,
 			    &have_higher_than_11mbit,
 			    &min_rate, &min_rate_index);
-- 
2.34.1


