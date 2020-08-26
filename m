Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8B252A25
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHZJfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHZJey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C99C061343
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so483211wmb.4
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sh6GJ0mJWJb3ICmo91l9UDo6bvtBy9zVj1QpKnJ7Ig=;
        b=E7S6Pkng7Y0zFItSSiJ6u4PAD6CRFndCXBLJmIKAADhgYzB7tAwnaOstq39x7K8YiA
         aYOiEa6IQ9pL2hp7r4/h6gkkN38ntfPXaVOzMazdJu+zmREhsaSzSyEHFJRalsGXtdGq
         RH0GewQfte2wlRM98ENsZ362ARQtgwlM1+Sverg5BwZw6BS9GhUr+h+OwQTC+WD+R5LD
         xP6mO7vA/v8yQcC0oB3mckaIE4cr9uwDkWUMvsQSMjSzBT8BmE3dJhUPo5k9PsJ3dL4n
         7i40Rog29DFzVrx7zYzM4LzRshP1DRoEa6cMkG1OOmgevWJPDDV//yehqKjWH3ay8Sb8
         WoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sh6GJ0mJWJb3ICmo91l9UDo6bvtBy9zVj1QpKnJ7Ig=;
        b=f+bqXvfTytCb4K7+SAcdzBbMtQvUo44I+Drgqh8J9jSjNrXjV/QVMQ+cKWn65U83Et
         Ro0nWsnmvuDJdl5x1Lb3yDbgGT+t/uUuJr5qyd2RKfdRhHu2Pv3FdxgQIUYLe5pkdA7w
         dvMPfLd3eqlU4LZkfmcZ2pk43QAeAge/iGvdVqv2GT5JTRujXvUIUZn/9synvlq7bZpc
         leeVf4TOXdNlwU5n0pO6SRI7/v3f+zy28cwrAR0Tv64v+UDBVVERDFK2xcQqhB/Dr9PX
         /HZzDq1xufUtQvjD2bdyunon3anFbLrnWsbCdtIVKwFGDM1X6bHisItSiiHyTb2cHv+1
         vscg==
X-Gm-Message-State: AOAM533sunm8rQYIQIMByM6QjBZ1/zV2vu137Muk3xAs+VAOhpKqYiVP
        ITn36fB1ks9s6CP5PXyCmjwHMw==
X-Google-Smtp-Source: ABdhPJzKS5OctiAZPFx3Qk+kjCmzI82WamC6hYGDP51dNtvT2E3Ogaz8sYsUpYWCXWko3lNaCQH5Og==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr6221723wmh.56.1598434465884;
        Wed, 26 Aug 2020 02:34:25 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: [PATCH 17/30] wireless: ath: ath9k: ar9002_initvals: Remove unused array 'ar9280PciePhy_clkreq_off_L1_9280'
Date:   Wed, 26 Aug 2020 10:33:48 +0100
Message-Id: <20200826093401.1458456-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9002_initvals.h:900:18: warning: ‘ar9280PciePhy_clkreq_off_L1_9280’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9002_initvals.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_initvals.h b/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
index 4d18c66a67903..e01b5c3728b86 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9002_initvals.h
@@ -897,20 +897,6 @@ static const u32 ar9280Modes_original_tx_gain_9280_2[][5] = {
 	{0x00007844, 0x92592480, 0x92592480, 0x92592480, 0x92592480},
 };
 
-static const u32 ar9280PciePhy_clkreq_off_L1_9280[][2] = {
-	/* Addr      allmodes  */
-	{0x00004040, 0x9248fd00},
-	{0x00004040, 0x24924924},
-	{0x00004040, 0xa8000019},
-	{0x00004040, 0x13160820},
-	{0x00004040, 0xe5980560},
-	{0x00004040, 0xc01dcffc},
-	{0x00004040, 0x1aaabe41},
-	{0x00004040, 0xbe105554},
-	{0x00004040, 0x00043007},
-	{0x00004044, 0x00000000},
-};
-
 static const u32 ar9280PciePhy_clkreq_always_on_L1_9280[][2] = {
 	/* Addr      allmodes  */
 	{0x00004040, 0x9248fd00},
-- 
2.25.1

