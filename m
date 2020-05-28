Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899511E5C46
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgE1Jo3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbgE1Jo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:44:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036CC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 02:44:28 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeF5O-004mD7-KZ; Thu, 28 May 2020 11:44:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC 01/10] cfg80211: add a helper to identify 6 GHz PSCs
Date:   Thu, 28 May 2020 11:44:07 +0200
Message-Id: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This allows identifying whether or not a channel is a PSC
(preferred scanning channel).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e2dbc9c02ef3..a38653358885 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5277,6 +5277,21 @@ ieee80211_get_channel(struct wiphy *wiphy, int freq)
 	return ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(freq));
 }
 
+/**
+ * cfg80211_channel_is_psc - Check if the channel is a 6 GHz PSC
+ * @chan: control channel to check
+ *
+ * The Preferred Scanning Channels (PSC) are defined in
+ * Draft IEEE P802.11ax/D5.0, 26.17.2.3.3
+ */
+static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
+{
+	if (chan->band != NL80211_BAND_6GHZ)
+		return false;
+
+	return ieee80211_frequency_to_channel(chan->center_freq) % 16 == 5;
+}
+
 /**
  * ieee80211_get_response_rate - get basic rate for a given rate
  *
-- 
2.26.2

