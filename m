Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDE539E85
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbiFAHkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbiFAHkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74899986E4
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=x7ZQcFvXpMeB75paJmKGva+u4ftpNNQ94kdXj2XJjo8=;
        t=1654069205; x=1655278805; b=HU1UWkPV/oe1peFu8FTNCeOYlFhh1CVZlVngqecAu+31Qql
        3KJz/aJV4+szE1/m9GPrWcDpbqdbSOUCJnqwucdCnyqiV9EzOhzdOxPqV1/fDZFyWvudt76EAeAzU
        /LLuPi9Zu/s3hObj/oPK8hirlIxHApKJLyLpwMwDLj06wov1yW07+z7AFSd+D0nhWRJPSslVb0ouQ
        1nIVULSlQhkgBEZaEJJp4pzu8z6fD7ipf4cMK9X0A7liVIsks57sYbu27/o1WM5/k056eASD7Ep3R
        fJpXv6t2oJpDa2VxawwANeSESHEAgQuxgTqTIDK/RCnSY0tNDh+gOSBjB6l3fIgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxW-00AJPK-Lu;
        Wed, 01 Jun 2022 09:40:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] mac80211: remove sta_info_tx_streams()
Date:   Wed,  1 Jun 2022 09:39:48 +0200
Message-Id: <20220601093922.d4aa77956a2a.I204d488e980cbba5353fca23fed38d8205dbd4f7@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

From: Johannes Berg <johannes.berg@intel.com>

The function is unused since commit 52b4810bed83 ("mac80211: Remove
support for changing AP SMPS mode") so we can just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 35 -----------------------------------
 net/mac80211/sta_info.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 9a70d846d0dd..6f6d83def8b8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2093,41 +2093,6 @@ int sta_info_move_state(struct sta_info *sta,
 	return 0;
 }
 
-u8 sta_info_tx_streams(struct sta_info *sta)
-{
-	struct ieee80211_sta_ht_cap *ht_cap = &sta->sta.deflink.ht_cap;
-	u8 rx_streams;
-
-	if (!sta->sta.deflink.ht_cap.ht_supported)
-		return 1;
-
-	if (sta->sta.deflink.vht_cap.vht_supported) {
-		int i;
-		u16 tx_mcs_map =
-			le16_to_cpu(sta->sta.deflink.vht_cap.vht_mcs.tx_mcs_map);
-
-		for (i = 7; i >= 0; i--)
-			if ((tx_mcs_map & (0x3 << (i * 2))) !=
-			    IEEE80211_VHT_MCS_NOT_SUPPORTED)
-				return i + 1;
-	}
-
-	if (ht_cap->mcs.rx_mask[3])
-		rx_streams = 4;
-	else if (ht_cap->mcs.rx_mask[2])
-		rx_streams = 3;
-	else if (ht_cap->mcs.rx_mask[1])
-		rx_streams = 2;
-	else
-		rx_streams = 1;
-
-	if (!(ht_cap->mcs.tx_params & IEEE80211_HT_MCS_TX_RX_DIFF))
-		return rx_streams;
-
-	return ((ht_cap->mcs.tx_params & IEEE80211_HT_MCS_TX_MAX_STREAMS_MASK)
-			>> IEEE80211_HT_MCS_TX_MAX_STREAMS_SHIFT) + 1;
-}
-
 static struct ieee80211_sta_rx_stats *
 sta_get_last_rx_stats(struct sta_info *sta)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index aa6950aa49a9..134a7dad0ac4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -891,7 +891,6 @@ u32 sta_get_expected_throughput(struct sta_info *sta);
 
 void ieee80211_sta_expire(struct ieee80211_sub_if_data *sdata,
 			  unsigned long exp_time);
-u8 sta_info_tx_streams(struct sta_info *sta);
 
 void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta);
 void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
-- 
2.36.1

