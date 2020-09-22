Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA4274909
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIVTZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 15:25:13 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:44952 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVTZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 15:25:13 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 79C9C13C2B0;
        Tue, 22 Sep 2020 12:20:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 79C9C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600802400;
        bh=/hsZNWlMO8q90+AR3z0NSM2bW5UCcwsFE4SclNmOotk=;
        h=From:To:Cc:Subject:Date:From;
        b=O0ZX+rnrhSQhPhAaqQadI6/YcIYSC8plVgVYkT7uTPF8pLKg+qLBeRriFE0gv2+g9
         DelK4zJw4qHI2nrjNOtERUDIM29YZs1WdJTrcYfVlc6fQrnrZ4M4YQST5vWY+g6xND
         4PhYXVhiMJFo4/k2mt2JJ8ftTP26nUXyfYAa/goM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] mac80211:  Support not iterating over not-sdata-in-driver ifaces
Date:   Tue, 22 Sep 2020 12:19:56 -0700
Message-Id: <20200922191957.25257-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow drivers to request that interface-iterator does NOT iterate
over interfaces that are not sdata-in-driver.  This will allow
us to fix crashes in ath10k (and possibly other drivers).

To summarize Johannes' explanation:

Consider

add interface wlan0
add interface wlan1
iterate active interfaces -> wlan0 wlan1
add interface wlan2
iterate active interfaces -> wlan0 wlan1 wlan2

If you apply this scenario to a restart, which ought to be functionally
equivalent to the normal startup, just compressed in time, you're
basically saying that today you get

add interface wlan0
add interface wlan1
iterate active interfaces -> wlan0 wlan1 wlan2 << problem here
add interface wlan2
iterate active interfaces -> wlan0 wlan1 wlan2

which yeah, totally seems wrong.

But fixing that to be

add interface wlan0
add interface wlan1
iterate active interfaces ->
<nothing>
add interface wlan2
iterate active interfaces -> <nothing>
(or
maybe -> wlan0 wlan1 wlan2 if the reconfig already completed)

This is also at least somewhat wrong, but better to not iterate
over something that exists in the driver than iterate over something
that does not.  Originally the first issue was causing crashes in
testing with lots of station vdevs on an ath10k radio, combined
with firmware crashing.

I ran with a similar patch for years with no obvious bad results,
including significant testing with ath9k and ath10k.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/util.c    | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 66e2bfd165e82..9c4bffcaed404 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5344,11 +5344,15 @@ void ieee80211_sched_scan_stopped(struct ieee80211_hw *hw);
  * @IEEE80211_IFACE_ITER_RESUME_ALL: During resume, iterate over all
  *	interfaces, even if they haven't been re-added to the driver yet.
  * @IEEE80211_IFACE_ITER_ACTIVE: Iterate only active interfaces (netdev is up).
+ * @IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER: Skip any interfaces where SDATA
+ *	is not in the driver.  This may fix crashes during firmware recovery
+ *	for instance.
  */
 enum ieee80211_interface_iteration_flags {
 	IEEE80211_IFACE_ITER_NORMAL	= 0,
 	IEEE80211_IFACE_ITER_RESUME_ALL	= BIT(0),
 	IEEE80211_IFACE_ITER_ACTIVE	= BIT(1),
+	IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER	= BIT(2),
 };
 
 /**
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c8504ffc71a11..f3bc05217f741 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -733,6 +733,9 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 		if (!(iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL) &&
 		    active_only && !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 			continue;
+		if ((iter_flags & IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER) &&
+		    !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+			continue;
 		if (ieee80211_sdata_running(sdata) || !active_only)
 			iterator(data, sdata->vif.addr,
 				 &sdata->vif);
-- 
2.26.2

