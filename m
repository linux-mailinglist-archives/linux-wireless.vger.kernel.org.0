Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9953778AF7F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjH1MFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjH1MF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1C123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M4jvdZ1w6AnYwUxT/H6fvVN++4nTWWAzPXI6CBIiKKs=;
        t=1693224325; x=1694433925; b=Th/cffEzm74lenxRECwII0cv4WTSvbSQqqAG+ErfTbvpc0y
        76wAW17F+sPjZNo+t6QtraeDYGLUB+8s0JRtx4xn7mXj8zm68qCxhDvZCO60QUkeRV61pr5oE9N38
        kIIZypfZ2uZJ0ybvHB+7CKtJS1+KUQr/B5m23Hlckv857QQAxFPYetBrsDi3NPEYz4L8KwIMqK8Gm
        +U0/qvNdjvsKMKqHEYjTVUQ283G5QNp1UCTEvnVaUHsp4ZFNEjUhT4q4qXZUu2TlnOXdPsanqc6HO
        yJ8/5DF3zFqIjzEWoAiQQRjqQPpaIcENGTQjFJMV4CObhlR2iLl5Z51SKUSGBdyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazj-00Gjgt-0d;
        Mon, 28 Aug 2023 14:05:23 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/40] wifi: mac80211: add more ops assertions
Date:   Mon, 28 Aug 2023 13:59:36 +0200
Message-ID: <20230828135927.c6d213b259ee.I63b73b2f3cdd145573d3c1f5ea90074f3561912a@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
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

Add more might_sleep() checks and check sdata-in-driver
for one additional place.

type=feature
ticket=jira:WIFI-314309

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/driver-ops.c |  2 ++
 net/mac80211/driver-ops.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 30cd0c905a24..376dae58b5a6 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -285,6 +285,8 @@ int drv_assign_vif_chanctx(struct ieee80211_local *local,
 {
 	int ret = 0;
 
+	might_sleep();
+
 	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index c4505593ba7a..d95ff2282f54 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -40,6 +40,8 @@ static inline void drv_tx(struct ieee80211_local *local,
 static inline void drv_sync_rx_queues(struct ieee80211_local *local,
 				      struct sta_info *sta)
 {
+	might_sleep();
+
 	if (local->ops->sync_rx_queues) {
 		trace_drv_sync_rx_queues(local, sta->sdata, &sta->sta);
 		local->ops->sync_rx_queues(&local->hw);
@@ -569,6 +571,8 @@ static inline void drv_sta_statistics(struct ieee80211_local *local,
 				      struct ieee80211_sta *sta,
 				      struct station_info *sinfo)
 {
+	might_sleep();
+
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return;
@@ -616,6 +620,8 @@ static inline int drv_get_survey(struct ieee80211_local *local, int idx,
 {
 	int ret = -EOPNOTSUPP;
 
+	might_sleep();
+
 	trace_drv_get_survey(local, idx, survey);
 
 	if (local->ops->get_survey)
@@ -797,6 +803,8 @@ static inline void drv_set_rekey_data(struct ieee80211_local *local,
 				      struct ieee80211_sub_if_data *sdata,
 				      struct cfg80211_gtk_rekey_data *data)
 {
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -987,6 +995,8 @@ static inline void drv_stop_ap(struct ieee80211_local *local,
 			       struct ieee80211_sub_if_data *sdata,
 			       struct ieee80211_bss_conf *link_conf)
 {
+	might_sleep();
+
 	/* make sure link_conf is protected */
 	drv_verify_link_exists(sdata, link_conf);
 
@@ -1016,6 +1026,8 @@ drv_set_default_unicast_key(struct ieee80211_local *local,
 			    struct ieee80211_sub_if_data *sdata,
 			    int key_idx)
 {
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1046,6 +1058,8 @@ drv_channel_switch_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 
+	might_sleep();
+
 	if (local->ops->channel_switch_beacon) {
 		trace_drv_channel_switch_beacon(local, sdata, chandef);
 		local->ops->channel_switch_beacon(&local->hw, &sdata->vif,
@@ -1060,6 +1074,8 @@ drv_pre_channel_switch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	int ret = 0;
 
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1077,6 +1093,8 @@ drv_post_channel_switch(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	int ret = 0;
 
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -1092,6 +1110,8 @@ drv_abort_channel_switch(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1107,6 +1127,8 @@ drv_channel_switch_rx_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 
+	might_sleep();
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1163,6 +1185,8 @@ static inline int drv_get_txpower(struct ieee80211_local *local,
 {
 	int ret;
 
+	might_sleep();
+
 	if (!local->ops->get_txpower)
 		return -EOPNOTSUPP;
 
@@ -1267,6 +1291,10 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 {
 	u32 ret = -EOPNOTSUPP;
 
+	might_sleep();
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
 	if (local->ops->get_ftm_responder_stats)
 		ret = local->ops->get_ftm_responder_stats(&local->hw,
 							 &sdata->vif,
@@ -1436,6 +1464,8 @@ static inline void drv_sta_set_4addr(struct ieee80211_local *local,
 				     struct ieee80211_sta *sta, bool enabled)
 {
 	sdata = get_bss_sdata(sdata);
+
+	might_sleep();
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1451,6 +1481,8 @@ static inline void drv_sta_set_decap_offload(struct ieee80211_local *local,
 					     bool enabled)
 {
 	sdata = get_bss_sdata(sdata);
+
+	might_sleep();
 	if (!check_sdata_in_driver(sdata))
 		return;
 
@@ -1526,6 +1558,8 @@ static inline int drv_net_setup_tc(struct ieee80211_local *local,
 {
 	int ret = -EOPNOTSUPP;
 
+	might_sleep();
+
 	sdata = get_bss_sdata(sdata);
 	trace_drv_net_setup_tc(local, sdata, type);
 	if (local->ops->net_setup_tc)
-- 
2.41.0

