Return-Path: <linux-wireless+bounces-1730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2C82B2BF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813F5B262A4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705AB51C26;
	Thu, 11 Jan 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIFg80IH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276F51C32
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989907; x=1736525907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zb91ZcZcUAyZakCzkah/W//NRl+08+etHGyLn/C0zHY=;
  b=QIFg80IHYrn7M6dVTodHUZU544yDLPgB9szkVfgo40vUKf4CEFoSm9ZK
   KLS5IXFZi7OZ1SglENQENxqTSY7DYNMKc28637KhB9sCoZlQJNWEXxTwM
   bTeeSRuW1cZ4V4IPas8Wji7xsB+lIjUvr1tyddhkoElWeT7A99ZrMYX3J
   mnE1kpEi3qH1aYa9qilE+EtGRf3Wc/yYdcB1hDhQ6Yw/G3eUjYKjzkwm3
   2qtGpm0esBncoKb6VO0vlzOcxGXMWb9veD5LSKmRUaA5DLC8cxHeQdHrV
   Z7tHX5jBta3dnDQvAk4EQ78gDW+h1dvSve+SCKYJ/bhTcCcesFJbpW7jh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182561"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606611"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606611"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/8] wifi: mac80211: simplify HE capability access
Date: Thu, 11 Jan 2024 18:17:42 +0200
Message-Id: <20240111181514.2ef62b43caeb.I8baa604dd3f3399e08b86c99395a2c6a1185d35d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For verifying the required HE capabilities are supported
locally, we access the HE capability element of the AP.
Simplify that access, we've already parsed and validated
it when parsing elements.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 45be270eaab7..5b1bc84760d5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4547,41 +4547,17 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				     const struct cfg80211_bss_ies *ies,
+				     const struct ieee80211_he_cap_elem *he_cap,
 				     const struct ieee80211_he_operation *he_op)
 {
-	const struct element *he_cap_elem;
-	const struct ieee80211_he_cap_elem *he_cap;
 	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
 	u16 mcs_80_map_tx, mcs_80_map_rx;
 	u16 ap_min_req_set;
-	int mcs_nss_size;
 	int nss;
 
-	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
-					     ies->data, ies->len);
-
-	if (!he_cap_elem)
+	if (!he_cap)
 		return false;
 
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
-		sdata_info(sdata,
-			   "Invalid HE elem, Disable HE\n");
-		return false;
-	}
-
-	/* skip one byte ext_tag_id */
-	he_cap = (void *)(he_cap_elem->data + 1);
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
-
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + sizeof(*he_cap) + mcs_nss_size) {
-		sdata_info(sdata,
-			   "Invalid HE elem with nss size, Disable HE\n");
-		return false;
-	}
-
 	/* mcs_nss is right after he_cap info */
 	he_mcs_nss_supp = (void *)(he_cap + 1);
 
@@ -4946,7 +4922,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
+		if (!ieee80211_verify_peer_he_mcs_support(sdata,
+							  (void *)elems->he_cap,
+							  he_oper) ||
 		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
 			*conn_flags |= IEEE80211_CONN_DISABLE_HE |
 				       IEEE80211_CONN_DISABLE_EHT;
-- 
2.34.1


