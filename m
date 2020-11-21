Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A52BBB0B
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKUAeR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 19:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgKUAeQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 19:34:16 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E0C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:34:16 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so5737041plr.9
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=H3imSh4VfouO45PN/i7nkB2699o3zHWfzE0iBa0zNmZUBzZJGHKfA0H2bUgq2xKYIg
         tH2eWgeGDL5DGfVN0fn160Ul8UaN2U5PXqw/P2iaEeW+BtqU693J7IKHsR2zn7sGLrvn
         wdXBf0SeExc6aMNlLGJlBcf0o2wAIrnB3LW2m8NUUNXO1yDGt+8IqPBEzMk5VNFlWRzo
         O8IcQtxouI50lEPWQGmJ+M+xcBef6dwwfZcD+4VLXsYSkXVFt9Eh9ZQxAr5caQ2+FnYs
         YPeV1yrH5ze0Hrgx8Eqfj2H3nWikHYGMLZO5+coWNRRijNyqwyZryR7eD7sfqyu9mByB
         47Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=aw2RU1vs4pgvlJz0kVBQD33Q4z8FPJYgrzJNVLGAB+FFlBbSnoqgZuvXBxQxeJSBt6
         bGP66Xbmatnyd9ihD+UzSdB/v73mokYUxyqY/cGRt4j+cSTOD/aQN+fezvw0WaKZErij
         WiKFytTf7GZBk5khiOlddFM/4IvgvKBbcYnoMloyKKuh9PxyF00UJO5D+B6iYt7Y0q7H
         yAGQUtUS2P8QEiqq951k7GD51JQZ4HxKizRlP6hjEOy277XE8zDftjYBOrbmaopbJBt+
         pIKod0fNz5m9EnHqRYcCVzaQ81ygaCJEB/Nn0QS87uDe4KIMKusiMKVmmr2/ZDDW2wmc
         XNYg==
X-Gm-Message-State: AOAM531HfIkICqsiVSySkwJuIN98zr2/hHm0kv+Bl16pnEQPY8oerBAd
        8vb3NCab8jetiu4HCR54Uz8=
X-Google-Smtp-Source: ABdhPJwANGtEhbLtCNyOsdm57ODvN1Lfk7qoTliL9gZLYq7OQNRwzVmJatGkkreWWZCBVf54mLdtZA==
X-Received: by 2002:a17:902:c20a:b029:d6:b2d6:8006 with SMTP id 10-20020a170902c20ab02900d6b2d68006mr16238532pll.31.1605918856286;
        Fri, 20 Nov 2020 16:34:16 -0800 (PST)
Received: from localhost.localdomain ([240b:10:2720:5510:ec4:b250:6b18:ddbe])
        by smtp.googlemail.com with ESMTPSA id x13sm5226030pfj.54.2020.11.20.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:34:15 -0800 (PST)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     ikegami.t@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices"
Date:   Sat, 21 Nov 2020 09:34:11 +0900
Message-Id: <20201121003411.9450-1-ikegami.t@gmail.com>
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

