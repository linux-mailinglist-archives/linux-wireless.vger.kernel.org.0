Return-Path: <linux-wireless+bounces-1397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB982221B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898A8284215
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580015E90;
	Tue,  2 Jan 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUjzxvhr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1315E96
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224170; x=1735760170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KVgqo7tjd+OCWP1VRbpQRLiVUBjytSZPsP3iPozB98=;
  b=fUjzxvhrBC7bUb636d7oLtl6YLzCXJOzRucgN0jZIjHJFN6mwTglkhFT
   C1jIEGOOkf1n7hbTyzKM5SBkcYhgfCsLF/Y9NIsa7TUS1lxtnIkHeOjjS
   OTokhO1XDzVI7I+TZWE8N6qp/2kYuav3aCRMeNk+lPWkTu1GhQcBtHkPI
   8boRANUGv8nzZcifJObL5EpSsWqTG1IUbT8ij9BMdBp8raB7n5Ixpevuu
   tRfP6L5UaUp2yTHNZ3dV3N2PAkdJWLU0+ML2zcDkmtgkbcLZwn0I9siXe
   lh1OIEAnwUDfGnxkODjMnnf1vu/VC6WAaVaGzkI4TbKCZ6ZvstBBj6L9g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314295"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624451"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624451"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] wifi: cfg80211: parse all ML elements in an ML probe response
Date: Tue,  2 Jan 2024 21:35:31 +0200
Message-Id: <20240102213313.6635eb152735.I94289002d4a2f7b6b44dfa428344854e37b0b29c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

A probe response from a transmitting AP in an Multi-BSSID setup will
contain more than one Multi-Link element. Most likely, only one of these
elements contains per-STA profiles.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 019208f6be77..42555753b947 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2614,10 +2614,12 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 	return 0;
 }
 
-static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
-				       struct cfg80211_inform_single_bss_data *tx_data,
-				       struct cfg80211_bss *source_bss,
-				       gfp_t gfp)
+static void
+cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
+				struct cfg80211_inform_single_bss_data *tx_data,
+				struct cfg80211_bss *source_bss,
+				const struct element *elem,
+				gfp_t gfp)
 {
 	struct cfg80211_inform_single_bss_data data = {
 		.drv_data = tx_data->drv_data,
@@ -2626,7 +2628,6 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		.bss_source = BSS_SOURCE_STA_PROFILE,
 	};
 	struct ieee80211_multi_link_elem *ml_elem;
-	const struct element *elem;
 	struct cfg80211_mle *mle;
 	u16 control;
 	u8 ml_common_len;
@@ -2637,15 +2638,7 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	const u8 *pos;
 	u8 i;
 
-	if (!source_bss)
-		return;
-
-	if (tx_data->ftype != CFG80211_BSS_FTYPE_PRESP)
-		return;
-
-	elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
-				      tx_data->ie, tx_data->ielen);
-	if (!elem || !ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
+	if (!ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
 		return;
 
 	ml_elem = (void *)elem->data + 1;
@@ -2820,6 +2813,25 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	kfree(mle);
 }
 
+static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
+				       struct cfg80211_inform_single_bss_data *tx_data,
+				       struct cfg80211_bss *source_bss,
+				       gfp_t gfp)
+{
+	const struct element *elem;
+
+	if (!source_bss)
+		return;
+
+	if (tx_data->ftype != CFG80211_BSS_FTYPE_PRESP)
+		return;
+
+	for_each_element_extid(elem, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       tx_data->ie, tx_data->ielen)
+		cfg80211_parse_ml_elem_sta_data(wiphy, tx_data, source_bss,
+						elem, gfp);
+}
+
 struct cfg80211_bss *
 cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 struct cfg80211_inform_bss *data,
-- 
2.34.1


