Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69C6F29DA
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjD3RP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3RP0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 13:15:26 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83165125
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 10:15:25 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-187af4a5453so799717fac.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682874925; x=1685466925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x4n/0WIPmgubAvGm6mAWMCWT52BVGUoZ/ntjsaUQFkU=;
        b=gKQsn6kOjjadBs6pg/ukV6MshTOV184P7aJMkpNYmjgEtj3e4UH5ZoBmwPt7uyNaij
         ZHRw1ZVenj9vYkus43ekvZ7OT0dDNSXjqn36HFtQdE4+5wYJfKGXMW7NvnPSgSA9MCj9
         dzTrq+c1mM2mO73VzEX6Qo+lLQdOs+xpmYn4ZZSAJnV/ePk0OUV+VPAL76/xqFSRf/cJ
         Zc/vhF+cb4o9ya529cuayBf76/jcXJAWXj7FFWw/VIIbs/d78WgE7hvQMVZdNlPOSbgS
         h/q/geoHg5qz7K5HsbQd9APorK1kmVY64/lgS8/Rqxml1UPA5XaHeTKvWV7k1a8uOem1
         xV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682874925; x=1685466925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4n/0WIPmgubAvGm6mAWMCWT52BVGUoZ/ntjsaUQFkU=;
        b=hZWd+bxA8VoZmoh/vE0JvyRrMp7aXJQ28QYOSBCtlnA0u0K4V3eiI1HRk/1Zfmo1p4
         rOnAuCfYXiKENMD3w2my9KJtrSC/hmWFiwRecaoMFEUHgmcvcQjA8ArvCUa91CMG3pOL
         +vA43TN03Dk12k25UqoFs0EXl+OdrL1x645oxv6yOhp7hzcLLbtwhLeiAcWxwgJ0uG3j
         sUdadg3F4Bd5GpAqHVoUTcdPAn6/84Kd5ZKaBbX+dQPuQB9K/DlYaO4se8zl0G5qhCf5
         pjRwPU63eaDUDKl0+yteRbU7uLWOssUuMUj/Mq0GlB1nAyCm+fIQl63no2VECQhHaS2s
         IinQ==
X-Gm-Message-State: AC+VfDwF0Po6fg5cv9ydGWBU6Fas66bpvofZ+4FyrvK22K5kS9p0FEYr
        qx4EOGFUz681KyEs+s/+Ccc=
X-Google-Smtp-Source: ACHHUZ6Z/9jGLFwwoGh5fojgfQEAjnmsU8J7q4Ujzn2K/bgu5sgt5qshusjBnNsUigQS1w+MYPDmVg==
X-Received: by 2002:a05:6870:b0e4:b0:18e:2bb2:3f97 with SMTP id u36-20020a056870b0e400b0018e2bb23f97mr5220661oag.25.1682874924787;
        Sun, 30 Apr 2023 10:15:24 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id b35-20020a4a98e6000000b0051a6cb524b6sm11815642ooj.2.2023.04.30.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 10:15:24 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] wifi: rtl8xxxu: Remove CONFIG_RTL8XXXU_UNTESTED
Date:   Sun, 30 Apr 2023 12:15:19 -0500
Message-Id: <20230430171519.13422-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This parameter is selected by openSUSE, Fedora, Ubuntu, and Mint. Of the
distros that I checked, only Debian on ppc32 did not select it.
Eliminating this option will have little effect on Linux users, and is a
necessary step in the elimination of the old rtl8192cu driver in the
rtlwifi family.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig          | 10 ----------
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |  2 --
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  3 ---
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
index 82bcaf44a65f..7989064c863b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
@@ -25,13 +25,3 @@ config RTL8XXXU
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called rtl8xxxu.  If unsure, say N.
-
-config RTL8XXXU_UNTESTED
-	bool "Include support for untested Realtek 8xxx USB devices (EXPERIMENTAL)"
-	depends on RTL8XXXU
-	help
-	  This option enables detection of Realtek 8723/8188/8191/8192 WiFi
-	  USB devices which have not been tested directly by the driver
-	  author or reported to be working by third parties.
-
-	  Please report your results!
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index b30a9a513cb8..ff0917ba2744 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -32,7 +32,6 @@
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
 
-#ifdef CONFIG_RTL8XXXU_UNTESTED
 static struct rtl8xxxu_power_base rtl8192c_power_base = {
 	.reg_0e00 = 0x07090c0c,
 	.reg_0e04 = 0x01020405,
@@ -626,4 +625,3 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.page_num_lo = TX_PAGE_NUM_LO_PQ,
 	.page_num_norm = TX_PAGE_NUM_NORM_PQ,
 };
-#endif
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd8c8c6d53d6..4b4976a00fd2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7523,8 +7523,6 @@ static const struct usb_device_id dev_table[] = {
 /* TOTOLINK N150UA V5 / N150UA-B */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x2005, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8710bu_fops},
-#ifdef CONFIG_RTL8XXXU_UNTESTED
-/* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192cu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8178, 0xff, 0xff, 0xff),
@@ -7678,7 +7676,6 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
-#endif
 { }
 };
 
-- 
2.40.1

