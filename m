Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548164BAFC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 18:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiLMRaC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 12:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiLMR36 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 12:29:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B71AD85
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:29:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b2so38257634eja.7
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgNU9XP/jwB8SsGvMEYk84p3VAIT3GnnXHOLuFR9Ggo=;
        b=nkJCsLDNsUeWxBt+u7rHbTOS5JEmfEQMHJDj0CQESAZOVo2CZu9b16A8sHfRxzCNHJ
         iY57rxaaXV0FB7SOTgN0SOZXuVeTL4bexA3Bw+Wu97h5fR+FIVSC6Y5C4dUOqf5idwge
         1I70rnLl/zaN8s3OveJ+PW7snGLB5ovBF5084mY0KsEaM4yTl5tohTEkVrc/BOUd9SR5
         1UeXcVEcGP5w1RXIur3WrKEvH4MSHCW7BpH0WxoFVzWILCP4xKnNuZykRJIUHOj50oQ7
         D16lWpwYhiJGlPn3ELbfFI4vPblcR7Oghjs2I6qqKe2kyxZoiJiLL786eJFgtzcrf6s0
         iNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgNU9XP/jwB8SsGvMEYk84p3VAIT3GnnXHOLuFR9Ggo=;
        b=S+ZpQGXJZwVmt8U0Jr8OWkNC2nr61On3UvMRQG10LRlSxCTE6/uw6K1H2RT+IPQqwd
         /qqBr92JeekCrIP/1qP8s6KrWAYKpNS6dxLXflIDoqKzsFivyMgADIuLulNy8KoUjrYX
         tUl5GRQ1OlxBHi2/CdGsugIqf7YSpyUq/g31SgjQMcPIP/TJxU95plerGQDx/vzSP0pR
         N+FHSR5k3Alv5RfwERLSI+hGUGOjhVsRBY+zzJxazTE4KbTvzWcfT1QE7keU6pGCibtA
         /fegFytf0hiXJBrmELxksIK5ESB5vWSI/uz85qJ3uaPb8Hl7T7MTt6QUQqknxUN7wbVX
         Ia9Q==
X-Gm-Message-State: ANoB5pl+eLOg53iJqNjaMD0ZKOGigbtmFi77MQ834UQ7uEVGHods6d0r
        M/RYGyVEjvQLzw7aGDMgNoKGdO2sxY8=
X-Google-Smtp-Source: AA0mqf56wf60ydKA/UyhUXzLEXZK6BkSvCPKqsVSL0mnR8eOHKauutPT/RuyJ/p4n3YQXuqQGea1VQ==
X-Received: by 2002:a17:906:76d2:b0:7c1:20ff:c044 with SMTP id q18-20020a17090676d200b007c120ffc044mr18691949ejn.27.1670952595013;
        Tue, 13 Dec 2022 09:29:55 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007c0f5d6f754sm4850555ejc.79.2022.12.13.09.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:29:54 -0800 (PST)
Message-ID: <495c0ea7-d6c9-15c7-7c25-77ecbe856cdc@gmail.com>
Date:   Tue, 13 Dec 2022 19:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 3/5] wifi: rtl8xxxu: Define masks for cck_agc_rpt bits
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
In-Reply-To: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
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

Define the constants CCK_AGC_RPT_LNA_IDX_MASK and
CCK_AGC_RPT_VGA_IDX_MASK instead of using the same literals
in four places.

And get the bits from cck_agc_rpt using u8_get_bits().

It's a cosmetic change only.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 3 +++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 4 ++--
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 4 ++--
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 87758295d618..15bb2b5211a8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -562,6 +562,9 @@ struct phy_rx_agc_info {
 #endif
 };
 
+#define CCK_AGC_RPT_LNA_IDX_MASK	GENMASK(7, 5)
+#define CCK_AGC_RPT_VGA_IDX_MASK	GENMASK(4, 0)
+
 struct rtl8723au_phy_stats {
 	struct phy_rx_agc_info path_agc[RTL8723A_MAX_RF_PATHS];
 	u8	ch_corr[RTL8723A_MAX_RF_PATHS];
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 94fc4647075a..54e136c964b4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1682,8 +1682,8 @@ static s8 rtl8188f_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	s8 rx_pwr_all = 0x00;
 	u8 vga_idx, lna_idx;
 
-	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
-	vga_idx = cck_agc_rpt & 0x1F;
+	lna_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_LNA_IDX_MASK);
+	vga_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_VGA_IDX_MASK);
 
 	switch (lna_idx) {
 	case 7:
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index c769d0eaa03c..7ec6d8fb3c2b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1717,8 +1717,8 @@ static s8 rtl8192e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	u8 vga_idx, lna_idx;
 	s8 lna_gain = 0;
 
-	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
-	vga_idx = cck_agc_rpt & 0x1F;
+	lna_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_LNA_IDX_MASK);
+	vga_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_VGA_IDX_MASK);
 
 	if (priv->cck_agc_report_type == 0)
 		lna_gain = lna_gain_table_0[lna_idx];
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 65ebf9dcf5f9..0ed667d5ed25 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1680,8 +1680,8 @@ static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	s8 rx_pwr_all = 0x00;
 	u8 vga_idx, lna_idx;
 
-	lna_idx = (cck_agc_rpt & 0xE0) >> 5;
-	vga_idx = cck_agc_rpt & 0x1F;
+	lna_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_LNA_IDX_MASK);
+	vga_idx = u8_get_bits(cck_agc_rpt, CCK_AGC_RPT_VGA_IDX_MASK);
 
 	switch (lna_idx) {
 	case 6:
-- 
2.38.0
