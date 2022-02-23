Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF9F4C1036
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiBWKWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 05:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiBWKWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 05:22:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734430F69
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=wtx5LDHSOtjZTd/A+HmWVa0n/Ma4VA53FegcM57Q5kk=; t=1645611715; x=1646821315; 
        b=pWeh2kiSUtXV2r6UQoplJRDOw5idtx+0mkgepNSMnTHl4AbUkzalkeYOkYuG62DEEZrKdOlG0Ga
        x00ve0MO1wwMTK22is//e9RDr87sI6Xuxa2KtbuFsF6BUX1pfjiKjs9Vu2XwMurkB+bEdIuh5brxa
        owNKb0oXduCYP/jrUknwTBqKUlsC0kB6hg1b3P/59QABbA2MdkIV7wnVJh926qA/CFk7s+qD+nERU
        vOurg6SuWhDmASpYGH7yE33S68CnC1/t9O7vf3kb3aI3YK7MAihnIzbhDefKvlUZhjZIU2GoOkl/N
        8dK6kJpXzPcKo6j1amXBNWAYqrpkzY19JVdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nMomN-004cTv-FZ;
        Wed, 23 Feb 2022 11:21:51 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>, Jouni Malinen <j@w1.fi>
Subject: [PATCH] mac80211: treat some SAE auth steps as final
Date:   Wed, 23 Feb 2022 11:21:47 +0100
Message-Id: <20220223112146.008533287568.I273035bd1d8eebebb59bfadd7f43aef81431bd3a@changeid>
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

So to fix this, reset the timer and actually set auth_data->done
in order to have no more retransmission, but to have the data
destroyed when the timer actually fires, which will only happen
if userspace didn't continue (i.e. crashed or abandoned it.)

Fixes: a4055e74a2ff ("mac80211: Don't destroy auth data in case of anti-clogging")
Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e5ccf17618ab..0216c22a5287 100644
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
+			/* treat it as done so that timeout will remove it */
+			ifmgd->auth_data->done = true;
+			ifmgd->auth_data->timeout =
+				jiffies + IEEE80211_AUTH_WAIT_SAE_RETRY;
+			ifmgd->auth_data->timeout_started = true;
+			run_again(sdata, ifmgd->auth_data->timeout);
 			goto notify_driver;
+		}
 
 		sdata_info(sdata, "%pM denied authentication (status %d)\n",
 			   mgmt->sa, status_code);
-- 
2.35.1

