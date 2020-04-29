Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4272A1BE8D8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2Umc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2Umb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 16:42:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C6EC03C1AE
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 13:42:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so3540619wma.4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qvNqW9VZY66NQpuYi1BXOqqn8Ol0ghGRclu1yj76a0g=;
        b=mI1jxagVTde/2+QB8gtV8Urph7bI+p+XTMxzhrzTl0+5UA7qrcpJbZd31OOwH1M8vN
         4+5l+AsL/MwI+C8Hy+/Ml0KmIJn5k0MnZtRDy4hHft9QCi6fpcCUNQy7mOS4jDN77+eq
         KDw26U0ESjng/XsujG5zH2mGgfcZlF1is7CuOgcSBmy81sdQJiOnD16okUZ+KmltwI4S
         HpfqwUhuC7Hth+ksDw3md/X1MCK0VCxpkXM+JiT6OEqSW02Oeat5tGYX8zoXsWFN1Tzh
         xZQd2Xyu6X/XDSwC+50lI77fsz+C3vQaTKJKO2JW83P9a4AetDevAX9JrJ4VN1wNVS18
         j3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qvNqW9VZY66NQpuYi1BXOqqn8Ol0ghGRclu1yj76a0g=;
        b=CwmBjVwNVtQMzu8r6hmZe3qaYF7ow1vO+PtqQ/W9o+dCTAMVoPdhcGW+lF1ixxTLGG
         a9aFNuLsoyDHj7y/S75BSAx2tFpQf2DYrNLpBz9x30Irgr4fKh/A5Zuhb2jqlexOENB6
         iLW78qrJhRzTY4aN7fd8LeQsOKrZg7pU9IZx/EXpVjDADoTg2EE9/fnAyjBMmCSw4cy6
         3zUt0AeSnot+/F3JgjPJe5Rcs2hiEiwkrQegTpbob1dM6dfoE1Ctt1hLndVnydeAMyvY
         e2oWc3TY/EXFKi3yg/TeJ3Dz6k6uvg11MG3K3aoSLYUjkoG0SXuUJRRtxxRrW5Wna4P/
         4Nvg==
X-Gm-Message-State: AGi0Puam+gZ20C3XXwLj7Siz6TP34erh18sly8Fq1CUIXQCPrpJ8qU4j
        ulQYnAlA3Sc+50m26v3qnaZLmnP7
X-Google-Smtp-Source: APiQypJ7lb8uaUfck/aZZAepxN5DdNIHQ9nKKlza+wq00+O7uKr7Hnb3k06Q05law0YNY7agvXTwaA==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr5004212wmi.173.1588192950047;
        Wed, 29 Apr 2020 13:42:30 -0700 (PDT)
Received: from [192.168.43.18] (188.29.164.11.threembb.co.uk. [188.29.164.11])
        by smtp.gmail.com with ESMTPSA id c25sm9095214wmb.44.2020.04.29.13.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 13:42:29 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: PATCH] staging: vt6656: use struct wiphy retry short and long
 settings.
Message-ID: <fbb8da09-ee46-2249-ff29-daaaff1a64e6@gmail.com>
Date:   Wed, 29 Apr 2020 21:42:27 +0100
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

Remove driver options for short and long retry and use the ones
set by user in wiphy.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h   | 3 ---
 drivers/staging/vt6656/main_usb.c | 8 ++------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index d1c6e9594a19..d19d802b5d4f 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -351,9 +351,6 @@ struct vnt_private {
 	u16 tx_rate_fb0;
 	u16 tx_rate_fb1;
 
-	u8 short_retry_limit;
-	u8 long_retry_limit;
-
 	enum nl80211_iftype op_mode;
 
 	int short_slot_time;
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index b1a7a6709ca7..03873a877d9a 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -59,8 +59,6 @@ MODULE_PARM_DESC(tx_buffers, "Number of receive usb tx buffers");
 
 #define RTS_THRESH_DEF     2347
 #define FRAG_THRESH_DEF     2346
-#define SHORT_RETRY_DEF     8
-#define LONG_RETRY_DEF     4
 
 /* BasebandType[] baseband type selected
  * 0: indicate 802.11a type
@@ -93,8 +91,6 @@ static void vnt_set_options(struct vnt_private *priv)
 	else
 		priv->num_rcb = vnt_rx_buffers;
 
-	priv->short_retry_limit = SHORT_RETRY_DEF;
-	priv->long_retry_limit = LONG_RETRY_DEF;
 	priv->op_mode = NL80211_IFTYPE_UNSPECIFIED;
 	priv->bb_type = BBP_TYPE_DEF;
 	priv->packet_type = priv->bb_type;
@@ -223,8 +219,8 @@ static int vnt_init_registers(struct vnt_private *priv)
 	init_cmd->exist_sw_net_addr = priv->exist_sw_net_addr;
 	for (ii = 0; ii < ARRAY_SIZE(init_cmd->sw_net_addr); ii++)
 		init_cmd->sw_net_addr[ii] = priv->current_net_addr[ii];
-	init_cmd->short_retry_limit = priv->short_retry_limit;
-	init_cmd->long_retry_limit = priv->long_retry_limit;
+	init_cmd->short_retry_limit = priv->hw->wiphy->retry_short;
+	init_cmd->long_retry_limit = priv->hw->wiphy->retry_long;
 
 	/* issue card_init command to device */
 	ret = vnt_control_out(priv, MESSAGE_TYPE_CARDINIT, 0, 0,
-- 
2.25.1
