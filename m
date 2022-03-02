Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0C4CAF0E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 20:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiCBTw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 14:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbiCBTwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9BD95D0
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 11:51:42 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id r13so6044024ejd.5
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//V6s70njW8Gqdv3PUMtK2rANsRzdBZe0tVhsi6Kse0=;
        b=S22zYVEoY8+z0lYLmvbJTkAiKzRGVyumBIZvSgJsrTx8rXQKrZAYgfc7SI+toIr13+
         ptAM8Ii7gE+KeEdKuHY2mR19ijMMCCGUbWKLsi7L7t+iW0hHyoRRc86PwEt5oauXTvpq
         Liq1+Q5o9LV6GjaLMOUE0ZE3FBXkJoROYF3MGdTUN49+kNU4kciDiy/gJZPGeulM5i/F
         yU33VilDSOFA0sFFrfgTZHzEzZ3zz7aHzHGRQ5PIJeEc98lZgqGHUu/EvZeMty6f1yEZ
         BXTVwSpnayZxXoal5itcbXHKP7zelQ8s0Qjdg6ZmzQ88lOLfeHuyKWv9Yy/8JECvExng
         htlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//V6s70njW8Gqdv3PUMtK2rANsRzdBZe0tVhsi6Kse0=;
        b=MArR8+HwgLYC/QLwGckE0OMz6VulOgsV3mKuu8taXzAq9X2x+YW4sRG7FjLxldN3tj
         HcyEgKpbrn4q54ZCZO4sYZQ51KUtyJOxd47p5RtGJoYJUvGhVMZwAoSYv61/t7Zp+7Oe
         VBoMBFG6//9XwpsLgGQrgf9DaXxS89usBZ1YoZCfm3PHYf3lxgQs5XziJbroumRp4G7/
         RPByfwV6y3yRjs0I+WuE6R5rmFlk3bx2v+df7Jc6BTvBvbmQFenfbpxdK9II2u9mjp4X
         0+4wZzkpUGdEQlwUNdsh9UIq5M4NjAcue1ONWyefWurpFoiC6RfmweBWxWIoVXWnL+If
         2UOw==
X-Gm-Message-State: AOAM531YP0CbPtPm8HZ8VVLgZgIm8WQFpwlG7p3SXIu4XhDnErej62oH
        7OUzceC+k7miVoOJIsjEKK7TcGd0pTE=
X-Google-Smtp-Source: ABdhPJyBWnPsbgaLBzhEAboNhKLPGtsfO0zXdMeGDP4zjaPkmg2rsFbvMa629AWyGGZXkMeBk730nA==
X-Received: by 2002:a17:906:130f:b0:6ce:88a9:42fa with SMTP id w15-20020a170906130f00b006ce88a942famr24107501ejb.469.1646250700767;
        Wed, 02 Mar 2022 11:51:40 -0800 (PST)
Received: from debian64.daheim (p5b0d776b.dip0.t-ipconnect.de. [91.13.119.107])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm8841837eds.21.2022.03.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:38 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nPV0c-000IP7-Hp;
        Wed, 02 Mar 2022 20:51:38 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v1 4/5] carl9170: replace bitmap_zalloc with devm_bitmap_zalloc
Date:   Wed,  2 Mar 2022 20:51:37 +0100
Message-Id: <0a79221aa5477501c3def032e95ef8018973a514.1646250537.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <f81a6ff3b02116c6a448c42eecb546ea5d46c108.1646250537.git.chunkeey@gmail.com>
References: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com> <d1c16490462a9371ab3cc16a018ef5e08382a35e.1646250537.git.chunkeey@gmail.com> <f81a6ff3b02116c6a448c42eecb546ea5d46c108.1646250537.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

the mem_bitmap is kept around for the lifetime of the
driver device. This is a perfect candidate for devm.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index e833052e9056..fae927ca4863 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1943,11 +1943,7 @@ int carl9170_register(struct ar9170 *ar)
 	struct ath_regulatory *regulatory = &ar->common.regulatory;
 	int err = 0, i;
 
-	if (WARN_ON(ar->mem_bitmap))
-		return -EINVAL;
-
-	ar->mem_bitmap = bitmap_zalloc(ar->fw.mem_blocks, GFP_KERNEL);
-
+	ar->mem_bitmap = devm_bitmap_zalloc(&ar->udev->dev, ar->fw.mem_blocks, GFP_KERNEL);
 	if (!ar->mem_bitmap)
 		return -ENOMEM;
 
@@ -2050,9 +2046,6 @@ void carl9170_free(struct ar9170 *ar)
 	kfree_skb(ar->rx_failover);
 	ar->rx_failover = NULL;
 
-	bitmap_free(ar->mem_bitmap);
-	ar->mem_bitmap = NULL;
-
 	kfree(ar->survey);
 	ar->survey = NULL;
 
-- 
2.35.1

