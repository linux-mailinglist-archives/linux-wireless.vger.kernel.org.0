Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A54F782D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiDGHx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiDGHxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 03:53:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5E1342F0
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 00:51:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r8so4863429oib.5
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgQ1ywg+ba/yQzHZ4Pvp9X9bnupFWJ5qxG8MURjAQ8s=;
        b=ai19JJrPJMlFSfCz2C9gQTi5UakFxWlunwlYkARXVeayQbFo8nLmHzAOuKrEenQuQy
         wIqF0qrfWRHYb4dDweucMO3A4Y2a0Y0VZgRCEVvlaEMg2EylhrQDR9/YBDHBlvmEBc3a
         N34xMYmEXKIuWt+PDcs+4Rs5jXzWB731HJLPawdFNSSzpl2kds5PwUy2riiEMraF/xZv
         //7JE9JETXZ0t1SmpQ8HsoCML/Ow88tKDxzGeoLd5Bl3BmiMk4SmfTH43hLFFKo2hOm7
         mZBU6guoZq+u/FqOtYSKNOawXkdAgK5Kntc+cJXofmbkr0dY0L8mPc5ItH76m0qYnspO
         jMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgQ1ywg+ba/yQzHZ4Pvp9X9bnupFWJ5qxG8MURjAQ8s=;
        b=I9wnHN+SOtVonwltAta1bd+PoA9DBXCmLjbdTwRu3dO4XOMflzt4B9WO0lCcXn2PiQ
         wJCizmZt6Hxg7it0d0hLMQtAvdNyU5KvbJEFhIU/dWV/uiLXAhBRMQL54IpxaRHiPRej
         d9kNwIDGceQEfzuUam0sT72PecaXnd5VUAtN3X9ssYtLKJ8Up5XsLQHgqQDHfMcSOna0
         Uqg6yqADPOZAGbdxR5BrXllXp97awV/SmCM7dsUbAlXv354g4ToQnQ2vmQcVTvhALl5E
         H0n22j0fIJQtFKQKfIYNocsKJcu1Ogsm3JM3nx16gHUNvlxF9OeP/QiFeuuUdmsgrex6
         +HNQ==
X-Gm-Message-State: AOAM530lCZUL/yMSn4hC36lfN+JhTEqYGMz1+uq53WRZIQP4zpZ4QKaG
        Lpgh8Q3EF0wsbQ+bCmXdeKinS83LfcA=
X-Google-Smtp-Source: ABdhPJyOxaSJwiK83floiNamfccAuz3h5iK7fzmzQj4pBqyqXQpKUDsqICEQT+8fboQv/vCrumVvOw==
X-Received: by 2002:a05:6808:144a:b0:2ef:9fa2:ba7f with SMTP id x10-20020a056808144a00b002ef9fa2ba7fmr5064826oiv.88.1649317916334;
        Thu, 07 Apr 2022 00:51:56 -0700 (PDT)
Received: from tower.austin.rr.com (cpe-68-203-212-228.rgv.res.rr.com. [68.203.212.228])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm6906245oot.14.2022.04.07.00.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:51:55 -0700 (PDT)
From:   Jimmy Hon <honyuenkwun@gmail.com>
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org, Jimmy Hon <honyuenkwun@gmail.com>
Subject: [PATCH 1/2] rtw88: 8821ce: add support for device ID 0xb821
Date:   Thu,  7 Apr 2022 02:51:22 -0500
Message-Id: <20220407075123.420696-2-honyuenkwun@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407075123.420696-1-honyuenkwun@gmail.com>
References: <20220407075123.420696-1-honyuenkwun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

New device ID 0xb821 found on TP-Link T2E
Tested it with c821 driver. 2.4GHz and 5GHz works.

PCI id:
05:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b821
        Subsystem: Realtek Semiconductor Co., Ltd. Device b821

Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
index f34de115e4bc..56d22f9de904 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
@@ -8,6 +8,10 @@
 #include "rtw8821ce.h"
 
 static const struct pci_device_id rtw_8821ce_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xB821),
+		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
+	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xC821),
 		.driver_data = (kernel_ulong_t)&rtw8821c_hw_spec
-- 
2.35.1

