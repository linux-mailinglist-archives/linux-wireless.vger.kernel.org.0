Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641136D8C33
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 02:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjDFA7m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 20:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjDFA7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 20:59:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C656EAF
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 17:59:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d7so3909180lfj.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Apr 2023 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680742777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4Raa0OR7WXYxLqnylowbsWrZ6nM/R8HDW7bruIHEw=;
        b=D10ncPGBOgRnIMiXNNqC8g6FcuG5XW1ETHr/ppA3OvELqpITLd8QQao3FNum1hsuOJ
         jxhsB9+keRcDSwONGSWAD02jPi+cGbNkg+wIRadu09gXsB2RRXgxfBsUUUbT6Uh+oi/q
         zwyS8E5Oy7or+DuUOMyplI+DNxdLWF3XUckfZmYDdMTaRkOG8JIRXXzC6faJQjcoUNVk
         +Zjz5ak+OEnMRIehFKlGrCnSmWCcSqS/XWdrXL7lhxczgQiOm73CHgU8XAv6cvXUeg/O
         r6uXSnbDGp9w3rNFArKA4QX5suA1+Y7F7MKGrLQqBMVuQq4K2Ets3Ocfb0hlvgVjRPeP
         682g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680742777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt4Raa0OR7WXYxLqnylowbsWrZ6nM/R8HDW7bruIHEw=;
        b=0ug7VZnDBE0dizz6qoGAeb0za+k2RBB/d05mOOPUjhJRMdRyQOo/yzCpCkDmbGu2qM
         TIv/wCHBdgsHIsssg9Wzj+h6LaSZV2s/QrsUTbKj9dNgE8zWM5S8vQsQ72/AN1d1J3vk
         OWuS4v24Uy99Q/O0pKPZ6OBHlTf6ufLHunudM01yNnvnZICXMTme1NZY3t4tDIyMyIUX
         GrLFvjJ4SRFMp7ttOenbB8VbDeN2gDRu5O7IBPDwluVRUY3csTS7sq4aNtmxTH0K+679
         2SblOjTtUtZ9AHNWn5bBBMJR0sjePdvn1HRRsTU5F+rnXfbIa+5bLouel30jmpqC3xN9
         G1SA==
X-Gm-Message-State: AAQBX9dsAhdXccO+Y7UPve5/DhK0ea+ImBqBmTsWHGn5wH3P1whJmqem
        wV9wSKHwicgH7s9bCRZI713CXg==
X-Google-Smtp-Source: AKy350bvRQ4xglcKBLR2B3LO2fNEinE6KMqWCgUjt28/qklI1ZlXN0Al/TofHrb2Le93U72r2Do0jw==
X-Received: by 2002:ac2:5a45:0:b0:4e9:9e31:5f70 with SMTP id r5-20020ac25a45000000b004e99e315f70mr1995840lfn.56.1680742777587;
        Wed, 05 Apr 2023 17:59:37 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v7-20020a197407000000b004b550c26949sm48280lfe.290.2023.04.05.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:59:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] ATH10K YAML conversion
Date:   Thu, 06 Apr 2023 02:59:34 +0200
Message-Id: <20230406-topic-ath10k_bindings-v1-0-1ef181c50236@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHYZLmQC/x2N0QqDMAwAf0XyvEJtdWz7lTFGWlMbJlEaNwTx3
 y17vIPjdlAqTAqPZodCP1aepUJ7aSBmlJEMD5XBWedtZ69mnReOBtfc2s87sAwso5o7pj7hzXf
 O91DbgEomFJSYay3faapyKZR4+8+er+M4ATBWI0V8AAAA
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680742775; l=762;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6wHUgDnIplyPhsLs7QHChoA/jlMqdzmIksoJsfliPu4=;
 b=Mg0AbrS53coeHuAmukl/B1WS0JpN+XpwrJVH/ak0bj7Ga6cjjpYcC3NaSYxTe9qwhDt8mFDD2Y5d
 Oe//HZGCBF26Of1Q4PodIBSJd+kb16DmZP5K1lqWFPaGlMN8gVl4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is my attempt at (finally) moving ATH10K to YAML.
One inexistent dt property came out as part of that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: net: Convert ATH10K to YAML
      arm64: dts: qcom: sdm845-polaris: Drop inexistent properties

 .../bindings/net/wireless/qcom,ath10k.txt          | 215 -------------
 .../bindings/net/wireless/qcom,ath10k.yaml         | 357 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   2 -
 3 files changed, 357 insertions(+), 217 deletions(-)
---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230406-topic-ath10k_bindings-9af5fa834235

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

