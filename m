Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE112C477F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 19:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgKYSXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 13:23:39 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39522 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgKYSXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 13:23:39 -0500
Received: by mail-lj1-f170.google.com with SMTP id o24so3299097ljj.6;
        Wed, 25 Nov 2020 10:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cPPQ179EgtW8kXz3cpwoQkCmMXkKDw1elffjhTNhfU4=;
        b=g3YaGfQrmcI4EH/ByZCmC2c62jdj3ZCr3mEnqo1c7TDGKOBWxLJWk3H2ED4+TtCSWW
         vE+7BTrzaz40/rQpCaSokWRcorcj9mditcjr86Z/n9Er0hZPHYPL80gYMGuK1V9ONE3O
         Vei6Yb8Lidze4ioXtILAed0ssSkkSyagvbC/9HwV8crDqbYqLM5AubDl5t1CJ4XjIBTU
         6/+YeB8I+J2++7n+qFOqxOFeMK+n0olZEC6HVHREZwFgZ1Xwi4cYMXcvthL2STSD66vB
         2HxKcgA/6LhssthGih1CkX7U5X0gQ98IOkUlr7QgrYaPENysSTW2/RDoLwyYCgDBwS3P
         vmXg==
X-Gm-Message-State: AOAM532JBuMGitUBhjyYe2Fbz1pf+K7z5/GWZcIvul7h7dLJ8R+d4JB4
        4Fjf/sI+LK7kr1s8LbuCRoE=
X-Google-Smtp-Source: ABdhPJyKlM2u5yPWPouZUr4Cm7f8hO7xnjA92sVBkOEU3ScYpVOWFCvJouSekvXHGuIkYkorve2sng==
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr1917176lju.405.1606328616800;
        Wed, 25 Nov 2020 10:23:36 -0800 (PST)
Received: from [172.16.128.221] ([4.34.229.34])
        by smtp.gmail.com with ESMTPSA id m202sm7189lfa.208.2020.11.25.10.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 10:23:35 -0800 (PST)
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Brian O'Keefe <bokeefe@alum.wpi.edu>
Subject: [PATCH 1/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to common
 include file
Message-ID: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
Date:   Wed, 25 Nov 2020 13:23:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
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
  include/linux/mmc/sdio_ids.h | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 12036619346c..97ccb0ac5e43 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -42,6 +42,20 @@
  #define SDIO_VENDOR_ID_TI                      0x0097
  #define SDIO_DEVICE_ID_TI_WL1271               0x4076

+#define SDIO_VENDOR_ID_REALTEK                  0x024c
+#define SDIO_DEVICE_ID_REALTEK_BESTBUY_0        0x0240
+#define SDIO_DEVICE_ID_REALTEK_BESTBUY_1        0x0241
+#define SDIO_DEVICE_ID_REALTEK_HP               0x0523
+#define SDIO_DEVICE_ID_REALTEK_ECS              0x0524
+#define SDIO_DEVICE_ID_REALTEK_TCL              0x0525
+#define SDIO_DEVICE_ID_REALTEK_ACER             0x0623
+#define SDIO_DEVICE_ID_REALTEK_RSVD             0x0624
+#define SDIO_DEVICE_ID_REALTEK_ROCKCHIP         0x0625
+#define SDIO_DEVICE_ID_REALTEK_BRASWELL         0x0626
+#define SDIO_DEVICE_ID_REALTEK_ACER_PWR_LIMIT   0x0627
+#define SDIO_DEVICE_ID_REALTEK_COMMON_01        0x8753
+#define SDIO_DEVICE_ID_REALTEK_COMMON_02        0xb723
+
  #define SDIO_VENDOR_ID_ATHEROS                 0x0271
  #define SDIO_DEVICE_ID_ATHEROS_AR6003_00       0x0300
  #define SDIO_DEVICE_ID_ATHEROS_AR6003_01       0x0301
--
2.25.1
