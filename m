Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E171B8794
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYP6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 11:58:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52231 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbgDYP6w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 11:58:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587830332; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=35c049idyfGWHfLV3bq19zRT2OvzevtvSPzwoZH/uBw=; b=iMU4nH1I180QPSp5EdFe8M34kYjyODGWSnBJ7tE5TymlFpksBY2nSuyDGpeBER+ihiMmpPnS
 39SltWVtrUHXdGLqmZQDKDV0sr/ORsKWhVz1cuMCCivizUzdF592wdqqp6v/Ayu2oaXHs+wD
 k0BNVBLT8SkOQEJRWTXnRBM5ipY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea45e38.7fe69c07eca8-smtp-out-n01;
 Sat, 25 Apr 2020 15:58:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28EC2C433F2; Sat, 25 Apr 2020 15:58:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E9E4C433CB;
        Sat, 25 Apr 2020 15:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E9E4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/5] mac80211: Random MAC address for a Management frame exchange
Date:   Sat, 25 Apr 2020 18:57:09 +0300
Message-Id: <20200425155713.25687-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow user space to use a temporary random MAC address for a Management
frame exchange with drivers that indicate support for this. The main use
for this is to allow GAS/ANQP exchanges to be performed before a
connection without having to expose a persistent MAC address similarly
to the way active scanning can be done with a random MAC address.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/ieee80211_i.h | 3 +++
 net/mac80211/offchannel.c  | 9 +++++++++
 net/mac80211/rx.c          | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9407cf44305c..d58f9acc90a3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1251,6 +1251,9 @@ struct ieee80211_local {
 	struct timer_list sta_cleanup;
 	int sta_generation;
 
+	/* temporary random address for a Management frame exchange */
+	u8 mgmt_tx_rand_addr[ETH_ALEN];
+
 	struct sk_buff_head pending[IEEE80211_MAX_QUEUES];
 	struct tasklet_struct tx_pending_tasklet;
 	struct tasklet_struct wake_txqs_tasklet;
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index db3b8bf75656..afdfced696ec 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -955,6 +955,12 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		IEEE80211_SKB_CB(skb)->hw_queue =
 			local->hw.offchannel_tx_hw_queue;
 
+	/* remember a random MAC address for Management frame exchange */
+	if (wiphy_ext_feature_isset(wiphy,
+				    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA) &&
+	    !ether_addr_equal(mgmt->sa, wdev_address(wdev)))
+		memcpy(local->mgmt_tx_rand_addr, mgmt->sa, ETH_ALEN);
+
 	/* This will handle all kinds of coalescing and immediate TX */
 	ret = ieee80211_start_roc_work(local, sdata, params->chan,
 				       params->wait, cookie, skb,
@@ -971,6 +977,9 @@ int ieee80211_mgmt_tx_cancel_wait(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 
+	/* stop using the random MAC address for Management frame exchange */
+	eth_zero_addr(local->mgmt_tx_rand_addr);
+
 	return ieee80211_cancel_roc(local, cookie, true);
 }
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index eaf8931e4627..60dc2406171f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3898,6 +3898,7 @@ EXPORT_SYMBOL(ieee80211_mark_rx_ba_filtered_frames);
 static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
@@ -3912,6 +3913,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (is_valid_ether_addr(local->mgmt_tx_rand_addr) &&
+		    ether_addr_equal(local->mgmt_tx_rand_addr, hdr->addr1))
+			return true;
+
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
 	case NL80211_IFTYPE_ADHOC:
 		if (!bssid)
-- 
2.20.1
