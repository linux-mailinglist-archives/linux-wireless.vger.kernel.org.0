Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729462AD441
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJK7y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 05:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJK7x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 05:59:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A70C0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 02:59:53 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kcRNN-004slV-32; Tue, 10 Nov 2020 11:59:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] mac80211: free sta in sta_info_insert_finish() on errors
Date:   Tue, 10 Nov 2020 11:59:43 +0100
Message-Id: <20201110115943.a44a8e309b18.I9c31d667a0ea2151441cc64ed6613d36c18a48e0@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If sta_info_insert_finish() fails, we currently keep the station
around and free it only in the caller, but there's only one such
caller and it always frees it immediately. Another consequence of
this split is that we need to keep __cleanup_single_sta() with
anything that can sleep, and sta_info_free() with the real memory
release.

Change this to free the station in sta_info_insert_finish(), in
which case we can still sleep. This will also let us unify the
cleanup code later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 377ec1aea9c6..f7070674d1c8 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -705,7 +705,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
  out_drop_sta:
 	local->num_sta--;
 	synchronize_net();
-	__cleanup_single_sta(sta);
+	cleanup_single_sta(sta);
  out_err:
 	mutex_unlock(&local->sta_mtx);
 	kfree(sinfo);
@@ -726,17 +726,11 @@ int sta_info_insert_rcu(struct sta_info *sta) __acquires(RCU)
 	if (err) {
 		mutex_unlock(&local->sta_mtx);
 		rcu_read_lock();
-		goto out_free;
+		sta_info_free(local, sta);
+		return err;
 	}
 
-	err = sta_info_insert_finish(sta);
-	if (err)
-		goto out_free;
-
-	return 0;
- out_free:
-	sta_info_free(local, sta);
-	return err;
+	return sta_info_insert_finish(sta);
 }
 
 int sta_info_insert(struct sta_info *sta)
-- 
2.26.2

