Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A87AB9821
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfITTy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 15:54:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50272 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfITTy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 15:54:28 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iBOz4-0005ZQ-Dn; Fri, 20 Sep 2019 21:54:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nicolas Waisman <nico@semmle.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] nl80211: validate beacon head
Date:   Fri, 20 Sep 2019 21:54:17 +0200
Message-Id: <1569009255-I7ac7fbe9436e9d8733439eab8acbbd35e55c74ef@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently don't validate the beacon head, i.e. the header,
fixed part and elements that are to go in front of the TIM
element. This means that the variable elements there can be
malformed, e.g. have a length exceeding the buffer size, but
most downstream code from this assumes that this has already
been checked.

Add the necessary checks to the netlink policy.

Cc: stable@vger.kernel.org
Fixes: ed1b6cc7f80f ("cfg80211/nl80211: add beacon settings")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd05ae1437a9..932854a0c38b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -201,6 +201,38 @@ cfg80211_get_dev_from_info(struct net *netns, struct genl_info *info)
 	return __cfg80211_rdev_from_attrs(netns, info->attrs);
 }
 
+static int validate_beacon_head(const struct nlattr *attr,
+				struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	const struct element *elem;
+	const struct ieee80211_mgmt *mgmt = (void *)data;
+	unsigned int fixedlen = offsetof(struct ieee80211_mgmt,
+					 u.beacon.variable);
+
+	if (len < fixedlen)
+		goto err;
+
+	if (ieee80211_hdrlen(mgmt->frame_control) !=
+	    offsetof(struct ieee80211_mgmt, u.beacon))
+		goto err;
+
+	data += fixedlen;
+	len -= fixedlen;
+
+	for_each_element(elem, data, len) {
+		/* nothing */
+	}
+
+	if (for_each_element_completed(elem, data, len))
+		return 0;
+
+err:
+	NL_SET_ERR_MSG_ATTR(extack, attr, "malformed beacon head");
+	return -EINVAL;
+}
+
 static int validate_ie_attr(const struct nlattr *attr,
 			    struct netlink_ext_ack *extack)
 {
@@ -322,8 +354,9 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_BEACON_INTERVAL] = { .type = NLA_U32 },
 	[NL80211_ATTR_DTIM_PERIOD] = { .type = NLA_U32 },
-	[NL80211_ATTR_BEACON_HEAD] = { .type = NLA_BINARY,
-				       .len = IEEE80211_MAX_DATA_LEN },
+	[NL80211_ATTR_BEACON_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head,
+				       IEEE80211_MAX_DATA_LEN),
 	[NL80211_ATTR_BEACON_TAIL] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
 				       IEEE80211_MAX_DATA_LEN),
-- 
2.20.1

