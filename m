Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D84AA0EC
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 21:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiBDUIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiBDUIF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 15:08:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4FBC061401
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=1+YAeqRRw6LUO/Ua4Hv2+yJMf6buZwDhlxBjYrGnoes=; t=1644005284; x=1645214884; 
        b=c17CcTvJjEiFclesOAPwQ2zh6pT0li2ECkY+W4MYJrP+p1fNRECxag7mNk+luEMsS9CA4tSEaAX
        7YmWuQORfkXqtmpzUKOt4IX2eoK5CSbcWQhC/NVGEVWZmlVinvw0MggxHAJ/Gko6OazYzTy7QdRDL
        eSPh9Mt8LafkyEW+4dUuYdeZUzT9NjwEiSoo1pk7kF4pbdXwbjOP0fVHHYABlD/oYp0C05gHuc5W4
        e8yWbC2dIo6nyPkecZAeMsrP54ccQR0euXqxC2CO/Hgnd0nYn6Lq+Hq+oURJp4Bi0yitGcw0BBVcP
        4pWW1Zgpq8GtrvEUY7kH9uU+nyQVi6VApSjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG4sE-00Ebg4-65;
        Fri, 04 Feb 2022 21:08:02 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] mac80211_hwsim: don't shadow a global variable
Date:   Fri,  4 Feb 2022 21:08:00 +0100
Message-Id: <20220204210759.27aad9ab95db.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The argument to hwsim_init_s1g_channels() shadows a global,
change that to be clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index f54f250f20c8..ac940767522e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -489,16 +489,16 @@ static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 		     0 },
 };
 
-static void hwsim_init_s1g_channels(struct ieee80211_channel *channels)
+static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
 {
 	int ch, freq;
 
 	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
 		freq = 902000 + (ch + 1) * 500;
-		channels[ch].band = NL80211_BAND_S1GHZ;
-		channels[ch].center_freq = KHZ_TO_MHZ(freq);
-		channels[ch].freq_offset = freq % 1000;
-		channels[ch].hw_value = ch + 1;
+		chans[ch].band = NL80211_BAND_S1GHZ;
+		chans[ch].center_freq = KHZ_TO_MHZ(freq);
+		chans[ch].freq_offset = freq % 1000;
+		chans[ch].hw_value = ch + 1;
 	}
 }
 
-- 
2.34.1

