Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6227741D0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjHHR2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjHHR2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 13:28:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592C21243
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:12:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so853531466b.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511080; x=1692115880;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY6ou3nWSYAFAbpL5fcsmF7g+TKRxVKltr2+VptchpE=;
        b=iTlPABMDbQPnZS6Ls6btLqf/nra86bdT5iZKtlhVt0JAkcru/RJsW/Cm4k5pO266gL
         gnS+lK3HfKz5E5FejzMsxCvbgdawFjCztL3FZazho9DF0jDO3gD9/OorEY2FmXtkjnTS
         DDJQAVqECSjbKJP91hKivOLLCZbuQYB31TFpFSW07lhen/HJYTORo1waRA9kM8P3wbL5
         ZX/XS8ypgGWvu8D+vwXMQ3oPLIm4AfDWO7rA+mydNU9HpZy86xyLhkDwd8uxuifHwM2Y
         z2Gyp6RCqJ3ffWXlWpRWlbPizns7MD0lq5C2uq3B/aYmUvheLcgvi8yyiHI/r2YnGE7E
         7mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511080; x=1692115880;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY6ou3nWSYAFAbpL5fcsmF7g+TKRxVKltr2+VptchpE=;
        b=WQoT2pEVvuzNJp0okDdKxZcpkQPUy025FpPjTW7DtSkvhgBTeVgryhjpIDSmIKZhjT
         8Nqk8QwOQiHCuj6CFzC7WXc4VtjGeUp4gFrw2qLs0l4obmpzIXaggrDeJBNMTqZR1SL9
         WWNBbccuLiJvK7G+Qc9nZEGLheHJ6EwQDPU9VJdRgdvix3oM93rOlslBwMW3IYVocBFq
         SLeMqxME0Pv3FlgwvjddhaS79GiGto+1VAoyCJWG8TcSMiKepIOXES9nfhbfnchsmMH7
         LEYmy8+6ZAFFYliQXt0T0GPUh8j8UbvGjOls9kOV/Yb0Jy5RDjyfyq8ZWZ6qQjCXhVVn
         lR0w==
X-Gm-Message-State: AOJu0YytD3UPIAxEkAVAFWRMYii3g41Epgx915kk/KsIIqkh5fnDd9KP
        gNfRhyun0L3LdtMhmR98/SuR2JlDVH3JXPzn/YI=
X-Google-Smtp-Source: AGHT+IE4GCEBg8RVyD837dgKBOWFoI5qD31p1ESEay2d0rA46DdwzPmszKIjNeRfJy90BuMZJvtjPA==
X-Received: by 2002:a17:907:78cf:b0:997:e79c:99dc with SMTP id kv15-20020a17090778cf00b00997e79c99dcmr10365115ejc.74.1691472974377;
        Mon, 07 Aug 2023 22:36:14 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a1709062a0b00b0099bd5d28dc4sm6056478eje.195.2023.08.07.22.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:36:14 -0700 (PDT)
Date:   Tue, 8 Aug 2023 08:36:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chin-Yen Lee <timlee@realtek.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtw89: fix a width vs precision bug
Message-ID: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "buf" is skb->data that comes from the firmware.  We want to print
"len" number of bytes.  But there is a missing period so the "len"
variable is used for formatting (width) instead of limiting the output
(precision).

Fixes: cad2bd8a136c ("wifi: rtw89: support firmware log with formatted text")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2811a94b5f69..bcd9050f989f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1165,7 +1165,7 @@ void rtw89_fw_log_dump(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	return;
 
 plain_log:
-	rtw89_info(rtwdev, "C2H log: %*s", len, buf);
+	rtw89_info(rtwdev, "C2H log: %.*s", len, buf);
 
 }
 
-- 
2.39.2

