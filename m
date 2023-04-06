Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FB6D9685
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjDFL5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjDFL5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 07:57:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574A9EEC
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 04:54:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d7so5459796lfj.3
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680782052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=NT0z1D54Jz23Qd8QBqW5y4LUgbLtaQiI1TTTYvzoNpqNjsOnHncu4tIm1w0PLSWfus
         FcGnKVh4sD4n20MNNi8iHuadPLgpCDZy3tNxNa+3prJ768N6bKVXy5ptvrYhfmmP153M
         nQT/Rvmq+0VrCWP7UfX/LVCU0QvOlyKPLKiaKC76p+4gyYfBcH048wCc/sJ0dGjmFB12
         SBH7ATZwDZgnf+2p8rbb5dnINgkFDUZxaevgSsqVaCXU8PiAW0dN9GX/a9MPcCZQT9dy
         jsjn0PO7g5uIHM+UuOO0VqtmQ9vqvErlM/XEs0HeE7HRYS2ojiPvPbuUXnSNbBXOHhoI
         tfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=PwLSucFZB2ea+oxnFYvn1nD6HoiH/sqmzE/kKQNBc2jFOaKjFSKArp/H3x7Sf5ffOB
         5ruumMzfe8TPZyGJh4YecnWE5S43MHK/M8cE4HrsFQyjuE/VQbxqPH8O6XuX5/m7R262
         AZCWtpigqt+ZpqXjuJfYnSdkRB6y4d7q6lmNN3Yzg8sz/8be6nFrWjmP34kWXlk6Imo7
         PA90JDA2+o8YVQxYLFaxA/6VH0GOGv2JtCheivBeuNf8NDFjKCyo54CtnZHcJWdXN8+F
         JEG2OJfClc5p5lGDjK+uhzxr29dNDk5y6IYgptJhObI/FuAz3ZVKvH5jE+uzxKyhN8Fj
         fDEw==
X-Gm-Message-State: AAQBX9flNWaxbbRLZrocNGjNykGegRrjnu0aYobxf8r6u0aVUCVxsvi3
        Cox3ovoMyPsHjZe02PIwaLTjZQ==
X-Google-Smtp-Source: AKy350YOJBBOhvLdzYhTyarkDYK/pXLiXR2cWg4R6nvYfiOFuIxo3sv/hjwJhsRRoIA0DWwgZVofkQ==
X-Received: by 2002:ac2:596b:0:b0:4e9:609c:e901 with SMTP id h11-20020ac2596b000000b004e9609ce901mr2444588lfp.21.1680782051848;
        Thu, 06 Apr 2023 04:54:11 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id q27-20020ac246fb000000b004eb2cc16342sm237513lfo.21.2023.04.06.04.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:54:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 13:54:05 +0200
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845-polaris: Drop inexistent
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-ath10k_bindings-v2-2-557f884a65d1@linaro.org>
References: <20230406-topic-ath10k_bindings-v2-0-557f884a65d1@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v2-0-557f884a65d1@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680782047; l=826;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A+cHJo96LANW/mYlLiz68VJ9kDkIsUWUlAaAZ/obM9g=;
 b=JZKiZ4o7YkofUMsu2AgB8TAPweZ+TM2wSK7+a4qVZ4XupOfbVVCCqYRW+YkwYuRfcRV1vwF/Z5lp
 cZVP38w6DVmxGIdjnblGj2CeL8CJgzyfVanJardNzq2u/QMMqRgn
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

Drop the qcom,snoc-host-cap-skip-quirk that was never introduced to
solve schema warnings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 1b7fdbae6a2b..56f2d855df78 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -712,7 +712,5 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
-
-	qcom,snoc-host-cap-skip-quirk;
 	status = "okay";
 };

-- 
2.40.0

