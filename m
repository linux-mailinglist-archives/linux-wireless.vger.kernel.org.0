Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272B9573358
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGMJqV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiGMJpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0ABF5D65
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=v30K36dvB1cMkilEXJvy3bfwmtm7u7//VTtwAkAlJIE=;
        t=1657705524; x=1658915124; b=pvAdG83UQKpQMYbzXj7KlVlatgl2SKMElP96lrUk8nEu3C/
        EuTV2GJr1l9pJrT+o815jBommZlyveJ2eWv/FZfYZrkI6w7OpgMbkvdlSbHcYRal5W1qkZ7DwmDTC
        hUhcST492ebHbzXjnWBV0gpxJYgPSHkcyeWQteCNi1Auv2gK2X4U3c8++PtWyDaRttGFZzOH6LWru
        LRg/ao/s6ysva6XjUDhYZ2bNiRL53Kl58VHPSt1jz0r+mAqOZBUB2J8RCN5hjEm2REUswV6z/WvcD
        wPlTBdIg8TK0qdefEFKLi6A+NgzhUqYb8SLe/jWaUwtCRFIejxOaQAP8l+21I/Zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvq-00EgvB-QY;
        Wed, 13 Jul 2022 11:45:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 51/76] wifi: cfg80211: add ieee80211_chanwidth_rate_flags()
Date:   Wed, 13 Jul 2022 11:44:37 +0200
Message-Id: <20220713114425.6b47d6067d5d.I02832f1c1d4aea1dca2c98bf61978b11ddd11467@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

To simplify things when we don't have a full chandef,
add ieee80211_chanwidth_rate_flags().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 09f2e2f031b6..ca26e3b7341a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -939,19 +939,18 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 				  enum nl80211_iftype iftype);
 
 /**
- * ieee80211_chandef_rate_flags - returns rate flags for a channel
+ * ieee80211_chanwidth_rate_flags - return rate flags for channel width
+ * @width: the channel width of the channel
  *
  * In some channel types, not all rates may be used - for example CCK
  * rates may not be used in 5/10 MHz channels.
  *
- * @chandef: channel definition for the channel
- *
- * Returns: rate flags which apply for this channel
+ * Returns: rate flags which apply for this channel width
  */
 static inline enum ieee80211_rate_flags
-ieee80211_chandef_rate_flags(struct cfg80211_chan_def *chandef)
+ieee80211_chanwidth_rate_flags(enum nl80211_chan_width width)
 {
-	switch (chandef->width) {
+	switch (width) {
 	case NL80211_CHAN_WIDTH_5:
 		return IEEE80211_RATE_SUPPORTS_5MHZ;
 	case NL80211_CHAN_WIDTH_10:
@@ -962,6 +961,20 @@ ieee80211_chandef_rate_flags(struct cfg80211_chan_def *chandef)
 	return 0;
 }
 
+/**
+ * ieee80211_chandef_rate_flags - returns rate flags for a channel
+ * @chandef: channel definition for the channel
+ *
+ * See ieee80211_chanwidth_rate_flags().
+ *
+ * Returns: rate flags which apply for this channel
+ */
+static inline enum ieee80211_rate_flags
+ieee80211_chandef_rate_flags(struct cfg80211_chan_def *chandef)
+{
+	return ieee80211_chanwidth_rate_flags(chandef->width);
+}
+
 /**
  * ieee80211_chandef_max_power - maximum transmission power for the chandef
  *
-- 
2.36.1

