Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6F60BD81
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 00:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiJXWf4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiJXWfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 18:35:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713E9638E
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:58:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so10502925wmr.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=302KGUriB18bOlCw7uWI8DGaJWWMh7Gj1UrQAJeI57c=;
        b=QHNKQvqY1KPdm5w9bCtltSV7u6Rnjw8QsjYHtAv7Xjvzt7uZPMNqR6aknD0LrzdW0Y
         Uulpzndkxt/H/jl3jLFu8pTnw5SYKVVqsB5r9UlYA2NTxCLX+6m2iKLKQuG8OEJnX5d+
         ZLEhKo+u4wXmn/Ke+meeeEEW5s35kEg7FTWgruPs15fGPNkteG5wnxH6zTqN/ReCnRbv
         2hqnRGOFW3m4REzSzX7Ks6x010GzKP98DaSxwZldClzaEFV9SU8wprmKkkC3YaFxnpJS
         KqKTbfBAwwi438uuX0RoqeuFKgl7w2HNwyMToJ8zbvFFjTpi7V7DBlt+2Uydkcpq4SD0
         JQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=302KGUriB18bOlCw7uWI8DGaJWWMh7Gj1UrQAJeI57c=;
        b=BS+nyv1snNPNjyZSIju4MHmXfFW0q/00HPxbRUfwCiI4Hj8TmndIqxa6O1GZimz69t
         RVWvPpw2px3yawaJT0cOxmUjFSgoSSof1o1OrBF6CvaFN0dFNZuaUGSXlJFRPMNfTamF
         0wK6XByVdOTfx4aRsUsgsSUo5kjm87D8QPMTJGI9TJtoTKLs6WBw7LDrmrCZVxiMMcyz
         mKFWgNer85s+2I0iMF4g/VGsmtOaIjVozreRBFdv+SaiH8ZBIRVVcmn3UVRqxKPT4Q0j
         QeS+8oSK+9wKzRSXICfXZHEjpMUXtXK9JV/C6/3YrwXNTMqvszDYyG80yuNyvWvf7EXw
         Ohyw==
X-Gm-Message-State: ACrzQf3wVm5fQ23gPoV4575HvazddyGXTNMVL6vwv40V6+R06eLKLJ4M
        toFkzi1jRxCn2NBAS4ZG9zh3acAJVS4=
X-Google-Smtp-Source: AMsMyM6LrW/bPjsWs1PPc36zz5ItktBjxYW1vFu7PIf3ynQLJ3SyFPBoetteqnnc069BAXMcL9G/Iw==
X-Received: by 2002:a05:600c:654f:b0:3c3:b5b7:43a9 with SMTP id dn15-20020a05600c654f00b003c3b5b743a9mr45530303wmb.201.1666645014215;
        Mon, 24 Oct 2022 13:56:54 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003c6f8d30e40sm9859375wmq.31.2022.10.24.13.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:56:53 -0700 (PDT)
Message-ID: <92f365c5-ff7c-33b0-60c9-f2c1492fba0a@gmail.com>
Date:   Mon, 24 Oct 2022 23:56:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
In-Reply-To: <1edda764-94ca-2123-0ba6-6b04a1b01709@gmail.com>
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
v2:
 - Suggestion from Ping-Ke Shih:
   - Don't use array of letters.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 ++++---------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7023f6accda7..7c587b5d554e 100644
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
