Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901372A139
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFIR12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFIR11 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 13:27:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53A30DD;
        Fri,  9 Jun 2023 10:27:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97467e06511so338961366b.2;
        Fri, 09 Jun 2023 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686331645; x=1688923645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBlvpkapb3S5TXw3HEYTW+PcvrpF6HWECZJi4X+Mzp4=;
        b=jwxV/JhDrE1JIYNpbRXRvZR1eNbyK/P25a726MCS7/SOEBr2f4HMFnEsw0ebCNyQJR
         N17IGdjnrKWElfV0q5RbTjZXw29COnTMQOYmy51xn0XqAA/HP28oUsq5eiO3dOgLYe6L
         ggXuNLh4+VXOPRH6iJ0tGv0rJDEq2fbc3Hd5Vj3r85I5dknUhdlqTtPV+GSMsuLCbvD7
         nl8JPdUeq8FBrJ9CdLoxzT+oAelsLTyEUkyBOMp4ZJLowOHuZLJ94XKetc/G8UwJqKyp
         V/KuYLkSZHWii4YpeEXDYxTNpvWUQBf5tS2o6BQ/lxm49M5lTkMIa3z5t3baWCvVZnPB
         KDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331645; x=1688923645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBlvpkapb3S5TXw3HEYTW+PcvrpF6HWECZJi4X+Mzp4=;
        b=a7ymlv4PX4uCF4BuE7zWUUqZEY4b5SyxY18Hx33QLajgXdLbwmJzif2kHh4Kz6LWSM
         1tTM0D0lXJarPpic2Yg8LzxGciav4TWlBq+H2oqoNdowGvrOyVVinPpQUC+2tdfbn8Lu
         vbxdoZQyMJi++UkgipjFwOwdrtJafpNzfXaUBOJiYnW1csq0PeRfrB+TWjO/QV6+WsZe
         KtnOAaFan6tpn5HJ4u2PIrvwNHHREQJhSj3iL/GEJyg3A8wKlgn1+ZLEystlk9SwFoPW
         ByyoHQGE4ooyOD3yblODAKZ988PpqtIHE1C6VOd+Fo9z/RYi95TxMgNgn/tehfoGBpxx
         frvw==
X-Gm-Message-State: AC+VfDwV1RydTbPttPtHKG1wAuT1mS3/4YW4UyRWicHE2VEXpfz3f7N4
        NS4qW9Iyh+JUYXzVLkTTmP1KLQWopC4=
X-Google-Smtp-Source: ACHHUZ7cF5TdfCz0QzjlZXBNor2s9JlusjzWgB/1lzfd+n3faNH1UWC1izdjrIK6ae//QPBZBLjeEQ==
X-Received: by 2002:a17:907:741:b0:958:801b:9945 with SMTP id xc1-20020a170907074100b00958801b9945mr2510182ejb.31.1686331644733;
        Fri, 09 Jun 2023 10:27:24 -0700 (PDT)
Received: from shift.daheim (pd9e2959c.dip0.t-ipconnect.de. [217.226.149.156])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906a40f00b0097d9e2b5f9csm11048ejz.170.2023.06.09.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:27:24 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q7ftT-001k9b-2Q;
        Fri, 09 Jun 2023 19:27:23 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: [PATCH v1] dt-bindings: net: wireless: ath10k: add ieee80211-freq-limit property
Date:   Fri,  9 Jun 2023 19:27:23 +0200
Message-Id: <f30552d1bfdb4c56f99ca79d8fbf52d3fcf71686.1686331623.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This is an existing optional property that ieee80211.yaml/cfg80211
provides. It's useful to further restrict supported frequencies
for a specified device through device-tree.

The driver supported this since ~2018 by
commit 34d5629d2ca8 ("ath10k: limit available channels via DT ieee80211-freq-limit")

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---

Note: this is for ath10k. The other patch is for a different driver (ath11k).
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c85ed330426d..99db442cef92 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -12,6 +12,9 @@ maintainers:
 description:
   Qualcomm Technologies, Inc. IEEE 802.11ac devices.
 
+allOf:
+  - $ref: ieee80211.yaml#
+
 properties:
   compatible:
     enum:
@@ -84,6 +87,8 @@ properties:
     required:
       - iommus
 
+  ieee80211-freq-limit: true
+
   qcom,ath10k-calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
-- 
2.40.1

