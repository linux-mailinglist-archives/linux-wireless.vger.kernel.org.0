Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194F52D9CE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbiESQHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbiESQHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 12:07:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803E3668C
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZatlPhAV7VaJts5OrgEqJysiuq1M/fnKOw7lbCzIjso=;
        t=1652976453; x=1654186053; b=gTEDHjEDSHuK5CcmcvR7F/9V6XC1REJSUaJ1Evv8PnDveqS
        4Q/r2esxnHWf5DuJgCa28CmXEbpKWjKq3pGItCN7ns1lrFHikuUdpmGOubR+r2kNNFokRwR/+HXfk
        qk6aQf4EUeKBDNFwS4+qS7jfn20cNsYLIv1Tcun0TWVQDAGywb6o1Q+1xS9CrAnARckFPm1KTeuDM
        pHtebkEdpx+alSIHB5qlzW6SqPPchKHcYTWhdHkm+QLgA74QiN8li5+tQ4ZGI+Tr849cC8ZsC1ROl
        TtWWSEzCc343dcSmbHX58SEpwZFMNovL69infe7uZXSSzvS4jmq4Jd8UufmyOQvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrigT-00GPjR-DF;
        Thu, 19 May 2022 18:07:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] mac80211: reject WEP or pairwise keys with key ID > 3
Date:   Thu, 19 May 2022 18:07:25 +0200
Message-Id: <20220519180724.ec02698e154e.Ia4321598b22c3e55accabbd7f6569543f2526f13@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519180724.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
References: <20220519180724.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
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

We don't really care too much right now since our data
structures are set up to not have a problem with this,
but clearly it's wrong to accept WEP and pairwise keys
with key ID > 3.

However, with MLD we need to split into per-link (GTK,
IGTK, BIGTK) and per interface/MLD (including WEP) keys
so make sure this is not a problem.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/key.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index c3476de4b14d..81dda0ca4d9f 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -433,13 +433,28 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 	int idx;
 	int ret = 0;
 	bool defunikey, defmultikey, defmgmtkey, defbeaconkey;
+	bool is_wep;
 
 	/* caller must provide at least one old/new */
 	if (WARN_ON(!new && !old))
 		return 0;
 
-	if (new)
+	if (new) {
 		list_add_tail_rcu(&new->list, &sdata->key_list);
+		is_wep = new->conf.cipher == WLAN_CIPHER_SUITE_WEP40 ||
+			 new->conf.cipher == WLAN_CIPHER_SUITE_WEP104;
+	} else {
+		is_wep = old->conf.cipher == WLAN_CIPHER_SUITE_WEP40 ||
+			 old->conf.cipher == WLAN_CIPHER_SUITE_WEP104;
+	}
+
+	if (old)
+		idx = old->conf.keyidx;
+	else
+		idx = new->conf.keyidx;
+
+	if ((is_wep || pairwise) && idx >= NUM_DEFAULT_KEYS)
+		return -EINVAL;
 
 	WARN_ON(new && old && new->conf.keyidx != old->conf.keyidx);
 
@@ -451,8 +466,6 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (old) {
-		idx = old->conf.keyidx;
-
 		if (old->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
 			ieee80211_key_disable_hw_accel(old);
 
@@ -460,8 +473,6 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				ret = ieee80211_key_enable_hw_accel(new);
 		}
 	} else {
-		/* new must be provided in case old is not */
-		idx = new->conf.keyidx;
 		if (!new->local->wowlan)
 			ret = ieee80211_key_enable_hw_accel(new);
 	}
-- 
2.36.1

