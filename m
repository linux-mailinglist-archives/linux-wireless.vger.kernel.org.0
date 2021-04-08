Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8738358516
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 15:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhDHNqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhDHNqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 09:46:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A968C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 06:46:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUUzF-0091Jb-Qe; Thu, 08 Apr 2021 15:46:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzkaller@googlegroups.com,
        syzbot+72b99dcf4607e8c770f3@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH] nl80211: fix beacon head validation
Date:   Thu,  8 Apr 2021 15:45:20 +0200
Message-Id: <20210408154518.d9b06d39b4ee.Iff908997b2a4067e8d456b3cb96cab9771d252b8@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the beacon head attribute (NL80211_ATTR_BEACON_HEAD)
is too short to even contain the frame control field,
we access uninitialized data beyond the buffer. Fix this
by checking the minimal required size first. We used to
do this until S1G support was added, where the fixed
data portion has a different size.

Cc: syzkaller@googlegroups.com
Reported-by: syzbot+72b99dcf4607e8c770f3@syzkaller.appspotmail.com
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 1d47f1198d58 ("nl80211: correctly validate S1G beacon head")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
#syz test: https://github.com/google/kmsan.git master
---
 net/wireless/nl80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index adfa07c67b44..03426cf17ee6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -229,9 +229,13 @@ static int validate_beacon_head(const struct nlattr *attr,
 	unsigned int len = nla_len(attr);
 	const struct element *elem;
 	const struct ieee80211_mgmt *mgmt = (void *)data;
-	bool s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
 	unsigned int fixedlen, hdrlen;
+	bool s1g_bcn;
 
+	if (len < offsetofend(typeof(*mgmt), frame_control))
+		goto err;
+
+	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
 	if (s1g_bcn) {
 		fixedlen = offsetof(struct ieee80211_ext,
 				    u.s1g_beacon.variable);
-- 
2.30.2

