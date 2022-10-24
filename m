Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9860BD89
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiJXWh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJXWhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 18:37:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7531DC27
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 14:00:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy4so7867184ejc.5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSqvEurDGrNTOd41O70DcnlgCGXPOUXGDiIWdQ4SdVI=;
        b=amO0paG0Zmv5vmbhOrwzrPTS2QzXKyKr27pE8F5t08m0WNR8lnmgqAZ02uXj+WIHXU
         QgB6wC12I6zJp7gY4LFw3OJwOAjYQyI27oiKyMzK8c3UWSTPlLxDRlcABCXVUZCOD2Jc
         k9RgrSEibvM4fWqVT0riYWWc5wqRmQXtWyLDX/jSyf+Rodu4IQhYd3UJ/tbHH0n3iMe8
         nh8/mMYehyBCGDzQJufsthmI0axe603RoKnFckzZ84Igl3Z4HA0iMD+vKoc5+PpJLAl8
         +HZCA+y0vrrnfSFNdGKC1wccxDZ3eDKe4XBoY/kupOS65tBjAZm5aX6VXHWSWCPXc58z
         0tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSqvEurDGrNTOd41O70DcnlgCGXPOUXGDiIWdQ4SdVI=;
        b=oqakn1NdlQ7IlIwoozzjH26/yXjruRPz+zjpoiEbn9Y4nqRNQwzqasgaJeXwg2Xyxn
         h6u98xORB03SryJVcANp8XTIiA67ZnFqbfXDvkK4mrGDOW1Br5tnx3AJNuNAjy79CUM8
         9KRQeGOFiHNIsUsXgQROShrd4+p9/PouVC245IfyRM8NU6onIcMBpcfwLqmcVyZ1YcQB
         uITM2kXoGiogQV329KjAIQ8bFU8yyoA+OISZpyubZ/q7ZFkPZGWJVY7jwfnEKOTdxXlc
         ntIKlgyK8Pk+3FV/pU3PLodmN4tgJPSfBUI0eaESDUmK/+UBDLw157nMzUJDDPE00m1M
         sUwg==
X-Gm-Message-State: ACrzQf1KHwrRuknL7edRYAnOSnc+slrgiLAhcLrNPqGOMyyeDxXuep/l
        8WezkSQEg9WV/+xtTNG7vmviDwU8QxU=
X-Google-Smtp-Source: AMsMyM6tpjDYMbDzFX+1pNTdcyY4PE5Ded7AmGHYToagl0LLxIQd1lvaYyZ+wsmq8wVZGQzlNJS/Dw==
X-Received: by 2002:a17:906:c14f:b0:793:30e1:96be with SMTP id dp15-20020a170906c14f00b0079330e196bemr24312165ejc.447.1666645129941;
        Mon, 24 Oct 2022 13:58:49 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d54a000000b0045920b019a9sm395402edr.95.2022.10.24.13.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:58:49 -0700 (PDT)
Message-ID: <fb69614a-a06a-ab59-fae2-9443e96e249b@gmail.com>
Date:   Mon, 24 Oct 2022 23:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
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

Replace two instances of bare pr_info with dev_info.

Also make their messages a little more informative.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 8bab7247460d..9d5ae83dad70 100644
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
@@ -5420,7 +5421,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
 			rtl8xxxu_queue_rx_urb(priv, rx_urb);
 			break;
 		default:
-			pr_info("failed to requeue urb %i\n", ret);
+			dev_info(&priv->udev->dev,
+				 "failed to requeue urb with error %i\n", ret);
 			skb = (struct sk_buff *)rx_urb->urb.context;
 			dev_kfree_skb(skb);
 			usb_free_urb(&rx_urb->urb);
-- 
2.38.0
