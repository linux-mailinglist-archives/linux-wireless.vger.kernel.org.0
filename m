Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE6508651
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiDTKwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiDTKv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 06:51:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D71ADAF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dgoqs00cvV7S+03DmfgiN1JayvNgrgAEjiayx1PuzfY=; b=qo7X8XIfJU62Vg4DH0VI0UiSHw
        37dfh8W3nZlykF6QdRtC7j+BC6QXaTA93UzwfzE+3sm/JhNAynE+tYPWSEusrOr5B8ocxLAdj+iU6
        dXCTYjRjcC1tQWuSynl+edn9W9xI0IPElupi8RhfjZaHKVPLXZUnejRqlBZsItSL92PM=;
Received: from p200300daa70ef200009e86881025829d.dip0.t-ipconnect.de ([2003:da:a70e:f200:9e:8688:1025:829d] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nh7tX-0005E2-JQ; Wed, 20 Apr 2022 12:49:11 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, cc@80211.de
Subject: [PATCH] mac80211: upgrade passive scan to active scan on DFS channels after beacon rx
Date:   Wed, 20 Apr 2022 12:49:07 +0200
Message-Id: <20220420104907.36275-1-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In client mode, we can't connect to hidden SSID APs or SSIDs not advertised
in beacons on DFS channels, since we're forced to passive scan. Fix this by
sending out a probe request immediately after the first beacon, if active
scan was requested by the user.

Cc: stable@vger.kernel.org
Reported-by: Catrinel Catrinescu <cc@80211.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/scan.c        | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d4a7ba4a8202..e58aa6fa58f2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1148,6 +1148,9 @@ struct tpt_led_trigger {
  *	a scan complete for an aborted scan.
  * @SCAN_HW_CANCELLED: Set for our scan work function when the scan is being
  *	cancelled.
+ * @SCAN_BEACON_WAIT: Set whenever we're passive scanning because of radar/no-IR
+ *	and could send a probe request after receiving a beacon.
+ * @SCAN_BEACON_DONE: Beacon received, we can now send a probe request
  */
 enum {
 	SCAN_SW_SCANNING,
@@ -1156,6 +1159,8 @@ enum {
 	SCAN_COMPLETED,
 	SCAN_ABORTED,
 	SCAN_HW_CANCELLED,
+	SCAN_BEACON_WAIT,
+	SCAN_BEACON_DONE,
 };
 
 /**
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5e6b275afc9e..b698756887eb 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -281,6 +281,16 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	if (likely(!sdata1 && !sdata2))
 		return;
 
+	if (test_and_clear_bit(SCAN_BEACON_WAIT, &local->scanning)) {
+		/*
+		 * we were passive scanning because of radar/no-IR, but
+		 * the beacon/proberesp rx gives us an opportunity to upgrade
+		 * to active scan
+		 */
+		 set_bit(SCAN_BEACON_DONE, &local->scanning);
+		 ieee80211_queue_delayed_work(&local->hw, &local->scan_work, 0);
+	}
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
@@ -787,6 +797,8 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 						IEEE80211_CHAN_RADAR)) ||
 		    !req->n_ssids) {
 			next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
+			if (req->n_ssids)
+				set_bit(SCAN_BEACON_WAIT, &local->scanning);
 		} else {
 			ieee80211_scan_state_send_probe(local, &next_delay);
 			next_delay = IEEE80211_CHANNEL_TIME;
@@ -998,6 +1010,8 @@ static void ieee80211_scan_state_set_channel(struct ieee80211_local *local,
 	    !scan_req->n_ssids) {
 		*next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
 		local->next_scan_state = SCAN_DECISION;
+		if (scan_req->n_ssids)
+			set_bit(SCAN_BEACON_WAIT, &local->scanning);
 		return;
 	}
 
@@ -1090,6 +1104,8 @@ void ieee80211_scan_work(struct work_struct *work)
 			goto out;
 	}
 
+	clear_bit(SCAN_BEACON_WAIT, &local->scanning);
+
 	/*
 	 * as long as no delay is required advance immediately
 	 * without scheduling a new work
@@ -1100,6 +1116,10 @@ void ieee80211_scan_work(struct work_struct *work)
 			goto out_complete;
 		}
 
+		if (test_and_clear_bit(SCAN_BEACON_DONE, &local->scanning) &&
+		    local->next_scan_state == SCAN_DECISION)
+			local->next_scan_state = SCAN_SEND_PROBE;
+
 		switch (local->next_scan_state) {
 		case SCAN_DECISION:
 			/* if no more bands/channels left, complete scan */
-- 
2.35.1

