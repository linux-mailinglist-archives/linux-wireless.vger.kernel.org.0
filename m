Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F44732802
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbjFPGzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbjFPGzE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:55:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894E2967
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898503; x=1718434503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wclxMH8FCSmyBDBTYuS+cf97OqkxF15uOd3DkP/ns78=;
  b=YymUwpejzFE1A9zgDRkj8oj6QwNteYXNpjLPG93nnTZBxNW4EvYL3mxs
   VLC7fxpe9FZBtyu6xFEv7a4fIXyZwwUg6UoMyImInro6h65TWcfuYoPC7
   2MUMdSaY/rnjH+NJf+nFL/QNF3ouFthGPUT7OfcWwGdJ8T6fLr3JZ5ujF
   3ffad75tyrsvRU6CUtb2VBvFqPbV+CcIo/JvF21MF5ohM3K/W5wQSjuTx
   0UUDqCHHOG2NF9SUw0JbB/cxw2MkgYQmK0/xFsJkE6YKe6oN6v3WyLOcS
   0xqB8vpvvGOpjcE1UCpw/oSjX3KRolIdtEqO9GVdCM1NFH16mkUdu94uc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078914"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078914"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720272"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720272"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/20] wifi: mac80211: use cfg80211 defragmentation helper
Date:   Fri, 16 Jun 2023 09:54:06 +0300
Message-Id: <20230616094949.7dcbf82baade.Ic68d1f547cb75d66037abdbb0f066db20ff41ba3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Use the shared functionality rather than copying it into mac80211.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +
 net/mac80211/util.c        | 93 ++++++++++++++------------------------
 2 files changed, 37 insertions(+), 58 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b05dfdcfff11..4ae9c58d6a12 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1752,6 +1752,8 @@ struct ieee802_11_elems {
 
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t multi_link_len;
+	/* The element in the original IEs */
+	const struct element *multi_link_elem;
 
 	/*
 	 * store the per station profile pointer and length in case that the
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b81089fc51e1..2e3270dc4d05 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -984,6 +984,7 @@ ieee80211_parse_extension_element(u32 *crc,
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
 		if (ieee80211_mle_size_ok(data, len)) {
+			elems->multi_link_elem = (void *)elem;
 			elems->multi_link = (void *)data;
 			elems->multi_link_len = len;
 		}
@@ -1458,56 +1459,11 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
-static void ieee80211_defragment_element(struct ieee802_11_elems *elems,
-					 void **elem_ptr, size_t *len,
-					 size_t total_len, u8 frag_id)
-{
-	u8 *data = *elem_ptr, *pos, *start;
-	const struct element *elem;
-
-	/*
-	 * Since 'data' points to the data of the element, not the element
-	 * itself, allow 254 in case it was an extended element where the
-	 * extended ID isn't part of the data we see here and thus not part of
-	 * 'len' either.
-	 */
-	if (!data || (*len != 254 && *len != 255))
-		return;
-
-	start = elems->scratch_pos;
-
-	if (WARN_ON(*len > (elems->scratch + elems->scratch_len -
-			    elems->scratch_pos)))
-		return;
-
-	memcpy(elems->scratch_pos, data, *len);
-	elems->scratch_pos += *len;
-
-	pos = data + *len;
-	total_len -= *len;
-	for_each_element(elem, pos, total_len) {
-		if (elem->id != frag_id)
-			break;
-
-		if (WARN_ON(elem->datalen >
-			    (elems->scratch + elems->scratch_len -
-			     elems->scratch_pos)))
-			return;
-
-		memcpy(elems->scratch_pos, elem->data, elem->datalen);
-		elems->scratch_pos += elem->datalen;
-
-		*len += elem->datalen;
-	}
-
-	*elem_ptr = start;
-}
-
 static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 				       u8 link_id)
 {
 	const struct ieee80211_multi_link_elem *ml = elems->multi_link;
-	size_t ml_len = elems->multi_link_len;
+	ssize_t ml_len = elems->multi_link_len;
 	const struct element *sub;
 
 	if (!ml || !ml_len)
@@ -1519,6 +1475,7 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 
 	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
 		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
+		ssize_t sta_prof_len;
 		u16 control;
 
 		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
@@ -1536,14 +1493,23 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 		if (!(control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE))
 			return;
 
-		elems->prof = prof;
-		elems->sta_prof_len = sub->datalen;
-
 		/* the sub element can be fragmented */
-		ieee80211_defragment_element(elems, (void **)&elems->prof,
-					     &elems->sta_prof_len,
-					     ml_len - (sub->data - (u8 *)ml),
-					     IEEE80211_MLE_SUBELEM_FRAGMENT);
+		sta_prof_len =
+			cfg80211_defragment_element(sub,
+						    (u8 *)ml, ml_len,
+						    elems->scratch_pos,
+						    elems->scratch +
+							elems->scratch_len -
+							elems->scratch_pos,
+						    IEEE80211_MLE_SUBELEM_FRAGMENT);
+
+		if (sta_prof_len < 0)
+			return;
+
+		elems->prof = (void *)elems->scratch_pos;
+		elems->sta_prof_len = sta_prof_len;
+		elems->scratch_pos += sta_prof_len;
+
 		return;
 	}
 }
@@ -1557,17 +1523,28 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 		.from_ap = params->from_ap,
 		.link_id = -1,
 	};
+	ssize_t ml_len = elems->multi_link_len;
 	const struct element *non_inherit = NULL;
 	const u8 *end;
 
 	if (params->link_id == -1)
 		return;
 
-	ieee80211_defragment_element(elems, (void **)&elems->multi_link,
-				     &elems->multi_link_len,
-				     elems->total_len - ((u8 *)elems->multi_link -
-							 elems->ie_start),
-				     WLAN_EID_FRAGMENT);
+	ml_len = cfg80211_defragment_element(elems->multi_link_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems->scratch_pos,
+					     elems->scratch +
+						elems->scratch_len -
+						elems->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+
+	if (ml_len < 0)
+		return;
+
+	elems->multi_link = (const void *)elems->scratch_pos;
+	elems->multi_link_len = ml_len;
+	elems->scratch_pos += ml_len;
 
 	ieee80211_mle_get_sta_prof(elems, params->link_id);
 	prof = elems->prof;
-- 
2.38.1

