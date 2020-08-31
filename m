Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335B258317
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgHaU4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:36 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52330 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729579AbgHaU4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 6A43B4F9053;
        Mon, 31 Aug 2020 20:56:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZrpykQiOBirN; Mon, 31 Aug 2020 20:56:29 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 341BA4F8E8D;
        Mon, 31 Aug 2020 20:56:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 13/22] cfg80211: handle Association Response from S1G STA
Date:   Mon, 31 Aug 2020 13:55:51 -0700
Message-Id: <20200831205600.21058-14-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
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
index bca4bb443291..690d00505649 100644
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
index db7333e20dd7..f8655452b81a 100644
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

