Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05A1F6990
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFKOCy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 10:02:54 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:46185 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgFKOCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 10:02:54 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6D801580065;
        Thu, 11 Jun 2020 16:02:51 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] nl80211: add connected to auth server to station info
Date:   Thu, 11 Jun 2020 16:02:38 +0200
Message-Id: <20200611140238.427461-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611140238.427461-1-markus.theil@tu-ilmenau.de>
References: <20200611140238.427461-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds the necessary bits to later query the auth server
flag for every peer from iw.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 3 +++
 net/mac80211/sta_info.c      | 4 +++-
 net/mac80211/sta_info.h      | 2 ++
 net/wireless/nl80211.c       | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6c9148ebdb83..34e04f186795 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1581,6 +1581,7 @@ struct cfg80211_tid_stats {
  *	an FCS error. This counter should be incremented only when TA of the
  *	received packet with an FCS error matches the peer MAC address.
  * @airtime_link_metric: mesh airtime link metric.
+ * @connected_to_as: true if mesh STA has a path to authentication server
  */
 struct station_info {
 	u64 filled;
@@ -1638,6 +1639,8 @@ struct station_info {
 	u32 fcs_err_count;
 
 	u32 airtime_link_metric;
+
+	u8 connected_to_as;
 };
 
 #if IS_ENABLED(CONFIG_CFG80211)
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 92238c63cad3..7aa1d94d7987 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3375,6 +3375,8 @@ enum nl80211_sta_bss_param {
  * @NL80211_STA_INFO_AIRTIME_LINK_METRIC: airtime link metric for mesh station
  * @NL80211_STA_INFO_ASSOC_AT_BOOTTIME: Timestamp (CLOCK_BOOTTIME, nanoseconds)
  *	of STA's association
+ * @NL80211_STA_INFO_CONNECTED_TO_AS: set to true if STA has a path to a
+ *	authentication server (u8, 0 or 1)
  * @__NL80211_STA_INFO_AFTER_LAST: internal
  * @NL80211_STA_INFO_MAX: highest possible station info attribute
  */
@@ -3422,6 +3424,7 @@ enum nl80211_sta_info {
 	NL80211_STA_INFO_AIRTIME_WEIGHT,
 	NL80211_STA_INFO_AIRTIME_LINK_METRIC,
 	NL80211_STA_INFO_ASSOC_AT_BOOTTIME,
+	NL80211_STA_INFO_CONNECTED_TO_AS,
 
 	/* keep last */
 	__NL80211_STA_INFO_AFTER_LAST,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cd8487bc6fc2..a39773b40457 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2426,7 +2426,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 				 BIT_ULL(NL80211_STA_INFO_LOCAL_PM) |
 				 BIT_ULL(NL80211_STA_INFO_PEER_PM) |
 				 BIT_ULL(NL80211_STA_INFO_NONPEER_PM) |
-				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE);
+				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_GATE) |
+				 BIT_ULL(NL80211_STA_INFO_CONNECTED_TO_AS);
 
 		sinfo->llid = sta->mesh->llid;
 		sinfo->plid = sta->mesh->plid;
@@ -2439,6 +2440,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->peer_pm = sta->mesh->peer_pm;
 		sinfo->nonpeer_pm = sta->mesh->nonpeer_pm;
 		sinfo->connected_to_gate = sta->mesh->connected_to_gate;
+		sinfo->connected_to_as = sta->mesh->connected_to_as;
 #endif
 	}
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 49728047dfad..9d398c9daa4c 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -385,6 +385,7 @@ DECLARE_EWMA(mesh_tx_rate_avg, 8, 16)
  * @processed_beacon: set to true after peer rates and capabilities are
  *	processed
  * @connected_to_gate: true if mesh STA has a path to a mesh gate
+ * @connected_to_as: true if mesh STA has a path to a authentication server
  * @fail_avg: moving percentage of failed MSDUs
  * @tx_rate_avg: moving average of tx bitrate
  */
@@ -404,6 +405,7 @@ struct mesh_sta {
 
 	bool processed_beacon;
 	bool connected_to_gate;
+	bool connected_to_as;
 
 	enum nl80211_plink_state plink_state;
 	u32 plink_timeout;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c154bf09a8af..242255a217d2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5394,6 +5394,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	PUT_SINFO(PEER_PM, peer_pm, u32);
 	PUT_SINFO(NONPEER_PM, nonpeer_pm, u32);
 	PUT_SINFO(CONNECTED_TO_GATE, connected_to_gate, u8);
+	PUT_SINFO(CONNECTED_TO_AS, connected_to_as, u8);
 
 	if (sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
 		bss_param = nla_nest_start_noflag(msg,
-- 
2.27.0

