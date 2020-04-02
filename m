Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA47019CBD1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgDBUpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 16:45:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36390 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBUpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 16:45:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so5859780wrs.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2020 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YlSD4Lk4f6lPWhUFQ2ne86biZ/yC8yucmHDeLcuroz8=;
        b=WcH1BXGHgSoOwDNpAGxLwoMQUObcbxH48bpCbwmsD4Aje0/QKeSTyXkgBHCBQ4zgL7
         CIM44HVSdSnj7NXv4oSdlrhyaiuTSUnvoCG9wFzuqxNEhd+hVEjdtsWxEEutxEiLOBEd
         stSbvYVo2wBYfapMJBb+outBXc8Gmq8n9mwx3Tg91xtTzX4gbO6pYUfe0qjxe2ShMUwY
         PSvjKeuRwl4aE459OokRwbiOkxRjQNuDsbxY5JJLP41LimY7bPFY+54qS8/Y+kUfeLhJ
         JsjQhg/L3wxexVFuV/lu+qsI5FsgumBmgFn4/7bJ7SWD+N5c3rYqBPm4RzevTM7bS+lb
         v98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YlSD4Lk4f6lPWhUFQ2ne86biZ/yC8yucmHDeLcuroz8=;
        b=GviMSSLRZh7BV9OD0AnkIHM5ucwf/pnVIU9Ti4kbBTPdUbvP0smlN+zL99GXsOYG1U
         FsUiY0GHShDaaHoIVYB08JUC0TJBTzgTB9nLGM8+EGfTTVbgKMwhviZu4uLbnB6nzRiX
         tt1enwGSrc+OcGdPBD9C/qxDDuR28EmJ6q6lYs1PbszjSeje1VSWFK6AR8eObcpmculM
         ogUhyOAmfl4kOdfacnAM2EYeVPpt9QpuSAj+/EIsKcO1uEHkzBdL/5D5Mp6vpgEkBHzL
         c2yL6UUsoerCnjpHqk8MQIQ4Uop/CYppKqqJYBjrmrLfEeJr2PXeoAoIqVCTzKEGrAwi
         Yj5A==
X-Gm-Message-State: AGi0PuazulOXfWmsqNmJ+TQzF8CI5wYB8Al47eBx3ywZdc0tgRbaSH34
        hvaws6BI3x/KbIfIE1akUVuQ8z2r
X-Google-Smtp-Source: APiQypKptHzouBDkzkNWuInsaxcIl98/BYu6yzlazLnMr8SXiVDJ1fnt5++gATFVwZI+TqFErRusmQ==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr2672777wrp.356.1585860323399;
        Thu, 02 Apr 2020 13:45:23 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id o9sm3986296wru.29.2020.04.02.13.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:45:22 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH] staging: vt6656: replace al2230_power_table array with
 formula.
Message-ID: <e277409a-4509-d09c-515d-59b952f8310d@gmail.com>
Date:   Thu, 2 Apr 2020 21:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The power table can replaced with calculation 0x0404090 | (power << 12)
removing array and length macro.

variable power never goes beyond the maximum setting.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rf.c | 79 ++-----------------------------------
 1 file changed, 4 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
index 43237b7e1dbe..4f9aba0f21b0 100644
--- a/drivers/staging/vt6656/rf.c
+++ b/drivers/staging/vt6656/rf.c
@@ -27,7 +27,6 @@
 #include "usbpipe.h"
 
 #define CB_AL2230_INIT_SEQ    15
-#define AL2230_PWR_IDX_LEN    64
 
 #define CB_AL7230_INIT_SEQ    16
 #define AL7230_PWR_IDX_LEN    64
@@ -518,74 +517,6 @@ static u8 vt3342_channel_table1[CB_MAX_CHANNEL][3] = {
 	{0x03, 0x00, 0x04}
 };
 
-/* Power Table */
-static const u32 al2230_power_table[AL2230_PWR_IDX_LEN] = {
-	0x04040900,
-	0x04041900,
-	0x04042900,
-	0x04043900,
-	0x04044900,
-	0x04045900,
-	0x04046900,
-	0x04047900,
-	0x04048900,
-	0x04049900,
-	0x0404a900,
-	0x0404b900,
-	0x0404c900,
-	0x0404d900,
-	0x0404e900,
-	0x0404f900,
-	0x04050900,
-	0x04051900,
-	0x04052900,
-	0x04053900,
-	0x04054900,
-	0x04055900,
-	0x04056900,
-	0x04057900,
-	0x04058900,
-	0x04059900,
-	0x0405a900,
-	0x0405b900,
-	0x0405c900,
-	0x0405d900,
-	0x0405e900,
-	0x0405f900,
-	0x04060900,
-	0x04061900,
-	0x04062900,
-	0x04063900,
-	0x04064900,
-	0x04065900,
-	0x04066900,
-	0x04067900,
-	0x04068900,
-	0x04069900,
-	0x0406a900,
-	0x0406b900,
-	0x0406c900,
-	0x0406d900,
-	0x0406e900,
-	0x0406f900,
-	0x04070900,
-	0x04071900,
-	0x04072900,
-	0x04073900,
-	0x04074900,
-	0x04075900,
-	0x04076900,
-	0x04077900,
-	0x04078900,
-	0x04079900,
-	0x0407a900,
-	0x0407b900,
-	0x0407c900,
-	0x0407d900,
-	0x0407e900,
-	0x0407f900
-};
-
 /*
  * Description: Write to IF/RF, by embedded programming
  */
@@ -685,10 +616,9 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 
 	switch (priv->rf_type) {
 	case RF_AL2230:
-		if (power >= AL2230_PWR_IDX_LEN)
-			return false;
+		power_setting = 0x0404090 | (power << 12);
 
-		ret &= vnt_rf_write_embedded(priv, al2230_power_table[power]);
+		ret &= vnt_rf_write_embedded(priv, power_setting);
 
 		if (rate <= RATE_11M)
 			ret &= vnt_rf_write_embedded(priv, 0x0001b400);
@@ -696,10 +626,9 @@ int vnt_rf_set_txpower(struct vnt_private *priv, u8 power, u32 rate)
 			ret &= vnt_rf_write_embedded(priv, 0x0005a400);
 		break;
 	case RF_AL2230S:
-		if (power >= AL2230_PWR_IDX_LEN)
-			return false;
+		power_setting = 0x0404090 | (power << 12);
 
-		ret &= vnt_rf_write_embedded(priv, al2230_power_table[power]);
+		ret &= vnt_rf_write_embedded(priv, power_setting);
 
 		if (rate <= RATE_11M) {
 			ret &= vnt_rf_write_embedded(priv, 0x040c1400);
-- 
2.25.1
