Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD922789D1F
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjH0LGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjH0LF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:05:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491B186
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134357; x=1724670357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QcitOUYEULAjhF7dIuS7zp2F7J+YtI5Va7DDHERZU4A=;
  b=QLU6NS8VV68PWl/yt5fBzXxUicR6xFwsy/1RMjR1KDYNQpAqrs5GTNI6
   Ycw4pXyZb7F6fTKhrcX3WDwejbzAKeNw/IDx9MBaB6fmkHvRIlXicO114
   UNa6CYhqSAFkO8Hw0Vy7eGQMcT0ZCuXLm0jnNX1FuIutzitZLD+tZLSe1
   SL6I+cpcEGXfaxZhAw2UXP9+XURiofZ8UdVdMbribIE2hXLzQd9ECLjI+
   eRmVa/vrF9kRk5FNMvg7aBJVxm4adB/HQASFOxYtap2WVaanmR492cHSj
   RedxKv/DVqpH1+NayrZopUMDEhyqbkG4Ntqq8fBJiEasv9Z/Bsdjh4byD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301549"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632970"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: cfg80211: add ieee80211_fragment_element to public API
Date:   Sun, 27 Aug 2023 14:05:22 +0300
Message-Id: <20230827135854.5af9391659f5.Ie534ed6591ba02be8572d4d7242394f29e3af04b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

This function will be used by the kunit tests within cfg80211. As it
is generally useful, move it from mac80211 to cfg80211.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h     | 12 ++++++++++++
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/util.c        | 29 -----------------------------
 net/wireless/util.c        | 29 +++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..630db8601ee5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8807,6 +8807,18 @@ static inline size_t ieee80211_ie_split(const u8 *ies, size_t ielen,
 	return ieee80211_ie_split_ric(ies, ielen, ids, n_ids, NULL, 0, offset);
 }
 
+/**
+ * ieee80211_fragment_element - fragment the last element in skb
+ * @skb: The skbuf that the element was added to
+ * @len_pos: Pointer to length of the element to fragment
+ * @frag_id: The element ID to use for fragments
+ *
+ * This function fragments all data after @len_pos, adding fragmentation
+ * elements with the given ID as appropriate. The SKB will grow in size
+ * accordingly.
+ */
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id);
+
 /**
  * cfg80211_report_wowlan_wakeup - report wakeup from WoWLAN
  * @wdev: the wireless device reporting the wakeup
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 06bd406846d2..8afeb1398b33 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2333,8 +2333,6 @@ ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
 	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
 }
 
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id);
-
 extern const int ieee802_1d_to_ac[8];
 
 static inline int ieee80211_ac_from_tid(int tid)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d430093d14af..07fbd04b362c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -5120,32 +5120,3 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 
 	return pos;
 }
-
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id)
-{
-	unsigned int elem_len;
-
-	if (!len_pos)
-		return;
-
-	elem_len = skb->data + skb->len - len_pos - 1;
-
-	while (elem_len > 255) {
-		/* this one is 255 */
-		*len_pos = 255;
-		/* remaining data gets smaller */
-		elem_len -= 255;
-		/* make space for the fragment ID/len in SKB */
-		skb_put(skb, 2);
-		/* shift back the remaining data to place fragment ID/len */
-		memmove(len_pos + 255 + 3, len_pos + 255 + 1, elem_len);
-		/* place the fragment ID */
-		len_pos += 255 + 1;
-		*len_pos = frag_id;
-		/* and point to fragment length to update later */
-		len_pos++;
-	}
-
-	*len_pos = elem_len;
-}
-EXPORT_SYMBOL_IF_KUNIT(ieee80211_fragment_element);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1783ab9d57a3..6a43f517727f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1972,6 +1972,35 @@ size_t ieee80211_ie_split_ric(const u8 *ies, size_t ielen,
 }
 EXPORT_SYMBOL(ieee80211_ie_split_ric);
 
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id)
+{
+	unsigned int elem_len;
+
+	if (!len_pos)
+		return;
+
+	elem_len = skb->data + skb->len - len_pos - 1;
+
+	while (elem_len > 255) {
+		/* this one is 255 */
+		*len_pos = 255;
+		/* remaining data gets smaller */
+		elem_len -= 255;
+		/* make space for the fragment ID/len in SKB */
+		skb_put(skb, 2);
+		/* shift back the remaining data to place fragment ID/len */
+		memmove(len_pos + 255 + 3, len_pos + 255 + 1, elem_len);
+		/* place the fragment ID */
+		len_pos += 255 + 1;
+		*len_pos = frag_id;
+		/* and point to fragment length to update later */
+		len_pos++;
+	}
+
+	*len_pos = elem_len;
+}
+EXPORT_SYMBOL(ieee80211_fragment_element);
+
 bool ieee80211_operating_class_to_band(u8 operating_class,
 				       enum nl80211_band *band)
 {
-- 
2.38.1

