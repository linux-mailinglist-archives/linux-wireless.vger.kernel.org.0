Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9722872B1E0
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjFKMhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjFKMhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 08:37:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212810EA;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-970056276acso508205866b.2;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfW8HTLYud1EQ9tICw/yqJQZQx8gu/6gJXHN5sMzGrA=;
        b=DipsTsm3cr+dNOJPEbzT/krkoZkZ+7PvswUNs6Xaiu/Zok9KXecIlT5IabEJG9KI04
         6TB0eYszMtJG3I1EUvkP9R3XzIBN2NIzEg4LbnhyZmxkQekM4abiE0/Cv2r8cLDjVf0S
         DN0Nq5mDiUQ10hZs66Gk0kcLUildSlcV+iI8+VKCh+MYGdGHjPvg6gHG1DIkCOmWWhUs
         27nGoB6U0Hkz78Vh2GIVcfa3W+GHQLDMtKhq8lWN5d0AFdNj/QUFnN53hrNTf7aTHWlx
         K4GGUaiGhhE+2fq3+LxOn7P9BWjSkjV6E2OJT7pb1TlYBu9TkSFmqhklwL+0T9Lh+r3f
         1xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfW8HTLYud1EQ9tICw/yqJQZQx8gu/6gJXHN5sMzGrA=;
        b=DX82GsLSOpo16VRZ2vu33994ldv+Jejli3CDE+fXq+d2sU3U8CUMqEPfOLBgJOFIt4
         wZ0Uf3mht1bkAQUmgywsiZdpnRprUz41kd2/FrBM6hFZctCxZpiWy1amYc0STg0GMaA+
         BQnf47TlPxxWShTv3m1KVR7q8zbpAaH5JqKNPtYexJ9qgFVw73p8h3wwPz2yP1212FfC
         /msBEJ0loIXlojdTtcbSOHFohtceevFHR2kcIDRl3sv/WsNDGHLOCxzDXkH3rI0Reqrg
         59mZT8ob7pkbHuLBrv1hO1L6e6SAN9HilCgqrRgVB5EXspn0w03XLP74Nx2jmWT50/Tl
         eGjA==
X-Gm-Message-State: AC+VfDyBxNHUUMTZ/fBdlFt/FkpsPg1PtG0VxqCnSvQVjDhdskXJpZUT
        TT92uDDSB1ktJPzHxJjRdJBDEtSFHQQ=
X-Google-Smtp-Source: ACHHUZ6Fb4nGanBr0hBWFYus+4reVW1WKuvN6K4zUZSQYA9dCf0i7FosFAStsWJAuyfWrdygkNe5+g==
X-Received: by 2002:a17:907:3f8e:b0:967:2abb:2cec with SMTP id hr14-20020a1709073f8e00b009672abb2cecmr7303359ejc.64.1686487055333;
        Sun, 11 Jun 2023 05:37:35 -0700 (PDT)
Received: from shift.daheim (p4fd09ff6.dip0.t-ipconnect.de. [79.208.159.246])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090663c200b009662b4230cesm3852749ejk.148.2023.06.11.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:37:33 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q8KK4-000LMx-2V;
        Sun, 11 Jun 2023 14:37:32 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: [PATCH v2] dt-bindings: net: wireless: ath10k: add ieee80211-freq-limit property
Date:   Sun, 11 Jun 2023 14:37:30 +0200
Message-Id: <c33c928b7c6c9bb4e7abe84eb8df9f440add275b.1686486464.git.chunkeey@gmail.com>
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

For testing the addition, I added the ieee80211-freq-limit
property with values from an OpenMesh A62 device. This is
because the OpenMesh A62 has "special filters in front of
the RX+TX paths to the 5GHz PHYs. These filtered channel
can in theory still be used by the hardware but the signal
strength is reduced so much that it makes no sense."

The driver supported this since ~2018 by
commit 34d5629d2ca8 ("ath10k: limit available channels via DT ieee80211-freq-limit")

Link: https://git.openwrt.org/?p=openwrt/openwrt.git;a=commit;h=e3b8ae2b09e137ce2eae33551923daf302293a0c
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2:
	- AllOf is a list. So add it to the existing one?
	- added example with link to vendor hardware reason
	  notes about the filtering
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c85ed330426d..7758a55dd328 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -84,6 +84,8 @@ properties:
     required:
       - iommus
 
+  ieee80211-freq-limit: true
+
   qcom,ath10k-calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:
@@ -164,6 +166,7 @@ required:
 additionalProperties: false
 
 allOf:
+  - $ref: ieee80211.yaml#
   - if:
       properties:
         compatible:
@@ -355,4 +358,5 @@ examples:
                            "msi14",
                            "msi15",
                            "legacy";
+        ieee80211-freq-limit = <5470000 5875000>;
       };
-- 
2.40.1

