Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01276E2E1F
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDOBOm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 21:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDOBOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 21:14:40 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150F5FF6
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 18:14:39 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1842e8a8825so24048528fac.13
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 18:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681521278; x=1684113278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1ux7BynvNGEk35o+KZscjx5hsHHLSRG85my7bGUDi10=;
        b=HLESMUEDq9+Op19jklfwbEHY+amUO3IlMuDUGSFBNJ3Zj7npL1iBpf66vSGjGZ+3bK
         Nm+fzZLJ/00vNF/Ekck8SO624WQjqe1ntGr+D+OURd0nlFw78XOpAxjqAj0IrbHEYOXg
         PgzLo29mKqNbyFlHcz8nmWVLnUr+tZkgYQYVaWKUoEgLY36CURS0ef1en211sxhmcqGy
         aPIo+THpTjxMGy1ur1ecpNbQP+nMq8VoVuRE88ISL0l0Aj23MzaNnFJXYsm/1wKP0puk
         m/8pxqIwRhId/4RTK2skrcnqmIC6XbB50cCf8hJ/iq7qxQ4TqsLOE6KE7t/lGUzQ4LhZ
         eiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681521278; x=1684113278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ux7BynvNGEk35o+KZscjx5hsHHLSRG85my7bGUDi10=;
        b=VBVZgawYxmTj09WnCemG714oO3r9050KY3ID/FE3I9mUPIWs7AtC/pmVGRZoLh7rfz
         1S9z8E5N7QF82UihdFuwnaDjN1gMPX3Z+zZdV4DIPmVDTXTRvBoP45XXXy82rQbLd31L
         +RJRavsyIJY3KqocEdRMxEmpV48j1W+iRpyqTHXh/ahmMRGepicDjz32oF6JqqTnSVBq
         vn0dl589yYk59L3dOzMy3N1FhgYHMYkJd+lp450h5LhIEuenLmJFVbTYp8MogsLDNF4d
         HtebX4lxy304vAVb7DbXOoavJBA20nVrDmUxcqRbSeOnQhHIUQZoVreCyqWEVRONdBBX
         V1eQ==
X-Gm-Message-State: AAQBX9csxTRrfXol+CXxv9HimOSQ92JsJEbCbeVhskyPUC08y4MhT7pQ
        Gccb2E5ZoqrQO7DhcOWwuBBeunO5Z+E=
X-Google-Smtp-Source: AKy350YrVFvV8NNdnOlao7/YvWTAlv9Tzzr3XpbjGd47MI+f3hr9eKEalLwGnj3RzZp3wJFf5GS8Yw==
X-Received: by 2002:a05:6870:6393:b0:17a:f88a:a1ee with SMTP id t19-20020a056870639300b0017af88aa1eemr3759930oap.25.1681521278531;
        Fri, 14 Apr 2023 18:14:38 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id dw19-20020a056870771300b001729072f759sm2437529oab.0.2023.04.14.18.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 18:14:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] wifi: rtw88: Fix memory leak in rtw88_usb
Date:   Fri, 14 Apr 2023 20:14:22 -0500
Message-Id: <20230415011422.11162-1-Larry.Finger@lwfinger.net>
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

The allocated memory is freed in rtw_usb_disconnect().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 68e1b782d199..d28493a8f16c 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -882,6 +882,7 @@ void rtw_usb_disconnect(struct usb_interface *intf)
 	rtw_unregister_hw(rtwdev, hw);
 	rtw_usb_deinit_tx(rtwdev);
 	rtw_usb_deinit_rx(rtwdev);
+	kfree(rtwusb->usb_data);
 
 	if (rtwusb->udev->state != USB_STATE_NOTATTACHED)
 		usb_reset_device(rtwusb->udev);
-- 
2.40.0

