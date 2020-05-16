Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C621D606C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEPKpD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgEPKpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 06:45:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5384C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:45:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so6272622wrc.8
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HBMtOIlLuh0dSxmXZrr/4mcZt+nHKej+x25g85wOizM=;
        b=MLIXTsyT8CTy2m0XpubsDcvvDcuAxwLuCPZ78AeihNMgaBYJWULU1KpF3h1aH1BTSR
         QGY76Nk+054FW1BPly5bw1WJ8x4wvaDXzjQBqd8WUl0pFvHqkyUc6Qz5qxsqnaaInuOH
         LRgPew2VFNfh5DYWh3HeiIGKX7UNH+5mtCJOJOOVNxMCOP9tJUiWb8nHvKTv5BIf+G6f
         sYDukxEycYSWCLWhVSE+oUSouviotwdfJm43wX3FJ5io2h4b30sDlUTAkVGMyFneRKI9
         tew2jLvOflj9oTvxDRa73m4AdOMxEwYh5yzyTYoQNJy+jXi0KJ2FrDqwTvQHcQiQgI6P
         WDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HBMtOIlLuh0dSxmXZrr/4mcZt+nHKej+x25g85wOizM=;
        b=er4XLk+b90dSpAjdEebRixHMZYUjB2umkV9khW8zrCpwyKi90oBz15ByQ7YnxkyiNS
         ztFnNZZR0deVpDSr4W5Odja8ChvTtAWHwgWo8pBgNRFA1hn2wK1pnsbcZvVvSiTLfruC
         u/Z2CaXitaJ7NosUq2TBkySdLZRAb9IzzmtyXspwaQbzZ45DVLM+NM1I5lz1FojI7LDv
         uEk9tp6oANzVQEWfojxog93ihqaWhaNMcaXRgQIFDyXBgYYF/gkS3zfj4TfATPfBIlyZ
         7NZBMstjB2y8xLbclM/quCri/FVwM6fhiUZvLuHDnulIgAe0akPTeQ/9lnoKL82TfKpo
         yDlA==
X-Gm-Message-State: AOAM532kpqekhOEmUb6OsGwwhRknQ8kcLmj56qjQxoR+MFtNbkvWkHVo
        TkWikB0Ez+GABofBYcxAtFnaOxw8
X-Google-Smtp-Source: ABdhPJzwfrXZ7NmvbG60R4IPwSAhn/Oo92R/5KY9FK7QdptvWa0iKqJBgZDe3FhMHzwhW8O4BG53Ig==
X-Received: by 2002:adf:f783:: with SMTP id q3mr9032517wrp.348.1589625899101;
        Sat, 16 May 2020 03:44:59 -0700 (PDT)
Received: from [192.168.43.18] ([185.69.145.77])
        by smtp.gmail.com with ESMTPSA id a24sm7108957wmb.24.2020.05.16.03.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 03:44:58 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 3/4] staging: vt6656: vnt_usb_send_context remove variable
 data.
Message-ID: <9416e1a8-bd72-ffb1-5366-78361d053907@gmail.com>
Date:   Sat, 16 May 2020 11:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A limit is also placed in vnt_tx_context of MAX_TOTAL_SIZE_WITH_ALL_HEADERS
limiting size.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h  | 1 -
 drivers/staging/vt6656/rxtx.c    | 3 ---
 drivers/staging/vt6656/usbpipe.c | 5 +++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 074b98dfac91..08294b21c4e9 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -250,7 +250,6 @@ struct vnt_usb_send_context {
 	u8 pkt_type;
 	u8 need_ack;
 	bool in_use;
-	unsigned char data[MAX_TOTAL_SIZE_WITH_ALL_HEADERS];
 };
 
 /*
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index cf194c95df03..8f9904c8045c 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -73,9 +73,6 @@ static struct vnt_usb_send_context
 		context = priv->tx_context[ii];
 		if (!context->in_use) {
 			context->in_use = true;
-			memset(context->data, 0,
-			       MAX_TOTAL_SIZE_WITH_ALL_HEADERS);
-
 			context->hdr = NULL;
 
 			return context;
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 904645fa0eb0..43f1ef32a9ce 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -463,6 +463,11 @@ int vnt_tx_context(struct vnt_private *priv,
 		return -ENODEV;
 	}
 
+	if (context->buf_len > MAX_TOTAL_SIZE_WITH_ALL_HEADERS) {
+		context->in_use = false;
+		return -E2BIG;
+	}
+
 	usb_fill_bulk_urb(urb,
 			  priv->usb,
 			  usb_sndbulkpipe(priv->usb, 3),
-- 
2.25.1
