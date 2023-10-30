Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1527DB5AA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjJ3JDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 05:03:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC2C1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 02:03:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c8316abcso5855696e87.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698656608; x=1699261408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Og0eGEy6ECnZkx/WHAySjGVnAuOJT/PL7KvVeqDKaQ=;
        b=btJogvBKRD/2sSBeYwuZkt0DD9rMsW7Uha4WYku4+MRNTcMew9moEzzOdvNqWt8RVT
         FLmwk4pr7/mj5Lt3MMkapv60tzZScrpZS2HOaSBR0ybK+2wFJqEO3i85VsYZwA3Yzxfh
         RP0VFI0uW6UG375CWzP0mnfSW4HM5tALMsUtS7ZFcmiMTqIXmjyfkunledcJ3R3x4ZYW
         nJIFjssZN1ikwtsZyVfU8Dib7Kil8uyaS//cvgAeRdX5ktuUqa7xKMZMSl7I4XO1Z7ar
         2YB/MaTfipawugQxF+Nd2GmRKVRTtU1kmxPjXm3cCfgddrjCkI/3+ojIUCVZz15hfGG2
         d4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656608; x=1699261408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Og0eGEy6ECnZkx/WHAySjGVnAuOJT/PL7KvVeqDKaQ=;
        b=ONQ+TZ3+LB/2PlDG6J7W6o7d8pV4eb9+55u0VStDQ5nT0FilQK+R23GYxMUpL+rDa3
         CpF44pkESrkJPpHmIHd4sFY0a417qzOllfHUWv9S/xZpdY0U6yFojlN5tb8zhJHh2agi
         x/NF3BYHLWZB7x7dRKVT4cwruPqooxs/bmjoB6FyoJtYpxweQ53LG2qY0URH6/z4oXNQ
         KoxCZx+P6uEquw779P3/gSOx3zQrqlvxpC4VkujtHaNrnOpNk0EzPTNthm85gBZ8GcCb
         68Bj511FfPUe2TWm4IIG9JHcX+eY77zFdNSj90hk+qGBtc0+9mC5ZxYDXglXnIbTI/Hg
         k2eQ==
X-Gm-Message-State: AOJu0Ywbp9r8HgQT+XTrr6KRHQAT2wcUTnxma8XNeXPZL4RQ/nox3Fto
        GrsdSJargKu3jg3UUb1pik8E1A==
X-Google-Smtp-Source: AGHT+IEVwK0EPwzXp3ZPpA567lm9mf9RmP+zWXN0GwNBvo7GPH4UCC9PSUAH//0uQ+MLYDODelpm9A==
X-Received: by 2002:ac2:5f6d:0:b0:506:899d:1989 with SMTP id c13-20020ac25f6d000000b00506899d1989mr5436459lfc.44.1698656607852;
        Mon, 30 Oct 2023 02:03:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4ccb000000b0032179c4a46dsm7771900wrt.100.2023.10.30.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:03:27 -0700 (PDT)
Date:   Mon, 30 Oct 2023 12:03:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: plfxlc: check for allocation failure in
 plfxlc_usb_wreq_async()
Message-ID: <e8d4a19a-f251-4101-a89b-607345e938cb@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check for if the usb_alloc_urb() failed.

Fixes: 68d57a07bfe5 ("wireless: add plfxlc driver for pureLiFi X, XL, XC devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/purelifi/plfxlc/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 76d0a778636a..311676c1ece0 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -493,9 +493,12 @@ int plfxlc_usb_wreq_async(struct plfxlc_usb *usb, const u8 *buffer,
 			  void *context)
 {
 	struct usb_device *udev = interface_to_usbdev(usb->ez_usb);
-	struct urb *urb = usb_alloc_urb(0, GFP_ATOMIC);
+	struct urb *urb;
 	int r;
 
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb)
+		return -ENOMEM;
 	usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, EP_DATA_OUT),
 			  (void *)buffer, buffer_len, complete_fn, context);
 
-- 
2.42.0

