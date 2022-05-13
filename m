Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69119526332
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbiEMNut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382451AbiEMNsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 09:48:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750684BFE3
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9YCcrFeHzxArli9oS8pfdeJEWrQkuBjU1AS+J0qCbyI=;
        t=1652449697; x=1653659297; b=luJngPqNLOncpq3WOMm/ror68Gcdig3hOiR1pmuj1J255AY
        MNFvrkjzO7yVemUWZMOu9uyUWLpnrU8iBkjKOLz0CblmLfRZ7jQjJ+k6ntfy/gtnrIkFCeiUqRNnf
        FXuIoFH5FLw042F/1s3moB4DdPlvIVOg4HmPM5V9h8GtiV2da/iwMSvKTmFVvulYxELAH7yJfsTE4
        Bn3JnS6DpQLWAIiR5bks2bJyaKcqPDU/H76CUvvjzxMF4vzyoKLrrzy4a7M0wj/j6eZ4xLbCTr6aR
        kgdsmSh8OZQXwcKh9Ho6oXYsLZcMmLnaJXI4u613SfPDsE2ZM87+pVgKfuIkxMbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npVeQ-00Abtz-Hb;
        Fri, 13 May 2022 15:48:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] mac80211: mlme: use local SSID copy
Date:   Fri, 13 May 2022 15:48:06 +0200
Message-Id: <20220513154805.89b855fd46f3.Ibdacb74eb4f9b21bc473072605df05bfd8bb2d75@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220513154805.23c69eb5e00a.I9f843f8106faa8572380bcf3954cf26ce9e592d3@changeid>
References: <20220513154805.23c69eb5e00a.I9f843f8106faa8572380bcf3954cf26ce9e592d3@changeid>
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

There's no need to look it up from the ifmgd->associated
BSS configuration, we already maintain a local copy since
commit b0140fda626e ("mac80211: mlme: save ssid info to
ieee80211_bss_conf while assoc"), though now it's in the
vif->cfg instead of bss_conf.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1bf6efe86c02..26b4863ae1ea 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2608,7 +2608,6 @@ static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	const struct element *ssid;
 	u8 *dst = ifmgd->bssid;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
@@ -2642,19 +2641,10 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		ifmgd->nullfunc_failed = false;
 		ieee80211_send_nullfunc(sdata->local, sdata, false);
 	} else {
-		int ssid_len;
-
-		rcu_read_lock();
-		ssid = ieee80211_bss_get_elem(ifmgd->associated, WLAN_EID_SSID);
-		if (WARN_ON_ONCE(ssid == NULL))
-			ssid_len = 0;
-		else
-			ssid_len = ssid->datalen;
-
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
-					      ssid->data, ssid_len,
+					      sdata->vif.cfg.ssid,
+					      sdata->vif.cfg.ssid_len,
 					      ifmgd->associated->channel);
-		rcu_read_unlock();
 	}
 
 	ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
-- 
2.35.3

