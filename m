Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6040B6243C2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 14:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKJN7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 08:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKJN7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 08:59:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3821C19C19
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:59:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u24so3163906edd.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5qrvMRjYp2MjZ83UWi9SzdbxwdoJBFIb7DywDX9xjk=;
        b=eBFtLrjrnKJZZ+CDUDYOIIQ7Tmg5QJTgOigUxEWxh6f+kstic4ACCfZMblFFph00T4
         E9qFzz+6V0vDzM5mf67lAutRQHlWcM+pLJQ2+lfiZtLnO96KM+HPsGGN6kn6U/l8nswx
         SYCETknz+FthPx7v4yQY9zkoUs/1tZWVAxM1wYlbDo0dfLURKClEgYrKZJ6as3GRu2xx
         yqiNdNPPsi4EM27YWTpurXiL4E0RjsC4bhJ5SqXvyEUNProDVbJcG690lKzzy8ELXvqf
         dGHJ3OuBCXPqoiDG3wohMhR8v38bh4koHprPwuWVL6jmo1Fu+BwztMT53zwTP7/cp72j
         o9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5qrvMRjYp2MjZ83UWi9SzdbxwdoJBFIb7DywDX9xjk=;
        b=nWuMgyEUcHpw97EaJW6V6GMbbFBSYkBf3Fadvu697/TtlDtLso4mxRtQnbl3cm/9WU
         WVSuIX0z/7UDJOwmgK1OtNeRIDlctCrkcJ24odnzdM5Yg7w3Fr3mMtna+riAd5qTQnfH
         vWFlMylHxsPRjpygMJdP1QhdPjlyVr+y+ZKdAGpOcDW1GpSuRaj/AaG2AeGO9SejN7Yz
         ypIVRxjjJqm9llNkuQYmTosZyui1kZlSPtWG47PmDpnwAYhYQltVZxhOSkyzqTODu26B
         a8hjmo8bdp8jPn8Z4UTwV4jhoS1CwPvDVBTdcLLVMN+AXpoW7B56mlSja+atK+Wr21+s
         lT4w==
X-Gm-Message-State: ACrzQf2hCfuE5n2uHPlPYcdgyCaDbhhJWaqYXZFKYDs6v16vbvvX4nB3
        b7bCvrF777Dg3KRbH0c4Wqj4JOTuaUQ=
X-Google-Smtp-Source: AMsMyM5ggRy4g1IqCuWJ5TyvBCqFARmMSdlu1IltKlrclubUT4Pc3w8zzlffsu6KFG3xTGESsIs8nw==
X-Received: by 2002:a05:6402:22a5:b0:462:b393:f281 with SMTP id cx5-20020a05640222a500b00462b393f281mr63684721edb.379.1668088770615;
        Thu, 10 Nov 2022 05:59:30 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00730bfe6adc4sm7269873ejt.37.2022.11.10.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:59:30 -0800 (PST)
Message-ID: <5fc9cc0e-eecb-8428-aeb1-f745791c0f16@gmail.com>
Date:   Thu, 10 Nov 2022 15:59:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
In-Reply-To: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
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

Fill priv->chip_name and priv->chip_vendor with strscpy instead of
sprintf. This is just to prevent future bugs in case the name of a
chip/vendor becomes longer than the size of chip_name/chip_vendor.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c   |  2 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c   |  8 ++++----
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c   |  4 ++--
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c   |  2 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c   |  2 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++------
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 0f77312dd0ca..ef38891ddbd1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -327,7 +327,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
 	u32 sys_cfg, vendor;
 	int ret = 0;
 
