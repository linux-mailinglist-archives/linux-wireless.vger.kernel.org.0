Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C915013A0CE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 06:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgANF7q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 00:59:46 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:56788 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgANF7q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 00:59:46 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 00:59:45 EST
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 81E4D2F0A42;
        Tue, 14 Jan 2020 05:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rW9lRudRv4wN; Mon, 13 Jan 2020 21:59:42 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 708E32F0A43;
        Mon, 13 Jan 2020 21:59:41 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 2/2] mac80211: add ieee80211_is_any_nullfunc()
Date:   Mon, 13 Jan 2020 21:59:40 -0800
Message-Id: <20200114055940.18502-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114055940.18502-1-thomas@adapt-ip.com>
References: <20200114055940.18502-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

commit 08a5bdde3812 ("mac80211: consider QoS Null frames for STA_NULLFUNC_ACKED")
Fixed a bug where we failed to take into account a
nullfunc frame can be either non-QoS or QoS. It turns out
there is at least one more bug in
ieee80211_sta_tx_notify(), introduced in
commit 7b6ddeaf27ec ("mac80211: use QoS NDP for AP probing"),
where we forgot to check for the QoS variant and so
assumed the QoS nullfunc frame never went out

Fix this by adding a helper ieee80211_is_any_nullfunc()
which consolidates the check for non-QoS and QoS nullfunc
frames. Replace existing compound conditionals and add a
couple more missing checks for QoS variant.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h | 9 +++++++++
 net/mac80211/mlme.c       | 2 +-
 net/mac80211/rx.c         | 8 +++-----
 net/mac80211/status.c     | 5 ++---
 net/mac80211/tx.c         | 2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e172d0c7bf74..1c4409b4c012 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -619,6 +619,15 @@ static inline bool ieee80211_is_qos_nullfunc(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
 }
 
+/**
+ * ieee80211_is_any_nullfunc - check if frame is regular or QoS nullfunc frame
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee80211_is_any_nullfunc(__le16 fc)
+{
+	return (ieee80211_is_nullfunc(fc) || ieee80211_is_qos_nullfunc(fc));
+}
+
 /**
  * ieee80211_is_bufferable_mmpdu - check if frame is bufferable MMPDU
  * @fc: frame control field in little-endian byteorder
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5fa13176036f..5cc5593f71b5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2460,7 +2460,7 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 	if (!ieee80211_is_data(hdr->frame_control))
 	    return;
 
-	if (ieee80211_is_nullfunc(hdr->frame_control) &&
+	if (ieee80211_is_any_nullfunc(hdr->frame_control) &&
 	    sdata->u.mgd.probe_send_count > 0) {
 		if (ack)
 			ieee80211_sta_reset_conn_monitor(sdata);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0e05ff037672..619c223f1cde 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1450,8 +1450,7 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (ieee80211_is_ctl(hdr->frame_control) ||
-	    ieee80211_is_nullfunc(hdr->frame_control) ||
-	    ieee80211_is_qos_nullfunc(hdr->frame_control) ||
+	    ieee80211_is_any_nullfunc(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
 		return RX_CONTINUE;
 
@@ -1838,8 +1837,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	 * Drop (qos-)data::nullfunc frames silently, since they
 	 * are used only to control station power saving mode.
 	 */
-	if (ieee80211_is_nullfunc(hdr->frame_control) ||
-	    ieee80211_is_qos_nullfunc(hdr->frame_control)) {
+	if (ieee80211_is_any_nullfunc(hdr->frame_control)) {
 		I802_DEBUG_INC(rx->local->rx_handlers_drop_nullfunc);
 
 		/*
@@ -2319,7 +2317,7 @@ static int ieee80211_drop_unencrypted(struct ieee80211_rx_data *rx, __le16 fc)
 
 	/* Drop unencrypted frames if key is set. */
 	if (unlikely(!ieee80211_has_protected(fc) &&
-		     !ieee80211_is_nullfunc(fc) &&
+		     !ieee80211_is_any_nullfunc(fc) &&
 		     ieee80211_is_data(fc) && rx->key))
 		return -EACCES;
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 0344b82a34f5..f05c829d02d3 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -643,8 +643,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		rcu_read_lock();
 		sdata = ieee80211_sdata_from_skb(local, skb);
 		if (sdata) {
-			if (ieee80211_is_nullfunc(hdr->frame_control) ||
-			    ieee80211_is_qos_nullfunc(hdr->frame_control))
+			if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
 						      cookie, acked,
 						      info->status.ack_signal,
@@ -1056,7 +1055,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			I802_DEBUG_INC(local->dot11FailedCount);
 	}
 
-	if ((ieee80211_is_nullfunc(fc) || ieee80211_is_qos_nullfunc(fc)) &&
+	if (ieee80211_is_any_nullfunc(fc) &&
 	    ieee80211_has_pm(fc) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
 	    !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c56d801e708f..4296d9d71311 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -297,7 +297,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
 	    test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
 	    !ieee80211_is_probe_req(hdr->frame_control) &&
-	    !ieee80211_is_nullfunc(hdr->frame_control))
+	    !ieee80211_is_any_nullfunc(hdr->frame_control))
 		/*
 		 * When software scanning only nullfunc frames (to notify
 		 * the sleep state to the AP) and probe requests (for the
-- 
2.20.1

