Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBB7773E3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjHJJNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjHJJMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C326A5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:12:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso996422e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658747; x=1692263547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Htd/z2F7UUScMygTNeT7Itp1hTM2TNM8XLM8S0EeMbk=;
        b=yfSdVESMRpRIqdOLo9ElSeY5VhUcLrAhe9vvR74OF27QX7tn8JvLFYN4qIXSQ6LrKN
         zp+rtZscwMT2u+cliOkOlI1ijhyLrQGZrXZoH0eK4YjoUBqzb4kx2Y5xvHKJHHOhBOSF
         ddS9gdY/ynd4QmvcGEidd6g4tBy0SeQn/MveMwxc6E3OiP9b9FqGGsc8xojcC+70Iyeh
         8jsbbsFVH50wP/LCTkQK6IKVj6KjYqj4c52N/xVsV/5vgAJz74xTZmP4FzoA3SXDKxUi
         jB4hLTNv7+RzEyai3VX/XuaexBUx56HlEoacEgR9I56wKQVGZ7lI67JVKAZI8TO7lmVn
         5wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658747; x=1692263547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Htd/z2F7UUScMygTNeT7Itp1hTM2TNM8XLM8S0EeMbk=;
        b=FD6Si7vqmY3T+ROytxUfwu8jbmfebMqzUcUXaCrASi0u2tdO6PyCcrnRVLgy56VDZ3
         utz9vJMMnaSjQzOdXPhoGzsMUk+NZYf5IvZeXLZ3Z5XyNwpBdLfKHMSJTGzpZrx77s1s
         rHqBqr9DGytJ1K8ZRk2XSDUQkkOLKbP0iumTIz+lkxge5SQVHzm1atHdIKLi+BQP38Zo
         YUw0if4KVKB8dNDh7V8OJ/muyPIe1PGkoNTiEtqw+D1NOR2mi7AUAf78SHroj+xmBSjj
         kI6TibzMeiFsPK51wABeTwEnvGwOEmJAc9p8vOe4VpkGMOY1kv0wHOJQIZ0BGJfmvrYz
         SWDg==
X-Gm-Message-State: AOJu0YzEKPyu1DBd4+FtnxOcLq2sSwQBSdHaFtaLGN+ij+A6fuW33fFW
        GNgHTaywAkacwMa6IZdrn0mTUw==
X-Google-Smtp-Source: AGHT+IE6Iks4Spr/j3fclN0BH0yxXPY85IWHUb1d17wuwqtArGFuIGsqA+mNTYIL5i+q7A7/N7gOfQ==
X-Received: by 2002:a19:7111:0:b0:4fb:cff5:3963 with SMTP id m17-20020a197111000000b004fbcff53963mr1104029lfc.60.1691658747473;
        Thu, 10 Aug 2023 02:12:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id f14-20020a50ee8e000000b0051ded17b30bsm531961edr.40.2023.08.10.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/2] wifi: ath11k: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:12:23 +0200
Message-Id: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'hw_rev' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  h11k/ahb.c:1124:11: error: cast to smaller integer type 'enum ath11k_hw_rev' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 139da578831a..ada4d68c7421 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1121,7 +1121,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	hw_rev = (enum ath11k_hw_rev)of_id->data;
+	hw_rev = (uintptr_t)of_id->data;
 
 	switch (hw_rev) {
 	case ATH11K_HW_IPQ8074:
-- 
2.34.1

