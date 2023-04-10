Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F26DC89C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDJPfv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDJPfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 11:35:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A94EC7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 08:35:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sh8so13292047ejc.10
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681140947;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP4HoH3Ana/5HQ+YGpeJ3b3LBky/en5MuiSk35t2JzY=;
        b=Re/Rf1M9wAiKRT1CjMD7BK7STue36XeVaVf7tlZ8PqoPL3angOLeJ8pza0PxZVM5OO
         udgMGYKvuuKVJn7Dst4vPWyXCnS/iaUAwOn5LO4Zy8YRCnJ5BoI8IMJnS/kQUcEMfr8G
         3lJ4y23d3sIofGgzSws4WAeJrtlaTIAT4od/aMTvMl8ptBx0YZ4vCfyepwWyX1A7HSxq
         66VUOqjI3OuYoocuHMbz15y7Kh12RZt98v0nen3RvzPgpu2ytjelD+mfcrzyMZNSCb3s
         5o1V0NLhQk8EZDsq9M5g2qv+UaM/7ZsQ64auVf1c4QBOG69Xtbi7YQZ/UvFfRo+6xS9R
         G7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140947;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fP4HoH3Ana/5HQ+YGpeJ3b3LBky/en5MuiSk35t2JzY=;
        b=5TyEDioIYWZGZZysfGEwfIt0/m1b9fADPv9tKtmL4VjP2fRGJMoubcD1TL8Qnj81ep
         MfPb49iQ9Gi6k220fp1gvbsD6XOEzSyqtbcR4yQwk4F0i/F5tr/8M7Nk62ycUgdPxqhX
         mR5/rSSPVmzX450SYFtCuXOE1Y3CjCwYI13RUnGPbqpB/jrld20pqWxbmNFms5/u1Vqt
         snYdMA+ETzi8gSshZm5sWAi02FMrL9/sTdLu1PGvhfhMGh4GzvX4uAenF0HK6lb/XsRH
         n8Tos3x94U9tYuFzPstv1QYcAzR5vPXwB8ZUsXFjVtKgQmFXP7a1nvIq7TbEtIfyv2lf
         9avA==
X-Gm-Message-State: AAQBX9cx4wtBRe2B5t0YJT3edRyNSf0tn/e4Zx5AGBMM526rkuPjBE80
        sTlUClc04/VxqGftM5D1ucDpmnVQC4s=
X-Google-Smtp-Source: AKy350aAPyQHvs/+G3Nm/CFJaj12/eAm3EKe5c4fq2HB8vRpg8ED+p4f1rg/xCShpE3IR0J5iXKdlQ==
X-Received: by 2002:a17:906:f244:b0:8a5:8620:575 with SMTP id gy4-20020a170906f24400b008a586200575mr5625525ejb.3.1681140947014;
        Mon, 10 Apr 2023 08:35:47 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b0094a52b041dasm2194976ejc.112.2023.04.10.08.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:35:46 -0700 (PDT)
