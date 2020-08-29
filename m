Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1231256484
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgH2DjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH2Di1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F975C061234
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h15so847869wrt.12
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWQ4Mgj5nJFptUvhPYJTMNqJmysjiQoavD7tKrDaEsk=;
        b=I2ght7KYE/B5nH2d5bhSaDOCKvd0k1yBR5ZhLE/yT9OApX7QSRPgs0E+vJjKJEvRQ1
         zRoM6Sah/TVJaU0BsCI02iIEipZ3Koj3JQdREkIirjjNY6B1mePBDQDwMhTjJOVmlq2h
         INg01W10mTrQolzhIy4Cd2MG8Z6Bc8lsxbYnX8h3JhzVMuaZJaN7jqfQB1TX5OzlVs96
         DnT6Rg1O6721xBAbeyh72wDZww9UwDK2nWOhAQwyNWXn2YXTuG4mZ1II/8e5Cvz32VCZ
         iKUNXLKSmyEdN7XEhHboVcwjG1PwBaAEHer6ksDhxQc6x0c+Dpb9UDtxEqrJn8AEjTDC
         oyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWQ4Mgj5nJFptUvhPYJTMNqJmysjiQoavD7tKrDaEsk=;
        b=a6Atq+zIQk7rr+qAJ7QVecMw2a+Ig3wxSlwpcq1Umzpj0cWqPmEieaiXjVNLOlrvGP
         d8a8l15eore5vBVdoZgsXI5VsSrjyV1tW47BWdeTNtUBPlIO9p2sQfhHmxy8NVoqIfLO
         vU8zz3JgHeAKhexw5BraynX9zo0MZ4KYr+qnFPBPQn1tNLeQRRY0JArqsccNpZlHevq4
         +7a4zCYwkV2sCeUGr3Ssts1uUehc42tJnfP6p4OO9XbqOwgMOFhOIj+3NLGRIKL4r9NH
         tZ2Xj3vGA13XkfWSZA76S/0ZCW5dQZ4M3LD80qjh/5kErWgpaUYJangSunV6hgrxOM1t
         JyCw==
X-Gm-Message-State: AOAM5321QmQW9KuUUiot+FX0+B0EnZIdW6Ejjv4DfqwULx8WlYs/mGvx
        n5FnT7nSsf2AcAlwk9DQLc+wmA==
X-Google-Smtp-Source: ABdhPJwPCnNoj+JQq6W3LPaPE8I+08sepY6ZOrs3FJzgnWfHFef+jvWjiyOPumjrjFKyxwx06V+ltA==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr1687315wrv.120.1598672304240;
        Fri, 28 Aug 2020 20:38:24 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 02/12] wcn36xx: Use V1 data structure to store supported rates
Date:   Sat, 29 Aug 2020 04:38:58 +0100
Message-Id: <20200829033908.2167689-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
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
index 4c30036e2e56..8534d36c3ae0 100644
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

