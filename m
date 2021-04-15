Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC136077E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhDOKsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhDOKsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 06:48:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498CC06175F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 03:47:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso12463928pjh.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZDSWVTMlAMb2GC5FLf9Wr+xeqh7iVHbgBuOpIuXmgM=;
        b=NampagNzPrn6NSKjQijinEcRmJ+6VjtD0femYHPPlCRPWwAi9YpHUbts3GmziV4e0T
         ev9UQcH5gJuTNiSr5NBZ30+KHwlpPiDC07hJEVMggSrBLQrsGtFFfTwNlQFV4//lUt5E
         p3BjI3Bu+4wQJCHxmo//e1BuYYPt60Bca+AOl9vDgS0DiEM3NIsp69qiIQVvs8BXFUr4
         MhFALAr4S4P2YUECtsnJlquCNt2uNVchZjD3AYJeeEuCQEdKyeXqY7E1KwI3AH4M4++3
         juOky+zdxOjVkSYGXNpSueM0ZY8hS+KqqVWxB24ZxKqvVPOz39WdnDJrGsdni8LSToGI
         eHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jZDSWVTMlAMb2GC5FLf9Wr+xeqh7iVHbgBuOpIuXmgM=;
        b=JH7o7jcHOIZlyTYZspJywZFllFKa9fwyKddGxLlQ0SWZrQ8LuF2pPSog8xMkBK8zqy
         gkodJpiZKSlTlJoBeiqgQDSK/Nfu69ZK6SVUjy3WLWkM9S+fBM/jFnEyQiuONUiKfTwH
         1+M+EKgOrcMJ1GY1+x7I4QVq+8UPQL5KR/3aCpCV3kUXl+1GVxyW8MsB2AG9GJftY3AS
         PhHCqV8oAUDM99GujQemfc/hdNAWllhf00e1hj7DtB3rCu9+Bmv+URl76SHt/1ywRRi5
         lN/rK2U9sVYGVxhqefgbI9qf0o2d28ontv7zF330QaWyq/di0eUNvQwc5iWCJEHmacOS
         Si9Q==
X-Gm-Message-State: AOAM532VmCkMqVQkJ88fdWye5pwGA4M90G6OGlg3igSxobB+UTP2IfDF
        LZUi0g5XPfb2LYzPxX//8F84rg==
X-Google-Smtp-Source: ABdhPJy+pmq8JLU/ek1cCoTJ2vGhGprFa2FPymMVG3bBW9n0OHjDvrYzdFm67XV/33rUpYEEszwGew==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr3178517pjb.114.1618483662489;
        Thu, 15 Apr 2021 03:47:42 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f65sm2130672pgc.19.2021.04.15.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:47:41 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: bcm4329-fmac: add optional brcm,ccode-map
Date:   Thu, 15 Apr 2021 18:47:27 +0800
Message-Id: <20210415104728.8471-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210415104728.8471-1-shawn.guo@linaro.org>
References: <20210415104728.8471-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add optional brcm,ccode-map property to support translation from ISO3166
country code to brcmfmac firmware country code and revision.

The country revision is needed because the RF parameters that provide
regulatory compliance are tweaked per platform/customer.  So depending
on the RF path tight to the chip, certain country revision needs to be
specified.  As such they could be seen as device specific calibration
data which is a good fit into device tree.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index b5fcc73ce6be..c11f23b20c4c 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -68,6 +68,13 @@ properties:
     description: A GPIO line connected to the WL_RST line, if present
       this shall be flagged as active low.
 
+  brcm,ccode-map:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Multiple strings for translating ISO3166 country code to
+      brcmfmac firmware country code and revision.
+    items:
+      pattern: '^[A-Z][A-Z]-[A-Z][0-9A-Z]-[0-9]+$'
+
 required:
   - compatible
   - reg
@@ -97,5 +104,6 @@ examples:
         interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
         interrupt-names = "host-wake";
         reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
+        brcm,ccode-map = "JP-JP-78", "US-Q2-86";
       };
     };
-- 
2.17.1

