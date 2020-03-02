Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF61765A9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 22:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCBVNd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 16:13:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCBVNc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 16:13:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id 6so632200wmi.5
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2020 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/+jAgbqODV6zfZn8QYllJrAWqpbAilb+ByG1dEQFoTI=;
        b=Z57J+9Mw7IFmL3JLrP8T7LAr056lkwB99n9qv4N2C/H7ReTKRNDU8nGtCvcQRo3cdN
         tjYtQd+nxYBpgYK6b1fUn6oJ0DVZWL17pZinObzpI/Dfe6HPKT7pwvVxYTnEqzbph6Vn
         MW6ZzN77hvb1STkpoDqMdR0XbNHDhwQF335RcwEiny6EtaWwFosxvNsUWiyOt0zzHBaZ
         3sa7RUOvRvma6ILhlFvg5KzNePYzEgxWGy6xOoFBCYpnf22HkVC8TlxCRW7uESAuHPv7
         5s8P04i8esgi+LA5D1RtOmiqLug//1+J3ZMVsxAAVD/nNiwVQsdgB1N4JAhQ0jGYBrDq
         a+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/+jAgbqODV6zfZn8QYllJrAWqpbAilb+ByG1dEQFoTI=;
        b=W4jsKlQjbT29usPBhLo5OMVNK9uO+iWIheOfnCUw9uEeiAV/0Wu7CI2rJ0US6E7h+1
         p08wq6Tf9oEFpN1tRd5lWzufKtdGHBNWQ1NV2DboAKdyJusUVHqbzYE5ZPLyfU+8hvQ/
         QNXiJtZ5/7MUQh3ihuFhkUQESKDSTWFZmxdHDL6cW2ijo45IhnpDRQ/4imaZ3r+fp0P+
         jvCVqS7/xxveq5ToKn5ZTWdLDtiGLMQOnq+fRbRj1ZdjxVV9bg08EOcJ3+8qyol+UAns
         8i6IgjoN7NN86sHpBKKNswljLpm6gCnQeLVvv9/3S1yo9MS/oZ9JXOaCjSbrWMQGn4Zv
         /P6g==
X-Gm-Message-State: ANhLgQ11kr/ZKI8UY/BAesjFXAm1f6rEgmswpMETMofJaeIi6C96+8jf
        b1H8zTCZLLH5v+aiLZnEHYF/jdr8
X-Google-Smtp-Source: ADFU+vuuRMJ6xQ1KS3gBLcSlUwjC/P74kdqs4m4AOK9sIi0L/9TBRhkATI2dk94eYER9Oi2Nm0XmiA==
X-Received: by 2002:a7b:cd8c:: with SMTP id y12mr335113wmj.5.1583183610759;
        Mon, 02 Mar 2020 13:13:30 -0800 (PST)
Received: from [192.168.43.18] (94.197.120.139.threembb.co.uk. [94.197.120.139])
        by smtp.gmail.com with ESMTPSA id u1sm11501634wrt.78.2020.03.02.13.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:13:30 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/3] staging: vt6656: vnt_int_start_interrupt remove spin
 lock.
Message-ID: <871a78d4-6d3e-f34b-d0ae-6123803c6faf@gmail.com>
Date:   Mon, 2 Mar 2020 21:13:28 +0000
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

This formed part of the legacy driver and potentially multi
users.

The driver now has only one user mac80211 remove this lock.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/int.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.c
index 3fa61c368464..fcf92cd1234b 100644
--- a/drivers/staging/vt6656/int.c
+++ b/drivers/staging/vt6656/int.c
@@ -26,16 +26,11 @@
 int vnt_int_start_interrupt(struct vnt_private *priv)
 {
 	int ret = 0;
-	unsigned long flags;
 
 	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
 
-	spin_lock_irqsave(&priv->lock, flags);
-
 	ret = vnt_start_interrupt_urb(priv);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	return ret;
 }
 
-- 
2.25.1
