Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE8255123
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0Wdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:32 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50500 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727889AbgH0Wd3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id F3D814F8094;
        Thu, 27 Aug 2020 22:33:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F4iT5SMMMuPj; Thu, 27 Aug 2020 22:33:26 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 305494F81CE;
        Thu, 27 Aug 2020 22:33:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 13/22] cfg80211: handle Association Response from S1G STA
Date:   Thu, 27 Aug 2020 15:32:55 -0700
Message-Id: <20200827223304.16155-14-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sending STA type is implicit based on beacon or probe
response content. If sending STA was an S1G STA, adjust
the Information Element location accordingly.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h |  5 +++++
 net/wireless/mlme.c       | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fe70cd99dec7..9307b60cef97 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1100,6 +1100,11 @@ struct ieee80211_mgmt {
 			/* followed by Supported rates */
 			u8 variable[0];
 		} __packed assoc_resp, reassoc_resp;
+		struct {
+			__le16 capab_info;
+			__le16 status_code;
+			u8 variable[0];
+		} __packed s1g_assoc_resp, s1g_reassoc_resp;
 		struct {
 			__le16 capab_info;
 			__le16 listen_interval;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a6c61a2e6569..b5275fe93531 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -30,6 +30,8 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
 	struct cfg80211_connect_resp_params cr;
+	const struct cfg80211_bss_ies *ies;
+	const u8 *s1g;
 
 	memset(&cr, 0, sizeof(cr));
 	cr.status = (int)le16_to_cpu(mgmt->u.assoc_resp.status_code);
@@ -42,6 +44,24 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 		len - offsetof(struct ieee80211_mgmt, u.assoc_resp.variable);
 	cr.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED;
 
+	/* Detect whether this was an S1G Association Response and adjust IE
+	 * location accordingly.
+	 */
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	if (WARN_ON(!ies)) {
+		rcu_read_unlock();
+		return;
+	}
+	s1g = cfg80211_find_ie(WLAN_EID_S1G_CAPABILITIES, ies->data, ies->len);
+	if (s1g) {
+		cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
+		cr.resp_ie_len =
+			len - offsetof(struct ieee80211_mgmt,
+				       u.s1g_assoc_resp.variable);
+	}
+	rcu_read_unlock();
+
 	trace_cfg80211_send_rx_assoc(dev, bss);
 
 	/*
-- 
2.20.1

