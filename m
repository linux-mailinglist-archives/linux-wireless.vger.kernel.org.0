Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56E7A5A00
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjISGef (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 02:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjISGeb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 02:34:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0E116
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hLj4M+1nL81iF8FaWOr3YPrNl0P+2RxGbGVGGG8Ljsk=;
        t=1695105264; x=1696314864; b=WlCK3UykndynPb+0nU0/GusHEg/CAYpX1oF1VqIClZkIkaG
        rC616TSGykKTr0bd5wKmGFtX4DLJGsRCVg8P6O6GJFDQ9xeuDbWcYDOwQOkHxTQIOSIlNWe+HpuAx
        mahtf2GJ8MFwcPVxsn4vTVPx/vkaWQjGYaILw6X06bGpO4qFPVFPMl4u6yGGJUe0o1KGHe/O7T4w6
        v21eWWbCle9incdLGUTOaL8jbFmokBz5VI0lWj8ytKWI/hiuWu7kWfyD8aPPcu9cFnx5JKO7oDdsx
        coc/2yuiYeYbAKP4pbfJPw7WZizpOg+NCugjvr1qBTC97ODxGV7Qup956zOrfzQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qiUJR-008tsE-2a;
        Tue, 19 Sep 2023 08:34:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: fix potential key leak
Date:   Tue, 19 Sep 2023 08:34:16 +0200
Message-ID: <20230919083414.a25780c91c3a.Ib812a4b56c78684bf33524ae0903fcb1e995b8bb@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919083414.d97c3dfda70e.I058ce0718e73c97de9cd19f499d40891df984ece@changeid>
References: <20230919083414.d97c3dfda70e.I058ce0718e73c97de9cd19f499d40891df984ece@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When returning from ieee80211_key_link(), the key needs to
have been freed or successfully installed. This was missed
in a number of error paths, fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/key.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 84ba20c3e3dc..0665ff5e456e 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -802,6 +802,9 @@ static void ieee80211_key_destroy(struct ieee80211_key *key,
 
 void ieee80211_key_free_unused(struct ieee80211_key *key)
 {
+	if (!key)
+		return;
+
 	WARN_ON(key->sdata || key->local);
 	ieee80211_key_free_common(key);
 }
@@ -854,7 +857,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 * can cause warnings to appear.
 	 */
 	bool delay_tailroom = sdata->vif.type == NL80211_IFTYPE_STATION;
-	int ret = -EOPNOTSUPP;
+	int ret;
 
 	mutex_lock(&sdata->local->key_mtx);
 
@@ -868,8 +871,10 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		 * the same cipher. Enforce the assumption for pairwise keys.
 		 */
 		if ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
-		    (old_key && old_key->conf.cipher != key->conf.cipher))
+		    (old_key && old_key->conf.cipher != key->conf.cipher)) {
+			ret = -EOPNOTSUPP;
 			goto out;
+		}
 	} else if (sta) {
 		struct link_sta_info *link_sta = &sta->deflink;
 		int link_id = key->conf.link_id;
@@ -895,8 +900,10 @@ int ieee80211_key_link(struct ieee80211_key *key,
 
 	/* Non-pairwise keys must also not switch the cipher on rekey */
 	if (!pairwise) {
-		if (old_key && old_key->conf.cipher != key->conf.cipher)
+		if (old_key && old_key->conf.cipher != key->conf.cipher) {
+			ret = -EOPNOTSUPP;
 			goto out;
+		}
 	}
 
 	/*
@@ -904,9 +911,8 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 * new version of the key to avoid nonce reuse or replay issues.
 	 */
 	if (ieee80211_key_identical(sdata, old_key, key)) {
-		ieee80211_key_free_unused(key);
 		ret = -EALREADY;
-		goto out;
+		goto unlock;
 	}
 
 	key->local = sdata->local;
@@ -930,7 +936,11 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		ieee80211_key_free(key, delay_tailroom);
 	}
 
+	key = NULL;
+
  out:
+	ieee80211_key_free_unused(key);
+ unlock:
 	mutex_unlock(&sdata->local->key_mtx);
 
 	return ret;
-- 
2.41.0

