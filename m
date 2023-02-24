Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F280D6A191A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBXJw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 04:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBXJw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 04:52:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205D63DD9
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=FSnH0EFJCmr3+sjJ98W2pAbsmccvBM7VOyHP6Awi2bk=; t=1677232346; x=1678441946; 
        b=cX/3v4YLRoEJe/wmpGngmOdWPtuJOjzHh/hJ1kVp7T+txgqM8OB+v4+w1jvue0ldjbmPKLD8C2D
        tc7VrihAeWKc7NS3KEJzFOlBRTXyQGEX1Fo9b0ip0DhQ7x3+it8d1TFXBKk7hMD2c8d4SwihJIFfj
        rPMhq3SlNlZUKYktd5sRgBl9cEN33CIto6PR53741rpGlE8vcPFZZ/v03W970TTCY+Ap7uhHu83pF
        bASKZWDe+QuLL7zCU4i0xMtFIBenMGzazZw44gFZuL5L5Vg7kL255Qs0je4jInnQShZtBSRuHq4+Q
        jdD4NuA2BdR7eBAckwLkVSTHAW8aZ4I1TjFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pVUkY-0048WQ-0K;
        Fri, 24 Feb 2023 10:52:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: check basic rates validity
Date:   Fri, 24 Feb 2023 10:52:19 +0100
Message-Id: <20230224105219.491db73b987d.If01a7725b22c06e1bd3ece401d04d0c003082c98@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When userspace sets basic rates, it might send us some rates
list that's empty or consists of invalid values only. We're
currently ignoring invalid values and then may end up with a
rates bitmap that's empty, which later results in a warning.

Reject the call if there were no valid rates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8eb342300868..d3d861911ed6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2611,6 +2611,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
+	if (params->basic_rates) {
+		if (!ieee80211_parse_bitrates(link->conf->chandef.width,
+					      wiphy->bands[sband->band],
+					      params->basic_rates,
+					      params->basic_rates_len,
+					      &link->conf->basic_rates))
+			return -EINVAL;
+		changed |= BSS_CHANGED_BASIC_RATES;
+		ieee80211_check_rate_mask(link);
+	}
+
 	if (params->use_cts_prot >= 0) {
 		link->conf->use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
@@ -2632,16 +2643,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->basic_rates) {
-		ieee80211_parse_bitrates(link->conf->chandef.width,
-					 wiphy->bands[sband->band],
-					 params->basic_rates,
-					 params->basic_rates_len,
-					 &link->conf->basic_rates);
-		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(link);
-	}
-
 	if (params->ap_isolate >= 0) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
-- 
2.39.2

