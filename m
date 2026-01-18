Return-Path: <linux-wireless+bounces-30934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C40D3932E
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3B73019256
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84B20C477;
	Sun, 18 Jan 2026 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBPVPMx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42B1EBA14
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722691; cv=none; b=VAEA/gusP2VuOK2+u4225fXLP+sl8dobDWwNNMLdveAsxE4OdTnnB8AnFXb3eN6bJ3V64ipPRKaXx2OmR/T+S4YBG8K8VHXqc7AjdSOlUChq4kThgcB/BJknOsawf0IKjqu5NLy0Rq8ZiuZjRMP2ZXkNgmQI9l8gtAWH5ErKuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722691; c=relaxed/simple;
	bh=1oaU4+52wCngIClBCTP3UiCM85ojtG9SnqIqKc8IBA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2pP52XjCuBX0mugx5BLXhrpQbgNW7D3yhJZC0kxHru5W5/eH8fOZOKXwlJeOuN5HJlPEIrRhu5SQ46G5lmgtTwCneY7HRNUOw+JaLnMhW4Fa3EatLKHyO+MTV0DdJbe87IWj0O5b4I5pICdk7haKMfWZr5GdqGvqYF0N1ErYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBPVPMx/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768722689; x=1800258689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1oaU4+52wCngIClBCTP3UiCM85ojtG9SnqIqKc8IBA4=;
  b=kBPVPMx/CPghoz4LzxPs8DLhrJPOV2V6qkgj9H6CjYqoc/XkdH7nS+lT
   LGGY4PHL+FmiYnSDQ+4S71eiwz89mbtYelAoH3KqfNEAhOLGIiAlxaw7h
   Xpr0av+d+eVC9MJaxS+8KgQuwr0c8X0JKHws/5Z+KDEMfKuEQ65EKDZ8k
   Hp8eMK6HvC6khav6VHOQCEPBT69RB/WxdXfgRbxamLCH9nGfFL3UismDL
   WKAzqatdbd4zkfIJSfbbnLIne6cYjpTvxG0Y+d/Th53Wup2LVUfEbtfBU
   TAnp0pZAo1Ua43brKiBRQuHD7ZJkblMERtyWYy8qg54y05TQUAnuNK/yJ
   Q==;
