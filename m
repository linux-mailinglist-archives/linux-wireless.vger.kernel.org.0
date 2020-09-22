Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A723273F89
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIVKYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 06:24:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A5C061755
        for <linux-wireless@vger.kernel.org>; Tue, 22 Sep 2020 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pQGJtkUrXuMxTVGBKNjPtRwCzVwoiD+gH/7spihF/zQ=; b=gN8OVJdEyaqL8+wn3bcnESfTFK
        NqZtyCohTcaoS3vhceRKkxo++AhyzuZwoXlKAWsaoaN0pb943QrM7LhbDFsP+w3sD56hYfO+wEj9V
        oQ424Tac3WVo01KwAUL4xi7UI4V0e077WVY3AKxXuxYB6zHtolvOltnzLku3ie89KXzA=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kKfTP-0004Kj-R7; Tue, 22 Sep 2020 12:24:35 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Georgi Valkov <gvalkov@abv.bg>
Subject: [PATCH v2] mac80211: fix regression in sta connection monitor
Date:   Tue, 22 Sep 2020 12:24:34 +0200
Message-Id: <20200922102434.42727-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When a frame was acked and probe frames were sent, the connection monitoring
needs to be reset, otherwise it will keep probing until the connection is
considered dead, even though frames have been acked in the mean time.

Fixes: 9abf4e49830d ("mac80211: optimize station connection monitor")
Reported-by: Georgi Valkov <gvalkov@abv.bg>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: reset connection monitor when a frame was acked (not just for nulldata)

 net/mac80211/status.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 7fe5bececfd9..cc870d1f7db6 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1120,6 +1120,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 	if (pubsta) {
+		struct ieee80211_sub_if_data *sdata = sta->sdata;
+
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
@@ -1134,6 +1136,13 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				/* Track when last packet was ACKed */
 				sta->status_stats.last_pkt_time = jiffies;
 
+				/* Reset connection monitor */
+				if (sdata->vif.type == NL80211_IFTYPE_STATION &&
+				    unlikely(sdata->u.mgd.probe_send_count > 0)) {
+					sdata->u.mgd.probe_send_count = 0;
+					ieee80211_queue_work(&local->hw, &sdata->work);
+				}
+
 				if (info->status.is_valid_ack_signal) {
 					sta->status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
-- 
2.28.0

