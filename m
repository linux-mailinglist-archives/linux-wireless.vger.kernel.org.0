Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264AA2C47AF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgKYSdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 13:33:08 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:39134 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYSdI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 13:33:08 -0500
Received: by mail-lf1-f47.google.com with SMTP id j205so4495287lfj.6;
        Wed, 25 Nov 2020 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iq/rhGtKw9JfHDyuXwJuAjCDQ6lH2DHrNUXy2SU1nX8=;
        b=rK4HULC0P8YCtdufKouei7J8LqZD5qS6PyYzQxwwJMMovDEuZ1VO77Y+ePfi7v0UOW
         ogKkP9FwebieIhyeIXLQVs3dihCX5+Bdm7XThe6tUrN/1+vFTsm41owdBFEQgUXZ6ZGE
         4n9UCUdmhTNN5PLyaiW7eFH7Fd8bgmAyFTVuY71/Y29HnhgyhzvbxeVBEY19hbnvAiJQ
         kzcMzW/FLnVCG5yAWdmtMXrqotNNB12DnoNnP7PV+IXX0ugRzVfARlmcpnhU8jNHrUIq
         T3HSFhGDp+QAGaEE6nRZXxnkCDamkpBWxlQrxTwHPGeIu1fnenppYxV6DwNjPrkvXXEP
         vO8g==
X-Gm-Message-State: AOAM531Kl8BiIqQRC1Usilwh21sYXMfslvtVOnqtIOCYbJqQQusDrdXG
        aXXkYmm1X9iIJsSuxw7r/hY=
X-Google-Smtp-Source: ABdhPJxxlTR7u7CExRGAjdVX/PKhoSgEB0Wt9pVoREtd/Sug6bk1fv0aMignqU347J7H7e3HAnuPgQ==
X-Received: by 2002:a19:c21a:: with SMTP id l26mr71698lfc.590.1606329185521;
        Wed, 25 Nov 2020 10:33:05 -0800 (PST)
Received: from [172.16.128.221] ([4.34.229.34])
        by smtp.gmail.com with ESMTPSA id p21sm330177ljj.13.2020.11.25.10.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 10:33:04 -0800 (PST)
Subject: [PATCH 1/2] mmc: sdio: Move SDIO IDs from rtl8723bs, driver to common
 include file
From:   Brian O'Keefe <bokeefe@alum.wpi.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
References: <16529bfd-0308-5da9-f7ce-4ffa9f77b4d0@alum.wpi.edu>
Message-ID: <a646a587-25ae-2395-a169-3742ba7f9723@alum.wpi.edu>
Date:   Wed, 25 Nov 2020 13:33:00 -0500
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

  With apologies; something I did mangled spacing in the previous 
version of the first patch.

---
  include/linux/mmc/sdio_ids.h | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 12036619346c..97ccb0ac5e43 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -42,6 +42,20 @@
  #define SDIO_VENDOR_ID_TI			0x0097
  #define SDIO_DEVICE_ID_TI_WL1271		0x4076

+#define SDIO_VENDOR_ID_REALTEK			0x024c
+#define SDIO_DEVICE_ID_REALTEK_BESTBUY_0	0x0240
+#define SDIO_DEVICE_ID_REALTEK_BESTBUY_1	0x0241
+#define SDIO_DEVICE_ID_REALTEK_HP		0x0523
+#define SDIO_DEVICE_ID_REALTEK_ECS		0x0524
+#define SDIO_DEVICE_ID_REALTEK_TCL		0x0525
+#define SDIO_DEVICE_ID_REALTEK_ACER		0x0623
+#define SDIO_DEVICE_ID_REALTEK_RSVD		0x0624
+#define SDIO_DEVICE_ID_REALTEK_ROCKCHIP		0x0625
+#define SDIO_DEVICE_ID_REALTEK_BRASWELL		0x0626
+#define SDIO_DEVICE_ID_REALTEK_ACER_PWR_LIMIT	0x0627
+#define SDIO_DEVICE_ID_REALTEK_COMMON_01	0x8753
+#define SDIO_DEVICE_ID_REALTEK_COMMON_02	0xb723
+
  #define SDIO_VENDOR_ID_ATHEROS			0x0271
  #define SDIO_DEVICE_ID_ATHEROS_AR6003_00	0x0300
  #define SDIO_DEVICE_ID_ATHEROS_AR6003_01	0x0301
-- 
2.25.1
