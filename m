Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9B5F84D4
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJHKy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Oct 2022 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Oct 2022 06:54:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993850F81
        for <linux-wireless@vger.kernel.org>; Sat,  8 Oct 2022 03:54:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qw20so15424875ejc.8
        for <linux-wireless@vger.kernel.org>; Sat, 08 Oct 2022 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqYlWAVGNpToyinTA2jS8XwUnosUWMHmyjgpH+9r6ZY=;
        b=ATJcqayHAO74lJRKn2+rAGtJu2sHjy6SS7ADF2z3lu9ngZl2FSt/kx2Wsg3X2AfzOM
         NccPqGwbxNcm4USATV043Mc4cnxaavxxsCGlNsp9VoKBajJZ97YN29hAJ8/RX1ZfdRom
         mkl+YMgjykDskgwf691D1UJXNuBQPGccS5aM3+0OImv7lsyaWsUY/OggOYiUAw1CiFXF
         Tv79hgq8k8u7ckT2cCsdXyqB7CDtyteDkKNXGzvgJFDdptWGPRKq+KXneCzzoCUOTg2a
         UJYBlhJnMz/hCpLgR7ejWpxogBCoHF4ayj5Xv02gbuk7Iyr4KsusjuN3N5WoaPTyVb8+
         amXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yqYlWAVGNpToyinTA2jS8XwUnosUWMHmyjgpH+9r6ZY=;
        b=74vgRtPBsOdokWfD03nQktPAOMymi5K/6sogGYJ4GerfZ91NSvA0VOb2Oo3Fq7njKL
         URiFagS0K1yO4LEVGz2p/7Lyj3qpQzN4tAy1pk8Ts98nWty14RUR/2RgNwZeHTc+FlhC
         gIJPw1Vuw4xmdRPbS1TEb2Yc3Xb/4pUuZMwXBY+8lKaP+BlrXH1KvvkdICUUxmVp0LiR
         dzHpv7XemQn/O3ln08OC2ZX9j0adck+rdb8Ezz6JQvYtp0HhvCRw3bxM6sFIGOImZ8Du
         XAgzEWTrhpRY5sdmM9HjWcxSk1QS9dgV/2fegYC/e5wh8FnvfM3LJOpAzNBY3LeOAI9r
         aj+g==
X-Gm-Message-State: ACrzQf2D5v+jGLbQMy/1WLV9rR7DYZGDLnCcfTqa4ppEssoeiv7cS95F
        2i2DTVCtee5ZN+R4jinUKqcfJELjCYw=
X-Google-Smtp-Source: AMsMyM7x9ubBVBN3WCiqvVkjYApZVK7ytqGp+TVX7hGrQAX33gqgKKyJ80KXRM/mcDRF/79knUuJuQ==
X-Received: by 2002:a17:907:744:b0:741:36b9:d2cc with SMTP id xc4-20020a170907074400b0074136b9d2ccmr7260855ejb.613.1665226464654;
        Sat, 08 Oct 2022 03:54:24 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id kv9-20020a17090778c900b0078d4e39d87esm264963ejc.225.2022.10.08.03.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 03:54:23 -0700 (PDT)
Message-ID: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
Date:   Sat, 8 Oct 2022 13:54:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/3] wifi: rtl8xxxu: Make some arrays const
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

All the initialisation tables, plus rtl8xxxu_rfregs.

