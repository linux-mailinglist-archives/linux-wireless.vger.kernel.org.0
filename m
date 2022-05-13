Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55F65266B6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381644AbiEMQDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378196AbiEMQDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 12:03:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B40286
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=U0ndl2yVU12GGWHlImb/3ibYgf12hCdLV2/qOqFkYyo=; t=1652457798; x=1653667398; 
        b=q+l5KiqeyU0bOWfVQKFJLtbbD7cEHDt+diQSdvTdLcDIcvc/RQwdYXRaoZy0apCLvUqsZHY4yfh
        TzwmqN34g+TVO2p9NAHoC1K9bYZk9S1yo8uzJnHizvJEJf4Yb4W/q3sPazNwNHNoPgGTtfp3BVHbi
        IP8hiCHRM46aWn7P+4Wq5CbAG58LSY/klPbeY7+rF0qurgLv5xqvLQJ1BYaLN05LBmZZvl5wqYtnV
        VA6Jw70K3+w2EfYqYT2S+gOwJBBmEaTpDEmJ8AfCe4qlj8IgQHaiOuyPmc0k2rKg7Sr2rXHtv5Itn
        UWbqvvjobv7VMnlhSbAz02WZ9oJ203H3cU1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npXl6-00AfFY-LO;
        Fri, 13 May 2022 18:03:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: mlme: track assoc_bss/associated separately
Date:   Fri, 13 May 2022 18:03:14 +0200
Message-Id: <20220513180239.fc51207a1228.I48646f2b5c4b52736e2d82919e436391e0b5ca55@changeid>
X-Mailer: git-send-email 2.35.3
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

We currently track whether we're associated and which the
BSS is in the same variable (ifmgd->associated), but for
MLD we'll need to move the BSS pointer to be per link,
while the question whether we're associated or not is for
the whole interface.

Add ifmgd->assoc_bss that stores the pointer and change
ifmgd->associated to be just a bool, so the question of
whether we're associated can continue working after MLD
rework, without requiring changes, while the BSS pointer
will have to be changed/used checked per link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/mlme.c        | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d072f20e3c5a..86ef0a46a68c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -453,9 +453,10 @@ struct ieee80211_if_managed {
 	bool nullfunc_failed;
 	u8 connection_loss:1,
 	   driver_disconnect:1,
-	   reconnect:1;
+	   reconnect:1,
+	   associated:1;
 
-	struct cfg80211_bss *associated;
+	struct cfg80211_bss *assoc_bss;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_mgd_assoc_data *assoc_data;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d38d100b5aed..9eb0bd4e2dc3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1376,7 +1376,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct cfg80211_bss *cbss = ifmgd->associated;
+	struct cfg80211_bss *cbss = ifmgd->assoc_bss;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
 	enum nl80211_band current_band;
@@ -2266,7 +2266,8 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.beacon_timeout = usecs_to_jiffies(ieee80211_tu_to_usec(
 		beacon_loss_count * bss_conf->beacon_int));
 
-	sdata->u.mgd.associated = cbss;
+	sdata->u.mgd.associated = true;
+	sdata->u.mgd.assoc_bss = cbss;
 	memcpy(sdata->u.mgd.bssid, cbss->bssid, ETH_ALEN);
 
 	ieee80211_check_rate_mask(sdata);
@@ -2361,7 +2362,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_stop_poll(sdata);
 
-	ifmgd->associated = NULL;
+	ifmgd->associated = false;
+	ifmgd->assoc_bss = NULL;
 	netif_carrier_off(sdata->dev);
 
 	/*
@@ -2644,7 +2646,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
 					      sdata->vif.cfg.ssid,
 					      sdata->vif.cfg.ssid_len,
-					      ifmgd->associated->channel);
+					      ifmgd->assoc_bss->channel);
 	}
 
 	ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
@@ -2734,7 +2736,7 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	sdata_assert_lock(sdata);
 
 	if (ifmgd->associated)
-		cbss = ifmgd->associated;
+		cbss = ifmgd->assoc_bss;
 	else if (ifmgd->auth_data)
 		cbss = ifmgd->auth_data->bss;
 	else if (ifmgd->assoc_data)
@@ -2799,7 +2801,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 		 * AP is probably out of range (or not reachable for another
 		 * reason) so remove the bss struct for that AP.
 		 */
-		cfg80211_unlink_bss(local->hw.wiphy, ifmgd->associated);
+		cfg80211_unlink_bss(local->hw.wiphy, ifmgd->assoc_bss);
 	}
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
@@ -4185,7 +4187,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(bssid,  ifmgd->associated))
+	    !ieee80211_rx_our_beacon(bssid, ifmgd->assoc_bss))
 		return;
 	bssid = ifmgd->bssid;
 
@@ -6287,7 +6289,7 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 	 * to cfg80211 while that's in a locked section already
 	 * trying to tell us that the user wants to disconnect.
 	 */
-	if (ifmgd->associated != req->bss)
+	if (ifmgd->assoc_bss != req->bss)
 		return -ENOLINK;
 
 	sdata_info(sdata,
-- 
2.35.3

