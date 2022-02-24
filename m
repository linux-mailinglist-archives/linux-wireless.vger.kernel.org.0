Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E94C284F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiBXJkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 04:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiBXJkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 04:40:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6A27B9A0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 01:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=XCAidi/WkKiYWoOx0bqQzPUgxQLz0mH6XGSOpqa9HyM=; t=1645695583; x=1646905183; 
        b=lQt09kOGs4Kp0UuxmrnMOidwe4Z7lJie1YBDcYAYHW2x+aplkxas6LS9nOVxbs2/Qo/z2Ai/4g6
        h9h07xwrDrccwBsCJ4PDPpKpttbQfnqjzr0G3DD2bZMsZPJNRl9yOeWn41Oxrgf2jlC6Ha77MJOab
        uivk3h/4og8g7mF161UrNJDfoKlrb6Zyepxj8tu+p6Iyr4lyGyYs+ByAxnRNTts2NDJ285oLIE8YY
        D9QfTrHnZIo4CMDogdpqsiLIHOMQIjPa6Vu7yxALYGxptD9q13NaKk9xWFAA1qkmpWY3J8Q+bYPpI
        x5hsE0E/FijqitGSbHqhBowqqRfKrPl4+1vg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nNAb6-0056dS-Eh;
        Thu, 24 Feb 2022 10:39:40 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, Jouni Malinen <j@w1.fi>
Subject: [PATCH v2] mac80211: treat some SAE auth steps as final
Date:   Thu, 24 Feb 2022 10:39:34 +0100
Message-Id: <20220224103932.75964e1d7932.Ia487f91556f29daae734bf61f8181404642e1eec@changeid>
X-Mailer: git-send-email 2.35.1
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

When we get anti-clogging token required (added by the commit
mentioned below), or the other status codes added by the later
commit 4e56cde15f7d ("mac80211: Handle special status codes in
SAE commit") we currently just pretend (towards the internal
state machine of authentication) that we didn't receive anything.

This has the undesirable consequence of retransmitting the prior
frame, which is not expected, because the timer is still armed.

If we just disarm the timer at that point, it would result in
the undesirable side effect of being in this state indefinitely
if userspace crashes, or so.

So to fix this, reset the timer and set a new auth_data->waiting
in order to have no more retransmissions, but to have the data
destroyed when the timer actually fires, which will only happen
if userspace didn't continue (i.e. crashed or abandoned it.)

Fixes: a4055e74a2ff ("mac80211: Don't destroy auth data in case of anti-clogging")
Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - introduce a new variable to make the SAE PK confirm work

---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 330ea62231fa..e87bccaab561 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -376,7 +376,7 @@ struct ieee80211_mgd_auth_data {
 
 	u8 key[WLAN_KEY_LEN_WEP104];
 	u8 key_len, key_idx;
-	bool done;
+	bool done, waiting;
 	bool peer_confirmed;
 	bool timeout_started;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e5ccf17618ab..744842c4513b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -37,6 +37,7 @@
 #define IEEE80211_AUTH_TIMEOUT_SAE	(HZ * 2)
 #define IEEE80211_AUTH_MAX_TRIES	3
 #define IEEE80211_AUTH_WAIT_ASSOC	(HZ * 5)
+#define IEEE80211_AUTH_WAIT_SAE_RETRY	(HZ * 2)
 #define IEEE80211_ASSOC_TIMEOUT		(HZ / 5)
 #define IEEE80211_ASSOC_TIMEOUT_LONG	(HZ / 2)
 #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
@@ -3011,8 +3012,15 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		    (status_code == WLAN_STATUS_ANTI_CLOG_REQUIRED ||
 		     (auth_transaction == 1 &&
 		      (status_code == WLAN_STATUS_SAE_HASH_TO_ELEMENT ||
-		       status_code == WLAN_STATUS_SAE_PK))))
+		       status_code == WLAN_STATUS_SAE_PK)))) {
+			/* waiting for userspace now */
+			ifmgd->auth_data->waiting = true;
+			ifmgd->auth_data->timeout =
+				jiffies + IEEE80211_AUTH_WAIT_SAE_RETRY;
+			ifmgd->auth_data->timeout_started = true;
+			run_again(sdata, ifmgd->auth_data->timeout);
 			goto notify_driver;
+		}
 
 		sdata_info(sdata, "%pM denied authentication (status %d)\n",
 			   mgmt->sa, status_code);
@@ -4603,10 +4611,10 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 
 	if (ifmgd->auth_data && ifmgd->auth_data->timeout_started &&
 	    time_after(jiffies, ifmgd->auth_data->timeout)) {
-		if (ifmgd->auth_data->done) {
+		if (ifmgd->auth_data->done || ifmgd->auth_data->waiting) {
 			/*
-			 * ok ... we waited for assoc but userspace didn't,
-			 * so let's just kill the auth data
+			 * ok ... we waited for assoc or continuation but
+			 * userspace didn't do it, so kill the auth data
 			 */
 			ieee80211_destroy_auth_data(sdata, false);
 		} else if (ieee80211_auth(sdata)) {
-- 
2.35.1

