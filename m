Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3487F4B5639
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356368AbiBNQaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356366AbiBNQaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB760AA5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=232J5opRknVgL6kR4s6AMD0FxBtYxtdEUz74hq0vMbw=;
        t=1644856211; x=1646065811; b=JduOz9ATycosEZNGREHLoiwnsmFRE7c0hl9KE48rxwyqe8a
        tE+/ltg0mzLESB9OAOKB86CwJbz6QTlwuvKD2FttszCGrfdNgR4ijw4DaL68/n1DpgN10VJ5VT9+i
        RsnyvCTtHzY2gB/Vn3/aHgq1TrKtBvI7JrZCpwN74qn6OCSkf9DdzD0muoSD3XRNYcvH4xML3Ug59
        k8EChaHKNs5tXHEKESAC2D+jjc8KMTYV0YlhbngBe4QNitwxll7WJTQXk/me6jPdGVC77g4X0i8Q5
        34GJI8OWT21imVC17p29BXFybbcLSQO1McCK0n/iRyfI053YvDvRAHEhYcMcsFhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEq-0011mw-RS;
        Mon, 14 Feb 2022 17:30:08 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 02/19] mac80211_hwsim: don't shadow a global variable
Date:   Mon, 14 Feb 2022 17:29:49 +0100
Message-Id: <20220214173004.66bac90d64a8.I3e878e42bf2feecbb0a6ca38a68c236c23a8c9e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
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

The argument to hwsim_init_s1g_channels() shadows a global,
change that to be clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 2cf328344cb5..92e055ee0bb9 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -475,16 +475,16 @@ static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
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

