Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC630085F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbhAVQNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 11:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbhAVQME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 11:12:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0611BC061788
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 08:11:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2z1s-00ACpP-Kn; Fri, 22 Jan 2021 17:11:20 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+d7a3b15976bf7de2238a@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: disallow TX while changing interface type
Date:   Fri, 22 Jan 2021 17:11:16 +0100
Message-Id: <20210122171115.b321f98f4d4f.I6997841933c17b093535c31d29355be3c0c39628@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

syzbot reported a crash that happened when changing the interface
type around a lot, and while it might have been easy to fix just
the symptom there, a little deeper investigation found that really
the reason is that we allowed packets to be transmitted while in
the middle of changing the interface type.

Disallow TX by stopping the queues while changing the type.

Fixes: 34d4bc4d41d2 ("mac80211: support runtime interface type changes")
Reported-by: syzbot+d7a3b15976bf7de2238a@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/iface.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bf9c0e974d6..8e281c2e644d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1078,6 +1078,7 @@ enum queue_stop_reason {
 	IEEE80211_QUEUE_STOP_REASON_FLUSH,
 	IEEE80211_QUEUE_STOP_REASON_TDLS_TEARDOWN,
 	IEEE80211_QUEUE_STOP_REASON_RESERVE_TID,
+	IEEE80211_QUEUE_STOP_REASON_IFTYPE_CHANGE,
 
 	IEEE80211_QUEUE_STOP_REASONS,
 };
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3b9ec4ef81c3..b31417f40bd5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1617,6 +1617,10 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 	if (ret)
 		return ret;
 
+	ieee80211_stop_vif_queues(local, sdata,
+				  IEEE80211_QUEUE_STOP_REASON_IFTYPE_CHANGE);
+	synchronize_net();
+
 	ieee80211_do_stop(sdata, false);
 
 	ieee80211_teardown_sdata(sdata);
@@ -1639,6 +1643,8 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_do_open(&sdata->wdev, false);
 	WARN(err, "type change: do_open returned %d", err);
 
+	ieee80211_wake_vif_queues(local, sdata,
+				  IEEE80211_QUEUE_STOP_REASON_IFTYPE_CHANGE);
 	return ret;
 }
 
-- 
2.26.2

