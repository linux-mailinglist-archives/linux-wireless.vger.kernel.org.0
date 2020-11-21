Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FED2BBADC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgKUAaK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 19:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgKUAaK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:10 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7496C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:30:09 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w14so9472049pfd.7
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=gcdftIt3k7j+DWB1YYReGNOxtmve/OrK2EJ+6TpRLPCWofdvlMLDJ2qIhsrxl+F6Bf
         FXxdl0v/tiQvXTHu7XwVUNcABy1kBjiit05TOJktP7nALErGGXnBXgm0yBctifeBLkGW
         1O9i/rTbw+43v81kNHuZxoJHLFWJ1Vs5eFDggfKoRH3W5X37iTgZWyWtrO3EFdYusHNc
         hnthmgGA21CdgLWXMnpJv4XQ4PGtJ+8DdzlZQNhS2ad0jDx9+ksphPYf6y0ZUswkiaht
         z1ZXF2A18cD8j1rUdsatwIfF4J4Gi+dqcIcT+rHHM+26kll3S7udWi0Knyu3F8eLqtuA
         iE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=lGwm/lYVChTscNtHQIowUPIyBKsxNggcoaDlOG513GD2+bpzi6xPasSTVDhpkQsa2l
         UuXQbas7X+keAWIRdPi9ba5Sfd0dlfQ8nIUHO1FtVhN6VguhJjath7kiVZaLnvQNoQaz
         abihstrZhm0rSUM+R14NYJ4EHqUynT0gEVvPZvmNCytWZvTJvHK50BpHgQ2wmXSecNct
         ZJm59rIDw2KLPKLNZ7VdXkVKnnqIvkLP8HtsU8Kzl0lD35PV4dNp7JPDmypcfnXCVYY4
         vAc978AaZfeCmtBLwCpzPhXAeohloY7fcgtWtoj1PKHbLz6x9UcONrsx/BOM4PYo1mSN
         cfbw==
X-Gm-Message-State: AOAM530tEbjUUk9gFuILCS/1k5T51yughfAnEguBwzQDJSRGG+Sd4qOi
        jI8jkMYoszIJX4VIBdUgclzrvVy/Z8jIhsbU
X-Google-Smtp-Source: ABdhPJy/pO8xLVEsraXQ/eiAP13+a4QU+UksZv+F5aNTimhffGO6x8bcFb5hi0TgqFXixN6sKIVT2Q==
X-Received: by 2002:a63:7706:: with SMTP id s6mr6161927pgc.439.1605918608417;
        Fri, 20 Nov 2020 16:30:08 -0800 (PST)
Received: from localhost.localdomain ([240b:10:2720:5510:ec4:b250:6b18:ddbe])
        by smtp.googlemail.com with ESMTPSA id k17sm5548224pji.50.2020.11.20.16.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:30:07 -0800 (PST)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] Revert "rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices"
Date:   Sat, 21 Nov 2020 09:29:55 +0900
Message-Id: <20201121002955.9007-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 28606150768a20b291a35dbbbb0ab4dd7d4739db.
Since actually Buffalo WI-U3-866D is falied to power on with the change.

The rtl8812au driver code to power on is same with the rtl8821a code.
But the rtl8821ae included rtl8821a does not support USB interface.
So seems that rtl8812au should be supported by rt1l8821a code with USB.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 40291d594ade..5cd7ef3625c5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6761,9 +6761,6 @@ static const struct usb_device_id dev_table[] = {
 /* Tested by Myckel Habets */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0109, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
-/* Buffalo WI-U3-866D */
-{USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x025d, 0xff, 0xff, 0xff),
-	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0xb720, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8723bu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xa611, 0xff, 0xff, 0xff),
-- 
2.27.0

