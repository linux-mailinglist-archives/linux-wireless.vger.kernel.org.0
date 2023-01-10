Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23525664515
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjAJPlv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjAJPlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 10:41:47 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B611AD98
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 07:41:46 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fy8so29632798ejc.13
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S0PGqXFKksi2Doprlka03QKocY/2FcAHAXJYc0T+BY=;
        b=KoClTt+kW9zIoNJn7Lu1nRrEfD48GXN8zndPM/j0Of2YP6fHnUbPghnsmvk/ngVAF3
         7w8eA3iQnFm675p52QwBp7GKHnmQQduP6EfwOtpPyWklnKY0qsMUqp2eQGQaZeCKsiD8
         lXXUyPko1PzrZ6Bh7wMzG5KvPuEXTuHPyV5XrTv0dAqsE4WneYJX4dlxdYqOO3lbD1H8
         sw1eV4jGbc+lfN57zJ/fqNaJH476h3bf0+1vml3XjpCK4ojhCeY137EsYvGGgDL4/suN
         aChkw61fDnfS49YCxI0JTegzR4nD/NRqiOohaPqCYVLTamSKmSRwmWvDFriLMOafzAv9
         fEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/S0PGqXFKksi2Doprlka03QKocY/2FcAHAXJYc0T+BY=;
        b=um1vrHl+q7iuWDtzqEqXzt1+yi/LY617j9gQGx4FZ4qOd0CzKRsrUUAt2A/zatHLrw
         YJwComQKQX00epmtF1AEv2kiR7Aub4g29wyYMHqr+rLjMWShGTi6SOwFShblf5WzGHHX
         GVVo5L47Up2wbb4icE1nNwvDVxqStVZvukNj2vl/WVIbWALb49VLas3kp8IK11/2VFjQ
         lsl5TtqUmg18NJejRR8hkkJdSiqfGFkrgIiIgKI/daWTCKqVLQZMeyzuwO3M3EJwPu3t
         dH27GckzjL7SjaTW95EaDIqAXf4+Oo7+URgNYJNmlrqXQz2qnNIjXfLqy0JIgqyRq3dl
         rmLg==
X-Gm-Message-State: AFqh2kq+PZUylbVZGLeS9nMok8CX6rbJC/AwSJqnrWDRZdySXfh7i3s4
        85Ke4Ma+u0hhk07UFAwMHd/7qna/KK4=
X-Google-Smtp-Source: AMrXdXs7mREFT2yskvQp9Y2cbzAIXIKgMvODjgY8wUx3CmAfyhdFFF9FSnwSVuGpNCj2Ia3NhlC6fA==
X-Received: by 2002:a17:906:524b:b0:7c1:5098:907f with SMTP id y11-20020a170906524b00b007c15098907fmr58425586ejm.61.1673365304588;
        Tue, 10 Jan 2023 07:41:44 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090699ca00b0084d43100f19sm3095916ejn.89.2023.01.10.07.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:41:44 -0800 (PST)
Message-ID: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
Date:   Tue, 10 Jan 2023 17:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtl8xxxu: Print the ROM version too
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

Make rtl8xxxu_print_chipinfo() print the ROM version. This is relevant
at least for the RTL8723AU and possibly relevant for the RTL8710BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd97c040948a..d521435e1c07 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1582,10 +1582,11 @@ static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 		cut = 'A' + priv->chip_cut;
 
 	dev_info(dev,
-		 "RTL%s rev %c (%s) %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
-		 priv->chip_name, cut, priv->chip_vendor, priv->tx_paths,
-		 priv->rx_paths, priv->ep_tx_count, priv->has_wifi,
-		 priv->has_bluetooth, priv->has_gps, priv->hi_pa);
+		 "RTL%s rev %c (%s) romver %d, %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
+		 priv->chip_name, cut, priv->chip_vendor, priv->rom_rev,
+		 priv->tx_paths, priv->rx_paths, priv->ep_tx_count,
+		 priv->has_wifi, priv->has_bluetooth, priv->has_gps,
+		 priv->hi_pa);
 
 	dev_info(dev, "RTL%s MAC: %pM\n", priv->chip_name, priv->mac_addr);
 }
-- 
2.38.0
