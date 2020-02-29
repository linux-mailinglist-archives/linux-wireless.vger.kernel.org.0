Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B445F1748E1
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Feb 2020 20:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgB2T37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Feb 2020 14:29:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgB2T37 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Feb 2020 14:29:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so6970332wmi.0
        for <linux-wireless@vger.kernel.org>; Sat, 29 Feb 2020 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=w5vEkyoOl+Ezm0+zDepgiNeDHkQLkere0DjeAVL4ezA=;
        b=qcqOA5nLHXm1JkABeNn0ekmYYuqGlo4k81IVZZ5/9FpQ8u2e0XpCUU6IiD78VSfjYC
         uNeWjgI8HXjkHBjYNMjq5XPNA4JvUyQ/Q5FpIv470NBEebOx7tp1suzW5HkaahEHO7x/
         pI4w59xE7LJ1+O9wbed3oqOvHUF11IP7xdyob4cp1Wy8jquT8qQ7hh0NvXb9yZWfqsZz
         Ti8jdLCey+i4mlj7oNoiXou/CwtFhlSHJh5wzwOLAqEMjv3t05YxK0XJkhfVmqwP5BSI
         8LtBZub52KqOrGzUS4GjoKYy6WCA8tw5mzEuQQGJPqVxL1Bguzh4nnEmltPU1PCLLAKD
         25Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=w5vEkyoOl+Ezm0+zDepgiNeDHkQLkere0DjeAVL4ezA=;
        b=iVsvM6/3Kglu9/Kr23nHUF6jyT1ZfNVeXQFNBsHVBXNYXYApwD/8akJFl7Xy6AGS4d
         o09JNxwN27eMZm97BqIbVZoLlkOyqFlV5cWZTuQpQcPVoxIEzJfJP/I4iwTbby5nGMgm
         ZqaIqP2b0fIP0KbrtWcIkgGwcryt6mjTxjbVMx0x4JU23d47Mm5khTu6r7+X96yca9ur
         8MOaS42Ng0PDI39nYr4ndk05W3qJAf/QgfzA+BefMRy2FKR/et4mGcmWMR/5o0UREaq0
         260VVgIATSE3mu9jttQwW06dz1ecoYbHOkehC9nzNSGXVVZTSDf45q3ph3ppORWC6FFY
         Z0fQ==
X-Gm-Message-State: APjAAAVcLkQ993O6APTwIaacj3YKwh9K40sW3zhbds0x6iT122iMv3X5
        hibksf+vLZs6Rlrr/qYPYxLyr1FN
X-Google-Smtp-Source: APXvYqzzZj/9nZgbdTCuloJJo+oYheRSlsRXmgCMX3q1dAwqW8FSaVAVaAZSXzOWj1B5SGlTg5Cneg==
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr11074048wmd.11.1583004597738;
        Sat, 29 Feb 2020 11:29:57 -0800 (PST)
Received: from [192.168.43.18] (94.197.121.166.threembb.co.uk. [94.197.121.166])
        by smtp.gmail.com with ESMTPSA id o9sm19369573wrw.20.2020.02.29.11.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 11:29:57 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH] staging: vt6656: Remove STATUS enums from TX path
Message-ID: <21bf299b-63e0-9f65-c7db-6e0b72e0f1d8@gmail.com>
Date:   Sat, 29 Feb 2020 19:29:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Returning standard error code or status variable.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h  | 9 ---------
 drivers/staging/vt6656/rxtx.c    | 4 ++--
 drivers/staging/vt6656/usbpipe.c | 5 ++---
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index da868adba7c9..5c9991415432 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -256,15 +256,6 @@ struct vnt_interrupt_buffer {
 	bool in_use;
 };
 
-/*++ NDIS related */
-
-enum {
-	STATUS_SUCCESS = 0,
-	STATUS_FAILURE,
-	STATUS_RESOURCES,
-	STATUS_PENDING,
-};
-
 /* flags for options */
 #define DEVICE_FLAGS_UNPLUG		0
 #define DEVICE_FLAGS_DISCONNECTED	1
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 1003808ac4ad..9439d190f431 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -704,7 +704,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (vnt_tx_context(priv, tx_context) != STATUS_PENDING) {
+	if (vnt_tx_context(priv, tx_context)) {
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return -EIO;
 	}
@@ -797,7 +797,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (vnt_tx_context(priv, context) != STATUS_PENDING)
+	if (vnt_tx_context(priv, context))
 		ieee80211_free_txskb(priv->hw, context->skb);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 7bfccc48a366..e93c2175543f 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -317,7 +317,7 @@ int vnt_tx_context(struct vnt_private *priv,
 
 	if (test_bit(DEVICE_FLAGS_DISCONNECTED, &priv->flags)) {
 		context->in_use = false;
-		return STATUS_RESOURCES;
+		return -ENODEV;
 	}
 
 	usb_fill_bulk_urb(urb,
@@ -333,8 +333,7 @@ int vnt_tx_context(struct vnt_private *priv,
 		dev_dbg(&priv->usb->dev, "Submit Tx URB failed %d\n", status);
 
 		context->in_use = false;
-		return STATUS_FAILURE;
 	}
 
-	return STATUS_PENDING;
+	return status;
 }
-- 
2.25.1
