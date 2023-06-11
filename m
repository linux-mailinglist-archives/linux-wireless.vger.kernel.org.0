Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34F72B114
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 11:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjFKJPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjFKJOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 05:14:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889B173B
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686474891; x=1718010891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1AJCMFaqPP3njOut+AdPOVV5yyBnGLxJE/AsJNI7aM=;
  b=fFW3ZyzhyKNnCfP8mrKhsrhPhYLISUdx0kg50zZEe0IhTo1akp6Z9PXD
   sx7m8sMOzz45uuvaSwCga6AVlt10cI8ysMHH2NHWJGQCekAEFoPAqo2/M
   nxAgnqjzR4mctGPEohCU0bX81vjqXbS50ZoVHpB/p5iXWsGPOPXqoj2+2
   pMJ/wjZpG9yB6Y4JxG7iyvZbZ0UCUtUT6opTZenglkbyWz4+W6uicAcJI
   304Ajlzw+avNujmLjhp4sEzBc4s38w4rOaacogMLwHwomb3Y4162/SlGj
   +nCt0KIcp/9cQKZkWIy7a55nqkWxyuElUbV/j4+nXaFUxVj9QdMQNRMUk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347488944"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="347488944"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688249753"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="688249753"
Received: from rganonx-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.222.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/4] wifi: mac80211: fragment per STA profile correctly
Date:   Sun, 11 Jun 2023 12:14:29 +0300
Message-Id: <20230611121219.9b5c793d904b.I7dad952bea8e555e2f3139fbd415d0cd2b3a08c3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611091429.24517-1-gregory.greenman@intel.com>
References: <20230611091429.24517-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

When fragmenting the ML per STA profile, the element ID should be
IEEE80211_MLE_SUBELEM_PER_STA_PROFILE rather than WLAN_EID_FRAGMENT.

Change the helper function to take the to be used element ID and pass
the appropriate value for each of the fragmentation levels.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 5 +++--
 net/mac80211/util.c        | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 561a2980f92f..4afd5095366c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2317,7 +2317,7 @@ ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
 	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
 }
 
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos);
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id);
 
 extern const int ieee802_1d_to_ac[8];
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6970d5e7ac8f..738822b82d3e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1367,10 +1367,11 @@ static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 		ieee80211_add_non_inheritance_elem(skb, outer_present_elems,
 						   link_present_elems);
 
-		ieee80211_fragment_element(skb, subelem_len);
+		ieee80211_fragment_element(skb, subelem_len,
+					   IEEE80211_MLE_SUBELEM_FRAGMENT);
 	}
 
-	ieee80211_fragment_element(skb, ml_elem_len);
+	ieee80211_fragment_element(skb, ml_elem_len, WLAN_EID_FRAGMENT);
 }
 
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3aa363bdb6e0..2fc07717bcad 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -5128,7 +5128,7 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 	return pos;
 }
 
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id)
 {
 	unsigned int elem_len;
 
@@ -5148,7 +5148,7 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
 		memmove(len_pos + 255 + 3, len_pos + 255 + 1, elem_len);
 		/* place the fragment ID */
 		len_pos += 255 + 1;
-		*len_pos = WLAN_EID_FRAGMENT;
+		*len_pos = frag_id;
 		/* and point to fragment length to update later */
 		len_pos++;
 	}
-- 
2.38.1