X-CSE-ConnectionGUID: /5b9DIEIRW+U142oB15qMg==
X-CSE-MsgGUID: WeQ3KNkyQ22hqjnXdn9Bag==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="87546810"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="87546810"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:29 -0800
X-CSE-ConnectionGUID: NQzvkNRGTVamu4Of2yNKMA==
X-CSE-MsgGUID: PU1PmYdzTym2jtcLqztAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236278503"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi 2/3] wifi: mac80211: apply advertised TTLM from association response
Date: Sun, 18 Jan 2026 09:51:14 +0200
Message-Id: <20260118093904.43c861424543.I067f702ac46b84ac3f8b4ea16fb0db9cbbfae7e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
References: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When the AP has a disabled link that the station can include in the
association, the fact that the link is dormant needs to be advertised
in the TID to Link Mapping (TTLM). Section 35.3.7.2.3 ("Negotiation of
TTLM") of Draft P802.11REVmf_D1.0 also states that the mapping needs to
be included in the association response frame.

As such, we can simply rely on the TTLM from the association response.
Before this change mac80211 would not properly track that an advertised
TTLM was effectively active, resulting in it not enabling the link once
it became available again.

For the link reconfiguration case, the data was not used at all. This
behaviour is actually correct because Draft P802.11REVmf_D1.0 states in
section 35.3.6.4 that we "shall operate with all the TIDs mapped to the
newly added links ..."

Fixes: 6d543b34dbcf ("wifi: mac80211: Support disabled links during association")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |   2 -
 net/mac80211/mlme.c        | 216 ++++++++++++++++++++-----------------
 2 files changed, 119 insertions(+), 99 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..bd573f8e61fb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -451,8 +451,6 @@ struct ieee80211_mgd_assoc_data {
 		struct ieee80211_conn_settings conn;
 
 		u16 status;
-
-		bool disabled;
 	} link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3f6bbe4e0175..b72345c779c0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6161,6 +6161,98 @@ static bool ieee80211_get_dtim(const struct cfg80211_bss_ies *ies,
 	return true;
 }
 
+static u16 ieee80211_get_ttlm(u8 bm_size, u8 *data)
+{
+	if (bm_size == 1)
+		return *data;
+
+	return get_unaligned_le16(data);
+}
+
+static int
+ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
+			const struct ieee80211_ttlm_elem *ttlm,
+			struct ieee80211_adv_ttlm_info *ttlm_info)
+{
+	/* The element size was already validated in
+	 * ieee80211_tid_to_link_map_size_ok()
+	 */
+	u8 control, link_map_presence, map_size, tid;
+	u8 *pos;
+
+	memset(ttlm_info, 0, sizeof(*ttlm_info));
+	pos = (void *)ttlm->optional;
+	control	= ttlm->control;
+
+	if ((control & IEEE80211_TTLM_CONTROL_DIRECTION) !=
+	    IEEE80211_TTLM_DIRECTION_BOTH) {
+		sdata_info(sdata, "Invalid advertised T2L map direction\n");
+		return -EINVAL;
+	}
+
+	link_map_presence = *pos;
+	pos++;
+
+	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT) {
+		ttlm_info->switch_time = get_unaligned_le16(pos);
+
+		/* Since ttlm_info->switch_time == 0 means no switch time, bump
+		 * it by 1.
+		 */
+		if (!ttlm_info->switch_time)
+			ttlm_info->switch_time = 1;
+
+		pos += 2;
+	}
+
+	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
+		ttlm_info->duration = pos[0] | pos[1] << 8 | pos[2] << 16;
+		pos += 3;
+	}
+
+	if (control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) {
+		ttlm_info->map = 0xffff;
+		return 0;
+	}
+
+	if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
+		map_size = 1;
+	else
+		map_size = 2;
+
+	/* According to Draft P802.11be_D3.0 clause 35.3.7.1.7, an AP MLD shall
+	 * not advertise a TID-to-link mapping that does not map all TIDs to the
+	 * same link set, reject frame if not all links have mapping
+	 */
+	if (link_map_presence != 0xff) {
+		sdata_info(sdata,
+			   "Invalid advertised T2L mapping presence indicator\n");
+		return -EINVAL;
+	}
+
+	ttlm_info->map = ieee80211_get_ttlm(map_size, pos);
+	if (!ttlm_info->map) {
+		sdata_info(sdata,
+			   "Invalid advertised T2L map for TID 0\n");
+		return -EINVAL;
+	}
+
+	pos += map_size;
+
+	for (tid = 1; tid < 8; tid++) {
+		u16 map = ieee80211_get_ttlm(map_size, pos);
+
+		if (map != ttlm_info->map) {
+			sdata_info(sdata, "Invalid advertised T2L map for tid %d\n",
+				   tid);
+			return -EINVAL;
+		}
+
+		pos += map_size;
+	}
+	return 0;
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_mgmt *mgmt,
 				    struct ieee802_11_elems *elems,
@@ -6192,8 +6284,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				continue;
 
 			valid_links |= BIT(link_id);
-			if (assoc_data->link[link_id].disabled)
-				dormant_links |= BIT(link_id);
 
 			if (link_id != assoc_data->assoc_link_id) {
 				err = ieee80211_sta_allocate_link(sta, link_id);
@@ -6202,6 +6292,33 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
+		/*
+		 * We do not support setting a negotiated TTLM during
+		 * association. As such, we can assume that if there is a TTLM,
+		 * then it is the currently active advertised TTLM.
+		 * In that case, there must be exactly one TTLM that does not
+		 * have a switch time set. This mapping should also leave us
+		 * with at least one usable link.
+		 */
+		if (elems->ttlm_num > 1) {
+			sdata_info(sdata,
+				   "More than one advertised TTLM in association response\n");
+			goto out_err;
+		} else if (elems->ttlm_num == 1) {
+			if (ieee80211_parse_adv_t2l(sdata, elems->ttlm[0],
+						    &sdata->u.mgd.ttlm_info) ||
+			    sdata->u.mgd.ttlm_info.switch_time != 0 ||
+			    !(valid_links & sdata->u.mgd.ttlm_info.map)) {
+				sdata_info(sdata,
+					   "Invalid advertised TTLM in association response\n");
+				goto out_err;
+			}
+
+			sdata->u.mgd.ttlm_info.active = true;
+			dormant_links =
+				valid_links & ~sdata->u.mgd.ttlm_info.map;
+		}
+
 		ieee80211_vif_set_links(sdata, valid_links, dormant_links);
 	}
 
