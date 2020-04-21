Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC91B2A7B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgDUOu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 10:50:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21988 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgDUOu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 10:50:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587480657; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=aIbYZlEVeIdEqygMGIZ/oMOCdCSL+gwjtNAPphhg01A=; b=ASC/+u1Vbxx9lC9J7D0b3E492ptdv8ir+fnEQtvqvlSBvR7Y+RdIpH7NbmJhu4eTB39E2125
 o5FvIsQOfg+CCDoEJM8V1mwiL4ahLMPNqqpGowe54C/1TNt2/XwHU/iG0vjgTCTgIBrz+QHJ
 /27y413XH0vUX/2ZbANZ4EhzB/s=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9f0840.7f397b086688-smtp-out-n01;
 Tue, 21 Apr 2020 14:50:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80CC4C433F2; Tue, 21 Apr 2020 14:50:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3511C433CB;
        Tue, 21 Apr 2020 14:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3511C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] mac80211: Process multicast RX registration for Action frames
Date:   Tue, 21 Apr 2020 17:48:15 +0300
Message-Id: <20200421144815.19175-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert a user space registration for processing multicast Action frames
(NL80211_CMD_REGISTER_FRAME with NL80211_ATTR_RECEIVE_MULTICAST) to a
new enum ieee80211_filter_flags bit FIF_MCAST_ACTION so that drivers can
update their RX filter parameters appropriately, if needed.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/mac80211.h     |  6 ++++++
 net/mac80211/cfg.c         | 13 ++++++++++---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/main.c        |  3 +++
 4 files changed, 20 insertions(+), 3 deletions(-)

This depends on the pending cfg80211 patch
[RFC PATCH] cfg80211: support multicast RX registration

Updates since RFC:
- document this to match Action frames in general, not just Public
  Action frames
- set rx_multicast_reg based on registration being for Action frame
  subtype instead of any subtype

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f6dc5a38720f..ef9a07cb3777 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1620,6 +1620,8 @@ enum ieee80211_vif_flags {
  *	monitor interface (if that is requested.)
  * @probe_req_reg: probe requests should be reported to mac80211 for this
  *	interface.
+ * @rx_multicast_reg: multicast Action frames should be reported to mac80211
+ *	for this interface.
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
+ * @FIF_MCAST_ACTION: pass multicast Action frames
  */
 enum ieee80211_filter_flags {
 	FIF_ALLMULTI		= 1<<1,
@@ -3101,6 +3106,7 @@ enum ieee80211_filter_flags {
 	FIF_OTHER_BSS		= 1<<6,
 	FIF_PSPOLL		= 1<<7,
 	FIF_PROBE_REQ		= 1<<8,
+	FIF_MCAST_ACTION	= 1<<9,
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e62b4764e82e..85e9d4c58c80 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3406,15 +3406,22 @@ ieee80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	u32 preq_mask = BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
+	u32 action_mask = BIT(IEEE80211_STYPE_ACTION >> 4);
 	bool global_change, intf_change;
 
 	global_change =
-		local->probe_req_reg != !!(upd->global_stypes & preq_mask);
+		(local->probe_req_reg != !!(upd->global_stypes & preq_mask)) ||
+		(local->rx_multicast_reg !=
+		 !!(upd->global_mcast_stypes & action_mask));
 	local->probe_req_reg = upd->global_stypes & preq_mask;
+	local->rx_multicast_reg = upd->global_mcast_stypes & action_mask;
 
-	intf_change = sdata->vif.probe_req_reg !=
-				!!(upd->interface_stypes & preq_mask);
+	intf_change = (sdata->vif.probe_req_reg !=
+		       !!(upd->interface_stypes & preq_mask)) ||
+		(sdata->vif.rx_multicast_reg !=
+		 !!(upd->interface_mcast_stypes & action_mask));
 	sdata->vif.probe_req_reg = upd->interface_stypes & preq_mask;
+	sdata->vif.rx_multicast_reg = upd->interface_mcast_stypes & action_mask;
 
 	if (!local->open_count)
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0c86f78c1bf3..c8acbd550ef7 100644
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
index 0e9ad60fb2b3..f33920df98d1 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -64,6 +64,9 @@ void ieee80211_configure_filter(struct ieee80211_local *local)
 	if (local->fif_pspoll)
 		new_flags |= FIF_PSPOLL;
 
+	if (local->rx_multicast_reg)
+		new_flags |= FIF_MCAST_ACTION;
+
 	spin_lock_bh(&local->filter_lock);
 	changed_flags = local->filter_flags ^ new_flags;
 
-- 
2.20.1
