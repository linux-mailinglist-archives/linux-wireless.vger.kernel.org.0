Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9736D408
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhD1Iho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Ihn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 04:37:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E538AC061574
        for <linux-wireless@vger.kernel.org>; Wed, 28 Apr 2021 01:36:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a11so1517894plh.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Apr 2021 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjUF9BpvK4r1iz57hM3EhPDHjFmt6yk1iQHfr+k3qbM=;
        b=OvLuvuwpiN9oVC4fXH86kG3mjF1qXle7T+jN//aJrJPmJtvAtZsgd3itGUvr7V5H+z
         Q7gBgtKmYFwNRu9lVApPHSbXPD0Md2l0xKeKMS7KTzDsPmw9C4kk9+GX3jVPdGZAUJDQ
         AvFoRvJjmf5vBYK2fbgFNUTRR0XIoRA4+VjYYUPEkYMMDhRyVSRnYSu4xhAZ5nsJYUW7
         sy2qeWQxhJJP6jPAi+9yYhILRg4mBErAQyuXVKUnxBqVTSDU99g78cjh5iyQCX9yzni2
         mPlLZv3nSANzvNYqKpP+tdJAUWKkQVhP6mEzNlBOEShDF/FIvOOefM1dY628B3nN9XPP
         AQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fjUF9BpvK4r1iz57hM3EhPDHjFmt6yk1iQHfr+k3qbM=;
        b=scJ5K7urLgSrK5nuX2MGJA9lIo/EUZERUaD4/pqY/TZtTmM1kWXGEg+Tktye9dvN8y
         aUxccdnDPxPWhSxvB4sBG0nIgpZoroPIenfOZEriYjqV/xB+T2QcaMAt3/nP+XGJ1i7U
         NE1fwAfOyfg6VQY95+f/a2NwZaeGYgWBzY2nMQvH4m0Ak9/LPtQVvYiKpEjw90DTL/ud
         6pdRXxMWcQnj87IFI0oQ4RCUXf6pP5p8j0JcWCBBQdmT/TMxlBJaQUALpEbTUixTm9TR
         rk648E7RBxvsB5IIfanQtk2qPdZpepq5BtAi6iwrQJMNrO92sgmIpiw9JZ76WEYD4MSZ
         rEsg==
X-Gm-Message-State: AOAM533JQSBryug4dBOgWfw+CUDAIAnuPEZpusLPPQA9DGW9+LtpSHX6
        pE6iXm3uCFItVAOe3ezkfPGusQ==
X-Google-Smtp-Source: ABdhPJw+pSzP+7mqH91TiZSleK8DJBgT6+VeuQSagoS0iZQRgwYUticLT6u5Zvx8pHT8CCv8f+oPMQ==
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr31564179pjq.149.1619599018459;
        Wed, 28 Apr 2021 01:36:58 -0700 (PDT)
Received: from starnight.endlessm-sf.com (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id f18sm4498493pfe.49.2021.04.28.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:36:58 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] brcm: Add a link to enable khadas VIM2's WiFi
Date:   Wed, 28 Apr 2021 16:32:31 +0800
Message-Id: <20210428083230.8137-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to kernel message on khadas VIM2 board equipped with BCM4356:

brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
usbcore: registered new interface driver brcmfmac
brcmfmac mmc0:0001:1: Direct firmware load for brcm/brcmfmac4356-sdio.khadas,vim2.txt failed with error -2
brcmfmac mmc0:0001:1: Direct firmware load for brcm/brcmfmac4356-sdio.txt failed with error -2

System needs the NVRAM file "brcmfmac4356-sdio.khadas,vim2.txt" to enable
the WiFi. After test, found it can share with the same file
"brcmfmac4356-sdio.vamrs,rock960.txt".

This patch adds the link to brcmfmac4356-sdio.vamrs,rock960.txt for it.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 WHENCE | 1 +
 1 file changed, 1 insertion(+)

diff --git a/WHENCE b/WHENCE
index 3c29304..5773020 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2780,6 +2780,7 @@ Link: brcm/brcmfmac43455-sdio.Raspberry\ Pi\ Foundation-Raspberry\ Pi\ Compute\
 File: "brcm/brcmfmac43455-sdio.MINIX-NEO Z83-4.txt"
 File: "brcm/brcmfmac4356-pcie.gpd-win-pocket.txt"
 File: brcm/brcmfmac4356-sdio.vamrs,rock960.txt
+Link: brcm/brcmfmac4356-sdio.khadas,vim2.txt -> brcmfmac4356-sdio.vamrs,rock960.txt
 
 Licence: GPLv2. See GPL-2 for details.
 
-- 
2.31.1

