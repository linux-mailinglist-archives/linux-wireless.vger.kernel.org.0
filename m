Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20F72B1DE
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjFKMhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjFKMhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 08:37:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8610D8;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977cf86aae5so509169366b.0;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6QgzW966aN6BIIkzy3cK1mL47MJ4CEEdefvvAf/lCw=;
        b=QPs6ouJjMCKQWdtUgc3dgU1lUCNHVR3UNV4yaE3ZyXXxeW1SW0/XVCSDuFmvbueEq+
         y7qD6g+gE/84Yzourvtzc+qvWiDGSYV6uREOmHdrKwQ0+yOpQhyR/5zIMkKwDzzg7kra
         n9GTPEDLgiU1qafi5A2zHPzYbdNuIWsXlAAzFA4ZOwHyPi29XCsFNe37aBxmF3zBRq8y
         16166iKIKVtbocYQFzl1N5bZ704luL4tF0AH17A6aGBguhfCt87aU+uxQ2T6Ugc3qIIC
         ib/t68fZifu+gWf4VtaQWf44SB4w7lAEYbsgeKNiiBfBjPjsqtGzyPJiLsJlEwH3IbqV
         CG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6QgzW966aN6BIIkzy3cK1mL47MJ4CEEdefvvAf/lCw=;
        b=aiM9PMEWNlcQuT5w8R851siZa5A/1sdL8h4NJXVAuPnJfaLw4m0B2xhLaApmfxVtxs
         KP11tSNVgW0gzF6yRZ4QB/IZZo2O7nCzKkSj6GOI+0MTXyiZtCmnbKeG4kjbFlAgMJcu
         2jDqryXtgxMGxnr1LGBbHeYnFCk6CwPjNpQkLV38Oc2CMmTw9pyNuT2mN/hBNnPTT6bk
         PRrJRARfdb4Iu+I+DuGdWeIcDx/NHeLr/uY31JAxjkGlJq717m6p4+35zQrgVCpDygqC
         gWJX+OQnVFETf9AhPx/5IKLXsfcfzP0QEDJntzkkk6Dn+ChsaYcUx7QlL1tyoUVmBnDK
         nvmg==
X-Gm-Message-State: AC+VfDxe+Pr1ODWrCr0/6zOtC9S0d3sEZI4wFRyi5KElvuVNoMzap3IB
        wsig7IDaIiX9s0CzJismIxpfHHGQFJ8=
X-Google-Smtp-Source: ACHHUZ5+L9bsKXky3I4zLev4ZT9LXDiJ8TXQja3KgzbdHNiaAdJAR1wnAzg9Ywpu1jzg+q/yLhNobQ==
X-Received: by 2002:a17:907:3f20:b0:978:82fd:758b with SMTP id hq32-20020a1709073f2000b0097882fd758bmr6423965ejc.29.1686487055192;
        Sun, 11 Jun 2023 05:37:35 -0700 (PDT)
Received: from shift.daheim (p4fd09ff6.dip0.t-ipconnect.de. [79.208.159.246])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709061c0e00b0096f6e2f4d9esm3759194ejg.83.2023.06.11.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:37:33 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q8KK4-000LN0-2X;
        Sun, 11 Jun 2023 14:37:32 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: net: wireless: ath11k: add ieee80211-freq-limit property
Date:   Sun, 11 Jun 2023 14:37:31 +0200
Message-Id: <fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
References: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2: make dtbs_check dt_binding_check (moved to existing allOf: seems to be fine)
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 7d5f982a3d09..521dc71d5e97 100644
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
@@ -87,6 +89,7 @@ required:
 additionalProperties: false
 
 allOf:
+  - $ref: ieee80211.yaml#
   - if:
       properties:
         compatible:
-- 
2.40.1

