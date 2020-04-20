Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA311B178F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTUwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 16:52:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60892 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgDTUwR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 16:52:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587415936; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=FS3wGokY4l7n3IGe8n9wlJQan6rajOpG39dC/pq+HzU=; b=aNErpyVfQQrBNh+TsnYvn0lcdAj1j6LIvHwEJy+yX9biwI4pkeOkbps7dymcq88l1fxC2jKF
 XTtaFMiWbD2EnCH5a7p60QTbOo58neSd6NtA1nYVXgNLx6k8XyVoIYcPzXa1W0EV9A7TuTeP
 KECHX/wexbT+IXED89/L1+Srajk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9e0b7b.7fe904bbe1f0-smtp-out-n01;
 Mon, 20 Apr 2020 20:52:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1133DC433F2; Mon, 20 Apr 2020 20:52:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83E25C433CB;
        Mon, 20 Apr 2020 20:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83E25C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [RFC] mac80211: Process multicast RX registration for Public Action frames
Date:   Mon, 20 Apr 2020 23:50:55 +0300
Message-Id: <20200420205055.15573-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert a user space registration for processing multicast frames
(NL80211_CMD_REGISTER_FRAME with NL80211_ATTR_RECEIVE_MULTICAST) to a
new enum ieee80211_filter_flags bit FIF_MCAST_PUBLIC_ACTION so that
drivers can update the RX filter parameters appropriately, if needed.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/mac80211.h     |  6 ++++++
 net/mac80211/cfg.c         | 10 +++++++---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/main.c        |  3 +++
 4 files changed, 17 insertions(+), 3 deletions(-)

This depends on the pending cfg80211 patch
[RFC PATCH] cfg80211: support multicast RX registration

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f6dc5a38720f..b97569de7a52 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1620,6 +1620,8 @@ enum ieee80211_vif_flags {
  *	monitor interface (if that is requested.)
  * @probe_req_reg: probe requests should be reported to mac80211 for this
  *	interface.
+ * @rx_multicast_reg: multicast Public Action frames should be reported to
+ *	mac80211 for this interface.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
  * @txq: the multicast data TX queue (if driver uses the TXQ abstraction)
@@ -1648,6 +1650,7 @@ struct ieee80211_vif {
 #endif
 
 	bool probe_req_reg;
+	bool rx_multicast_reg;
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
@@ -3091,6 +3094,8 @@ void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
  * @FIF_PSPOLL: pass PS Poll frames
  *
  * @FIF_PROBE_REQ: pass probe request frames
+ *
+ * @FIF_MCAST_PUBLIC_ACTION: pass multicast Public Action frames
  */
 enum ieee80211_filter_flags {
 	FIF_ALLMULTI		= 1<<1,
@@ -3101,6 +3106,7 @@ enum ieee80211_filter_flags {
 	FIF_OTHER_BSS		= 1<<6,
 	FIF_PSPOLL		= 1<<7,
 	FIF_PROBE_REQ		= 1<<8,
+	FIF_MCAST_PUBLIC_ACTION	= 1<<9,
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e62b4764e82e..af8f420c2c6c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3409,12 +3409,16 @@ ieee80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 	bool global_change, intf_change;
 
 	global_change =
-		local->probe_req_reg != !!(upd->global_stypes & preq_mask);
+		(local->probe_req_reg != !!(upd->global_stypes & preq_mask)) ||
+		(local->rx_multicast_reg != !!upd->global_mcast_stypes);
 	local->probe_req_reg = upd->global_stypes & preq_mask;
+	local->rx_multicast_reg = upd->global_mcast_stypes;
 
-	intf_change = sdata->vif.probe_req_reg !=
-				!!(upd->interface_stypes & preq_mask);
+	intf_change = (sdata->vif.probe_req_reg !=
+		       !!(upd->interface_stypes & preq_mask)) ||
+		(sdata->vif.rx_multicast_reg != !!upd->interface_mcast_stypes);
 	sdata->vif.probe_req_reg = upd->interface_stypes & preq_mask;
+	sdata->vif.rx_multicast_reg = upd->interface_mcast_stypes;
 
 	if (!local->open_count)
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3c8b1d9b1a1..9ef2c44bbcd0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1170,6 +1170,7 @@ struct ieee80211_local {
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
 	bool probe_req_reg;
+	bool rx_multicast_reg;
 	unsigned int filter_flags; /* FIF_* */
 
 	bool wiphy_ciphers_allocated;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 0e9ad60fb2b3..0bf5cfb37458 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -64,6 +64,9 @@ void ieee80211_configure_filter(struct ieee80211_local *local)
 	if (local->fif_pspoll)
 		new_flags |= FIF_PSPOLL;
 
+	if (local->rx_multicast_reg)
+		new_flags |= FIF_MCAST_PUBLIC_ACTION;
+
 	spin_lock_bh(&local->filter_lock);
 	changed_flags = local->filter_flags ^ new_flags;
 
-- 
2.20.1
