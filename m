Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2B19B9CC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbgDBBS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:28 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46512 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733237AbgDBBS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 940574F7AF5;
        Thu,  2 Apr 2020 01:18:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YAQedbto12bM; Thu,  2 Apr 2020 01:18:23 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 4F25D4F7AF7;
        Thu,  2 Apr 2020 01:18:13 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 7/9] nl80211: accept scan frequencies in KHz
Date:   Wed,  1 Apr 2020 18:18:08 -0700
Message-Id: <20200402011810.22947-8-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_ATTR_SCAN_FREQUENCIES_KHZ are optional in addition
to the MHz frequencies specified in
NL80211_ATTR_SCAN_FREQUENCIES.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/uapi/linux/nl80211.h |  2 ++
 net/wireless/nl80211.c       | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 28401f039d75..0b76a2dabe25 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2430,6 +2430,7 @@ enum nl80211_commands {
  * @NL80211_ATTR_WIPHY_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
  *	the allowed channel bandwidth configurations. (u8 attribute)
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
+ * @NL80211_ATTR_SCAN_FREQUENCIES_KHZ: nested attribute with KHz frequencies
  *
  * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
  *	(u16).
@@ -2957,6 +2958,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_WIPHY_FREQ_OFFSET,
 	NL80211_ATTR_CENTER_FREQ1_OFFSET,
+	NL80211_ATTR_SCAN_FREQUENCIES_KHZ,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b1226401757a..33feba480df8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -665,6 +665,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
 	[NL80211_ATTR_WIPHY_FREQ_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
+	[NL80211_ATTR_SCAN_FREQUENCIES_KHZ] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -7749,6 +7750,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_scan_request *request;
+	struct nlattr *scan_freqs = NULL;
+	bool scan_freqs_khz = false;
 	struct nlattr *attr;
 	struct wiphy *wiphy;
 	int err, tmp, n_ssids = 0, n_channels, i;
@@ -7767,9 +7770,14 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
-	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
-		n_channels = validate_scan_freqs(
-				info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]);
+	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES_KHZ]) {
+		scan_freqs = info->attrs[NL80211_ATTR_SCAN_FREQUENCIES_KHZ];
+		scan_freqs_khz = true;
+	} else if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES])
+		scan_freqs = info->attrs[NL80211_ATTR_SCAN_FREQUENCIES];
+
+	if (scan_freqs) {
+		n_channels = validate_scan_freqs(scan_freqs);
 		if (!n_channels) {
 			err = -EINVAL;
 			goto unlock;
@@ -7817,13 +7825,16 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	i = 0;
-	if (info->attrs[NL80211_ATTR_SCAN_FREQUENCIES]) {
+	if (scan_freqs) {
 		/* user specified, bail out if channel not found */
-		nla_for_each_nested(attr, info->attrs[NL80211_ATTR_SCAN_FREQUENCIES], tmp) {
+		nla_for_each_nested(attr, scan_freqs, tmp) {
 			struct ieee80211_channel *chan;
+			int freq = nla_get_u32(attr);
 
-			chan = ieee80211_get_channel(wiphy, nla_get_u32(attr));
+			if (!scan_freqs_khz)
+				freq = MHZ_TO_KHZ(freq);
 
+			chan = ieee80211_get_channel_khz(wiphy, freq);
 			if (!chan) {
 				err = -EINVAL;
 				goto out_free;
-- 
2.20.1

