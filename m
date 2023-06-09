Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69794729392
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjFIIpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjFIIpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:45:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE518D;
        Fri,  9 Jun 2023 01:44:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977e0fbd742so231135466b.2;
        Fri, 09 Jun 2023 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686300297; x=1688892297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2m01kvhOF2I2EUXo3IlN8hGgswTk7oH4FeWuyBRNa8=;
        b=am9QIvx7QekKST0NXLKJo5aSPv82fLUuKqa4LffbKR48CuwJBWxBzGpe3d72WgFXyO
         wLvIaV3AiujQI4AyhiMVHQjZac6NkdtmYHJnRO5lwco/SuOrYPNIOlzLi5K6HnoNhcE9
         ogccymsmzzXA97+/WKcGgtHpvYm/D5mVl6vmAKSlaZD2EvXIX1WkBJ/+hVL03NnarFDB
         QSg8YkUfC4ofUXhXwDkAOrAJS/PQqjQuuLH+28T+iIlz5GKOCaaSQQiC7q5uPfesc1aa
         n8GqhK+DreyECmxXXr9bajCNf5XALY+nc3eGTKg1BHrbFsKgNm5oSJzztJbH5qNDmFX7
         KH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300297; x=1688892297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2m01kvhOF2I2EUXo3IlN8hGgswTk7oH4FeWuyBRNa8=;
        b=fxWs8Je8DnJVC1VkMg0UZV7qYpKiJ4uBqjiLyApfG6ruEoHpPFuA66KtCHVuNdVHXz
         E1neZtjT4vwL9t+nmxIX2L7dYbmWcv4pO0+810GQXJy9Klrqkn6vyNkP+Sl/4FAaYxUm
         qbUEgQGykC1sXhWZNwsxKILWcB2+UGKJ/YTyRt99uSSX65IBMJ42mwerDdonwpI0zUt3
         1aLuWfAgtOKx2eNYqKrl6b1itXlZcvrBOLE/4iFDINddnKADdKfxLMqbMCjz77WN9VD5
         JBqFBD06P4Gde194NWKfGAEqMg7WqMzODsPH4ZPdscUzKv5fuxptHcvCscZJso0btmnc
         J3Dw==
X-Gm-Message-State: AC+VfDwCDpDyCzgElFLpqQxKilkv1wc4TAvFTo5Y7/NguyjyMQPJtYdP
        vyBH7Y1ggPY5yV3VghKriuq9K+4fqEQ=
X-Google-Smtp-Source: ACHHUZ5QzLadAPdG9cB+kjCl1DS/fPiN26MxAdgN7lxN1c8+aeWylkl3/EDmP9O7dYv1z3xoH7RHsw==
X-Received: by 2002:a17:907:1626:b0:977:95f4:5cca with SMTP id hb38-20020a170907162600b0097795f45ccamr1037363ejc.54.1686300296651;
        Fri, 09 Jun 2023 01:44:56 -0700 (PDT)
Received: from shift.daheim (pd9e2959c.dip0.t-ipconnect.de. [217.226.149.156])
        by smtp.gmail.com with ESMTPSA id lc20-20020a170906dff400b00970f0e2dab2sm1000421ejc.112.2023.06.09.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:44:56 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q7Xjr-0004fO-1J;
        Fri, 09 Jun 2023 10:44:55 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: [PATCH v1 1/2] dt-bindings: net: ath11k: add ieee80211-freq-limit property
Date:   Fri,  9 Jun 2023 10:44:54 +0200
Message-Id: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
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

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 7d5f982a3d09..91bf69c2df01 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -58,6 +58,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  ieee80211-freq-limit: true
+
   wifi-firmware:
     type: object
     description: |
-- 
2.40.1

