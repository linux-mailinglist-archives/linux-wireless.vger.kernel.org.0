Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC321EDDAA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFDHKD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgFDHKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6302BC08C5C2
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0l-0001P3-Ox; Thu, 04 Jun 2020 09:09:59 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 06/12] mac80211: propagate multi bssid settings when starting an AP
Date:   Thu,  4 Jun 2020 09:09:46 +0200
Message-Id: <20200604070952.15481-7-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch extends the bss_config allowing us to propagate the multiple
bssid setting down the stack into the driver.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1a98b3907aa7..3812adcef7d7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -606,6 +606,7 @@ struct ieee80211_ftm_responder_params {
  * @he_operation: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
+ * @multi_bssid: the multi bssid settings of the AP.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -669,6 +670,7 @@ struct ieee80211_bss_conf {
 	struct ieee80211_he_operation he_operation;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct ieee80211_multi_bssid multi_bssid;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e4f73567d873..f6f7323c66ab 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1130,6 +1130,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	       sizeof(struct ieee80211_he_obss_pd));
 	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
 	       sizeof(struct ieee80211_he_bss_color));
+	memcpy(&sdata->vif.bss_conf.multi_bssid, &params->multi_bssid,
+	       sizeof(struct ieee80211_multi_bssid));
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
-- 
2.20.1

