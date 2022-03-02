Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4954CAF0F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbiCBTw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiCBTw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0BD95CF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 11:51:43 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qt6so5985922ejb.11
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCoxThg0BgDvUZW1SxPOzG8xYONpAW2nI0hT5dyuJ+8=;
        b=E1UR1coOBUydg9tjcKe22ruZqfCSDhM8R7IJODWapeZsAxvyy4jn/PAi/rQaR/hF+r
         lwgKyboCRZ0HUB2m87y+bb+wL8R+yWJt57q8LxUNLzx+jn6pfayuTTANn4ESI3h3IdTr
         o2yPn/XEPE5z8hCEOt0z9EvL8t2pA+pQp9r1Skjasu9DIUB+ylij8HgXHXPTKEzxzTlz
         Nyoo7UsPJRcBKWjnRsavcMA3zdFXpMRcXJRxnzvDZuoNsNmDKYWrKQSGqNAeYCMXGwGO
         DWmUn2BuzcNDpKc4llw0v/YtscpDVbNzuV+zpFhFPMBSOhrvFFXMurGguOfzXpSreRGj
         Ekzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCoxThg0BgDvUZW1SxPOzG8xYONpAW2nI0hT5dyuJ+8=;
        b=iuNrjzV4+SsnpEn2iiA1hYBqY+RdJSMLvdD+r/HvIYSFkBDgDF/QwqAeK9bEbY2GkU
         Ra6lpPlrndwUa239bVozpzhcONi13tRFzxhGt+juK6uuloOqpVA566c1c7HjP0Ho19CJ
         ES6SPCZ+eqxcqoVgxP6aYw8Gg+KA8E+7/fEBv6mvi2/IIz45kWovSdSPIsqDqnY1CAh6
         Z9XwydZRUnJYpzmBmH7HFkhrjHkXoB2nziqVshxP/tbahR+SJ4JAtkyYcvufVk6k2FE/
         chYRaRotTuaSDWPyWyUrKYgeiNzCdcGi01GXyyIgFqZa8WSNyjA5K2j4eAE8PJp+ONue
         NrdA==
X-Gm-Message-State: AOAM530dRUBL4+te4gYZnjTTDlRiRRd2T8FRwO6einWs/NaPhgRUVHlD
        3MzEs7GIgHdKCRvF4d+rtDJGSsgZXk4=
X-Google-Smtp-Source: ABdhPJxWlSvtuC29nF+E7m14ac5qWwtG3tuzUZSsIDHT5ORykNN2RehJC2Cm14LTUG5LISCN7nIGew==
X-Received: by 2002:a17:907:3f9e:b0:6da:842e:873e with SMTP id hr30-20020a1709073f9e00b006da842e873emr1144996ejc.383.1646250701706;
        Wed, 02 Mar 2022 11:51:41 -0800 (PST)
Received: from debian64.daheim (p5b0d776b.dip0.t-ipconnect.de. [91.13.119.107])
        by smtp.gmail.com with ESMTPSA id qx13-20020a170906fccd00b006bdeb94f50csm6592339ejb.203.2022.03.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:38 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nPV0c-000IP3-HH;
        Wed, 02 Mar 2022 20:51:38 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v1 3/5] carl9170: devres-ing input_allocate_device
Date:   Wed,  2 Mar 2022 20:51:36 +0100
Message-Id: <f81a6ff3b02116c6a448c42eecb546ea5d46c108.1646250537.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d1c16490462a9371ab3cc16a018ef5e08382a35e.1646250537.git.chunkeey@gmail.com>
References: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com> <d1c16490462a9371ab3cc16a018ef5e08382a35e.1646250537.git.chunkeey@gmail.com>
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

devres will take care of freeing the input_device once
it is no longer needed.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 9495b3da1978..e833052e9056 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1494,7 +1494,7 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	if (!(ar->features & CARL9170_WPS_BUTTON))
 		return 0;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(&ar->udev->dev);
 	if (!input)
 		return -ENOMEM;
 
@@ -1512,10 +1512,8 @@ static int carl9170_register_wps_button(struct ar9170 *ar)
 	input_set_capability(input, EV_KEY, KEY_WPS_BUTTON);
 
 	err = input_register_device(input);
-	if (err) {
-		input_free_device(input);
+	if (err)
 		return err;
-	}
 
 	ar->wps.pbc = input;
 	return 0;
@@ -2038,13 +2036,6 @@ void carl9170_unregister(struct ar9170 *ar)
 	carl9170_debugfs_unregister(ar);
 #endif /* CONFIG_CARL9170_DEBUGFS */
 
-#ifdef CONFIG_CARL9170_WPC
-	if (ar->wps.pbc) {
-		input_unregister_device(ar->wps.pbc);
-		ar->wps.pbc = NULL;
-	}
-#endif /* CONFIG_CARL9170_WPC */
-
 	carl9170_cancel_worker(ar);
 	cancel_work_sync(&ar->restart_work);
 
-- 
2.35.1

