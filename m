Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F561535A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 21:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKAUdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAUdy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 16:33:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F88E5A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 13:33:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n12so39932911eja.11
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rbUo0Aplg90H6Xa4J4YshSzIWNNGZpQq057VJI7ZrU=;
        b=QP88xRNkQaaq6mi7L+CXdA2kRc/R3iacnEFDtPA++WK/kYwNYEiRUW5v6gA2PBk4yp
         S3rIjrSApaARbYZD4h0ywgrFZ4hw9drEbV+ZcpL2Pax6Tk1xlvRAcdZGMhYZ08bqHm2S
         mCRAQEIMtBsmLrUPlraQAcAafWZ36db4hgnJcf120lVm2hPcg9xAe8qyT2EXlqmiHHQs
         yCkd3dcfDqEjroH1NLhVM2wpXApTe1qRRTKmTvpwxoJDEbnb/QydOavwe8HHGTX9v1lO
         +OOoSXxhU9OZJc4Xq56HAJeRY+8oCIekU3raeLjY/yQnBlUID82VVCyy7uFURr2PiHoB
         G6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rbUo0Aplg90H6Xa4J4YshSzIWNNGZpQq057VJI7ZrU=;
        b=CrGlviOXkVEDTUYDuxlH4GBV+X46CXTjryquvmltDMVKrzvIrrDkXHtwZWzOlrzcNW
         fZTcKQ22kYRFIcKPH8ZLi/aj175KLJ0RRQarDTd97tslXIB6rVyi15tFjI/GRzCtd9Qr
         LOoWPK93hlCg7hdpjLHwC4dm/C8iUT6iYpJSEZSpm1ZrjWwSn6JggcfS/Xfda4+LKD5h
         4zQPmifdEAyAJIPtpVv3xTAptnGtnMjBDc8QozDMRHGO4uhWA2Pbd2/XkKOTQSSdzb5z
         E+oRVgyYXP4FyLikp+JpBjR6gl6+ubCieVZA45/EVIJAl1fD1TInQIWFrMrISlMJbfVd
         2tjg==
X-Gm-Message-State: ACrzQf0aGAaBrxOmgzqbWbdCsWR4nM4F9LoBVfovfpakJLFRHLNxbFay
        o/iLqoMqX5EjnmAHpB3Nv8RWQwB16Ww=
X-Google-Smtp-Source: AMsMyM4jY3qTPpJv0nW/3OgBNcw/DIng9ul6y2JmYRLkLOchY5hza4ah80xCmPVYMhggyw6khKceZw==
X-Received: by 2002:a17:907:2bf9:b0:7a4:bbce:dd98 with SMTP id gv57-20020a1709072bf900b007a4bbcedd98mr20681339ejc.669.1667334831716;
        Tue, 01 Nov 2022 13:33:51 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id f30-20020a170906739e00b0078e05db7005sm4520858ejl.214.2022.11.01.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:33:51 -0700 (PDT)
Message-ID: <1559c705-0b0b-8dcb-7596-fbb85844d3d9@gmail.com>
Date:   Tue, 1 Nov 2022 22:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
In-Reply-To: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
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
v4:
 - Rebased on top of wireless-next.
 
v3:
 - No change.
 
v2:
 - Suggestion from Ping-Ke Shih:
   - Don't use array of letters.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 ++++---------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 51cb22ee55cd..823e50811b0d 100644
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
