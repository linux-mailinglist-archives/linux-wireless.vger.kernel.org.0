Return-Path: <linux-wireless+bounces-16982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134C9FFA5D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38998162719
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F071B4235;
	Thu,  2 Jan 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+GzATO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881811B3724
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827631; cv=none; b=m5m9ZGRN9PZ2V07HwfUczq9qxGQlTCH3V5WNq0iCWlKo6Vb9hK/Nemk9H6ncCgglh81W2wuNHZf98RTKaufwn9d6aMyS+TTxUC36KxdVxZ21q4JjNJ477PNadePB8FjlEOCsSwhE5AGEgGMCUr/ijYWEYOnclxaiASYs6U4WDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827631; c=relaxed/simple;
	bh=KrepId+URL+McHwvoO3F0S5zSWcZ63fMVY5SnCf6h4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFnPO+AW6mD2TXTUcmenRLy8pJaGVZs+Z1kbrOYr9PjuK1ulZp4XBgoeYaTAxjQjUy35JYC2NFb7q/5e+pxMOoAbigEROpd2gs8wi/jjK1YHIzxVGRrfU8/9oOxUsE6s3+zDZ1UMBYsIUb4hYFbM2bUpQ6n+kjcu9TCPZDSZxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+GzATO9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827629; x=1767363629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrepId+URL+McHwvoO3F0S5zSWcZ63fMVY5SnCf6h4w=;
  b=Q+GzATO9CMH+NsShWdXHRGHYNLChhdeg2NbVXSqKXK/9JCebLmL/wKoZ
   XU/eCz9khxC8Ysq7E//YNF6uRv8r7J4BCDlZZaq4BxcB2gosF0oHRbB3M
   1CjOnxcwhwXlLoDDRftEdzurPpbf3eCzSgGp4itbBjvPmhdILNZ4Lz20N
   xXzWTtoruzUPQmMfF/qGaFTZsbZffFCpt1sEq5CBfWi+ZyI9Xp+zCPey1
   PqP/mCzQVz6aYmwICN7kmxSc43NStCxGBcCuak01h3nLOdV544qUzuWEh
   I1nXWuPEd69rzJz6LjhrmOKlbrntXa/TcCZoUvmhSQL+ppKh8RepxQ5Sn
   Q==;
X-CSE-ConnectionGUID: NL4gudYoTsiYPynnw9Zkbw==
X-CSE-MsgGUID: THe1Ow/WT1K8iY4Spk/20Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735103"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735103"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:29 -0800
X-CSE-ConnectionGUID: FOYP2xY2TdaoZmuECGkDpA==
X-CSE-MsgGUID: 7GzsFYi/RsihTy0eJnrfdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357382"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/17] wifi: mac80211: Refactor adding association elements
Date: Thu,  2 Jan 2025 16:19:56 +0200
Message-Id: <20250102161730.191f58f2bba7.I6baa6e2989a39937234ff91d7db5ff1359a6bb30@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Instead of always using 'sdata->u.mgd.assoc_data' have
the association data be passed as an argument.

This will later allow to use the same functionality
for adding links to the current association.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 73 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad4a474585e0..50bbe4532ac1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1636,23 +1636,25 @@ static size_t ieee80211_add_before_he_elems(struct sk_buff *skb,
 #define PRESENT_ELEMS_MAX	8
 #define PRESENT_ELEM_EXT_OFFS	0x100
 
-static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
-					struct sk_buff *skb, u16 capab,
-					const struct element *ext_capa,
-					const u16 *present_elems);
-
-static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
-					 struct sk_buff *skb, u16 *capab,
-					 const struct element *ext_capa,
-					 const u8 *extra_elems,
-					 size_t extra_elems_len,
-					 unsigned int link_id,
-					 struct ieee80211_link_data *link,
-					 u16 *present_elems)
+static void
+ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb, u16 capab,
+			    const struct element *ext_capa,
+			    const u16 *present_elems,
+			    struct ieee80211_mgd_assoc_data *assoc_data);
+
+static size_t
+ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
+			 struct sk_buff *skb, u16 *capab,
+			 const struct element *ext_capa,
+			 const u8 *extra_elems,
+			 size_t extra_elems_len,
+			 unsigned int link_id,
+			 struct ieee80211_link_data *link,
+			 u16 *present_elems,
+			 struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
 	struct ieee80211_channel *chan = cbss->channel;
 	const struct ieee80211_sband_iftype_data *iftd;
@@ -1801,7 +1803,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 
 	if (link_id == assoc_data->assoc_link_id)
 		ieee80211_assoc_add_ml_elem(sdata, skb, orig_capab, ext_capa,
-					    present_elems);
+					    present_elems, assoc_data);
 
 	/* crash if somebody gets it wrong */
 	present_elems = NULL;
@@ -1880,14 +1882,14 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 		*len = skb->len - skb_len - 2;
 }
 
-static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
-					struct sk_buff *skb, u16 capab,
-					const struct element *ext_capa,
-					const u16 *outer_present_elems)
+static void
+ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb, u16 capab,
+			    const struct element *ext_capa,
+			    const u16 *outer_present_elems,
+			    struct ieee80211_mgd_assoc_data *assoc_data)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	struct ieee80211_multi_link_elem *ml_elem;
 	struct ieee80211_mle_basic_common_info *common;
 	const struct wiphy_iftype_ext_capab *ift_ext_capa;
@@ -1960,16 +1962,17 @@ static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 		 * (if applicable) are skipped. So we only have
 		 * the capability field (remember the position and fill
 		 * later), followed by the elements added below by
-		 * calling ieee80211_assoc_link_elems().
+		 * calling ieee80211_add_link_elems().
 		 */
 		capab_pos = skb_put(skb, 2);
 
-		extra_used = ieee80211_assoc_link_elems(sdata, skb, &capab,
-							ext_capa,
-							extra_elems,
-							extra_elems_len,
-							link_id, NULL,
-							link_present_elems);
+		extra_used = ieee80211_add_link_elems(sdata, skb, &capab,
+						      ext_capa,
+						      extra_elems,
+						      extra_elems_len,
+						      link_id, NULL,
+						      link_present_elems,
+						      assoc_data);
 		if (extra_elems)
 			skb_put_data(skb, extra_elems + extra_used,
 				     extra_elems_len - extra_used);
@@ -2156,12 +2159,12 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* add the elements for the assoc (main) link */
 	link_capab = capab;
-	offset = ieee80211_assoc_link_elems(sdata, skb, &link_capab,
-					    ext_capa,
-					    assoc_data->ie,
-					    assoc_data->ie_len,
-					    assoc_data->assoc_link_id, link,
-					    present_elems);
+	offset = ieee80211_add_link_elems(sdata, skb, &link_capab,
+					  ext_capa,
+					  assoc_data->ie,
+					  assoc_data->ie_len,
+					  assoc_data->assoc_link_id, link,
+					  present_elems, assoc_data);
 	put_unaligned_le16(link_capab, capab_pos);
 
 	/* if present, add any custom non-vendor IEs */
-- 
2.34.1


