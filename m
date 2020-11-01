Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466FF2A2059
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKARcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 12:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKARcx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 12:32:53 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3ADC0617A6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Nov 2020 09:32:53 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t22so5628109plr.9
        for <linux-wireless@vger.kernel.org>; Sun, 01 Nov 2020 09:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHeiVwCcJrFPyx2vdrB8vG9J7L8wGgVjGBknaCzrjgc=;
        b=UNtuhwZYtml6+lQilU0D8aNuz3Q9QMJ29GdtxK196wvGrIbkjFaN4V7E7JneGToM4i
         OxM+XSsL/XKttKIO7vN678d4hlaM+Z8qgx6ChdQVJj4GiGwwPviG9ACPTIATD2Lf+1aS
         LBYuvZp04dLnJkPfX7eI2ZB9qd0HvwbifWdfUQg+fS0J3XEehyB/JZZINvOQk6i7t0p/
         l63Z6SmfY5Hb+YCyoqODN5Mxcgd0r5zKSUYwbNvuxBnBtAzrYjPfVLnhx9RHb/6MRp92
         hbdbxhl9TbSNKhqoLCHwqqrJemk2QefDL6+apJBUGJlT0egD8T2m0fnPy7cOXG2dq8lo
         uCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHeiVwCcJrFPyx2vdrB8vG9J7L8wGgVjGBknaCzrjgc=;
        b=Kfxtt0Qn06PNBKJhLfvrXrqKj/qVDHURmPKfdNpufVe/lHGkahhSeIPm5wLwC/ED8p
         DtxAlRYsi9dUO0Agxro2ZEnpdPTglnCnZBEfZetvXJ8WYzmp7ag1GfcJOvJqE/7/Af+V
         rA/k5HpEIc+mJhTnE0dkK5IQmUj0Kh9tmOlll7oOk9Z4ANMM/enVuatucBVi7LN8oby0
         t7kqVyvt+k+cNzjvu8nJmiOZ+SCnIbn+PkipQjC1AzZp57GVBrtXD8c3bInPZBZ1vSHQ
         7biCT0rdz7GJ/N0gmGJs8SLMDYR4dsmxcqIxQodKorqpg6QW8e65W3ad+twWQXmgMhBN
         L2sg==
X-Gm-Message-State: AOAM531hvfUbhtyKSw+7GDJQzkCa+qiHfdEpazizdPE1fTlTixPdn/yi
        kxnj+KhfOlWeNumKAcT5hzT4w2GrTh6d4Q==
X-Google-Smtp-Source: ABdhPJyfR2CjTGxgykBPYXLr/ERqQf3Ep18X0PDzNK2re+uklDPJ4jWzsKQ5T9D1a4yiStaMjaPuXw==
X-Received: by 2002:a17:902:9681:b029:d5:cdbd:c38c with SMTP id n1-20020a1709029681b02900d5cdbdc38cmr16981681plp.85.1604251972302;
        Sun, 01 Nov 2020 09:32:52 -0800 (PST)
Received: from localhost.localdomain ([240b:10:2720:5510:8f22:949a:103d:7b6d])
        by smtp.googlemail.com with ESMTPSA id u5sm4567772pgk.80.2020.11.01.09.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:32:51 -0800 (PST)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices
Date:   Mon,  2 Nov 2020 02:32:36 +0900
Message-Id: <20201101173236.7851-1-ikegami.t@gmail.com>
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
index 5cd7ef3625c5..40291d594ade 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6761,6 +6761,9 @@ static const struct usb_device_id dev_table[] = {
 /* Tested by Myckel Habets */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0109, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Buffalo WI-U3-866D */
+{USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x025d, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8723bu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
-- 
2.27.0

