Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56D61DA85
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Nov 2022 14:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKENIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Nov 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKENII (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Nov 2022 09:08:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9412B1A7
        for <linux-wireless@vger.kernel.org>; Sat,  5 Nov 2022 06:08:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so11159856edd.13
        for <linux-wireless@vger.kernel.org>; Sat, 05 Nov 2022 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApXQgVGqhwgtuUPS2wo5LwvHPRrL0W3P9SwHqhi/kMs=;
        b=DSs3pe+OqFzRKhVu1yPdjRsLLKq0BP4pnhSYVp5TCKkAA37KXjMw9W1Rd1lf0rdCS4
         BV17mg07eLy1ZYnOpDIGmDjj4ycBigzYBXNG35rxxj0KXJH7m6S8OZwfp5AMoDwSKnrO
         jIEk84+2++HpS/NP9hTAsa9rCXf7dCZ0pGJ3PjJPaDWhDsCDt4GM6YqeP2ysoAXYek09
         1qulycyNlihB2nx4qG7fkzIcgAekLOPtHNbZWOpzesp0DSiNggAHReSSxe4irKmBQSbL
         DsQrOli7CsBVXj9gxHx8ZOLgJm0/PsrDxvpQmCMghVZzSoVhdjNQjihqYM2rA/xvgmQB
         8DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ApXQgVGqhwgtuUPS2wo5LwvHPRrL0W3P9SwHqhi/kMs=;
        b=vsi4ne3juim30+HKIKJzsSxFLEWHMgapMH/8tJRZexUAToepymO9vTRvKb3Az6YU/I
         oPFWbefkVY7TuPr1AVTvKoRi6V8CU2HpaGnrLSHWBugCYz2tpYS5+DLjB7wiQvKKsEgI
         QhWf/Dg8cuXlKHflavxDwQn25LDELxnkhh+NtWPQ7lyovRtzY14cwv97vb9Xik6iEZ19
         CmTSMumGA83suXq3/c2ItqXtPgVwmoZcvCGEb/7qeHplZJZ3GBqlp2V/1HFDcH2VznQ4
         GakeDXuIwkB4E4jt/Vp05rTaUq5ZOdPZenL2brM/IC4TXh/gK7Q6f3m7l8aRf7NPDP9Y
         Uuhg==
X-Gm-Message-State: ACrzQf021EczBXm+HXZXRq8PIvPJZjel36IVbp5ke69D0eOtxQxy7kx8
        v7EfMg7B+db1qlLfm1ZlxRMp97hQnsM=
X-Google-Smtp-Source: AMsMyM7zEZiEocLHfMoHnEu1wUP2bKgPZEA1kL7iTSB9eOodLBeeruQDchmYtHyWBrT+isbRJjqyjw==
X-Received: by 2002:aa7:cd58:0:b0:462:d797:483d with SMTP id v24-20020aa7cd58000000b00462d797483dmr41588467edw.343.1667653681961;
        Sat, 05 Nov 2022 06:08:01 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id sg43-20020a170907a42b00b0078db5bddd9csm913553ejc.22.2022.11.05.06.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 06:08:01 -0700 (PDT)
Message-ID: <8d8ebf5f-54f0-8fae-1dc9-329d583852b9@gmail.com>
Date:   Sat, 5 Nov 2022 15:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/3] wifi: rtl8xxxu: Move burst init to a function
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No changes to functionality, just moving code to make
rtl8xxxu_init_device look nicer.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 89 ++++++++++---------
 4 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index ad3f32f4c6e7..1b9da71dc38d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1471,6 +1471,7 @@ struct rtl8xxxu_fileops {
 	int (*parse_rx_desc) (struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 	void (*init_aggregation) (struct rtl8xxxu_priv *priv);
 	void (*init_statistics) (struct rtl8xxxu_priv *priv);
+	void (*init_burst) (struct rtl8xxxu_priv *priv);
 	void (*enable_rf) (struct rtl8xxxu_priv *priv);
 	void (*disable_rf) (struct rtl8xxxu_priv *priv);
 	void (*usb_quirks) (struct rtl8xxxu_priv *priv);
@@ -1576,6 +1577,7 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_enable_rf(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen1_disable_rf(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen2_disable_rf(struct rtl8xxxu_priv *priv);
+void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv);
 int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb);
 int rtl8xxxu_gen2_channel_to_group(int channel);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 99610bb2afd5..bb88bab7c72a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1652,6 +1652,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.parse_rx_desc = rtl8xxxu_parse_rxdesc24,
 	.init_aggregation = rtl8188fu_init_aggregation,
 	.init_statistics = rtl8188fu_init_statistics,
+	.init_burst = rtl8xxxu_init_burst,
 	.enable_rf = rtl8188f_enable_rf,
 	.disable_rf = rtl8188f_disable_rf,
 	.usb_quirks = rtl8188f_usb_quirks,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index a27fe06d6f77..de5da6e51da7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1656,6 +1656,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.parse_rx_desc = rtl8xxxu_parse_rxdesc24,
 	.init_aggregation = rtl8723bu_init_aggregation,
 	.init_statistics = rtl8723bu_init_statistics,
+	.init_burst = rtl8xxxu_init_burst,
 	.enable_rf = rtl8723b_enable_rf,
 	.disable_rf = rtl8xxxu_gen2_disable_rf,
 	.usb_quirks = rtl8xxxu_gen2_usb_quirks,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9318de69a96b..8b640b1237b5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3909,6 +3909,52 @@ static void rtl8xxxu_init_queue_reserved_page(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_RQPN, val32);
 }
 
+void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+
+	/*
+	 * For USB high speed set 512B packets
+	 */
+	val8 = rtl8xxxu_read8(priv, REG_RXDMA_PRO_8723B);
+	val8 &= ~(BIT(4) | BIT(5));
+	val8 |= BIT(4);
+	val8 |= BIT(1) | BIT(2) | BIT(3);
+	rtl8xxxu_write8(priv, REG_RXDMA_PRO_8723B, val8);
+
+	/*
+	 * Enable single packet AMPDU
+	 */
+	val8 = rtl8xxxu_read8(priv, REG_HT_SINGLE_AMPDU_8723B);
+	val8 |= BIT(7);
+	rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
+
+	rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
+	if (priv->rtl_chip == RTL8723B)
+		val8 = 0x5e;
+	else if (priv->rtl_chip == RTL8188F)
+		val8 = 0x70; /* 0x5e would make it very slow */
+	rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, val8);
+	rtl8xxxu_write32(priv, REG_AGGLEN_LMT, 0xffffffff);
+	rtl8xxxu_write8(priv, REG_RX_PKT_LIMIT, 0x18);
+	rtl8xxxu_write8(priv, REG_PIFS, 0x00);
+	if (priv->rtl_chip == RTL8188F) {
+		rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL, FWHW_TXQ_CTRL_AMPDU_RETRY);
+		rtl8xxxu_write32(priv, REG_FAST_EDCA_CTRL, 0x03086666);
+	}
+	if (priv->rtl_chip == RTL8723B)
+		val8 = 0x50;
+	else if (priv->rtl_chip == RTL8188F)
+		val8 = 0x28; /* 0x50 would make the upload slow */
+	rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, val8);
+	rtl8xxxu_write8(priv, REG_USTIME_EDCA, val8);
+
+	/* to prevent mac is reseted by bus. */
+	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL);
+	val8 |= BIT(5) | BIT(6);
+	rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
+}
+
 static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -4162,48 +4208,9 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	/*
 	 * Initialize burst parameters
 	 */
