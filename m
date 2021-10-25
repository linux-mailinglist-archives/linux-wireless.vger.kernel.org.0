Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D810D43925A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhJYJbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJYJbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 05:31:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCBC061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:28:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j205so9350712wmj.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/+oZOCwMQqCUIX1z5v+OaCxmYJRHF2kwnH6X7mMYmA=;
        b=m7Mhijl3RAylArH+60Hlq/RuLfM9ldI53Bb42CqSn1GCr6S8hx64jpBY6CP2hUiT2B
         quGkJ4vfPtem7pc4DQtwFCqBnr/xGIzO40/1sZwp3W2LISbOKZLaJYHXF3QlXMth75lZ
         b5vXgpDkvLuDIWFAReFy1tqnuZnS/jXuqWC6gTwdb0+EQ7RiHsUeX1Azbo2SCKvgV4yh
         cNG4El8nRzgSosgRpgTnpfkz4KcpJAFVI/ww5MYEpltwBgpNiMNSSJE89YhFiFsTjrIW
         ZcUNlfcQ2tfp6RHIQMoRPFDabqnNp2vt/DhUvV0CDev47Jsme/f+kxTo14mfjT25HzM9
         gFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/+oZOCwMQqCUIX1z5v+OaCxmYJRHF2kwnH6X7mMYmA=;
        b=kQznaqo0qV1l1TmI4iOOpBo3wlWDCEs00ikdGp/GpQqTtyx3CWtO+2RF6JpGihHIev
         OVYLqNfoosqtpNYyk7W4fvQoxOyfS4Cme7ytNqQsthieFpruA8t7sgyQPSF5OU7izWeV
         tlT6N0G2sRlQbtUGRO6IQbP7+4aeDepuorvzs+NbUc/IKKtddGqH6MHrnWSQxYPDJ8M9
         ngkn+n7fGYzYl7acGPL2g5nkz2iikPDY69bkznKOSJd70qcmG47tyY4Asux5gONAGnTR
         QI40wLJDBzKML1BEfiabPvQIMCsZZmj+zykbIG4o9eLhFx5XjoCZhYuGzcHGS3g5ecCQ
         YBLg==
X-Gm-Message-State: AOAM531eG39TfZKp1peQyDYQEEkF0UsTddbPeNJtGnBrF3ji9swm5I7F
        mQ+y8tCZuBMxyAPTIh7ITrsFPy4DQZ47zA==
X-Google-Smtp-Source: ABdhPJy5ssV78/mBoHv8MRUlJLUhN/pch5w5kcP4Kple26xMVmO/dSaxiThtx/Bt1/MnHuTGKI72Mg==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr18624045wmb.37.1635154125046;
        Mon, 25 Oct 2021 02:28:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z135sm20858853wmc.45.2021.10.25.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:28:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/1] wcn36xx: Revert firmware link monitoring 
Date:   Mon, 25 Oct 2021 10:30:36 +0100
Message-Id: <20211025093037.3966022-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V3:
- Remove Ben's SOB
- Drops Fixes tag
- Adds meaningful description of what's being done and why to commit log

V2:
- Adds Fixes tag

V1:
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

