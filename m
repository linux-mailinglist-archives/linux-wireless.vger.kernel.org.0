Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822424378C1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhJVOKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhJVOK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:10:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E165C061348
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:08:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i12so2510029wrb.7
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Byda3t3fBgkK2vvUy7I3YkpW+LpkoB/CAoExYFZxC+E=;
        b=IP3rLg2Lpl+iLYUKorLaLPlBTdVPNh1+p51OIPdtdDZTSISOt2pUu32DKMcufCHGyt
         IlKmJNHzpRMXcpz8T10pfhmjGq+wxw5pQjvKjweHTL4VEVuamIYx8O38DK6nYbBrxAjQ
         dqAEHcwPGSa5LlEMmABTo+kJeJWqXsX4sd8/H+SKsyj7BM6QFX4ekGd6mCRGkpHdL673
         Wy1IwmZ4It0zRIhc1rnkJHIYZphVjsqKwwpLpCHIrPTPmStkLngT4pmkQf0arHf3chxT
         dw0CTg8uoBgj0SBVw8CTpEaZL5R4YuWDpAIV6JCk5d+5EVEN9jyhDp8Adp0u8JtrsKVi
         0y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Byda3t3fBgkK2vvUy7I3YkpW+LpkoB/CAoExYFZxC+E=;
        b=j7q+ewTFoB0fN+MTF8CBArNwmuuNZ+PPOQGh5sstWPpIBYFqoIbLmdvadM5Wrm2oT5
         THyK5Ua08iO2dhi8tSB4dEDv3mdDDDIzy+8yRXGSdaF2iJ34ZPg+gPaaoaQ1PE/N7FAO
         MNDaEWmMD+2z9WuyP28rxR7adsXAjZMya5VSshbz3mbCwF/80XJgQkk7J32q99JKadUx
         OPYQI34uXfkc1xX69bkF4SyxTU1FG4K6i2vLY2JyjulD41WlG3lxzAm9KriMqkZOVEla
         1aPqPzQKGx5U0bMuR6SqMGiXoUu5u5dsW6KrwKd5W3akFV0PhXkGpBY8OY98Cf+wvDyJ
         yUHA==
X-Gm-Message-State: AOAM531+m2lNpPNVBAwgi/bRUp09R9quTukIw0TiBhFVHHwilwSNg4D8
        ICammIQUb7P/WwdUifSFQwtKtNymi3H6bQ==
X-Google-Smtp-Source: ABdhPJxDQCrjkGmeGQlcKrSvoTEIvZpeZWHsvGbAciVagCDKLVdvB5LG+9fGg9GXy8uM+QEtENXxzA==
X-Received: by 2002:adf:bc12:: with SMTP id s18mr119820wrg.328.1634911688942;
        Fri, 22 Oct 2021 07:08:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y8sm3686444wrq.39.2021.10.22.07.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:08:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/1] wcn36xx: Revert firmware link monitoring
Date:   Fri, 22 Oct 2021 15:10:07 +0100
Message-Id: <20211022141008.2846454-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We can get this working with

- Secure APs PS on/off
- Open APs PS on

by setting firmware feature bit WLANACTIVE_OFFLOAD 

Open APs PS off though is non-functional even with the above bit enabled
and three quaters of a wheel is useless.

So unfortunately for now zap it off.

Bryan O'Donoghue (1):
  Revert "wcn36xx: Enable firmware link monitoring"

 drivers/net/wireless/ath/wcn36xx/main.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.33.0

