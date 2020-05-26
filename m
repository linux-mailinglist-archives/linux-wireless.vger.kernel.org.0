Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3211E21F0
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbgEZMd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 08:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbgEZMd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 08:33:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA032C03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 05:33:57 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdYmJ-003Q8c-2H; Tue, 26 May 2020 14:33:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Haggai Abramovsky <haggai.abramovsky@intel.com>
Subject: [PATCH] mac80211: fix HT-Control field reception for management frames
Date:   Tue, 26 May 2020 14:33:48 +0200
Message-Id: <20200526143346.cf5ce70521c5.I333251a084ec4cfe67b7ef7efe2d2f1a33883931@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we receive management frames with an HT-Control field, we cannot
parse them properly, as we assume a fixed length management header.

Since we don't even need the HTC field (for these frames, or really
at all), just remove it at the beginning of RX.

Reported-by: Haggai Abramovsky <haggai.abramovsky@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index eaf8931e4627..a979cc57b6ef 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -93,13 +93,44 @@ static u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
  * This function cleans up the SKB, i.e. it removes all the stuff
  * only useful for monitoring.
  */
-static void remove_monitor_info(struct sk_buff *skb,
-				unsigned int present_fcs_len,
-				unsigned int rtap_space)
+static struct sk_buff *ieee80211_clean_skb(struct sk_buff *skb,
+					   unsigned int present_fcs_len,
+					   unsigned int rtap_space)
 {
+	struct ieee80211_hdr *hdr;
+	unsigned int hdrlen;
+	__le16 fc;
+
 	if (present_fcs_len)
 		__pskb_trim(skb, skb->len - present_fcs_len);
 	__pskb_pull(skb, rtap_space);
+
+	hdr = (void *)skb->data;
+	fc = hdr->frame_control;
+
+	/*
+	 * Remove the HT-Control field (if present) on management
+	 * frames after we've sent the frame to monitoring. We
+	 * (currently) don't need it, and don't properly parse
+	 * frames with it present, due to the assumption of a
+	 * fixed management header length.
+	 */
+	if (likely(!ieee80211_is_mgmt(fc) || !ieee80211_has_order(fc)))
+		return skb;
+
+	hdrlen = ieee80211_hdrlen(fc);
+	hdr->frame_control &= ~cpu_to_le16(IEEE80211_FCTL_ORDER);
+
+	if (!pskb_may_pull(skb, hdrlen)) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+
+	memmove(skb->data + IEEE80211_HT_CTL_LEN, skb->data,
+		hdrlen - IEEE80211_HT_CTL_LEN);
+	__pskb_pull(skb, IEEE80211_HT_CTL_LEN);
+
+	return skb;
 }
 
 static inline bool should_drop_frame(struct sk_buff *skb, int present_fcs_len,
@@ -827,8 +858,8 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 			return NULL;
 		}
 
-		remove_monitor_info(origskb, present_fcs_len, rtap_space);
-		return origskb;
+		return ieee80211_clean_skb(origskb, present_fcs_len,
+					   rtap_space);
 	}
 
 	ieee80211_handle_mu_mimo_mon(monitor_sdata, origskb, rtap_space);
@@ -871,8 +902,7 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	if (!origskb)
 		return NULL;
 
-	remove_monitor_info(origskb, present_fcs_len, rtap_space);
-	return origskb;
+	return ieee80211_clean_skb(origskb, present_fcs_len, rtap_space);
 }
 
 static void ieee80211_parse_qos(struct ieee80211_rx_data *rx)
-- 
2.26.2

