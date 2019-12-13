Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7011E72B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLMP6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:58:15 -0500
Received: from nbd.name ([46.4.11.11]:56200 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfLMP6O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:58:14 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifnKT-00073u-7l; Fri, 13 Dec 2019 16:58:09 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/7] mac80211: add a struct for holding BSS color settings
Date:   Fri, 13 Dec 2019 16:57:56 +0100
Message-Id: <20191213155802.25491-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now we only track the actual color but not the other bits contained
within the he_oper field. Fix this by creating a new struct to hold all
of the info.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h | 15 +++++++++++++++
 include/net/mac80211.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8140c4837122..e395ef48af83 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -259,6 +259,19 @@ struct ieee80211_he_obss_pd {
 	u8 max_offset;
 };
 
+/**
+ * struct ieee80211_he_bss_color - AP settings for BSS coloring
+ *
+ * @color: the current color.
+ * @disabled: is the feature disabled.
+ * @partial: define the AID equation.
+ */
+struct ieee80211_he_bss_color {
+	u8 color;
+	bool disabled;
+	bool partial;
+};
+
 /**
  * struct ieee80211_sta_ht_cap - STA's HT capabilities
  *
@@ -910,6 +923,7 @@ enum cfg80211_ap_settings_flags {
  * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
+ * @he_bss_color: BSS Color settings
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -938,6 +952,7 @@ struct cfg80211_ap_settings {
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
+	struct ieee80211_he_bss_color he_bss_color;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6781d4637557..16a5525ddab1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -604,6 +604,7 @@ struct ieee80211_ftm_responder_params {
  *	in order to discover all the nontransmitted BSSIDs in the set.
  * @he_operation: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
+ * @he_bss_color: BSS coloring settings, if BSS supports HE
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -667,6 +668,7 @@ struct ieee80211_bss_conf {
 	u8 profile_periodicity;
 	struct ieee80211_he_operation he_operation;
 	struct ieee80211_he_obss_pd he_obss_pd;
+	struct ieee80211_he_bss_color he_bss_color;
 };
 
 /**
-- 
2.20.1

