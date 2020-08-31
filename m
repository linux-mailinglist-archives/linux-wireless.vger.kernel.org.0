Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A225830D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgHaU4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:14 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52210 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729485AbgHaU4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 51DAC4F8F09;
        Mon, 31 Aug 2020 20:56:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kxkuQSDrrqZr; Mon, 31 Aug 2020 20:56:10 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 94E744F8D69;
        Mon, 31 Aug 2020 20:56:06 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 04/22] nl80211: correctly validate S1G beacon head
Date:   Mon, 31 Aug 2020 13:55:42 -0700
Message-Id: <20200831205600.21058-5-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The S1G beacon has a different header size than regular
beacons, so adjust the beacon head validator.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/wireless/nl80211.c | 16 +++++++++++++---
 net/wireless/util.c    |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7da4d84bcc1a..3bf595c828db 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -209,14 +209,24 @@ static int validate_beacon_head(const struct nlattr *attr,
 	unsigned int len = nla_len(attr);
 	const struct element *elem;
 	const struct ieee80211_mgmt *mgmt = (void *)data;
-	unsigned int fixedlen = offsetof(struct ieee80211_mgmt,
-					 u.beacon.variable);
+	bool s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
+	unsigned int fixedlen, hdrlen;
+
+	if (s1g_bcn) {
+		fixedlen = offsetof(struct ieee80211_ext,
+				    u.s1g_beacon.variable);
+		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
+	} else {
+		fixedlen = offsetof(struct ieee80211_mgmt,
+				    u.beacon.variable);
+		hdrlen = offsetof(struct ieee80211_mgmt, u.beacon);
+	}
 
 	if (len < fixedlen)
 		goto err;
 
 	if (ieee80211_hdrlen(mgmt->frame_control) !=
-	    offsetof(struct ieee80211_mgmt, u.beacon))
+	    hdrlen)
 		goto err;
 
 	data += fixedlen;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 4a9ff9ef513f..49e7c0cbbf62 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -399,6 +399,11 @@ unsigned int __attribute_const__ ieee80211_hdrlen(__le16 fc)
 {
 	unsigned int hdrlen = 24;
 
+	if (ieee80211_is_ext(fc)) {
+		hdrlen = 4;
+		goto out;
+	}
+
 	if (ieee80211_is_data(fc)) {
 		if (ieee80211_has_a4(fc))
 			hdrlen = 30;
-- 
2.20.1