Most of them were already static.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  8 +++----
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         | 10 ++++-----
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         | 10 ++++-----
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 12 +++++-----
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         |  2 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         |  8 +++----
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 22 +++++++++----------
 7 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9950a2ee00aa..ad3f32f4c6e7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1500,7 +1500,7 @@ struct rtl8xxxu_fileops {
 	u16 trxff_boundary;
 	u8 pbp_rx;
 	u8 pbp_tx;
-	struct rtl8xxxu_reg8val *mactable;
+	const struct rtl8xxxu_reg8val *mactable;
 	u8 total_page_num;
 	u8 page_num_hi;
 	u8 page_num_lo;
@@ -1509,7 +1509,7 @@ struct rtl8xxxu_fileops {
 
 extern int rtl8xxxu_debug;
 
-extern struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[];
+extern const struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[];
 extern const u32 rtl8xxxu_iqk_phy_iq_bb_reg[];
 u8 rtl8xxxu_read8(struct rtl8xxxu_priv *priv, u16 addr);
 u16 rtl8xxxu_read16(struct rtl8xxxu_priv *priv, u16 addr);
@@ -1538,10 +1538,10 @@ void rtl8xxxu_fill_iqk_matrix_a(struct rtl8xxxu_priv *priv, bool iqk_ok,
 void rtl8xxxu_fill_iqk_matrix_b(struct rtl8xxxu_priv *priv, bool iqk_ok,
 				int result[][8], int candidate, bool tx_only);
 int rtl8xxxu_init_phy_rf(struct rtl8xxxu_priv *priv,
-			 struct rtl8xxxu_rfregval *table,
+			 const struct rtl8xxxu_rfregval *table,
 			 enum rtl8xxxu_rfpath path);
 int rtl8xxxu_init_phy_regs(struct rtl8xxxu_priv *priv,
-			   struct rtl8xxxu_reg32val *array);
+			   const struct rtl8xxxu_reg32val *array);
 int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, char *fw_name);
 void rtl8xxxu_firmware_self_reset(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_power_off(struct rtl8xxxu_priv *priv);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 4ede766104c8..99610bb2afd5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -30,7 +30,7 @@
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
 
-static struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
+static const struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
 	{0x024, 0xDF}, {0x025, 0x07}, {0x02B, 0x1C}, {0x283, 0x20},
 	{0x421, 0x0F}, {0x428, 0x0A}, {0x429, 0x10}, {0x430, 0x00},
 	{0x431, 0x00}, {0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04},
@@ -60,7 +60,7 @@ static struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
 	{0xffff, 0xff},
 };
 
-static struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {
+static const struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {
 	{0x800, 0x80045700}, {0x804, 0x00000001},
 	{0x808, 0x0000FC00}, {0x80C, 0x0000000A},
 	{0x810, 0x10001331}, {0x814, 0x020C3D10},
@@ -168,7 +168,7 @@ static struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {
+static const struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {
 	{0xC78, 0xFC000001}, {0xC78, 0xFB010001},
 	{0xC78, 0xFA020001}, {0xC78, 0xF9030001},
 	{0xC78, 0xF8040001}, {0xC78, 0xF7050001},
@@ -205,7 +205,7 @@ static struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {
 	{0x00, 0x00030000}, {0x08, 0x00008400},
 	{0x18, 0x00000407}, {0x19, 0x00000012},
 	{0x1B, 0x00001C6C},
@@ -263,7 +263,7 @@ static struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {
 	{0x00, 0x00030000}, {0x08, 0x00008400},
 	{0x18, 0x00000407}, {0x19, 0x00000012},
 	{0x1B, 0x00001C6C},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index dd84da51686c..e9bc94edfa79 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -77,7 +77,7 @@ static struct rtl8xxxu_power_base rtl8188r_power_base = {
 	.reg_0868 = 0x00020204,
 };
 
-static struct rtl8xxxu_rfregval rtl8192cu_radioa_2t_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8192cu_radioa_2t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00018c63},
 	{0x04, 0x000210e7}, {0x09, 0x0002044f},
@@ -152,7 +152,7 @@ static struct rtl8xxxu_rfregval rtl8192cu_radioa_2t_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8192cu_radiob_2t_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8192cu_radiob_2t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00018c63},
 	{0x04, 0x000210e7}, {0x09, 0x0002044f},
@@ -176,7 +176,7 @@ static struct rtl8xxxu_rfregval rtl8192cu_radiob_2t_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8192cu_radioa_1t_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8192cu_radioa_1t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00018c63},
 	{0x04, 0x000210e7}, {0x09, 0x0002044f},
@@ -251,7 +251,7 @@ static struct rtl8xxxu_rfregval rtl8192cu_radioa_1t_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8188ru_radioa_1t_highpa_table[] = {
+static const struct rtl8xxxu_rfregval rtl8188ru_radioa_1t_highpa_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00018c63},
 	{0x04, 0x000210e7}, {0x09, 0x0002044f},
@@ -413,7 +413,7 @@ static int rtl8192cu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 static int rtl8192cu_init_phy_rf(struct rtl8xxxu_priv *priv)
 {
-	struct rtl8xxxu_rfregval *rftable;
+	const struct rtl8xxxu_rfregval *rftable;
 	int ret;
 
 	if (priv->rtl_chip == RTL8188R) {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index c37bae079cf6..550290ae9e17 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -32,7 +32,7 @@
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
 
-static struct rtl8xxxu_reg8val rtl8192e_mac_init_table[] = {
+static const struct rtl8xxxu_reg8val rtl8192e_mac_init_table[] = {
 	{0x011, 0xeb}, {0x012, 0x07}, {0x014, 0x75}, {0x303, 0xa7},
 	{0x428, 0x0a}, {0x429, 0x10}, {0x430, 0x00}, {0x431, 0x00},
 	{0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04}, {0x435, 0x05},
@@ -62,7 +62,7 @@ static struct rtl8xxxu_reg8val rtl8192e_mac_init_table[] = {
 	{0xffff, 0xff},
 };
 
-static struct rtl8xxxu_reg32val rtl8192eu_phy_init_table[] = {
+static const struct rtl8xxxu_reg32val rtl8192eu_phy_init_table[] = {
 	{0x800, 0x80040000}, {0x804, 0x00000003},
 	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
 	{0x810, 0x10001331}, {0x814, 0x020c3d10},
@@ -194,7 +194,7 @@ static struct rtl8xxxu_reg32val rtl8192eu_phy_init_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_std_table[] = {
+static const struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_std_table[] = {
 	{0xc78, 0xfb000001}, {0xc78, 0xfb010001},
 	{0xc78, 0xfb020001}, {0xc78, 0xfb030001},
 	{0xc78, 0xfb040001}, {0xc78, 0xfb050001},
@@ -263,7 +263,7 @@ static struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_std_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_highpa_table[] = {
+static const struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_highpa_table[] = {
 	{0xc78, 0xfa000001}, {0xc78, 0xf9010001},
 	{0xc78, 0xf8020001}, {0xc78, 0xf7030001},
 	{0xc78, 0xf6040001}, {0xc78, 0xf5050001},
@@ -332,7 +332,7 @@ static struct rtl8xxxu_reg32val rtl8xxx_agc_8192eu_highpa_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8192eu_radioa_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8192eu_radioa_init_table[] = {
 	{0x7f, 0x00000082}, {0x81, 0x0003fc00},
 	{0x00, 0x00030000}, {0x08, 0x00008400},
 	{0x18, 0x00000407}, {0x19, 0x00000012},
@@ -412,7 +412,7 @@ static struct rtl8xxxu_rfregval rtl8192eu_radioa_init_table[] = {
 	{0xff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8192eu_radiob_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8192eu_radiob_init_table[] = {
 	{0x7f, 0x00000082}, {0x81, 0x0003fc00},
 	{0x00, 0x00030000}, {0x08, 0x00008400},
 	{0x18, 0x00000407}, {0x19, 0x00000012},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index e18ddd441728..44565bf4c1c2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -54,7 +54,7 @@ static struct rtl8xxxu_power_base rtl8723a_power_base = {
 	.reg_0868 = 0x02040608,
 };
 
-static struct rtl8xxxu_rfregval rtl8723au_radioa_1t_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8723au_radioa_1t_init_table[] = {
 	{0x00, 0x00030159}, {0x01, 0x00031284},
 	{0x02, 0x00098000}, {0x03, 0x00039c63},
 	{0x04, 0x000210e7}, {0x09, 0x0002044f},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 7c9b8432a4e9..a27fe06d6f77 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -32,7 +32,7 @@
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
 
-static struct rtl8xxxu_reg8val rtl8723b_mac_init_table[] = {
+static const struct rtl8xxxu_reg8val rtl8723b_mac_init_table[] = {
 	{0x02f, 0x30}, {0x035, 0x00}, {0x039, 0x08}, {0x04e, 0xe0},
 	{0x064, 0x00}, {0x067, 0x20}, {0x428, 0x0a}, {0x429, 0x10},
 	{0x430, 0x00}, {0x431, 0x00},
@@ -63,7 +63,7 @@ static struct rtl8xxxu_reg8val rtl8723b_mac_init_table[] = {
 	{0xffff, 0xff},
 };
 
-static struct rtl8xxxu_reg32val rtl8723b_phy_1t_init_table[] = {
+static const struct rtl8xxxu_reg32val rtl8723b_phy_1t_init_table[] = {
 	{0x800, 0x80040000}, {0x804, 0x00000003},
 	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
 	{0x810, 0x10001331}, {0x814, 0x020c3d10},
@@ -164,7 +164,7 @@ static struct rtl8xxxu_reg32val rtl8723b_phy_1t_init_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8xxx_agc_8723bu_table[] = {
+static const struct rtl8xxxu_reg32val rtl8xxx_agc_8723bu_table[] = {
 	{0xc78, 0xfd000001}, {0xc78, 0xfc010001},
 	{0xc78, 0xfb020001}, {0xc78, 0xfa030001},
 	{0xc78, 0xf9040001}, {0xc78, 0xf8050001},
@@ -235,7 +235,7 @@ static struct rtl8xxxu_reg32val rtl8xxx_agc_8723bu_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregval rtl8723bu_radioa_1t_init_table[] = {
+static const struct rtl8xxxu_rfregval rtl8723bu_radioa_1t_init_table[] = {
 	{0x00, 0x00010000}, {0xb0, 0x000dffe0},
 	{0xfe, 0x00000000}, {0xfe, 0x00000000},
 	{0xfe, 0x00000000}, {0xb1, 0x00000018},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index ba2a16de19ed..9318de69a96b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -128,7 +128,7 @@ static struct ieee80211_supported_band rtl8xxxu_supported_band = {
 	.n_bitrates = ARRAY_SIZE(rtl8xxxu_rates),
 };
 
-struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[] = {
+const struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[] = {
 	{0x420, 0x80}, {0x423, 0x00}, {0x430, 0x00}, {0x431, 0x00},
 	{0x432, 0x00}, {0x433, 0x01}, {0x434, 0x04}, {0x435, 0x05},
 	{0x436, 0x06}, {0x437, 0x07}, {0x438, 0x00}, {0x439, 0x00},
@@ -153,7 +153,7 @@ struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[] = {
 	{0x70a, 0x65}, {0x70b, 0x87}, {0xffff, 0xff},
 };
 
-static struct rtl8xxxu_reg32val rtl8723a_phy_1t_init_table[] = {
+static const struct rtl8xxxu_reg32val rtl8723a_phy_1t_init_table[] = {
 	{0x800, 0x80040000}, {0x804, 0x00000003},
 	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
 	{0x810, 0x10001331}, {0x814, 0x020c3d10},
@@ -251,7 +251,7 @@ static struct rtl8xxxu_reg32val rtl8723a_phy_1t_init_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8192cu_phy_2t_init_table[] = {
+static const struct rtl8xxxu_reg32val rtl8192cu_phy_2t_init_table[] = {
 	{0x024, 0x0011800f}, {0x028, 0x00ffdb83},
 	{0x800, 0x80040002}, {0x804, 0x00000003},
 	{0x808, 0x0000fc00}, {0x80c, 0x0000000a},
@@ -349,7 +349,7 @@ static struct rtl8xxxu_reg32val rtl8192cu_phy_2t_init_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8188ru_phy_1t_highpa_table[] = {
+static const struct rtl8xxxu_reg32val rtl8188ru_phy_1t_highpa_table[] = {
 	{0x024, 0x0011800f}, {0x028, 0x00ffdb83},
 	{0x040, 0x000c0004}, {0x800, 0x80040000},
 	{0x804, 0x00000001}, {0x808, 0x0000fc00},
@@ -448,7 +448,7 @@ static struct rtl8xxxu_reg32val rtl8188ru_phy_1t_highpa_table[] = {
 	{0xffff, 0xffffffff},
 };
 
-static struct rtl8xxxu_reg32val rtl8xxx_agc_standard_table[] = {
+static const struct rtl8xxxu_reg32val rtl8xxx_agc_standard_table[] = {
 	{0xc78, 0x7b000001}, {0xc78, 0x7b010001},
 	{0xc78, 0x7b020001}, {0xc78, 0x7b030001},
 	{0xc78, 0x7b040001}, {0xc78, 0x7b050001},
@@ -532,7 +532,7 @@ static struct rtl8xxxu_reg32val rtl8xxx_agc_standard_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_reg32val rtl8xxx_agc_highpa_table[] = {
+static const struct rtl8xxxu_reg32val rtl8xxx_agc_highpa_table[] = {
 	{0xc78, 0x7b000001}, {0xc78, 0x7b010001},
 	{0xc78, 0x7b020001}, {0xc78, 0x7b030001},
 	{0xc78, 0x7b040001}, {0xc78, 0x7b050001},
@@ -616,7 +616,7 @@ static struct rtl8xxxu_reg32val rtl8xxx_agc_highpa_table[] = {
 	{0xffff, 0xffffffff}
 };
 
-static struct rtl8xxxu_rfregs rtl8xxxu_rfregs[] = {
+static const struct rtl8xxxu_rfregs rtl8xxxu_rfregs[] = {
 	{	/* RF_A */
 		.hssiparm1 = REG_FPGA0_XA_HSSI_PARM1,
 		.hssiparm2 = REG_FPGA0_XA_HSSI_PARM2,
@@ -2173,7 +2173,7 @@ void rtl8xxxu_firmware_self_reset(struct rtl8xxxu_priv *priv)
 static int
 rtl8xxxu_init_mac(struct rtl8xxxu_priv *priv)
 {
-	struct rtl8xxxu_reg8val *array = priv->fops->mactable;
+	const struct rtl8xxxu_reg8val *array = priv->fops->mactable;
 	int i, ret;
 	u16 reg;
 	u8 val;
@@ -2203,7 +2203,7 @@ rtl8xxxu_init_mac(struct rtl8xxxu_priv *priv)
 }
 
 int rtl8xxxu_init_phy_regs(struct rtl8xxxu_priv *priv,
-			   struct rtl8xxxu_reg32val *array)
+			   const struct rtl8xxxu_reg32val *array)
 {
 	int i, ret;
 	u16 reg;
@@ -2368,7 +2368,7 @@ static int rtl8xxxu_init_phy_bb(struct rtl8xxxu_priv *priv)
 }
 
 static int rtl8xxxu_init_rf_regs(struct rtl8xxxu_priv *priv,
-				 struct rtl8xxxu_rfregval *array,
+				 const struct rtl8xxxu_rfregval *array,
 				 enum rtl8xxxu_rfpath path)
 {
 	int i, ret;
@@ -2416,7 +2416,7 @@ static int rtl8xxxu_init_rf_regs(struct rtl8xxxu_priv *priv,
 }
 
 int rtl8xxxu_init_phy_rf(struct rtl8xxxu_priv *priv,
-			 struct rtl8xxxu_rfregval *table,
+			 const struct rtl8xxxu_rfregval *table,
 			 enum rtl8xxxu_rfpath path)
 {
 	u32 val32;
-- 
2.37.2
