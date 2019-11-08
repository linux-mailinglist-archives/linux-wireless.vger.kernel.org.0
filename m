Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC65F57D4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfKHTm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46176 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfKHTm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D156113C340;
        Fri,  8 Nov 2019 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D156113C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242145;
        bh=5bXVOyMXQoclge2QBACXqbmVR/VjShxbU/QoQJ/qqgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxTHki01V22vDIekHle8CbdEw2Y8LhgV+gpmszbc1Y5qXX04sfSrdsjw/V8hpJcGK
         oH659V+mJ77RXgcotAe9ivsnpXjl/Y9lwwmViB22gaIxiLqcoH2q/KvkVUxl/0FH3h
         otYuDZ15z1LbaksXkzPaO4o9VhYvvkbyNlGTaaM4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 04/10] mac80211: Don't spam so loud about warned-sdata-in-driver.
Date:   Fri,  8 Nov 2019 11:42:05 -0800
Message-Id: <20191108194210.23618-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Once per sdata is plenty, and possibly still too much.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.h  | 17 ++++++++++++++---
 net/mac80211/ieee80211_i.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d8967cd461fe..e734a85165ad 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -14,9 +14,20 @@
 
 static inline bool check_sdata_in_driver(struct ieee80211_sub_if_data *sdata)
 {
-	return !WARN(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER),
-		     "%s:  Failed check-sdata-in-driver check, flags: 0x%x\n",
-		     sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);
+	if (unlikely(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER))) {
+		if (!sdata->warned_sdata_in_driver) {
+			WARN(1, "%s:  Failed check-sdata-in-driver check, flags: 0x%x\n",
+			     sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);
+			sdata->warned_sdata_in_driver = true;
+		}
+		else {
+			/* just print error instead of full WARN spam */
+			sdata_err(sdata, "Failed check-sdata-in-driver check, flags: 0x%x\n",
+				  sdata->flags);
+		}
+		return false;
+	}
+	return true;
 }
 
 static inline bool _check_sdata_in_driver(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 05406e9c05b3..5594ab80d9c1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -932,6 +932,8 @@ struct ieee80211_sub_if_data {
 	bool reserved_radar_required;
 	bool reserved_ready;
 
+	bool warned_sdata_in_driver;
+
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
-- 
2.20.1

