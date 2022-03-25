Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66F64E6CF0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 04:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356250AbiCYD7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355395AbiCYD7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 23:59:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B26C55AF
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 20:58:00 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B49EB3F1B3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648180678;
        bh=HfhFiSazR5AEpCcSLsKBFtyKGjNGuMH/2Hmmg2fcF54=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=K6eNxOXWTVIg1lw+cpr92g//f2Q779mTD5JEEsvwY9SUVR8JHb05bpnCmE+ILJrnI
         sPMuMKorrqqliTp0zwNtHOFFYJ67ZZzKYCAXXcwk0Na3o6XhPykht34HCzDG5YWtC8
         2GjE29fTSveDao3/kNt3UfzLLwt9WduNCnXy6DQw26jpb5fmJVbbVvF/OI1OPodRlD
         udCEyqJf72/ZcL0JewGk7Ppy0gqHg/oGbmE6lbrYRQEpJjP42/2PW59l2E0c8KuLFN
         lA1sf9GFLSbzEYLPUX/YdtDgH8AuT9E9aTQhG3oGMujt2lqhZV5kizecxqElCJejwO
         C752XSwPyN45w==
Received: by mail-pf1-f197.google.com with SMTP id c78-20020a624e51000000b004fadac38f65so3492647pfb.16
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 20:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfhFiSazR5AEpCcSLsKBFtyKGjNGuMH/2Hmmg2fcF54=;
        b=NRazomdDP5suA5oOQUrtqf6KxTDcUeQPfT/mXRughNQyGwUsEJnFFzktBoaTXahLXf
         lPCR5u5b1ZNPay417yS2Yo9fGlQHTysAftA30JK+HGD40NVL4MVPUiDSFs3Rfi6HPDdK
         IlN3iL0l3Sc9+J0nqfhOYVX74guRMZN9HNZsAm4PbtgY6QH7BX//u0VneYHKCmu5hL6T
         I+ZphG7KZ2oqiV49iLpifMITxzAPM3vPQ/D78r33XBrOwEFSEDOl81YInyekDGFLMgA0
         e2nbXpWMclW5yTOhCPM6wMHD8owzd8SDPaEJEy4XN/+MaCAufQYSndSXihj7jSsYOKQy
         nTwA==
X-Gm-Message-State: AOAM533LmkYXrbLU5GGFv3yPw4dDA6/2FI3XkMe6fjGTco6IQ33d/BSU
        WFMO86JFhdeKNN0qZURtB5DkRPr1IEdya72mKg0wiHAKWWB0g0jr3RIgn7wAt0NO4y1rH7X2S4T
        ESAtMvkgdVUx/OoOFvB+HeKStnOWTP3vYtPelsXwN88U4
X-Received: by 2002:a63:1e4b:0:b0:381:c48:928b with SMTP id p11-20020a631e4b000000b003810c48928bmr6225532pgm.139.1648180677212;
        Thu, 24 Mar 2022 20:57:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFFS803gF+q2mgNAsgGNpiwAvXpqSXWcGhWvjVXchMZL//AWHsQKx3HdQP/D0kn2Ktzy9xXg==
X-Received: by 2002:a63:1e4b:0:b0:381:c48:928b with SMTP id p11-20020a631e4b000000b003810c48928bmr6225515pgm.139.1648180676853;
        Thu, 24 Mar 2022 20:57:56 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e286-bae1-8fdb-11c6-cf63-1f23.emome-ip6.hinet.net. [2001:b400:e286:bae1:8fdb:11c6:cf63:1f23])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm3825801pgb.11.2022.03.24.20.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:57:56 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v3 2/2] rtl8xxxu: fill up txrate info for gen1 chips
Date:   Fri, 25 Mar 2022 11:57:35 +0800
Message-Id: <20220325035735.4745-3-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325035735.4745-1-chris.chiu@canonical.com>
References: <20220325035735.4745-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RTL8188CUS/RTL8192CU(gen1) don't support rate adatptive report hence
no real txrate info can be retrieved. The vendor driver reports the
highest rate in HT capabilities from the IEs to avoid empty txrate.
This commit initiates the txrate information with the highest supported
rate negotiated with AP. The gen2 chip keeps update the txrate from
the rate adaptive reports, and gen1 chips at least have non-NULL txrate
after associated.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

Changelog:
  v3:
   - Move the rtl8xxxu_legacy_ratetable[] and rtl8xxxu_desc_to_mcsrate()
     to the proper place instead of adding them
     
  v2:
   - Use the 'static const' for rtl8xxxu_legacy_ratetable[]


 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 88 +++++++++++++------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d225a1257530..6d9b5cf01b11 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4473,6 +4473,35 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 	priv->rx_buf_aggregation = 1;
 }
 
