Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464D1174933
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Feb 2020 21:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgB2Ud7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Feb 2020 15:33:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42510 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgB2Ud6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Feb 2020 15:33:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id p18so7579478wre.9
        for <linux-wireless@vger.kernel.org>; Sat, 29 Feb 2020 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Zt3dq1OUkMEUcUXW65qyxooApGG+qBeaodqKhZlMmPE=;
        b=JbBDTY++uSsVrcYM05asL6cIXEST1QQi6vSxyskSsjGDkrsnZGvIJcvG/XPIPBnqKp
         PFrt7L1A0B0Hy99+rv8yAw8SEE5sPCtfVHnHb4pj7Nnlwxu6AoaDbNrozSJ61KZOmvNd
         JFi3S1nTzfTvXGmssIJVRK0MySvv3RtvGCxdAIgBK7taVUakmntRsp2oHat26dfDy43l
         7TRmgM9WFxH0wjV8XJKA+74DEEIllSN8Gvb3IGoJz9EZ6TMgbOC0l+sTZnW0YORtqGAo
         uTYo9o0OLtSw6SFzznqxP20u6VmHOOAriwO9hP+gdKQqma65k7Lw4sB6DU4lNOLvw3ax
         2hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Zt3dq1OUkMEUcUXW65qyxooApGG+qBeaodqKhZlMmPE=;
        b=syYt91BAYCOAnazfWm9WIuki/dR1mM3GFDirmbrqPFYQPhb+ZcBpJzw1D+REeLhvtZ
         eM0B8/TH6ySWYcQdrO57TQbKEkhXio5i3GMjkdFkuUVdmphjwQVTbpHrA0X19kRuBt8W
         P6VcIn4a19w0DEKfkWVAwnL4+UW6+sd40u2ePaRMS7B+mC70a6rwFeUYNLBw2CHhVnYF
         5YV6oiGLeQcprq2HlL1f+sxoZfemaCS3B816kCho5AnuKD6gVxeyfysK0aGGSfMPCDms
         Rjel/e7vZ94Jtz42cWNy9UCpaitff9y+6TtDj7LPwQU/1itgX+CIugD/1VaawFVznAna
         iMKQ==
X-Gm-Message-State: APjAAAVxOueoL+w0GYctz3Tcaa+6HL6PmdDURcCeqx+hKtgeZ1siBcfv
        xnaImt+eHzK0G1Tf1RJoR/esNaSX
X-Google-Smtp-Source: APXvYqxzp+Dj+OvCiZn/aP2YmRrI+t1wRiYoB6g1TCn+nuk3NEGo5KZXit5wv97r9XkPXnV3L3VIMw==
X-Received: by 2002:adf:9282:: with SMTP id 2mr12657562wrn.124.1583008436742;
        Sat, 29 Feb 2020 12:33:56 -0800 (PST)
Received: from [192.168.43.18] (94.197.121.166.threembb.co.uk. [94.197.121.166])
        by smtp.gmail.com with ESMTPSA id a9sm19644051wrn.3.2020.02.29.12.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:33:56 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: use vnt_vt3184_agc array directly
Message-ID: <4b455ee4-7ac7-e1ff-4a10-2d99f2e30714@gmail.com>
Date:   Sat, 29 Feb 2020 20:33:54 +0000
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

vnt_vt3184_agc is always the same regardless of rf type
so use the array directly removing from stack buffer.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index f18e059ce66b..48a624bf00c0 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -367,8 +367,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	int ret = 0;
 	u16 length;
 	u8 *addr;
-	u8 *agc;
-	u16 length_agc;
 	u8 array[256];
 	u8 data;
 
@@ -386,8 +384,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
-		agc = vnt_vt3184_agc;
-		length_agc = sizeof(vnt_vt3184_agc);
 
 		priv->bb_vga[0] = 0x1C;
 		priv->bb_vga[1] = 0x10;
@@ -398,8 +394,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
-		agc = vnt_vt3184_agc;
-		length_agc = sizeof(vnt_vt3184_agc);
 
 		addr[0xd7] = 0x06;
 
@@ -413,8 +407,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		priv->bb_rx_conf = vnt_vt3184_vt3226d0[10];
 		length = sizeof(vnt_vt3184_vt3226d0);
 		addr = vnt_vt3184_vt3226d0;
-		agc = vnt_vt3184_agc;
-		length_agc = sizeof(vnt_vt3184_agc);
 
 		priv->bb_vga[0] = 0x20;
 		priv->bb_vga[1] = 0x10;
@@ -430,8 +422,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		priv->bb_rx_conf = vnt_vt3184_vt3226d0[10];
 		length = sizeof(vnt_vt3184_vt3226d0);
 		addr = vnt_vt3184_vt3226d0;
-		agc = vnt_vt3184_agc;
-		length_agc = sizeof(vnt_vt3184_agc);
 
 		priv->bb_vga[0] = 0x20;
 		priv->bb_vga[1] = 0x10;
@@ -454,10 +444,9 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	if (ret)
 		goto end;
 
-	memcpy(array, agc, length_agc);
-
 	ret = vnt_control_out(priv, MESSAGE_TYPE_WRITE, 0,
-			      MESSAGE_REQUEST_BBAGC, length_agc, array);
+			      MESSAGE_REQUEST_BBAGC,
+			      sizeof(vnt_vt3184_agc), vnt_vt3184_agc);
 	if (ret)
 		goto end;
 
-- 
2.25.1
