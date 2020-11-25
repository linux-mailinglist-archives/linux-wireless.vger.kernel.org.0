Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83022C478A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 19:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgKYS0E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 13:26:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41527 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYS0E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 13:26:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id y7so3286369lji.8;
        Wed, 25 Nov 2020 10:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmSzTuh8Arl5nV5ZYE05LYJSV8JmR8q2m0gM3oS3fiE=;
        b=UU6MI5gRAHRnArBjVMYNUpOuLb1t5L/u4ffMBQzZPa1R5UXoFF7cP+9qCA+QfJipGZ
         9NJg7q2FyG9UWMmWSWwECXEWjUmJQ3U3abwQ/amvqmxKLWgK8wGMxVuTDAtaVRIeuABY
         IMCK9DKaqzgeTlk+KS+l28a3AEhNxgxQex/KZ0Kd3kX/qSjzEGC6zC34YS1vRdyOhMsN
         Ibw5btHRxJe17b1d51wc9eUSQOHtUUhpBLryU1/2iaAF6G2Q5v7az3BAzMfi1AOsjJ+1
         MMSb3QFTXgjIisyn0f2dHloo2WnYFz+LuxxgL5ivS+uR7V+qrqg0pfkCADgXa6Lsrzln
         iLXQ==
X-Gm-Message-State: AOAM530Igs5v2LV7jSN/1naqDhpsXbQBCrkntF77Xd7qYQlkq3ozHTub
        5iCHCMLTwrhBHnfpSUiMGSs=
X-Google-Smtp-Source: ABdhPJw3kY56t8HqoPsxIwp+H3hOaVeaaCm1QfpKYzi+7ibpXovQpwYfBg+dahgjYAXy2ELrrpq69w==
X-Received: by 2002:a2e:9689:: with SMTP id q9mr1927919lji.197.1606328762189;
        Wed, 25 Nov 2020 10:26:02 -0800 (PST)
Received: from [172.16.128.221] ([4.34.229.34])
        by smtp.gmail.com with ESMTPSA id m22sm11626lfl.14.2020.11.25.10.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 10:26:01 -0800 (PST)
Subject: [PATCH 2/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to common
 include file
From:   Brian O'Keefe <bokeefe@alum.wpi.edu>
To:     linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
Message-ID: <6762a763-5284-04dc-e636-486c74dedd34@alum.wpi.edu>
Date:   Wed, 25 Nov 2020 13:25:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Macro names were derived from the Windows driver, as that was the best
available source.

Signed-off-by: Brian O'Keefe <bokeefe@alum.wpi.edu>
---
  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 13 +++++++------
  1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c 
b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index b2208e5f190a..8dd3763d1a33 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -10,18 +10,19 @@
  #include <rtw_debug.h>
  #include <hal_btcoex.h>
  #include <linux/jiffies.h>
+#include <linux/mmc/sdio_ids.h>

  #ifndef dev_to_sdio_func
  #define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
  #endif

  static const struct sdio_device_id sdio_ids[] = {
-	{ SDIO_DEVICE(0x024c, 0x0523), },
-	{ SDIO_DEVICE(0x024c, 0x0525), },
-	{ SDIO_DEVICE(0x024c, 0x0623), },
-	{ SDIO_DEVICE(0x024c, 0x0626), },
-	{ SDIO_DEVICE(0x024c, 0x0627), },
-	{ SDIO_DEVICE(0x024c, 0xb723), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, SDIO_DEVICE_ID_REALTEK_HP), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, SDIO_DEVICE_ID_REALTEK_TCL), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, SDIO_DEVICE_ID_REALTEK_ACER), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, SDIO_DEVICE_ID_REALTEK_BRASWELL), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, 
SDIO_DEVICE_ID_REALTEK_ACER_PWR_LIMIT), },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK, 
SDIO_DEVICE_ID_REALTEK_COMMON_02), },
  	{ /* end: all zeroes */				},
  };
  MODULE_DEVICE_TABLE(sdio, sdio_ids);
-- 
2.25.1

