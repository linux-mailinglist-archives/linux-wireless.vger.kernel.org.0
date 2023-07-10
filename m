Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B74DFF8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 23:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGJVEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGJVEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 17:04:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1CBC
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:04:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f766777605so7775500e87.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689023081; x=1691615081;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AljlMmjXrKm4FJYukYxs1FJPNHeca4F3lkP2SD3zF4M=;
        b=O8CJAAUaEyllZf/xCZjZZpJiV77pZse+AJxrgVIBUVlHcJiz6pqmDWd0OG63gEudJ/
         l4j6KN5FNOMNQn4TNfZF4/3jG/XhAhAM6tjTc7GjMabzk9njCSFGi2NiJL8Pou6TLwav
         5BOe/5NFGGkeawNZW/fAe97f2/pVlX0OkzPboON02db5/4J+tC17ZVi5ucrq5qJCKS43
         BMJSpD/m7vtGRo7CzuC7Dv3ql5UbJZXHugaYXb0tp8R6lSTHEOgsjRtyH/TTQxOwT8l4
         hRqCXevNcaaXETO5h9QUQ3TMoN4ZuIJxK0TB9Ppd10dCFfpEW3fwAdVBZ7LJsrjxgb7n
         mtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023081; x=1691615081;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AljlMmjXrKm4FJYukYxs1FJPNHeca4F3lkP2SD3zF4M=;
        b=BNbpOmnd4+I9bG318Dl8laasIoW5EoXhjDJe0l5FjgkKJppKM2s5nBuXSHLoeD72v9
         Nm5EnCB99X8kVQnUrQsuFdUk1vEkfXzwlyWWWIM6v6HiSr7Ahsg3FWsQYK9gbvXL9yb1
         GpAw2KrWevzRb3kWwrx6LhSNkqyCXdRJqNfXKug8Kyh/mlvchUa3Tta0w08I79h8vx87
         wqvStGgiM0OWxD1fHnBUQPS2Z+nWuv/Q9kdw2ROpuLjAbqnEufyojpkmemhYQlU7pE6n
         z+yLnOByXUyFTs3BnmVGGZ8h9o1Z3qUfscmQL2KCuvz8YVA5hZEeGzMxovUaG/fKx8ac
         7tSQ==
X-Gm-Message-State: ABy/qLbqcQdhKcGhqpnkFkHGdlZNzvtoGbDnR/3a3FwUkT8huPVubu/3
        6NDC+jt/RCgGFaYqT3v3UPDbiQ6UlDE=
X-Google-Smtp-Source: APBJJlGt0c6TtgEu6sKduRsx0KPTBKp+JdNCEhLOb/aAcocQx/xfpaX2jFKSLj/aUCk1cbi3YYG6Xg==
X-Received: by 2002:a19:7106:0:b0:4f8:69f8:47a0 with SMTP id m6-20020a197106000000b004f869f847a0mr9807042lfc.29.1689023081077;
        Mon, 10 Jul 2023 14:04:41 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7d593000000b0051e166f342asm167600edq.66.2023.07.10.14.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 14:04:40 -0700 (PDT)
Message-ID: <56c9b186-ba9a-8469-652d-ce1709813e9e@gmail.com>
Date:   Tue, 11 Jul 2023 00:04:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: [PATCH 3/4] wifi: rtl8xxxu: Enable AP mode for RTL8192EU
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
In-Reply-To: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Theoretically this chip can handle 127 clients.

Tested only very briefly but it should work as well as the RTL8188FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index f673aa9ba15a..47bcaec6f2db 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1767,6 +1767,8 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.supports_ap = 1,
+	.max_macid_num = 128,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
-- 
2.41.0
