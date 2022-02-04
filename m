Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090C4AA0F3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiBDUMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 15:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBDUMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 15:12:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E107C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 12:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ECMPJfC/QpLsErlBwhJHmiMgpUfNKm0uVQKAWZkgfXA=; t=1644005534; x=1645215134; 
        b=vCKtooGwrHfoMy0484ERUFHm2WAkA3+0zVZLTCpFzHMu15Hi7AMViDWtXwtfnvrWVvXHiY/p1DV
        j1dOyJBSOvJ0hO/bcqJ+OSxW3CNV1ILyo0SZcLUtgLVlWgwI9xU62ge3U6Ia0PhT+ig/KQR2jUDRo
        juLPn5qtRrmOVMQ2hKKuKM3BNgrOO6ODTAJD9o2M6+k2TnH5SLRuBtRGb/uaFofqRu1V2/l8PdzRw
        Mxc7d/HbbzwfJNc56rizaMnIVdyXOSSaxG3nbXm+qjMfhO9F/prHV7vl7WiRSO8itYtO1IJO8L+Je
        xa/iY3IhEXIGgm0px3HYa3BoDIKcROw+Uthg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG4wF-00Ebl7-BB;
        Fri, 04 Feb 2022 21:12:11 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH] mac80211_hwsim: Add custom regulatory for 6GHz
Date:   Fri,  4 Feb 2022 21:12:09 +0100
Message-Id: <20220204211208.3682e9d96d6a.I9507395b64496d96a2276ba8c1e1323e54407aa7@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

Add a custom regulatory domain for testing 6 GHz, including
320 MHz bandwidth. This can be used before the regulatory
databases are all updated etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index e8cb58828a86..ac940767522e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -173,9 +173,23 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_02 = {
 	}
 };
 
+static const struct ieee80211_regdomain hwsim_world_regdom_custom_03 = {
+	.n_reg_rules = 6,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 40, 0, 30, 0),
+		REG_RULE(5745 - 10, 5825 + 10, 40, 0, 30, 0),
+		REG_RULE(5855 - 10, 5925 + 10, 40, 0, 33, 0),
+		REG_RULE(5955 - 10, 7125 + 10, 320, 0, 33, 0),
+	}
+};
+
 static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_01,
 	&hwsim_world_regdom_custom_02,
+	&hwsim_world_regdom_custom_03,
 };
 
 struct hwsim_vif_priv {
-- 
2.34.1

