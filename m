Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCE61535C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKAUfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKAUfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 16:35:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F5101DE
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 13:35:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w14so21692435wru.8
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Gq3bdsDsxpSqZIIEkC5NrsUctQcAb4lvn0k1trEJf0=;
        b=Bo366EaWhlb/8e0q983H7Wmt77/fuvPC+0I4zB8GELAdclPq7IhuTetFjcTRzwtQG9
         75EEIucbcfZgCUWOyg5Wa7TyVRydWOXI8Xv0pjr0ccPrlKE8TSIc8LvK2H4vo+Ls2glw
         GxwIaAd6gym1IT8PiMaF1BgYXUqRQplqAmZM7/DIuHQSb8PLTXfMwPQugKV4ixHj1k5j
         6bmlk89Z+YKoITSDvx50uk4e01T1dom1vn0Jfmd2i0ccI+J8FGvB5e3yFtxNlIBwIGdW
         RuoPpo7bTkDe084H9UE8ptGLRtbrHe/clk92XDoK5MrZF10ZQ0/PRCxglFwA1hq0tCVX
         g+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gq3bdsDsxpSqZIIEkC5NrsUctQcAb4lvn0k1trEJf0=;
        b=SUBVeM9o9JjSFqYJuV6kmxZojoXvIPXioS2R+V6JKZ8LEEL+xnVG4NWDKMosfxe5d4
         ogZ3JE0VYunXpNAS4yCz+dz+yXm+uzsyxdB8LrfvKt7/sioFQnbQfXi4fO8Uv/Ew6yzv
         L17rhHsma8lVhi0xBVrumscBWcQ95MKFDmABTfVG8UEo2BwD9SebB4DNKudhwntjaBAu
         3EUP/dDbzYHlEJvW6RcEyElvMxdr6V9kZqccoqltkERRFyrNsZiq3UYyvB5eDzVJgnrp
         /BLaIlS1pJnVAOWis9jgnWG8DXzTbF1CaQctakTpJfARsDws8jfqRQoDdUa1uicI7152
         uIXg==
X-Gm-Message-State: ACrzQf3TgZaIePUGmD37TOt9ehlevxjYyJeTTpDcSh3h1DIcp+gSAEA+
        BT9h6U9t9cn0lKDAxBC1nzav8fg/+C4=
X-Google-Smtp-Source: AMsMyM45InQNmwPrC0egiwh964cI7eZ+zNp67m7rgzZwb/POJ4PkiUbcOp6RWXd5nBPMKGW94NC5qg==
X-Received: by 2002:adf:e792:0:b0:236:604f:1330 with SMTP id n18-20020adfe792000000b00236604f1330mr142633wrm.373.1667334937886;
        Tue, 01 Nov 2022 13:35:37 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b003c6bbe910fdsm13362557wmb.9.2022.11.01.13.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:35:37 -0700 (PDT)
Message-ID: <c9f3ebb2-769b-7d80-cac2-5a9d1bcc010a@gmail.com>
Date:   Tue, 1 Nov 2022 22:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 5/5] wifi: rtl8xxxu: Use dev_* instead of pr_info
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

Replace two instances of bare pr_info with dev_info and dev_warn.

Also make their messages a little more informative.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Rebased on top of wireless-next.
 - Feedback from Kalle Valo:
   - Change one dev_info into dev_warn.
 
v3:
 - No change.
 
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 58e6416787df..019f8ddd418b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -2015,7 +2015,8 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 
 	val8 = rtl8xxxu_read8(priv, REG_MCU_FW_DL);
 	if (val8 & MCU_FW_RAM_SEL) {
-		pr_info("do the RAM reset\n");
+		dev_info(&priv->udev->dev,
+			 "Firmware is already running, resetting the MCU.\n");
 		rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
 		priv->fops->reset_8051(priv);
 	}
@@ -5413,7 +5414,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
 			rtl8xxxu_queue_rx_urb(priv, rx_urb);
 			break;
 		default:
-			pr_info("failed to requeue urb %i\n", ret);
+			dev_warn(&priv->udev->dev,
+				 "failed to requeue urb with error %i\n", ret);
 			skb = (struct sk_buff *)rx_urb->urb.context;
 			dev_kfree_skb(skb);
 			usb_free_urb(&rx_urb->urb);
-- 
2.38.0
