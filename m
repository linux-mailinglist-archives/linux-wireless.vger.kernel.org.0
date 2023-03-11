Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6D6B5ADE
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Mar 2023 12:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCKLOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Mar 2023 06:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCKLNe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BD1E9DC
        for <linux-wireless@vger.kernel.org>; Sat, 11 Mar 2023 03:13:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so30653687edb.10
        for <linux-wireless@vger.kernel.org>; Sat, 11 Mar 2023 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYeKkWHhYvN+444DTzgsl5+G+f11J6OJGCVyHJg/Evs=;
        b=FfegRiBCebxhiHZu+Anl2gLy58pjJKjlVwbjRhrrKUu7nrGPSb9ZC0KqzD+nxGICwc
         yAnmoyyq2shISuujndfg8IVnKrPFWg8/Z0oI6SCvKGf1zue4uY0slKgHAuPENH2wVTNw
         3sdsQrm0dEehM+8l5L25hs9mKIqqYfHQbaWDHTlStjdUvddD12YlEwN50a5a8ZZMrefP
         Sb09YV5o2MV13BXstUPo20xOBfjR0TDauTR+QPE2bkIgMMqvUJU4dd0hatfI9nrnKfNQ
         QUVdW8zwh2iCjkbOykhHgmsn0qzucWBwnStg1Ho3GLaXyuSUk+0Ji4BTvejYqtqlJdou
         DJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYeKkWHhYvN+444DTzgsl5+G+f11J6OJGCVyHJg/Evs=;
        b=QP2Q0EkSkWQ5AM3lQhzPw4byNkZz5GpJFCrma0PD8PuuOja0dZ8a2YA9z9qg4WiLVH
         589mYtX3tZlgjIN6lP/hJiE84rPBy5inSYqbob3OAjl3YjGms8O8v2H6bW3/aiMWpbuW
         eSEd/oXvjhGGeIeWtRTB/zX+eq9fTg9UcQ2i1DL4q+PEDNOkmcKJbuRZQeCXMLhx/3Oi
         umzo2INyitCDtaAtNh4EpKLQpvmEzZdXTiaLTTP3UKcqGERJ3CTFdsfALuzFlcZi9rNe
         cI8tVKRbAQuuTanQhYLYh+L2S3N9jvAIveX25NVimZExyjUCfzszmJv9kvnyTBZda0oT
         yqcg==
X-Gm-Message-State: AO0yUKXDaT24IUs2cMPQyvK5UTdmRzgzKg4a7GZMif15Dcz5UW/OAJ8p
        E3WvY1v8TrRMexoqRZZ3ILLOPA==
X-Google-Smtp-Source: AK7set+geB3WimVsQZxOu0FKGq/F0JNtiq/b4zqiHUOE3p4BIg7uSfKlTL73g821Ym14wGENKaU1GQ==
X-Received: by 2002:a50:ed12:0:b0:4bb:8e88:daeb with SMTP id j18-20020a50ed12000000b004bb8e88daebmr26559718eds.31.1678533211216;
        Sat, 11 Mar 2023 03:13:31 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id sg42-20020a170907a42a00b009202ce3c8adsm722621ejc.27.2023.03.11.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Greer <mgreer@animalcreek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: trf7970a: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:28 +0100
Message-Id: <20230311111328.251219-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/nfc/trf7970a.c:2232:34: error: ‘trf7970a_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/trf7970a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 21d68664fe08..7eb17f46a815 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2229,7 +2229,7 @@ static const struct dev_pm_ops trf7970a_pm_ops = {
 			   trf7970a_pm_runtime_resume, NULL)
 };
 
-static const struct of_device_id trf7970a_of_match[] = {
+static const struct of_device_id trf7970a_of_match[] __maybe_unused = {
 	{.compatible = "ti,trf7970a",},
 	{},
 };
-- 
2.34.1