Message-ID: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
Date:   Mon, 10 Apr 2023 18:35:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtl8xxxu: Clean up some messy ifs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add some new members to rtl8xxxu_fileops and use them instead of
checking priv->rtl_chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Don't set init_reg_pkt_life_time for the RTL8192EU. Just because
   this patch should not introduce any changes in behaviour.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++++
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  5 ++++
 .../realtek/rtl8xxxu/rtl8xxxu_8710b.c         |  9 +++++++
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  3 +++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 +++++--------------
 6 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9d48c69ffece..39fee07917e7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1923,6 +1923,11 @@ struct rtl8xxxu_fileops {
 	u8 has_tx_report:1;
 	u8 gen2_thermal_meter:1;
 	u8 needs_full_init:1;
+	u8 init_reg_rxfltmap:1;
+	u8 init_reg_pkt_life_time:1;
+	u8 init_reg_hmtfr:1;
+	u8 ampdu_max_time;
+	u8 ustime_tsf_edca;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 6a82ec47568e..af8436070ba7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1883,6 +1883,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.has_tx_report = 1,
+	.init_reg_pkt_life_time = 1,
 	.gen2_thermal_meter = 1,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 82dee1fed477..dfb250adb168 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1746,6 +1746,11 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.init_reg_rxfltmap = 1,
+	.init_reg_pkt_life_time = 1,
+	.init_reg_hmtfr = 1,
+	.ampdu_max_time = 0x70,
+	.ustime_tsf_edca = 0x28,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index 920466e39604..22d4704dd31e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -1865,6 +1865,15 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.init_reg_rxfltmap = 1,
+	.init_reg_pkt_life_time = 1,
+	.init_reg_hmtfr = 1,
+	.ampdu_max_time = 0x5e,
+	/*
+	 * The RTL8710BU vendor driver uses 0x50 here and it works fine,
+	 * but in rtl8xxxu 0x50 causes slow upload and random packet loss. Why?
+	 */
+	.ustime_tsf_edca = 0x28,
 	.adda_1t_init = 0x03c00016,
 	.adda_1t_path_on = 0x03c00016,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index d99538eb8398..c31c2b52ac77 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1741,6 +1741,9 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.init_reg_hmtfr = 1,
+	.ampdu_max_time = 0x5e,
+	.ustime_tsf_edca = 0x50,
 	.adda_1t_init = 0x01c00014,
 	.adda_1t_path_on = 0x01c00014,
 	.adda_2t_path_on_a = 0x01c00014,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c152b228606f..62dd53a57659 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1916,7 +1916,7 @@ static int rtl8xxxu_start_firmware(struct rtl8xxxu_priv *priv)
 	/*
 	 * Init H2C command
 	 */
-	if (priv->rtl_chip == RTL8723B || priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B)
+	if (priv->fops->init_reg_hmtfr)
 		rtl8xxxu_write8(priv, REG_HMTFR, 0x0f);
 exit:
 	return ret;
@@ -3864,11 +3864,8 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_HT_SINGLE_AMPDU_8723B, val8);
 
 	rtl8xxxu_write16(priv, REG_MAX_AGGR_NUM, 0x0c14);
-	if (priv->rtl_chip == RTL8723B || priv->rtl_chip == RTL8710B)
-		val8 = 0x5e;
-	else if (priv->rtl_chip == RTL8188F)
-		val8 = 0x70; /* 0x5e would make it very slow */
-	rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B, val8);
+	rtl8xxxu_write8(priv, REG_AMPDU_MAX_TIME_8723B,
+			priv->fops->ampdu_max_time);
 	rtl8xxxu_write32(priv, REG_AGGLEN_LMT, 0xffffffff);
 	rtl8xxxu_write8(priv, REG_RX_PKT_LIMIT, 0x18);
 	rtl8xxxu_write8(priv, REG_PIFS, 0x00);
@@ -3876,16 +3873,8 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 		rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL, FWHW_TXQ_CTRL_AMPDU_RETRY);
 		rtl8xxxu_write32(priv, REG_FAST_EDCA_CTRL, 0x03086666);
 	}
-	/*
-	 * The RTL8710BU vendor driver uses 0x50 here and it works fine,
-	 * but in rtl8xxxu 0x50 causes slow upload and random packet loss. Why?
-	 */
-	if (priv->rtl_chip == RTL8723B)
-		val8 = 0x50;
-	else if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B)
-		val8 = 0x28; /* 0x50 would make the upload slow */
-	rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, val8);
-	rtl8xxxu_write8(priv, REG_USTIME_EDCA, val8);
+	rtl8xxxu_write8(priv, REG_USTIME_TSF_8723B, priv->fops->ustime_tsf_edca);
+	rtl8xxxu_write8(priv, REG_USTIME_EDCA, priv->fops->ustime_tsf_edca);
 
 	/* to prevent mac is reseted by bus. */
 	val8 = rtl8xxxu_read8(priv, REG_RSV_CTRL);
@@ -4102,7 +4091,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
 
-	if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8710B) {
+	if (fops->init_reg_rxfltmap) {
 		/* Accept all data frames */
 		rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0xffff);
 
@@ -4187,8 +4176,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (fops->init_aggregation)
 		fops->init_aggregation(priv);
 
-	if (priv->rtl_chip == RTL8188F || priv->rtl_chip == RTL8188E ||
-	    priv->rtl_chip == RTL8710B) {
+	if (fops->init_reg_pkt_life_time) {
 		rtl8xxxu_write16(priv, REG_PKT_VO_VI_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
 		rtl8xxxu_write16(priv, REG_PKT_BE_BK_LIFE_TIME, 0x0400); /* unit: 256us. 256ms */
 	}
-- 
2.39.2
