Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B375281A2D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgJBRxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 13:53:13 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:53216 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387957AbgJBRxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 13:53:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9409E4FA00B;
        Fri,  2 Oct 2020 17:53:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 20KOeAS8aTsS; Fri,  2 Oct 2020 17:53:09 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7B67A4FA0DD;
        Fri,  2 Oct 2020 17:53:09 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 2/2] mac80211: initialize last_rate for S1G STAs
Date:   Fri,  2 Oct 2020 10:53:08 -0700
Message-Id: <20201002175308.16374-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002175308.16374-1-thomas@adapt-ip.com>
References: <20201002175308.16374-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

last_rate is initialized to zero by sta_info_alloc(), but
this indicates legacy bitrate for the last TX rate (and
invalid for the last RX rate). To avoid a warning when
decoding the last rate as legacy (before a data frame
has been sent), initialize them as S1G MCS.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/Makefile      |  1 +
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        |  4 +++-
 net/mac80211/rate.c        |  1 +
 net/mac80211/s1g.c         | 17 +++++++++++++++++
 net/mac80211/sta_info.h    |  1 +
 6 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 net/mac80211/s1g.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index 6cbb1286d6c0..ad04c361cba5 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -13,6 +13,7 @@ mac80211-y := \
 	ht.o agg-tx.o agg-rx.o \
 	vht.o \
 	he.o \
+	s1g.o \
 	ibss.o \
 	iface.o \
 	rate.o \
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c3e3578574a6..d9d7a34480b0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1928,6 +1928,9 @@ void
 ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
 			const struct ieee80211_he_operation *he_op_ie_elem);
 
+/* S1G */
+void ieee80211_s1g_sta_init(struct sta_info *sta);
+
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_mgmt *mgmt,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e9a8e8e94ee6..fe6cfb8d477f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5190,8 +5190,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		int shift = ieee80211_vif_get_shift(&sdata->vif);
 
 		/* TODO: S1G Basic Rate Set is expressed elsewhere */
-		if (cbss->channel->band == NL80211_BAND_S1GHZ)
+		if (cbss->channel->band == NL80211_BAND_S1GHZ) {
+			ieee80211_s1g_sta_init(new_sta);
 			goto skip_rates;
+		}
 
 		ieee80211_get_rates(sband, bss->supp_rates,
 				    bss->supp_rates_len,
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0cba7fed28cf..723762a4052b 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -53,6 +53,7 @@ void rate_control_rate_init(struct sta_info *sta)
 
 	/* TODO: check for minstrel_s1g ? */
 	if (sband->band == NL80211_BAND_S1GHZ) {
+		ieee80211_s1g_sta_init(sta);
 		rcu_read_unlock();
 		return;
 	}
diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
new file mode 100644
index 000000000000..dbc216ad0a6e
--- /dev/null
+++ b/net/mac80211/s1g.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* S1G handling
+ * Copyright(c) 2020 Adapt-IP
+ */
+
+#include <linux/ieee80211.h>
+#include <net/mac80211.h>
+
+#include "ieee80211_i.h"
+
+void ieee80211_s1g_sta_init(struct sta_info *sta)
+{
+	/* avoid indicating legacy bitrates for S1G STAs */
+	sta->tx_stats.last_rate.flags |= IEEE80211_TX_RC_S1G_MCS;
+	sta->rx_stats.last_rate =
+			STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 91a61b44b4e0..00ae81e9e1a1 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -823,6 +823,7 @@ enum sta_stats_type {
 	STA_STATS_RATE_TYPE_HT,
 	STA_STATS_RATE_TYPE_VHT,
 	STA_STATS_RATE_TYPE_HE,
+	STA_STATS_RATE_TYPE_S1G,
 };
 
 #define STA_STATS_FIELD_HT_MCS		GENMASK( 7,  0)
-- 
2.20.1

