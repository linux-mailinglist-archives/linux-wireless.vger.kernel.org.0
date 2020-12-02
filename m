Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568242CB422
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 06:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLBE4P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 23:56:15 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:49601 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLBE4P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 23:56:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606884950; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Y0sxRJNJS5B+mb9efI/4KZVV1ub/u03t9Fe872TfCb8=; b=glK9qkSt8khbsvX48nF4TbMewFMJzsrpML73RMnpNuRVKk8GnokTX/5MXZayZckWx8VAvE+N
 IuunjoKrg1Htkf0JJxBptr1J5FSpSmnCHS0f1mpnpvQO7QZD88urBPKJAnzCwnk4zcDxxUwT
 Z94K8F98cGBytTE4U/Ar0dtfWr4=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fc71e3bf653ea0cd851deb0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 04:55:23
 GMT
Sender: tmariyap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4CDA0C433ED; Wed,  2 Dec 2020 04:55:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from cdchalpyex0390930-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tmariyap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11EFDC433C6;
        Wed,  2 Dec 2020 04:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11EFDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tmariyap@codeaurora.org
From:   Thiraviyam Mariyappan <tmariyap@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <tmariyap@codeaurora.org>
Subject: [PATCH] mac80211: fix rx byte values not updated on mesh link
Date:   Wed,  2 Dec 2020 10:25:12 +0530
Message-Id: <1606884912-10987-1-git-send-email-tmariyap@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mesh link, rx byte values were not updating though rx packets keep
increasing in the station dump. This is because of rx_stats were updated
regardless of USES_RSS flag is enabled/disabled. Solved the issue by
updating the rx_stats from percpu pointers according to the USES_RSS flag

Signed-off-by: Thiraviyam Mariyappan <tmariyap@codeaurora.org>
---
 net/mac80211/mesh_plink.c |  6 +++++-
 net/mac80211/rx.c         | 44 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index aca26df..e840277 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -416,6 +416,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 	u32 rates, basic_rates = 0, changed = 0;
 	enum ieee80211_sta_rx_bandwidth bw = sta->sta.bandwidth;
+	struct ieee80211_sta_rx_stats *stats;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -425,7 +426,10 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					&basic_rates);
 
 	spin_lock_bh(&sta->mesh->plink_lock);
-	sta->rx_stats.last_rx = jiffies;
+	stats = &sta->rx_stats;
+	if (ieee80211_hw_check(&local->hw, USES_RSS))
+		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+	stats->last_rx = jiffies;
 
 	/* rates and capabilities don't change during peering */
 	if (sta->mesh->plink_state == NL80211_PLINK_ESTAB &&
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 062c2b4..1e8851d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2212,6 +2212,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	unsigned int frag, seq;
 	struct ieee80211_fragment_entry *entry;
 	struct sk_buff *skb;
+	struct ieee80211_sta_rx_stats *stats;
 
 	hdr = (struct ieee80211_hdr *)rx->skb->data;
 	fc = hdr->frame_control;
@@ -2340,8 +2341,12 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
  out:
 	ieee80211_led_rx(rx->local);
  out_no_led:
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	if (rx->sta) {
+		stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&rx->sdata->local->hw, USES_RSS))
+			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		stats->packets++;
+	}
 	return RX_CONTINUE;
 }
 
@@ -3134,6 +3139,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *) rx->skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 	int len = rx->skb->len;
+	struct ieee80211_sta_rx_stats *stats;
 
 	if (!ieee80211_is_action(mgmt->frame_control))
 		return RX_CONTINUE;
@@ -3415,16 +3421,24 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 
  handled:
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	if (rx->sta) {
+		stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&local->hw, USES_RSS))
+			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		stats->packets++;
+	}
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 
  queue:
 	skb_queue_tail(&sdata->skb_queue, rx->skb);
 	ieee80211_queue_work(&local->hw, &sdata->work);
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	if (rx->sta) {
+		stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&local->hw, USES_RSS))
+			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		stats->packets++;
+	}
 	return RX_QUEUED;
 }
 
@@ -3467,6 +3481,7 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *) rx->skb->data;
 	int len = rx->skb->len;
+	struct ieee80211_sta_rx_stats *stats;
 
 	if (!ieee80211_is_action(mgmt->frame_control))
 		return RX_CONTINUE;
@@ -3490,8 +3505,12 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 
  handled:
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	if (rx->sta) {
+		stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&rx->sdata->local->hw, USES_RSS))
+			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		stats->packets++;
+	}
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 }
@@ -3585,6 +3604,7 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
 	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
+	struct ieee80211_sta_rx_stats *stats;
 	__le16 stype;
 
 	stype = mgmt->frame_control & cpu_to_le16(IEEE80211_FCTL_STYPE);
@@ -3635,8 +3655,12 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 	/* queue up frame and kick off work to process it */
 	skb_queue_tail(&sdata->skb_queue, rx->skb);
 	ieee80211_queue_work(&rx->local->hw, &sdata->work);
-	if (rx->sta)
-		rx->sta->rx_stats.packets++;
+	if (rx->sta) {
+		stats = &rx->sta->rx_stats;
+		if (ieee80211_hw_check(&rx->sdata->local->hw, USES_RSS))
+			stats = this_cpu_ptr(rx->sta->pcpu_rx_stats);
+		stats->packets++;
+	}
 
 	return RX_QUEUED;
 }
-- 
2.7.4

