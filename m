Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98926EA880
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDUKoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUKoK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 06:44:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E73C07
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 03:44:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f086770a50so10887865e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682073848; x=1684665848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9MeXQGQNttAKEG/2Uafkn62wt8R8L4SBm0zKSGewls=;
        b=x3ujMZWszN2R7Xq37gf2sInr4NEdk+/poPUHTl0m+nCFLhvdAWnAYwzzF5xF6mWRxh
         iGY1VEsPpB0CML7KQdPQNql1tte6dwKKXmLu5kbzYnJezKHOi45mNRzcjVwLgLl9lutX
         2uoI2Wcc4hpgb05yNQwbcSVbyOveS7EBek95ek+AVrDk7WDlVK6f2aHZe+q5aRRnJCQp
         Kfr7BQfeM51E/Rci4nylNs7/JL5/frAQ6YX2/ua/CoKurwzQlo0910Ta5L5KeDu0bY+z
         QX/r00EstL044iQEHRUsoHU5uNy0c19MDwSvFmD3VvPaKFaRUqv7iC0+S0wse1SBCDpV
         oxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682073848; x=1684665848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9MeXQGQNttAKEG/2Uafkn62wt8R8L4SBm0zKSGewls=;
        b=C985Sh4JdTNqOcqstfxsjlZzRDrCojOs6Y6+NHB86Pcqwo6os80xVnMoo8SZJsPAB0
         peGPP7K1txsWA/t0fdaAoSgbOB+K1tG2LUK7rYqUqWyK5TUo0ikuOphP/oFMgAw0wMVZ
         YYtwwo69sBN1E4AXoaHR49+VHX9vYXGWDpN3PdiV9K56pedAnoIHFGtU4ILUG3tznjXS
         Il5+/WZsQpPlo2m6+Q6bWohElXh3H/Cm2T5WQR+YK7DJTbtVmP+yY//Dc5Roosm78gXE
         t3Z0b/70a5Qn0W8FhR5lUTOzBqqVtiIrqCLkT7k+Ez31ovYLrdjDbnhMOxXP/IUEuV7i
         iU9g==
X-Gm-Message-State: AAQBX9czU95/myNXG9LsNcS20sZpyUR5epLVjXBxp+0lyjY8jJNC0/Fi
        oVLXbqRvX/a1UTlWJTSyfoUwRl6s8dc9yiAcYwM=
X-Google-Smtp-Source: AKy350Y688eh9yj2svLW6NLije/X+twIT+EVi+I5h4sY3AU+gdC6bKWTV48BhOI6aw0XAvYH/h2iDQ==
X-Received: by 2002:a1c:4b09:0:b0:3f1:8f05:3b82 with SMTP id y9-20020a1c4b09000000b003f18f053b82mr1443312wma.38.1682073848113;
        Fri, 21 Apr 2023 03:44:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm7906521wmq.20.2023.04.21.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 03:44:07 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:44:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and
 RTL8851B
Message-ID: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The if statement is reversed so it will not record the chip version.
This was detected using Smatch:

    drivers/net/wireless/realtek/rtw89/core.c:3593 rtw89_read_chip_ver()
    error: uninitialized symbol 'val'.

Fixes: a6fb2bb84654 ("wifi: rtw89: read version of analog hardware")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7fc0a26a4d73..1d462c9e46d9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3587,7 +3587,7 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 
 	if (chip->chip_id == RTL8852B || chip->chip_id == RTL8851B) {
 		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CV, &val);
-		if (!ret)
+		if (ret)
 			return;
 
 		rtwdev->hal.acv = u8_get_bits(val, XTAL_SI_ACV_MASK);
-- 
2.39.2

