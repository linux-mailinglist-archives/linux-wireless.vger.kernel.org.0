Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73824492E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHNLop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgHNLjr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCEDC061386
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:39:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7223672wmg.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3TFuBWvx6taUPZUro4+v5BkkgVZieDFqQLYKGmsIgM=;
        b=bvKIMDsMikcPYW96Fn3utXtu9dLMKak+fKSEqcxJ2kfKkauaLTlDoFJ7kUu1BATx8u
         caauFpS9nW9cKPOH+hxpBo0zdLH59ujrwjn2WIQBdnNTtEozhc61dYrIT5+Z6/PwyRZF
         ug7L/HOwoB+qsPTilK5uOl4XwTvHS8Q9k2Abp8srA2CKV3UW4LGcjKNZLUC10BPa8P1F
         ERKSRj0rE+4+aMzld1AgI2LMDjGJxoB78sFjSB3/G1ekMVIubuYTwtjqM0TmvuaMUstN
         igPecR1wuJ7WU5qJnxQ4EUPxQU5WBqgI0CtS7mS4jZWnTi8ECakaQSMtun3+wqjmpi2s
         Cj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3TFuBWvx6taUPZUro4+v5BkkgVZieDFqQLYKGmsIgM=;
        b=FAUJpDuJxSByTnL6E7ANchicQTfAwyUZki2YoJNMs4um+R7GTetuHYtKxkdroOFnsb
         awDw6sh+30P+GyOKHWkK9HpJNePaUyoOM6Fm53BdaXaDGJjPn+KeDMjq12V3VqmxMfx4
         YfdpchXRDupgZpS/nrSTpsfzvb91hxFYO26WYngg+M5HfjlNrl5qJqh52xKyRwJ3xe8p
         gTDn6zBEoj/4NxtjfNUl0Bv9U5lWtMZSZZNpUOK4MjVrfrKJMmFX79GUJ9z6+zOn4VJT
         mb0E3SotbmeTMN9z74nAsxe2nRPcfmIT5MG3pHbFwZ5K0pKRCJVmFuHCQBJXEVIzByd4
         caIA==
X-Gm-Message-State: AOAM533xO1Y/cTbIpt2JhnheVleeAqXUWJ2ghK4WXtljksKufGufk6ET
        al5yddN9QNpB5dO9awQ082EDH89OVc8Duw==
X-Google-Smtp-Source: ABdhPJy2P0Di40BugpsK0J8/j2MpwLD0+3D1Hh0XMB1MSchU/UDiuDWLC8amz/EV2MYcASC/3IfBgQ==
X-Received: by 2002:a05:600c:2302:: with SMTP id 2mr2262779wmo.151.1597405186025;
        Fri, 14 Aug 2020 04:39:46 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Simon Kelley <simon@thekelleys.org.uk>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 05/30] net: wireless: atmel: atmel: Demote non-kerneldoc header to standard comment block
Date:   Fri, 14 Aug 2020 12:39:08 +0100
Message-Id: <20200814113933.1903438-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/atmel/atmel.c:4232: warning: Cannot understand     This file is part of net.russotto.AtmelMACFW, hereto referred to

Cc: Simon Kelley <simon@thekelleys.org.uk>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/atmel/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index d5875836068c0..7d51f18c3b5c6 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -4228,7 +4228,7 @@ static void atmel_wmem32(struct atmel_private *priv, u16 pos, u32 data)
 /* Copyright 2003 Matthew T. Russotto                                      */
 /* But derived from the Atmel 76C502 firmware written by Atmel and         */
 /* included in "atmel wireless lan drivers" package                        */
-/**
+/*
     This file is part of net.russotto.AtmelMACFW, hereto referred to
     as AtmelMACFW
 
-- 
2.25.1

