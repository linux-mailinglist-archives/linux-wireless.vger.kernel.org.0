Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18BD4B562E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356401AbiBNQab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356391AbiBNQaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67705FF0B
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wZYc0kytM7C5qLCFLZWdcn3SaWfUlzq7rMq7zwjbTv4=;
        t=1644856214; x=1646065814; b=DbqAKIaraBzrIleZs6u/WKckjOGS+caF9V27SCgUVgoXrOC
        1sdjUUMZKM8ih/DV082+3kcIMkJj2N2zUwUj2pFCZtR1f0RO6YnQOeil/RM9T1AlmOtXXZqParjVf
        x0Ggac7/RzZbqkaVkpLnQbwSp2I+2z6M7fzwLwmlHfP0xWh3EauZcVpIIcIyI49y/Sw/i0dHLeW7p
        irhFwOQcP5fShZVbhx5x9Mvan4nQVzqc5ZBNdU03cn2W41ueq8UiYgAQDsWgxQap5KKxckewxiHmE
        5OtUUo4Lzoe/qi96NEPcR/aE63eCq5X47GXw7ggJItdg1jO7rmvRPwOUx8l++R6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEv-0011mw-15;
        Mon, 14 Feb 2022 17:30:13 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v3 18/19] mac80211: parse AddBA request with extended AddBA element
Date:   Mon, 14 Feb 2022 17:30:05 +0100
Message-Id: <20220214173004.8209cae9d9e4.I434f5588602f83b4e658c660120040913b3a2e3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In EHT requesting aggregation with 1K needs the use of extended
the AddBA element for the buffer size, so add the logic to parse
it and make sure it's in limits of the EHT aggregation size.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 0d2bab9d351c..218cdc554d71 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -180,7 +180,8 @@ static void sta_rx_agg_reorder_timer_expired(struct timer_list *t)
 
 static void ieee80211_add_addbaext(struct ieee80211_sub_if_data *sdata,
 				   struct sk_buff *skb,
-				   const struct ieee80211_addba_ext_ie *req)
+				   const struct ieee80211_addba_ext_ie *req,
+				   u16 buf_size)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_addba_ext_ie *resp;
@@ -210,6 +211,8 @@ static void ieee80211_add_addbaext(struct ieee80211_sub_if_data *sdata,
 		frag_level = cap_frag_level;
 	resp->data |= u8_encode_bits(frag_level,
 				     IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK);
+	resp->data |= u8_encode_bits(buf_size >> IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT,
+				     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
 }
 
 static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
@@ -261,7 +264,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	mgmt->u.action.u.addba_resp.status = cpu_to_le16(status);
 
 	if (sta->sta.he_cap.has_he && addbaext)
-		ieee80211_add_addbaext(sdata, skb, addbaext);
+		ieee80211_add_addbaext(sdata, skb, addbaext, buf_size);
 
 	ieee80211_tx_skb(sdata, skb);
 }
@@ -309,7 +312,9 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (sta->sta.he_cap.has_he)
+	if (sta->sta.eht_cap.has_eht)
+		max_buf_size = IEEE80211_MAX_AMPDU_BUF_EHT;
+	else if (sta->sta.he_cap.has_he)
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HE;
 	else
 		max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
@@ -502,6 +507,13 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 			goto free;
 	}
 
+	if (sta->sta.eht_cap.has_eht && elems && elems->addba_ext_ie) {
+		u8 buf_size_1k = u8_get_bits(elems->addba_ext_ie->data,
+					     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
+
+		buf_size |= buf_size_1k << IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT;
+	}
+
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
 					buf_size, true, false,
-- 
2.34.1

