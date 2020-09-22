Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7109274A7D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVU62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 16:58:28 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:48330 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVU62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 16:58:28 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F1BA613C2B0;
        Tue, 22 Sep 2020 13:58:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F1BA613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600808308;
        bh=sw7u6ASysvVDrXa8h7RnE8YmSTWBbCk/hRkhjZBul8w=;
        h=From:To:Cc:Subject:Date:From;
        b=QMb07Ai7P//QIfPbstOJeZlPjQ/d5McpWiDoGypIW/PgAeXIxXKmuYMTzA8KvELNu
         7Pmll24V5qBKSSz5aficZ0Y7PjqI6bzw9Co6XUCMh4b2DLAFiZhynrF3qCY2ERSL4i
         RqjKF8d65MUk/q6IIo/gXnMhSJgRYVXakMY7VCAo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211: Remove vdevs from driver when firmware is unrecoverable.
Date:   Tue, 22 Sep 2020 13:58:25 -0700
Message-Id: <20200922205825.25411-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

While testing ax200 (backport version hacked into a 5.4 kernel),
I noticed a KASAN use-after-free.  I think this is because the
old logic would clear the SDATA_IN_DRIVER flag without actually
removing it from the driver.  Then a bit later, the driver would
try to access some sdata memory.

So instead, tell the driver to remove the vdevs.  The kernel still
splats a lot of warnings in this case, but I did not see a KASAN
error and the system recovered and continued running on the remaining
radio (the one w/out fatal firmware error).

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/util.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ecd56f80b0c82..320e3df9ac31c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2070,7 +2070,7 @@ static void ieee80211_flush_completed_scan(struct ieee80211_local *local,
 
 static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 {
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_sub_if_data *sdata, *sdata_tmp;
 	struct ieee80211_chanctx *ctx;
 
 	/*
@@ -2094,8 +2094,9 @@ static void ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
 	 */
 	ieee80211_sched_scan_end(local);
 
-	list_for_each_entry(sdata, &local->interfaces, list)
-		sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
+	list_for_each_entry_safe(sdata, sdata_tmp, &local->interfaces, list)
+		if (check_sdata_in_driver(sdata))
+			drv_remove_interface(local, sdata);
 
 	/* Mark channel contexts as not being in the driver any more to avoid
 	 * removing them from the driver during the shutdown process...
@@ -2306,12 +2307,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	 * report failure.
 	 */
 	if (res) {
-		list_for_each_entry_continue_reverse(sdata, &local->interfaces,
-						     list)
-			if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
-			    sdata->vif.type != NL80211_IFTYPE_MONITOR &&
-			    ieee80211_sdata_running(sdata))
-				drv_remove_interface(local, sdata);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
-- 
2.26.2

