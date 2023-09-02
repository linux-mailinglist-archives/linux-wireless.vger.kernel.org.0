Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937A7906C3
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Sep 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbjIBJId (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Sep 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIBJIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Sep 2023 05:08:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88B170A
        for <linux-wireless@vger.kernel.org>; Sat,  2 Sep 2023 02:08:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7423ef3eso20004595ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 02 Sep 2023 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693645709; x=1694250509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRyPUH/s0RaB41Y50a3lU0rUMMpoD3ifcA14Cmdz6qs=;
        b=VQrx9zlsVepm6oosmrJPOd1rBfL+hXMN6v7UeLc38PqmUIIxwq2Lioowr3BSUdU2Cn
         tXNrfPC5bU9z75XfVYOFctllMr/wCc3TexDH/Y+Bq2MOKUQDbtZHBvAknu4z2JMz8po6
         6C7VvkDQ7o7JP5xKTNBE8RQDg0RxALKkCAL+ZxU8xP8z19SFmGZL/Vr2y/5QxYBMcstF
         +TOkOX2G2Zq/LGe03A60kAc5ug7lZt++E9cEiixrl0IDxtY2SEpLFcGJ6T4YW5s26ytd
         xhDdS+Uiqtr5A2gmPRWSJ4bjLfGIJr454lg6Ztott4iWTBOhubzwTh/Gd6N1McgHxlN5
         tZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693645709; x=1694250509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRyPUH/s0RaB41Y50a3lU0rUMMpoD3ifcA14Cmdz6qs=;
        b=dtiqnWKfAzdATWfPlN6AL2u0DlxFEu+nKv2Wdt2lrDClVuQNQFDYyZIUUxOYhGqOuc
         h7ooepMyExJ4BIT66Iwk+mvRBTWa5eNAH/oAaYNTeA7hM5G83EhUFtcI//0MUts4r3w8
         QgmwJMcsSqAK9xq1pC1ms2xc71m/brHfWzixxwt3lF7VkT14gOtqPD/o+vU2idTnB7XL
         Eyedu+fXGZ378O4ek9jRV1ZM7i46ILxSpwwVgLqCsuPni7zohg9fNVGxo2qGJRUvm3Ho
         sT+HSYNsrZXk8vNu9YOmSLkli/BfqeFDa1J0Mbw7ucbKWgYLAFXiLI24LVt57ztmtsz6
         KSZw==
X-Gm-Message-State: AOJu0Yyp3eGCJw74Ifi7G+Q6nJvjDGQOFDfeg1IAwd/fRHUtDJNtexEh
        ZY1F+xRVCdA4AxhZz4i2O94=
X-Google-Smtp-Source: AGHT+IGBsAhZRKuVDhjJXta7nH1edQoFg/fKrnv0e27FkjkxjpXIUn5tLSrzNnzgSj2LXuO1Igf+FA==
X-Received: by 2002:a17:903:234f:b0:1be:ffaf:d72a with SMTP id c15-20020a170903234f00b001beffafd72amr5875529plh.60.1693645709201;
        Sat, 02 Sep 2023 02:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a40d:5ac2:6bab:c627:af57:9218])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902d70f00b001b8b26fa6c1sm1931326ply.115.2023.09.02.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 02:08:28 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, Shubh <shubhisroking@gmail.com>
Subject: [PATCH] wifi: rtlwifi: Fix spelling mistake "nerver" -> "never"
Date:   Sat,  2 Sep 2023 14:38:08 +0530
Message-ID: <20230902090808.67926-1-shubhisroking@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Shubh <shubhisroking@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 807a53a97..679bdc46d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1265,7 +1265,7 @@ void rtl_get_tcb_desc(struct ieee80211_hw *hw,
 			tcb_desc->disable_ratefallback = 1;
 		} else {
 			/*
-			 *because hw will nerver use hw_rate
+			 *because hw will never use hw_rate
 			 *when tcb_desc->use_driver_rate = false
 			 *so we never set highest N rate here,
 			 *and N rate will all be controlled by FW
-- 
2.42.0

