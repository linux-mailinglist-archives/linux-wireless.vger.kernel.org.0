Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F26261A86
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgIHSg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIHSck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42817C061795
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so318969wmi.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=L84IYj1+mGRVeUF5X+p6fcIEr9exM6/rlB2Liur8Tibm9ON92A+Oh4Pmmx4sPMNhIf
         PGPNl0P0f2cIhb1Fw36RKPFZ61WcMyMeM1j+AW0ga9zl/e57ilZ/Y4yNHDs9wthzN4F6
         /1DgtoNBwUHJ2ApEvJOlvYC5zeut5yRhuNIbnrJ4tRHU6mOoognuHxahBviwyfCtJkby
         fnIh2MqAj8jEwZMBm9VJzAKG9KtkLOKXnfWp2WDcGzwC4isDjxVLWP2eO8Ma2lENmMx0
         n9uCGvqOaieuP2yZls8PiEVL2ho+WfXw3tdxzqIHsY/NvBs1X4gqWbpPAjbdGajXvPk4
         RYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfNF9Nm72/GLHvVDln+H8GXexy5WDv58YkhHrtQxFnI=;
        b=kHQxNtPuR2Aib37CvjxdipyA41MNXqr8aLba8JN3GNQcQT5v+IRrfR7vyaulq3AfTV
         LSue6Yl4F4kR+sgrRW19JKUYtEc8ZigSTj1aPkQeL5uuC5SqwxaWz2O9f4+XuDnh2wDi
         dTl+7KsAo9wC5ILdukKidxR7KuP1WihNHT0vzXba+kLd9chRvRVHm2GU8kHc3nyqUQ6t
         zMYWgnvgHrltzpyWtZ/IswooN3ZqwpWB+okP2KEbHGNt7VyVcgC5W16wRHxGRyROZa6J
         +2HPds0coesfT9a0lPGIxARV45DiAe2XnSuYACdylssTwm7nynzCVhyQZmJYRj3/m9GD
         ReNQ==
X-Gm-Message-State: AOAM532SqbgOiQkIlKmBaEQcoWhASj85s7KEoU6nRnamrkmwOld5pHSx
        Nj53q+1RTjFBywsliBcuAfgrRw==
X-Google-Smtp-Source: ABdhPJzRJnJ0FgJ1dB0JxSiPYY5CGLpxFlVYMWVwIIzf9CpNMIA+n2CqsROY6WmkD7of0JjXp/i1Jw==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr365746wmk.93.1599589422587;
        Tue, 08 Sep 2020 11:23:42 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id g186sm286202wmg.25.2020.09.08.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:42 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/2] wcn36xx: Use V1 data structure to store supported rates
Date:   Tue,  8 Sep 2020 19:24:28 +0100
Message-Id: <20200908182428.2870226-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182428.2870226-1-bryan.odonoghue@linaro.org>
References: <20200908182428.2870226-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch converts the internal data structure used to store data-rates
from version 0 to version 1.

This allows us to extend out the internal storage to represent VHT
parameters.

Using the extended version 1 data-structure allows us to avoid a whole raft
of version 1 specific fixup functions.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c     | 5 +++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 55aaaeb78b14..d5ca9907af86 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -242,9 +242,10 @@ static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		sta_params->aid = sta_priv->aid;
 		wcn36xx_smd_set_sta_ht_params(sta, sta_params);
 		memcpy(&sta_params->supported_rates, &sta_priv->supported_rates,
-			sizeof(sta_priv->supported_rates));
+			sizeof(struct wcn36xx_hal_supported_rates));
 	} else {
-		wcn36xx_set_default_rates(&sta_params->supported_rates);
+		wcn36xx_set_default_rates((struct wcn36xx_hal_supported_rates *)
+					  &sta_params->supported_rates);
 		wcn36xx_smd_set_sta_default_ht_params(sta_params);
 	}
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 342ca0ae7e28..d7d349de20e6 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -169,7 +169,7 @@ struct wcn36xx_sta {
 	u8 bss_dpu_desc_index;
 	bool is_data_encrypted;
 	/* Rates */
-	struct wcn36xx_hal_supported_rates supported_rates;
+	struct wcn36xx_hal_supported_rates_v1 supported_rates;
 
 	spinlock_t ampdu_lock;		/* protects next two fields */
 	enum wcn36xx_ampdu_state ampdu_state[16];
-- 
2.27.0

