Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23172A204B
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgKARXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 12:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKARXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 12:23:35 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12CC0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 09:23:35 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so8794904pgg.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Nov 2020 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAcUCNLzx6+O0zQu47ccphgR7ZEoasSXxbEime98rBk=;
        b=SgvXrS4JVfWggxLGy83qIZBcEPJZa7MkhRsa7NIUg/2/fScJieThA+wa42Caueha5z
         SQQBPB2eaq+t7RvoP2WqUSMl7Pr6sJbr/XVDeAcT1JeRmpHwM/UhkCCa3ibGWmSDsbYH
         bjC1cCFbgxv2TyMnVCJOraemKAohcanq8l7PBXk8iKmYwR5n5rIPsEXrpJ1OZQZclQ4y
         EIDR7OG68gWGHlLyIExbau6RkP0aI0UYeUC91yOAe3Jd5fWxgKFtk9OXavUjzbCSJvbY
         r5cIhZDE1VoFnOeQaNZVda6HCqxoT/afqhrMAuiHy9lH6NAQMB/Qk8CMgfpoVevyKw27
         dcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uAcUCNLzx6+O0zQu47ccphgR7ZEoasSXxbEime98rBk=;
        b=DHb0fkfJkafJ7/gr7yP+flrCt1IqpeY4RbSc1r1O54pTEvMVEAx9VJdcgjv1iKUgOV
         USaA5dWEbw7lqSwz095mqKOVDLcLkBaPiNx3nw08vfQhDOHiMUlzDyV7kbRkF4y7seq8
         CtZsKBju8Zq0wqOT0AOJA7PJH95qbd5YtNhm7+HEnWLyRI9BUgIKEzXEZfsyH8a805ya
         307dofmGXHP84nGi7Ki1nGxiVTwrF/slr8dIcuOhS0fXokpLSXVjii34fKQzHpoc3Ymv
         KqDrjJ64ZzGZrST6cERMasMwAAG5/YRegtBjmWjqaq3OodoTp41ew0+Of8EuuTrWSKaF
         cOFw==
X-Gm-Message-State: AOAM531K5tNCyT7UONHVa5p//ideCakIcW/kGL+3kBTe6H5jwF26WFgm
        q8pV95yAMH4ZSdKYBgbLQWSEejTdjb2Mew==
X-Google-Smtp-Source: ABdhPJzBv9qiMXrxB2IXh44u0I4fWY5jyqPCiZ12eJM7GFobtuWFfAwxlI0qqL7S1lARuLX2H1wk+g==
X-Received: by 2002:a62:16ce:0:b029:160:5faa:23d5 with SMTP id 197-20020a6216ce0000b02901605faa23d5mr18375110pfw.26.1604251414634;
        Sun, 01 Nov 2020 09:23:34 -0800 (PST)
Received: from localhost.localdomain ([240b:10:2720:5510:8f22:949a:103d:7b6d])
        by smtp.googlemail.com with ESMTPSA id p11sm4486425pgb.67.2020.11.01.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:23:34 -0800 (PST)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices
Date:   Mon,  2 Nov 2020 02:23:17 +0900
Message-Id: <20201101172317.7412-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Buffalo WI-U3-866D is supported by the rtl8812au driver.
Also RTL8812AU software supports the product RTL8192EU also.
So add Buffalo WI-U3-866D with the RTL8192EU driver info.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5cd7ef3625c5..226c85ab3aa9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6761,6 +6761,9 @@ static const struct usb_device_id dev_table[] = {
 /* Tested by Myckel Habets */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0109, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Buffalo WI-U3-866D */
+{USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x025D, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8723bu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
-- 
2.27.0

