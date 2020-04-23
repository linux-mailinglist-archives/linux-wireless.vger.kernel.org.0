Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6395B1B6606
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 23:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWVOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVOd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 17:14:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8609DC09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 14:14:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so8338916wrt.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UqaUzhYpxz0lrWzJ6DPc0vNRY+etRrC0oeksk1Ww4Gs=;
        b=X2cJfeRWZp0JzMd8jTTQTj/Rb9Dl4QcQ4QoXMJZVALw3/l3qK8TpKqATlP4WVHvGDl
         N6bbd0rPPK49L39qy86FyYkc6bT8dPCdCwITha53gNhvImFyWSBpt3q1v9/xEnhNGJH7
         hj/7pcZS9qGaeJzB1OABn7AeB2MFfNEPIbFJnL3kmntVHsZhBy4heVBXnc4HNXfEoXAk
         V749tq9CvafXPuchZkyzNqSGFJ9IqKp6LYYOJ+hQn7LsL7BHt1kC2zgLqySoFZy5EI5h
         ekc84s/IrDp8rzqgm5bYwCcmwHcGeM8iKifX7VnwoGrfmH4rSDxwg9fuYLnVdla4uYyV
         bAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UqaUzhYpxz0lrWzJ6DPc0vNRY+etRrC0oeksk1Ww4Gs=;
        b=q/MMnS9zstFUXTs3M1kIW8VmQ9LGRfiGJpx+VSVHBTjEY2ul65Mf3zQoACuezzAMja
         T71WnfMUzmaB2xdPWv6eoSetZp27XuLf03kB/mmkGKoBRJEXwfS5xERkK/9ShAjooCp1
         /Gv3pK1orn07wtl/e32BNdX/C+d1sPXjprfn3Vs+7YbF7WyKpb/fAoNutQ3NGKkSm0PW
         TtxXfQYHMfYVMvG01r0wb5PPoI+zSQ/UNW27Vk7WUnLgsRA+KF+Gzsg9wwlrn7Ny62Oh
         w0oCsYp3EGdMpFAjheBBNQ/Wpv7/0MDC/Te2srxcPAzCJdEGXUwSg18M0y7uN7dh5CE+
         GWqg==
X-Gm-Message-State: AGi0PuZmaC+FXxlaiwDG/G86Sdi+aBVZFNrcd2sravpKTOvU5Mcz4eOZ
        9/cqoSPkMdpUvnFe9/Flo8w=
X-Google-Smtp-Source: APiQypLJzaiDg90Z9WoWkrOF+3EiBl2eIFduhI556E3nTfHEb6slLEJsFaZbrZWwnZWngt+HJKL13g==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr7552471wrt.394.1587676470238;
        Thu, 23 Apr 2020 14:14:30 -0700 (PDT)
Received: from [192.168.43.18] (94.197.120.138.threembb.co.uk. [94.197.120.138])
        by smtp.gmail.com with ESMTPSA id j68sm5538616wrj.32.2020.04.23.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 14:14:29 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: Remove set short time in
 vnt_init_registers.
Message-ID: <a2bfc4f5-3f7f-3718-6056-2907a004477f@gmail.com>
Date:   Thu, 23 Apr 2020 22:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The short time is set in vnt_bss_info_changed no need to set it
here.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/main_usb.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 4bca0b99cf45..c0545932866c 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -401,19 +401,6 @@ static int vnt_init_registers(struct vnt_private *priv)
 	dev_dbg(&priv->usb->dev, "Network address = %pM\n",
 		priv->current_net_addr);
 
-	/*
-	 * set BB and packet type at the same time
-	 * set Short Slot Time, xIFS, and RSPINF
-	 */
-	if (priv->bb_type == BB_TYPE_11A)
-		priv->short_slot_time = true;
-	else
-		priv->short_slot_time = false;
-
-	ret = vnt_set_short_slot_time(priv);
-	if (ret)
-		goto end;
-
 	priv->radio_ctl = priv->eeprom[EEP_OFS_RADIOCTL];
 
 	if ((priv->radio_ctl & EEP_RADIOCTL_ENABLE) != 0) {
-- 
2.25.1
