Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD75600265
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Oct 2022 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJPR3o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Oct 2022 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJPR3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Oct 2022 13:29:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E5140EC
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:29:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so20335378ejr.2
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84YrzMdgD7pxeBiK4TEteGNtLOGIqh4JfD372CeCLgE=;
        b=B28zobae46h2v3zuuCOSKsrr/6yVwmw+N94urtJzdyWG6i0bwoCN0zEMhxUc0P++JK
         7hA785647FVdKniMVakzGApVuiukuqhSoDHgyFmRxcHnFemn3sUIOp1+P7Vrv59lw7vr
         qNzm4xNhta99uLL4rxzxmyp0FhCPU7hDs1H7uTUpnBMDoKA06zcGEW/j7cSTnIl8if5V
         U41Alu/f73UBz6924d8Y56SBcEXt0Fj2HSNzskEen8X/9trenmW6iU9QAAjfpWC9sbz7
         pLBOxipm8d+Ur/3hlhPsn0m4rKNwrQAWnkwl5Z07Roks1QJjC70mswGxB2BvQG4t4eqw
         M2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84YrzMdgD7pxeBiK4TEteGNtLOGIqh4JfD372CeCLgE=;
        b=T6qec81LTdjdOTxFTtybVj6iE0C7hCYHV+Bl4aD4mbJuycusOKgZGtYEyIvImi4OQb
         MRQChNdngNQ48pfNtGc99bn+V76i0NrnL/LgKrrvujblgtmIPYLuDd/NzNhHLQREeZLt
         ccpuD+vvy2aEB1FpkyI0UtGInv9tOtplrqL7wckcMO4pVPOr4LWsaGEXlEYd4EPlI5ki
         XjLb+1s/loRH4XMnYq/bsKnptZX1vrFU0HKfGMS9e6CmBFilKowwDWQaCX/n0wtB8qFy
         8/9POp9aImlUNb0AkfD5S9SiaLzDT+4Csci/PZzrR4d07USLMZiFUEG1ddt2A5IwvucJ
         YOPg==
X-Gm-Message-State: ACrzQf1pVBVQJ6DwKEiNOdQc7FgXhv21WbIs3R8KUhdScFIbg6SrD8F2
        vmkC+WxaAcTxkpKvA16UbhE2R8WSQTg=
X-Google-Smtp-Source: AMsMyM7PWbsgX4FSYPBftZ2qrPi33QyX3oAWprcScJ+TW7tyq1PI2ZHzp9tbNYUmdISZSjlKPdI1jw==
X-Received: by 2002:a17:906:9745:b0:78d:480f:cee7 with SMTP id o5-20020a170906974500b0078d480fcee7mr5796259ejy.192.1665941379791;
        Sun, 16 Oct 2022 10:29:39 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id v24-20020aa7d658000000b00458f82462a5sm5725978edr.25.2022.10.16.10.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 10:29:39 -0700 (PDT)
Message-ID: <f7239792-028f-77dc-a86d-f89e3eeafa7d@gmail.com>
Date:   Sun, 16 Oct 2022 20:29:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
In-Reply-To: <2b29b6d9-c17e-76d6-c32f-630f24b407b7@gmail.com>
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
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 27 +++++--------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 2efc99896b96..a8914650815e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1573,31 +1573,16 @@ rtl8xxxu_set_spec_sifs(struct rtl8xxxu_priv *priv, u16 cck, u16 ofdm)
 
 static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 {
+	static const char cuts[16] = "ABCDEFGHIJKLMNOP";
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
+		cut = cuts[priv->chip_cut];
 
 	dev_info(dev,
-		 "RTL%s rev %s (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
+		 "RTL%s rev %c (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
 		 priv->chip_name, cut, priv->chip_vendor, priv->tx_paths,
 		 priv->rx_paths, priv->ep_tx_count, priv->has_wifi,
 		 priv->has_bluetooth, priv->has_gps, priv->hi_pa);
-- 
2.38.0
