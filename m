Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFE64F930
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLQOP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLQOP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:15:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A113F2F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:15:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5921410wmb.2
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XBNtzZIUL6DpeJRGDseDf4I9zzEeOSirZvIImwNMbA=;
        b=N5rGiLQodNU8eTMbNw3sLEufM5Pp+0Wk1uRKjZ3QkChi/z4f2iG1kBKKdmpmHzx6Vd
         jLVSsXfvmczuxHnER6j8VLxITUsaHxJozG3gLFQr9OUMkumxqhysHwjmQm6EBro7rX4k
         hflX/t/kmaZKbcJiswcggDOLTUV0nQtKIvtsB2N7cssbepzxQNv87ziDfuuCVgO7+RBm
         I54JX1frl/TdtIfHkFhhmBxvpEya+fJKhDxT6F7IeX0LL5edFow1FfKChGLVwGPAyTqh
         y0DrHUTZq2Yjj05DsMQYEgtLXmwAs50HOOnKdsOSUjTXDW/LMq2SZDffvxDPqsQJe8uB
         ntZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XBNtzZIUL6DpeJRGDseDf4I9zzEeOSirZvIImwNMbA=;
        b=PB6dkodYoZMYhQdpHGbJHazt2FVVgGfbB5pQgMazLJ0qpITO9F0i89oGM92dGi4OM5
         4OVieQLv5KRHQ2dASen9tlxR1K93I2Wq8SlfS7grrj3xMW3G0E4s8nsC4CKmyiwv4rqV
         D5wkQVLol9neJk4PjaObE+ZRTSjq/vnZahlfkX88f4+M0PMYlhjQW/Q990PXGrnU4J3R
         G8ay9ua0/h0JckKj245XIRWdPP7xyQMJc9J1/F6qi54aWP20+nPIOr2+kn6mKqoPf/4R
         GATWhcLy0EpRPGKnYcVadyb92UhTEMFb+oFJdF4GnH+FgZn1pvIm1mXeLmmoKNsnNhrj
         gmpg==
X-Gm-Message-State: AFqh2kpAqNbBjI0wgnU0wFbhPHShpyc3y3+Grcql5+zm9fm8rsxRLC/r
        r3w0fYBJRUhXIGhF5bhS9yxrj+GDdaQ=
X-Google-Smtp-Source: AMrXdXtYc+gA7RSrQhlnkaf2NpC/Y4cIA9nWTQA5z9n2VvH17CFGZHeC9zGdVSKovPK+YsfanSssyQ==
X-Received: by 2002:a1c:4b18:0:b0:3d3:39a9:e659 with SMTP id y24-20020a1c4b18000000b003d339a9e659mr7797477wma.21.1671286525037;
        Sat, 17 Dec 2022 06:15:25 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id ja5-20020a05600c556500b003d1e4120700sm6866415wmb.41.2022.12.17.06.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:15:24 -0800 (PST)
Message-ID: <cfe79922-efdf-2ed0-7404-263915d19d82@gmail.com>
Date:   Sat, 17 Dec 2022 16:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 3/5] wifi: rtl8xxxu: Define masks for cck_agc_rpt bits
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
In-Reply-To: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
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
v3:
 - No change.

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
