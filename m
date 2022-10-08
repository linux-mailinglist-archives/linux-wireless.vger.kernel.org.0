Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A25F84D6
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJHK4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Oct 2022 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHK4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Oct 2022 06:56:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B6046638
        for <linux-wireless@vger.kernel.org>; Sat,  8 Oct 2022 03:56:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sc25so9935972ejc.12
        for <linux-wireless@vger.kernel.org>; Sat, 08 Oct 2022 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVJ5B6wu3UadmrvFdRCi3/DB1Qu041B0YNDIMREFVBw=;
        b=STCnuMGu/XeIrH2cv/PlwptDSYL2o6FLhI61aRvr5lyfMlK5CcvH3fP6bGt7hrJQDy
         FhR8NC6wmRHbGfpDC6+LTOvAfh51cu4ydqIbxOtjbre3q48Z1UsYMuzBJffapHlA2jEW
         ookDAMRPUmnViJuvPNrHu9QaCROvJbvLygrVJoPI+9Q5pcu1ARlSKh1nCYI5jDlRtfLs
         J1NRo47byFBorlsj8lwp8l0vc/m/mfKwqY618qk3WNmOeMAD2QL0AyrxB6QZGnwy4nIB
         fcPEiLz1gbuUfzGtGLw+oW2QcZ+yQLdf7j6LgCsdnUVscuihuVlHnfDXYyZapgxvDaVl
         lSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVJ5B6wu3UadmrvFdRCi3/DB1Qu041B0YNDIMREFVBw=;
        b=ykFlso84t4omY7xkaDBTP9v6aCH+0oEeo9ExtOxLS90h7STh/3AjbIFHDm3FlrUo7H
         VZRKhPXGix/Y7nrKKj8fG/BhbaIjcchKQQUT19EwaadQSqAxg2Ja0TSLtfBIbBBRCNh0
         uJUhbb6u2aEorUwgMZb4zOjhSrwFrQ8g1NSS1+zxP9ylgNRiwHI+5w4B+7sMVb3LyWss
         J8kmg7vBBtoJOT3ENKvgj0oSLsxCNVw4TIh9k5cCYLtawIpZ/o2qZKMWEaFrf7za1So0
         5+Lp3/M7mzttSOrkttGlF9ktOPMFihqtTOeYH4p6kMEsU5KYZfx8bzfV0Iwg02kMnzsc
         589A==
X-Gm-Message-State: ACrzQf0l8wZEBmhxEfKt4V2+z1HTBSRn95FObub3SvHd7Lzxe0ACr5kT
        YlfP/65bjy3AQQ22bPWqr/ulCUrZe0Y=
X-Google-Smtp-Source: AMsMyM5Vh5oHzGlC/ut5GtsNeSOyiIrXxNfR898bCKGcefkVFuH99E/OzquP4wzKC3xBoa0lDQ96iQ==
X-Received: by 2002:a17:906:730a:b0:78d:403c:8dd9 with SMTP id di10-20020a170906730a00b0078d403c8dd9mr7440845ejc.47.1665226570541;
        Sat, 08 Oct 2022 03:56:10 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b0073ddff7e432sm2638951ejo.14.2022.10.08.03.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 03:56:10 -0700 (PDT)
Message-ID: <24af8024-2f07-552b-93d8-38823d8e3cb0@gmail.com>
Date:   Sat, 8 Oct 2022 13:56:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 2/3] wifi: rtl8xxxu: Fix reading the vendor of combo chips
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
In-Reply-To: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
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

The wifi + bluetooth combo chips (RTL8723AU and RTL8723BU) read the
chip vendor from the wrong register because the val32 variable gets
overwritten. Add one more variable to avoid this.

This had no real effect on RTL8723BU. It may have had an effect on
RTL8723AU.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 8b640b1237b5..33a8ee545113 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1610,13 +1610,13 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 	const struct usb_device_descriptor *descriptor = &priv->udev->descriptor;
 	struct device *dev = &priv->udev->dev;
 	struct ieee80211_hw *hw = priv->hw;
-	u32 val32, bonding;
+	u32 val32, bonding, sys_cfg;
 	u16 val16;
 
-	val32 = rtl8xxxu_read32(priv, REG_SYS_CFG);
-	priv->chip_cut = (val32 & SYS_CFG_CHIP_VERSION_MASK) >>
+	sys_cfg = rtl8xxxu_read32(priv, REG_SYS_CFG);
+	priv->chip_cut = (sys_cfg & SYS_CFG_CHIP_VERSION_MASK) >>
 		SYS_CFG_CHIP_VERSION_SHIFT;
-	if (val32 & SYS_CFG_TRP_VAUX_EN) {
+	if (sys_cfg & SYS_CFG_TRP_VAUX_EN) {
 		dev_info(dev, "Unsupported test chip\n");
 		return -ENOTSUPP;
 	}
@@ -1632,7 +1632,7 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 		goto skip_complicated_chip_detection;
 	}
 
-	if (val32 & SYS_CFG_BT_FUNC) {
+	if (sys_cfg & SYS_CFG_BT_FUNC) {
 		if (priv->chip_cut >= 3) {
 			sprintf(priv->chip_name, "8723BU");
 			priv->rtl_chip = RTL8723B;
@@ -1654,7 +1654,7 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 		if (val32 & MULTI_GPS_FUNC_EN)
 			priv->has_gps = 1;
 		priv->is_multi_func = 1;
-	} else if (val32 & SYS_CFG_TYPE_ID) {
+	} else if (sys_cfg & SYS_CFG_TYPE_ID) {
 		bonding = rtl8xxxu_read32(priv, REG_HPON_FSM);
 		bonding &= HPON_FSM_BONDING_MASK;
 		if (priv->fops->tx_desc_size ==
@@ -1708,7 +1708,7 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 	case RTL8188F:
 	case RTL8192E:
 	case RTL8723B:
-		switch (val32 & SYS_CFG_VENDOR_EXT_MASK) {
+		switch (sys_cfg & SYS_CFG_VENDOR_EXT_MASK) {
 		case SYS_CFG_VENDOR_ID_TSMC:
 			sprintf(priv->chip_vendor, "TSMC");
 			break;
@@ -1725,7 +1725,7 @@ static int rtl8xxxu_identify_chip(struct rtl8xxxu_priv *priv)
 		}
 		break;
 	default:
-		if (val32 & SYS_CFG_VENDOR_ID) {
+		if (sys_cfg & SYS_CFG_VENDOR_ID) {
 			sprintf(priv->chip_vendor, "UMC");
 			priv->vendor_umc = 1;
 		} else {
-- 
2.37.2
