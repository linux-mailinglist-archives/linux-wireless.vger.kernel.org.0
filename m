Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E676621C8E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 19:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKHS4b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKHS4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 13:56:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524816A682
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 10:56:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t25so41006907ejb.8
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2btLF8jbiCminjKUScT17x40EjHZF8d0H12GZhCjv6A=;
        b=mGveFu752j7HsymORU4PtaGhhqd6y7vQzXXOk6sEO/0cEbv8Kw9E9D8eMPSQM1J9y5
         GMobLGO3DuQ0Yag37bCviVTyFTyVyeqK/zo+t/1AuPUQKlk0MBggwIoxs50Ik8wB8RCQ
         D65Lk0KTq4tSrAyyyufyEWQFnvdWM4wHFIN0ScA34FHg1Zz46wJ13CXtuSNLVV4SwUs0
         vIGPuhzkdJTfgHKPg4hIMa9xHQxPLbrXpvYTSDZA3abrIDKOTxZ010oaQclXL/QJvXgk
         +ZGJ09xlT4PRqJgQySM2Y1RbGJNtA6cRi2LkM+ZEfvqMkcKtmqjQJ/r9Qsi42chdvbKl
         lG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2btLF8jbiCminjKUScT17x40EjHZF8d0H12GZhCjv6A=;
        b=GSIHJtU2ji76VoPH2XmMmwTljRgXkWiAM4OJOWR3ILbk6D7U6NQ9sPqk8uPaXeUb7T
         IS9D+t9Vfs56QoqZgFEqGdn5dCVWWMGkZ3TBM/ctA+TA1G5xf17tJHu0Oy0YNSSGnmwL
         VmSFhAlnasl41A/3IBPSyjn+N3L7Gngd+zg5TaBV0D8fFTjaL/ICgkBu/REYeWlgo7TC
         rH535RcVRbsWsbKFfBLEh2t0gN+iAPYoCmWvjle+npA7XZPsBXsl1/P4oY8s+iXLuaSs
         BsUf11cFPchbb7BOxtdkekflQTfrOm5gQuoIfU2ji3/nZdnAgEzpV3xKrIR1irMaef50
         x5Ew==
X-Gm-Message-State: ACrzQf3tZdqNxwcl4C2H6dhUPqoV+gatWMkIIVbO4P77qQmKT9Z/ut7E
        tp45rOwvZwzskb1TizLeoO04GVvOVzc=
X-Google-Smtp-Source: AA0mqf6TCjDMBFpbg6PBxH1LMdWZ/nbrgA1s4VevI7KlIulUjSwdPpmLUmDNFpWWkDjggYaUN73oVw==
X-Received: by 2002:a17:907:162b:b0:7ae:4ed4:1503 with SMTP id hb43-20020a170907162b00b007ae4ed41503mr17539688ejc.485.1667933787709;
        Tue, 08 Nov 2022 10:56:27 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id la24-20020a170907781800b00770812e2394sm4950487ejc.160.2022.11.08.10.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:56:27 -0800 (PST)
Message-ID: <1db11152-efc1-2027-565a-a0373cccd117@gmail.com>
Date:   Tue, 8 Nov 2022 20:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/3] wifi: rtl8xxxu: Use strscpy instead of sprintf
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
In-Reply-To: <91f59414-86f7-f0ed-a138-19f0ab63bb0b@gmail.com>
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
This patch should be applied after my older patch:
"[PATCH v2 2/3] wifi: rtl8xxxu: Split up rtl8xxxu_identify_chip"
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
