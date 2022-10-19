Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC726044A7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiJSMLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiJSMJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 08:09:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C2107A85
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 04:45:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so39306963eja.6
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWXy3ixXhBh6Q+ZuZgHETSGEk5KoziqbQ5MQxqx+wbs=;
        b=CaPw3qHT3TySqMmiNuwPFH+mLC2ACNuwLziAPyH7O4nkzf72qzK3ynkIwY6SGfClq9
         5QaupJng8/SEmYdiXlpNVSq4kqDNO9rkcztr+gBSWXfxZbuJlSwcBEuEQrBlQtT+49sI
         E4QPybDNIjiEoLzI8NVa+kdtKP0IZlLax7NAih98SAUV0UUl8Jokv30R8sopdHB0n5DG
         45f3iRasdqvDuHYcPKEO7GGpbA2vf9BWIZJq8UNAYFPyc+4gTYNyqsTG61mIB1sChxnq
         XN9U8MGT5tU/PtbHqgCZc8d0v4YwGdygb7tYGjMxLL8Kf6TUEQ49/PILKIb3rQqjtFtB
         sXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWXy3ixXhBh6Q+ZuZgHETSGEk5KoziqbQ5MQxqx+wbs=;
        b=cQUWIKNZdKPALGUeYDz6tH/Z208q56GeiJv5jf80aLIEVcJ/G+rHXQl5pOumiXtm49
         JOMmE0N6eis7gjx8acSn9EjyfHz2RrOwhDadUjFKGb7jCL/RsmJ7CNbJV49vcvR83siF
         ENAOeZtEK3Bo0rD8es1XdRW7iXyLEoCGo5YZ3XpTYgLSGln0KUq+JV/kX3tHvZhxrsBv
         AbmgPT9TF5nry8eN/JPL6cy5rXKzU9rjWNXRcUvoAbwVUNQHRtyroUatuxXv/8C5xWTC
         3HClREilgbT4SV2jDLhbNnC2RSDkONbn+2LVetKhU0Pn8pd134ErbvAGXcjNlgqn9Faa
         1lag==
X-Gm-Message-State: ACrzQf3IrzudawDzpfeafoVW2TMf7a40HMAtcNWWZBHq3kRWRiKMkl0/
        ZeHdNxwdWYeGWSQlgVrBed8hkpS5UCGsOMUZqCY=
X-Google-Smtp-Source: AMsMyM5oI5I0yd2b5CwmclYuxYoHEpi9ntL6DXvukcvbQPvk9E8McK5XVJJ+vvZJzrhVgAEtJtJR7C2+ar+MmPSgIMA=
X-Received: by 2002:a17:907:7621:b0:741:6656:bd14 with SMTP id
 jy1-20020a170907762100b007416656bd14mr6318806ejc.298.1666179859287; Wed, 19
 Oct 2022 04:44:19 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 19 Oct 2022 04:44:18 -0700
From:   Arend van Spriel <aspriel@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Date:   Wed, 19 Oct 2022 04:44:18 -0700
Message-ID: <CAJ65rDzroYUFnPuzH54dFB1fAYPynDrTZYy-fF72E=Y_bFER-g@mail.gmail.com>
Subject: [PATCH] wifi: cfg80211: fix memory leak in query_regdb_file()
To:     Johannes Berg <johannes@sipsolutions.net>,
        arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the function query_regdb_file() the alpha2 parameter is duplicated
using kmemdup() and subsequently freed in regdb_fw_cb(). However,
request_firmware_nowait() can fail without calling regdb_fw_cb() and
thus leak memory.

Fixes: 007f6c5e6eb4 ("cfg80211: support loading regulatory database as
firmware file")
Signed-off-by: Arend van Spriel <aspriel@gmail.com>
---
 net/wireless/reg.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index ec25924a1c26..f629c2e15fea 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1080,6 +1080,8 @@ static void regdb_fw_cb(const struct firmware
*fw, void *context)

 static int query_regdb_file(const char *alpha2)
 {
+	int err;
+
 	ASSERT_RTNL();

 	if (regdb)
@@ -1089,9 +1091,13 @@ static int query_regdb_file(const char *alpha2)
 	if (!alpha2)
 		return -ENOMEM;

-	return request_firmware_nowait(THIS_MODULE, true, "regulatory.db",
-				       &reg_pdev->dev, GFP_KERNEL,
-				       (void *)alpha2, regdb_fw_cb);
+	err = request_firmware_nowait(THIS_MODULE, true, "regulatory.db",
+				      &reg_pdev->dev, GFP_KERNEL,
+				      (void *)alpha2, regdb_fw_cb);
+	if (err)
+		kfree(alpha2);
+
+	return err;
 }

 int reg_reload_regdb(void)
-- 
2.35.1
