Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745F7203E1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjFBN7q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBN7p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 09:59:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C813E;
        Fri,  2 Jun 2023 06:59:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1b2ca09b9so5613201fa.1;
        Fri, 02 Jun 2023 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685714382; x=1688306382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrRm9mbhnmjr+sQNDH4TjteCZ6R8/1j4j0I2dwDcxPE=;
        b=rJMHJt+8tlPhpCkKZYtqXnfYId/ftqviQyj0WKyxdzv3Q2V0qQxNLBbedqjIjrDXFR
         q3zACnKLczXJgEqgm5NNcj2lcmLZtPgFkTuM1j4lTqy/WjIsLvYI0qFSt1lEr7hwDjxw
         zrvcIOh2yS1Q6hrt844RVfoyLM6/h+ByPCecJpOzJPTLShT9pO+mxhrn1fmUO1Qpe2Q7
         u8j+vdlCzdhjyLQkPwPeLkdxI5QXTychr2xRCetqZvhoF/BL+l8lbwOgom3kDDxBNJ6N
         Op+kb7pvvhtE/y8M7X+qCv2Qe8CyxybjDcmst1cWqdB2qAI52vu7CEIpd0CpasBq0tzw
         w3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685714382; x=1688306382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrRm9mbhnmjr+sQNDH4TjteCZ6R8/1j4j0I2dwDcxPE=;
        b=ATnGa9ATbMcZRMOfDQDHPoG1NrPTce+kamS+XKGffH42hpsLw6bFHxrvDlMQBIgszu
         xFjZRiZhPUy+06H4IaFWfvE1ML9tCH8IG848dkFo3Oz0FXN6HPhtaZHf+97pAabODpY5
         MrWi+KXPMLn/YVugyVF7oFxvNIoJTGQh8q4+qx48+azuuHVl4Zlfc96p/nk2ZsDQNgsw
         L2py5AJXfg91dmPTB+9/VZjMFFceeQub18u0J6ILmg/bfqyjpsfpk0EFsfsVd0pGOjaE
         8XAMv+00jHpwI+FEAcMGhbUoIlhw0DLqd3WEF1dWqR5cRoinwtRzuWDpoAGuye11cbB+
         RaTA==
X-Gm-Message-State: AC+VfDzlICRxFBrmEyaO3ZHGmEP2npS6BloPqXTyTQVVe4dAETy3sqvu
        kvTOo+IGovEAXgpX4iXWbxQ=
X-Google-Smtp-Source: ACHHUZ5ACdd5I3ygzTy0xC/I+FT8wUQxaU/RIIf/a2zI+IJjOKk4gyQFKVfpUpWpoDXqI4CaaqKvYQ==
X-Received: by 2002:a2e:7308:0:b0:2b0:5f62:8cd with SMTP id o8-20020a2e7308000000b002b05f6208cdmr90743ljc.0.1685714382551;
        Fri, 02 Jun 2023 06:59:42 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e8199000000b002adbf24212esm236579ljg.49.2023.06.02.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:59:41 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: net: wireless: brcm,bcm4329-fmac: allow generic properties
Date:   Fri,  2 Jun 2023 15:59:24 +0200
Message-Id: <20230602135925.14143-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230602135925.14143-1-zajec5@gmail.com>
References: <20230602135925.14143-1-zajec5@gmail.com>
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

Include ieee80211.yaml to allow using generic 802.11 properties for
bindings of Broadcom FullMAC devices. That allows specifying frequencies
ranges.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 527f055a6683..4aa521f1be8c 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -15,6 +15,9 @@ description:
   These chips also have a Bluetooth portion described in a separate
   binding.
 
+allOf:
+  - $ref: ieee80211.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -121,7 +124,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.35.3