@@ -6992,98 +7109,6 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 	sdata->u.mgd.ttlm_info.switch_time = 0;
 }
 
-static u16 ieee80211_get_ttlm(u8 bm_size, u8 *data)
-{
-	if (bm_size == 1)
-		return *data;
-	else
-		return get_unaligned_le16(data);
-}
-
-static int
-ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
-			const struct ieee80211_ttlm_elem *ttlm,
-			struct ieee80211_adv_ttlm_info *ttlm_info)
-{
-	/* The element size was already validated in
-	 * ieee80211_tid_to_link_map_size_ok()
-	 */
-	u8 control, link_map_presence, map_size, tid;
-	u8 *pos;
-
-	memset(ttlm_info, 0, sizeof(*ttlm_info));
-	pos = (void *)ttlm->optional;
-	control	= ttlm->control;
-
-	if ((control & IEEE80211_TTLM_CONTROL_DIRECTION) !=
-	    IEEE80211_TTLM_DIRECTION_BOTH) {
-		sdata_info(sdata, "Invalid advertised T2L map direction\n");
-		return -EINVAL;
-	}
-
-	link_map_presence = *pos;
-	pos++;
-
-	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT) {
-		ttlm_info->switch_time = get_unaligned_le16(pos);
-
-		/* Since ttlm_info->switch_time == 0 means no switch time, bump
-		 * it by 1.
-		 */
-		if (!ttlm_info->switch_time)
-			ttlm_info->switch_time = 1;
-
-		pos += 2;
-	}
-
-	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
-		ttlm_info->duration = pos[0] | pos[1] << 8 | pos[2] << 16;
-		pos += 3;
-	}
-
-	if (control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) {
-		ttlm_info->map = 0xffff;
-		return 0;
-	}
-
-	if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
-		map_size = 1;
-	else
-		map_size = 2;
-
-	/* According to Draft P802.11be_D3.0 clause 35.3.7.1.7, an AP MLD shall
-	 * not advertise a TID-to-link mapping that does not map all TIDs to the
-	 * same link set, reject frame if not all links have mapping
-	 */
-	if (link_map_presence != 0xff) {
-		sdata_info(sdata,
-			   "Invalid advertised T2L mapping presence indicator\n");
-		return -EINVAL;
-	}
-
-	ttlm_info->map = ieee80211_get_ttlm(map_size, pos);
-	if (!ttlm_info->map) {
-		sdata_info(sdata,
-			   "Invalid advertised T2L map for TID 0\n");
-		return -EINVAL;
-	}
-
-	pos += map_size;
-
-	for (tid = 1; tid < 8; tid++) {
-		u16 map = ieee80211_get_ttlm(map_size, pos);
-
-		if (map != ttlm_info->map) {
-			sdata_info(sdata, "Invalid advertised T2L map for tid %d\n",
-				   tid);
-			return -EINVAL;
-		}
-
-		pos += map_size;
-	}
-	return 0;
-}
-
 static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 					  struct ieee802_11_elems *elems,
 					  u64 beacon_ts)
@@ -9740,7 +9765,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 							       req, true, i,
 							       &assoc_data->link[i].conn);
 			assoc_data->link[i].bss = link_cbss;
-			assoc_data->link[i].disabled = req->links[i].disabled;
 
 			if (!bss->uapsd_supported)
 				uapsd_supported = false;
@@ -10722,8 +10746,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 							 &data->link[link_id].conn);
 
 			data->link[link_id].bss = link_cbss;
-			data->link[link_id].disabled =
-				req->add_links[link_id].disabled;
 			data->link[link_id].elems =
 				(u8 *)req->add_links[link_id].elems;
 			data->link[link_id].elems_len =
-- 
2.34.1


