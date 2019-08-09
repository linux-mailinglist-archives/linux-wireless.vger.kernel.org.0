Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05417881E0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437253AbfHISAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 14:00:04 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45898 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436846AbfHISAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 14:00:04 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A9BD4137561;
        Fri,  9 Aug 2019 11:00:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A9BD4137561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1565373603;
        bh=LTLi5+G5wPLoY08uyBagMZ62OuzViQDdgmDrnwnbGpc=;
        h=From:To:Cc:Subject:Date:From;
        b=suZfcyhMUmVraFlcJo39gOeLx8xasgX63lRoHDlwj9lv/iTYtSJswIWyODlVgFPUj
         OWEf/pDTjBBuMeNVQXbWAfuf3OrkpHh7DaenGtikP92JHDlXIE64QOh+1xl6/pXxD3
         yXu53TU0B4ABiHBxc/uj5JY4PJOFzQxj67OT1yb4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 1/2] wireless: Support assoc-at timer in sta-info
Date:   Fri,  9 Aug 2019 11:00:00 -0700
Message-Id: <20190809180001.26393-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Report time stamp of when sta became associated.

This is the boottime clock, units are nano-seconds.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  I had forgotten to refresh the 2/2 patch.

 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ef510c916635..19c200b917eb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1306,6 +1306,7 @@ struct cfg80211_tid_stats {
  *	indicate the relevant values in this struct for them
  * @connected_time: time(in secs) since a station is last connected
  * @inactive_time: time since last station activity (tx/rx) in milliseconds
+ * @assoc_at: bootime (ns) of the last association
  * @rx_bytes: bytes (size of MPDUs) received from this station
  * @tx_bytes: bytes (size of MPDUs) transmitted to this station
  * @llid: mesh local link id
@@ -1366,6 +1367,7 @@ struct station_info {
 	u64 filled;
 	u32 connected_time;
 	u32 inactive_time;
+	u64 assoc_at;
 	u64 rx_bytes;
 	u64 tx_bytes;
 	u16 llid;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 76d5811193be..3796e1e06665 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3175,6 +3175,7 @@ enum nl80211_sta_bss_param {
  *	sent to the station (u64, usec)
  * @NL80211_STA_INFO_AIRTIME_WEIGHT: current airtime weight for station (u16)
  * @NL80211_STA_INFO_AIRTIME_LINK_METRIC: airtime link metric for mesh station
+ * @NL80211_STA_INFO_ASSOC_AT_BOOTTIME: Timestamp of last association
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3221,6 +3222,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_TX_DURATION,
 	NL80211_STA_INFO_AIRTIME_WEIGHT,
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
+	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 789cd98f02f5..b61a59b9d78b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5028,6 +5028,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	PUT_SINFO(CONNECTED_TIME, connected_time, u32);
 	PUT_SINFO(INACTIVE_TIME, inactive_time, u32);
+	PUT_SINFO_U64(ASSOC_AT_BOOTTIME, assoc_at);
 
 	if (sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
 			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
-- 
2.20.1

