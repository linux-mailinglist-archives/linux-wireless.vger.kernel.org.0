Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633F61179E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ1Qhh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJ1QhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 12:37:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42941F8117
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:37:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so14160626eje.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xmdTqSBwriJgg2L/zL+fFUQwTpdbdl03jPfPFDBTes=;
        b=JGiSdKBgBzGSp0EHplZSoTjsV70mM591LCQcI7FZVeEpC264C4YkHl8aTJVsM8sYtt
         +H7GpO+pLD2I/vGyac2wAVmuU2tYX1Q+Jl3K9+b1KGyKKvNUk1icEVPTRYYvnRYj/sKq
         bCen/dsZmJevo3DnlWEYki/8Yg52pG3hSK2VCHsO5o1J4rPqe2EcTa4/PE3DUda+xaKM
         IZLOA1F6aSoGejecJhY43aegRaYl+83SBqcFpn+HTuWy/LfhQaVdLxx0Qt/ziz1EUswl
         V39uz2BdGDjtp43oEuIu13BZd6epa2AitNE2XCIl9wVKku5rhkmCiGdveKiMfYpH059N
         ErcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xmdTqSBwriJgg2L/zL+fFUQwTpdbdl03jPfPFDBTes=;
        b=xlzOSOVZ0wezDiyl+zBEYi0DgpS3pxRAgUbYi1z+whlZ3Gj6VUAMBkHrz0I57cf0tb
         0ASSvQ4cP/xidztXW00YydHLwYs5gqmJaV8UeV5sMhuu8DPC3zBIFFfRZPQxaUzLssMh
         a63oQBw+9Pn3i7Uhhf3I3X5/oKAjIrMrSqc9cH97O7/tPCB6hbxGyeZ1YfsG7any7FZL
         6j/wTAqz7LBSVuDe1Bp97FmQGM+hM0AVRpdHWdkxvuar6ocQ37DWGOWF/v/YKtqxbDSz
         pc52dSPAjCeUaYmI1VehJ6nwihe6MuWM7sbfvmpXOUNtGQJhD+3FaOAAAt6kBAt4cWXP
         Z0ow==
X-Gm-Message-State: ACrzQf2mRegIGm358RSkjsUjITWLDg2FzeFXgqWVuyeZg64Kr6OxtuH3
        ymVFoIhauJV5Pbbvf1w3yXz2qsfUyoY=
X-Google-Smtp-Source: AMsMyM7Y3qhc8QTzPDS9l0JSMsFDX9cS+2SlqRW3ailXMpNxfN+yXgHaRVl3buSD9mxtaPbHj6iwjw==
X-Received: by 2002:a17:907:728e:b0:78d:f5c2:70d3 with SMTP id dt14-20020a170907728e00b0078df5c270d3mr190714ejc.506.1666975026215;
        Fri, 28 Oct 2022 09:37:06 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906474200b0073c10031dc9sm2367802ejs.80.2022.10.28.09.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:37:05 -0700 (PDT)
Message-ID: <bded398b-322d-0e70-c058-62b1a6115bed@gmail.com>
Date:   Fri, 28 Oct 2022 19:37:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
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

The chip cut, also known as the chip version, is a letter from A (0)
to P (15). Recognise them all instead of printing "unknown" when it's
greater than E.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.
 
v2:
 - Suggestion from Ping-Ke Shih:
   - Don't use array of letters.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 ++++---------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 861c33a6d7f9..64062f18a5a0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1574,30 +1574,14 @@ rtl8xxxu_set_spec_sifs(struct rtl8xxxu_priv *priv, u16 cck, u16 ofdm)
 static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
-	char *cut;
+	char cut = '?';
 
-	switch (priv->chip_cut) {
-	case 0:
-		cut = "A";
-		break;
-	case 1:
-		cut = "B";
-		break;
-	case 2:
-		cut = "C";
-		break;
-	case 3:
-		cut = "D";
-		break;
-	case 4:
-		cut = "E";
-		break;
-	default:
-		cut = "unknown";
-	}
+	/* Currently always true: chip_cut is 4 bits. */
+	if (priv->chip_cut <= 15)
+		cut = 'A' + priv->chip_cut;
 
 	dev_info(dev,
-		 "RTL%s rev %s (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
+		 "RTL%s rev %c (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
 		 priv->chip_name, cut, priv->chip_vendor, priv->tx_paths,
 		 priv->rx_paths, priv->ep_tx_count, priv->has_wifi,
 		 priv->has_bluetooth, priv->has_gps, priv->hi_pa);
-- 
2.38.0
