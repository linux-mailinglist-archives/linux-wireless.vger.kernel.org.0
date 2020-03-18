Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93D118A8FC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 00:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCRXIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 19:08:05 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39601 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRXIF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 19:08:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id w1so552347qte.6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UXmRlgfID0Xxnp+jZ1RXGIQFHPz9yFcvNzZubq9Vo80=;
        b=qKwr8qtKCZ7ayWL8TehlUMRKKBIzPztWe98YQatcXr9p/5s/e2cvNL0teXpSfLt50r
         h8X/dCh+jqZz14iYeMXNE6KgDIMx2lIYzMCIw/5164uSpGffUv7OvvedX9k0i71u6+VO
         wbTukfWqhR3KGipyXr3+D/0wUTxwuXc/GFOdvhRuT8EhzjoKK1tOHhbLhXZ2Qan4G0cq
         CTPLgmIPhn3RqaZxyLhIr2nCBq4uMVeWya+CUgcpstU+VvmAsrT49MYuLtehlUX8cevU
         EqiwXd+1zgt3VUJgoNyzsnM5eARyUmWuwOr73tcLS+4LhJvsvB8yd008NmtGOzbV2KIX
         picw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UXmRlgfID0Xxnp+jZ1RXGIQFHPz9yFcvNzZubq9Vo80=;
        b=AwyBEI63ji+QVcG3p7BqKuP6dkSXfCSePf+8yeb1Opjv7SOJjnB3KwylAKaS46gPy7
         sihFa/Aes2HaPZTx+ErLrSBGhildJBETlsbqK0vaBTMe0KlkXGrUPpaQK+QibhXYTR18
         wUMQUM225eFFMUAHCzqXDxfxqVfPT4UumCoeotAzjqqeXjVxuPLnEKyDcvkgDKTD7eLj
         qQp1afw2Odj+MtCw8X8IswzCrKYj9OWA49anRmZhQmEBO0HPEJIscDPQGdebI+34GUzW
         eCkwA434+ZORKoouJijhZtnW5d4qx/xU482Up6w3o/RylW0BT5p+P6o2jMvl3HUoZb/p
         KeFg==
X-Gm-Message-State: ANhLgQ3ohQuMOz4z0+2ZVJdnF3VNFHq4Z5PnZIunmXqvzXbLLIQ3knI8
        DObHkzkUT3wrm/XYwIChfBxUCUyeBfAMght4BuJtotCp9OB4yaqaHH6XO8AgmiAiUU04yKr8AiV
        XZ1Qm1/Z5kW07AfSFAHJeT8p9oZ95rOh3gxf71wCZ1xy6QGjv0kZzn6hMrB4mdTWPAr469XCTT+
        YIts8m/QDL8I82WZBpkg==
X-Google-Smtp-Source: ADFU+vu40w5qIu9W5SGcRjQQLB66wXO3GDMg20CXRxOquYneNQSzBlVjuahigNIouzwaL4E56sz3X3PyWMKdFOwe+Yud5w==
X-Received: by 2002:a05:6214:186f:: with SMTP id eh15mr275510qvb.249.1584572882178;
 Wed, 18 Mar 2020 16:08:02 -0700 (PDT)
Date:   Wed, 18 Mar 2020 16:07:48 -0700
Message-Id: <20200318230748.30096-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] MT76: Add support for newer versions of the XBox One wifi adapter
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        royluo@google.com, Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current version has a new USB ID and reports as an 0x7632 device.
Adding the IDs results in it working out of the box.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02.h    | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 0ca0bbfe8769e..c7c601f0348a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -211,6 +211,7 @@ static inline bool is_mt76x0(struct mt76x02_dev *dev)
 static inline bool is_mt76x2(struct mt76x02_dev *dev)
 {
 	return mt76_chip(&dev->mt76) == 0x7612 ||
+	       mt76_chip(&dev->mt76) == 0x7632 ||
 	       mt76_chip(&dev->mt76) == 0x7662 ||
 	       mt76_chip(&dev->mt76) == 0x7602;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index b64ad816cc25b..a6a14621e8a93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -18,6 +18,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
 	{ },
 };
 
-- 
2.25.1.696.g5e7596f4ac-goog

