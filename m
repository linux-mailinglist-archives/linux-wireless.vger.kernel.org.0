Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E46881E1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437263AbfHISAF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 14:00:05 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45906 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436792AbfHISAF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 14:00:05 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id BAE95137564;
        Fri,  9 Aug 2019 11:00:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BAE95137564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1565373604;
        bh=DaEIqHx2Riv3RxGCcSDf9oJHB7GJ/nZm+bdsHRJ+Qac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YorKXmVLMX1SLo5BNOPYjvOvWAqSEhYlWHNLfJAZp8rnhj00B7bGHudoEXa24o3sJ
         hX1sEVPEqD8cuq82k59L7Pc7DgVmr1pT6bL/bh13SOopafCox/RVd9IIYSOWXmP0xE
         rzD2omy7HZ99muPz7KHZZt35GofK9FbaGSXUN3yo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 2/2] mac80211: add assoc-at support.
Date:   Fri,  9 Aug 2019 11:00:01 -0700
Message-Id: <20190809180001.26393-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809180001.26393-1-greearb@candelatech.com>
References: <20190809180001.26393-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Report timestamp for when sta becomes associated.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/sta_info.c | 3 +++
 net/mac80211/sta_info.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cd88c8872372..e8407ed2b87b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1995,6 +1995,7 @@ int sta_info_move_state(struct sta_info *sta,
 	case IEEE80211_STA_ASSOC:
 		if (sta->sta_state == IEEE80211_STA_AUTH) {
 			set_bit(WLAN_STA_ASSOC, &sta->_flags);
+			sta->assoc_at = ktime_get_boot_ns();
 			ieee80211_recalc_min_chandef(sta->sdata);
 			if (!sta->sta.support_p2p_ps)
 				ieee80211_recalc_p2p_go_ps_allowed(sta->sdata);
@@ -2224,6 +2225,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			 BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
+			 BIT_ULL(NL80211_STA_INFO_ASSOC_AT_BOOTTIME) |
 			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
@@ -2232,6 +2234,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	sinfo->connected_time = ktime_get_seconds() - sta->last_connected;
+	sinfo->assoc_at = sta->assoc_at;
 	sinfo->inactive_time =
 		jiffies_to_msecs(jiffies - ieee80211_sta_last_active(sta));
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index bb02d5fac7ba..6ebb943c78c2 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -468,6 +468,7 @@ struct ieee80211_sta_rx_stats {
  *	the station when it leaves powersave or polls for frames
  * @driver_buffered_tids: bitmap of TIDs the driver has data buffered on
  * @txq_buffered_tids: bitmap of TIDs that mac80211 has txq data buffered on
+ * @assoc_at: clock boottime (in ns) of last association
  * @last_connected: time (in seconds) when a station got connected
  * @last_seq_ctrl: last received seq/frag number from this STA (per TID
  *	plus one for non-QoS frames)
@@ -565,6 +566,7 @@ struct sta_info {
 	unsigned long driver_buffered_tids;
 	unsigned long txq_buffered_tids;
 
+	unsigned long assoc_at;
 	long last_connected;
 
 	/* Updated from RX path only, no locking requirements */
-- 
2.20.1

