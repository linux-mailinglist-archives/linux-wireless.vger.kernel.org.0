Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F32535D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2019 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfEUPDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 May 2019 11:03:10 -0400
Received: from nbd.name ([46.4.11.11]:38154 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfEUPDK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 May 2019 11:03:10 -0400
Received: from p548c8ce3.dip0.t-ipconnect.de ([84.140.140.227] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hT6IF-00007m-7R; Tue, 21 May 2019 17:03:07 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH 1/2] mac80211: add ieee80211_get_he_iftype_cap() helper
Date:   Tue, 21 May 2019 17:02:58 +0200
Message-Id: <20190521150259.2414-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This function is similar to ieee80211_get_he_sta_cap() but allows passing
the iftype. Also make ieee80211_get_he_sta_cap() use the new helper
rather than duplicating the code.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3f67f01b5f7a..379202ff3d14 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -395,16 +395,18 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 }
 
 /**
- * ieee80211_get_he_sta_cap - return HE capabilities for an sband's STA
- * @sband: the sband to search for the STA on
+ * ieee80211_get_he_iftype_cap - return HE capabilities for an sband's iftype
+ * @sband: the sband to search for the iftype on
+ * @iftype: enum nl80211_iftype
  *
  * Return: pointer to the struct ieee80211_sta_he_cap, or NULL is none found
  */
 static inline const struct ieee80211_sta_he_cap *
-ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
+ieee80211_get_he_iftype_cap(const struct ieee80211_supported_band *sband,
+			    u8 iftype)
 {
 	const struct ieee80211_sband_iftype_data *data =
-		ieee80211_get_sband_iftype_data(sband, NL80211_IFTYPE_STATION);
+		ieee80211_get_sband_iftype_data(sband, iftype);
 
 	if (data && data->he_cap.has_he)
 		return &data->he_cap;
@@ -412,6 +414,18 @@ ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
 	return NULL;
 }
 
+/**
+ * ieee80211_get_he_sta_cap - return HE capabilities for an sband's STA
+ * @sband: the sband to search for the STA on
+ *
+ * Return: pointer to the struct ieee80211_sta_he_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_he_cap *
+ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
+{
+	return ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_STATION);
+}
+
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
-- 
2.20.1

