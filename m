Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B057334F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiGMJqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbiGMJp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7FF6B82
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fQhhEjKraYyQiBmUehadiMQLkQvP6p1VhWtxcoifpHg=;
        t=1657705522; x=1658915122; b=vDGrWwLRsYonx8E3a9pOiqxZD9LDGUYAJlI1UCNxnLxQQya
        aAWXPWVsUxhiY/UYcTSRjuEJ1/fM9A0uXh4MrPS7s5ka1CFpbOSSaPg23S7gVZ8dwHwhu/dLeeVJM
        f6AciIPtNyItoaru+h/n8ul6ghfAZe0eTcl0xB/0pHkua4TFmzungtMl+z9pt2n7mGAxU7WIGzIF0
        B0tZKJlReXm4KVnjHaNgihRgPNohMwsHKdS7GIzFZJFioQ1QVfg7SVYS430pdEKrQKM/VgcRqKWW+
        AqsRqVveZMRy1p2vPV1zqWRkGIGVbM7jzvWfdWaeyiq/mQC45snYAdZ2FSCZeIcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvo-00EgvB-E2;
        Wed, 13 Jul 2022 11:45:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 46/76] wifi: mac80211: don't re-parse elems in ieee80211_assoc_success()
Date:   Wed, 13 Jul 2022 11:44:32 +0200
Message-Id: <20220713114425.67c47f031e80.Ib37e7c341c74a7de1166bac5b936231fb549046e@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

We're already passing the elems pointer, and have parsed
them from the same frame with exactly the same parameters,
so don't need to do that again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1819a8161e12..aec77e81df99 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3469,27 +3469,17 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 	struct ieee80211_link_data *link = &sdata->deflink;
 	u32 changed = 0;
-	u8 *pos;
 	int err;
 	bool ret;
 
-	/* AssocResp and ReassocResp have identical structure */
-
-	pos = mgmt->u.assoc_resp.variable;
-	aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
-	if (is_s1g) {
-		pos = (u8 *) mgmt->u.s1g_assoc_resp.variable;
-		aid = 0; /* TODO */
-	}
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
-	elems = ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false,
-				       mgmt->bssid, assoc_data->bss->bssid);
-
-	if (!elems)
-		return false;
 
 	if (elems->aid_resp)
 		aid = le16_to_cpu(elems->aid_resp->aid);
+	else if (is_s1g)
+		aid = 0; /* TODO */
+	else
+		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
 
 	/*
 	 * The 5 MSB of the AID field are reserved
@@ -3864,7 +3854,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	ret = true;
  out:
-	kfree(elems);
 	kfree(bss_ies);
 	return ret;
 }
-- 
2.36.1

