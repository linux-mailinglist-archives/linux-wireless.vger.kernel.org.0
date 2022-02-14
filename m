Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E674B563A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356378AbiBNQaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356373AbiBNQaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872B60ABF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pTzUO/iLdArxO7QBxL5WrsG8xZLnhgzyR32bcWH1LzM=;
        t=1644856211; x=1646065811; b=ghVeTXvA8xHpAqo8Hgb2h0qd/tzv0ouVHoyBL5FD7Bah7Vw
        Jy1XYqcMhBRpNlC3pFLR4MFGwk0s3SYzebofvFRUOU1ez3bx3N6SNdgxVknKx1yIMN7woYKLPoHov
        twzKmbK+bovLxSbwdT4ij3TxgH11JlkYIbdTUumICA1+Njb6e2llIVCGvWgyB4ksjjccIG4qDm9+V
        d/Hd0K0wRuCzlYrDuaxEwBW3cap3AA4IEI+Byz3BSnEl4N1ofwD9GLA6vmZJe3VIdb0VbN0RDsF6+
        XtCZnTtHUMWPPwXlU4518g9ZTYyyruETuxbMvDi6Mriq95kc7cdIJ4q6SCc4SCSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEr-0011mw-3j;
        Mon, 14 Feb 2022 17:30:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 03/19] mac80211_hwsim: Add custom regulatory for 6GHz
Date:   Mon, 14 Feb 2022 17:29:50 +0100
Message-Id: <20220214173004.e3d6faf1f35f.I9507395b64496d96a2276ba8c1e1323e54407aa7@changeid>
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
index 92e055ee0bb9..defb7e36c1f2 100644
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

