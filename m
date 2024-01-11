Return-Path: <linux-wireless+bounces-1728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40082B2BB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F96B1F254A1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79BD4F8B6;
	Thu, 11 Jan 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEnY25z4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEF4F60B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989904; x=1736525904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWlw4rZv4Y5veQLZCWljvU/7dgjSr71rO1h1z8eash8=;
  b=ZEnY25z4P2JmP4RhTOQrghbGg+ahuin2rZ3t9ckU2jVeKEK91QWUOHGC
   bIdZRaxK6EEgvE/WWuZJCoZy5nDQK34DEfyH4jcVE5vNIG502nzjs1JS3
   iAHNQAtJOIeIsYctwT9mWZOOgsIx+JctLM9aQplFPCCVc3Mc4vrwSXtY5
   PlUdHGhu/s2XEpk4zwiHNiW6qEBpr5jU/ELTYs08tv4Pi6fYgpIMum0bR
   cMXQlN7doNOy11Da3NQyZ1doGGdip9H/0VJzRvdolHpdP1TpxsaOrp+Ko
   6zxixDRMAaHrvUlPUzVYBnWOxOIzVo7/GGIllKjukQCYfmxZMhxDr+VmO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182491"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606493"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606493"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/8] wifi: mac80211: simplify ieee80211_config_bw() prototype
Date: Thu, 11 Jan 2024 18:17:40 +0200
Message-Id: <20240111181514.f0653cd5e7dd.I8bd5ee848074029a9f0495c95e4339546ad8fe15@changeid>
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

The only user of this function passes a lot of pointers
directly from the parsed elements, so it's simpler to
just pass the entire elements parsing struct. This also
shows that the ht_cap is actually unused.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 576ba6b25db9..6fa69ad3ad4f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -489,15 +489,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
-			       const struct ieee80211_ht_cap *ht_cap,
-			       const struct ieee80211_vht_cap *vht_cap,
-			       const struct ieee80211_ht_operation *ht_oper,
-			       const struct ieee80211_vht_operation *vht_oper,
-			       const struct ieee80211_he_operation *he_oper,
-			       const struct ieee80211_eht_operation *eht_oper,
-			       const struct ieee80211_s1g_oper_ie *s1g_oper,
+			       struct ieee802_11_elems *elems,
 			       const u8 *bssid, u64 *changed)
 {
+	const struct ieee80211_vht_cap *vht_cap = elems->vht_cap_elem;
+	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
+	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
+	const struct ieee80211_he_operation *he_oper = elems->he_operation;
+	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
+	const struct ieee80211_s1g_oper_ie *s1g_oper = elems->s1g_oper;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -6433,11 +6433,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems->ht_cap_elem,
-				elems->vht_cap_elem, elems->ht_operation,
-				elems->vht_operation, elems->he_operation,
-				elems->eht_operation,
-				elems->s1g_oper, bssid, &changed)) {
+	if (ieee80211_config_bw(link, elems, bssid, &changed)) {
 		sdata_info(sdata,
 			   "failed to follow AP %pM bandwidth change, disconnect\n",
 			   bssid);
-- 
2.34.1