-	if (priv->rtl_chip == RTL8723B || priv->rtl_chip == RTL8188F) {
-		/*
-		 * For USB high speed set 512B packets
-		 */
-		val8 = rtl8xxxu_read8(priv, REG_RXDMA_PRO_8723B);
-		val8 &= ~(BIT(4) | BIT(5));
-		val8 |= BIT(4);
-		val8 |= BIT(1) | BIT(2) | BIT(3);
-		rtl8xxxu_write8(priv, REG_RXDMA_PRO_8723B, val8);
 
-		/*
-		 * For USB high speed set 512B packets
-		 */
-		val8 = rtl8xxxu_read8(priv, REG_HT_SINGLE_AMPDU_8723B);
-		val8 |= BIT(7);
-		rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
-
-		rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
-		if (priv->rtl_chip == RTL8723B)
-			val8 = 0x5e;
-		else if (priv->rtl_chip == RTL8188F)
-			val8 = 0x70; /* 0x5e would make it very slow */
-		rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, val8);
-		rtl8xxxu_write32(priv, REG_AGGLEN_LMT, 0xffffffff);
-		rtl8xxxu_write8(priv, REG_RX_PKT_LIMIT, 0x18);
-		rtl8xxxu_write8(priv, REG_PIFS, 0x00);
-		if (priv->rtl_chip == RTL8188F) {
-			rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL, FWHW_TXQ_CTRL_AMPDU_RETRY);
-			rtl8xxxu_write32(priv, REG_FAST_EDCA_CTRL, 0x03086666);
-		}
-		if (priv->rtl_chip == RTL8723B)
-			val8 = 0x50;
-		else if (priv->rtl_chip == RTL8188F)
-			val8 = 0x28; /* 0x50 would make the upload slow */
-		rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, val8);
-		rtl8xxxu_write8(priv, REG_USTIME_EDCA, val8);
-
-		/* to prevent mac is reseted by bus. */
-		val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL);
-		val8 |= BIT(5) | BIT(6);
-		rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
-	}
+	if (priv->fops->init_burst)
+		priv->fops->init_burst(priv);
 
 	if (fops->init_aggregation)
 		fops->init_aggregation(priv);
-- 
2.38.0
