Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10296D2949
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCaUST (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjCaUSR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 16:18:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA0CDCC
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 13:18:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so94189622edb.10
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680293895;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTx27nFeah1HlFYaH/bV7WVuKUIPODz6snpbykgWgI0=;
        b=Bjg6OmLxxxfoTFhd1HoqQ+SqgWkTFQ9vVKnNwM+a4NIuyzIIxt2vSmMMRjCZ/jJM6Y
         UYuKltXf+sJgtxTQjIqefjdiAantcfI2f2e4nWDJa2wufun4dnJhWHBnCehqyZOdZpRG
         avSVeG5kOy5l19fXK0rYsoqt6SuhQTL9QCT7kud7vZkCACVacU3OBIzgt+JwUm5PAOg3
         ah3vYLsCybHuc3l7KZwVOClk6jDOQeEbMjAy9pAET5QP98F0/TD6EdPrOQ6VQgFCE8av
         DCpE6R/HW2IC07xXfRWLSNGDV0GN+lvxMBdvDML/C80BhZgzlWvpv8qrAtzw7J2XQ9dR
         gU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293895;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTx27nFeah1HlFYaH/bV7WVuKUIPODz6snpbykgWgI0=;
        b=vSty0ookCZjkLw+1mbUaFyON2vxja7/LSlRHpz2ZsSfoRXRhx86QR0XAIErvmiEyIX
         EFieIqZdYYoAtEtC64N5BvPjXPcqmCvivVjP6+70KcjYK9WbqAtk+ebOZgf0AL9Lli58
         ayOz4qAif0LBFRtW7ha/Jo0brk9/EtBTwe++pEuxUOZTP3DnTrOsruFAMS7UjsotsZaq
         eqVZ5wkHMrbK5TTpf+1IJac52C02l5oqrAn9kJiM9AtoE+X6lkbSVcHtjZmhq0caGBYU
         fx/Sf9gIQv0Uq81FDDE2CPN7MPj7G3SvWvHfvZ2K/ViIdVrX6mZxRxmwVrbSHdRtllyP
         nYYw==
X-Gm-Message-State: AAQBX9cb/zJba0i9LeiT+FR9V+gWBHAxenaohGlgdk4BZwxx2l+3zQQA
        IMnF0+XuwC6NiZK2OUkPzMCE00dU8tw=
X-Google-Smtp-Source: AKy350ara8Jr7Pqq7JT4CwterTufcHyQIBCpaHy1wErHQlyDXyBM4/LL+s38a3A1YjMhUyP7Q8sBVA==
X-Received: by 2002:a17:906:553:b0:8af:5403:992d with SMTP id k19-20020a170906055300b008af5403992dmr26532624eja.28.1680293894921;
        Fri, 31 Mar 2023 13:18:14 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709062dda00b0093caa021528sm1305489eji.85.2023.03.31.13.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:18:14 -0700 (PDT)
Message-ID: <41960362-55ec-226f-befa-c3c05c38c94c@gmail.com>
Date:   Fri, 31 Mar 2023 23:18:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH 2/2] wifi: rtl8xxxu: Support devices with 5-6 out endpoints
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
In-Reply-To: <eb152b5b-fe65-3783-a3d9-71c9cb7ef9d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle them the same way as the devices with 3-4 USB out endpoints.
This is needed for the RTL8192FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 39fee07917e7..82a0290ccb29 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -27,7 +27,7 @@
 #define RTL8XXXU_MAX_REG_POLL		500
 #define	USB_INTR_CONTENT_LENGTH		56
 
-#define RTL8XXXU_OUT_ENDPOINTS		4
+#define RTL8XXXU_OUT_ENDPOINTS		6
 
 #define REALTEK_USB_READ		0xc0
 #define REALTEK_USB_WRITE		0x40
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 62dd53a57659..6106b47d0c37 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1663,6 +1663,8 @@ int rtl8xxxu_config_endpoints_no_sie(struct rtl8xxxu_priv *priv)
 	struct device *dev = &priv->udev->dev;
 
 	switch (priv->nr_out_eps) {
+	case 6:
+	case 5:
 	case 4:
 	case 3:
 		priv->ep_tx_low_queue = 1;
-- 
2.39.2
