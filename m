Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB045252A5C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHZJiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgHZJew (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E8C061799
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so1084120wmi.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gXj0QTNi35Mkf/0PfjV36Op7KYk+Sf8/3WVle5YvISs=;
        b=LwLU6UgNWRhkAICyUcI0WTYo9m6TXWqPAHELcWqUYunSe14/NoTP2Wi3SxwnjRCPYp
         P8ToArmn9LBzbGkBXZ5NsJr3JcJPxfj4PgpcLvujetjrJ+klZkFbwpqK7c0ENSxr3mNx
         TZxfs6nglopjKXRQRLOaqoCUM9q4GccbGnin36RbIYanIqRUXWquVts5sYLDdBZYOzzb
         vAyKkiZ+aFleQE2DfWIpFhUJ+MAVRqtkvonJgyFAONhAPazcEjwPOHxWz+EVcNksSV7I
         vfNUXi6Qw+KqfZKelE0ChGdvsvJPlz3owrqDYGcVtd3723oXffVMm074IevYrbmxxaLj
         Gs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXj0QTNi35Mkf/0PfjV36Op7KYk+Sf8/3WVle5YvISs=;
        b=moRkI8OJ4Pd6FUUh/D8M//MgSH/R/5lAS9FvS3PFcHNAUr2p3ou4011efjkO7fzSvh
         UlMoxNGsDIANJiU2BE8JOf4e+o+SRL5y1PcBp1kXvDotlfICRMJTnWZoE07bAJDASYKU
         2k9S9CYRIZNLCyDYlcX5mnBXFVFkjd0T/ROqsDXr8+MWA1/I4yQieInV0lAgkb7z9lzy
         ybXFgOgWpb6usVkF3z/g0N2b8L3iEZQzAVRmmyhdTYim4pwRkjzbJvJM7yAS7NxXR8Hw
         x9THLtcjDiqbnlVfam37FiOWJQ2Yh+EWCR5JDMfTtf2frmmmfrn+jPDn82K0MNO+fWj1
         Ob+g==
X-Gm-Message-State: AOAM5327wQEBwNNOpZvlMJ+bjBzZBLO+tdNNrEUkUXbdNFnkivTlQ36j
        9VBA+uKpX3tiAXmUdhyGWGijrMM5LEHnsw==
X-Google-Smtp-Source: ABdhPJzhoiIojiVg/XClYdahPZ4ZyRm0woGPRNGbBc3tfiZLNL944VFpp2XhnfvuIRtgcAevDM0t/Q==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr5945307wmb.173.1598434464899;
        Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 16/30] wireless: rsi: rsi_91x_sdio: Fix a few kernel-doc related issues
Date:   Wed, 26 Aug 2020 10:33:47 +0100
Message-Id: <20200826093401.1458456-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 - File headers do not make for good kernel-doc candidates
 - Kernel-doc header lines should start with " *"
 - Fix doc-rot issue

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_sdio.c:25: warning: cannot understand function prototype: 'u16 dev_oper_mode = DEV_OPMODE_STA_BT_DUAL; '
 drivers/net/wireless/rsi/rsi_91x_sdio.c:802: warning: bad line:                                    from the device.
 drivers/net/wireless/rsi/rsi_91x_sdio.c:842: warning: Function parameter or member 'pfunction' not described in 'rsi_init_sdio_interface'
 drivers/net/wireless/rsi/rsi_91x_sdio.c:842: warning: Excess function parameter 'pkt' description in 'rsi_init_sdio_interface'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index a04ff75c409f4..a7b8684143f46 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2014 Redpine Signals Inc.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
@@ -799,7 +799,7 @@ static int rsi_sdio_host_intf_write_pkt(struct rsi_hw *adapter,
 
 /**
  * rsi_sdio_host_intf_read_pkt() - This function reads the packet
-				   from the device.
+ *				   from the device.
  * @adapter: Pointer to the adapter data structure.
  * @pkt: Pointer to the packet data to be read from the the device.
  * @length: Length of the data to be read from the device.
@@ -832,11 +832,10 @@ int rsi_sdio_host_intf_read_pkt(struct rsi_hw *adapter,
  * rsi_init_sdio_interface() - This function does init specific to SDIO.
  *
  * @adapter: Pointer to the adapter data structure.
- * @pkt: Pointer to the packet data to be read from the the device.
+ * @pfunction: Pointer to the sdio_func structure.
  *
  * Return: 0 on success, -1 on failure.
  */
-
 static int rsi_init_sdio_interface(struct rsi_hw *adapter,
 				   struct sdio_func *pfunction)
 {
-- 
2.25.1

