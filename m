Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDC273A3D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIVFhc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:32 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34044 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728898AbgIVFhc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9F6234F9E0E;
        Tue, 22 Sep 2020 05:37:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2grerOppbu95; Tue, 22 Sep 2020 05:37:28 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id EF9E74F9DFD;
        Tue, 22 Sep 2020 05:37:18 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 08/17] cfg80211: handle Association Response from S1G STA
Date:   Mon, 21 Sep 2020 19:28:09 -0700
Message-Id: <20200922022818.15855-9-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sending STA type is implicit based on beacon or probe
response content. If sending STA was an S1G STA, adjust
the Information Element location accordingly.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v4:
 - clean up ugly check for S1G BSS (Johannes)
---
 include/linux/ieee80211.h |  5 +++++
 net/wireless/mlme.c       | 14 +++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 1ce0b37441b9..d0fda8424118 100644
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
index db7333e20dd7..0ac820780437 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -30,6 +30,15 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
 	struct cfg80211_connect_resp_params cr;
+	const u8 *resp_ie = mgmt->u.assoc_resp.variable;
+	size_t resp_ie_len = len - offsetof(struct ieee80211_mgmt,
+					    u.assoc_resp.variable);
+
+	if (bss->channel->band == NL80211_BAND_S1GHZ) {
+		resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
+		resp_ie_len = len - offsetof(struct ieee80211_mgmt,
+					     u.s1g_assoc_resp.variable);
+	}
 
 	memset(&cr, 0, sizeof(cr));
 	cr.status = (int)le16_to_cpu(mgmt->u.assoc_resp.status_code);
@@ -37,9 +46,8 @@ void cfg80211_rx_assoc_resp(struct net_device *dev, struct cfg80211_bss *bss,
 	cr.bss = bss;
 	cr.req_ie = req_ies;
 	cr.req_ie_len = req_ies_len;
-	cr.resp_ie = mgmt->u.assoc_resp.variable;
-	cr.resp_ie_len =
-		len - offsetof(struct ieee80211_mgmt, u.assoc_resp.variable);
+	cr.resp_ie = resp_ie;
+	cr.resp_ie_len = resp_ie_len;
 	cr.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED;
 
 	trace_cfg80211_send_rx_assoc(dev, bss);
-- 
2.20.1