-	sprintf(priv->chip_name, "8188FU");
+	strscpy(priv->chip_name, "8188FU", sizeof(priv->chip_name));
 	priv->rtl_chip = RTL8188F;
 	priv->rf_paths = 1;
 	priv->rx_paths = 1;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index 815c1e278e4e..6c443e4822d8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -345,12 +345,12 @@ int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
 		bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
 		bonding &= HPON_FSM_BONDING_MASK;
 		if (bonding == HPON_FSM_BONDING_1T2R) {
-			sprintf(priv->chip_name, "8191CU");
+			strscpy(priv->chip_name, "8191CU", sizeof(priv->chip_name));
 			priv->tx_paths = 1;
 			priv->usb_interrupts = 1;
 			priv->rtl_chip = RTL8191C;
 		} else {
-			sprintf(priv->chip_name, "8192CU");
+			strscpy(priv->chip_name, "8192CU", sizeof(priv->chip_name));
 			priv->tx_paths = 2;
 			priv->usb_interrupts = 0;
 			priv->rtl_chip = RTL8192C;
@@ -358,7 +358,7 @@ int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
 		priv->rf_paths = 2;
 		priv->rx_paths = 2;
 	} else {
-		sprintf(priv->chip_name, "8188CU");
+		strscpy(priv->chip_name, "8188CU", sizeof(priv->chip_name));
 		priv->rf_paths = 1;
 		priv->rx_paths = 1;
 		priv->tx_paths = 1;
@@ -451,7 +451,7 @@ static int rtl8192cu_parse_efuse(struct rtl8xxxu_priv *priv)
 	priv->power_base = &rtl8192c_power_base;
 
 	if (efuse->rf_regulatory & 0x20) {
-		sprintf(priv->chip_name, "8188RU");
+		strscpy(priv->chip_name, "8188RU", sizeof(priv->chip_name));
 		priv->rtl_chip = RTL8188R;
 		priv->hi_pa = 1;
 		priv->no_pape = 1;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 7a182073832b..fc3336f18892 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -496,11 +496,11 @@ int rtl8192eu_identify_chip(struct rtl8xxxu_priv *priv)
 	bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
 	bonding &= HPON_FSM_BONDING_MASK;
 	if (bonding == HPON_FSM_BONDING_1T2R) {
-		sprintf(priv->chip_name, "8191EU");
+		strscpy(priv->chip_name, "8191EU", sizeof(priv->chip_name));
 		priv->tx_paths = 1;
 		priv->rtl_chip = RTL8191E;
 	} else {
-		sprintf(priv->chip_name, "8192EU");
+		strscpy(priv->chip_name, "8192EU", sizeof(priv->chip_name));
 		priv->tx_paths = 2;
 		priv->rtl_chip = RTL8192E;
 	}
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 33a1114a5853..c8ab71ed4ff4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -144,7 +144,7 @@ static int rtl8723au_identify_chip(struct rtl8xxxu_priv *priv)
 		goto out;
 	}
 
-	sprintf(priv->chip_name, "8723AU");
+	strscpy(priv->chip_name, "8723AU", sizeof(priv->chip_name));
 	priv->usb_interrupts = 1;
 	priv->rtl_chip = RTL8723A;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 558572bdd2c8..ece82e613bf0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -319,7 +319,7 @@ static int rtl8723bu_identify_chip(struct rtl8xxxu_priv *priv)
 		goto out;
 	}
 
-	sprintf(priv->chip_name, "8723BU");
+	strscpy(priv->chip_name, "8723BU", sizeof(priv->chip_name));
 	priv->rtl_chip = RTL8723B;
 	priv->rf_paths = 1;
 	priv->rx_paths = 1;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index e4eb17d03cd7..e8fcd531c437 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1592,10 +1592,10 @@ static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 void rtl8xxxu_identify_vendor_1bit(struct rtl8xxxu_priv *priv, u32 vendor)
 {
 	if (vendor) {
-		sprintf(priv->chip_vendor, "UMC");
+		strscpy(priv->chip_vendor, "UMC", sizeof(priv->chip_vendor));
 		priv->vendor_umc = 1;
 	} else {
-		sprintf(priv->chip_vendor, "TSMC");
+		strscpy(priv->chip_vendor, "TSMC", sizeof(priv->chip_vendor));
 	}
 }
 
@@ -1603,18 +1603,18 @@ void rtl8xxxu_identify_vendor_2bits(struct rtl8xxxu_priv *priv, u32 vendor)
 {
 	switch (vendor) {
 	case SYS_CFG_VENDOR_ID_TSMC:
-		sprintf(priv->chip_vendor, "TSMC");
+		strscpy(priv->chip_vendor, "TSMC", sizeof(priv->chip_vendor));
 		break;
 	case SYS_CFG_VENDOR_ID_SMIC:
-		sprintf(priv->chip_vendor, "SMIC");
+		strscpy(priv->chip_vendor, "SMIC", sizeof(priv->chip_vendor));
 		priv->vendor_smic = 1;
 		break;
 	case SYS_CFG_VENDOR_ID_UMC:
-		sprintf(priv->chip_vendor, "UMC");
+		strscpy(priv->chip_vendor, "UMC", sizeof(priv->chip_vendor));
 		priv->vendor_umc = 1;
 		break;
 	default:
-		sprintf(priv->chip_vendor, "unknown");
+		strscpy(priv->chip_vendor, "unknown", sizeof(priv->chip_vendor));
 	}
 }
 
-- 
2.38.0
