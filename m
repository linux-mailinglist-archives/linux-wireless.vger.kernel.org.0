Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864103581D0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhDHLa5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhDHLaz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 07:30:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB547C061762
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 04:30:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 7so877389plb.7
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFkQVg2sWZMIrKtGQV1AJb0w7icp+ZqdTBHv4nvPanw=;
        b=LmuFVG/w9xpRWNtvDT4ojWVfUpuqmOetuIzsLuSAtFySN347ImRJYrGZQ4fZQP1u25
         ikG5+5xtkCZa8AN9TNVUPlRbXhDbqxL/T086wcXYBDrxG1pw69oJTPPUkK2PgJ22m82T
         yoH+XPxmYm33F3EaRQcwgw0s7tu3xHSA+I4P4GQTwebvkEQlVg2esh0Asvp8x5ZZlRHs
         ZefwCd5BCMqLYBzoW+ExsD7hK9TYDkpz+lurhr3k3oMenWfdtGy47YHHPjmTHCuQ/f9q
         6p3WY9Bo5wLQ7yKzvHstUw3vRFTAqzB3OueUNendvaocTBjLsaP2mzzIWQPgosFKAzHr
         7mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFkQVg2sWZMIrKtGQV1AJb0w7icp+ZqdTBHv4nvPanw=;
        b=srAL8ChCSR/cLHHVXYFf5isesB5zkaDimtVUUgkme8QM6hthmtiX/Yu58/A1BDcWzm
         Oa2QvbyNYlH5wVrOVvc77/ACR81x68j7mkEGnyWgKGzW2UvuWlF2DZt/+2u+Bc8vPzUS
         jop/jzSafUBVmXtbwZUSBZBPrqRH4xXMpiEUX8YInp99cnBqFukh+GPstGnyrL5gNTEe
         JO5DDWLB+fp6Pcshx4etoB5k6ON2qTxjOU1FjRoXe6XQFPGyePy6HoMinCwX1A1YX63E
         xzsjpYi0UVcRBvvMwcff2r2xmMbShffJaB6OcwsXvhYPBK0i4MX1QH6HfXVj1aZX3t1a
         nV8Q==
X-Gm-Message-State: AOAM533sWc1XoIeHgDZjsjKsLKvCEiETaMU/ocZ9rZZMd0gKriTNwLrU
        NohhpuYsyikP9s0ig9krVdr+PQ==
X-Google-Smtp-Source: ABdhPJytiTe+6hgbzt/Xrq0RGr+fgKoE+HAt22IdyHQUyup9kjgIulw9hoxb2qs5qhHTWoxT67goDg==
X-Received: by 2002:a17:902:904b:b029:e5:5cc5:877d with SMTP id w11-20020a170902904bb02900e55cc5877dmr7556967plz.50.1617881443425;
        Thu, 08 Apr 2021 04:30:43 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x18sm7753267pfi.105.2021.04.08.04.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:30:43 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-binding: bcm43xx-fmac: add optional brcm,ccode-map
Date:   Thu,  8 Apr 2021 19:30:21 +0800
Message-Id: <20210408113022.18180-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210408113022.18180-1-shawn.guo@linaro.org>
References: <20210408113022.18180-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add optional brcm,ccode-map property to support translation from ISO3166
country code to brcmfmac firmware country code and revision.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
index cffb2d6876e3..a65ac4384c04 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
@@ -15,6 +15,12 @@ Optional properties:
 	When not specified the device will use in-band SDIO interrupts.
  - interrupt-names : name of the out-of-band interrupt, which must be set
 	to "host-wake".
+ - brcm,ccode-map : multiple strings for translating ISO3166 country code to
+	brcmfmac firmware country code and revision.  Each string must be in
+	format "AA-BB-num" where:
+	  AA is the ISO3166 country code which must be 2 characters.
+	  BB is the firmware country code which must be 2 characters.
+	  num is the revision number which must fit into signed integer.
 
 Example:
 
@@ -34,5 +40,6 @@ mmc3: mmc@1c12000 {
 		interrupt-parent = <&pio>;
 		interrupts = <10 8>; /* PH10 / EINT10 */
 		interrupt-names = "host-wake";
+		brcm,ccode-map = "JP-JP-78", "US-Q2-86";
 	};
 };
-- 
2.17.1

