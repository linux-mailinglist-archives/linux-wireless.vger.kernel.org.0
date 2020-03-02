Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9251765B7
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCBVQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 16:16:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35378 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCBVQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 16:16:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id r7so1697097wro.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2020 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8AnoNeDdMH20PXacSn59CEXHM7eY06izLZGO6XE29os=;
        b=WcULC1MazSLvQr+LcM5zwVVaXuY97FoKzhszrsw4F/LwFYLFLVXMHQX3tkfDyezwOa
         tEE7focHjQSacFVL9LLodx+TXUBIYiLuGUjtB0avZ0vFJZFsjeuDz3w+dfAYQVcUq602
         /PRLd50JJi+SjoP7JwnQvCIP7O4aaK2B3IAV3nrIsWZD86RZorxYIFnvrxBvhPko6vht
         iLAWVZlfPhfMWIsUW6USdGq9g1XcOCt7aOH/kG7bYblAkGxOiMdt0Tk0skhMkaj+jVc2
         8NmHYTGLftCpmjuCafaiyQkrsGjMJZWP49hHtRpNX1lJlKMwbbMEFC+yFVBCGiRaSDD2
         rb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8AnoNeDdMH20PXacSn59CEXHM7eY06izLZGO6XE29os=;
        b=EvJ8MWadIoXsBno7HKv6yZPtbxNh7z9p6R5zW81LnJXfoue1Vpg7zowIYAkhxgzUqi
         LS7EtzuLt1RMu/r34wkfHro94SrYnYrWkURw4jG5S147KCyimugNwIWM5FP48KHXR4g+
         U57Ws2NiYxQS9oSuWfUEUm1qc7ivXKoc7TltUlA+0pnicKTen5rrjvQ5rg8H3tOcYeoJ
         ZrG+EiYFgnOsAoFmgnawvv+rPiUmqweS/tyKKnAZsTo6f+AilQddGAlMSvvTaMGx0223
         hRsy9Egf9l89jqx72fylc7+PxiOzBJzsm47u4Hc68BZ54LTQ5zqnqP4HEyG6YRtPCzWn
         zr5Q==
X-Gm-Message-State: ANhLgQ0Y9dYorSYDcKW8gWaDJEaeKTp9jvTxc6R+Vchy+xg6Oa976ivD
        MPEibss6gHXk7X6H6+cJTBRRg7Th
X-Google-Smtp-Source: ADFU+vtS2cViV3B5jAAlKsErJxA4bYnUXiL5wU0FcRrtXG+wMXKEJx0OesI0WMOJE5oeQoXzG64PAQ==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr1351265wrq.424.1583183785458;
        Mon, 02 Mar 2020 13:16:25 -0800 (PST)
Received: from [192.168.43.18] (94.197.120.139.threembb.co.uk. [94.197.120.139])
        by smtp.gmail.com with ESMTPSA id m3sm9482886wrx.9.2020.03.02.13.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:16:25 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: PATCH 2/3] staging: vt6656: Remove function vnt_int_process_data.
Message-ID: <dff3a1d0-4d24-d9ea-2a15-c81fd544bc79@gmail.com>
Date:   Mon, 2 Mar 2020 21:16:23 +0000
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

call vnt_start_interrupt_urb directly from vnt_start.

Move debug message to vnt_start_interrupt_urb.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/int.c      | 11 -----------
 drivers/staging/vt6656/int.h      |  1 -
 drivers/staging/vt6656/main_usb.c |  2 +-
 drivers/staging/vt6656/usbpipe.c  |  2 ++
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.c
index fcf92cd1234b..139be3f845c3 100644
--- a/drivers/staging/vt6656/int.c
+++ b/drivers/staging/vt6656/int.c
@@ -23,17 +23,6 @@
 #include "power.h"
 #include "usbpipe.h"
 
-int vnt_int_start_interrupt(struct vnt_private *priv)
-{
-	int ret = 0;
-
-	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
-
-	ret = vnt_start_interrupt_urb(priv);
-
-	return ret;
-}
-
 static int vnt_int_report_rate(struct vnt_private *priv, u8 pkt_no, u8 tsr)
 {
 	struct vnt_usb_send_context *context;
diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.h
index 8a6d60569ceb..0b7473a7f190 100644
--- a/drivers/staging/vt6656/int.h
+++ b/drivers/staging/vt6656/int.h
@@ -41,7 +41,6 @@ struct vnt_interrupt_data {
 	u8 sw[2];
 } __packed;
 
-int vnt_int_start_interrupt(struct vnt_private *priv);
 void vnt_int_process_data(struct vnt_private *priv);
 
 #endif /* __INT_H__ */
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 9135aad0863d..a22f88b1f5e9 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -549,7 +549,7 @@ static int vnt_start(struct ieee80211_hw *hw)
 
 	priv->int_interval = 1;  /* bInterval is set to 1 */
 
-	ret = vnt_int_start_interrupt(priv);
+	ret = vnt_start_interrupt_urb(priv);
 	if (ret)
 		goto free_all;
 
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index e93c2175543f..0e29dc2f4b0d 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -176,6 +176,8 @@ int vnt_start_interrupt_urb(struct vnt_private *priv)
 {
 	int ret = 0;
 
+	dev_dbg(&priv->usb->dev, "---->Interrupt Polling Thread\n");
+
 	if (priv->int_buf.in_use) {
 		ret = -EBUSY;
 		goto err;
-- 
2.25.1
