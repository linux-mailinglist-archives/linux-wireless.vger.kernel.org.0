Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1740E6DC89E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDJPgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDJPgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 11:36:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EBA5580
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 08:36:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sg7so24768026ejc.9
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681141009;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYwHES1HHEuOHGnfRim60lI7+eW1T9cHdJm3p7Wt+3I=;
        b=MHXCMKuA4zoMpRTMLzkTbPMCtneGtfnQhM8UNuIfSMG/yRekVraclEWx8ZiEhuhi8f
         9Kn3aqYVz1yJ+POs5EjYL54YmxjTBZR5fR6Rkqj0vKnbT+OwuMXoxqBQK5u9iHcrpRk1
         hTLE6rR5kmzFGmSmVDXM5ndQIQRV9/GcN5et0fjSrIIdRRoZP32NFK3nzD3S+9jnA66S
         jD7jDzECyEGBpayB/Z4mbfjiMsNWHbIYhRXvOczO6NT1ZeUDBYH2vzcOyYqrcVJt5ZCh
         SAXqCS3MfV+jc9xDLb9y/XEAH0dpGXeEwIpYMPMVhtk8T4d75sV2d/yPXgpjYvtS3+Dh
         /HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681141009;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYwHES1HHEuOHGnfRim60lI7+eW1T9cHdJm3p7Wt+3I=;
        b=gjmVwPAmgOGoIjRX3kmnCEORYfdyp8CsMtEFq+FEeazOXjbOnzWeIJgPA2XbVugqU9
         n1kOYVZhIBkOEad2CxMRmA1P24SXXkZJrnSHCz1YMruZNjkf0TILvhobXSKOHBIPfus9
         v5AIrUs5+Sq5SEkcOBVfUa9U0oJd2IhSOrPv6SHsZYQ/7tcEcjwG3+OJkWFQawELmZIO
         gYgVlLpnATqQr3czdoqVSXc4xhPJG5ayX90Y/Y3FB1L5ALzqS7pcmiK7au+N5VyUfcWe
         6+M/SD/lJ8ljTNTN3o+edX6hp02vU4qlccmZq37s42M6GhTfWoHc1uzisu+6VHnHBO0i
         UdvA==
X-Gm-Message-State: AAQBX9dPpWhFbfqaGRVztiAC21Hqk/RwAy/nTnkiWNmSFNSLvMOAuRuF
        QS5v4DzE+WWk17zXYeLfTwg7RF8i/wo=
X-Google-Smtp-Source: AKy350awz2TKaWzHMu1iwJilbnIsvX1OwNPKomIH6BWdh59Dgd7okmBJu1VNKh1+Jeud9xwmHkYRkQ==
X-Received: by 2002:a17:907:d403:b0:926:c9e4:f843 with SMTP id vi3-20020a170907d40300b00926c9e4f843mr8597445ejc.59.1681141009366;
        Mon, 10 Apr 2023 08:36:49 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906344d00b0094a83007249sm1297249ejb.16.2023.04.10.08.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:36:49 -0700 (PDT)
Message-ID: <ef4bc66d-84f5-4021-efd7-1787d097519c@gmail.com>
Date:   Mon, 10 Apr 2023 18:36:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH v2 2/2] wifi: rtl8xxxu: Support devices with 5-6 out endpoints
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
In-Reply-To: <e24a5534-6e33-cfb9-0634-0caf4646513f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle them the same way as the devices with 3-4 USB out endpoints.
This is needed for the RTL8192FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 39fee07917e7..82a0290ccb29 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -27,7 +27,7 @@
 #define RTL8XXXU_MAX_REG_POLL		500
 #define	USB_INTR_CONTENT_LENGTH		56
 
-#define RTL8XXXU_OUT_ENDPOINTS		4
+#define RTL8XXXU_OUT_ENDPOINTS		6
 
 #define REALTEK_USB_READ		0xc0
 #define REALTEK_USB_WRITE		0x40
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 62dd53a57659..6106b47d0c37 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1663,6 +1663,8 @@ int rtl8xxxu_config_endpoints_no_sie(struct rtl8xxxu_priv *priv)
 	struct device *dev = &priv->udev->dev;
 
 	switch (priv->nr_out_eps) {
+	case 6:
+	case 5:
 	case 4:
 	case 3:
 		priv->ep_tx_low_queue = 1;
-- 
2.39.2
