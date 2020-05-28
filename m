Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317F81E6481
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgE1Oud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgE1Ou3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:50:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBBC05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:50:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrV-004vYI-R9; Thu, 28 May 2020 16:50:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/24] cfg80211: add a helper to identify 6 GHz PSCs
Date:   Thu, 28 May 2020 16:49:58 +0200
Message-Id: <20200528165011.414363ecf62c.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
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

