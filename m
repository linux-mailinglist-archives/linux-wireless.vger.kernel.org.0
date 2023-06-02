Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E37203DE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjFBN7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBN7n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 09:59:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324801B4;
        Fri,  2 Jun 2023 06:59:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so25099401fa.3;
        Fri, 02 Jun 2023 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685714380; x=1688306380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq7HB21XMVzbuju4In7eSNLqalYy4ECbVHCyuGvLgRQ=;
        b=ZdLjJfv32SsP/aYsyMqUqCORlXRb9tzTXgWDfUZNaRWE+N6WMPpCPLlTa7dgG/J0E6
         VqTEFb3b9zUoU80t17v/FW+Y+h8qKOUzE6Ev1o1hUlvtAQ0N+Sv8jT7BLE2Bj2kpmN3k
         OxHVAD5Hly8VQGBZc5lyXmxMevumG22vc+XwCI70GbFrF6ILKjKwwpNo91UBj9cvD+bT
         ckIRUj0K33L/xZ4+FLbz8gXsFboEecoA6LD7cTvYARNIlPxZwlhk2bLyNwL9/Q9/2zZH
         GZmky641UVt4fwd5eFYbWwDRx4ctI+gNkdF60pwIPOQ6jWBCcRnr4J4Phe5NsJGoj/Ot
         fZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685714380; x=1688306380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq7HB21XMVzbuju4In7eSNLqalYy4ECbVHCyuGvLgRQ=;
        b=d0mfR3BYEYU2rxP6m0PlMT8RyG5rgTRrsyaQt6pFhLIDJpmNt59SrdgVaYazFIDoYX
         i3kJO+34sL6IkjMKRl98SQ34Isg7hqEJ4Upnpm0uXnT8O4KLkxC3MLTNo8gxppadJDpJ
         W87lgt+vKOaK0oMRH8yK+7yv2mUIrWM6Ca/r5QogOBWh3qJ9Rp60W1dXBGUp4k4YPRmS
         Y2Ig7THkukxaFGxPyRbxGP0jJH5SHoz2h8zQClMlIDLU9WaKnldfCGdF3L8deG5+1d5W
         9wsw0T0SaB4DezbazDK9u9zhr1wmKKoolQDleEpfY9ROgdEoFee5ljU8Q/uIJrhzLrZP
         FKkA==
X-Gm-Message-State: AC+VfDz/G6mtwQqQg6gofA/njopQwj/oRYvNGh9SqnWOwWNcp1i7eHkS
        Cy/yu0/RMt7dxMYDnMNIlXA=
X-Google-Smtp-Source: ACHHUZ6mJe1gbtLO6kefCFoFBKsHd/47SyFqDp3q6ike3CxAD67E73K2C7Ln/s2wuqb4eRO0yJbXtA==
X-Received: by 2002:a2e:b602:0:b0:2ab:145e:c04a with SMTP id r2-20020a2eb602000000b002ab145ec04amr54492ljn.17.1685714380108;
        Fri, 02 Jun 2023 06:59:40 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e8199000000b002adbf24212esm236579ljg.49.2023.06.02.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:59:39 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Arend Van Spriel <arend@broadcom.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: net: wireless: brcm,bcm4329-fmac: add BCM4366 binding
Date:   Fri,  2 Jun 2023 15:59:23 +0200
Message-Id: <20230602135925.14143-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

It's an 802.11ac chipset that can be found hardwired in a lot of
Northstar based routers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index fec1cc9b9a08..527f055a6683 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -38,6 +38,7 @@ properties:
               - brcm,bcm4354-fmac
               - brcm,bcm4356-fmac
               - brcm,bcm4359-fmac
+              - brcm,bcm4366-fmac
               - cypress,cyw4373-fmac
               - cypress,cyw43012-fmac
           - const: brcm,bcm4329-fmac
-- 
2.35.3

