Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633E4382A1
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJWJdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJWJdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:33:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E82C061764
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:30:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e12so2456509wra.4
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tvcj3Tu7wZBfjgrOoHFPXrMVlJAmRlLA42ROSETHGug=;
        b=V5p6oLcVx2jE3KGaP6Szf2WGKdL0fJxAcMhGDtG48dwixLh69aBsjuMnxxLQNLR6lu
         DBBG9uhWqZomvSBeSkH32kkY7adskPwk616+R0GKMe9trfIrpxZsI7dTBQohJbY/TWQ8
         BvhmwQRP+Ae0wod0yanrLl3l3lRUU91EqRew/ElG/Jmo6yAybjHqBPc2zzlcObgDGv7u
         G7v2EdYJxQSoTbRjCbgHaqFzLnvKXvRcnMcnGcx6OCFmjKoXUfnhKVhfX59ItKQEaI3V
         f3YqNE2oFa0GK2ptowuwxj+bPeliCdRb3OsnISS8SRL4pQ8KWwZZ/L48w4ZZos9qJSRT
         wG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tvcj3Tu7wZBfjgrOoHFPXrMVlJAmRlLA42ROSETHGug=;
        b=UoJVGbr84wXknk5iVwIz93fr/b0tYtldiAcLFGkmeT4Enxa29YDjxnMNOds9CRIrAH
         hs4WV0ENa/HyrSvKk95zXoZm6FpIhAZzWeEOue2+Pa64q1IEDaXCLguPTASi0XLtd4l5
         poRDB/DCcJOG9NBx3qQ1kYD3sT7wdLVR8iKxofu9JDWO2Ao0myvpilao1gB+PyRX4CM0
         9cuGgZgaT1bQP/3mUwy+/lOwqnbQK1oKGpWSdri0QuVnT9gbzusrQWV/8CN/7X/i5owC
         WaM2yPx40zq4hp9PU6LJoxn9AHylBfDsA0vl4CtpIHaMiwzvg3ydvgg8y0kGvnr35iGb
         FcBw==
X-Gm-Message-State: AOAM532hx3gi/HQAowJbXq46RAe644RkhbqLWHYDGTQvXpGJ57aUneUi
        qSNRa5iDY3dWIW1yR2tRlAju+A==
X-Google-Smtp-Source: ABdhPJzYW8dTZhtd3eBvM5+tYQwYlGRZ+/rXXOrKLPNwu1OqHfci/m8+LMt5V8wMlAWO/gYdhBN1gg==
X-Received: by 2002:adf:f211:: with SMTP id p17mr6691862wro.37.1634981458211;
        Sat, 23 Oct 2021 02:30:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t12sm11456977wmq.44.2021.10.23.02.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 02:30:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/1] wcn36xx: Revert firmware link monitoring
Date:   Sat, 23 Oct 2021 10:32:56 +0100
Message-Id: <20211023093257.2849565-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

