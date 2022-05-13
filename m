Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39852630B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349207AbiEMNur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382450AbiEMNsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 09:48:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F4AFD3C
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=gMV3qebm/IUQpicVsS6UZ5ZUBWHJZnDFwO46s6iwiic=; t=1652449697; x=1653659297; 
        b=l86sEkXSEhqRmU//dFHyVjse+KR8HYgVQp97+IxiKl0pZRRYrufr3Lq+5g4kjgCyEc0la707Bbk
        QeQ+wXgKNrQzo5BV/IOFF143SCpb6Xb1/dztn5AwTfkr9ZuR7PJvPEjnlj/s/PPPXjVrvTh2tGM0q
        oi17pWZvNWdywNPR9908JcoGBC5ZP0Gi0YBbFoTwpe3b0E3UC9qOBomy97hRtiuCw4x47/MUPmmBY
        2mjxjtn06TCCKR2SA6bc2k0YvoUEsPSGLr29QDLnT9lxZCxfy6+8MWQ9i38OwF/vglmK3CHyswhZN
        si/54rCepyUJfqBz5WZH0nIJiMMfzpOLz0gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npVeQ-00Abtz-03;
        Fri, 13 May 2022 15:48:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] mac80211: mlme: move in RSSI reporting code
Date:   Fri, 13 May 2022 15:48:04 +0200
Message-Id: <20220513154805.23c69eb5e00a.I9f843f8106faa8572380bcf3954cf26ce9e592d3@changeid>
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

This code is tightly coupled to the sdata->u.mgd data
structure, so there's no reason for it to be in utils.
Move it to mlme.c.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c | 40 ----------------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f02137b4cb12..c32cfb5de5d8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6379,3 +6379,43 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp)
 	cfg80211_cqm_beacon_loss_notify(sdata->dev, gfp);
 }
 EXPORT_SYMBOL(ieee80211_cqm_beacon_loss_notify);
+
+static void _ieee80211_enable_rssi_reports(struct ieee80211_sub_if_data *sdata,
+					    int rssi_min_thold,
+					    int rssi_max_thold)
+{
+	trace_api_enable_rssi_reports(sdata, rssi_min_thold, rssi_max_thold);
+
+	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
+		return;
+
+	/*
+	 * Scale up threshold values before storing it, as the RSSI averaging
+	 * algorithm uses a scaled up value as well. Change this scaling
+	 * factor if the RSSI averaging algorithm changes.
+	 */
+	sdata->u.mgd.rssi_min_thold = rssi_min_thold*16;
+	sdata->u.mgd.rssi_max_thold = rssi_max_thold*16;
+}
+
+void ieee80211_enable_rssi_reports(struct ieee80211_vif *vif,
+				    int rssi_min_thold,
+				    int rssi_max_thold)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	WARN_ON(rssi_min_thold == rssi_max_thold ||
+		rssi_min_thold > rssi_max_thold);
+
+	_ieee80211_enable_rssi_reports(sdata, rssi_min_thold,
+				       rssi_max_thold);
+}
+EXPORT_SYMBOL(ieee80211_enable_rssi_reports);
+
+void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	_ieee80211_enable_rssi_reports(sdata, 0, 0);
+}
+EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 682a164f795a..1e26b5235add 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2854,46 +2854,6 @@ size_t ieee80211_ie_split_vendor(const u8 *ies, size_t ielen, size_t offset)
 	return pos;
 }
 
-static void _ieee80211_enable_rssi_reports(struct ieee80211_sub_if_data *sdata,
-					    int rssi_min_thold,
-					    int rssi_max_thold)
-{
-	trace_api_enable_rssi_reports(sdata, rssi_min_thold, rssi_max_thold);
-
-	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
-		return;
-
-	/*
-	 * Scale up threshold values before storing it, as the RSSI averaging
-	 * algorithm uses a scaled up value as well. Change this scaling
-	 * factor if the RSSI averaging algorithm changes.
-	 */
-	sdata->u.mgd.rssi_min_thold = rssi_min_thold*16;
-	sdata->u.mgd.rssi_max_thold = rssi_max_thold*16;
-}
-
-void ieee80211_enable_rssi_reports(struct ieee80211_vif *vif,
-				    int rssi_min_thold,
-				    int rssi_max_thold)
-{
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-
-	WARN_ON(rssi_min_thold == rssi_max_thold ||
-		rssi_min_thold > rssi_max_thold);
-
-	_ieee80211_enable_rssi_reports(sdata, rssi_min_thold,
-				       rssi_max_thold);
-}
-EXPORT_SYMBOL(ieee80211_enable_rssi_reports);
-
-void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif)
-{
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-
-	_ieee80211_enable_rssi_reports(sdata, 0, 0);
-}
-EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
-
 u8 *ieee80211_ie_build_ht_cap(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			      u16 cap)
 {
-- 
2.35.3

