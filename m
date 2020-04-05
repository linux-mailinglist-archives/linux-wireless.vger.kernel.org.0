Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DF19EE5D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgDEWHP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Apr 2020 18:07:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54000 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEWHP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Apr 2020 18:07:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so12804027wmd.3
        for <linux-wireless@vger.kernel.org>; Sun, 05 Apr 2020 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peG3TSM125daYxWC/2EFWMDab5RxR8LW/FgCsF+8Ga0=;
        b=awIP6QaEf0EGmnYQa88tViwXmy570MvIzQoLawJb8NYBodkLOgJNnph1X+kop60Y+s
         jQD6PkV+0ieBs1z1RGJM3ikAgr8m/gJwCYkjBCmGHAyuzIDoMrTQUdDw0zoM4fzfB/fY
         D7mkB857aM8jtWD27nsBqjOwfNeBgs1M2r+qPTeMEz0wD38B4A8UoTKu23ZLUf/D4OzI
         Lvtk0mqZgbJ3iuXcSculN+e7nd8mAySsNi7JC1EZ1RMg6K4mrKbfUQjDdKIeHK5qF0KF
         cmD06CcwG/gcHdd6pN7P4XTal6Ll4FlNFtLUwLepOVsfn1QJ0Sybk5oh9aBTfZ6oAOb3
         TqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peG3TSM125daYxWC/2EFWMDab5RxR8LW/FgCsF+8Ga0=;
        b=d70DUQiWUYbGP3JqnJFOqCnAuPn/35RyrnZPcwlrsHHza3JGAsymvw++aG+h8W8Mdf
         gkkbFzDsunD/15oX50OTA9iH+hjxeAFQC3GykrLw4cCJ8cOBGW3/d+gbpLIWJmH+NrsU
         ivQtY2cGDm78H9rX3FSVSyAH4cqzgmTCqe1swJ6nfg/syFMJ2CRHQkZoqwyBmEuNpaTN
         ghlahU6uXhNu8OfG9GRYd7tTj3S2APhKcOw2BfUW7BzTwOyELhGXKMqZ/WDEtB/0Vw+A
         FzGxWfpH55g7dpDhHGpZcuHBtryc3yFrJFbcHT/tWgtL3SfT8BoQ/78vgg2FTH0MGSJk
         SqrA==
X-Gm-Message-State: AGi0PuZDOA18vrAUL2Dcoh8eGi4O04NVpQ3HwwA2BA6IDf7ymlXZRWmh
        AJSz0beMfMZmHHAj4kkPGEIy3Bkh
X-Google-Smtp-Source: APiQypIM0Z3Jpxu4tMQMSoqZAuo9ukOewHBACncHm2zcAN385VKgTemsh8mJoEJ387ILDJPdS/xIBA==
X-Received: by 2002:a1c:b144:: with SMTP id a65mr20623786wmf.54.1586124432732;
        Sun, 05 Apr 2020 15:07:12 -0700 (PDT)
Received: from debian64.daheim (p4FD09DF8.dip0.t-ipconnect.de. [79.208.157.248])
        by smtp.gmail.com with ESMTPSA id t12sm24106185wrm.0.2020.04.05.15.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 15:07:12 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.93)
        (envelope-from <chunkeey@gmail.com>)
        id 1jLDPx-000BsY-DI; Mon, 06 Apr 2020 00:07:01 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Giuseppe Marco Randazzo <gmrandazzo@gmail.com>,
        kvalo@codeaurora.org
Subject: [PATCH] p54usb: add AirVasT USB stick device-id
Date:   Mon,  6 Apr 2020 00:06:59 +0200
Message-Id: <20200405220659.45621-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>

This patch adds the AirVasT USB wireless devices 124a:4026
to the list of supported devices. It's using the ISL3886
usb firmware. Without this modification, the wiki adapter
is not recognized.

Cc: <stable@vger.kernel.org>
Signed-off-by: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com> [formatted, reworded]
---
 drivers/net/wireless/intersil/p54/p54usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intersil/p54/p54usb.c b/drivers/net/wireless/intersil/p54/p54usb.c
index b94764c88750..ff0e30c0c14c 100644
--- a/drivers/net/wireless/intersil/p54/p54usb.c
+++ b/drivers/net/wireless/intersil/p54/p54usb.c
@@ -61,6 +61,7 @@ static const struct usb_device_id p54u_table[] = {
 	{USB_DEVICE(0x0db0, 0x6826)},	/* MSI UB54G (MS-6826) */
 	{USB_DEVICE(0x107b, 0x55f2)},	/* Gateway WGU-210 (Gemtek) */
 	{USB_DEVICE(0x124a, 0x4023)},	/* Shuttle PN15, Airvast WM168g, IOGear GWU513 */
+	{USB_DEVICE(0x124a, 0x4026)},	/* AirVasT USB wireless device */
 	{USB_DEVICE(0x1435, 0x0210)},	/* Inventel UR054G */
 	{USB_DEVICE(0x15a9, 0x0002)},	/* Gemtek WUBI-100GW 802.11g */
 	{USB_DEVICE(0x1630, 0x0005)},	/* 2Wire 802.11g USB (v1) / Z-Com */
-- 
2.26.0

