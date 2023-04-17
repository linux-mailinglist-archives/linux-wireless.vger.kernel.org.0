Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294466E4DFA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDQQEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDQQEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 12:04:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0F8A74
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 09:03:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id k101-20020a9d19ee000000b006a14270bc7eso9967637otk.6
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681747417; x=1684339417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l0crzzW89BIFjvoLdInrsQtw1pgBJPEt/usufoThRT0=;
        b=YF1z/YdibqD1JtJUFsXdGciAxwBMn8YAVQi7eXRgpR3VF3JrKiYU8OGxwOR2KkMWWu
         y1atuk7M+94CLWLhMD59M3IvY31jvq6u19XGsnYt530V3B6ADgmA7cnfCaLKvOKhQsh+
         y0pvG+JwV8ox0BufhGXuXGrDRjX6s3PiEY+ubtNfGE4RXMSWujDTg0wpiA7IWBbwO3wi
         4gfkXF+Wb0ndt4/ccC4wBRfUQuIKeII8aDduVyyv9zXVGCFZsOgl4g2uw7q/5NvLuchk
         EPa+BxkUPlsoc2BDrV9BY1WHRqIGy6RkkPTrJV2VN9+Ot9fY+ljzKGkyiP/y4wcVnXkz
         E+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681747417; x=1684339417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0crzzW89BIFjvoLdInrsQtw1pgBJPEt/usufoThRT0=;
        b=bBcCsS7vdfPems3vf8q+TsOy9TwPWhWrAstDZJWfXaMq10d0hYFANJF319o/Fa1kvR
         GaxRL/3jA6BLjvaEezng811qjhK9b3gVLze3SUByTiELKv2ua96VJJLTsxg+TEre7vVI
         b+dz1dQG4GyqDGTnpi1wBdbjQEXDbNPv38cRya58JYEvbNmut1kHWfGKPN1AF6/PCfSj
         HCKMqcd8JCKeMP5df67D729hojm6xatSdMNJI/Lr19RpF98bG2/goEpkJb8FcOnmmYKZ
         2kE0fG+FhuPA7ErvDNBU6HTI1L7aZRmu4uGKWfRZGUa9nUoua/IJrHrGqo1bFWi3IhJM
         foRg==
X-Gm-Message-State: AAQBX9e6GfEbh/xThRhALx8V9G+ucB8jkrKB/vBTDTTl6srw1qyR8hxp
        EJ+PxgzHfCCgrRtAXZHfiiHVSjqOd1k=
X-Google-Smtp-Source: AKy350Zw1wc/+/mUNSQzVpVwApcUpAG/je5v2iwrAEVuWzu4wA7Ho7DqW+ZM1QGBOWMlufu8+hZLlQ==
X-Received: by 2002:a05:6830:147:b0:69f:a723:bd60 with SMTP id j7-20020a056830014700b0069fa723bd60mr6632215otp.5.1681747417394;
        Mon, 17 Apr 2023 09:03:37 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id m9-20020a0568301e6900b0069f8ff38bcbsm4594256otr.16.2023.04.17.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:03:37 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v2] wifi: rtw88: Fix memory leak in rtw88_usb
Date:   Mon, 17 Apr 2023 11:03:31 -0500
Message-Id: <20230417160331.23071-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kmemleak shows the following leak arising from routine in the usb
probe routine:

unreferenced object 0xffff895cb29bba00 (size 512):
  comm "(udev-worker)", pid 534, jiffies 4294903932 (age 102751.088s)
  hex dump (first 32 bytes):
    77 30 30 30 00 00 00 00 02 2f 2d 2b 30 00 00 00  w000...../-+0...
    02 00 2a 28 00 00 00 00 ff 55 ff ff ff 00 00 00  ..*(.....U......
  backtrace:
    [<ffffffff9265fa36>] kmalloc_trace+0x26/0x90
    [<ffffffffc17eec41>] rtw_usb_probe+0x2f1/0x680 [rtw_usb]
    [<ffffffffc03e19fd>] usb_probe_interface+0xdd/0x2e0 [usbcore]
    [<ffffffff92b4f2fe>] really_probe+0x18e/0x3d0
    [<ffffffff92b4f5b8>] __driver_probe_device+0x78/0x160
    [<ffffffff92b4f6bf>] driver_probe_device+0x1f/0x90
    [<ffffffff92b4f8df>] __driver_attach+0xbf/0x1b0
    [<ffffffff92b4d350>] bus_for_each_dev+0x70/0xc0
    [<ffffffff92b4e51e>] bus_add_driver+0x10e/0x210
    [<ffffffff92b50935>] driver_register+0x55/0xf0
    [<ffffffffc03e0708>] usb_register_driver+0x88/0x140 [usbcore]
    [<ffffffff92401153>] do_one_initcall+0x43/0x210
    [<ffffffff9254f42a>] do_init_module+0x4a/0x200
    [<ffffffff92551d1c>] __do_sys_finit_module+0xac/0x120
    [<ffffffff92ee6626>] do_syscall_64+0x56/0x80
    [<ffffffff9300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

The leak was verified to be real by unloading the driver, which resulted
in a dangling pointer to the allocation.

The allocated memory is freed in rtw_usb_intf_deinit().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
---
v2 - Moved the kfree call as suggested by Ping-Ke Shih,
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 68e1b782d199..05c732644361 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -780,6 +780,7 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
 	usb_put_dev(rtwusb->udev);
+	kfree(rtwusb->usb_data);
 	usb_set_intfdata(intf, NULL);
 }
 
-- 
2.40.0

