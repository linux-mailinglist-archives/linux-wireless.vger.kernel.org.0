Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E414600273
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Oct 2022 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJPRbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Oct 2022 13:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJPRbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Oct 2022 13:31:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CF10063
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:31:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so13099057edj.5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UG4hwCy9957FxOMAsK0JOwX3APF9qYW+A1+dDCADRY0=;
        b=d/tdIuoPIgi9HBBYlj4DcprTerbS/KIp99zpSotcvh4CRKJ7aExtVLtKNmNXBMhQib
         mlP6SPnFiyHKottFBaB6LBaw1ZCS9uJ2/tNscKHaNAFMZMEe/GaL0oY5Z9/aohCW78pg
         CdEkSTThrxXV0GG0dW4HgFuyedOWRrOBHJBRrSRJeRlAtN5IwPJ1F+9M08ZCvIOSDE88
         hmTAtdBh3fZA/oCagUJJ0qPsa76NbhFX5fmRVDVE1Hp4h24V8uQ2u1gxKLD+3w+Tqa9p
         56EgPlMb5Gr5ZYu52Zty6aQ22DzMx5dLSGPYxVtrxDmYHbRwDpFUz3vZm6VQ2kwyu0iU
         Mc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG4hwCy9957FxOMAsK0JOwX3APF9qYW+A1+dDCADRY0=;
        b=IjHnVvuUNqrNhS4Yuwb9t/nvzQqobXSfCR5FaU9YsJgd9mcJ2AZJQOjclYHuZnMq31
         sMsSaaau0RIe0Ea4quMS1/wGS7+r/7gOduE4INrPA/r5IKG7SM7cI4Sj0aSnCsfazhxj
         b7NbRQ5xv4yCtUKyH7f3UOMrXqoCKSwJ+k3jl+RaLK+5AibuGYkjaistlocYxbDYtEkQ
         yi/+kGk5hQ8RduO1aSrW0DhoHxZbeQT/6x8qrY4ZzeIjDUQv3h7rPkqybPlyel15UOvJ
         fV+sWPPIodMuJMAEFV06gmqcuQC8o+mtxlcl7eI2IHi/ey9RPMuXm3P3uOVjrTS0nwVz
         YhbA==
X-Gm-Message-State: ACrzQf3/dz4g0wXsPRKXyMgRN6QYejYbWLG0qUR0SGLb5Fx+pm/ztBaA
        AXWHmWBH2/RPP3a890pxSD95SgU9/QQ=
X-Google-Smtp-Source: AMsMyM5GmEPNdIrz4U3II2THzf9sji6q/rI1rEQp+gWuLpRMeGlW+RdLkRvu3AORy1scythiK2RA9Q==
X-Received: by 2002:aa7:dd45:0:b0:458:7474:1fbe with SMTP id o5-20020aa7dd45000000b0045874741fbemr6936825edw.334.1665941506691;
        Sun, 16 Oct 2022 10:31:46 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090626d400b0078907275a44sm4900501ejc.42.2022.10.16.10.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 10:31:46 -0700 (PDT)
Message-ID: <f6173e5b-1fa4-909e-ce8e-2b2974bd0623@gmail.com>
Date:   Sun, 16 Oct 2022 20:31:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
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

Replace two instances of bare pr_info with dev_info.

Also make their messages a little more informative.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 33169b836f2c..fe3316b4f16f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -2016,7 +2016,8 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 
 	val8 = rtl8xxxu_read8(priv, REG_MCU_FW_DL);
 	if (val8 & MCU_FW_RAM_SEL) {
-		pr_info("do the RAM reset\n");
+		dev_info(&priv->udev->dev,
+			 "Firmware is already running, resetting the MCU.\n");
 		rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
 		priv->fops->reset_8051(priv);
 	}
@@ -5424,7 +5425,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
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
