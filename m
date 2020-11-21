Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D62BBADB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 01:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKUA3Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 19:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgKUA3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 19:29:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42967C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:29:25 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so9482867pfp.5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 16:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=QXxHiHCbaJZMWYamJ0UKyqv91RqL+VEaNx3Xa7RDrDXgQOaw4PqwoLQjmvO01JokTp
         m5kkAFmO/NYMLocmya+ASW2Hjq1JHMtfFf1qtfPd3fSS8/un7ZPH2kEMJxkG4Fl+y7jP
         v12Bqh/z17HOtQUDH3lI4wcg5e/5pgKPfhHD+a0Jwx4zHfjeB/6xSuCY4E84dIc5QzAh
         FtIbE+2hCBMpB0mHNYa/G5qz9JlqmohW+X47i8/0x1/qK4I71EEJz6pDOLZmmFqUzShb
         I0uY29Uv/p/s64MxLQQqrlmFCeEP8SQwXvEN+tP/2YElHLNsL8Q/n0w1EYSk/yQGGEZb
         L28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olvdt7ki5fqHF/H4ohvOZWI03xMh6S5Vc6eypQqd3rQ=;
        b=qLsSKp4vBw8jgKh4uHX9tFAbztNaF2ol89eDCAxIhsnMO6gAm3/kRHmPejqtUxm12y
         h8Ik2djcMYRxlsuCgux7ERRZWeJZyCNuXMeHYN1vRZtECy8KlyG1SOsa4B3LQYDnG8jm
         GTCTvy3PL1tpzK7TM0Aeq2ydmToZy7UROwsiOMbjZ7JrYiD+XNbUiP4q/7Gv0NtKYUEk
         p3Ocks6frvR+ymr0uC8EuxYEVIuhHCKs/kHmhgMOgQrXtdCmDnhrWiE29A5f1frw7w5d
         glY2goOhsQUW2k8Sg7xJUXNRja7+2U0dnvxeVhU4NSdSjDJYbaJhpwxHmWkvEDjfIPAr
         sV+g==
X-Gm-Message-State: AOAM5335zkGS0cCtXeMEMI9+4UdImhSWpQ+KbVLzR3yr3h4bFXF9WG89
        iuikSwCbFQ28qBEdGJPLsDc=
X-Google-Smtp-Source: ABdhPJwLb4QWw5xTEw1nS5pedjE3VdVz/i7WjB+pxBqczUAjWljy5+1AFvYcoGudKZ2jHLEk/eWusg==
X-Received: by 2002:a17:90a:4208:: with SMTP id o8mr11655651pjg.19.1605918564663;
        Fri, 20 Nov 2020 16:29:24 -0800 (PST)
Received: from localhost.localdomain ([240b:10:2720:5510:ec4:b250:6b18:ddbe])
        by smtp.googlemail.com with ESMTPSA id 15sm13056470pjy.0.2020.11.20.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:29:24 -0800 (PST)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
To:     ikegami.t@gmail.com
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices"
Date:   Sat, 21 Nov 2020 09:29:14 +0900
Message-Id: <20201121002914.8942-1-ikegami.t@gmail.com>
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

