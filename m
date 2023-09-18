Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7F7A4813
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjIRLM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbjIRLMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C01C3
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035523; x=1726571523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgLzRBHR0Z/Wqcg8LOH9MZ/U99Qtn0eoj3MPgZYA2ag=;
  b=aLVcb9gK7cEgFtXR+yumbG8xLEODAABa+/Vtmr4Mkk4GKpdKgroEzxG4
   swjECUgTm16qn+7FTgulAiLwigOg35DoerVjvvmQQTswR5OqVdlI/xXtg
   hEs2P520Uaxh2U0wxiKorTp/H6DaRZbF7pFTYbDlB4Ebk8LGqQmc6Orcl
   J3lMkZsLkUv07uyz4hi0h8j/CCurQbo6VahqKZmGPg4bo1geb30fPAW+Z
   CLLsghqox2FKqRtQ3rGo3NXB/aWbof64l8ZvEFWYgAQhs3LKhzV4zlr5f
   ZBzIjh1xeLUa5in6C0GVdL2wpihAaZ9ofYILOHpntgH3edJ/46mZu4sU3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535869"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025435"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025435"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/18] wifi: mac80211: work around Cisco AP 9115 VHT MPDU length
Date:   Mon, 18 Sep 2023 14:10:55 +0300
Message-Id: <20230918140607.d1966a9a532e.I090225babb7cd4d1081ee9acd40e7de7e41c15ae@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Cisco AP module 9115 with FW 17.3 has a bug and sends a too
large maximum MPDU length in the association response
(indicating 12k) that it cannot actually process.

Work around that by taking the minimum between what's in the
association response and the BSS elements (from beacon or
probe response).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/cfg.c         |  3 ++-
 net/mac80211/ibss.c        |  2 +-
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mesh_plink.c  |  2 +-
 net/mac80211/mlme.c        | 27 +++++++++++++++++++++++++--
 net/mac80211/vht.c         | 16 ++++++++++++++--
 6 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6b3ccb55aae5..7a7a83d76864 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1836,7 +1836,8 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	/* VHT can override some HT caps such as the A-MSDU max length */
 	if (params->vht_capa)
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    params->vht_capa, link_sta);
+						    params->vht_capa, NULL,
+						    link_sta);
 
 	if (params->he_capa)
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index a7736acadf3c..8b1e02f2f9ae 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1046,7 +1046,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 						   &chandef);
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-							    &cap_ie,
+							    &cap_ie, NULL,
 							    &sta->deflink);
 			if (memcmp(&cap, &sta->sta.deflink.vht_cap, sizeof(cap)))
 				rates_updated |= true;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7856336b5c6..6c56ec42dde9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2085,6 +2085,7 @@ void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
+				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index f3d5bb0a59f1..a1e526419e9d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -451,7 +451,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-					    elems->vht_cap_elem,
+					    elems->vht_cap_elem, NULL,
 					    &sta->deflink);
 
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a85873f305bf..b480dd181a63 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4162,10 +4162,33 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 						  elems->ht_cap_elem,
 						  link_sta);
 
-	if (elems->vht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+	if (elems->vht_cap_elem &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+		const struct ieee80211_vht_cap *bss_vht_cap = NULL;
+		const struct cfg80211_bss_ies *ies;
+
+		/*
+		 * Cisco AP module 9115 with FW 17.3 has a bug and sends a
+		 * too large maximum MPDU length in the association response
+		 * (indicating 12k) that it cannot actually process ...
+		 * Work around that.
+		 */
+		rcu_read_lock();
+		ies = rcu_dereference(cbss->ies);
+		if (ies) {
+			const struct element *elem;
+
+			elem = cfg80211_find_elem(WLAN_EID_VHT_CAPABILITY,
+						  ies->data, ies->len);
+			if (elem && elem->datalen >= sizeof(*bss_vht_cap))
+				bss_vht_cap = (const void *)elem->data;
+		}
+
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
-						    link_sta);
+						    bss_vht_cap, link_sta);
+		rcu_read_unlock();
+	}
 
 	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    elems->he_cap) {
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c1250aa47808..b3a5c3e96a72 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -4,7 +4,7 @@
  *
  * Portions of this file
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -116,12 +116,14 @@ void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
+				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
 	struct ieee80211_sta_vht_cap own_cap;
 	u32 cap_info, i;
 	bool have_80mhz;
+	u32 mpdu_len;
 
 	memset(vht_cap, 0, sizeof(*vht_cap));
 
@@ -317,11 +319,21 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
+	/*
+	 * Work around the Cisco 9115 FW 17.3 bug by taking the min of
+	 * both reported MPDU lengths.
+	 */
+	mpdu_len = vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK;
+	if (vht_cap_ie2)
+		mpdu_len = min_t(u32, mpdu_len,
+				 le32_get_bits(vht_cap_ie2->vht_cap_info,
+					       IEEE80211_VHT_CAP_MAX_MPDU_MASK));
+
 	/*
 	 * FIXME - should the amsdu len be per link? store per link
 	 * and maintain a minimum?
 	 */
-	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
+	switch (mpdu_len) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 		link_sta->pub->agg.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
 		break;
-- 
2.38.1

