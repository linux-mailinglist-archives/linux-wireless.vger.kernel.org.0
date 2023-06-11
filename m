Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EAF72B1DB
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjFKMhi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKMhh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 08:37:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15559E63;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977d55ac17bso619311966b.3;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487054; x=1689079054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKDEqVBNJxLHyWcpWhxYEDcaagbwl62DkbQPgzzJEqQ=;
        b=E0p+bg1sj7/jjAdpQm12mb9yfZuRaSIHsKURrMBsPg2Qc+YYVpDKF3tnuveUOXhcDO
         o30y4uhNOG0sjjRyMlJD7MiHeodHxRZCTohRQTZMH6m5VU5kTwg9/lXTADcRaY0yPERL
         10SAWyArRExkxSaZZFJxKQQjxS4tjW06bvz34CD4njybQrP0DkX2k3/mNIW/KW9DrFTL
         Kji3fG3WNgGwd8rb5Tx8z/RAZlYnL2ReY28lTqeXANbbY9PLgROnGD3/NlM0jVsdzsIc
         9k1mxxnrsMvhRvvihBwwEgCKY6coxlnrYf9GyRISExPu4Fa6hDe+E5pTFavMV1UH9sAM
         51QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487054; x=1689079054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKDEqVBNJxLHyWcpWhxYEDcaagbwl62DkbQPgzzJEqQ=;
        b=USp3do78CWGhpY08EOo+xtdbadEFlQgZ7K2/laKRxantm/WcQIAsik/ehZ1iVdZe58
         TI02EaohV3eUQT1hJQU0VPuIn/0Wpk31Rq1knXyIsrnv7Jmt0YpALi0ynKISegm5/jRZ
         dVKvlB/DMOFQK8XBuNacRJtnfzYi5pkd5fUQP/v1hwkUmADFJcL4jQLG3PJC2MuMihgI
         lhd8hvab3KX3iDt8vSW6ZjioR3gCrc4thB0/Xdpe59zqy0KCjPYCpDEjtG5LD+J6gptj
         eVV70Ew4n+nM1HCVUVGW+4NZymzazZjrTmGQ/j78HWAbCV5LLn7NxJyBIkHV53uybC0n
         HomA==
X-Gm-Message-State: AC+VfDy0JxDIXOhfVwwFql/A5+2P5x8ae4MIOBTMj4CjhLI8EzZUb1Lm
        DGNpk+jjPWysKx7wkZ0gClZQ7uuPDFE=
X-Google-Smtp-Source: ACHHUZ4kwduvkYS33AizAyoJQ6d6KJtRYPJOcLthUw+LV4CKh7RnIjj1QFaMFbRCtPkVbhDpaSri8Q==
X-Received: by 2002:a17:907:16a4:b0:974:216f:dc36 with SMTP id hc36-20020a17090716a400b00974216fdc36mr6680424ejc.17.1686487054314;
        Sun, 11 Jun 2023 05:37:34 -0700 (PDT)
Received: from shift.daheim (p4fd09ff6.dip0.t-ipconnect.de. [79.208.159.246])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709060dd100b0094f282fc29asm3709170eji.207.2023.06.11.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:37:33 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q8KK4-000LMu-2R;
        Sun, 11 Jun 2023 14:37:32 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     rafal@milecki.pl, kvalo@kernel.org, f.fainelli@gmail.com,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: [PATCH v1] dt-bindings: net: wireless: bcm4329-fmac: add ieee80211-freq-limit property
Date:   Sun, 11 Jun 2023 14:37:29 +0200
Message-Id: <288fc9a0db6c292bc132e828611c41785b075078.1686486461.git.chunkeey@gmail.com>
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

The driver supported this since ~2017 by
commit 0f83ff697356 ("brcmfmac: use wiphy_read_of_freq_limits to respect limits from DT")

This property is already being used by:
arch/arm/dts/bcm4709-netgear-r8000.dts

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index fec1cc9b9a08..44e5f6677289 100644
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
@@ -63,6 +66,8 @@ properties:
     description: Name for the OOB IRQ, this must be set to "host-wake".
     const: host-wake
 
+  ieee80211-freq-limit: true
+
   brcm,drive-strength:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Drive strength used for the SDIO pins on the device in mA.
-- 
2.40.1