+static const struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
+	{.bitrate = 10, .hw_value = 0x00,},
+	{.bitrate = 20, .hw_value = 0x01,},
+	{.bitrate = 55, .hw_value = 0x02,},
+	{.bitrate = 110, .hw_value = 0x03,},
+	{.bitrate = 60, .hw_value = 0x04,},
+	{.bitrate = 90, .hw_value = 0x05,},
+	{.bitrate = 120, .hw_value = 0x06,},
+	{.bitrate = 180, .hw_value = 0x07,},
+	{.bitrate = 240, .hw_value = 0x08,},
+	{.bitrate = 360, .hw_value = 0x09,},
+	{.bitrate = 480, .hw_value = 0x0a,},
+	{.bitrate = 540, .hw_value = 0x0b,},
+};
+
+static void rtl8xxxu_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
+{
+	if (rate <= DESC_RATE_54M)
+		return;
+
+	if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
+		if (rate < DESC_RATE_MCS8)
+			*nss = 1;
+		else
+			*nss = 2;
+		*mcs = rate - DESC_RATE_MCS0;
+	}
+}
+
 static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 {
 	struct ieee80211_hw *hw = priv->hw;
@@ -4534,9 +4563,12 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 	struct ieee80211_sta *sta;
+	struct rtl8xxxu_ra_report *rarpt;
 	u32 val32;
 	u8 val8;
 
+	rarpt = &priv->ra_report;
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		dev_dbg(dev, "Changed ASSOC: %i!\n", bss_conf->assoc);
 
@@ -4545,6 +4577,10 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		if (bss_conf->assoc) {
 			u32 ramask;
 			int sgi = 0;
+			u8 highest_rate;
+			u8 mcs = 0, nss = 0;
+			u32 bit_rate;
+
 
 			rcu_read_lock();
 			sta = ieee80211_find_sta(vif, bss_conf->bssid);
@@ -4569,6 +4605,29 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				sgi = 1;
 			rcu_read_unlock();
 
+			highest_rate = fls(ramask) - 1;
+			if (highest_rate < DESC_RATE_MCS0) {
+				rarpt->txrate.legacy =
+				rtl8xxxu_legacy_ratetable[highest_rate].bitrate;
+			} else {
+				rtl8xxxu_desc_to_mcsrate(highest_rate,
+							 &mcs, &nss);
+				rarpt->txrate.flags |= RATE_INFO_FLAGS_MCS;
+
+				rarpt->txrate.mcs = mcs;
+				rarpt->txrate.nss = nss;
+
+				if (sgi) {
+					rarpt->txrate.flags |=
+						RATE_INFO_FLAGS_SHORT_GI;
+				}
+
+				rarpt->txrate.bw |= RATE_INFO_BW_20;
+			}
+			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
+			rarpt->bit_rate = bit_rate;
+			rarpt->desc_rate = highest_rate;
+
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
@@ -5419,35 +5478,6 @@ void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 	}
 }
 
-static struct ieee80211_rate rtl8xxxu_legacy_ratetable[] = {
-	{.bitrate = 10, .hw_value = 0x00,},
-	{.bitrate = 20, .hw_value = 0x01,},
-	{.bitrate = 55, .hw_value = 0x02,},
-	{.bitrate = 110, .hw_value = 0x03,},
-	{.bitrate = 60, .hw_value = 0x04,},
-	{.bitrate = 90, .hw_value = 0x05,},
-	{.bitrate = 120, .hw_value = 0x06,},
-	{.bitrate = 180, .hw_value = 0x07,},
-	{.bitrate = 240, .hw_value = 0x08,},
-	{.bitrate = 360, .hw_value = 0x09,},
-	{.bitrate = 480, .hw_value = 0x0a,},
-	{.bitrate = 540, .hw_value = 0x0b,},
-};
-
-static void rtl8xxxu_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
-{
-	if (rate <= DESC_RATE_54M)
-		return;
-
-	if (rate >= DESC_RATE_MCS0 && rate <= DESC_RATE_MCS15) {
-		if (rate < DESC_RATE_MCS8)
-			*nss = 1;
-		else
-			*nss = 2;
-		*mcs = rate - DESC_RATE_MCS0;
-	}
-}
-
 static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 {
 	struct rtl8xxxu_priv *priv;
-- 
2.25.1

