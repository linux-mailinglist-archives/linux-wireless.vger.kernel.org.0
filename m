Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC04074C73D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jul 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGISiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jul 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjGISiM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jul 2023 14:38:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA9FE
        for <linux-wireless@vger.kernel.org>; Sun,  9 Jul 2023 11:38:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992b2249d82so489523666b.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jul 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688927889; x=1691519889;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca14QOII0RA1iCaeOMlWN0+rtUB9Z+STfK35iuSH8Yg=;
        b=fE676MvhdK8uu1J4iBAb20KEN1yhZNa9H4wnSWgnJJj4L7hiZEc82qkdcLxjBAzW51
         Jlk9n514nI92F0eI8gzf0hF2QwiKJRMAz71JbJOSZ6i4FSX1erYqlbFBxDecKv6ADDdk
         V6tmpaz5XpUSG10OD+5/7Fy963rK00AHYfGxLLKRlvxTIzZx3cZw+Wm3MFFmNlLY5TsN
         S0yUwwSJbVNzGkRlb6cuVnf+IV77pC0FDxpGT62jOlycmzgYL74SFgmyrkAQ4EhbSLIs
         4dgw9vveX4hXLkZOonrOTLwKibS14EPuY7avG9T+DtKS2dlTeTZYK7DIVKlBhxqO1NtB
         d5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688927889; x=1691519889;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ca14QOII0RA1iCaeOMlWN0+rtUB9Z+STfK35iuSH8Yg=;
        b=ZOPrCLqmJcI+VLgsCRFGWJfOF0w3zX4ku4tTeTeutaQsdPcyaCNg93CIfjELS6O+dg
         8BFeTnfLKr5gxwpUBgsR9BhMZxu0nKLwpVgfH4McKt8kT5e9ElU3Woh1/Je3t9dYlD5o
         xy8oun2fuHZ3zcWMJZ7wnqp/u315rxA4r+l94uOAogMysNMksd+QvIi3Iow+emCuzidK
         3kiYDDyrv5rdNt3Gf5BpVRqLt27bjyiSEtl7D2pRYfivIB3CgzMXutUOZVIF8xvwidHY
         3Fkdv5blekorbvERvy9oVUamCdiUgt0F35H1OnZpfcE9gQINsGykyRCWLpFo6EVarUtQ
         IPtA==
X-Gm-Message-State: ABy/qLZXdHUul7v7jjtf48jcTFESy/Jv5tGpFvP7E6T7RZreA90LTHaM
        J6BhDdF8GlKKvesjidT4iRuKT3fagu4=
X-Google-Smtp-Source: APBJJlGlUEURxaJqPFi8VgQOw6LZauq3OitGX4Xw4PqqRuvH2U+UNS4vxNkkDDhsdNb8C/YNRDVsGw==
X-Received: by 2002:a17:906:e17:b0:992:7462:a22c with SMTP id l23-20020a1709060e1700b009927462a22cmr9346068eji.36.1688927889282;
        Sun, 09 Jul 2023 11:38:09 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00992b510089asm5082370ejd.84.2023.07.09.11.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 11:38:08 -0700 (PDT)
Message-ID: <52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com>
Date:   Sun, 9 Jul 2023 21:38:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH RFC] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't subtract 1 from the power index. This was added in commit
2fc0b8e5a17d ("rtl8xxxu: Add TX power base values for gen1 parts")
for unknown reasons. The vendor drivers don't do this.

Also correct the calculations of values written to
REG_OFDM0_X{C,D}_TX_IQ_IMBALANCE. According to the vendor driver,
these are used for TX power training.

With these changes rtl8xxxu sets the TX power of RTL8192CU the same
as the vendor driver.

None of this appears to have any effect on my RTL8192CU device.
---
My RTL8192CU with rtl8xxxu has lower upload speed compared to the
vendor driver, so I compared the register writes and found
differences in the TX power stuff.

Jes, do you remember why you subtracted 1 from the power index?
That has to be on purpose. The other differences look unintentional.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5d102a1246a3..e111fb2b2c30 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1510,8 +1510,8 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	group = rtl8xxxu_gen1_channel_to_group(channel);
 
-	cck[0] = priv->cck_tx_power_index_A[group] - 1;
-	cck[1] = priv->cck_tx_power_index_B[group] - 1;
+	cck[0] = priv->cck_tx_power_index_A[group];
+	cck[1] = priv->cck_tx_power_index_B[group];
 
 	if (priv->hi_pa) {
 		if (cck[0] > 0x20)
@@ -1522,10 +1522,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
 	ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
-	if (ofdm[0])
-		ofdm[0] -= 1;
-	if (ofdm[1])
-		ofdm[1] -= 1;
 
 	ofdmbase[0] = ofdm[0] +	priv->ofdm_tx_power_index_diff[group].a;
 	ofdmbase[1] = ofdm[1] +	priv->ofdm_tx_power_index_diff[group].b;
@@ -1614,20 +1610,22 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
 			 mcs_a + power_base->reg_0e1c);
+	val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
 	for (i = 0; i < 3; i++) {
 		if (i != 2)
-			val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
+			val8 = (val8 > 8) ? (val8 - 8) : 0;
 		else
-			val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
+			val8 = (val8 > 6) ? (val8 - 6) : 0;
 		rtl8xxxu_write8(priv, REG_OFDM0_XC_TX_IQ_IMBALANCE + i, val8);
 	}
 	rtl8xxxu_write32(priv, REG_TX_AGC_B_MCS15_MCS12,
 			 mcs_b + power_base->reg_0868);
+	val8 = u32_get_bits(mcs_b + power_base->reg_0868, 0xff000000);
 	for (i = 0; i < 3; i++) {
 		if (i != 2)
-			val8 = (mcsbase[1] > 8) ? (mcsbase[1] - 8) : 0;
+			val8 = (val8 > 8) ? (val8 - 8) : 0;
 		else
-			val8 = (mcsbase[1] > 6) ? (mcsbase[1] - 6) : 0;
+			val8 = (val8 > 6) ? (val8 - 6) : 0;
 		rtl8xxxu_write8(priv, REG_OFDM0_XD_TX_IQ_IMBALANCE + i, val8);
 	}
 }
-- 
2.41.0
